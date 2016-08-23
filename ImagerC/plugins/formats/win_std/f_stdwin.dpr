library f_stdwin;

uses SysUtils, Windows, Classes, Graphics;

{$R *.RES}
{$R fipis.res}

function FIPISopen(path,ext: PChar; app: THandle):hBitmap; stdcall;
var
   pic: TPicture;
   bmp: TBitmap;
begin
// standart bitmaps or icons or metas
pic:=TPicture.Create();
bmp:=TBitmap.Create();
try
   try
      pic.LoadFromFile(String(path));
      bmp.Width:=pic.Width;
      bmp.Height:=pic.Height;
      bmp.Canvas.Draw(0,0,pic.Graphic);
      Result:=bmp.Handle;
   except
         Result:=0;
   end;
finally
       bmp.ReleaseHandle();
       bmp.Free();
       pic.Free();
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
   bmp.SaveToFile(String(path));
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
