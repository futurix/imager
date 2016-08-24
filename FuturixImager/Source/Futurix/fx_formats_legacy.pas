unit fx_formats_legacy;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms, ShellAPI,
  ShlObj,
  c_const, c_utils, c_reg, c_lang, c_locales;

procedure UpdateAssociations();
procedure WriteHandler();
function GetExt(ext: string): boolean;
procedure SetExt(ext: string);
procedure UnsetExt(ext: string);


implementation

uses w_main;

procedure UpdateAssociations();
begin
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

procedure WriteHandler();
var
  reg: TFRegistry;
  icon_num: integer;
  description, app_path: string;
  full_screen: boolean;
begin
  // safety first
  if IsVista() then
    Exit();

  // loading settings
  icon_num := FxRegRInt('Formats_Icon', 1);
  description := FxRegRStr('Formats_Description', Format(GetLString(FXL_REG_FF_DESCRIPTION), [sAppName]));
  full_screen := FxRegRBool('Formats_FullScreen', false);
  app_path := Slash(ExtractFilePath(GetModuleLocation(HInstance)));

  // writing common handler
  reg := TFRegistry.Create(RA_FULL);
  reg.RootKey := HKEY_CURRENT_USER;

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

  FreeAndNil(reg);
end;

function GetExt(ext: string): boolean;
var
  freg: TFRegistry;
begin
  Result := false;

  freg := TFRegistry.Create(RA_READONLY);
  freg.RootKey := HKEY_CURRENT_USER;

  if freg.OpenKey('\SOFTWARE\Classes\.' + ext, false) then
    begin
    Result := (freg.ReadString('') = sRegAssociation);
    freg.CloseKey();
    end;

  FreeAndNil(freg);
end;

procedure SetExt(ext: string);
var
  freg: TFRegistry;
  tmp: string;
begin
  freg := TFRegistry.Create(RA_FULL);
  freg.RootKey := HKEY_CURRENT_USER;

  if freg.OpenKey('\SOFTWARE\Classes\.' + ext, true) then
    begin
    tmp := freg.RStr('', '');

    if ((tmp <> '') and (tmp <> sRegAssociation)) then
      freg.WriteString(sRegAssociationOld, tmp);

    freg.WriteString('', sRegAssociation);
    freg.CloseKey();
    end;

  FreeAndNil(freg);
end;

procedure UnsetExt(ext: string);
var
  freg: TFRegistry;
  tmp: string;
begin
  freg := TFRegistry.Create(RA_FULL);
  freg.RootKey := HKEY_CURRENT_USER;

  if freg.OpenKey('\SOFTWARE\Classes\.' + ext, false) then
    begin
    if (freg.RStr('', '') = sRegAssociation) then
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
