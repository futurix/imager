unit fx_app;

interface

uses
  Windows, Messages, SysUtils, Classes, ShellAPI, ShlObj, ActiveX, ComObj,
  ShellObjects,
  c_const, c_utils, c_reg, c_locales, c_lang;

var
  app_path: string = '';

procedure Execute();
procedure Sync();
procedure Launch();
procedure CleanUp();


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
  app_path := Slash(ExtractFilePath(GetModuleLocation(HInstance)));

  // saving the only command-line parameter
  param := ParamStr(1);

  // localization
  InitLocalization(LoadLibraryEx(PWideChar(app_path + FXFILE_APP), 0, LOAD_LIBRARY_AS_DATAFILE));

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
var
  reg: TFRegistry;
  icon_num, idx: integer;
  description, temp: string;
  full_screen, use_rare: boolean;
  exts, rare: TStringList;
begin
  reg := TFRegistry.Create(RA_FULL);
  exts := TStringList.Create();
  rare := TStringList.Create();

  // loading settings
  icon_num := FxRegRInt('Formats_Icon', 1);
  description := FxRegRStr('Formats_Description', Format(GetLString(FXL_REG_FF_DESCRIPTION), [sAppName]));
  full_screen := FxRegRBool('Formats_FullScreen', false);
  use_rare := FxRegRBool('Formats_IncludeRareFormats', false);

  // reading supported formats + rare formats
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

  // writing common handler
  reg.RootKey := HKEY_LOCAL_MACHINE;

  if reg.OpenKey('\SOFTWARE\Classes\' + sRegAssociation, true) then
    begin
    reg.WString('', description);
    reg.CloseKey();

    if reg.OpenKey('\SOFTWARE\Classes\' + sRegAssociation + '\DefaultIcon', true) then
      begin
      reg.WString('', app_path + FXFILE_APP + ',' + IntToStr(icon_num));
      reg.CloseKey();
      end;

    if reg.OpenKey('\SOFTWARE\Classes\' + sRegAssociation + '\Shell\Open', true) then
      begin
      reg.WString('', GetLString(FXL_REG_FF_ACTION_OPEN));
      reg.CloseKey();
      end;

    if reg.OpenKey('\SOFTWARE\Classes\' + sRegAssociation + '\Shell\Open\Command', true) then
      begin
      if not full_screen then
        reg.WString('', '"' + app_path + FXFILE_APP + '" "%1"')
      else
        reg.WString('', '"' + app_path + FXFILE_APP + '" "%1" /fs');

      reg.CloseKey();
      end;
    end;

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
        reg.WString('.' + temp, sRegAssociation);

      reg.CloseKey();
      end;
    end;

  // writing final registration
  reg.RootKey := HKEY_LOCAL_MACHINE;

  if reg.OpenKey('\SOFTWARE\RegisteredApplications', false) then
    begin
    reg.WString(sAppName, 'SOFTWARE\Futurix\FuturixImager\Capabilities');
    reg.CloseKey();
    end;

  // clean-up
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
begin
  RegDeleteKeyIncludingSubkeys(HKEY_LOCAL_MACHINE, 'SOFTWARE\Classes\' + sRegAssociation);
  RegDeleteKeyIncludingSubkeys(HKEY_LOCAL_MACHINE, 'SOFTWARE\Futurix\FuturixImager\Capabilities');

  reg := TFRegistry.Create(RA_FULL);
  reg.RootKey := HKEY_LOCAL_MACHINE;

  if reg.OpenKey('\SOFTWARE\RegisteredApplications', false) then
    begin
    reg.DeleteValue(sAppName);
    reg.CloseKey();
    end;

  FreeAndNil(reg);
end;

end.
