// global definitions
unit globals;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, IniFiles, Registry,
  c_const, c_reg;

type
  TDoPrint = function(app: THandle; img: hBitmap; filename: PChar; fast: boolean):integer; stdcall;
  TDoScan = function(app: THandle; imager_dir: PChar):integer; stdcall;

  TFileTypes = (ftNone, ftLocal, ftUnsaved);
  TImageTypes = (itNone, itNormal, itAnimated, itMulti);
  TStartUpOptions = (soSlideShow, soDirAsParam);
  TStartUp = set of TStartUpOptions;
  TOptionsValues = (opZoomOnLoad, opOpenAfterSave,
                    opFSCenter, opFullPathInTitle, opOpenDef);
  TOptions = set of TOptionsValues;

var
  files: TStringList;
  reg: TFuturisRegistry;

var infImage: record
  original, null_bitmap: TBitmap;
  zoom_factor: Real;
  path: string;
  modified: boolean;
  file_type: TFileTypes;
  image_type: TImageTypes;
  filenum: integer;
end;

var infSettings: record
  options: TOptions;
  showparams: TStartUp;
  dir: string;
  full_screen: boolean;
end;

var infMouse: record
  handy: boolean;
  x ,y: integer;
end;

var infMulti: record
  lib: THandle;
  pages, page: integer;
  // functions
  FIPISmultiInit: TFIPISmultiInit;
  FIPISmultiGetPages: TFIPISmultiGetPages;
  FIPISmultiGetPage: TFIPISmultiGetPage;
  FIPISmultiDeInit: TFIPISmultiDeInit;
end;

var infAnim: record
  lib: THandle;
  // functions
  FIPISanimInit: TFIPISanimInit;
  FIPISanimConfirm: TFIPISanimConfirm;
  FIPISanimRestart: TFIPISanimRestart;
  FIPISanimGetFrame: TFIPISanimGetFrame;
  FIPISanimDeInit: TFIPISanimDeInit;
end;

procedure FillImage(path: string; file_type: TFileTypes; image_type: TImageTypes; zoom_factor: Real = 1; modified: boolean = false);
procedure FillBitmap(bmp: TBitmap; synch: boolean = true; img: hBitmap = 0);

implementation

uses main;

procedure FillImage(path: string; file_type: TFileTypes; image_type: TImageTypes; zoom_factor: Real = 1; modified: boolean = false);
begin
infImage.path:=path;
infImage.file_type:=file_type;
infImage.image_type:=image_type;
infImage.zoom_factor:=zoom_factor;
infImage.modified:=modified;
end;

procedure FillBitmap(bmp: TBitmap; synch: boolean = true; img: hBitmap = 0);
begin
if img=0 then
  begin
  // from TBitmap
  infImage.original.Assign(bmp);
  infImage.original.PixelFormat:=pf24bit;
  if synch then
    frmMain.imgMain.Picture.Bitmap.Assign(infImage.original);
  frmMain.imgMain.Picture.Bitmap.PixelFormat:=pf24bit;
  end
else
  begin
  // from hBitmap
  infImage.original.Handle:=img;
  infImage.original.PixelFormat:=pf24bit;
  if synch then
    frmMain.imgMain.Picture.Bitmap.Assign(infImage.original);
  frmMain.imgMain.Picture.Bitmap.PixelFormat:=pf24bit;
  end;
end;

end.
