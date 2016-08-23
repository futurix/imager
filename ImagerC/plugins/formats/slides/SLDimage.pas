unit SLDimage;

{$WARNINGS OFF}
{$HINTS OFF}

interface

uses
  Windows, Graphics, Classes, dialogs;


type
  { Here it is! }
  Tslide = class(TGraphic)
  private
  protected
    {header of slide file}
    Header : packed record
     ID_String : array[0..12] of char;
     ID_Bytes : array[0..3] of byte;
     Type_Indicator,
     Level_Indicator : byte;
     Width,
     Height : Word;
     Aspect_Ratio : array[0..3] of byte;
     Hardware_Fill,
     Test_Number : Word;
    end;
    FDrawList: TList;
    FEmpty: Boolean;
    FHeight: Integer;
    FMaxExtent: TPoint;
    FMinExtent: TPoint;
    FScaleFactor: Single;
    FWidth: Integer;
    procedure ClearLists;
    procedure Draw(ACanvas: TCanvas; const ARect: TRect); override;
    function GetEmpty: Boolean; override;
    function GetHeight: Integer; override;
    function GetWidth: Integer; override;
    procedure Scale;
    procedure SetHeight(Value: Integer); override;
    procedure SetScaleFactor(Value: Single);
    procedure SetWidth(Value: Integer); override;
	public
    constructor Create; override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle;
      APalette: HPALETTE); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle;
      var APalette: HPALETTE); override;
    procedure SaveToStream(Stream: TStream); override;
    property MaxExtent: TPoint read FMaxExtent write FMaxExtent;
    property MinExtent: TPoint read FMinExtent write FMinExtent;
    property ScaleFactor: Single read FScaleFactor write SetScaleFactor;
  end;

implementation

uses
  SysUtils;

type
  TslideEntityKind = (kVector, kOffsetVector,kEOF,
                      kSolidFill,kEndpointVector,kNewColor);

  { Tslide Entity storage to internal use }
  TslideEntity = packed record
   case Kind: TslideEntityKind of
      kVector         :  (vFx,vFy,vTx,vTy: SmallInt);
      kOffsetVector   :  (ovFx,ovMarker,ovFy,ovTx,ovTy:ShortInt);
      kEOF            :  (eofMarker:Word);
      kSolidFill      :  (sfMarker,sfx,sfy:SmallInt);
      kEndpointVector :  (evTx,evMarker,evTy:ShortInt);
      kNewColor       :  (ncColor,ncMarker:Byte);
  end;
  { pointer types for the above }
  PslideEntity = ^TslideEntity;

function AcadToRgb(i:Byte) : TColor;
{AcadToRgb is only an approximation, but should be good enough}
var
 j,k:Byte;
 r,g,b:Byte;
 z,e:Byte;
 l,m:Byte;
 c:TColor;
 t:Word;
const
 s:array[1..9,1..3] of byte=((255,0,0),(255,255,0),(0,255,0),
     (0,255,255),(0,0,255),(255,0,255),
     (0,0,0),(132,132,132),(186,186,186));
 gr:array[250..255,1..3] of byte=((0,0,0),(41,41,41),(90,90,90),
     (132,132,132),(188,188,188),(173,173,173));{last three not needed}
begin
 if (i>9) and (i<250) then begin
  z:=i div 10;
  e:=i-10*z;
  j:=((z-1) div 4)+1;
  k:=j+1; if k=7 then k:=1;
  l:=z mod 4; if l=0 then l:=4;
  m:=l-1; l:=5-l;
  {straight forward, no problem here}
  r:=(m*s[k,1]+l*s[j,1]) div 4;
  g:=(m*s[k,2]+l*s[j,2]) div 4;
  b:=(m*s[k,3]+l*s[j,3]) div 4;
  if (e mod 2) = 1 then begin
   t:=(r div 2) + 129; if t>255 then r:=255 else r:=t;
   t:=(g div 2) + 129; if t>255 then g:=255 else g:=t;
   t:=(b div 2) + 129; if t>255 then b:=255 else b:=t;
  end;
  for j:=1 to (e div 2) do begin
  {some colours get slightly brighter, which is better than
   slightly darker (as 3/5 instead of 7/10)}
   r:=7*r div 10;
   g:=7*g div 10;
   b:=7*b div 10;
  end;
 end;
 if i<10 then begin
   r:=s[i,1];
   g:=s[i,2];
   b:=s[i,3];
 end;
 if i>249 then begin
   r:=gr[i,1];
   g:=gr[i,2];
   b:=gr[i,3];
 end;
 c:=((b shl 8) + g) shl 8 + r;
 Result:=c;
end;


{ Tslide }

constructor Tslide.Create;
begin
  inherited Create;
  FDrawList := TList.Create;
  FEmpty := True;
  FScaleFactor := 1;
end;

destructor Tslide.Destroy;
begin
  ClearLists;
  FDrawList.Free;
  inherited Destroy;
end;

procedure Tslide.Assign(Source: TPersistent);
var
  SLD: Tslide;
  NewEntity: PslideEntity;
  i: Integer;
