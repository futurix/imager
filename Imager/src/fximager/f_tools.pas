// tool routines
unit f_tools;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms, ShellAPI,
  ShlObj, Printers, c_const, c_utils, c_reg, c_locales;

const
    VK_XBUTTON1			= 5;
    VK_XBUTTON2			= 6;
	VK_BROWSER_BACK 	= 166;
	VK_BROWSER_FORWARD 	= 167;
	VK_BROWSER_REFRESH 	= 168;
	VK_BROWSER_STOP 	= 169;

procedure CommandLine();
procedure Uninstall();
procedure FileNotFound(path: string);
procedure OpenURL(url: string);
procedure UpdateAssociations();
procedure WriteHandler();
procedure PutRegDock();
function  IsShift(): boolean;
function  IsCtrl(): boolean;


implementation

uses main, w_show, f_graphics, f_ui, f_nav, f_filectrl, w_preview;

// reads command line
procedure CommandLine();
var
    fs: boolean;
    filename: string;
begin
    fs := false;
    filename := '';

    // parsing full screen
    if (ParamCount() > 0) then
    	begin
        if ((ParamStr(1) = '/fs') or (ParamStr(1) = '-fs') or (ParamStr(1) = '--fs')) then
        	fs := true;

    	if (ParamCount() > 1) then
    		begin
        	if ((ParamStr(2) = '/fs') or (ParamStr(2) = '-fs') or (ParamStr(2) = '--fs')) then
        		fs := true;
        	end;
        end;

    // parsing filename
    if (ParamCount() > 0) then
    	begin
        if FileExists(ParamStr(1)) then
        	filename := ParamStr(1);

    	if (ParamCount() > 1) then
    		begin
        	if FileExists(ParamStr(2)) then
        		filename := ParamStr(2);
        	end;
        end;

    // applying
    if (fs and (not frmMain.full_screen)) then
    	ToggleFS();

    if (filename <> '') then
    	Load(filename);
end;

// removes all registry associations
procedure Uninstall();
var
	lreg: TFRegistry;
    exts: TStringList;
    i: integer;
    tmp: string;
begin
    lreg := TFRegistry.Create();
    lreg.RootKey := HKEY_CURRENT_USER;

    exts := TStringList.Create();

	lreg.OpenKey(sModules + '\' + PS_FOPEN, true);
	lreg.GetValueNames(exts);
	lreg.CloseKey();

    exts.Sort();

	for i := 0 to (exts.Count - 1) do
    	begin
        lreg.RootKey := HKEY_CLASSES_ROOT;

		lreg.OpenKey('\.' + exts[i], true);

  		if lreg.RStr('', '') = sRegAssociation then
    		begin
			if lreg.ValueExists(sRegAssociationOld) then
      			begin
      			tmp := lreg.RStr(sRegAssociationOld, '');
      			lreg.WriteString('', tmp);
      			lreg.DeleteValue(sRegAssociationOld);
      			end
    		else
                lreg.DeleteValue('');
    		end
  		else
    		if lreg.ValueExists(sRegAssociationOld) then
      			lreg.DeleteValue(sRegAssociationOld);

		lreg.CloseKey();

        // XP/2003 support
		if IsXP() then
  			begin
  			lreg.RootKey := HKEY_CURRENT_USER;

  			lreg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' + exts[i], true);

  			if lreg.RStr('ProgID', '') = sRegAssociation then
    			begin
    			if lreg.ValueExists(sRegAssociationOld) then
      				begin
      				tmp := lreg.RStr(sRegAssociationOld, '');
      				lreg.WString('ProgID', tmp);
      				lreg.DeleteValue(sRegAssociationOld);
      				end
    			else
      				lreg.DeleteValue('ProgID');
    			end
  			else
    			if lreg.ValueExists(sRegAssociationOld) then
      				lreg.DeleteValue(sRegAssociationOld);

  			lreg.CloseKey();
  			end;

  		lreg.RootKey:=HKEY_CURRENT_USER;
        end;

    FreeAndNil(exts);
    FreeAndNil(lreg);
end;

procedure FileNotFound(path: string);
begin
	if (frmMain.MRU.Files.IndexOf(path) <> -1) then
  		begin
  		frmMain.MRU.Files.Delete(frmMain.MRU.Files.IndexOf(path));

  		if (infImage.filenum > -1) then
    		Dec(infImage.filenum);
  		end;

	if (files.IndexOf(path) <> -1) then
  		begin
  		files.Delete(files.IndexOf(path));

  		if (infImage.filenum > -1) then
    		Dec(infImage.filenum);

  		if (files.Count > 0) then
    		GoNext();
  		end;
end;

procedure OpenURL(url: string);
begin
	ShellExecute(Application.Handle, 'open', PChar(url), nil, nil, SW_SHOWNORMAL);
end;

procedure UpdateAssociations();
begin
	SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

procedure WriteHandler();
var
	icon_num: integer;
	description: string;
	fs: boolean;
begin
	// preparing
	reg.OpenKey(sSettings, true);
	icon_num := reg.RInt('Formats_Icon', 1);
	description := reg.RStr('Formats_Description', Format(LoadLStr(640), [sAppName]));

	if description = 'Image file' then
  		description := Format(LoadLStr(640), [sAppName]); // fix for ugly name
	fs := reg.RBool('Formats_FullScreen', false);
	reg.CloseKey();

	// doing stuff
	reg.RootKey := HKEY_CLASSES_ROOT;

	reg.OpenKey('\' + sRegAssociation, true);
	reg.WriteString('', description);
	reg.OpenKey('\' + sRegAssociation + '\DefaultIcon', true);
	reg.WriteString('', path_app + FN_APP + ',' + IntToStr(icon_num));
	reg.OpenKey('\' + sRegAssociation + '\Shell\Open', true);
	reg.WriteString('', LoadLStr(641));
	reg.OpenKey('\' + sRegAssociation + '\Shell\Open\Command', true);
	if not fs then
  		reg.WriteString('', '"' + Application.ExeName + '" "%1"')
	else
  		reg.WriteString('', '"' + Application.ExeName + '" "%1" /fs');
	reg.CloseKey();

	reg.RootKey := HKEY_CURRENT_USER;
end;

procedure PutRegDock();
begin
	reg.OpenKey(sReg, true);
	reg.WriteString(sRegAssociation, Application.ExeName);
	reg.WriteString('InstallationPath', path_app);
	reg.CloseKey();
end;

function IsShift(): boolean;
begin
	Result := (HiWord(GetKeyState(VK_SHIFT)) <> 0);
end;

function IsCtrl(): boolean;
begin
	Result := (HiWord(GetKeyState(VK_CONTROL)) <> 0);
end;

end.
