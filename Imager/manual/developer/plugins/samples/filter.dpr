library filter;

uses
  SysUtils, Windows, Classes, Graphics,
  c_const;

{$R *.res}


function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
	func(PT_FFILTER, 'Sample Filter', ' ');

	Result := true;
end;

function FFilter(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;
var
	bmp: TBitmap;
begin
    {
    	this function recieves current image (always as 24-bit DIB)
        and should return transformed 24-bit image or 0 in case of failure

        there is a boolean parameter "preview":
        if it is "true", then you should not display any GUI, perform transformation as
        fast as possible (maybe with lower quality results) - this will be used for preview
        in "Filters" dialog (if you return 0 and "preview" is "false" - then Imager will
        display string that no preview is available)
		if "preview" is "false" - filter should work as usual
    }

	// getting current image
	bmp := TBitmap.Create();
	bmp.Handle := img;

	// do something with image here
    {
    	if preview then (*...*)
        	else (*...*);
    }

	// sending result
	Result := bmp.ReleaseHandle();

    // cleaning bitmap object
	FreeAndNil(bmp);
end;

exports
	FQuery, FFilter;

begin
end.
 