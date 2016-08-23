// global variables manipulation
unit f_global;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms, IniFiles,
  c_const;

procedure StartUpChecks();
procedure ReadSettings();
procedure SaveSettings();
procedure IMGtune();
procedure FreeGlobals();

implementation

uses globals, f_strutils, f_debug, f_ui, f_reg, f_tools, main;

// sets ini files for Futuris Imager
procedure StartUpChecks();
begin
// main check
if not reg.KeyExists(sModules) then
  PlugScan();

// writing paths
PutRegDock();
end;

procedure ReadSettings();
begin
// history
frmMain.MRU.LoadFromRegistry(sReg + '\History');

// other stuff
reg.OpenKey(sReg + '\Main',true);
frmMain.sbxMain.Color:=StringToColor(reg.RStr('Color','clAppWorkSpace'));
if reg.RInt('ZoomOnLoad',0)=1 then
  begin
  Include(infSettings.options,opZoomOnLoad);
  frmMain.miZoomTFoL.Checked:=true;
  end
else
  begin
  Exclude(infSettings.options,opZoomOnLoad);
  frmMain.miZoomTFoL.Checked:=false;
  end;

if reg.RIntC('OpenAfterSave',1)=1 then Include(infSettings.options,opOpenAfterSave)
   else Exclude(infSettings.options,opOpenAfterSave);

if reg.RIntC('FSCenter',1)=1 then Include(infSettings.options,opFSCenter)
  else Exclude(infSettings.options,opFSCenter);
if reg.RIntC('OpenDef',1)=1 then Include(infSettings.options,opOpenDef)
  else Exclude(infSettings.options,opFSCenter);
reg.CloseKey();

reg.OpenKey(sReg + '\UI',true);
if reg.RIntC('TBStyle',0)=1 then ApplyToolbarSkin(true)
  else ApplyToolbarSkin(false);
if reg.RIntC('TBMain',1)=1 then ToggleMainToolbar(true,true)
  else ToggleMainToolbar(true,false);
if reg.RIntC('TBStatus',1)=1 then ToggleStatusbar(true,true)
  else ToggleStatusbar(true,false);
if reg.RIntC('FullPathInTitle',0)=1 then Include(infSettings.options,opFullPathInTitle)
  else Exclude(infSettings.options,opFullPathInTitle);
if reg.RIntC('Handy',1)=1 then infMouse.handy:=true
  else infMouse.handy:=false;
reg.CloseKey();

Screen.Cursors[7]:=LoadCursor(hInstance,'HAND');

if infMouse.handy then frmMain.imgMain.Cursor:=7
  else frmMain.imgMain.Cursor:=0;
end;

// saves settings to ini
procedure SaveSettings();
begin
reg.OpenKey(sReg + '\UI',true);
if infSettings.full_screen=false then
  begin
  if frmMain.tbrMain.Visible then reg.WriteInteger('TBMain',1)
    else reg.WriteInteger('TBMain',0);
  if frmMain.sbrMain.Visible then reg.WriteInteger('TBStatus',1)
    else reg.WriteInteger('TBStatus',0);
  end;
reg.CloseKey();

reg.OpenKey(sReg + '\Main',true);
if (opZoomOnLoad in infSettings.options) then reg.WriteInteger('ZoomOnLoad',1)
  else reg.WriteInteger('ZoomOnLoad',0);
reg.CloseKey();

frmMain.MRU.SaveToRegistry(sReg + '\History');
end;

// tunes bitmaps
procedure IMGtune();
begin
frmMain.imgMain.Picture.Bitmap.PixelFormat:=pf24bit;
infImage.original:=TBitmap.Create();
infImage.original.PixelFormat:=pf24bit;
infImage.null_bitmap:=TBitmap.Create();
end;

// frees all global resources
procedure FreeGlobals();
begin
// other freeings
files.Free();
infImage.original.Free();
infImage.null_bitmap.Free();
end;

end.
