library f_wbitmap;

uses
  SysUtils, Windows, Classes, Graphics,
  c_const, bmp2wbmp;

{$R *.RES}

function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
	func(PT_FOPEN, 'wbmp', 'Wireless Bitmap (*.wbmp)');
	func(PT_FOPEN, 'wbm', 'Wireless Bitmap (*.wbm)');
	func(PT_FSAVE, 'wbmp', ' ');

	Result := true;
end;

function FOpen(path,ext: PChar; app: THandle):hBitmap; stdcall;
var
  bmp: TBitmap;
begin
// WAP bitmap
bmp:=TBitmap.Create();
try
  try
  LoadFromWBmpFile(bmp,String(path));
  Result:=bmp.Handle;
  except
    Result:=0;
  end;
finally
  bmp.ReleaseHandle();
  bmp.Free();
end;
end;

function FSave(path,ext: PChar; app, wnd: THandle; img: hBitmap):integer; stdcall;
var
  bmp: TBitmap;
begin
bmp:=TBitmap.Create();
Result:=1;
try
  bmp.Handle:=img;
  SaveAsWBmpFile(bmp,String(path));
  except
    Result:=0;
  end;
bmp.Free();
end;

exports
  FQuery, FOpen, FSave;

begin
end.
