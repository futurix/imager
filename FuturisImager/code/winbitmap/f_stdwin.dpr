library f_stdwin;

uses SysUtils, Windows, Classes, Graphics, c_const;

{$R *.RES}

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
func(PT_FOPEN,'bmp',' ');
func(PT_FOPEN,'dib',' ');
func(PT_FOPEN,'rle',' ');
func(PT_FOPEN,'emf',' ');
func(PT_FOPEN,'wmf',' ');
func(PT_FSAVE,'bmp',' ');
func(PT_FDESCR,'bmp','Windows Bitmap (*.bmp)');
func(PT_FDESCR,'dib','Windows DIB (*.dib)');
func(PT_FDESCR,'rle','RLE-compressed Windows Bitmap (*.rle)');
func(PT_FDESCR,'emf','Windows Metafile (*.wmf)');
func(PT_FDESCR,'wmf','Enhanced Metafile (*.emf)');
Result:=true;
end;

function FIPISopen(path,ext: PChar; app: THandle):hBitmap; stdcall;
var
  pic: TPicture;
  bmp: TBitmap;
begin
// standart bitmaps or metafiles
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

function FIPISsave(path,ext: PChar; app, wnd: THandle; img: hBitmap):integer; stdcall;
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
  FIPISquery, FIPISopen, FIPISsave;

begin
end.
