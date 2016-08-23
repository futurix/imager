// global definitions
unit globals;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, IniFiles, Registry,
  fipis;

type
  TDoPrint = function(app: THandle; img: hBitmap; filename: PChar; fast: boolean):integer; stdcall;
  TLoadFile = function(app: THandle; url, tempfile, ua, ref: PChar):PChar; stdcall;
  TExecute = function(app: THandle):integer; stdcall;
  TDoScan = function(app: THandle; imager_dir: PChar):integer; stdcall;

  TFileTypes = (ftNone, ftLocal, ftWeb, ftUnsaved);
  TImageTypes = (itNone, itNormal, itAnimated, itMulti);
  TStartUpOptions = (soSlideShow, soDirAsParam);
  TStartUp = set of TStartUpOptions;
  TOptionsValues = (opHints, opAutoApply, opZoomOnLoad, opOpenAfterSave,
                    opDelTempFiles, opFSCenter, opFullPathInTitle, opOpenDef);
  TOptions = set of TOptionsValues;

const
  sReg = '\Software\Futuris\ImagerC';
  sFIPIS = '\Software\Futuris\FIPIS';
  sName = 'Futuris Imager';

var
  files: TStringList;
  reg: TRegistry;

var infImage: record
  original, null_bitmap: TBitmap;
  zoom_factor: Real;
  path, url: string;
  modified: boolean;
  file_type: TFileTypes;
  image_type: TImageTypes;
  filenum: integer;
end;

var infSettings: record
  options: TOptions;
  quick_mask, uagent, appHome: string;
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

procedure FillImage(path, url: string; file_type: TFileTypes; image_type: TImageTypes; zoom_factor: Real = 1; modified: boolean = false);
procedure FillBitmap(bmp: TBitmap; synch: boolean = true; img: hBitmap = 0);

implementation

uses main;

procedure FillImage(path, url: string; file_type: TFileTypes; image_type: TImageTypes; zoom_factor: Real = 1; modified: boolean = false);
begin
infImage.path:=path;
infImage.url:=url;
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
  if synch then
    frmMain.imgMain.Picture.Bitmap.Assign(infImage.original);
  end
else
  begin
  // from hBitmap
  infImage.original.Handle:=img;
  if synch then
    frmMain.imgMain.Picture.Bitmap.Assign(infImage.original);
  end;
end;

end.
