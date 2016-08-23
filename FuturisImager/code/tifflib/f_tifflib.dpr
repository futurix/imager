library f_tifflib;

uses
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Forms,
  c_const,
  c_helper,
  EnDcxGr,
  EnEpsGr,
  EnJpgGr,
  EnPcxGr,
  EnPngGr,
  EnPpmGr,
  EnTgaGr,
  EnTifGr,
  JPEGsave in 'JPEGsave.pas' {frmJPEGsave},
  TIFFsave in 'TIFFsave.pas' {frmTIFFsave};

var
  mtiff: TTiffGraphic;
  mdcx: TDcxGraphic;
  str: TFileStream;
  mext: string = '';

{$R *.res}

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
func(PT_FOPEN,'eps',' ');
func(PT_FOPEN,'jpg',' ');
func(PT_FOPEN,'jpeg',' ');
func(PT_FOPEN,'jpe',' ');
func(PT_FOPEN,'jif',' ');
func(PT_FOPEN,'jfif',' ');
func(PT_FOPEN,'pcx',' ');
func(PT_FOPEN,'pcc',' ');
func(PT_FOPEN,'dcx',' ');
func(PT_FOPEN,'png',' ');
func(PT_FOPEN,'tga',' ');
func(PT_FOPEN,'vst',' ');
func(PT_FOPEN,'icb',' ');
func(PT_FOPEN,'vda',' ');
func(PT_FOPEN,'afi',' ');
func(PT_FOPEN,'tif',' ');
func(PT_FOPEN,'tiff',' ');

func(PT_FOPENMULTI,'dcx',' ');
func(PT_FOPENMULTI,'tif',' ');
func(PT_FOPENMULTI,'tiff',' ');

func(PT_FDESCR,'eps','Encapsulated PostScript (*.eps)');
func(PT_FDESCR,'jpg','Joint Photographic Experts Group (*.jpg)');
func(PT_FDESCR,'jpeg','Joint Photographic Experts Group (*.jpeg)');
func(PT_FDESCR,'jpe','Joint Photographic Experts Group (*.jpe)');
func(PT_FDESCR,'jif','Joint Photographic Experts Group (*.jif)');
func(PT_FDESCR,'jfif','Joint Photographic Experts Group (*.jfif)');
func(PT_FDESCR,'pcx','ZSoft Paintbrush (*.pcx)');
func(PT_FDESCR,'pcc','ZSoft Paintbrush (*.pcc)');
func(PT_FDESCR,'dcx','ZSoft Multi-page Paintbrush (*.dcx)');
func(PT_FDESCR,'png','Portable Network Graphics (*.png)');
func(PT_FDESCR,'tga','Truevision Targa (*.tga)');
func(PT_FDESCR,'vst','Truevision Targa (*.vst)');
func(PT_FDESCR,'icb','Truevision Targa (*.icb)');
func(PT_FDESCR,'vda','Truevision Targa (*.vda)');
func(PT_FDESCR,'afi','Truevision Targa (*.afi)');
func(PT_FDESCR,'tif','Tag Image File Format (*.tif)');
func(PT_FDESCR,'tiff','Tag Image File Format (*.tiff)');

func(PT_FSAVE,'jpg',' ');
func(PT_FSAVE,'pcx',' ');
func(PT_FSAVE,'png',' ');
func(PT_FSAVE,'pbm',' ');
func(PT_FSAVE,'pgm',' ');
func(PT_FSAVE,'ppm',' ');
func(PT_FSAVE,'tga',' ');
func(PT_FSAVE,'tif',' ');

//func(PT_FEXPORT,'Advanced JPEG Export',' ');

Result:=true;
end;

function FIPISopen(path, ext: PChar; app: THandle):hBitmap; stdcall;
var
  bmp: TBitmap;
  eps: TEpsGraphic;
  jpeg: TJpegGraphic;
  pcx: TPcxGraphic;
  dcx: TDcxGraphic;
  png: TPngGraphic;
  ppm: TPpmGraphic;
  tga: TTgaGraphic;
  tiff: TTiffGraphic;
