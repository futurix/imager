unit f_tools;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms, ShellAPI,
  ShlObj, Printers, c_const, c_utils, c_reg, c_locales;

procedure Uninstall();
procedure UpdateAssociations();
procedure WriteHandler();
function  IsMemberOfGroup(const DomainAliasRid: DWORD): boolean;
function  IsStrongUser(): boolean;


implementation

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
			nreg.WString('', Slash(ExtractFilePath(Application.ExeName)) + FN_APP + ',' + IntToStr(icon_num));

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
  				nreg.WString('', '"' + Slash(ExtractFilePath(Application.ExeName)) + FN_APP + '" "%1"')
			else
  				nreg.WString('', '"' + Slash(ExtractFilePath(Application.ExeName)) + FN_APP + '" "%1" /fs');

			nreg.CloseKey();
        	end;
    	end;

    FreeAndNil(nreg);
end;

function IsMemberOfGroup(const DomainAliasRid: DWORD): boolean;
const
	SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority =
		(Value: (0, 0, 0, 0, 0, 5));
	SECURITY_BUILTIN_DOMAIN_RID = $00000020;
	SE_GROUP_ENABLED = $00000004;
	SE_GROUP_USE_FOR_DENY_ONLY = $00000010;
var
	Sid: PSID;
	CheckTokenMembership: function(TokenHandle: THandle; SidToCheck: PSID; var IsMember: BOOL): BOOL; stdcall;
	IsMember: BOOL;
	Token: THandle;
	GroupInfoSize: DWORD;
	GroupInfo: PTokenGroups;
	i: integer;
begin
	if (Win32Platform <> VER_PLATFORM_WIN32_NT) then
    	begin
		Result := True;
		Exit;
		end;

	Result := false;

	if not AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,
		SECURITY_BUILTIN_DOMAIN_RID, DomainAliasRid, 0, 0, 0, 0, 0, 0, Sid) then
		Exit;

	try
		CheckTokenMembership := nil;

		if (Lo(GetVersion) >= 5) then
      		CheckTokenMembership := GetProcAddress(GetModuleHandle(advapi32), 'CheckTokenMembership');
		if Assigned(CheckTokenMembership) then
        	begin
			if CheckTokenMembership(0, Sid, IsMember) then
			Result := IsMember;
			end
		else
        	begin
			GroupInfo := nil;
			if not OpenThreadToken(GetCurrentThread, TOKEN_QUERY, True, Token) then
            	begin
				if (GetLastError <> ERROR_NO_TOKEN) then
					Exit;

				if not OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, Token) then
					Exit;
				end;

			try
				GroupInfoSize := 0;

				if not GetTokenInformation(Token, TokenGroups, nil, 0, GroupInfoSize) and
					(GetLastError <> ERROR_INSUFFICIENT_BUFFER) then
					Exit;

				GetMem(GroupInfo, GroupInfoSize);
				if not GetTokenInformation(Token, TokenGroups, GroupInfo, GroupInfoSize, GroupInfoSize) then
					Exit;

				for i := 0 to (GroupInfo.GroupCount - 1) do
                	begin
					if EqualSid(Sid, GroupInfo.Groups[i].Sid) and (GroupInfo.Groups[i].Attributes and (SE_GROUP_ENABLED or
						SE_GROUP_USE_FOR_DENY_ONLY) = SE_GROUP_ENABLED) then
                        begin
						Result := true;
						Break;
						end;
					end;

            finally
				FreeMem(GroupInfo);
				CloseHandle(Token);
			end;
		end;

	finally
		FreeSid(Sid);
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
