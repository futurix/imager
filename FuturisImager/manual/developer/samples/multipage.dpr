library multipage;

uses
  SysUtils, Windows, Classes, Graphics,
  c_const;

{$R *.RES}


function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
	func(PT_FOPENMULTI, 'bmp', ' ');
	func(PT_FDESCR, 'bmp', 'Sample Multi-page Bitmap (*.bmp)');

	Result := true;
end;

function FIPISmultiInit(filename, ext: PChar; app: THandle):integer; stdcall;
begin
    {
    	this function called on file open

        initialize globals here
        note, that in any case FIPISmultiGetPages will be called after FIPISmultiInit
    }

    // if the file is multi-page return page count, otherwise 0
	Result := 0;
end;

function FIPISmultiGetPages():integer; stdcall;
begin
    {
    	this function should return page count or 0 (if file is not multi-page)

        note: if current file is NOT multi-page then free global resources here,
        because FIPISmultiDeInit will not be called in this case
    }
    
	Result := 0;
end;

function FIPISmultiGetPage(index: integer):hBitmap; stdcall;
begin
    {
    	this function should return HBITMAP of requested page or 0 - otherwise
        (if it is 0, then file will be closed)
    }

	Result := 0;
end;

function FIPISmultiDeInit():integer; stdcall;
begin
	{
        this function will be called on multi-page file close

		clean global resource here
	}

	Result := 1;
end;

exports
	FIPISquery, FIPISmultiInit, FIPISmultiGetPages, FIPISmultiGetPage, FIPISmultiDeInit;

begin
end.
