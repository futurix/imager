library f_slides;

uses Windows, SysUtils, Graphics, Classes, SLDimage;

{$R *.RES}
{$R fipis.res}

function FIPISopen(path,ext: PChar; app: THandle):hBitmap; stdcall;
var
   bmp: TBitmap;
   sld: TSlide;
begin
sld:=TSlide.Create();
bmp:=TBitmap.Create();
try
   sld.LoadFromFile(String(path));
   bmp.Height:=sld.Height;
   bmp.Width:=sld.Width;
   bmp.Canvas.Draw(0,0,sld);
   Result:=bmp.ReleaseHandle();
   except
         on EInvalidGraphic do Result:=0;
         end;
sld.Free();
bmp.Free();
end;

exports FIPISopen;

begin
end.
 