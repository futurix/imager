unit fx_app;

interface

uses
  Windows, Messages, SysUtils, Classes, ShellAPI, ShlObj, ActiveX, ComObj,
  ShellObjects,
  c_const, c_utils, c_reg, c_locales, c_lang;

procedure Execute();
procedure Sync();
procedure Launch();
procedure CleanUp();
procedure WriteHandlerExt(ext, description, icon, app_path: string; fs: boolean = false);
procedure RemoveHanderExt(ext: string);


implementation

procedure Execute();
var
  param: string;
begin
  // this utility does not work with WindowsXP or older
  if not IsVista() then
    Exit();

  // initializing
  CoInitializeEx(nil, COINIT_APARTMENTTHREADED); // COM might not be initialized in command-line tools

  // saving the only command-line parameter
  param := ParamStr(1);

  // localization
  InitLocalization(LoadLibraryEx(PWideChar(Slash(ExtractFilePath(GetModuleLocation(HInstance))) + FXFILE_APP), 0, LOAD_LIBRARY_AS_DATAFILE));

  // working
  if ((param = '/sync') or (param = '-sync')) then
    begin
    CleanUp();
    Sync();
    end
  else if ((param = '/clean') or (param = '-clean')) then
    begin
    CleanUp();
    end
  else
    begin
    CleanUp();
    Sync();
    Launch();
    end;
end;

procedure Sync();
const
  defIconNumber: integer = 1;
var
  reg: TFRegistry;
  idx: integer;
  app_path, description, temp, t_descr, t_icon: string;
  def_descr, full_screen, use_rare: boolean;
  exts, rare, descr, icons, persist: TStringList;
begin
  reg := TFRegistry.Create(RA_FULL);
  exts := TStringList.Create();
  rare := TStringList.Create();
  descr := TStringList.Create();
  icons := TStringList.Create();
  persist := TStringList.Create();
  persist.Sorted := true;
  persist.CaseSensitive := false;
  persist.Duplicates := dupIgnore;

  // loading settings
  description := FxRegRStr('Formats_Description', Format(GetLString(FXL_REG_FF_DESCRIPTION), [sAppName]));
  def_descr := FxRegRBool('Formats_DefaultDescriptionOnly', false);
  full_screen := FxRegRBool('Formats_FullScreen', false);
  use_rare := FxRegRBool('Formats_IncludeRareFormats', false);
  app_path := Slash(ExtractFilePath(GetModuleLocation(HInstance)));

  // reading supported formats + rare formats + descriptions + icons + PEL
  reg.RootKey := HKEY_CURRENT_USER;

  if reg.OpenKey(sModules + '\' + PS_FOPEN, false) then
    begin
    reg.GetValueNames(exts);
    reg.CloseKey();
    end;

  if reg.OpenKey(sModules, false) then
    begin
    reg.RStrings(FX_REG_NOTREC, rare);
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

  // updating persistent list of all extensions ever used
  reg.RootKey := HKEY_LOCAL_MACHINE;

  if reg.OpenKeyMachine(sPersistentSettings) then
    begin
    reg.RStrings(sPersistentExts, persist);
    reg.CloseKey();
    end;

  persist.AddStrings(exts);

  if reg.OpenKeyMachine(sPersistentSettings) then
    begin
    reg.WStrings(sPersistentExts, persist);
    reg.CloseKey();
    end;

  // removing rare formats if they not wanted
  if not use_rare then
    begin
    for temp in rare do
      begin
      idx := exts.IndexOf(temp);

      if idx <> -1 then
        exts.Delete(idx);
      end;
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

  // writing capabilities
  reg.RootKey := HKEY_LOCAL_MACHINE;

  if reg.OpenKey(sReg + '\Capabilities', true) then
    begin
    reg.WString('ApplicationName', sAppName);
    reg.WString('ApplicationDescription', Format(GetLString(FXL_REG_FF_OVERVIEW), [sAppName]));
    reg.CloseKey();

    if reg.OpenKey(sReg + '\Capabilities\FileAssociations', true) then
      begin
      for temp in exts do
        reg.WString('.' + temp, sRegAssociation + '.' + LowerCase(temp));

      reg.CloseKey();
      end;
    end;

  // writing final registration
  reg.RootKey := HKEY_LOCAL_MACHINE;

  if reg.OpenKey('SOFTWARE\RegisteredApplications', false) then
    begin
    reg.WString(sAppName, sReg + '\Capabilities');
    reg.CloseKey();
    end;

  // clean-up
  FreeAndNil(persist);
  FreeAndNil(icons);
  FreeAndNil(descr);
  FreeAndNil(exts);
  FreeAndNil(rare);
  FreeAndNil(reg);
end;

procedure Launch();
var
  app: IApplicationAssociationRegistrationUI;
begin
  try
    app := CreateComObject(CLASS_ApplicationAssociationRegistrationUI) as IApplicationAssociationRegistrationUI;
    if Assigned(app) then
      app.LaunchAdvancedAssociationUI(sAppName);
  except
  end;
end;

procedure CleanUp();
var
  reg: TFRegistry;
  exts, persist: TStringList;
  temp: string;
begin
  reg := TFRegistry.Create(RA_FULL);
  reg.RootKey := HKEY_LOCAL_MACHINE;

  exts := TStringList.Create();
  persist := TStringList.Create();
  persist.Sorted := true;
  persist.CaseSensitive := false;
  persist.Duplicates := dupIgnore;

  // getting all extensions
  reg.RootKey := HKEY_CURRENT_USER;

  if reg.OpenKey(sModules + '\' + PS_FOPEN, false) then
    begin
    reg.GetValueNames(exts);
    reg.CloseKey();
    end;

  reg.RootKey := HKEY_LOCAL_MACHINE;

  if reg.OpenKey(sPersistentSettings, false) then
    begin
    reg.RStrings(sPersistentExts, persist);
    reg.CloseKey();
    end;

  persist.AddStrings(exts);

  // removing all handlers
  for temp in persist do
    RemoveHanderExt(temp);

  // removing default handler
  RemoveHanderExt('');

  // removing capabilities
  RegDeleteKeyIncludingSubkeys(HKEY_LOCAL_MACHINE, sReg + '\Capabilities');

  // removing registration
  if reg.OpenKey('SOFTWARE\RegisteredApplications', false) then
    begin
    reg.DeleteValue(sAppName);
    reg.CloseKey();
    end;

  FreeAndNil(reg);
end;

procedure WriteHandlerExt(ext, description, icon, app_path: string; fs: boolean);
var
  reg: TFRegistry;
  ass: string;
  access: cardinal;
begin
  // need to disable registry redirection on Win64
  if IsWin64() then
    access := RA_FULL or KEY_WOW64_64KEY
  else
    access := RA_FULL;

  reg := TFRegistry.Create(access);
  reg.RootKey := HKEY_LOCAL_MACHINE;

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
      reg.WString('', GetLString(FXL_REG_FF_ACTION_OPEN));
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
    RegDeleteKeyIncludingSubkeys_WOW64(HKEY_LOCAL_MACHINE, PWideChar('SOFTWARE\Classes\' + ass))
  else
    RegDeleteKeyIncludingSubkeys(HKEY_LOCAL_MACHINE, PWideChar('SOFTWARE\Classes\' + ass));
end;

end.
