library f_mirror;

uses Windows, SysUtils, Classes, Graphics;

var
   gbmp: TBitmap;

{$R *.RES}
{$R fipis.res}

procedure MirrorRight(var src: TBitmap);
var
   i: integer;
   img: TBitmap;
begin
img:=TBitmap.Create();
img.Width:=src.Width;
img.Height:=src.Height;
for i:=0 to (src.Width-1) do begin
                             img.Canvas.CopyRect(Rect(src.Width-1-i,0,src.Width-i,src.Height),src.Canvas,Rect(i,0,i+1,src.Height));
                             end;
src.Assign(img);
img.Free();
end;

procedure MirrorDown(var src: TBitmap);
var
   i: integer;
   img: TBitmap;
begin
img:=TBitmap.Create();
img.Width:=src.Width;
img.Height:=src.Height;
for i:=0 to (src.Height-1) do begin
                             img.Canvas.CopyRect(Rect(0,src.Height-1-i,src.Width,src.Height-i),src.Canvas,Rect(0,i,src.Width,i+1));
                             end;
src.Assign(img);
img.Free();
end;

function FIPISfilter(info: PChar; app: THandle; img: hBitmap):hBitmap; stdcall;
var
   bmp: TBitmap;
begin
// tuning internals
bmp:=TBitmap.Create();
bmp.Handle:=img;
bmp.PixelFormat:=pf24Bit;
gbmp:=TBitmap.Create();
gbmp.Assign(bmp);
// modifying
if Pos('Right',String(info))<>0 then begin
                                     // Mirror Right
                                     MirrorRight(gbmp);
                                     end
else begin
     // Mirror Down
     MirrorDown(gbmp);
     end;
// sending result
bmp.Assign(gbmp);
Result:=bmp.ReleaseHandle();
bmp.Free();
gbmp.Free();
end;

exports FIPISfilter;

begin
end.
 