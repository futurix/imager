//------------------------------------------------------------------------------
//  Apprehend Version  : 4.1
//  Copyright (c) 2005 : Adirondack Software & Graphics
//  Created            : 1-09-1992
//  Last Modification  : 07-26-2005
//  Description        : PixelFormatFix Unit
//------------------------------------------------------------------------------

// PixelFormatFix.pas
// used to prevent strange delphi/c++builder crash if pixelformat is not forced:
//
// "Mouser" (www.donationcoder.com), 5/12/05
// Capturing large bitmaps very frequently caused crashing of my applications
// with insufficient memory type errors.
// After some time I tracked down this newsgroup post which suggests that
// the cure is to set the bitmap object to 24bits per pixel prior to filling it.
// See -> http://groups-beta.google.com/group/borland.public.delphi.graphics/browse_thread/
// thread/2575992b6bd62e66/203f09c94f0b1396?q=bitmap+delphi+%22not+enough+storage+is+available+
// to+process+this+command%22&rnum=1&hl=en#203f09c94f0b1396
//  ".. if you dont declare the pixel format to be 24 bit the Bitmap will be seen as a device
// dependent bitmap and this may cause the problem. Setting pixelformat to pf24bit ensures
// that you will create a DIB. "
//

unit PixelFormatFix;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, ExtCtrls, StdCtrls, Menus, Clipbrd;

procedure DoPixelFormatFix (bitmapp: TBitmap);

implementation


procedure DoPixelFormatFix (bitmapp: TBitmap);
begin
//  bitmapp.PixelFormat := pf24bit;
//  bitmapp.PixelFormat := pfDevice;
  bitmapp.PixelFormat := pf32bit;
end;



end.

