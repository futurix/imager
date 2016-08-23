library f_ngexport;

uses
  Windows, SysUtils, Graphics, Classes, NGImage,
  ngexpw in 'ngexpw.pas' {frmXNG};

{$R *.RES}
{$R fipis.res}

function FIPISsave(path,ext: PChar; app: THandle; img: hBitmap):integer; stdcall;
var
   bmp: TBitmap;
   xng: TNGImage;
begin
bmp:=TBitmap.Create();
xng:=TNGImage.Create();
Result:=1;
try
   bmp.Handle:=img;
   xng.Assign(bmp);
   if ext='jng' then xng.SaveToJNGfile(String(path))
   else xng.SaveToPNGfile(String(path));
   except
         Result:=0;
   end;
bmp.Free();
xng.Free();
end;

exports FIPISsave, FIPISexport;

begin
end.
 