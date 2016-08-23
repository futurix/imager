unit c_helper;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics;

type
  TColorReduction =
    (rmNone, rmWindows20, rmWindows256, rmWindowsGray, rmMonochrome, rmGrayScale,
     rmNetscape, rmQuantize, rmQuantizeWindows, rmPalette);

  TDitherMode =
    (dmNearest, dmFloydSteinberg, dmStucki, dmSierra, dmJaJuNI, dmSteveArche,
     dmBurkes);

function FIPIShelpGetBitmap(path: PChar; app: THandle):HBITMAP; stdcall;
function FIPIShelpBrowseForBitmap(app, wnd: THandle):HBITMAP; stdcall;
function FIPIShelpSelectColor(color: TColor; app, wnd: THandle):TColor; stdcall;
function FIPIShelpDitherOnDemand(bitmap: HBITMAP; clr: TColorReduction; dth: TDitherMode; app: THandle):HBITMAP; stdcall;
function FIPIShelpDither(bitmap: HBITMAP; app, wnd: THandle):HBITMAP; stdcall;

implementation

function FIPIShelpGetBitmap(path: PChar; app: THandle):HBITMAP; external 'helper.dll';
function FIPIShelpBrowseForBitmap(app, wnd: THandle):HBITMAP; external 'helper.dll';
function FIPIShelpSelectColor(color: TColor; app, wnd: THandle):TColor; external 'helper.dll';
function FIPIShelpDitherOnDemand(bitmap: HBITMAP; clr: TColorReduction; dth: TDitherMode; app: THandle):HBITMAP; external 'helper.dll';
function FIPIShelpDither(bitmap: HBITMAP; app, wnd: THandle):HBITMAP; external 'helper.dll';

end.
