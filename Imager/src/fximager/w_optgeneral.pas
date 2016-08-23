unit w_optgeneral;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, Dialogs, CheckLst, ShellAPI,
  c_const, c_utils, c_locales, imageenio, hyiedefs, hyieutils, ToolWin,
  ImgList, c_themes, c_reg, Menus;

const
	SETTING_OPENAFTERSAVE 				= 0;
    SETTING_SHOWALLFILTERDEFAULT 		= 1;
    SETTING_DISABLEMRU					= 2;
    SETTING_ENABLEFITALL				= 3;
    SETTING_SHOWFULLPATHINTITLE			= 4;
    SETTING_ALLOWMULTIPLEINST			= 5;
    SETTING_FSONDOUBLECLICK				= 6;
    SETTING_PROGRESSIVELOAD				= 7;
    SETTING_HQDISPLAYFILTER				= 8;
    SETTING_DELAYDISPLAYFILTER			= 9;
    SETTING_ENABLECMS					= 10;

type
  TfrmOptions = class(TForm)
    lblSWinColor: TLabel;
    lblSFSColor: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    lblClearMRU: TLabel;
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
    lblGetLocales: TLabel;
    lblInstPlugins: TLabel;
    lblGetPlugins: TLabel;
    lblPlugScan: TLabel;
    lblOpenPlugFolder: TLabel;
    lvwPlugins: TListView;
    lblTheme: TLabel;
    cbxThemes: TComboBox;
    lblGetThemes: TLabel;
    lblThemeInfo: TLabel;
    sbxPreview: TScrollBox;
    tbrPreview: TToolBar;
    ToolButton0: TToolButton;
    imlPreview: TImageList;
    shtFormats: TTabSheet;
    lvwExt: TListView;
    lblAddParams: TLabel;
    popFormats: TPopupMenu;
    piSelectAll: TMenuItem;
    piSelectNone: TMenuItem;
    lvwSettings: TListView;
    cbxShowRare: TCheckBox;
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
    ToolButton60: TToolButton;
    ToolButton61: TToolButton;
    ToolButton62: TToolButton;
    shtPlugCfg: TTabSheet;
    lblPlugCfg: TLabel;
    lvwPlugCfg: TListView;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblClearMRUClick(Sender: TObject);
    procedure sbxMainColorClick(Sender: TObject);
    procedure sbxFSColorClick(Sender: TObject);
    procedure cbxLanguagesChange(Sender: TObject);
    procedure lblGetLocalesClick(Sender: TObject);
    procedure lblPlugScanClick(Sender: TObject);
    procedure lblOpenPlugFolderClick(Sender: TObject);
    procedure lblGetPluginsClick(Sender: TObject);
    procedure cbxThemesChange(Sender: TObject);
    procedure lblGetThemesClick(Sender: TObject);
    procedure lblAddParamsClick(Sender: TObject);
    procedure piSelectAllClick(Sender: TObject);
    procedure piSelectNoneClick(Sender: TObject);
    procedure cbxShowRareClick(Sender: TObject);
    procedure lvwPlugCfgDblClick(Sender: TObject);
    procedure lvwPlugCfgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure InitLocales();
    procedure InitThemes();
    procedure InitFormats();
    procedure GetInstalledPluginsList();
    function  GetExt(ext: string): boolean;
    procedure SetExt(ext: string);
    procedure UnsetExt(ext: string);
    procedure SaveFormats();
	procedure AddSetting(id: longint; name: string);
	function  GetSetting(id: longint): boolean;
	procedure SetSetting(id: longint; value: boolean);
  public
    bLangChanged: boolean;
    bThemeChanged: boolean;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure Localize();
  end;

resourcestring
	sBuiltInLang = 'English (built-in)';
    sBuiltInTheme = 'Default (built-in)';

var
	frmOptions: TfrmOptions;


implementation

uses main, f_ui, f_plugins, f_scan, f_tools, w_show, f_images,
  w_optformats;

{$R *.DFM}

procedure TfrmOptions.InitLocales();
var
	langs: TStringList;
    locale_name: string;
