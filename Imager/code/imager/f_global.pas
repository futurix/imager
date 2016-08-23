// global variables manipulation
unit f_global;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms, IniFiles,
  c_const, c_utils;

procedure StartUpChecks();
procedure ReadSettings();
procedure SaveSettings();
procedure FreeGlobals();


implementation

uses globals, f_ui, f_reg, f_tools, main, f_images;

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
	reg.OpenKey(sReg + '\Main', true);

	frmMain.sbxMain.Color := StringToColor(reg.RStr('Color', 'clAppWorkSpace'));
    frmMain.img.Background := frmMain.sbxMain.Color;

	if reg.RIntC('OpenAfterSave', 1) = 1 then Include(infSettings.options, opOpenAfterSave)
   		else Exclude(infSettings.options, opOpenAfterSave);

	if reg.RIntC('OpenDef', 1) = 1 then Include(infSettings.options, opOpenDef)
  		else Exclude(infSettings.options, opOpenDef);

	if reg.RBoolC('NoMRU', false) = true then Include(infSettings.options, opNoMRU)
  		else Exclude(infSettings.options, opNoMRU);

	reg.CloseKey();

	reg.OpenKey(sReg + '\UI', true);

    if (Screen.Width > 1024) then
    	begin
		if reg.RIntC('TBStyle', 1) = 1 then ApplyToolbarSkin(true)
  			else ApplyToolbarSkin(false);
        end
    else
    	begin
		if reg.RIntC('TBStyle', 0) = 1 then ApplyToolbarSkin(true)
  			else ApplyToolbarSkin(false);
        end;

	if reg.RIntC('TBMain', 1) = 1 then ToggleMainToolbar(true, true)
  		else ToggleMainToolbar(true, false);
	if reg.RIntC('TBStatus', 1) = 1 then ToggleStatusbar(true, true)
  		else ToggleStatusbar(true, false);
	if reg.RIntC('FullPathInTitle', 0) = 1 then Include(infSettings.options, opFullPathInTitle)
  		else Exclude(infSettings.options, opFullPathInTitle);

    case reg.RIntC('DispStyle', 1) of
    	0: SetDisplayStyle(dsNormal);
        1: SetDisplayStyle(dsFit);
		else
        	SetDisplayStyle(dsNormal);
    end;

    SetCenter(reg.RBoolC('DispCenter', true));
    SetScrollbars(reg.RBoolC('Scrollbars', true));

	reg.CloseKey();
end;

// saves settings to ini
procedure SaveSettings();
begin
	reg.OpenKey(sReg + '\UI',true);

	if infSettings.full_screen = false then
  		begin
  		if frmMain.tbrMain.Visible then reg.WriteInteger('TBMain', 1)
    		else reg.WriteInteger('TBMain', 0);
  		if frmMain.sbrMain.Visible then reg.WriteInteger('TBStatus', 1)
    		else reg.WriteInteger('TBStatus', 0);
  		end;

    case GetDisplayStyle() of
    	dsNormal: reg.WInteger('DispStyle', 0);
        dsFit: reg.WInteger('DispStyle', 1);
    end;

    reg.WBool('DispCenter', GetCenter());
    reg.WBool('Scrollbars', GetScrollbars());

	reg.CloseKey();

    if not (opNoMRU in infSettings.options) then
    	frmMain.MRU.SaveToRegistry(sReg + '\History');
end;

// frees all global resources
procedure FreeGlobals();
begin
	// other freeings
	FreeAndNil(files);
end;

end.
