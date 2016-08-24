unit o_iconlib;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ShlObj,
  c_const, c_reg, c_utils, ExtCtrls;

type
  TfraOptIconLib = class(TFrame)
    lblSelect: TLabel;
    cbxIconLibs: TComboBox;
    lblInfo: TLabel;
    imgPreview: TImage;
    procedure cbxIconLibsSelect(Sender: TObject);
  private
    changed: boolean;

    procedure Init(saveSelection: boolean);
    procedure UpdatePreview();
    function ParseIconLib(path: string): boolean;
    procedure ResetIconLib();
    function PrepareIconLibPath(input, libFile: string): string;
    function GetIconLibFileFromName(name: string): string;
  public
    procedure Load();
    procedure Reload();
    procedure Save();
    procedure Cancelled();
  end;

const
  sDefaultIconLib: string = 'Default (built-in)';


implementation

uses w_main, w_options;

{$R *.dfm}

procedure TfraOptIconLib.Load();
begin
  changed := false;

  Init(false);
end;

procedure TfraOptIconLib.Reload();
begin
  Init(true);
end;

procedure TfraOptIconLib.Save();
var
  selection, selFile: string;
  done: boolean;
begin
  if changed then
    begin
    done := false;
    selFile := '';

    if (cbxIconLibs.ItemIndex <> -1) then
      selection := cbxIconLibs.Items[cbxIconLibs.ItemIndex]
    else
      selection := sDefaultIconLib;

    if (selection <> sDefaultIconLib) then
      begin
      selFile := GetIconLibFileFromName(selection);

      if FileExists(selFile) then
        done := ParseIconLib(selFile);
      end;

    if not done then
      ResetIconLib();

    if Assigned(frmOptions) then
      frmOptions.actionUpdateFileFormatHandlers := true;
    end;
end;

procedure TfraOptIconLib.Cancelled();
begin
  //
end;

procedure TfraOptIconLib.Init(saveSelection: boolean);
var
  reg: TFRegistry;
  libs: TStringList;
  temp, oldSelection: string;
