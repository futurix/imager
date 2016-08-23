library f_gdiplus;

uses
  SysUtils, Windows, Classes, Graphics,
  c_const,
  GDIPAPI, GDIPOBJ;

var
  gimg: TGPBitmap;
  gframe: cardinal = 0;

{$R *.res}

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
func(PT_FOPEN,'gif',' ');
func(PT_FOPENANIM,'gif',' ');
func(PT_FDESCR,'gif','CompuServe GIF (*.gif)');
Result:=true;
end;

function FIPISopen(path,ext: PChar; app: THandle):hBitmap; stdcall;
var
  bmp: TBitmap;
  img: TGPBitmap;
  tmp: HBITMAP;
begin
// initializing GDI+
StartupInput.DebugEventCallback := nil;
StartupInput.SuppressBackgroundThread := False;
StartupInput.SuppressExternalCodecs   := False;
StartupInput.GdiplusVersion := 1;
GdiplusStartup(gdiplusToken, @StartupInput, nil);

// working
img:=TGPBitmap.Create(WideString(path));
bmp:=TBitmap.Create();

if img.GetHBITMAP(aclWhite, tmp)=OK then
  begin
  bmp.Handle:=tmp;
  Result:=bmp.ReleaseHandle();
  end
else
  Result:=0;

FreeAndNil(bmp);
FreeAndNil(img);

// stopping GDI+
if assigned(GenericSansSerifFontFamily) then GenericSansSerifFontFamily.Free;
if assigned(GenericSerifFontFamily) then GenericSerifFontFamily.Free;
if assigned(GenericMonospaceFontFamily) then GenericMonospaceFontFamily.Free;
if assigned(GenericTypographicStringFormatBuffer) then GenericTypographicStringFormatBuffer.free;
if assigned(GenericDefaultStringFormatBuffer) then GenericDefaultStringFormatBuffer.Free;
GdiplusShutdown(gdiplusToken);
end;

function FIPISanimInit(filename, ext: PChar; app: THandle):integer; stdcall;
begin
Result:=1;

// initializing GDI+
StartupInput.DebugEventCallback := nil;
StartupInput.SuppressBackgroundThread := False;
StartupInput.SuppressExternalCodecs   := False;
StartupInput.GdiplusVersion := 1;
GdiplusStartup(gdiplusToken, @StartupInput, nil);

// working
gimg:=TGPBitmap.Create(WideString(filename));
end;

function FIPISanimRestart():integer; stdcall;
begin
gframe:=gimg.GetFrameCount(FrameDimensionTime)-1;
Result:=1;
end;

function FIPISanimConfirm():integer; stdcall;
begin
if gimg.GetFrameCount(FrameDimensionTime)<=1 then
  Result:=0
else
  Result:=1;
end;

function FIPISanimGetFrame(var img: hBitmap; var delay: integer):integer; stdcall;
var
  bmp: TBitmap;
  tmp: HBITMAP;
  isize: integer;
  iitem: PPropertyItem;
type
  ac = array of Longword;
begin
Inc(gframe);
if (gframe=gimg.GetFrameCount(FrameDimensionTime)) then
  gframe:=0;

gimg.SelectActiveFrame(FrameDimensionTime,gframe);

bmp:=TBitmap.Create();

if gimg.GetHBITMAP(aclWhite,tmp)=OK then
  begin
  bmp.Handle:=tmp;
  img:=bmp.ReleaseHandle();

  isize:=gimg.GetPropertyItemSize(PropertyTagFrameDelay);
  GetMem(iitem,isize);
  gimg.GetPropertyItem(PropertyTagFrameDelay,isize,iitem);
  delay:=(ac(iitem.value)[gframe])*10;
  FreeMem(iitem,isize);
  Result:=1;
  end
else
  begin
  img:=0;
  delay:=0;
  Result:=0;
  end;  
FreeAndNil(bmp);
end;

function FIPISanimDeInit():integer; stdcall;
begin
Result:=1;
FreeAndNil(gimg);

// stopping GDI+
if assigned(GenericSansSerifFontFamily) then GenericSansSerifFontFamily.Free;
if assigned(GenericSerifFontFamily) then GenericSerifFontFamily.Free;
if assigned(GenericMonospaceFontFamily) then GenericMonospaceFontFamily.Free;
if assigned(GenericTypographicStringFormatBuffer) then GenericTypographicStringFormatBuffer.free;
if assigned(GenericDefaultStringFormatBuffer) then GenericDefaultStringFormatBuffer.Free;
GdiplusShutdown(gdiplusToken);
end;

exports
  FIPISquery, FIPISopen,
  FIPISanimInit, FIPISanimConfirm, FIPISanimRestart, FIPISanimGetFrame, FIPISanimDeInit;

begin
end.
 