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

function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
	func(PT_FSAVE, 'gif', 'CompuServe GIF (*.gif)');
	if (Win32Platform = VER_PLATFORM_WIN32_NT) then
  		func(PT_FEXPORT, 'Advanced GIF Export...', ' ');

	Result := true;
end;

function FSave(path, ext: PChar; app, wnd: THandle; img: hBitmap):integer; stdcall;
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
  FQuery, FSave, FExport;

begin
end.
 