library animated;

uses
  SysUtils, Windows, Classes, Graphics,
  c_const;

{$R *.res}


function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
	func(PT_FOPENANIM, 'bmp', 'Sample Animated Bitmap (*.bmp)');

	Result := true;
end;

function FAnimStart(filename, ext: PChar; app: THandle):integer; stdcall;
begin
    {
    	this function is called on file open

        initialize globals here and return 1 if the image is really animated
    }

	Result := 1;
end;

function FAnimRestart():integer; stdcall;
begin
    {
    	this function called when user requested animation restart

        do something with it ;-)
    }

	Result := 1;
end;

function FAnimGetFrame(var img: hBitmap; var delay: integer):integer; stdcall;
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

function FAnimStop():integer; stdcall;
begin
	{
        this function will be called on animation file close

		clean global resources here
	}

	Result := 1;
end;

exports
	FQuery, FAnimStart, FAnimRestart, FAnimGetFrame, FAnimStop;

begin
end.
 