begin
	if Source is Tslide then
  	SLD := Tslide(Source)
  else
  	raise Exception.Create('Tslide.Assign can only assign from other Tslide''s');
  ClearLists;
  if SLD.Empty then Exit;
  for i := 0 to SLD.FDrawList.Count - 1 do begin
    New(NewEntity);
    NewEntity^ := PslideEntity(SLD.FDrawList[i])^;
    FDrawList.Add(NewEntity);
  end;
  FMaxExtent := SLD.FMaxExtent;
  FMinExtent := SLD.FMinExtent;
  FScaleFactor := SLD.FScaleFactor;

  FEmpty := False;
  Scale; { calculate height and width, kept for compatibility with TGraphic }
  Changed(Self);
end;

{ the method used to clear/empty a drawing }
procedure Tslide.ClearLists;
var
  i: Integer;
begin
  for i := 0 to FDrawList.Count - 1 do
    Dispose(PslideEntity(FDrawList[i]));
  FDrawList.Clear;
  FEmpty := True;
end;

procedure DrawVector(mx,my:Single;b,fx,fy,tx,ty:Word;
                     ACanvas: TCanvas);
var
  ix, iy: Integer;
begin
  ACanvas.Brush.Style := bsClear;
  ACanvas.Pen.Style :=psSolid;
  ACanvas.MoveTo(Round(FX * mx),b - Round(FY * my));
  ix := Round(TX * mx);
  iy := b - Round(TY * my);
  ACanvas.LineTo(ix, iy);
  ACanvas.Pixels[ix, iy] := ACanvas.Pen.Color;
end;

{ used by TCanvas.Draw for drawing }
procedure Tslide.Draw(ACanvas: TCanvas; const ARect: TRect);
var
  mx, my: Single;
  b,i: Integer;
  lp1,lp2,pc:Word;
  {so there is a limited number of vertices for solid fill...}
  PointList: Array[1..1000] of TPoint;
begin
  if Empty then Exit;
  pc:=9999;
  b:=ARect.Bottom - ARect.Top;
  mx := (ARect.Right - ARect.Left) / FMaxExtent.x;
  my := b / FMaxExtent.y;
  for i:=0 to FDrawList.Count-1 do with TslideEntity(FDrawList[i]^) do
    case Kind of
     kVector:
      begin
       DrawVector(mx,my,b,vfx,vfy,vtx,vty,ACanvas);
       lp1:=vFx;lp2:=vFy;
      end;
     kNewColor:
      begin
       ACanvas.Pen.Color   := AcadToRgb(ncColor);
       ACanvas.Brush.Color := AcadToRgb(ncColor);
      end;
     kOffsetVector:
      begin
       DrawVector(mx,my,b,lp1+ovfx,lp2+ovfy,lp1+ovtx,lp2+ovty,ACanvas);
       lp1 := lp1+ovfx;
       lp2 := lp2+ovfy;
      end;
     kEndpointVector:
      begin
       DrawVector(mx,my,b,lp1,lp2,lp1+evtx,lp2+evty,ACanvas);
       lp1 := lp1+evtx;
       lp2 := lp2+evty;
      end;
     kSolidFill:
      begin
       if pc=9999 {very first group of data, no vertex yet}
        then pc:=0
        else begin
         if sfY>=0 then begin {add to vertices}
          inc(pc);
          PointList[pc].x:=Round(sfx*mx);
          PointList[pc].y:=b-Round(sfy*my);
         end {end of add vertex}
         else begin {end of data, draw now}
          ACanvas.Brush.Style := bsSolid;
          ACanvas.Polygon(Slice(PointList,pc));
          pc:=9999;
         end;{end of draw}
        end;{end of pc=9999}
      end;{Solid Fill}
    end; {case}
end;

function Tslide.GetEmpty: Boolean;
begin
  Result := FEmpty;
end;

function Tslide.GetHeight: Integer;
begin
  Result := FHeight;
end;

function Tslide.GetWidth: Integer;
begin
  Result := FWidth;
end;

procedure Tslide.LoadFromClipboardFormat(AFormat: Word; AData: THandle;
      APalette: HPALETTE);
begin
  raise Exception.Create('Tslide does not support loading from clipboard format');
end;

{ This is where the SLD is loaded }
procedure Tslide.LoadFromStream(Stream: TStream);
var
  CurEntity: PslideEntity;
  b:byte;
