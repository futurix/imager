unit o_themes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ImgList, ComCtrls, ToolWin,
  c_const, c_locales, c_lang, c_themes, c_reg, c_utils;

type
  TfraOptThemes = class(TFrame)
    lblSelect: TLabel;
    cbxThemes: TComboBox;
    lblInfo: TLabel;
    sbxPreview: TScrollBox;
    tbrPreview: TToolBar;
    imlPreview: TImageList;
    procedure cbxThemesSelect(Sender: TObject);
  private
    changed: boolean;

    procedure Init(saveSelection: boolean);
    procedure UpdatePreview();
    function GetThemeFileFromName(name: string): string;
  public
    procedure Load();
    procedure Reload();
    procedure Save();
    procedure Cancelled();
  end;

const
  sDefaultTheme: string = 'Default (built-in)';


implementation

uses w_main, w_options;

{$R *.dfm}

procedure TfraOptThemes.Load();
var
  i: integer;
  btn: TToolButton;
begin
  changed := false;

  // generate preview buttons
  for i := 59 downto 0 do
    begin
    btn := TToolButton.Create(tbrPreview);
    btn.ImageIndex := i;
    btn.Parent := tbrPreview;
    end;

  // wrap the toolbar
  tbrPreview.Wrapable := true;

  // initialize
  Init(false);
end;

procedure TfraOptThemes.Reload();
begin
  Init(true);
end;

procedure TfraOptThemes.Save();
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

    if (cbxThemes.ItemIndex <> -1) then
      selection := cbxThemes.Items[cbxThemes.ItemIndex]
    else
      selection := sDefaultTheme;

    if (selection <> sDefaultTheme) then
      begin
      selFile := GetThemeFileFromName(selection);

      if FileExists(selFile) then
        begin
        lib := LoadLibraryEx(PWideChar(selFile), 0, LOAD_LIBRARY_AS_DATAFILE);

        if (lib <> 0) then
          begin
          if (LoadResString(lib, 1) = sThemeID) then
            begin
            done := true;
            friendlyName := LoadResString(lib, 2);

            if reg.OpenKeyUser(sSettings) then
              begin
              reg.WString(sThemeName, friendlyName);
              reg.WString(sThemeFile, selFile);

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
        reg.DeleteValue(sThemeName);
        reg.DeleteValue(sThemeFile);

        reg.CloseKey();
        end;

    if Assigned(frmOptions) then
      frmOptions.actionUpdateTheme := true;

    FreeAndNil(reg);
    end;
end;

procedure TfraOptThemes.Cancelled();
begin
  //
end;

procedure TfraOptThemes.Init(saveSelection: boolean);
var
  reg: TFRegistry;
  libs: TStringList;
  temp, oldSelection: string;
begin
  temp := '';

  if saveSelection and (cbxThemes.ItemIndex <> -1) then
    oldSelection := cbxThemes.Items[cbxThemes.ItemIndex];

  // cleaning
  cbxThemes.Clear();

  // default selection
  cbxThemes.Items.Add(sDefaultTheme);

  // getting list of localizations
  reg := TFRegistry.Create();

  if reg.OpenKeyUserRO(sModules + '\' + PS_FTHEME) then
    begin
    libs := TStringList.Create();

    reg.GetValueNames(libs);
    libs.Sort();
    cbxThemes.Items.AddStrings(libs);

    reg.CloseKey();
    FreeAndNil(libs);
    end;

  if saveSelection and (cbxThemes.Items.IndexOf(oldSelection) <> -1) then
    cbxThemes.ItemIndex := cbxThemes.Items.IndexOf(oldSelection)
  else
    begin
    if reg.OpenKeyUserRO(sSettings) then
      begin
      temp := reg.RStr(sThemeName, '');
      reg.CloseKey();
      end;

    if (temp <> '') and (cbxThemes.Items.IndexOf(temp) <> -1) then
      cbxThemes.ItemIndex := cbxThemes.Items.IndexOf(temp)
    else
      cbxThemes.ItemIndex := cbxThemes.Items.IndexOf(sDefaultTheme);
    end;

  if (cbxThemes.ItemIndex = -1) and (cbxThemes.Items.Count > 0) then
    cbxThemes.ItemIndex := 0;

  // clean-up
  FreeAndNil(reg);

  // disable selection if there is only one choice
  cbxThemes.Enabled := (cbxThemes.Items.Count > 1);

  // update UI
  UpdatePreview();
end;

procedure TfraOptThemes.UpdatePreview();
var
  selection, selFile, theme_descr: string;
  done: boolean;
  lib: THandle;
  bmp: TBitmap;
begin
  done := false;
  selFile := '';

  if (cbxThemes.ItemIndex <> -1) then
    selection := cbxThemes.Items[cbxThemes.ItemIndex]
  else
    selection := sDefaultTheme;

  if (selection <> sDefaultTheme) then
    begin
    selFile := GetThemeFileFromName(selection);

    // trying to load the library
    if FileExists(selFile) then
      begin
      lib := LoadLibraryEx(PWideChar(selFile), 0, LOAD_LIBRARY_AS_DATAFILE);

      if (lib <> 0) then
        begin
        if (LoadResString(lib, 1) = sThemeID) then
          begin
          done := true;

          theme_descr := LoadResString(lib, 3);
          if (theme_descr <> '') then
            theme_descr := (LoadLStr(3556) + ' ' + theme_descr);

          lblInfo.Caption :=
            LoadLStr(3553) + ' ' + LoadResString(lib, 2) + #10 +
            theme_descr + #10 +
            LoadLStr(3554) + ' ' + LoadResString(lib, 4) + #10 +
            LoadLStr(3555) + ' ' + sAppName + ' ' + LoadResString(lib, 5);

          bmp := LoadBitmapFromCustomTheme(lib, 'IMGMAIN');

          if (bmp <> nil) then
            begin
            imlPreview.Height := bmp.Height;
            imlPreview.Width := bmp.Height;
            imlPreview.Clear();
            imlPreview.Add(bmp, nil);
            end
          else
            imlPreview.Clear();
          end;

        FreeLibrary(lib);
        end;
      end;
    end;

  if not done then
    begin
    // default
    lblInfo.Caption := 'Default theme included with FuturixImager';

    bmp := LoadBitmapFromCustomTheme(HInstance, 'IMGMAIN');

    if (bmp <> nil) then
      begin
      imlPreview.Height := bmp.Height;
      imlPreview.Width := bmp.Height;
      imlPreview.Clear();
      imlPreview.Add(bmp, nil);
      end
    else
      imlPreview.Clear();
    end;
end;

procedure TfraOptThemes.cbxThemesSelect(Sender: TObject);
begin
  UpdatePreview();

  changed := true;
end;

function TfraOptThemes.GetThemeFileFromName(name: string): string;
var
  reg: TFRegistry;
begin
  reg := TFRegistry.Create();

  if reg.OpenKeyUserRO(sModules + '\' + PS_FTHEME) then
    begin
    Result := reg.RStr(name, '');
    reg.CloseKey();
    end;

  FreeAndNil(reg);
end;

end.
