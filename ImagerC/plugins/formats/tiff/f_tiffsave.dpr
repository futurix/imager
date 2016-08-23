library f_tiffsave;

uses Windows, SysUtils, Graphics, Classes, bmp2tiff;

{$R *.RES}
{$R fipis.res}

function FIPISsave(path,ext: PChar; app: THandle; img: hBitmap):integer; stdcall;
var
   bmp: TBitmap;
begin
bmp:=TBitmap.Create();
Result:=1;
try
   bmp.Handle:=img;
   WriteTiffToFile(String(path),bmp);
   except
         Result:=0;
   end;
bmp.Free();
end;

exports FIPISsave;

begin
end.
 