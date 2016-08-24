unit fx_cmdline;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms, ShellAPI,
  c_const, c_utils, c_reg, c_locales;

function ProcessSpecialArguments(): boolean;
procedure RunPluginScan();
procedure RunCleanup();


implementation

uses fx_pluginscanner, fx_formats_legacy;

function ProcessSpecialArguments(): boolean;
var
  prm: string;
begin
  // result should be true if application should exit after the function
  Result := false;

  // saving parameter
  prm := ParamStr(1);

  if ((prm = '/scan') or (prm = '-scan')) then
    begin
    Result := true;

    RunPluginScan();
    end
  else if ((prm = '/clean') or (prm = '-clean')) then
    begin
    Result := true;

    RunCleanup();
    end;
end;

procedure RunPluginScan();
var
  app_path: string;
  scanner: FuturixPluginScanner;
begin
  // detect application location
  app_path := Slash(ExtractFilePath(Application.ExeName));

  // run the scan
  scanner := FuturixPluginScanner.Create(app_path, false);
  scanner.Scan();
  FreeAndNil(scanner);
end;

procedure RunCleanup();
var
  reg: TFRegistry;
  exts: TStringList;
  ext: string;
begin
  // remove handler
  RegDeleteKeyIncludingSubkeys(HKEY_CURRENT_USER, 'SOFTWARE\Classes\' + sRegAssociation);

  // cleaning all extensions
  reg := TFRegistry.Create(RA_READONLY);
  reg.RootKey := HKEY_CURRENT_USER;
  exts := TStringList.Create();

  if reg.OpenKey(sModules + '\' + PS_FOPEN, false) then
    begin
    reg.GetValueNames(exts);
    reg.CloseKey();
    end;

  for ext in exts do
    begin
    if GetExt(ext) then
      UnsetExt(ext);
    end;

  FreeAndNil(exts);
  FreeAndNil(reg);

  // update system
  UpdateAssociations();
end;

end.
