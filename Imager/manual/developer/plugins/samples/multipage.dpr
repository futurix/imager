library multipage;

uses
  SysUtils, Windows, Classes, Graphics,
  c_const;

{$R *.RES}


function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
	func(PT_FOPENMULTI, 'bmp', 'Sample Multi-page Bitmap (*.bmp)');

	Result := true;
end;

function FMultiStart(filename, ext: PChar; app: THandle):integer; stdcall;
begin
    {
    	this function called on file open

        initialize globals here and return number of pages
    }

    // if the file is multi-page return page count, otherwise 0
	Result := 0;
end;

function FMultiGetPage(index: integer):hBitmap; stdcall;
begin
    {
    	this function should return HBITMAP of requested page or 0 - otherwise
        (if it is 0, then file will be closed)
    }

	Result := 0;
end;

function FMultiStop():integer; stdcall;
begin
	{
        this function will be called on multi-page file close

		clean global resources here
	}

	Result := 1;
end;

exports
	FQuery, FMultiStart, FMultiGetPage, FMultiStop;

begin
end.
