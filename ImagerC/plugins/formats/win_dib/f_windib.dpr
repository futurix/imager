library f_windib;

uses Windows, SysUtils, Classes, Graphics;

{$R *.RES}
{$R fipis.res}

function FIPISopen(path,ext: PChar; app: THandle):hBitmap; stdcall;
var
   bmp: TBitmap;
begin
bmp:=TBitmap.Create();
try
   bmp.LoadFromFile(String(path));
   Result:=bmp.ReleaseHandle();
   except
         Result:=0;
   end;
bmp.Free();
end;

exports FIPISopen;

begin
end.
 