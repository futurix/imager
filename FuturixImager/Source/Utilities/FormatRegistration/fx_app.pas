unit fx_app;

interface

uses
  Windows, Messages, SysUtils, Classes, ShellAPI, ShlObj,
  c_const, c_utils, c_reg, c_locales, c_lang;

procedure Execute();
procedure Install();
procedure Uninstall();
procedure Reg();
procedure Launch();

procedure WriteFormatsDock();
procedure WriteApplicationRegistration();
procedure UpdateAssociations();


implementation

procedure Execute();
var
  param: string;
begin
  // this utility does not work with WindowsXP or older
  if not IsVista() then
    Exit();

  // saving the only command-line parameter
  param := ParamStr(1);

  // localization
  InitLocalization(HInstance);

  // sync
  // sync + launch
  // clean-up

  if ((param = '/install') or (param = '-install')) then
    Install()
  else if ((param = '/uninstall') or (param = '-uninstall')) then
    Uninstall()
  else if ((param = '/register') or (param = '-register')) then
    Reg()
  else if ((param = '/launch') or (param = '-launch')) then
    Launch();
end;

// initial registry setup
procedure Install();
var
  reg: TFRegistry;
begin
  reg := TFRegistry.Create(RA_FULL);

  FreeAndNil(reg);
end;

// registry clean-up
procedure Uninstall();
begin
  //
end;

// file format registration (XP only - to be removed!)
procedure Reg();
var
  reg: TFRegistry;
  exts: TStringList;
begin
  // initializing
  reg := TFRegistry.Create(RA_FULL);
  exts := TStringList.Create();

  // reading list of extensions
  if (reg.OpenKeyLocal(sModules + '\' + PS_FOPEN, RA_READONLY)) then
    begin
    reg.GetValueNames(exts);
    reg.CloseKey();
    end;

  // writing capabilities
  {if (reg.OpenKeyShared('', RA_FULL)) then
    begin
    //
    reg.CloseKey();
    end;}

  // registering application

  // clean-up
  FreeAndNil(exts);
  FreeAndNil(reg);
end;

// default programs registration and launch (Vista/7 and newer)
procedure Launch();
var
  reg: TFRegistry;
begin
  reg := TFRegistry.Create(RA_FULL);

  FreeAndNil(reg);
end;

procedure WriteFormatsDock();
begin
  //
end;

procedure WriteApplicationRegistration();
begin
  //
end;

procedure UpdateAssociations();
begin
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

end.
