unit fx_formats_legacy;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms, ShellAPI,
  ShlObj,
  c_const, c_utils, c_reg, c_str;

procedure UpdateAssociations();
procedure WriteHandlers();
procedure WriteHandlerExt(ext, description, icon, app_path: string; fs: boolean = false);
procedure RemoveHanderExt(ext: string);
function GetExt(ext: string): boolean;
procedure SetExt(ext: string);
procedure UnsetExt(ext: string);


implementation

uses w_main;

procedure UpdateAssociations();
begin
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

procedure WriteHandlers();
const
  defIconNumber: integer = 1;
var
  reg: TFRegistry;
  description, app_path, temp, t_descr, t_icon: string;
  def_descr, full_screen: boolean;
  exts, descr, icons, persist: TStringList;
begin
  // safety first
  if IsVista() then
    Exit();

  // initializing
  reg := TFRegistry.Create(RA_FULL);
  exts := TStringList.Create();
  descr := TStringList.Create();
  icons := TStringList.Create();
  persist := TStringList.Create();
  persist.Sorted := true;
  persist.CaseSensitive := false;
  persist.Duplicates := dupIgnore;

  // loading settings
  description := FxRegRStr('Formats_Description', Format(FXL_REG_FF_DESCRIPTION, [sAppName]));
  def_descr := FxRegRBool('Formats_DefaultDescriptionOnly', false);
  full_screen := FxRegRBool('Formats_FullScreen', false);
  app_path := Slash(ExtractFilePath(GetModuleLocation(HInstance)));

  // reading supported formats + rare formats + descriptions + icons + PEL
  reg.RootKey := HKEY_CURRENT_USER;

  if reg.OpenKey(sModules + '\' + PS_FOPEN, false) then
    begin
    reg.GetValueNames(exts);
    reg.CloseKey();
    end;

  if reg.OpenKey(sModules + '\' + PS_FDESCR, false) then
    begin
    reg.ReadKeysAndValues(descr);
    reg.CloseKey();
    end;

  if reg.OpenKey(sFormatIcons, false) then
    begin
    reg.ReadKeysAndValues(icons);
    reg.CloseKey();
    end;

  if reg.OpenKey(sPersistentSettings, false) then
    begin
    reg.RStrings(sPersistentExts, persist);
    reg.CloseKey();
    end;

  persist.AddStrings(exts);

  if reg.OpenKey(sPersistentSettings, true) then
    begin
    reg.WStrings(sPersistentExts, persist);
    reg.CloseKey();
    end;

  // writing extension-specific handlers
  for temp in persist do
    begin
    t_descr := description;
    if ((not def_descr) and (descr.IndexOfName(temp) <> -1) and (Trim(descr.Values[temp]) <> '')) then
      t_descr := descr.Values[temp];

    if ((icons.IndexOfName(temp) <> -1) and (Trim(icons.Values[temp]) <> '')) then
      t_icon := icons.Values[temp]
    else if ((icons.IndexOfName('') <> -1) and (Trim(icons.Values['']) <> '')) then
      t_icon := icons.Values['']
    else
      t_icon := app_path + FXFILE_APP + ',' + IntToStr(defIconNumber);

    WriteHandlerExt(temp, t_descr, t_icon, app_path, full_screen);
    end;

  // writing default handler
  if ((icons.IndexOfName('') <> -1) and (Trim(icons.Values['']) <> '')) then
    t_icon := icons.Values['']
  else
    t_icon := app_path + FXFILE_APP + ',' + IntToStr(defIconNumber);

  WriteHandlerExt('', description, t_icon, app_path, full_screen);

  // clean-up
  FreeAndNil(persist);
  FreeAndNil(icons);
  FreeAndNil(descr);
  FreeAndNil(exts);
  FreeAndNil(reg);
end;

procedure WriteHandlerExt(ext, description, icon, app_path: string; fs: boolean);
var
  reg: TFRegistry;
  ass: string;
  access: cardinal;
begin
  // safety first
  if IsVista() then
    Exit();

  // need to disable registry redirection on Win64
  if IsWin64() then
    access := RA_FULL or KEY_WOW64_64KEY
  else
    access := RA_FULL;

  // working
  reg := TFRegistry.Create(access);
  reg.RootKey := HKEY_CURRENT_USER;

  if (ext <> '') then
    ass := sRegAssociation + '.' + LowerCase(ext)
  else
    ass := sRegAssociation;

  if reg.OpenKey('SOFTWARE\Classes\' + ass, true) then
    begin
    reg.WString('', description);
    reg.CloseKey();

    if reg.OpenKey('SOFTWARE\Classes\' + ass + '\DefaultIcon', true) then
      begin
      reg.WString('', icon);
      reg.CloseKey();
      end;

    if reg.OpenKey('SOFTWARE\Classes\' + ass + '\Shell\Open', true) then
      begin
      reg.WString('', FXL_REG_FF_ACTION_OPEN);
      reg.CloseKey();
      end;

    if reg.OpenKey('SOFTWARE\Classes\' + ass + '\Shell\Open\Command', true) then
      begin
      if not fs then
        reg.WString('', '"' + app_path + FXFILE_APP + '" "%1"')
      else
        reg.WString('', '"' + app_path + FXFILE_APP + '" "%1" /fs');

      reg.CloseKey();
      end;
    end;

  FreeAndNil(reg);
end;

procedure RemoveHanderExt(ext: string);
var
  ass: string;
begin
  if (ext <> '') then
    ass := sRegAssociation + '.' + LowerCase(ext)
  else
    ass := sRegAssociation;

  if IsWin64() then
    RegDeleteKeyIncludingSubkeys_WOW64(HKEY_CURRENT_USER, PWideChar('SOFTWARE\Classes\' + ass))
  else
    RegDeleteKeyIncludingSubkeys(HKEY_CURRENT_USER, PWideChar('SOFTWARE\Classes\' + ass));
end;

function GetExt(ext: string): boolean;
var
  freg: TFRegistry;
  hdl: string;
  access: cardinal;
begin
  Result := false;

  // need to disable registry redirection on Win64
  if IsWin64() then
    access := RA_READONLY or KEY_WOW64_64KEY
  else
    access := RA_READONLY;

  freg := TFRegistry.Create(access);
  freg.RootKey := HKEY_CURRENT_USER;

  if freg.OpenKey('SOFTWARE\Classes\.' + ext, false) then
    begin
    hdl := freg.ReadString('');
    Result := ((hdl = sRegAssociation) or (hdl = (sRegAssociation + '.' + LowerCase(ext))));

    freg.CloseKey();
    end;

  FreeAndNil(freg);
end;

procedure SetExt(ext: string);
var
  freg: TFRegistry;
  tmp: string;
  access: cardinal;
begin
  // need to disable registry redirection on Win64
  if IsWin64() then
    access := RA_FULL or KEY_WOW64_64KEY
  else
    access := RA_FULL;

  freg := TFRegistry.Create(access);
  freg.RootKey := HKEY_CURRENT_USER;

  if freg.OpenKey('SOFTWARE\Classes\.' + ext, true) then
    begin
    tmp := freg.RStr('', '');

    if ((tmp <> '') and (tmp <> sRegAssociation) and (tmp <> (sRegAssociation + '.' + LowerCase(ext)))) then
      freg.WriteString(sRegAssociationOld, tmp);

    freg.WriteString('', sRegAssociation + '.' + LowerCase(ext));
    freg.CloseKey();
    end;

  FreeAndNil(freg);
end;

procedure UnsetExt(ext: string);
var
  freg: TFRegistry;
  tmp, hdl: string;
  access: cardinal;
begin
  // need to disable registry redirection on Win64
  if IsWin64() then
    access := RA_FULL or KEY_WOW64_64KEY
  else
    access := RA_FULL;

  freg := TFRegistry.Create(access);
  freg.RootKey := HKEY_CURRENT_USER;

  if freg.OpenKey('SOFTWARE\Classes\.' + ext, false) then
    begin
    hdl := freg.RStr('', '');

    if ((hdl = sRegAssociation) or (hdl = (sRegAssociation + '.' + LowerCase(ext)))) then
      begin
      if freg.ValueExists(sRegAssociationOld) then
        begin
        tmp := freg.RStr(sRegAssociationOld, '');
        freg.WriteString('', tmp);
        freg.DeleteValue(sRegAssociationOld);
        end
      else
        freg.WriteString('', '');
      end
    else
      if freg.ValueExists(sRegAssociationOld) then
        freg.DeleteValue(sRegAssociationOld);

    freg.CloseKey();
    end;

  FreeAndNil(freg);
end;

end.
