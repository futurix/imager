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

function FHelpGetBitmap(path: PChar; app: THandle):HBITMAP; stdcall;
function FHelpBrowseForBitmap(app, wnd: THandle):HBITMAP; stdcall;
function FHelpSelectColor(color: TColor; app, wnd: THandle):TColor; stdcall;
function FHelpDitherOnDemand(bitmap: HBITMAP; clr: TColorReduction; dth: TDitherMode; app: THandle):HBITMAP; stdcall;
function FHelpDither(bitmap: HBITMAP; app, wnd: THandle):HBITMAP; stdcall;


implementation

function FHelpGetBitmap(path: PChar; app: THandle):HBITMAP; external 'img_helper.dll';
function FHelpBrowseForBitmap(app, wnd: THandle):HBITMAP; external 'img_helper.dll';
function FHelpSelectColor(color: TColor; app, wnd: THandle):TColor; external 'img_helper.dll';
function FHelpDitherOnDemand(bitmap: HBITMAP; clr: TColorReduction; dth: TDitherMode; app: THandle):HBITMAP; external 'img_helper.dll';
function FHelpDither(bitmap: HBITMAP; app, wnd: THandle):HBITMAP; external 'img_helper.dll';

end.
