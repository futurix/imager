library export;

uses
  SysUtils, Classes, Windows, Graphics, Forms,
  c_const;

{$R *.RES}


function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
	func(PT_FEXPORT, 'Sample Export...', ' ');

	Result := true;
end;

function FExport(info: PChar; app, wnd: THandle; img: hBitmap):integer; stdcall;
var
	bmp: TBitmap;
begin
	{
    	this function recieves current image in "img", and can do anything with it

        GUI permitted (use wnd as parent window handle)
    }

   	// the following line required if you want to use Delphi's Application object correctly
	Application.Handle := app;

    // setting bitmap object
    bmp := TBitmap.Create();
	bmp.Handle := img;

    // here you can work with bitmap
    // save it, print it, whatever
    //bmp.SaveToFile('C:\1.bmp');

	// sample code to show Delphi form
    {
	frmSample := TfrmSample.Create(Application);
	frmSample.ShowModal();
    FreeAndNil(frmSample);
    }

	// cleaning up
    FreeAndNil(bmp);

    // result currently is not checked
	Result := 1;
end;

exports
	FQuery, FExport;

begin
end.
 