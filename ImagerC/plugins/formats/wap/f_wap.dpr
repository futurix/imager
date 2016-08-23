library f_wap;

uses SysUtils, Windows, Classes, Graphics, bmp2wbmp;

{$R *.RES}
{$R fipis.res}

function FIPISopen(path,ext: PChar; app: THandle):hBitmap; stdcall;
var
   bmp: TBitmap;
begin
// WAP bitmap
bmp:=TBitmap.Create();
try
   try
   LoadFromWBmpFile(bmp,String(path));
   Result:=bmp.Handle;
   except
         Result:=0;
   end;
finally
       bmp.ReleaseHandle();
       bmp.Free();
end;
end;

function FIPISsave(path,ext: PChar; app: THandle; img: hBitmap):integer; stdcall;
var
   bmp: TBitmap;
begin
bmp:=TBitmap.Create();
Result:=1;
try
   bmp.Handle:=img;
   SaveAsWBmpFile(bmp,String(path));
   except
         Result:=0;
   end;
bmp.Free();
end;

exports
       FIPISopen,
       FIPISsave;

begin
end.
