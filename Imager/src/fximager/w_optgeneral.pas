unit w_optgeneral;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, Dialogs, CheckLst, ShellAPI,
  c_const, c_utils, c_locales, imageenio, hyiedefs, hyieutils;

type
  TfrmOptGeneral = class(TForm)
    cbxOpenAfterSave: TCheckBox;
    lblSWinColor: TLabel;
    lblSFSColor: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    cbxAllFiles: TCheckBox;
    cbxFullPath: TCheckBox;
    cbxNoMRU: TCheckBox;
    lblClearMRU: TLabel;
    sbxMainColor: TScrollBox;
    sbxFSColor: TScrollBox;
    cbxProgress: TCheckBox;
    lblArrows: TLabel;
    cbxArrows: TComboBox;
    lblEnter: TLabel;
    cbxEnter: TComboBox;
    cbxFitAll: TCheckBox;
    cbxDblClick: TCheckBox;
    lblWheel: TLabel;
    cbxWheel: TComboBox;
    lblMouseDrag: TLabel;
    cbxMouseDrag: TComboBox;
    lblNewImage: TLabel;
    cbxNewImage: TComboBox;
    pclOptions: TPageControl;
    shtGeneral: TTabSheet;
    shtBeh: TTabSheet;
    shtPerformance: TTabSheet;
    lblWarning: TLabel;
    lblWarnRAM: TLabel;
    cbxHighQ: TCheckBox;
    cbxDelayHighQ: TCheckBox;
    cbxCMS: TCheckBox;
    cbxUseMemory: TCheckBox;
    shtTasks: TTabSheet;
    sbnFileFormats: TSpeedButton;
    sbnPlugins: TSpeedButton;
    sbnLanguages: TSpeedButton;
    cbxInstance: TCheckBox;
    cbxReverseWheel: TCheckBox;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblClearMRUClick(Sender: TObject);
    procedure sbxMainColorClick(Sender: TObject);
    procedure sbxFSColorClick(Sender: TObject);
    procedure sbnFileFormatsClick(Sender: TObject);
    procedure sbnPluginsClick(Sender: TObject);
    procedure sbnLanguagesClick(Sender: TObject);
  private
  public
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Localize();
  end;

var
	frmOptGeneral: TfrmOptGeneral;


implementation

uses main, f_ui, f_plugins, f_scan, f_tools, w_show, f_images,
  w_optformats, w_optlang, w_optplugins;

{$R *.DFM}

procedure TfrmOptGeneral.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
end;

procedure TfrmOptGeneral.FormDestroy(Sender: TObject);
begin
	frmOptGeneral := nil;
end;

procedure TfrmOptGeneral.btnCancelClick(Sender: TObject);
begin
	Self.Close();
end;

procedure TfrmOptGeneral.FormCreate(Sender: TObject);
begin
    Localize();

    reg.OpenKey(sSettings, true);

	if reg.RInt('OpenAfterSave', 1) = 1 then
    	cbxOpenAfterSave.Checked := true
    else
    	cbxOpenAfterSave.Checked := false;

	sbxMainColor.Color := StringToColor(reg.RStr('Color', 'clAppWorkSpace'));
	sbxFSColor.Color := StringToColor(reg.RStr('FSColor', 'clBlack'));
	if reg.RInt('OpenDef', 1) = 1 then
    	cbxAllFiles.Checked := true
    else
    	cbxAllFiles.Checked := false;
	if reg.RBool('NoMRU', false) = true then
    	cbxNoMRU.Checked := true
    else
    	cbxNoMRU.Checked := false;
    
    cbxProgress.Checked := reg.RBool('ProgressiveImageLoad', false);
    cbxArrows.ItemIndex := reg.RInt('ArrowKeys', 0);
    cbxEnter.ItemIndex := reg.RInt('EnterKey', 0);
    cbxFitAll.Checked := reg.RBool('EnableFitAll', false);
    cbxDblClick.Checked := reg.RBool('FSonDblClick', true);
    cbxWheel.ItemIndex := reg.RInt('MouseWheel', 0);
    cbxMouseDrag.ItemIndex := reg.RInt('MouseDrag', 0);
    cbxNewImage.ItemIndex := reg.RInt('OnNewBitmap', 0);
    cbxHighQ.Checked := reg.RBool('HighQualityDisplay', false);
    cbxDelayHighQ.Checked := reg.RBool('DelayZoomFilter', true);
    cbxCMS.Checked := reg.RBool('UseCMS', false);
    cbxUseMemory.Checked := reg.RBool('PreferRAM', false);
    cbxInstance.Checked := not reg.RBool('OneInstanceOnly', false);
    cbxReverseWheel.Checked := reg.RBool('ReverseMouseWheel', false);

	if reg.RInt('FullPathInTitle', 0) = 1 then
    	cbxFullPath.Checked := true
    else
    	cbxFullPath.Checked := false;
    	
    reg.CloseKey();
