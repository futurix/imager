// global variables manipulation
unit f_global;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms, IniFiles, futuris_resample;

procedure StartUpChecks();
procedure ReadSettings();
procedure SaveSettings();
procedure IMGtune();
procedure FreeGlobals();

implementation

uses globals, f_strutils, f_debug, f_ui, f_reg, f_tools, main, rsthread;

// sets ini files for Futuris Imager
procedure StartUpChecks();
begin
// main check
if not reg.KeyExists(sFIPIS) then PlugScan();
// writing paths
PutRegDock();
end;

procedure ReadSettings();
var
   tmp: integer;
begin
// History
frmMain.MRU.LoadFromRegistry(sReg + '\History');
// other stuff
reg.OpenKey(sFIPIS,true);
infSettings.quick_mask:=RegReadStr('BrowsingMask','*.*');
reg.CloseKey();
reg.OpenKey(sReg + '\Main',true);
frmMain.sbxMain.Color:=StringToColor(RegReadStr('Color','clAppWorkSpace'));
tmp:=RegReadInt('ZoomFilter',0);
if ((tmp<7)and(tmp>=0)) then begin
                             case tmp of
                                      0: frmMain.miZMBoxClick(frmMain);
                                      1: frmMain.miZMTriangleClick(frmMain);
                                      2: frmMain.miZMHermiteClick(frmMain);
                                      3: frmMain.miZMBellClick(frmMain);
                                      4: frmMain.miZMSplineClick(frmMain);
                                      5: frmMain.miZMLanczos3Click(frmMain);
                                      6: frmMain.miZMMitchellClick(frmMain);
                             end;
                             end
else frmMain.miZMBoxClick(frmMain);
if RegReadInt('AutoApply',1)=1 then Include(infSettings.options,opAutoApply)
   else Exclude(infSettings.options,opAutoApply);
if RegReadInt('ZoomOnLoad',0)=1 then begin
                                     Include(infSettings.options,opZoomOnLoad);
                                     frmMain.miZoomTFoL.Checked:=true;
                                     end
else begin
     Exclude(infSettings.options,opZoomOnLoad);
     frmMain.miZoomTFoL.Checked:=false;
     end;
if RegReadInt('OpenAfterSave',1)=1 then Include(infSettings.options,opOpenAfterSave)
   else Exclude(infSettings.options,opOpenAfterSave);
if RegReadInt('DelTemp',0)=1 then Include(infSettings.options,opDelTempFiles) else Exclude(infSettings.options,opDelTempFiles);
if RegReadInt('Hints',1)=1 then Application.ShowHint:=true else Application.ShowHint:=false;
if RegReadInt('FSCenter',1)=1 then Include(infSettings.options,opFSCenter) else Exclude(infSettings.options,opFSCenter);
if RegReadInt('OpenDef',1)=1 then Include(infSettings.options,opOpenDef) else Exclude(infSettings.options,opFSCenter);
reg.CloseKey();
reg.OpenKey(sReg + '\UI',true);
if RegReadInt('TBMain',1)=1 then ToggleMainToolbar(true,true) else ToggleMainToolbar(true,false);
if RegReadInt('TBStatus',1)=1 then ToggleStatusbar(true,true) else ToggleStatusbar(true,false);
if RegReadInt('FullPathInTitle',0)=1 then Include(infSettings.options,opFullPathInTitle) else Exclude(infSettings.options,opFullPathInTitle);
if RegReadInt('Handy',1)=1 then infMouse.handy:=true else infMouse.handy:=false;
reg.CloseKey();
reg.OpenKey(sReg + '\Web',true);
infSettings.uagent:=RegReadStr('UA','FuturisImagerC');
infSettings.appHome:=RegReadStr('Ref','');
reg.CloseKey();
Screen.Cursors[7]:=LoadCursor(hInstance,'HAND');
if infMouse.handy then frmMain.imgMain.Cursor:=7 else frmMain.imgMain.Cursor:=0;
end;

// saves settings to ini
procedure SaveSettings();
begin
reg.OpenKey(sReg + '\UI',true);
if infSettings.full_screen=false then begin
                                      if frmMain.tbrMain.Visible then reg.WriteInteger('TBMain',1) else reg.WriteInteger('TBMain',0);
                                      if frmMain.sbrMain.Visible then reg.WriteInteger('TBStatus',1) else reg.WriteInteger('TBStatus',0);
                                      end;
reg.CloseKey();
reg.OpenKey(sFIPIS,true);
reg.WriteString('BrowsingMask',infSettings.quick_mask);
reg.CloseKey();
reg.OpenKey(sReg + '\Main',true);
if (opZoomOnLoad in infSettings.options) then reg.WriteInteger('ZoomOnLoad',1)
   else reg.WriteInteger('ZoomOnLoad',0);
case th_filter of
               sfBox: reg.WriteInteger('ZoomFilter',0);
               sfTriangle: reg.WriteInteger('ZoomFilter',1);
               sfHermite: reg.WriteInteger('ZoomFilter',2);
               sfBell: reg.WriteInteger('ZoomFilter',3);
               sfSpline: reg.WriteInteger('ZoomFilter',4);
               sfLanczos3: reg.WriteInteger('ZoomFilter',5);
               sfMitchell: reg.WriteInteger('ZoomFilter',6);
               end;
reg.CloseKey();
frmMain.MRU.SaveToRegistry(sReg + '\History');
end;

// tunes bitmaps
procedure IMGtune();
begin
infImage.original:=TBitmap.Create();
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
