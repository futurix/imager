// graphics routines
unit f_graphics;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms,
  c_const;

procedure OpenImage();
procedure Reopen();
procedure Save();
procedure CloseImage(turn_off_ui: boolean = true);
procedure Load(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
function DoImageLoad(path: string):hBitmap;
function Write(path: string):integer;
procedure OpenLocal(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
procedure OpenUntitled(bmp: TBitmap; img: hBitmap = 0; synch: boolean = true);
function SupportedExt(ext: string):boolean;
function FileType(path: string):integer;
function IsSupported(filename: string):boolean;
function GetTypeString(ext: string; default: string = ''):string;

implementation

uses globals, main, f_debug, f_reg, f_plugins, f_ui, f_tools,
     f_nav, f_strutils, f_images, f_anim, f_multi, f_external;

// starts open process
procedure OpenImage();
begin
if (infImage.file_type=ftLocal) then
  frmMain.dlgOpen.InitialDir:=ExtractFileDir(infImage.path)
else
  begin
  reg.OpenKey(sReg + '\Main',true);
  frmMain.dlgOpen.InitialDir:=reg.RStr('OpenPath','');
  reg.CloseKey();
  end;

if frmMain.dlgOpen.Execute=true then
  begin
  reg.OpenKey(sReg + '\Main',true);
  reg.WriteString('OpenPath',ExtractFileDir(frmMain.dlgOpen.FileName));
  reg.CloseKey();
  Load(frmMain.dlgOpen.FileName);
  end;
end;

// reloads image
procedure Reopen();
var
  tmp: string;
begin
if infImage.file_type=ftLocal then
  begin
  tmp:=infImage.path;
  CloseImage();
  Load(tmp);
  end;
end;

// starts saving process
procedure Save();
var
  tmp: string;
  res: integer;
begin
SetSaveDialog();
if frmMain.dlgSave.Execute=true then
  begin
  res:=Write(frmMain.dlgSave.FileName);
  if (opOpenAfterSave in infSettings.options) then
    begin
    if res=1 then
      begin
      tmp:=frmMain.dlgSave.FileName;
      CloseImage();
      Load(tmp);
      end;
    end
  else
    FillImage(infImage.path,infImage.file_type,infImage.image_type);
  end;
end;

// closes file
procedure CloseImage(turn_off_ui: boolean = true);
begin
// cleaning undo
if (infImage.undo_bitmap <> nil) then
    FreeAndNil(infImage.undo_bitmap);

// specific things
case infImage.image_type of
  itNone: FillImage('',ftNone,itNone);
  itNormal: FillImage('',ftNone,itNone);
  itAnimated: CloseAnim();
  itMulti: CloseMulti();
  end;

// nullifying
infImage.original.Assign(infImage.null_bitmap);
frmMain.imgMain.Picture.Bitmap.Assign(infImage.null_bitmap);
frmMain.imgMain.Height:=0;
frmMain.imgMain.Width:=0;
ResetImageScroll();
if turn_off_ui then
  Able(false);
end;

// loads file from given path
procedure Load(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
begin
// start
case FileType(path) of
  1: begin
    CloseImage(false);
    OpenLocal(path, add_to_mru, same_folder);
    end;
  3: begin
    CloseImage(false);
    OpenAnim(path, add_to_mru, same_folder);
    end;
  4: begin
    CloseImage(false);
    OpenMulti(path, add_to_mru, same_folder);
    end;
  5: begin
    CloseImage();
    Report('File does not exist!');
    end;
  else CloseImage();
  end;
end;

// actually loads image
function DoImageLoad(path: string):hBitmap;
var
  FIPISopen: TFIPISopen;
  bmp: hBitmap;
  lib: THandle;
  ext, lib_path: string;
begin
if not FileExists(path) then
  begin
  FileNotFound(path);
  Abort();
  end;
ext:=GetExt(path);
reg.OpenKey(sModules + '\Open',true);
lib_path:=GetAppFolder() + 'plugins\' + reg.RStr(ext,'');
reg.CloseKey();

// main stuff
Result:=0;
if lib_path<>'' then
  begin
  lib:=LoadLibrary(PChar(lib_path));
  if lib<>0 then
    begin
    @FIPISopen:=GetProcAddress(lib,'FIPISopen');
    if not (@FIPISopen=nil) then
      begin
      bmp:=FIPISopen(PChar(path),PChar(ext),Application.Handle);
      if bmp<>0 then
        begin
        //Success!!!
        Result:=bmp;
        end
      else
        FileNotFound(path);
      end;
    FreeLibrary(lib);
    end;
  end;
end;

// saves file
function Write(path: string):integer;
var
  FIPISsave: TFIPISsave;
  lib: THandle;
  ext, lib_path: string;
  res: integer;
begin
// start
ext:=ExtractFileExt(path);
ext:=LowerCase(ext);
Result:=0;
Delete(ext,1,1);
reg.OpenKey(sModules + '\Save',true);
lib_path:=GetAppFolder() + 'plugins\' + reg.RStr(ext,'');
reg.CloseKey();

// main stuff
if lib_path<>'' then
  begin
  lib:=LoadLibrary(PChar(lib_path));
  if lib<>0 then
    begin
    @FIPISsave:=GetProcAddress(lib,'FIPISsave');
    if not (@FIPISsave=nil) then
      begin
      res:=FIPISsave(PChar(path),PChar(ext),Application.Handle,frmMain.Handle,frmMain.imgMain.Picture.Bitmap.Handle);
      if res<>0 then
        infImage.modified:=false;
      Result:=res;
      end
    else
      Report('FIPISsave function not found!');
    end
  else
    Report('DLL Library (FIPISsave) load error!');
  FreeLibrary(lib);
  end;
end;

// opens local file
procedure OpenLocal(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
var
  bmp: hBitmap;
begin
bmp:=DoImageLoad(path);
if bmp<>0 then
  begin
  // loading
  if (opZoomOnLoad in infSettings.options) then FillBitmap(nil,false,bmp)
    else FillBitmap(nil,true,bmp);
  FillImage(path,ftLocal,itNormal);
  Able(true);
  if add_to_mru then
    frmMain.MRU.Add(path);
    if not same_folder then
      ScanFolder(path)
    else
      FindFileNumber();
    if (opZoomOnLoad in infSettings.options) then ZoomToFit();
    if ((opFSCenter in infSettings.options) and infSettings.full_screen) then
      Center();
    end;
end;

// opens untitled bitmap
procedure OpenUntitled(bmp: TBitmap; img: hBitmap = 0; synch: boolean = true);
begin
CloseImage(false);
if img<>0 then
  begin
  // loading from hBitmap
  FillBitmap(nil,synch,img);
  FillImage('',ftUnsaved,itNormal);
  Able(true);
  if ((opFSCenter in infSettings.options) and infSettings.full_screen) then
    Center();
  end
else
  begin
  // loading from TBitmap
  if bmp<>nil then
    begin
    FillBitmap(bmp,synch);
    FillImage('',ftUnsaved,itNormal);
    Able(true);
    if ((opFSCenter in infSettings.options) and infSettings.full_screen) then
      Center();
    end
  else
    Report('nil TBitmap discovered in OpenUntitled() !',0);
  end;
end;

// finds out if supported by FIPISopen
function SupportedExt(ext: string):boolean;
begin
reg.OpenKey(sModules + '\Open',true);
if reg.RStr(ext,'')<>'' then
  Result:=true
else
  Result:=false;
reg.CloseKey();
end;

// finds out file type
function FileType(path: string):integer;
begin
Result:=0;                                                // not supported
if IsAnimation(GetExt(path)) then Result:=3               // animation
  else if IsMulti(GetExt(path)) then Result:=4            // multi-page
    else if SupportedExt(GetExt(path)) then Result:=1     // normal
      else if not FileExists(path) then Result:=5;        // not exists
end;

// finds out file type
function IsSupported(filename: string):boolean;
begin
Result:=false;

case FileType(filename) of
  1, 3, 4: Result:=true;
  end;
end;

// returns file type string or ''
function GetTypeString(ext: string; default: string = ''):string;
begin
reg.OpenKey(sModules + '\Descr',true);
Result:=reg.RStr(ext,default);
reg.CloseKey();
end;

end.
