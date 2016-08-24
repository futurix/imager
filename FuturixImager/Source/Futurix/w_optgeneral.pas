unit w_optgeneral;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, Dialogs, CheckLst, ShellAPI,
  c_const, c_utils, c_locales, imageenio, hyiedefs, hyieutils, ToolWin,
  ImgList, c_themes, c_reg, Menus;

const
  SETTING_OPENAFTERSAVE             = 0;
  SETTING_SHOWALLFILTERDEFAULT      = 1;
  SETTING_DISABLEMRU                = 2;
  SETTING_ENABLEFITALL              = 3;
  SETTING_SHOWFULLPATHINTITLE       = 4;
  SETTING_ALLOWMULTIPLEINST         = 5;
  SETTING_FSONDOUBLECLICK           = 6;
  SETTING_PROGRESSIVELOAD           = 7;
  SETTING_HQDISPLAYFILTER           = 8;
  SETTING_DELAYDISPLAYFILTER        = 9;
  SETTING_ENABLECMS                 = 10;

type
  TfrmOldOptions = class(TForm)
    lblSWinColor: TLabel;
    lblSFSColor: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    sbxMainColor: TScrollBox;
    sbxFSColor: TScrollBox;
    lblArrows: TLabel;
    cbxArrows: TComboBox;
    lblEnter: TLabel;
    cbxEnter: TComboBox;
    lblWheel: TLabel;
    cbxWheel: TComboBox;
    lblMouseDrag: TLabel;
    cbxMouseDrag: TComboBox;
    lblNewImage: TLabel;
    cbxNewImage: TComboBox;
    pclOptions: TPageControl;
    shtGeneral: TTabSheet;
    shtBeh: TTabSheet;
    cbxReverseWheel: TCheckBox;
    shtLang: TTabSheet;
    shtThemes: TTabSheet;
    shtPlugins: TTabSheet;
    lblLocale: TLabel;
    cbxLanguages: TComboBox;
    lblLocaleInfo: TLabel;
    lblInstPlugins: TLabel;
    lvwPlugins: TListView;
    lblTheme: TLabel;
    cbxThemes: TComboBox;
    lblThemeInfo: TLabel;
    sbxPreview: TScrollBox;
    tbrPreview: TToolBar;
    ToolButton0: TToolButton;
    imlPreview: TImageList;
    lvwSettings: TListView;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    ToolButton32: TToolButton;
    ToolButton33: TToolButton;
    ToolButton34: TToolButton;
    ToolButton35: TToolButton;
    ToolButton36: TToolButton;
    ToolButton37: TToolButton;
    ToolButton38: TToolButton;
    ToolButton39: TToolButton;
    ToolButton40: TToolButton;
    ToolButton41: TToolButton;
    ToolButton42: TToolButton;
    ToolButton43: TToolButton;
    ToolButton44: TToolButton;
    ToolButton45: TToolButton;
    ToolButton46: TToolButton;
    ToolButton47: TToolButton;
    ToolButton48: TToolButton;
    ToolButton49: TToolButton;
    ToolButton50: TToolButton;
    ToolButton51: TToolButton;
    ToolButton52: TToolButton;
    ToolButton53: TToolButton;
    ToolButton54: TToolButton;
    ToolButton55: TToolButton;
    ToolButton56: TToolButton;
    ToolButton57: TToolButton;
    ToolButton58: TToolButton;
    ToolButton59: TToolButton;
    shtPlugCfg: TTabSheet;
    lblPlugCfg: TLabel;
    lvwPlugCfg: TListView;
    lblResample: TLabel;
    cbxResample: TComboBox;
    lblSGradColor: TLabel;
    sbxGradColor: TScrollBox;
    rdgBg: TRadioGroup;
    lblFormats: TLabel;
    lblClearMRU: TLabel;
    lblPlugScan: TLabel;
    lblOpenPlugFolder: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbxMainColorClick(Sender: TObject);
    procedure sbxFSColorClick(Sender: TObject);
    procedure cbxLanguagesChange(Sender: TObject);
    procedure cbxThemesChange(Sender: TObject);
    procedure lvwPlugCfgDblClick(Sender: TObject);
    procedure lvwPlugCfgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbxGradColorClick(Sender: TObject);
    procedure lblFormatsClick(Sender: TObject);
    procedure lblClearMRUClick(Sender: TObject);
    procedure lblPlugScanClick(Sender: TObject);
    procedure lblOpenPlugFolderClick(Sender: TObject);
  private
    procedure InitLocales();
    procedure InitThemes();
    procedure GetInstalledPluginsList();
  procedure AddSetting(id: longint; name: string);
  function  GetSetting(id: longint): boolean;
  procedure SetSetting(id: longint; value: boolean);
  public
    bLangChanged: boolean;
    bThemeChanged: boolean;

    procedure Localize();
  end;

