unit fx_cmdline;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms, ShellAPI,
  c_const, c_utils, c_reg;

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
  scanner := FuturixPluginScanner.Create(app_path);
  scanner.Scan();
  FreeAndNil(scanner);
end;

procedure RunCleanup();
var
  reg: TFRegistry;
  exts, persist: TStringList;
  ext: string;
begin
  // cleaning all extensions
  reg := TFRegistry.Create(RA_READONLY);
  reg.RootKey := HKEY_CURRENT_USER;
  exts := TStringList.Create();
  persist := TStringList.Create();
  persist.Sorted := true;
  persist.CaseSensitive := false;
  persist.Duplicates := dupIgnore;

  if reg.OpenKey(sModules + '\' + PS_FOPEN, false) then
    begin
    reg.GetValueNames(exts);
    reg.CloseKey();
    end;

  if reg.OpenKey(sPersistentSettings, false) then
    begin
    reg.RStrings(sPersistentExts, persist);
    reg.CloseKey();
    end;

  persist.AddStrings(exts);

  for ext in persist do
    begin
    if GetExt(ext) then
      UnsetExt(ext);
    end;

  // removing all handlers
  for ext in persist do
    RemoveHanderExt(ext);

  // removing default handler
  RemoveHanderExt('');

  // clean-up
  FreeAndNil(persist);
  FreeAndNil(exts);
  FreeAndNil(reg);

  // update system
  UpdateAssociations();
end;

end.