begin
  temp := '';

  if saveSelection and (cbxIconLibs.ItemIndex <> -1) then
    oldSelection := cbxIconLibs.Items[cbxIconLibs.ItemIndex];

  // cleaning
  cbxIconLibs.Clear();

  // default icon
  cbxIconLibs.Items.Add(sDefaultIconLib);

  // icon libraries
  reg := TFRegistry.Create();

  if reg.OpenKeyUserRO(sModules + '\' + PS_FICONLIB) then
    begin
    libs := TStringList.Create();

    reg.GetValueNames(libs);
    cbxIconLibs.Items.AddStrings(libs);

    reg.CloseKey();
    FreeAndNil(libs);
    end;

  if saveSelection and (cbxIconLibs.Items.IndexOf(oldSelection) <> -1) then
    cbxIconLibs.ItemIndex := cbxIconLibs.Items.IndexOf(oldSelection)
  else
    begin
    if reg.OpenKeyUserRO(sSettings) then
      begin
      temp := reg.RStr(sIconLibName, '');
      reg.CloseKey();
      end;

    if (temp <> '') and (cbxIconLibs.Items.IndexOf(temp) <> -1) then
      cbxIconLibs.ItemIndex := cbxIconLibs.Items.IndexOf(temp)
    else
      cbxIconLibs.ItemIndex := cbxIconLibs.Items.IndexOf(sDefaultIconLib);
    end;

  if (cbxIconLibs.ItemIndex = -1) and (cbxIconLibs.Items.Count > 0) then
    cbxIconLibs.ItemIndex := 0;

  // clean-up
  FreeAndNil(reg);

  // disable selection if there is only one choice
  cbxIconLibs.Enabled := (cbxIconLibs.Items.Count > 1);

  // update UI
  UpdatePreview();
end;

procedure TfraOptIconLib.UpdatePreview();
var
  selection, selFile: string;
  done: boolean;
  lib: THandle;
  res: TResourceStream;
begin
  done := false;
  selFile := '';

  if (cbxIconLibs.ItemIndex <> -1) then
    selection := cbxIconLibs.Items[cbxIconLibs.ItemIndex]
  else
    selection := sDefaultIconLib;

  if (selection <> sDefaultIconLib) then
    begin
    selFile := GetIconLibFileFromName(selection);

    // trying to load the library
    if FileExists(selFile) then
      begin
      lib := LoadLibraryEx(PWideChar(selFile), 0, LOAD_LIBRARY_AS_DATAFILE);

      if (lib <> 0) then
        begin
        if (LoadResString(lib, 1) = sIconLibID) then
          begin
          done := true;
          lblInfo.Caption := LoadResString(lib, 3);

          try
            res := TResourceStream.Create(lib, 'PREVIEW', 'FUTURIX');
            imgPreview.Picture.Bitmap.LoadFromStream(res);
            FreeAndNil(res);
            except
              imgPreview.Picture.Bitmap.Assign(nil);
            end;
          end;

        FreeLibrary(lib);
        end;
      end;
    end;

  if not done then
    begin
    // loading default
    lblInfo.Caption := 'Default icon included with FuturixImager';
    imgPreview.Picture.Icon.Handle :=
      LoadImage(HInstance, MAKEINTRESOURCE(1), IMAGE_ICON, 48, 48, LR_DEFAULTCOLOR);
    end;
end;

procedure TfraOptIconLib.cbxIconLibsSelect(Sender: TObject);
begin
  UpdatePreview();

  changed := true;
end;

function TfraOptIconLib.ParseIconLib(path: string): boolean;
var
  selection, friendlyName: string;
  reg: TFRegistry;
  lib: THandle;
  res: TResourceStream;
  data: TStringList;
  i: integer;
begin
  // initialization
  selection := ''; // default: no icon lib
  reg := TFRegistry.Create();
  data := TStringList.Create();
  Result := false;

  // clean-up
  RegDeleteKeyIncludingSubkeys(HKEY_CURRENT_USER, PWideChar(sFormatIcons));

  if reg.OpenKeyUser(sSettings) then
    begin
    reg.DeleteValue(sIconLibName);
    reg.DeleteValue(sIconLibFile);

    reg.CloseKey();
    end;

  // trying to load the file
  if ((path <> '') and FileExists(path)) then
    begin
    lib := LoadLibraryEx(PWideChar(path), 0, LOAD_LIBRARY_AS_DATAFILE);

    if (lib <> 0) then
      begin
      if (LoadResString(lib, 1) = sIconLibID) then
        begin
        Result := true;
        friendlyName := LoadResString(lib, 2);

        try
          res := TResourceStream.Create(lib, 'ICONGUIDE', 'FUTURIX');

          data.LoadFromStream(res);
          selection := path;

          FreeAndNil(res);
          except
            selection := '';
          end;

        if (selection <> '') then
          begin
          if reg.OpenKeyUser(sFormatIcons) then
            begin
            for i := 0 to data.Count - 1 do
              begin
              if (data.Names[i] = '%DEFAULT%') then
                reg.WString('', PrepareIconLibPath(data.Values[data.Names[i]], path))
              else if (Trim(data.Names[i]) <> '') then
                reg.WString(Trim(data.Names[i]), PrepareIconLibPath(data.Values[data.Names[i]], path));
              end;

            reg.CloseKey();
            end;

          if reg.OpenKeyUser(sSettings) then
            begin
            reg.WString(sIconLibName, friendlyName);
            reg.WString(sIconLibFile, selection);

            reg.CloseKey();
            end;
          end;
        end;

      FreeLibrary(lib);
      end;
    end;

  FreeAndNil(data);
  FreeAndNil(reg);
end;

procedure TfraOptIconLib.ResetIconLib();
var
  reg: TFRegistry;
begin
  reg := TFRegistry.Create();

  // clean-up
  RegDeleteKeyIncludingSubkeys(HKEY_CURRENT_USER, PWideChar(sFormatIcons));

  if reg.OpenKeyUser(sSettings) then
    begin
    reg.DeleteValue(sIconLibName);
    reg.DeleteValue(sIconLibFile);

    reg.CloseKey();
    end;

  FreeAndNil(reg);
end;

function TfraOptIconLib.PrepareIconLibPath(input, libFile: string): string;
var
  f: TReplaceFlags;
begin
  f := [rfReplaceAll, rfIgnoreCase];

  // FuturixImager folder
  input := StringReplace(input, '%APP%', NoSlash(fx.ApplicationPath), f);
  // icon library itself
  input := StringReplace(input, '%THIS%', libFile, f);
  // folder where icon library is located
  input := StringReplace(input, '%THISDIR%', NoSlash(ExtractFilePath(libFile)), f);

  if IsVista() then
    begin
    // Program Files
    input := StringReplace(input, '%PF%', NoSlash(GetKnownFolderPath(FOLDERID_ProgramFiles)), f);
    // Application Data
    input := StringReplace(input, '%APPDATA%', NoSlash(GetKnownFolderPath(FOLDERID_RoamingAppData)), f);
    // Application Data (non roaming)
    input := StringReplace(input, '%LOCALAPPDATA%', NoSlash(GetKnownFolderPath(FOLDERID_LocalAppData)), f);
    // Windows
    input := StringReplace(input, '%WIN%', NoSlash(GetKnownFolderPath(FOLDERID_Windows)), f);
    // System32
    input := StringReplace(input, '%SYS%', NoSlash(GetKnownFolderPath(FOLDERID_System)), f);
    // System32 or WOW64
    if IsWin64() then
      input := StringReplace(input, '%SYSx86%', NoSlash(GetKnownFolderPath(FOLDERID_SystemX86)), f)
    else
      input := StringReplace(input, '%SYS%', NoSlash(GetKnownFolderPath(FOLDERID_System)), f);
    end
  else
    begin
    // Program Files
    input := StringReplace(input, '%PF%', NoSlash(GetShellFolderPath(CSIDL_PROGRAM_FILES)), f);
    // Application Data
    input := StringReplace(input, '%APPDATA%', NoSlash(GetShellFolderPath(CSIDL_APPDATA)), f);
    // Application Data (non roaming)
    input := StringReplace(input, '%LOCALAPPDATA%', NoSlash(GetShellFolderPath(CSIDL_LOCAL_APPDATA)), f);
    // Windows
    input := StringReplace(input, '%WIN%', NoSlash(GetShellFolderPath(CSIDL_WINDOWS)), f);
    // System32
    input := StringReplace(input, '%SYS%', NoSlash(GetShellFolderPath(CSIDL_SYSTEM)), f);
    // System32 or WOW64
    if IsWin64() then
      input := StringReplace(input, '%SYSx86%', NoSlash(GetShellFolderPath(CSIDL_SYSTEMX86)), f)
    else
      input := StringReplace(input, '%SYS%', NoSlash(GetShellFolderPath(CSIDL_SYSTEM)), f);
   end;

  Result := Trim(input);
end;

function TfraOptIconLib.GetIconLibFileFromName(name: string): string;
var
  reg: TFRegistry;
begin
  reg := TFRegistry.Create();

  if reg.OpenKeyUserRO(sModules + '\' + PS_FICONLIB) then
    begin
    Result := reg.RStr(name, '');
    reg.CloseKey();
    end;

  FreeAndNil(reg);
end;

end.