begin
if ext='eps' then
  begin
  try
    bmp:=TBitmap.Create();
    eps:=TEpsGraphic.Create();
    eps.LoadFromFile(String(path));
    bmp.Assign(eps);
    Result:=bmp.ReleaseHandle();
    FreeAndNil(bmp);
    FreeAndNil(eps);
    except
      Result:=0;
    end;
  end
else if ((ext='jpg') or (ext='jpeg') or (ext='jif') or (ext='jpe') or (ext='jfif')) then
  begin
  try
    bmp:=TBitmap.Create();
    jpeg:=TJpegGraphic.Create();
    jpeg.LoadFromFile(String(path));
    bmp.Assign(jpeg);
    Result:=bmp.ReleaseHandle();
    FreeAndNil(bmp);
    FreeAndNil(jpeg);
    except
      Result:=0;
    end;
  end
else if ((ext='pcx') or (ext='pcc')) then
  begin
  try
    bmp:=TBitmap.Create();
    pcx:=TPcxGraphic.Create();
    pcx.LoadFromFile(String(path));
    bmp.Assign(pcx);
    Result:=bmp.ReleaseHandle();
    FreeAndNil(bmp);
    FreeAndNil(pcx);
    except
      Result:=0;
    end;
  end
else if ext='dcx' then
  begin
  try
    bmp:=TBitmap.Create();
    dcx:=TDcxGraphic.Create();
    dcx.LoadFromFile(String(path));
    bmp.Assign(dcx);
    Result:=bmp.ReleaseHandle();
    FreeAndNil(bmp);
    FreeAndNil(dcx);
    except
      Result:=0;
    end;
  end
else if ext='png' then
  begin
  try
    bmp:=TBitmap.Create();
    png:=TPngGraphic.Create();
    png.LoadFromFile(String(path));
    bmp.Assign(png);
    Result:=bmp.ReleaseHandle();
    FreeAndNil(bmp);
    FreeAndNil(png);
    except
      Result:=0;
    end;
  end
else if ((ext='pbm') or (ext='pgm') or (ext='ppm')) then
  begin
  try
    bmp:=TBitmap.Create();
    ppm:=TPpmGraphic.Create();
    ppm.LoadFromFile(String(path));
    bmp.Assign(ppm);
    Result:=bmp.ReleaseHandle();
    FreeAndNil(bmp);
    FreeAndNil(ppm);
    except
      Result:=0;
    end;
  end
else if ((ext='tga') or (ext='vst') or (ext='icb') or (ext='vda') or (ext='afi')) then
  begin
  try
    bmp:=TBitmap.Create();
    tga:=TTgaGraphic.Create();
    tga.LoadFromFile(String(path));
    bmp.Assign(tga);
    Result:=bmp.ReleaseHandle();
    FreeAndNil(bmp);
    FreeAndNil(tga);
    except
      Result:=0;
    end;
  end
else if ((ext='tif') or (ext='tiff')) then
  begin
  try
    bmp:=TBitmap.Create();
    tiff:=TTiffGraphic.Create();
    tiff.LoadFromFile(String(path));
    bmp.Assign(tiff);
    Result:=bmp.ReleaseHandle();
    FreeAndNil(bmp);
    FreeAndNil(tiff);
    except
      Result:=0;
    end;
  end
else
  Result:=0;
end;

function FIPISsave(path,ext: PChar; app, wnd: THandle; img: hBitmap):integer; stdcall;
var
  bmp: TBitmap;
  jpeg: TJpegGraphic;
  pcx: TPcxGraphic;
  png: TPngGraphic;
  ppm: TPpmGraphic;
  tga: TTgaGraphic;
  tiff: TTiffGraphic;
begin
Application.Handle:=app;

// initializing
bmp:=TBitmap.Create();
Result:=0;
bmp.Handle:=img;
bmp.PixelFormat:=pf24bit;

