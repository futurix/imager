library f_grayscale;

uses
  SysUtils, Windows, Classes, Graphics, c_const;

var
  gbmp: TBitmap;

{$R *.RES}

procedure GrayScale(var clip: tbitmap);
var
  p0: PByteArray;
  Gray,x,y: Integer;
begin
  for y:=0 to clip.Height-1 do
  begin
    p0:=clip.scanline[y];
    for x:=0 to clip.Width-1 do
    begin
      Gray:=Round(p0[x*3]*0.3+p0[x*3+1]*0.59+p0[x*3+2]*0.11);
      p0[x*3]:=Gray;
      p0[x*3+1]:=Gray;
      p0[x*3+2]:=Gray;
    end;
  end;
end;

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
func(PT_FFILTER,'Grayscale',' ');
Result:=true;
end;

function FIPISfilter(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;
var
  bmp: TBitmap;
begin
// tuning internals
bmp:=TBitmap.Create();
bmp.Handle:=img;
gbmp:=TBitmap.Create();
gbmp.Assign(bmp);

// modifying
GrayScale(gbmp);

// sending result
bmp.Assign(gbmp);
gbmp.Free();
Result:=bmp.ReleaseHandle();
bmp.Free();
end;

exports
  FIPISquery, FIPISfilter;

begin
end.
 