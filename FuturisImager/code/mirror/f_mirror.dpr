library f_mirror;

uses
  Windows, SysUtils, Classes, Graphics,
  c_const;

var
  gbmp: TBitmap;

{$R *.RES}

procedure MirrorRight(var src: TBitmap);
var
  i: integer;
  img: TBitmap;
begin
img:=TBitmap.Create();
img.PixelFormat:=pf24Bit;
img.Width:=src.Width;
img.Height:=src.Height;
for i:=0 to (src.Width-1) do
  img.Canvas.CopyRect(Rect(src.Width-1-i,0,src.Width-i,src.Height),src.Canvas,Rect(i,0,i+1,src.Height));
src.Assign(img);
img.Free();
end;

procedure MirrorDown(var src: TBitmap);
var
  i: integer;
  img: TBitmap;
begin
img:=TBitmap.Create();
img.PixelFormat:=pf24Bit;
img.Width:=src.Width;
img.Height:=src.Height;
for i:=0 to (src.Height-1) do
  img.Canvas.CopyRect(Rect(0,src.Height-1-i,src.Width,src.Height-i),src.Canvas,Rect(0,i,src.Width,i+1));
src.Assign(img);
img.Free();
end;

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
func(PT_FFILTER,'Flip Horizontal',' ');
func(PT_FFILTER,'Flip Vertical',' ');
Result:=true;
end;

function FIPISfilter(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;
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
if Pos('Horizontal',String(info))<>0 then
  begin
  // Flip Horizontal
  MirrorRight(gbmp);
  end
else
  begin
  // Flip Vertical
  MirrorDown(gbmp);
  end;

// sending result
bmp.Assign(gbmp);
Result:=bmp.ReleaseHandle();
bmp.Free();
gbmp.Free();
end;

exports
  FIPISquery, FIPISfilter;

begin
end.
 