// working
if ext='jpg' then
  begin
  frmJPEGsave:=TfrmJPEGsave.Create(nil);
  frmJPEGsave.ShowModal();
  
  if jpeg_confirm then
    begin
    jpeg:=TJpegGraphic.Create();

    if frmJPEGsave.tbrQuality.Position>0 then
      jpeg.SaveQuality:=frmJPEGsave.tbrQuality.Position
    else
      jpeg.SaveQuality:=1;
    jpeg.SaveProgressive:=frmJPEGsave.cbxProgressive.Checked;

    jpeg.Assign(bmp);
    jpeg.SaveToFile(String(path));
    FreeAndNil(jpeg);
    Result:=1;
    end
  else
    Result:=0;

  FreeAndNil(frmJPEGsave);
  end
else if ext='pcx' then
  begin
  pcx:=TPcxGraphic.Create();
  pcx.Assign(bmp);
  pcx.SaveToFile(String(path));
  FreeAndNil(pcx);
  Result:=1;
  end
else if ext='png' then
  begin
  png:=TPngGraphic.Create();
  png.Assign(bmp);
  png.SaveProgressive:=true;
  png.SaveToFile(String(path));
  FreeAndNil(png);
  Result:=1;
  end
else if ext='pbm' then
  begin
  ppm:=TPpmGraphic.Create();
  bmp.Handle:=FIPIShelpDitherOnDemand(bmp.Handle,rmMonochrome,dmFloydSteinberg,app);
  bmp.PixelFormat:=pf1bit;
  ppm.Assign(bmp);
  ppm.SaveToFile(String(path));
  FreeAndNil(ppm);
  Result:=1;
  end
else if ext='pgm' then
  begin
  ppm:=TPpmGraphic.Create();
  bmp.Handle:=FIPIShelpDitherOnDemand(bmp.Handle,rmGrayScale,dmFloydSteinberg,app);
  bmp.PixelFormat:=pf8bit;
  ppm.Assign(bmp);
  ppm.SaveToFile(String(path));
  FreeAndNil(ppm);
  Result:=1;
  end
else if ext='ppm' then
  begin
  ppm:=TPpmGraphic.Create();
  ppm.Assign(bmp);
  ppm.SaveToFile(String(path));
  FreeAndNil(ppm);
  Result:=1;
  end
else if ext='tga' then
  begin
  tga:=TTgaGraphic.Create();
  tga.Assign(bmp);
  tga.SaveToFile(String(path));
  FreeAndNil(tga);
  Result:=1;
  end
else if ext='tif' then
  begin
  frmTIFFsave:=TfrmTIFFsave.Create(nil);
  frmTIFFsave.ShowModal();

  if tiff_confirm then
    begin
    tiff:=TTiffGraphic.Create();

    if frmTIFFsave.rbnCNone.Checked then
      begin
      tiff.Assign(bmp);
      tiff.Compression:=tcNone;
      end
    else if frmTIFFsave.rbnCLZW.Checked then
      begin
      tiff.Assign(bmp);
      tiff.Compression:=tcLZW;
      end
    else if frmTIFFsave.rbnCJPEG.Checked then
      begin
      tiff.Assign(bmp);
      if frmTIFFsave.tbrQuality.Position>0 then
        tiff.JpegQuality:=frmTIFFsave.tbrQuality.Position
      else
        tiff.JpegQuality:=1;
      tiff.Compression:=tcJPEG;
      end
    else if frmTIFFsave.rbnCZlib.Checked then
      begin
      tiff.Assign(bmp);
      tiff.Compression:=tcZLib;
      end
    else if frmTIFFsave.rbnCPackBits.Checked then
      begin
      tiff.Assign(bmp);
      tiff.Compression:=tcPackbits;
      end
    else if frmTIFFsave.rbnCG31.Checked then
      begin
      bmp.Handle:=FIPIShelpDitherOnDemand(bmp.Handle,rmMonochrome,dmFloydSteinberg,app);
      bmp.PixelFormat:=pf1bit;
      tiff.Assign(bmp);
      tiff.Compression:=tcGroup3_1d;
      end
    else if frmTIFFsave.rbnCG32.Checked then
      begin
      bmp.Handle:=FIPIShelpDitherOnDemand(bmp.Handle,rmMonochrome,dmFloydSteinberg,app);
      bmp.PixelFormat:=pf1bit;
      tiff.Assign(bmp);
      tiff.Compression:=tcGroup3_2d;
      end
    else if frmTIFFsave.rbnCG4.Checked then
      begin
      bmp.Handle:=FIPIShelpDitherOnDemand(bmp.Handle,rmMonochrome,dmFloydSteinberg,app);
      bmp.PixelFormat:=pf1bit;
      tiff.Assign(bmp);
      tiff.Compression:=tcGroup4;
      end
    else
      begin
      tiff.Assign(bmp);
      tiff.Compression:=tcLZW;
      end;

    tiff.SaveToFile(String(path));
    FreeAndNil(tiff);
    Result:=1;
    end
  else
    Result:=0;

  FreeAndNil(frmTIFFsave);
  end;