begin
    // loading languages
    langs := TStringList.Create();
    cbxLanguages.Items.Clear();

    reg.OpenKey(sModules + '\' + PS_FLOCALE, true);
    reg.GetValueNames(langs);
    reg.CloseKey();

    langs.Sort();

    cbxLanguages.Items.Add(sBuiltInLang);
    cbxLanguages.Items.AddStrings(langs);

    reg.OpenKey(sReg, true);
    locale_name := reg.RStr(sLocaleName, '');
    reg.CloseKey();

    if (cbxLanguages.Items.IndexOf(locale_name) <> -1) then
    	cbxLanguages.ItemIndex := cbxLanguages.Items.IndexOf(locale_name)
    else
    	cbxLanguages.ItemIndex := 0;

    cbxLanguagesChange(Self);
    FreeAndNil(langs);
end;

procedure TfrmOptions.InitThemes();
var
	themes: TStringList;
    theme_name: string;
begin
    // loading languages
    themes := TStringList.Create();
    cbxThemes.Items.Clear();

    reg.OpenKey(sModules + '\' + PS_FTHEME, true);
    reg.GetValueNames(themes);
    reg.CloseKey();

    themes.Sort();

    cbxThemes.Items.Add(sBuiltInTheme);
    cbxThemes.Items.AddStrings(themes);

    reg.OpenKey(sReg, true);
    theme_name := reg.RStr(sThemeName, '');
    reg.CloseKey();

    if (cbxThemes.Items.IndexOf(theme_name) <> -1) then
    	cbxThemes.ItemIndex := cbxThemes.Items.IndexOf(theme_name)
    else
    	cbxThemes.ItemIndex := 0;

    cbxThemesChange(Self);
    FreeAndNil(themes);
end;

procedure TfrmOptions.InitFormats();
var
	s, notrec: TStringList;
    i: integer;
    item: TListItem;
begin
    notrec := TStringList.Create();
	s := TStringList.Create();

	reg.OpenKey(sModules + '\' + PS_FOPEN, true);
	reg.GetValueNames(s);
	reg.CloseKey();

	reg.OpenKey(sModules + '\' + PS_FNOTREC, true);
	reg.GetValueNames(notrec);
	reg.CloseKey();

	s.Sort();
    lvwExt.Items.Clear();

    reg.OpenKey(sModules + '\' + PS_FDESCR, true);

    for i := 0 to (s.Count - 1) do
    	begin
        if ((GetExt(s[i])) or (cbxShowRare.Checked) or (notrec.IndexOf(s[i]) = -1)) then
        	begin
        	item := lvwExt.Items.Add();
        	item.Caption := s[i];
        	item.SubItems.Add(reg.RStr(s[i], ''));
        	item.Checked := GetExt(s[i]);
            end;
        end;

    reg.CloseKey();

	FreeAndNil(s);
    FreeAndNil(notrec);
end;

procedure TfrmOptions.GetInstalledPluginsList();
var
	list: TStringList;
    i: integer;
    item: TListItem;
    show_cfg: boolean;
begin
    show_cfg := false;

    lvwPlugins.Items.Clear();
    lvwPlugCfg.Items.Clear();

    list := TStringList.Create();

    if reg.OpenKey(sModules + '\' + PS_FNAME, false) then
    	begin
    	reg.GetValueNames(list);

        list.Sort();

        for i := 0 to (list.Count - 1) do
            begin
            item := lvwPlugins.Items.Add();
            item.Caption := ExtractFileName(reg.RStr(list[i], '???'));
            item.SubItems.Add(list[i]);
            end;

        reg.CloseKey();
        end;

    list.Clear();

    if reg.OpenKey(sModules + '\' + PS_FCONFIG, false) then
    	begin
    	reg.GetValueNames(list);

        list.Sort();

        if (list.Count > 0) then
        	show_cfg := true;

        for i := 0 to (list.Count - 1) do
            begin
            item := lvwPlugCfg.Items.Add();
            item.Caption := list[i];
            item.ImageIndex := 7;
            end;

        reg.CloseKey();
        end;

    FreeAndNil(list);

    shtPlugCfg.TabVisible := show_cfg;
end;

function TfrmOptions.GetExt(ext: string): boolean;
var
	freg: TFRegistry;
begin
	Result := false;

    freg := TFRegistry.Create(RA_READONLY);
    freg.RootKey := HKEY_CLASSES_ROOT;

    if freg.OpenKey('\.' + ext, false) then
  		begin
        Result := (freg.ReadString('') = sRegAssociation);
        freg.CloseKey();
  		end;

    FreeAndNil(freg);
end;

procedure TfrmOptions.SetExt(ext: string);
var
	freg: TFRegistry;
	tmp: string;
begin
    freg := TFRegistry.Create(RA_FULL);
    freg.RootKey := HKEY_CLASSES_ROOT;

	if freg.OpenKey('\.' + ext, true) then
    	begin
		tmp := freg.RStr('', '');

		if ((tmp <> '') and (tmp <> sRegAssociation)) then
  			freg.WriteString(sRegAssociationOld, tmp);

		freg.WriteString('', sRegAssociation);
		freg.CloseKey();
    	end;

    FreeAndNil(freg);
end;

procedure TfrmOptions.UnsetExt(ext: string);
var
	freg: TFRegistry;
	tmp: string;
begin
    freg := TFRegistry.Create(RA_FULL);
    freg.RootKey := HKEY_CLASSES_ROOT;

	if freg.OpenKey('\.' + ext, false) then
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

procedure TfrmOptions.SaveFormats();
var
	i: integer;
begin
    for i := 0 to (lvwExt.Items.Count - 1) do
  		begin
  		if lvwExt.Items[i].Checked then
    		SetExt(lvwExt.Items[i].Caption)
  		else
    		if GetExt(lvwExt.Items[i].Caption) then
      			UnsetExt(lvwExt.Items[i].Caption);
  		end;
end;

procedure TfrmOptions.AddSetting(id: longint; name: string);
var
	item: TListItem;
begin
	item := lvwSettings.Items.Add();
    item.Caption := name;
    item.Data := Pointer(id);
end;

function TfrmOptions.GetSetting(id: longint): boolean;
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

procedure TfrmOptions.SetSetting(id: longint; value: boolean);
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

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
end;

procedure TfrmOptions.FormDestroy(Sender: TObject);
begin
	frmOptions := nil;
end;

procedure TfrmOptions.btnCancelClick(Sender: TObject);
begin
	Self.Close();
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
    bLangChanged := false;
    bThemeChanged := false;

    Localize();

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

    SetStyleAsLink(lblGetLocales);
    SetStyleAsLink(lblClearMRU);
    SetStyleAsLink(lblPlugScan);
    SetStyleAsLink(lblOpenPlugFolder);
    SetStyleAsLink(lblGetPlugins);
    SetStyleAsLink(lblGetThemes);
    SetStyleAsLink(lblAddParams);

    DoLocaleScan();
    DoThemesScan();
    
	InitLocales();
    InitThemes();
    InitFormats();

    GetInstalledPluginsList();

    reg.OpenKey(sSettings, true);

	sbxMainColor.Color 		:= StringToColor(reg.RStr('Color', 'clAppWorkSpace'));
	sbxFSColor.Color 		:= StringToColor(reg.RStr('FSColor', 'clBlack'));

    cbxArrows.ItemIndex 	:= reg.RInt('ArrowKeys', 0);
    cbxEnter.ItemIndex 		:= reg.RInt('EnterKey', 0);
    cbxWheel.ItemIndex 		:= reg.RInt('MouseWheel', 1);
    cbxMouseDrag.ItemIndex 	:= reg.RInt('MouseDrag', 0);
    cbxNewImage.ItemIndex 	:= reg.RInt('OnNewBitmap', 0);
    cbxReverseWheel.Checked := reg.RBool('ReverseMouseWheel', false);

	SetSetting(SETTING_OPENAFTERSAVE, (reg.RInt('OpenAfterSave', 1) = 1));
    SetSetting(SETTING_SHOWALLFILTERDEFAULT, (reg.RInt('OpenDef', 1) = 1));
    SetSetting(SETTING_DISABLEMRU, reg.RBool('NoMRU', false));
    SetSetting(SETTING_ENABLEFITALL, reg.RBool('EnableFitAll', false));
    SetSetting(SETTING_SHOWFULLPATHINTITLE, (reg.RInt('FullPathInTitle', 0) = 1));
    SetSetting(SETTING_ALLOWMULTIPLEINST, (not reg.RBool('OneInstanceOnly', false)));
    SetSetting(SETTING_FSONDOUBLECLICK, reg.RBool('FSonDblClick', true));
    SetSetting(SETTING_PROGRESSIVELOAD, reg.RBool('ProgressiveImageLoad', false));
    SetSetting(SETTING_HQDISPLAYFILTER, reg.RBool('HighQualityDisplay', false));
    SetSetting(SETTING_DELAYDISPLAYFILTER, reg.RBool('DelayZoomFilter', true));
    SetSetting(SETTING_ENABLECMS, reg.RBool('UseCMS', false));
    	
    reg.CloseKey();
end;

procedure TfrmOptions.btnOKClick(Sender: TObject);
var
	locale_lib, theme_lib: string;
begin
    locale_lib := '';
    theme_lib := '';

    // saving settings
    reg.OpenKey(sSettings, true);

	if GetSetting(SETTING_OPENAFTERSAVE) then
    	reg.WriteInteger('OpenAfterSave', 1)
    else
    	reg.WriteInteger('OpenAfterSave', 0);

	reg.WriteString('Color', ColorToString(sbxMainColor.Color));
	reg.WriteString('FSColor', ColorToString(sbxFSColor.Color));

	if GetSetting(SETTING_SHOWALLFILTERDEFAULT) then
    	reg.WriteInteger('OpenDef', 1)
    else
    	reg.WriteInteger('OpenDef', 0);

	reg.WriteBool('NoMRU', GetSetting(SETTING_DISABLEMRU));
    
    reg.WBool('ProgressiveImageLoad', GetSetting(SETTING_PROGRESSIVELOAD));
    reg.WInteger('ArrowKeys', cbxArrows.ItemIndex);
    reg.WInteger('EnterKey', cbxEnter.ItemIndex);
    reg.WBool('EnableFitAll', GetSetting(SETTING_ENABLEFITALL));
    reg.WBool('FSonDblClick', GetSetting(SETTING_FSONDOUBLECLICK));
    reg.WInteger('MouseWheel', cbxWheel.ItemIndex);
    reg.WInteger('MouseDrag', cbxMouseDrag.ItemIndex);
    reg.WInteger('OnNewBitmap', cbxNewImage.ItemIndex);
    reg.WBool('HighQualityDisplay', GetSetting(SETTING_HQDISPLAYFILTER));
    reg.WBool('DelayZoomFilter', GetSetting(SETTING_DELAYDISPLAYFILTER));
    reg.WBool('UseCMS', GetSetting(SETTING_ENABLECMS));
    reg.WBool('OneInstanceOnly', not GetSetting(SETTING_ALLOWMULTIPLEINST));
    reg.WBool('ReverseMouseWheel', cbxReverseWheel.Checked);

	if GetSetting(SETTING_SHOWFULLPATHINTITLE) then
    	reg.WriteInteger('FullPathInTitle', 1)
    else
    	reg.WriteInteger('FullPathInTitle', 0);
    	
    reg.CloseKey();

    // themes
    if bThemeChanged then
    	begin
        if reg.OpenKey(sModules + '\' + PS_FTHEME, false) then
        	begin
            theme_lib := reg.RStr(cbxThemes.Items[cbxThemes.ItemIndex], '');
            reg.CloseKey();
            end;

    	if ((cbxThemes.Items[cbxThemes.ItemIndex] <> sBuiltInTheme) and (theme_lib <> '') and (FileExists(theme_lib))) then
    		begin
    		reg.OpenKey(sReg, true);
    		reg.WString(sThemeName, cbxThemes.Items[cbxThemes.ItemIndex]);
            reg.WString(sThemeLib, theme_lib);
    		reg.CloseKey();
        	end
    	else
    		begin
    		reg.OpenKey(sReg, true);
        	reg.DeleteValue(sThemeName);
            reg.DeleteValue(sThemeLib);
    		reg.CloseKey();
        	end;

        UnloadTheme();
        LoadTheme(HInstance);

        ApplyTheme();
        end;

    // localization stuff
    if bLangChanged then
    	begin
        if reg.OpenKey(sModules + '\' + PS_FLOCALE, false) then
        	begin
            locale_lib := reg.RStr(cbxLanguages.Items[cbxLanguages.ItemIndex], '');
            reg.CloseKey();
            end;

    	if ((cbxLanguages.Items[cbxLanguages.ItemIndex] <> sBuiltInLang) and (locale_lib <> '') and (FileExists(locale_lib))) then
    		begin
    		reg.OpenKey(sReg, true);
    		reg.WString(sLocaleName, cbxLanguages.Items[cbxLanguages.ItemIndex]);
            reg.WString(sLocaleLib, locale_lib);
    		reg.CloseKey();
        	end
    	else
    		begin
    		reg.OpenKey(sReg, true);
        	reg.DeleteValue(sLocaleName);
            reg.DeleteValue(sLocaleLib);
    		reg.CloseKey();
        	end;

		// updating settings
    	CleanLocalization();
    	InitLocalization(HInstance);

        DoPluginScan();
		UpdatePlugIns();

    	frmMain.Localize();
    	if Assigned(frmShow) then
    		frmShow.Localize();
        end;

    // file formats
    SaveFormats();
	WriteHandler();
	UpdateAssociations();

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

	if frmMain.full_screen then
    	frmMain.sbxMain.Color := sbxFSColor.Color
    else
    	frmMain.sbxMain.Color := sbxMainColor.Color;
    frmMain.img.Background := frmMain.sbxMain.Color;

    frmMain.bOpenDef := GetSetting(SETTING_SHOWALLFILTERDEFAULT);
    frmMain.bNoMRU := GetSetting(SETTING_DISABLEMRU);

	SetDialogs();

    SetDisplayStyle(GetDisplayStyle());

    frmMain.bFullPathInTitle := GetSetting(SETTING_SHOWFULLPATHINTITLE);

	Header();

    if GetSetting(SETTING_HQDISPLAYFILTER) then
    	frmMain.img.ZoomFilter := rfFastLinear
    else
    	frmMain.img.ZoomFilter := rfNone;

    iegEnableCMS := GetSetting(SETTING_ENABLECMS);

    frmMain.img.DelayZoomFilter := GetSetting(SETTING_DELAYDISPLAYFILTER);

	Self.Close();
end;

procedure TfrmOptions.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

procedure TfrmOptions.lblClearMRUClick(Sender: TObject);
begin
    frmMain.MRU.Files.Clear();
end;

procedure TfrmOptions.CreateParams(var Params: TCreateParams);
begin
	Params.Style := (Params.Style or WS_POPUP);

	inherited;

	if (Owner is TForm) then
		Params.WndParent := (Owner as TWinControl).Handle
	else if Assigned(Screen.ActiveForm) then
		Params.WndParent := Screen.ActiveForm.Handle;
end;

procedure TfrmOptions.Localize();
var
	temp_itemindex: integer;
begin
    Self.Caption				:= LoadLStr(840);

    shtFormats.Caption			:= LoadLStr(843);

    lvwExt.Columns[0].Caption	:= LoadLStr(878);
    lvwExt.Columns[1].Caption	:= LoadLStr(877);
    lblAddParams.Caption		:= LoadLStr(879);
    piSelectAll.Caption			:= LoadLStr(858);
    piSelectNone.Caption		:= LoadLStr(859);
    cbxShowRare.Caption			:= LoadLStr(3557);

    shtGeneral.Caption 			:= LoadLStr(841);

    lblClearMRU.Caption			:= LoadLStr(851);
    lblSWinColor.Caption		:= LoadLStr(853);
    sbxMainColor.Hint			:= LoadLStr(745);
    lblSFSColor.Caption			:= LoadLStr(854);
    sbxFSColor.Hint				:= LoadLStr(745);

    shtBeh.Caption				:= LoadLStr(842);

    lblArrows.Caption			:= LoadLStr(3300);
    temp_itemindex := cbxArrows.ItemIndex;
    cbxArrows.Items[0]			:= LoadLStr(3301);
    cbxArrows.Items[1]			:= LoadLStr(3302);
    cbxArrows.ItemIndex := temp_itemindex;
    lblEnter.Caption			:= LoadLStr(3303);
    temp_itemindex := cbxEnter.ItemIndex;
    cbxEnter.Items[0]			:= LoadLStr(3304);
    cbxEnter.Items[1]			:= LoadLStr(3305);
    cbxEnter.ItemIndex := temp_itemindex;
    lblWheel.Caption			:= LoadLStr(3312);
    temp_itemindex := cbxWheel.ItemIndex;
    cbxWheel.Items[0]			:= LoadLStr(3301);
    cbxWheel.Items[1]			:= LoadLStr(3313);
    cbxWheel.Items[2]			:= LoadLStr(3302);
    cbxWheel.ItemIndex := temp_itemindex;
    lblMouseDrag.Caption		:= LoadLStr(3314);
    temp_itemindex := cbxMouseDrag.ItemIndex;
    cbxMouseDrag.Items[0]		:= LoadLStr(3315);
    cbxMouseDrag.Items[1]		:= LoadLStr(3316);
    cbxMouseDrag.ItemIndex := temp_itemindex;
    lblNewImage.Caption			:= LoadLStr(3317);
    temp_itemindex := cbxNewImage.ItemIndex;
    cbxNewImage.Items[0]		:= LoadLStr(3318);
    cbxNewImage.Items[1]		:= LoadLStr(3319);
    cbxNewImage.Items[2]		:= LoadLStr(3320);
    cbxNewImage.Items[3]		:= LoadLStr(3321);
    cbxNewImage.Items[4]		:= LoadLStr(3322);
    cbxNewImage.Items[5]		:= LoadLStr(3323);
    cbxNewImage.ItemIndex := temp_itemindex;
    cbxReverseWheel.Caption		:= LoadLStr(875);

    shtLang.Caption				:= LoadLStr(844);

    shtPlugins.Caption			:= LoadLStr(862);

    lblPlugScan.Caption			:= LoadLStr(863);
    lblOpenPlugFolder.Caption	:= LoadLStr(864);
    lblGetPlugins.Caption		:= LoadLStr(865);
    lblInstPlugins.Caption		:= LoadLStr(867);

    lvwPlugins.Columns[0].Caption := LoadLStr(876);
    lvwPlugins.Columns[1].Caption := LoadLStr(877);

    shtPlugCfg.Caption			:= LoadLStr(3558);
    lblPlugCfg.Caption			:= LoadLStr(3559);

    shtThemes.Caption			:= LoadLStr(3550);
    lblTheme.Caption			:= LoadLStr(3551);
    lblGetThemes.Caption		:= LoadLStr(3552);

    btnOK.Caption				:= LoadLStr(50);
    btnCancel.Caption			:= LoadLStr(51);
end;

procedure TfrmOptions.sbxMainColorClick(Sender: TObject);
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

procedure TfrmOptions.sbxFSColorClick(Sender: TObject);
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

procedure TfrmOptions.cbxLanguagesChange(Sender: TObject);
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
            if reg.OpenKey(sModules + '\' + PS_FLOCALE, false) then
            	begin
                locale_str := reg.RStr(cbxLanguages.Items[cbxLanguages.ItemIndex], '');
                reg.CloseKey();

                if ((locale_str <> '') and FileExists(locale_str)) then
                	begin
                    local_lib := LoadLibraryEx(PChar(locale_str), 0, LOAD_LIBRARY_AS_DATAFILE);

                    if (local_lib <> 0) then
                    	begin
                        if (LoadResString(local_lib, 1) = sLocaleID) then
                        	begin
                            load_default := false;

                            lang_loc := LoadResString(local_lib, 6);
                            if (lang_loc <> '') then
                            	lang_loc := (' (' + lang_loc + ')');

                            lblLocaleInfo.Caption :=    'Language: ' + LoadResString(local_lib, 2) + lang_loc + #10 + #10 +
                            							'Translator: ' + LoadResString(local_lib, 4) + #10 +
                                                        'Last updated for: ' + sAppName + ' ' + LoadResString(local_lib, 5);
                            end;

                        FreeLibrary(local_lib);
                        end;
                    end;
                end;
            end;
        end;

    if load_default then
    	begin
        lblLocaleInfo.Caption :=    'Language: ' + sBuiltInLang + #10 + #10 +
        							'Translator: ' + LoadResString(HInstance, 4) + #10 +
                                    'Last updated for: ' + sAppName + ' ' + LoadResString(HInstance, 5);
        end;
end;

procedure TfrmOptions.lblGetLocalesClick(Sender: TObject);
begin
	OpenURL(sURLlocales);
end;

procedure TfrmOptions.lblPlugScanClick(Sender: TObject);
begin
	DoPluginScan();
	UpdatePlugIns();
    SetDialogs();
    GetInstalledPluginsList();
    InitFormats();
	Application.MessageBox(PChar(LoadLStr(604)), sAppName, MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmOptions.lblOpenPlugFolderClick(Sender: TObject);
begin
	ShellExecute(Application.Handle, 'open', PChar(path_app), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmOptions.lblGetPluginsClick(Sender: TObject);
begin
	OpenURL(sURLplugins);
end;

procedure TfrmOptions.cbxThemesChange(Sender: TObject);
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
            if reg.OpenKey(sModules + '\' + PS_FTHEME, false) then
            	begin
                theme_str := reg.RStr(cbxThemes.Items[cbxThemes.ItemIndex], '');
                reg.CloseKey();

                if ((theme_str <> '') and FileExists(theme_str)) then
                	begin
                    lib := LoadLibraryEx(PChar(theme_str), 0, LOAD_LIBRARY_AS_DATAFILE);

                    if (lib <> 0) then
                    	begin
                        if (LoadResString(lib, 1) = sThemeID) then
                        	begin
                            load_default := false;

                            theme_descr := LoadResString(lib, 3);
                            if (theme_descr <> '') then
                            	theme_descr := (LoadLStr(3556) + ' ' + theme_descr + #10);

                            lblThemeInfo.Caption :=	LoadLStr(3553) + ' ' + LoadResString(lib, 2) + #10 +
                                                    theme_descr + #10 +
                            						LoadLStr(3554) + ' ' + LoadResString(lib, 4) + #10 +
                                                    LoadLStr(3555) + ' ' + sAppName + ' ' + LoadResString(lib, 5);

                        	bmp := LoadBitmapFromCustomTheme(lib, 'TBSA');

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
        end;

    if load_default then
    	begin
        lblThemeInfo.Caption :=	LoadLStr(3553) + ' ' + sBuiltInTheme + #10 +
                                LoadLStr(3556) + ' Default FuturixImager style' + #10 + #10 +
        						LoadLStr(3554) + ' ' + LoadResString(HInstance, 4) + #10 +
        						LoadLStr(3555) + ' ' + sAppName + ' ' + LoadResString(HInstance, 5);

        bmp := LoadBitmapFromCustomTheme(HInstance, 'TBSA');

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

procedure TfrmOptions.lblGetThemesClick(Sender: TObject);
begin
	OpenURL(sURLthemes);
end;

procedure TfrmOptions.lblAddParamsClick(Sender: TObject);
begin
	if not Assigned(frmOptFormats) then
  		begin
  		Application.CreateForm(TfrmOptFormats, frmOptFormats);
  		frmOptFormats.ShowModal();
  		end;
end;

procedure TfrmOptions.piSelectAllClick(Sender: TObject);
var
	i: integer;
begin
    for i := 0 to (lvwExt.Items.Count - 1) do
  		lvwExt.Items[i].Checked := true;
end;

procedure TfrmOptions.piSelectNoneClick(Sender: TObject);
var
	i: integer;
begin
    for i := 0 to (lvwExt.Items.Count - 1) do
  		lvwExt.Items[i].Checked := false;
end;

procedure TfrmOptions.cbxShowRareClick(Sender: TObject);
begin
	InitFormats();
end;

procedure TfrmOptions.lvwPlugCfgDblClick(Sender: TObject);
var
	FxImgCfg: TFxImgCfg;
	lib: THandle;
    lib_path: string;
begin
    if (lvwPlugCfg.Selected <> nil) then
    	begin
		reg.OpenKey(sModules + '\' + PS_FCONFIG, true);
    	lib_path := reg.RStr(lvwPlugCfg.Selected.Caption, '');
    	reg.CloseKey();

  		lib := LoadLibrary(PChar(lib_path));

  		if (lib <> 0) then
    		begin
    		@FxImgCfg := GetProcAddress(lib, EX_CFG);

    		if (@FxImgCfg <> nil) then
                FxImgCfg(PChar(lvwPlugCfg.Selected.Caption), Application.Handle, frmMain.Handle, FxImgGlobalCallback);

    		FreeLibrary(lib);
    		end
        else
        	ShowMessage(LoadLStr(607));
        end;
end;

procedure TfrmOptions.lvwPlugCfgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if (Key = VK_SPACE) then
    	lvwPlugCfgDblClick(Self);
end;

end.
