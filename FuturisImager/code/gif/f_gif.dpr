library f_gif;

uses
  SysUtils,
  Classes,
  Windows,
  Graphics,
  gifimage,
  c_const,
  gifexp in 'gifexp.pas' {frmGIFExport};

{$R *.RES}

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
func(PT_FOPEN,'gif',' ');
func(PT_FSAVE,'gif',' ');
if (Win32Platform = VER_PLATFORM_WIN32_NT) then
  func(PT_FEXPORT,'GIF Export',' ');
func(PT_FDESCR,'gif','CompuServe GIF (*.gif)');
Result:=true;
end;

function FIPISopen(path,ext: PChar; app: THandle):hBitmap; stdcall;
var
  bmp: TBitmap;
  gif: TGifImage;
begin
gif:=TGifImage.Create();
bmp:=TBitmap.Create();
try
  gif.LoadFromFile(String(path));
  bmp.Height:=gif.Height;
  bmp.Width:=gif.Width;
  bmp.Canvas.Draw(0,0,gif);
  Result:=bmp.ReleaseHandle();
  except
  on EInvalidGraphic do
    Result:=0;
  end;
bmp.Free();
gif.Free();
end;

function FIPISsave(path, ext: PChar; app, wnd: THandle; img: hBitmap):integer; stdcall;
var
  bmp: TBitmap;
  gif: TGifImage;
begin
gif:=TGifImage.Create();
bmp:=TBitmap.Create();
Result:=1;
try
  bmp.Handle:=img;
  gif.Assign(bmp);
  gif.Optimize([],rmQuantizeWindows,dmFloydSteinberg,2);
  gif.SaveToFile(String(path));
  except
  Result:=0;
  end;
bmp.Free();
gif.Free();
end;

exports
  FIPISquery, FIPISopen, FIPISsave, FIPISexport;

begin
end.
 