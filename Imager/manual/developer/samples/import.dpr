library import;

uses
  SysUtils, Classes, Windows, Graphics,
  c_const;

{$R *.RES}


function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
	func(PT_FIMPORT, 'Sample Import...', ' ');

	Result := true;
end;

function FIPISimport(info: PChar; app, wnd: THandle):hBitmap; stdcall;
var
	bmp: TBitmap;
begin
	{
    	this function should get some image somehow and return it (or return 0)

        GUI permitted (use wnd as parent window handle)
    }

	bmp := TBitmap.Create();
	
    //do something with "bmp"
    //bmp.LoadFromFile('C:\1.bmp');

    // return handle if success, or 0 - otherwise
	//Result := bmp.ReleaseHandle();
    Result := 0;

    // clean up
	FreeAndNil(bmp);
end;

exports
	FIPISquery, FIPISimport;

begin
end.