resourcestring
  sBuiltInLang = 'English (built-in)';
  sBuiltInTheme = 'Default (built-in)';

var
  frmOldOptions: TfrmOldOptions;


implementation

uses w_main, f_ui, f_plugins, f_scan, f_tools, w_show, f_images, fx_consts;

{$R *.DFM}

procedure TfrmOldOptions.InitLocales();
var
  langs: TStringList;
  locale_name: string;
  wreg: TFRegistry;
begin
  // loading languages
  langs := TStringList.Create();
  cbxLanguages.Items.Clear();

  wreg := TFRegistry.Create(RA_READONLY);
  wreg.RootKey := HKEY_CURRENT_USER;

  if wreg.OpenKey(sModules + '\' + PS_FLOCALE, false) then
    begin
    wreg.GetValueNames(langs);

    wreg.CloseKey();
    end;

  FreeAndNil(wreg);

  langs.Sort();

  cbxLanguages.Items.Add(sBuiltInLang);
  cbxLanguages.Items.AddStrings(langs);

  locale_name := FxRegRStr(sLocaleName, '', sReg);

  if (cbxLanguages.Items.IndexOf(locale_name) <> -1) then
    cbxLanguages.ItemIndex := cbxLanguages.Items.IndexOf(locale_name)
  else
    cbxLanguages.ItemIndex := 0;

  cbxLanguagesChange(Self);
  FreeAndNil(langs);
end;

procedure TfrmOldOptions.InitThemes();
var
  themes: TStringList;
  theme_name: string;
  wreg: TFRegistry;
begin
  // loading themes
  themes := TStringList.Create();
  cbxThemes.Items.Clear();

  wreg := TFRegistry.Create(RA_READONLY);
  wreg.RootKey := HKEY_CURRENT_USER;

  if wreg.OpenKey(sModules + '\' + PS_FTHEME, false) then
    begin
    wreg.GetValueNames(themes);
    wreg.CloseKey();
    end;

  FreeAndNil(wreg);

  themes.Sort();

  cbxThemes.Items.Add(sBuiltInTheme);
  cbxThemes.Items.AddStrings(themes);

  theme_name := FxRegRStr(sThemeName, '', sReg);

  if (cbxThemes.Items.IndexOf(theme_name) <> -1) then
    cbxThemes.ItemIndex := cbxThemes.Items.IndexOf(theme_name)
  else
    cbxThemes.ItemIndex := 0;

  cbxThemesChange(Self);
  FreeAndNil(themes);
end;

procedure TfrmOldOptions.GetInstalledPluginsList();
var
  list: TStringList;
  i: integer;
  item: TListItem;
  show_cfg: boolean;
  wreg: TFRegistry;
begin
  wreg := TFRegistry.Create(RA_READONLY);
  wreg.RootKey := HKEY_CURRENT_USER;

  show_cfg := false;

  lvwPlugins.Items.Clear();
  lvwPlugCfg.Items.Clear();

  list := TStringList.Create();

  if wreg.OpenKey(sModules + '\' + PS_FNAME, false) then
    begin
    wreg.GetValueNames(list);

    list.Sort();

    for i := 0 to (list.Count - 1) do
      begin
      item := lvwPlugins.Items.Add();
      item.Caption := ExtractFileName(wreg.RStr(list[i], '???'));
      item.SubItems.Add(list[i]);
      end;

    wreg.CloseKey();
    end;

  list.Clear();

  if wreg.OpenKey(sModules + '\' + PS_FCONFIG, false) then
    begin
    wreg.GetValueNames(list);

    list.Sort();

    if (list.Count > 0) then
      show_cfg := true;

    for i := 0 to (list.Count - 1) do
      begin
      item := lvwPlugCfg.Items.Add();
      item.Caption := list[i];
      item.ImageIndex := 6;
      end;

    wreg.CloseKey();
    end;

  FreeAndNil(list);
  FreeAndNil(wreg);

  shtPlugCfg.TabVisible := show_cfg;
end;

procedure TfrmOldOptions.AddSetting(id: longint; name: string);
var
  item: TListItem;
begin
  item := lvwSettings.Items.Add();
  item.Caption := name;
  item.Data := Pointer(id);
end;

function TfrmOldOptions.GetSetting(id: longint): boolean;
var
  i: integer;
begin
  Result := false;

  for i := 0 to (lvwSettings.Items.Count - 1) do
    begin
    if (longint(lvwSettings.Items[i].Data) = id) then
      begin
      Result := lvwSettings.Items[i].Checked;
      Break;
      end;
    end;
end;

procedure TfrmOldOptions.SetSetting(id: longint; value: boolean);
var
  i: integer;
begin
  for i := 0 to (lvwSettings.Items.Count - 1) do
    begin
    if (longint(lvwSettings.Items[i].Data) = id) then
      begin
      lvwSettings.Items[i].Checked := value;
      Break;
      end;
    end;
end;

procedure TfrmOldOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmOldOptions.FormDestroy(Sender: TObject);
begin
  frmOldOptions := nil;
end;

procedure TfrmOldOptions.btnCancelClick(Sender: TObject);
begin
  Self.Close();
end;

procedure TfrmOldOptions.FormCreate(Sender: TObject);
var
  wreg: TFRegistry;
begin
  wreg := TFRegistry.Create(RA_READONLY);
  wreg.RootKey := HKEY_CURRENT_USER;

  bLangChanged := false;
  bThemeChanged := false;

  Localize();

  SetStyleAsLink(lblClearMRU);
  SetStyleAsLink(lblPlugScan);
  SetStyleAsLink(lblOpenPlugFolder);
  SetStyleAsLink(lblFormats);

  AddSetting(SETTING_OPENAFTERSAVE, LoadLStr(847));
  AddSetting(SETTING_SHOWALLFILTERDEFAULT, LoadLStr(848));
  AddSetting(SETTING_DISABLEMRU, LoadLStr(849));
  AddSetting(SETTING_ENABLEFITALL, LoadLStr(3306));
  AddSetting(SETTING_SHOWFULLPATHINTITLE, LoadLStr(846));
  AddSetting(SETTING_ALLOWMULTIPLEINST, LoadLStr(874));
  AddSetting(SETTING_FSONDOUBLECLICK, LoadLStr(3307));
  AddSetting(SETTING_PROGRESSIVELOAD, LoadLStr(868));
  AddSetting(SETTING_HQDISPLAYFILTER, LoadLStr(869));
  AddSetting(SETTING_DELAYDISPLAYFILTER, LoadLStr(873));
  AddSetting(SETTING_ENABLECMS, LoadLStr(3309));
    
  DoLocaleScan();
  DoThemesScan();
    
  InitLocales();
  InitThemes();

  GetInstalledPluginsList();

  if wreg.OpenKey(sSettings, false) then
    begin
    sbxMainColor.Color        := StringToColor(wreg.RStr('Color', 'clAppWorkSpace'));
    sbxFSColor.Color          := StringToColor(wreg.RStr('FSColor', 'clBlack'));
    sbxGradColor.Color        := StringToColor(wreg.RStr('Gradient', 'clSilver'));

    rdgBg.ItemIndex           := wreg.RInt('BgStyle', 0);

    cbxArrows.ItemIndex       := wreg.RInt('ArrowKeys', 0);
    cbxEnter.ItemIndex        := wreg.RInt('EnterKey', 0);
    cbxWheel.ItemIndex        := wreg.RInt('MouseWheel', 1);
    cbxMouseDrag.ItemIndex    := wreg.RInt('MouseDrag', 0);
    cbxNewImage.ItemIndex     := wreg.RInt('OnNewBitmap', 0);
    cbxResample.ItemIndex     := wreg.RInt('Resampler', 0);
    cbxReverseWheel.Checked   := wreg.RBool('ReverseMouseWheel', false);

    SetSetting(SETTING_OPENAFTERSAVE, (wreg.RInt('OpenAfterSave', 1) = 1));
    SetSetting(SETTING_SHOWALLFILTERDEFAULT, (wreg.RInt('OpenDef', 1) = 1));
    SetSetting(SETTING_DISABLEMRU, wreg.RBool('NoMRU', false));
    SetSetting(SETTING_ENABLEFITALL, wreg.RBool('EnableFitAll', false));
    SetSetting(SETTING_SHOWFULLPATHINTITLE, (wreg.RInt('FullPathInTitle', 0) = 1));
    SetSetting(SETTING_ALLOWMULTIPLEINST, (not wreg.RBool('OneInstanceOnly', false)));
    SetSetting(SETTING_FSONDOUBLECLICK, wreg.RBool('FSonDblClick', true));
    SetSetting(SETTING_PROGRESSIVELOAD, wreg.RBool('ProgressiveImageLoad', false));
    SetSetting(SETTING_HQDISPLAYFILTER, wreg.RBool('HighQualityDisplay', true));
    SetSetting(SETTING_DELAYDISPLAYFILTER, wreg.RBool('DelayZoomFilter', false));
    SetSetting(SETTING_ENABLECMS, wreg.RBool('UseCMS', false));

    wreg.CloseKey();
    end
  else
    begin
    sbxMainColor.Color        := clAppWorkSpace;
    sbxFSColor.Color          := clBlack;
    sbxGradColor.Color        := clSilver;

    rdgBg.ItemIndex           := 0;

    cbxArrows.ItemIndex       := 0;
    cbxEnter.ItemIndex        := 0;
    cbxWheel.ItemIndex        := 1;
    cbxMouseDrag.ItemIndex    := 0;
    cbxNewImage.ItemIndex     := 0;
    cbxResample.ItemIndex     := 0;
    cbxReverseWheel.Checked   := false;

    SetSetting(SETTING_OPENAFTERSAVE, true);
    SetSetting(SETTING_SHOWALLFILTERDEFAULT, true);
    SetSetting(SETTING_DISABLEMRU, false);
    SetSetting(SETTING_ENABLEFITALL, false);
    SetSetting(SETTING_SHOWFULLPATHINTITLE, false);
    SetSetting(SETTING_ALLOWMULTIPLEINST, true);
    SetSetting(SETTING_FSONDOUBLECLICK, true);
    SetSetting(SETTING_PROGRESSIVELOAD, false);
    SetSetting(SETTING_HQDISPLAYFILTER, true);
    SetSetting(SETTING_DELAYDISPLAYFILTER, false);
    SetSetting(SETTING_ENABLECMS, false);
    end;

  FreeAndNil(wreg);
end;

procedure TfrmOldOptions.btnOKClick(Sender: TObject);
var
  locale_lib, theme_lib: string;
  wreg: TFRegistry;
begin
  wreg := TFRegistry.Create(RA_FULL);
  wreg.RootKey := HKEY_CURRENT_USER;

  locale_lib := '';
  theme_lib := '';

  // saving settings
  if wreg.OpenKey(sSettings, true) then
    begin
    if GetSetting(SETTING_OPENAFTERSAVE) then
      wreg.WInteger('OpenAfterSave', 1)
    else
      wreg.WInteger('OpenAfterSave', 0);

    wreg.WString('Color', ColorToString(sbxMainColor.Color));
    wreg.WString('FSColor', ColorToString(sbxFSColor.Color));
    wreg.WString('Gradient', ColorToString(sbxGradColor.Color));
    wreg.WInteger('BgStyle', rdgBg.ItemIndex);

    fxSettings.ColorDefault := sbxMainColor.Color;
    fxSettings.ColorFullScreen := sbxFSColor.Color;
    fxSettings.ColorGradient := sbxGradColor.Color;
    fxSettings.BackgroundStyle := rdgBg.ItemIndex;

    if GetSetting(SETTING_SHOWALLFILTERDEFAULT) then
      wreg.WInteger('OpenDef', 1)
    else
      wreg.WInteger('OpenDef', 0);

    wreg.WBool('NoMRU', GetSetting(SETTING_DISABLEMRU));
    
    wreg.WBool('ProgressiveImageLoad', GetSetting(SETTING_PROGRESSIVELOAD));
    wreg.WInteger('ArrowKeys', cbxArrows.ItemIndex);
    wreg.WInteger('EnterKey', cbxEnter.ItemIndex);
    wreg.WBool('EnableFitAll', GetSetting(SETTING_ENABLEFITALL));
    wreg.WBool('FSonDblClick', GetSetting(SETTING_FSONDOUBLECLICK));
    wreg.WInteger('MouseWheel', cbxWheel.ItemIndex);
    wreg.WInteger('MouseDrag', cbxMouseDrag.ItemIndex);
    wreg.WInteger('OnNewBitmap', cbxNewImage.ItemIndex);
    wreg.WInteger('Resampler', cbxResample.ItemIndex);
    wreg.WBool('HighQualityDisplay', GetSetting(SETTING_HQDISPLAYFILTER));
    wreg.WBool('DelayZoomFilter', GetSetting(SETTING_DELAYDISPLAYFILTER));
    wreg.WBool('UseCMS', GetSetting(SETTING_ENABLECMS));
    wreg.WBool('OneInstanceOnly', not GetSetting(SETTING_ALLOWMULTIPLEINST));
    wreg.WBool('ReverseMouseWheel', cbxReverseWheel.Checked);

    if GetSetting(SETTING_SHOWFULLPATHINTITLE) then
      wreg.WInteger('FullPathInTitle', 1)
    else
      wreg.WInteger('FullPathInTitle', 0);
      
    wreg.CloseKey();
    end
  else
    MessageBox(Self.Handle, PWideChar(Format(LoadLStr(3324), ['core'])), sAppName, MB_OK or MB_ICONERROR);

  // themes
  if bThemeChanged then
    begin
    theme_lib := FxRegRStr(cbxThemes.Items[cbxThemes.ItemIndex], '', sModules + '\' + PS_FTHEME);

    if ((cbxThemes.Items[cbxThemes.ItemIndex] <> sBuiltInTheme) and (theme_lib <> '') and (FileExists(theme_lib))) then
      begin
      if wreg.OpenKey(sReg, true) then
        begin
        wreg.WString(sThemeName, cbxThemes.Items[cbxThemes.ItemIndex]);
        wreg.WString(sThemeLib, theme_lib);

        wreg.CloseKey();
        end
      else
        MessageBox(Self.Handle, PWideChar(Format(LoadLStr(3324), ['theming1'])), sAppName, MB_OK or MB_ICONERROR);
      end
    else
      begin
      if wreg.OpenKey(sReg, true) then
        begin
        wreg.DeleteValue(sThemeName);
        wreg.DeleteValue(sThemeLib);

        wreg.CloseKey();
        end
      else
        MessageBox(Self.Handle, PWideChar(Format(LoadLStr(3324), ['theming2'])), sAppName, MB_OK or MB_ICONERROR);
      end;

    UnloadTheme();
    LoadTheme(HInstance);

    ApplyTheme();
    end;

    // localization stuff
  if bLangChanged then
    begin
    locale_lib := FxRegRStr(cbxLanguages.Items[cbxLanguages.ItemIndex], '', sModules + '\' + PS_FLOCALE);

    if ((cbxLanguages.Items[cbxLanguages.ItemIndex] <> sBuiltInLang) and (locale_lib <> '') and (FileExists(locale_lib))) then
      begin
      if wreg.OpenKey(sReg, true) then
        begin
        wreg.WString(sLocaleName, cbxLanguages.Items[cbxLanguages.ItemIndex]);
        wreg.WString(sLocaleLib, locale_lib);

        wreg.CloseKey();
        end
      else
        MessageBox(Self.Handle, PWideChar(Format(LoadLStr(3324), ['lang1'])), sAppName, MB_OK or MB_ICONERROR);
      end
    else
      begin
      if wreg.OpenKey(sReg, true) then
        begin
        wreg.DeleteValue(sLocaleName);
        wreg.DeleteValue(sLocaleLib);

        wreg.CloseKey();
        end
      else
        MessageBox(Self.Handle, PWideChar(Format(LoadLStr(3324), ['lang2'])), sAppName, MB_OK or MB_ICONERROR);
      end;

    // updating settings
    CleanLocalization();
    InitLocalization(HInstance);

    DoPluginScan();
    UpdatePlugIns();

    // localization fix
    if (c_locales.locale_lib <> 0) then
      begin
      frmMain.mnuMain.Images := nil;
      frmMain.popMain.Images := nil;
      frmMain.popZoom.Images := nil;
      frmMain.popDisp.Images := nil;
      end
    else
      begin
      frmMain.mnuMain.Images := frmMain.imlFixed;
      frmMain.popMain.Images := frmMain.imlFixed;
      frmMain.popZoom.Images := frmMain.imlFixed;
      frmMain.popDisp.Images := frmMain.imlFixed;
      end;

    frmMain.Localize();
    if Assigned(frmShow) then
      frmShow.Localize();
    end;

  // updating settings
  frmMain.miDSFitAll.Visible := GetSetting(SETTING_ENABLEFITALL);
  frmMain.piDSFitAll.Visible := frmMain.miDSFitAll.Visible;
  if not GetSetting(SETTING_ENABLEFITALL) then
    if (GetDisplayStyle() = dsFitAll) then
      SetDisplayStyle(dsFitBig);

  frmMain.bFSonDblClick := GetSetting(SETTING_FSONDOUBLECLICK);
  frmMain.nArrows := cbxArrows.ItemIndex;
  frmMain.nMouseWheel := cbxWheel.ItemIndex;
  frmMain.bReverseWheel := cbxReverseWheel.Checked;
  frmMain.nMouseDrag := cbxMouseDrag.ItemIndex;
  frmMain.nNewBitmap := cbxNewImage.ItemIndex;
  frmMain.nEnter := cbxEnter.ItemIndex;
  frmMain.bOpenAfterSave := GetSetting(SETTING_OPENAFTERSAVE);
  frmMain.bProgressiveLoad := GetSetting(SETTING_PROGRESSIVELOAD);

  ApplyBackground();

  frmMain.bOpenDef := GetSetting(SETTING_SHOWALLFILTERDEFAULT);
  frmMain.bNoMRU := GetSetting(SETTING_DISABLEMRU);

  SetDialogs();

  SetDisplayStyle(GetDisplayStyle());

  frmMain.bFullPathInTitle := GetSetting(SETTING_SHOWFULLPATHINTITLE);

  Header();

  if GetSetting(SETTING_HQDISPLAYFILTER) then
    begin
    case cbxResample.ItemIndex of
      0:  frmMain.img.ZoomFilter := rfFastLinear;
      1:  frmMain.img.ZoomFilter := rfLinear;
      2:  frmMain.img.ZoomFilter := rfTriangle;
      3:  frmMain.img.ZoomFilter := rfBicubic;
      4:  frmMain.img.ZoomFilter := rfBilinear;
      5:  frmMain.img.ZoomFilter := rfNearest;
      6:  frmMain.img.ZoomFilter := rfBSpline;
      7:  frmMain.img.ZoomFilter := rfMitchell;
      8:  frmMain.img.ZoomFilter := rfBell;
      9:  frmMain.img.ZoomFilter := rfHermite;
      10:  frmMain.img.ZoomFilter := rfLanczos3;
      11:  frmMain.img.ZoomFilter := rfProjectWB;
      12:  frmMain.img.ZoomFilter := rfProjectBW;
      else
        frmMain.img.ZoomFilter := rfFastLinear;
    end;
    end
  else
    frmMain.img.ZoomFilter := rfNone;

  iegEnableCMS := GetSetting(SETTING_ENABLECMS);
    
  frmMain.img.DelayZoomFilter := GetSetting(SETTING_DELAYDISPLAYFILTER);

  FreeAndNil(wreg);

  Self.Close();
end;

procedure TfrmOldOptions.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Self.Close();
end;

procedure TfrmOldOptions.Localize();
var
  temp_itemindex: integer;
begin
  Self.Caption            := LoadLStr(840);

  lblFormats.Caption      := LoadLStr(3340);

  shtGeneral.Caption      := LoadLStr(841);

  lblClearMRU.Caption     := LoadLStr(851);

  lblSWinColor.Caption    := LoadLStr(853);
  sbxMainColor.Hint       := LoadLStr(745);
  lblSFSColor.Caption     := LoadLStr(854);
  sbxFSColor.Hint         := LoadLStr(745);
  lblSGradColor.Caption   := LoadLStr(3350);
  sbxGradColor.Hint       := LoadLStr(745);

  rdgBg.Caption           := LoadLStr(3351);

  rdgBg.Items[0]          := LoadLStr(3352);
  rdgBg.Items[1]          := LoadLStr(3353);
  rdgBg.Items[2]          := LoadLStr(3354);
  rdgBg.Items[3]          := LoadLStr(3355);
  rdgBg.Items[4]          := LoadLStr(3356);

  shtBeh.Caption          := LoadLStr(842);

  lblArrows.Caption       := LoadLStr(3300);
  temp_itemindex          := cbxArrows.ItemIndex;
  cbxArrows.Items[0]      := LoadLStr(3301);
  cbxArrows.Items[1]      := LoadLStr(3302);
  cbxArrows.ItemIndex     := temp_itemindex;
  lblEnter.Caption        := LoadLStr(3303);
  temp_itemindex          := cbxEnter.ItemIndex;
  cbxEnter.Items[0]       := LoadLStr(3304);
  cbxEnter.Items[1]       := LoadLStr(3305);
  cbxEnter.ItemIndex      := temp_itemindex;
  lblWheel.Caption        := LoadLStr(3312);
  temp_itemindex          := cbxWheel.ItemIndex;
  cbxWheel.Items[0]       := LoadLStr(3301);
  cbxWheel.Items[1]       := LoadLStr(3313);
  cbxWheel.Items[2]       := LoadLStr(3302);
  cbxWheel.ItemIndex      := temp_itemindex;
  lblMouseDrag.Caption    := LoadLStr(3314);
  temp_itemindex          := cbxMouseDrag.ItemIndex;
  cbxMouseDrag.Items[0]   := LoadLStr(3315);
  cbxMouseDrag.Items[1]   := LoadLStr(3316);
  cbxMouseDrag.ItemIndex  := temp_itemindex;
  lblNewImage.Caption     := LoadLStr(3317);
  temp_itemindex          := cbxNewImage.ItemIndex;
  cbxNewImage.Items[0]    := LoadLStr(3318);
  cbxNewImage.Items[1]    := LoadLStr(3319);
  cbxNewImage.Items[2]    := LoadLStr(3320);
  cbxNewImage.Items[3]    := LoadLStr(3321);
  cbxNewImage.Items[4]    := LoadLStr(3322);
  cbxNewImage.Items[5]    := LoadLStr(3323);
  cbxNewImage.ItemIndex   := temp_itemindex;
  cbxReverseWheel.Caption := LoadLStr(875);

  lblResample.Caption     := LoadLStr(3326);
  cbxResample.Items[0]    := LoadLStr(3327);
  cbxResample.Items[1]    := LoadLStr(3328);
  cbxResample.Items[2]    := LoadLStr(3329);
  cbxResample.Items[3]    := LoadLStr(3330);
  cbxResample.Items[4]    := LoadLStr(3331);
  cbxResample.Items[5]    := LoadLStr(3332);
  cbxResample.Items[6]    := LoadLStr(3333);
  cbxResample.Items[7]    := LoadLStr(3334);
  cbxResample.Items[8]    := LoadLStr(3335);
  cbxResample.Items[9]    := LoadLStr(3336);
  cbxResample.Items[10]   := LoadLStr(3337);
  cbxResample.Items[11]   := LoadLStr(3338);
  cbxResample.Items[12]   := LoadLStr(3339);

  shtLang.Caption         := LoadLStr(844);

  shtPlugins.Caption      := LoadLStr(862);

  lblPlugScan.Caption         := LoadLStr(863);
  lblOpenPlugFolder.Caption   := LoadLStr(864);
  lblInstPlugins.Caption      := LoadLStr(867);

  lvwPlugins.Columns[0].Caption := LoadLStr(876);
  lvwPlugins.Columns[1].Caption := LoadLStr(877);

  shtPlugCfg.Caption      := LoadLStr(3558);
  lblPlugCfg.Caption      := LoadLStr(3559);

  shtThemes.Caption       := LoadLStr(3550);
  lblTheme.Caption        := LoadLStr(3551);

  btnOK.Caption           := LoadLStr(50);
  btnCancel.Caption       := LoadLStr(51);
end;

procedure TfrmOldOptions.sbxMainColorClick(Sender: TObject);
var
  dlg: TColorDialog;
begin
  dlg := TColorDialog.Create(Self);

  dlg.Color := sbxMainColor.Color;
  dlg.Options := [cdFullOpen, cdAnyColor];

  if dlg.Execute then
    sbxMainColor.Color := dlg.Color;

  FreeAndNil(dlg);
end;

procedure TfrmOldOptions.sbxFSColorClick(Sender: TObject);
var
  dlg: TColorDialog;
begin
  dlg := TColorDialog.Create(Self);

  dlg.Color := sbxFSColor.Color;
  dlg.Options := [cdFullOpen, cdAnyColor];

  if dlg.Execute then
    sbxFSColor.Color := dlg.Color;

  FreeAndNil(dlg);
end;

procedure TfrmOldOptions.sbxGradColorClick(Sender: TObject);
var
  dlg: TColorDialog;
begin
  dlg := TColorDialog.Create(Self);

  dlg.Color := sbxGradColor.Color;
  dlg.Options := [cdFullOpen, cdAnyColor];

  if dlg.Execute then
    sbxGradColor.Color := dlg.Color;

  FreeAndNil(dlg);
end;

procedure TfrmOldOptions.cbxLanguagesChange(Sender: TObject);
var
  locale_str, lang_loc: string;
  local_lib: THandle;
  load_default: boolean;
begin
  bLangChanged := true;
  load_default := true;

  if (cbxLanguages.Items[cbxLanguages.ItemIndex] <> sBuiltInLang) then
    begin
    if (cbxLanguages.Items[cbxLanguages.ItemIndex] <> '') then
      begin
      locale_str := FxRegRStr(cbxLanguages.Items[cbxLanguages.ItemIndex], '', sModules + '\' + PS_FLOCALE);

      if ((locale_str <> '') and FileExists(locale_str)) then
        begin
        local_lib := LoadLibraryEx(PWideChar(locale_str), 0, LOAD_LIBRARY_AS_DATAFILE);

        if (local_lib <> 0) then
          begin
          if (LoadResString(local_lib, 1) = sLocaleID) then
            begin
            load_default := false;

            lang_loc := LoadResString(local_lib, 6);
            if (lang_loc <> '') then
              lang_loc := (' (' + lang_loc + ')');

            lblLocaleInfo.Caption :=
              'Language: ' + LoadResString(local_lib, 2) + lang_loc + #10 + #10 +
              'Translator: ' + LoadResString(local_lib, 4) + #10 +
              'Last updated for: ' + sAppName + ' ' + LoadResString(local_lib, 5);
            end;

          FreeLibrary(local_lib);
          end;
        end;
      end;
    end;

  if load_default then
    begin
    lblLocaleInfo.Caption :=
      'Language: ' + sBuiltInLang + #10 + #10 +
      'Translator: ' + LoadResString(HInstance, 4) + #10 +
      'Last updated for: ' + sAppName + ' ' + LoadResString(HInstance, 5);
    end;
end;

procedure TfrmOldOptions.lblClearMRUClick(Sender: TObject);
begin
  frmMain.mru.ClearItems(true);
end;

procedure TfrmOldOptions.lblFormatsClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PWideChar(path_app + FN_FORMATS), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmOldOptions.lblOpenPlugFolderClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PWideChar(path_app), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmOldOptions.lblPlugScanClick(Sender: TObject);
begin
  DoPluginScan();
  UpdatePlugIns();
  SetDialogs();
  GetInstalledPluginsList();

  Application.MessageBox(PWideChar(LoadLStr(604)), sAppName, MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmOldOptions.cbxThemesChange(Sender: TObject);
var
  theme_str, theme_descr: string;
  load_default: boolean;
  lib: THandle;
  bmp: TBitmap;
begin
  bThemeChanged := true;
  load_default := true;

  if (cbxThemes.Items[cbxThemes.ItemIndex] <> sBuiltInTheme) then
    begin
    if (cbxThemes.Items[cbxThemes.ItemIndex] <> '') then
      begin
      theme_str := FxRegRStr(cbxThemes.Items[cbxThemes.ItemIndex], '', sModules + '\' + PS_FTHEME);

      if ((theme_str <> '') and FileExists(theme_str)) then
        begin
        lib := LoadLibraryEx(PWideChar(theme_str), 0, LOAD_LIBRARY_AS_DATAFILE);

        if (lib <> 0) then
          begin
          if (LoadResString(lib, 1) = sThemeID) then
            begin
            load_default := false;

            theme_descr := LoadResString(lib, 3);
            if (theme_descr <> '') then
              theme_descr := (LoadLStr(3556) + ' ' + theme_descr + #10);

            lblThemeInfo.Caption :=
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
              imlPreview.AddMasked(bmp, bmp.Canvas.Pixels[0,0]);
              end
            else
              imlPreview.Clear();
            end;

          FreeLibrary(lib);
          end;
        end;
      end;
    end;

  if load_default then
    begin
    lblThemeInfo.Caption :=
      LoadLStr(3553) + ' ' + sBuiltInTheme + #10 +
      LoadLStr(3556) + ' Default FuturixImager style' + #10 + #10 +
      LoadLStr(3554) + ' ' + LoadResString(HInstance, 4) + #10 +
      LoadLStr(3555) + ' ' + sAppName + ' ' + LoadResString(HInstance, 5);

    bmp := LoadBitmapFromCustomTheme(HInstance, 'IMGMAIN');

    if (bmp <> nil) then
      begin
      imlPreview.Height := bmp.Height;
      imlPreview.Width := bmp.Height;
      imlPreview.Clear();
      imlPreview.AddMasked(bmp, bmp.Canvas.Pixels[0,0]);
      end
    else
      imlPreview.Clear();
    end;

  tbrPreview.ButtonHeight := imlPreview.Height + 6;
  tbrPreview.ButtonWidth := imlPreview.Height + 7;
end;

procedure TfrmOldOptions.lvwPlugCfgDblClick(Sender: TObject);
var
  FxImgCfg: TFxImgCfg;
  lib: THandle;
  lib_path: string;
begin
  if (lvwPlugCfg.Selected <> nil) then
    begin
    lib_path := FxRegRStr(lvwPlugCfg.Selected.Caption, '', sModules + '\' + PS_FCONFIG);

    lib := LoadLibrary(PWideChar(lib_path));

    if (lib <> 0) then
      begin
      @FxImgCfg := GetProcAddress(lib, EX_CFG);

      if (@FxImgCfg <> nil) then
        FxImgCfg(PWideChar(lvwPlugCfg.Selected.Caption), Application.Handle, frmMain.Handle, FxImgGlobalCallback);

      FreeLibrary(lib);
      end
    else
      ShowMessage(LoadLStr(607));
    end;
end;

procedure TfrmOldOptions.lvwPlugCfgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_SPACE) then
    lvwPlugCfgDblClick(Self);
end;

end.
