unit c_graphics;

interface

uses
  Windows, SysUtils, Classes, Graphics,
  c_const;

type
  TBitmapEx = class helper for TBitmap
  public
    procedure ApplyLimits();
  end;


implementation

// applies limits on supported pixel formats
procedure TBitmapEx.ApplyLimits();
var
  info: BITMAP;
  res: TPixelFormat;
begin
  res := pf24bit;

  if HandleAllocated then
    begin
    ZeroMemory(@info, SizeOf(BITMAP));

    if (GetObject(Handle, SizeOf(BITMAP), @info) <> 0) then
      begin
      if (info.bmBitsPixel = 32) then
        res := pf32bit;
      end;
    end;

  PixelFormat := res;
end;

end.
