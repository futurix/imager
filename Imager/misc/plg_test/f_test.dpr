library f_test;

uses
  Windows, SysUtils, Classes, Graphics, c_const;

{$R *.res}


function FIPISquery(plug_path: PChar; func : TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
	func(PT_FFILTER, 'my test filter', ' ');
	Result := true;
end;

function FIPISfilter(info: PChar; preview: boolean; app, wnd: THandle; img: HBITMAP):HBITMAP; stdcall;
var
	bmp: TBitmap;
begin
	bmp := TBitmap.Create();
	bmp.Handle := img;
    bmp.PixelFormat := pf24bit;
    
	// my "code" here:
	bmp.Canvas.Ellipse(0, 0, 200, 200);
 	// end of my "code"

 	Result := bmp.ReleaseHandle();
 	FreeAndNil(bmp);
end;

exports
	FIPISquery, FIPISfilter;

begin
end.

