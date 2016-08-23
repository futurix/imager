library animated;

uses
  SysUtils, Windows, Classes, Graphics,
  c_const;

{$R *.res}


function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
	func(PT_FOPENANIM, 'bmp', ' ');
	func(PT_FDESCR, 'bmp', 'Sample Animated Bitmap (*.bmp)');

	Result := true;
end;

function FIPISanimInit(filename, ext: PChar; app: THandle):integer; stdcall;
begin
    {
    	this function called on file open

        initialize globals here
        note, that in any case FIPISanimConfirm will be called after FIPISanimInit
    }

	Result := 1;
end;

function FIPISanimRestart():integer; stdcall;
begin
    {
    	this function called when user requested animation restart

        do something with it ;-)
    }

	Result := 1;
end;

function FIPISanimConfirm():integer; stdcall;
begin
	{
    	this function should return 1 if current file is animated or 0 - otherwise

        note: if current file is NOT animated then free global resources here,
        because FIPISanimDeInit will not be called in this case
    }

	Result := 0
end;

function FIPISanimGetFrame(var img: hBitmap; var delay: integer):integer; stdcall;
begin
	{
    	this function should return HBITMAP in "img" and display duration in "delay"

        result should be 1 if everything OK, or 0 - otherwise
        (if it is 0, then animation will be closed)
    }

	img := 0;
	delay := 0;
	Result := 0;
end;

function FIPISanimDeInit():integer; stdcall;
begin
	{
        this function will be called on animation file close

		clean global resource here
	}

	Result := 1;
end;

exports
	FIPISquery, FIPISanimInit, FIPISanimConfirm, FIPISanimRestart, FIPISanimGetFrame, FIPISanimDeInit;

begin
end.
 