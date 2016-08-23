unit c_ie;

interface

uses
  Windows, SysUtils, Classes, Graphics,
  hyieutils,
  c_const;

type
  TIEBitmapEx = class helper for TIEBitmap
  public
    procedure PrepareAlphaForExternalUse();
    procedure PrepareAlphaAfterAssignment();
  end;


implementation

// combines together alpha channel and main image
// before copying to TBitmap
procedure TIEBitmapEx.PrepareAlphaForExternalUse();
begin
  if ((PixelFormat = ie24RGB) and HasAlphaChannel) then
    begin
    PixelFormat := ie32RGB;
    SynchronizeRGBA(false);
    end;
end;

// extracts alpha channel after converting from HBITMAP
procedure TIEBitmapEx.PrepareAlphaAfterAssignment();
begin
  if (PixelFormat = ie32RGB) then
    begin
    SynchronizeRGBA(true);
    PixelFormat := ie24RGB;
    end;
end;

end.
