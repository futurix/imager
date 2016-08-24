unit o_lang;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls,
  c_const, c_reg, c_utils;

type
  TfraOptLang = class(TFrame)
    lblSelect: TLabel;
    cbxLangs: TComboBox;
    lblPreview: TLabel;
    procedure cbxLangsSelect(Sender: TObject);
  private
    changed: boolean;

    procedure Init(saveSelection: boolean);
    procedure UpdatePreview();
    function GetLocaleFileFromName(name: string): string;
  public
    procedure Load();
    procedure Reload();
    procedure Save();
    procedure Cancelled();
  end;

const
  sDefaultLanguage: string = 'English (built-in)';


implementation

uses w_options;

{$R *.dfm}

procedure TfraOptLang.Load();
begin
  changed := false;

  Init(false);
end;

procedure TfraOptLang.Reload();
begin
  Init(true);
end;

procedure TfraOptLang.Save();
var
  selection, selFile, friendlyName: string;
  done: boolean;
  reg: TFRegistry;
  lib: THandle;
begin
  if changed then
    begin
    done := false;
    selFile := '';
    reg := TFRegistry.Create();

    if (cbxLangs.ItemIndex <> -1) then
      selection := cbxLangs.Items[cbxLangs.ItemIndex]
    else
      selection := sDefaultLanguage;

    if (selection <> sDefaultLanguage) then
      begin
      selFile := GetLocaleFileFromName(selection);

      if FileExists(selFile) then
        begin
        lib := LoadLibraryEx(PWideChar(selFile), 0, LOAD_LIBRARY_AS_DATAFILE);

        if (lib <> 0) then
          begin
          if (LoadResString(lib, 1) = sLocaleID) then
            begin
            done := true;
            friendlyName := LoadResString(lib, 2);

            if reg.OpenKeyUser(sSettings) then
              begin
              reg.WString(sLocaleName, friendlyName);
              reg.WString(sLocaleFile, selFile);

              reg.CloseKey();
              end;
            end;

          FreeLibrary(lib);
          end;
        end;
      end;

    if not done then
      if reg.OpenKeyUser(sSettings) then
        begin
        reg.DeleteValue(sLocaleName);
        reg.DeleteValue(sLocaleFile);

        reg.CloseKey();
        end;

    if Assigned(frmOptions) then
      frmOptions.actionUpdateLocalization := true;

    FreeAndNil(reg);
    end;
end;

procedure TfraOptLang.Cancelled();
begin
  //
end;

procedure TfraOptLang.Init(saveSelection: boolean);
var
  reg: TFRegistry;
  libs: TStringList;
  temp, oldSelection: string;
begin
  temp := '';

  if saveSelection and (cbxLangs.ItemIndex <> -1) then
    oldSelection := cbxLangs.Items[cbxLangs.ItemIndex];

  // cleaning
  cbxLangs.Clear();

  // default selection
  cbxLangs.Items.Add(sDefaultLanguage);

  // getting list of localizations
  reg := TFRegistry.Create();

  if reg.OpenKeyUserRO(sModules + '\' + PS_FLOCALE) then
    begin
    libs := TStringList.Create();

    reg.GetValueNames(libs);
    libs.Sort();
    cbxLangs.Items.AddStrings(libs);

    reg.CloseKey();
    FreeAndNil(libs);
    end;

  if saveSelection and (cbxLangs.Items.IndexOf(oldSelection) <> -1) then
    cbxLangs.ItemIndex := cbxLangs.Items.IndexOf(oldSelection)
  else
    begin
    if reg.OpenKeyUserRO(sSettings) then
      begin
      temp := reg.RStr(sLocaleName, '');
      reg.CloseKey();
      end;

    if (temp <> '') and (cbxLangs.Items.IndexOf(temp) <> -1) then
      cbxLangs.ItemIndex := cbxLangs.Items.IndexOf(temp)
    else
      cbxLangs.ItemIndex := cbxLangs.Items.IndexOf(sDefaultLanguage);
    end;

  if (cbxLangs.ItemIndex = -1) and (cbxLangs.Items.Count > 0) then
    cbxLangs.ItemIndex := 0;

  // clean-up
  FreeAndNil(reg);

  // disable selection if there is only one choice
  cbxLangs.Enabled := (cbxLangs.Items.Count > 1);

  // update UI
  UpdatePreview();
end;

procedure TfraOptLang.UpdatePreview();
var
  selection, selFile, lang_loc: string;
  done: boolean;
  lib: THandle;
begin
  done := false;
  selFile := '';

  if (cbxLangs.ItemIndex <> -1) then
    selection := cbxLangs.Items[cbxLangs.ItemIndex]
  else
    selection := sDefaultLanguage;

  if (selection <> sDefaultLanguage) then
    begin
    selFile := GetLocaleFileFromName(selection);

    // trying to load the library
    if FileExists(selFile) then
      begin
      lib := LoadLibraryEx(PWideChar(selFile), 0, LOAD_LIBRARY_AS_DATAFILE);

      if (lib <> 0) then
        begin
        if (LoadResString(lib, 1) = sLocaleID) then
          begin
          done := true;

          lang_loc := LoadResString(lib, 6);
          if (lang_loc <> '') then
            lang_loc := ' (' + lang_loc + ')';

          lblPreview.Caption :=
            'Language: ' + LoadResString(lib, 2) + lang_loc + #10 +
            'Translator: ' + LoadResString(lib, 4) + #10 +
            'Last updated for: ' + sAppName + ' ' + LoadResString(lib, 5);
          end;

        FreeLibrary(lib);
        end;
      end;
    end;

  if not done then
    lblPreview.Caption :='Default language included with FuturixImager';
end;

procedure TfraOptLang.cbxLangsSelect(Sender: TObject);
begin
  UpdatePreview();

  changed := true;
end;

function TfraOptLang.GetLocaleFileFromName(name: string): string;
var
  reg: TFRegistry;
begin
  reg := TFRegistry.Create();

  if reg.OpenKeyUserRO(sModules + '\' + PS_FLOCALE) then
    begin
    Result := reg.RStr(name, '');
    reg.CloseKey();
    end;

  FreeAndNil(reg);
end;

end.
