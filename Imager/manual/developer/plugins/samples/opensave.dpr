library opensave;

uses
  SysUtils, Windows, Classes, Graphics,
  c_const;

{$R *.RES}


function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
	func(PT_FOPEN,'bmp', 'Sample Bitmap (*.bmp)');
	func(PT_FSAVE,'bmp', ' ');

	Result := true;
end;

function FOpen(path, ext: PChar; app: THandle):hBitmap; stdcall;
var
	bmp: TBitmap;
begin
    {
    	this function should open file "path", convert it and return HBITMAP
        or 0 in case of failure to open

        no GUI or error messages permitted!!!
    }

	// simple bitmap loading using TBitmap
	bmp := TBitmap.Create();
	bmp.LoadFromFile(String(path));
	Result := bmp.ReleaseHandle();
	FreeAndNil(bmp);
end;

function FSave(path, ext: PChar; app, wnd: THandle; img: hBitmap):integer; stdcall;
var
	bmp: TBitmap;
begin
    {
    	this function should recieve current image's HBITMAP and save it to "path"

        simple GUI permitted
    }

	// simple bitmap saving using TBitmap
	bmp := TBitmap.Create();
	bmp.Handle := img;
	bmp.SaveToFile(String(path));
	FreeAndNil(bmp);

	Result := 1;
end;

exports
	FQuery, FOpen, FSave;

begin
end.