end;

procedure TfrmOptGeneral.btnOKClick(Sender: TObject);
begin
    // saving settings
    reg.OpenKey(sSettings, true);

	if cbxOpenAfterSave.Checked then
    	reg.WriteInteger('OpenAfterSave', 1)
    else
    	reg.WriteInteger('OpenAfterSave', 0);

	reg.WriteString('Color', ColorToString(sbxMainColor.Color));
	reg.WriteString('FSColor', ColorToString(sbxFSColor.Color));

	if cbxAllFiles.Checked then
    	reg.WriteInteger('OpenDef', 1)
    else
    	reg.WriteInteger('OpenDef', 0);

	reg.WriteBool('NoMRU', cbxNoMRU.Checked);
    
    reg.WBool('ProgressiveImageLoad', cbxProgress.Checked);
    reg.WInteger('ArrowKeys', cbxArrows.ItemIndex);
    reg.WInteger('EnterKey', cbxEnter.ItemIndex);
    reg.WBool('EnableFitAll', cbxFitAll.Checked);
    reg.WBool('FSonDblClick', cbxDblClick.Checked);
    reg.WInteger('MouseWheel', cbxWheel.ItemIndex);
    reg.WInteger('MouseDrag', cbxMouseDrag.ItemIndex);
    reg.WInteger('OnNewBitmap', cbxNewImage.ItemIndex);
    reg.WBool('HighQualityDisplay', cbxHighQ.Checked);
    reg.WBool('DelayZoomFilter', cbxDelayHighQ.Checked);
    reg.WBool('UseCMS', cbxCMS.Checked);
    reg.WBool('PreferRAM', cbxUseMemory.Checked);
    reg.WBool('OneInstanceOnly', not cbxInstance.Checked);
    reg.WBool('ReverseMouseWheel', cbxReverseWheel.Checked);

	if cbxFullPath.Checked then
    	reg.WriteInteger('FullPathInTitle', 1)
    else
    	reg.WriteInteger('FullPathInTitle', 0);
    	
    reg.CloseKey();

	// updating settings
    frmMain.miDSFitAll.Visible := cbxFitAll.Checked;
    frmMain.piDSFitAll.Visible := frmMain.miDSFitAll.Visible;
    if not cbxFitAll.Checked then
    	if (GetDisplayStyle() = dsFitAll) then
    		SetDisplayStyle(dsFitBig);

    frmMain.bFSonDblClick := cbxDblClick.Checked;
    frmMain.nArrows := cbxArrows.ItemIndex;
    frmMain.nMouseWheel := cbxWheel.ItemIndex;
    frmMain.bReverseWheel := cbxReverseWheel.Checked;
    frmMain.nMouseDrag := cbxMouseDrag.ItemIndex;
    frmMain.nNewBitmap := cbxNewImage.ItemIndex;
    frmMain.nEnter := cbxEnter.ItemIndex;
    frmMain.bOpenAfterSave := cbxOpenAfterSave.Checked;
    frmMain.bProgressiveLoad := cbxProgress.Checked;

	if frmMain.full_screen then
    	frmMain.sbxMain.Color := sbxFSColor.Color
    else
    	frmMain.sbxMain.Color := sbxMainColor.Color;
    frmMain.img.Background := frmMain.sbxMain.Color;

    frmMain.bOpenDef := cbxAllFiles.Checked;
    frmMain.bNoMRU := cbxNoMRU.Checked;

	SetDialogs();

    SetDisplayStyle(GetDisplayStyle());

    frmMain.bFullPathInTitle := cbxFullPath.Checked;

	Header();

    if cbxHighQ.Checked then
    	frmMain.img.ZoomFilter := rfFastLinear
    else
    	frmMain.img.ZoomFilter := rfNone;

    iegEnableCMS := cbxCMS.Checked;

    if cbxUseMemory.Checked then
    	IEDefMinFileSize := 268435456
    else
    	IEDefMinFileSize := -1;

    frmMain.img.DelayZoomFilter := cbxDelayHighQ.Checked;

	Self.Close();