// cleaning
FreeAndNil(bmp);
end;

function FIPISmultiInit(filename, ext: PChar; app: THandle):integer; stdcall;
begin
Result:=0;

if ((ext='tif') or (ext='tiff')) then
  begin
  try
    mtiff:=TTiffGraphic.Create();
    str:=TFileStream.Create(String(filename),fmOpenRead+fmShareDenyNone);
    str.Seek(0,soFromBeginning);
    Result:=mtiff.GetImageCount(str);
    mext:='tiff';
  except
    Result:=0;
    FreeAndNil(str);
    FreeAndNil(mtiff);
  end;
  end
else if ext='dcx' then
  begin
  try
    mdcx:=TDcxGraphic.Create();
    str:=TFileStream.Create(String(filename),fmOpenRead+fmShareDenyNone);
    str.Seek(0,soFromBeginning);
    Result:=mdcx.GetImageCount(str);
    mext:='dcx';
  except
    Result:=0;
    FreeAndNil(str);
    FreeAndNil(mdcx);
  end;
  end;
end;

function FIPISmultiGetPages():integer; stdcall;
begin
if mext='tiff' then
  begin
  str.Seek(0,soFromBeginning);
  Result:=mtiff.GetImageCount(str);
  end
else if mext='dcx' then
  begin
  str.Seek(0,soFromBeginning);
  Result:=mdcx.GetImageCount(str);
  end
else Result:=0;
end;

function FIPISmultiGetPage(index: integer):hBitmap; stdcall;
var
   bmp: TBitmap;
begin
if mext='tiff' then
  begin
  str.Seek(0,soFromBeginning);
  mtiff.ImageToLoad:=index+1;
  bmp:=TBitmap.Create();
  mtiff.LoadFromStream(str);
  bmp.Assign(mtiff);
  Result:=bmp.ReleaseHandle();
  FreeAndNil(bmp);
  end
else if mext='dcx' then
  begin
  str.Seek(0,soFromBeginning);
  mdcx.ImageToLoad:=index+1;
  bmp:=TBitmap.Create();
  mdcx.LoadFromStream(str);
  bmp.Assign(mdcx);
  Result:=bmp.ReleaseHandle();
  FreeAndNil(bmp);
  end
else Result:=0;
end;

function FIPISmultiDeInit():integer; stdcall;
begin
Result:=1;

if mext='tiff' then
  begin
  FreeAndNil(mtiff);
  FreeAndNil(str);
  mext:='';
  end
else if mext='dcx' then
  begin
  FreeAndNil(mdcx);
  FreeAndNil(str);
  mext:='';
  end
else Result:=0;
end;

exports
  FIPISquery, FIPISopen, FIPISsave,
  FIPISmultiInit, FIPISmultiGetPages, FIPISmultiGetPage, FIPISmultiDeInit;

begin
end.