begin
  { move to beginning of stream }
  Stream.Seek(0, 0);
  try
    { initialize variables to default values }
    b:=SizeOf(Header);
    Stream.Read(Header,b);
    if (header.ID_String = 'AutoCAD Slide') and (header.ID_Bytes[0]=$0D)
        and (header.ID_Bytes[1]=$0A)  and (header.ID_Bytes[2]=$1A)
        and (header.ID_Bytes[3]=$00) then
        begin end
    else raise Exception.Create('Invalid slide file');
    if Header.Level_Indicator=1 {old slide format}
     then raise Exception.Create('unsupported level 1 slide');
    if Header.Test_Number<>$1234
     then raise Exception.Create('SLD file not from an Intel-based machine');
    FMinExtent := Point(0, 0);
    FMaxExtent := Point(Header.Width+1,Header.Height+1);
    { clear lists of drawing objects }
    ClearLists;

    { parse SLD file until end of file }
    while Stream.Position<Stream.Size do begin
     New(CurEntity);
     Stream.Read(b,1);
     Stream.Read(b,1);
     Stream.Seek(-2, soFromCurrent);
     case b of
      $FC: begin {end of file}
            CurEntity^.Kind := kEOF;
            Stream.Read(CurEntity^.eofMarker,2);
            Stream.Seek(0, soFromEnd);
           end;
      $FF: begin {new colour}
            CurEntity^.Kind := kNewColor;
            Stream.Read(CurEntity^.ncColor,1);
            Stream.Read(CurEntity^.ncMarker,1);
           end;
      $00..$7F: begin {vector}
            CurEntity^.Kind := kVector;
            Stream.Read(CurEntity^.vFx,2);
            Stream.Read(CurEntity^.vFy,2);
            Stream.Read(CurEntity^.vTx,2);
            Stream.Read(CurEntity^.vTy,2);
           end;
      $FB: begin {offset vector}
            CurEntity^.Kind := kOffsetVector;
            Stream.Read(CurEntity^.ovFx,1);
            Stream.Read(CurEntity^.ovMarker,1);
            Stream.Read(CurEntity^.ovFy,1);
            Stream.Read(CurEntity^.ovTx,1);
            Stream.Read(CurEntity^.ovTy,1);
           end;
      $FE: begin {common endpoint vector}
            CurEntity^.Kind := kEndpointVector;
            Stream.Read(CurEntity^.evTx,1);
            Stream.Read(CurEntity^.evMarker,1);
            Stream.Read(CurEntity^.evTy,1);
           end;
      $FD: begin {solid fill}
            CurEntity^.Kind := kSolidFill;
            Stream.Read(CurEntity^.sfMarker,2);
            Stream.Read(CurEntity^.sfx,2);
            Stream.Read(CurEntity^.sfy,2);
           end;
     end;
     FDrawList.Add(CurEntity);
    end;
    FEmpty := False;
    { calculate height and width, kept for compatibility with TGraphic }
    Scale;
    Changed(Self);
  finally
  end;
end;

procedure Tslide.SaveToClipboardFormat(var AFormat: Word; var AData: THandle;
		var APalette: HPALETTE);
begin
  raise Exception.Create('Tslide does not yet support saving to clipboard format');
end;

procedure Tslide.SaveToStream(Stream: TStream);
var
 i : Word;
begin
  {here is is}
  if Empty then Exit;
  Stream.Seek(0, 0);
  Stream.Write(Header,SizeOf(Header));
  for i:=0 to FDrawList.Count-1 do with TslideEntity(FDrawList[i]^) do
     case kind of
      kEOF: begin {end of file}
            Stream.Write(eofMarker,2);
           end;
      kNewColor: begin {new colour}
            Stream.Write(ncColor,1);
            Stream.Write(ncMarker,1);
           end;
      kVector: begin {vector}
            Stream.Write(vFx,2);
            Stream.Write(vFy,2);
            Stream.Write(vTx,2);
            Stream.Write(vTy,2);
           end;
      kOffsetVector: begin {offset vector}
            Stream.Write(ovFx,1);
            Stream.Write(ovMarker,1);
            Stream.Write(ovFy,1);
            Stream.Write(ovTx,1);
            Stream.Write(ovTy,1);
           end;
      kEndpointVector: begin {common endpoint vector}
            Stream.Write(evTx,1);
            Stream.Write(evMarker,1);
            Stream.Write(evTy,1);
           end;
      kSolidFill: begin {solid fill}
            Stream.Write(sfMarker,2);
            Stream.Write(sfx,2);
            Stream.Write(sfy,2);
           end;
     end; {case}
  Stream.Size := Stream.Position;
end;

{ calculate height & width based on ScaleFactor }

procedure Tslide.Scale;
var
  w, h: Longint;
begin
  h := Round(Abs(FScaleFactor * (FMaxExtent.y - FMinExtent.y)));
  w := Round(Abs(FScaleFactor * (FMaxExtent.x - FMinExtent.x)));
  if h > 32767 then
    FHeight := 32767
  else
    FHeight := h;
  if w > 32767 then
    FWidth := 32767
  else
    FWidth := w;
end;

{ Set the height = set the ScaleFactor }

procedure Tslide.SetHeight(Value: Integer);
begin
  FScaleFactor := Value / Abs(FMaxExtent.y - FMinExtent.y);
  Scale;
  Changed(Self);
end;

{ Set the ScaleFactor and recalc. the height & width }

procedure Tslide.SetScaleFactor(Value: Single);
begin
  FScaleFactor := Value;
  Scale;
  Changed(Self);
end;

{ Set the width = set the ScaleFactor }

procedure Tslide.SetWidth(Value: Integer);
begin
  FScaleFactor := Value / Abs(FMaxExtent.x - FMinExtent.x);
  Scale;
  Changed(Self);
end;
{
initialization
  TPicture.RegisterFileFormat('sld', 'AutoCAD Slides', Tslide);  }

{$WARNINGS ON}
{$HINTS ON}
end.