end;

procedure TfrmOptGeneral.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

procedure TfrmOptGeneral.lblClearMRUClick(Sender: TObject);
begin
    frmMain.MRU.Files.Clear();
end;

procedure TfrmOptGeneral.CreateParams(var Params: TCreateParams);
begin
	Params.Style := (Params.Style or WS_POPUP);

	inherited;

	if (Owner is TForm) then
		Params.WndParent := (Owner as TWinControl).Handle
	else if Assigned(Screen.ActiveForm) then
		Params.WndParent := Screen.ActiveForm.Handle;
end;

procedure TfrmOptGeneral.Localize();
var
	temp_itemindex: integer;
begin
    Self.Caption				:= LoadLStr(840);

    shtTasks.Caption			:= LoadLStr(845);

    sbnFileFormats.Caption		:= LoadLStr(843);
    sbnPlugins.Caption			:= LoadLStr(862);
    sbnLanguages.Caption		:= LoadLStr(844);

    shtGeneral.Caption 			:= LoadLStr(841);

    cbxFitAll.Caption			:= LoadLStr(3306);
    cbxFullPath.Caption			:= LoadLStr(846);
    cbxAllFiles.Caption			:= LoadLStr(848);
    cbxOpenAfterSave.Caption	:= LoadLStr(847);
    cbxNoMRU.Caption			:= LoadLStr(849);
    lblClearMRU.Caption			:= LoadLStr(851);
    lblSWinColor.Caption		:= LoadLStr(853);
    sbxMainColor.Hint			:= LoadLStr(745);
    lblSFSColor.Caption			:= LoadLStr(854);
    sbxFSColor.Hint				:= LoadLStr(745);
    cbxInstance.Caption			:= LoadLStr(874);

    shtBeh.Caption				:= LoadLStr(842);

    cbxDblClick.Caption			:= LoadLStr(3307);
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

    shtPerformance.Caption		:= LoadLStr(866);

    cbxProgress.Caption			:= LoadLStr(868);
    cbxHighQ.Caption			:= LoadLStr(869);
    lblWarning.Caption			:= LoadLStr(3308);
    cbxDelayHighQ.Caption		:= LoadLStr(873);
    cbxCMS.Caption				:= LoadLStr(3309);
    cbxUseMemory.Caption		:= LoadLStr(3310);
    lblWarnRAM.Caption			:= LoadLStr(3311);

    btnOK.Caption				:= LoadLStr(50);
    btnCancel.Caption			:= LoadLStr(51);
end;

procedure TfrmOptGeneral.sbxMainColorClick(Sender: TObject);
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

procedure TfrmOptGeneral.sbxFSColorClick(Sender: TObject);
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

procedure TfrmOptGeneral.sbnFileFormatsClick(Sender: TObject);
begin
	if not Assigned(frmOptFormats) then
  		begin
  		Application.CreateForm(TfrmOptFormats, frmOptFormats);
  		frmOptFormats.ShowModal();
  		end;
end;

procedure TfrmOptGeneral.sbnPluginsClick(Sender: TObject);
begin
	if not Assigned(frmOptPlugins) then
  		begin
  		Application.CreateForm(TfrmOptPlugins, frmOptPlugins);
  		frmOptPlugins.ShowModal();
  		end;
end;

procedure TfrmOptGeneral.sbnLanguagesClick(Sender: TObject);
begin
	if not Assigned(frmOptLang) then
  		begin
  		Application.CreateForm(TfrmOptLang, frmOptLang);
  		frmOptLang.ShowModal();
  		end;
end;

end.
