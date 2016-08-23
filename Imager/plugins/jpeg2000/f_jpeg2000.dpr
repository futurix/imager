library f_jpeg2000;

uses
  SysUtils,
  Windows,
  Classes,
  Graphics,
  Forms,
  ImageDLLLoader,
  LinarBitmap,
  c_const,
  JPEG2Ksave in 'JPEG2Ksave.pas' {frmJPsave};

{$R *.res}

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
func(PT_FOPEN,'jp2',' ');
func(PT_FOPEN,'jpc',' ');
func(PT_FOPEN,'ras',' ');

func(PT_FSAVE,'jp2',' ');

func(PT_FDESCR,'jp2','JPEG 2000 (*.jp2)');
func(PT_FDESCR,'jpc','JPEG 2000 (*.jpc)');
func(PT_FDESCR,'ras','Sun Raster (*.ras)');

Result:=true;
end;

function FIPISopen(path,ext: PChar; app: THandle):hBitmap; stdcall;
var
  bmp: TBitmap;
begin
bmp:=TBitmap.Create();
ImageDLLLoader.Default.FindDLLs('jasper.dll');

with TLinearBitmap.Create do
  try
    LoadFromFile(String(path));
    AssignTo(bmp);
  finally
    Free();
  end;

Result:=bmp.ReleaseHandle();
FreeAndNil(bmp);
end;

function FIPISsave(path,ext: PChar; app, wnd: THandle; img: hBitmap):integer; stdcall;
var
  bmp: TBitmap;
begin
Result:=0;
//Application.Handle:=app;

bmp:=TBitmap.Create();
ImageDLLLoader.Default.FindDLLs('jasper.dll');
bmp.Handle:=img;

frmJPsave:=TfrmJPsave.Create(nil);
frmJPsave.ShowModal();

if jp2_confirm then
  begin
  with TLinearBitmap.Create do
    try
      Assign(bmp);

      if frmJPsave.cbxLossless.Checked=false then
        ImageDLLLoader.Default.CompOptions:=('rate=' + Format('%f', [frmJPsave.tbrQuality.Position/100]));

      SaveToFile(String(path));
      Result:=1;
    finally
      Free();
    end;
  end;

FreeAndNil(frmJPsave);
FreeAndNil(bmp);
end;

exports
  FIPISquery, FIPISopen, FIPISsave;

begin
end.
 