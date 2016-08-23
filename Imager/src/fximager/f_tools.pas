unit f_tools;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms, ShellAPI,
  ShlObj, Printers, h_chm, h_nt, c_const, c_utils, c_reg, c_locales;

procedure CommandLine();
procedure Uninstall();
procedure FileNotFound(path: string);
procedure OpenHelp(page: WideString);
procedure OpenURL(url: WideString);
procedure UpdateAssociations();
procedure WriteHandler();
procedure PutRegDock();
function  IsShift(): boolean;
function  IsCtrl(): boolean;
function  IsMemberOfGroup(const DomainAliasRid: DWORD): boolean;
function  IsStrongUser(): boolean;


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
	rreg, wreg: TFRegistry;
    exts: TStringList;
    i: integer;
    tmp: string;
begin
    rreg := TFRegistry.Create(RA_READONLY);
    rreg.RootKey := HKEY_CURRENT_USER;

    exts := TStringList.Create();

	if rreg.OpenKey(sModules + '\' + PS_FOPEN, false) then
    	begin
		rreg.GetValueNames(exts);

		rreg.CloseKey();
        end;

    exts.Sort();
    
    FreeAndNil(rreg);

	for i := 0 to (exts.Count - 1) do
    	begin
        wreg := TFRegistry.Create(RA_FULL);
        wreg.RootKey := HKEY_CLASSES_ROOT;

		if wreg.OpenKey('\.' + exts[i], false) then
        	begin
  			if wreg.RStr('', '') = sRegAssociation then
    			begin
				if wreg.ValueExists(sRegAssociationOld) then
      				begin
      				tmp := wreg.RStr(sRegAssociationOld, '');
      				wreg.WString('', tmp);
      				wreg.DeleteValue(sRegAssociationOld);
      				end
    			else
                	wreg.DeleteValue('');
    			end
  			else
    			if wreg.ValueExists(sRegAssociationOld) then
      				wreg.DeleteValue(sRegAssociationOld);

			wreg.CloseKey();
        	end;

  		FreeAndNil(wreg);
        end;

    FreeAndNil(exts);
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

procedure OpenHelp(page: WideString);
begin
    HtmlHelpW(GetDesktopWindow(), PWideChar(WideString(path_app + FN_HELP + '::/') + page), HH_DISPLAY_TOPIC, 0);
end;

procedure OpenURL(url: WideString);
begin
    ShellExecuteW(Application.Handle, 'open', PWideChar(url), nil, nil, SW_SHOWNORMAL);
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
	nreg: TFRegistry;
begin
	// preparing
    icon_num := FxRegRInt('Formats_Icon', 1);
    description := FxRegRStr('Formats_Description', Format(LoadLStr(640), [sAppName]));
	fs := FxRegRBool('Formats_FullScreen', false);

	// doing stuff
	nreg := TFRegistry.Create(RA_FULL);
	nreg.RootKey := HKEY_CLASSES_ROOT;

	if nreg.OpenKey('\' + sRegAssociation, true) then
    	begin
		nreg.WString('', description);

        nreg.CloseKey();

        if nreg.OpenKey('\' + sRegAssociation + '\DefaultIcon', true) then
        	begin
			nreg.WString('', path_app + FN_APP + ',' + IntToStr(icon_num));

            nreg.CloseKey();
            end;

		if nreg.OpenKey('\' + sRegAssociation + '\Shell\Open', true) then
            begin
			nreg.WString('', LoadLStr(641));

            nreg.CloseKey();
            end;

		if nreg.OpenKey('\' + sRegAssociation + '\Shell\Open\Command', true) then
        	begin
			if not fs then
  				nreg.WString('', '"' + Application.ExeName + '" "%1"')
			else
  				nreg.WString('', '"' + Application.ExeName + '" "%1" /fs');

			nreg.CloseKey();
        	end;
    	end;

    FreeAndNil(nreg);
end;

procedure PutRegDock();
begin
    FxRegWStr(sAppName, Application.ExeName, sReg);
    FxRegWStr('InstallationPath', path_app, sReg);
end;

function IsShift(): boolean;
begin
	Result := (HiWord(GetKeyState(VK_SHIFT)) <> 0);
end;

function IsCtrl(): boolean;
begin
	Result := (HiWord(GetKeyState(VK_CONTROL)) <> 0);
end;

function IsMemberOfGroup(const DomainAliasRid: DWORD): boolean;
const
	SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority =
    	(Value: (0, 0, 0, 0, 0, 5));
	SECURITY_BUILTIN_DOMAIN_RID = $00000020;
var
	sid: PSID;
	IsMember: BOOL;
begin
	if Win32Platform <> VER_PLATFORM_WIN32_NT then
    	begin
    	Result := true;
    	Exit;
  		end;

	Result := false;

	if not AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,
    	SECURITY_BUILTIN_DOMAIN_RID, DomainAliasRid,
    	0, 0, 0, 0, 0, 0, sid) then
    	Exit;

	try
		if CheckTokenMembership(0, sid, IsMember) then
			Result := IsMember;

  		finally
    		FreeSid(sid);
  		end;
end;

function IsStrongUser(): boolean;
const
	DOMAIN_ALIAS_RID_ADMINS = $00000220;
    DOMAIN_ALIAS_RID_POWER_USERS = $00000223;
begin
	Result := (IsMemberOfGroup(DOMAIN_ALIAS_RID_ADMINS) or IsMemberOfGroup(DOMAIN_ALIAS_RID_POWER_USERS));
end;

end.
