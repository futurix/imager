unit w_setup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, Dialogs, ColorPickerButton,
  c_const, c_utils;

type
  TfrmSetup = class(TForm)
    cbxOpenAfterSave: TCheckBox;
    lblSWinColor: TLabel;
    lblSFSColor: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    cbxAllFiles: TCheckBox;
    cbxFullPath: TCheckBox;
    pkrColor: TColorPickerButton;
    pkrFSColor: TColorPickerButton;
    gbxGeneralSettings: TGroupBox;
    gbxColors: TGroupBox;
    cbxUseLargeToolbarButtons: TCheckBox;
    cbxNoMRU: TCheckBox;

    procedure LoadSettings();
    procedure SaveSettings();
    procedure UpdateSettings();

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
	frmSetup: TfrmSetup;


implementation

uses main, globals, f_ui, f_plugins, f_reg;

{$R *.DFM}

// loads all settings from INI
procedure TfrmSetup.LoadSettings();
begin
	reg.OpenKey(sReg + '\Main', true);
	if reg.RInt('OpenAfterSave', 1) = 1 then
    	cbxOpenAfterSave.Checked := true
    else
    	cbxOpenAfterSave.Checked := false;
	pkrColor.SelectionColor := StringToColor(reg.RStr('Color', 'clAppWorkSpace'));
	pkrFSColor.SelectionColor := StringToColor(reg.RStr('FSColor', 'clBlack'));
	if reg.RInt('OpenDef', 1) = 1 then
    	cbxAllFiles.Checked := true
    else
    	cbxAllFiles.Checked := false;
	if reg.RBool('NoMRU', false) = true then
    	cbxNoMRU.Checked := true
    else
    	cbxNoMRU.Checked := false;
	reg.CloseKey();

	reg.OpenKey(sReg + '\UI', true);
	if reg.RInt('TBStyle', 0) = 1 then
    	cbxUseLargeToolbarButtons.Checked := true
    else
    	cbxUseLargeToolbarButtons.Checked := false;
	if reg.RInt('FullPathInTitle', 0) = 1 then
    	cbxFullPath.Checked := true
    else
    	cbxFullPath.Checked := false;
	reg.CloseKey();
end;

// saves all settings to INI
procedure TfrmSetup.SaveSettings();
begin
	reg.OpenKey(sReg + '\Main', true);
	if cbxOpenAfterSave.Checked then
    	reg.WriteInteger('OpenAfterSave', 1)
    else
    	reg.WriteInteger('OpenAfterSave', 0);
	reg.WriteString('Color', ColorToString(pkrColor.SelectionColor));
	reg.WriteString('FSColor', ColorToString(pkrFSColor.SelectionColor));
	if cbxAllFiles.Checked then
    	reg.WriteInteger('OpenDef', 1)
    else
    	reg.WriteInteger('OpenDef', 0);
	if cbxNoMRU.Checked then
    	reg.WriteBool('NoMRU', true)
    else
    	reg.WriteBool('NoMRU', false);
	reg.CloseKey();

	reg.OpenKey(sReg + '\UI', true);
	if cbxUseLargeToolbarButtons.Checked then
    	reg.WriteInteger('TBStyle', 1)
    else
    	reg.WriteInteger('TBStyle', 0);
	if cbxFullPath.Checked then
    	reg.WriteInteger('FullPathInTitle', 1)
    else
    	reg.WriteInteger('FullPathInTitle', 0);
	reg.CloseKey();
end;

// updates all settings in real-time
procedure TfrmSetup.UpdateSettings();
begin
	if cbxOpenAfterSave.Checked then
    	Include(infSettings.options, opOpenAfterSave)
    else
    	Exclude(infSettings.options, opOpenAfterSave);

	if infSettings.full_screen then
    	frmMain.sbxMain.Color := pkrFSColor.SelectionColor
    else
    	frmMain.sbxMain.Color := pkrColor.SelectionColor;

	if cbxAllFiles.Checked then
    	Include(infSettings.options, opOpenDef)
    else
    	Exclude(infSettings.options, opOpenDef);

	if cbxNoMRU.Checked then
    	Include(infSettings.options, opNoMRU)
    else
    	Exclude(infSettings.options, opNoMRU);

	SetDialogs();

	if cbxUseLargeToolbarButtons.Checked then
    	ApplyToolbarSkin(true)
    else
    	ApplyToolbarSkin(false);

	if cbxFullPath.Checked then
    	Include(infSettings.options,opFullPathInTitle)
    else
    	Exclude(infSettings.options,opFullPathInTitle);

	Header();
end;

procedure TfrmSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
end;

procedure TfrmSetup.FormDestroy(Sender: TObject);
begin
	frmSetup := nil;
end;

procedure TfrmSetup.btnCancelClick(Sender: TObject);
begin
	frmSetup.Close();
end;

procedure TfrmSetup.FormCreate(Sender: TObject);
begin
	LoadSettings();
end;

procedure TfrmSetup.btnOKClick(Sender: TObject);
begin
	SaveSettings();
	UpdateSettings();
	frmSetup.Close();
end;

procedure TfrmSetup.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

end.
