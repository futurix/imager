library tool;

uses
  Windows, SysUtils, Graphics, Classes,
  c_const;

{$R *.RES}


function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
	func(PT_FTOOL, 'Sample Tool...', ' ');

	Result := true;
end;

function FIPIStool(info, path: PChar; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;
begin
	{
    	this is a generic tool function

        it can show GUI (using "wnd" as parent window handle)

        it recieves current file path in "path" (it can be empty if current file is not saved)
        and current image's HBITMAP in "img"

        return some HBITMAP if you want it to be opened as unsaved bitmap
        or
        return 0 if you don't want Imager to react somehow on your tool launch
    }

	Result := 0;
end;

exports
	FIPISquery, FIPIStool;

begin
end.
 