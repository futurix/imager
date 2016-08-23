unit w_setup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, Dialogs, ColorPickerButton;

type
  TfrmSetup = class(TForm)
    pgcSetup: TPageControl;
    shtGeneral: TTabSheet;
    shtWeb: TTabSheet;
    cbxHints: TCheckBox;
    cbxOpenAfterSave: TCheckBox;
    edtReferer: TEdit;
    lblHRef: TLabel;
    lblHUA: TLabel;
    edtUA: TEdit;
    cbxDeleteTempOnExit: TCheckBox;
    shtColors: TTabSheet;
    lblSWinColor: TLabel;
    lblSFSColor: TLabel;
    dlgColor: TColorDialog;
    btnOK: TButton;
    btnCancel: TButton;
    cbxAllFiles: TCheckBox;
    cbxFullPath: TCheckBox;
    shtMasks: TTabSheet;
    gbxOpenDefFilter: TGroupBox;
    gbxBrowsingMask: TGroupBox;
    edtOpenDef: TEdit;
    edtBrowseDef: TEdit;
    pkrColor: TColorPickerButton;
    pkrFSColor: TColorPickerButton;
    cbxHand: TCheckBox;
    cbxAutoApply: TCheckBox;
    cbxFSCenter: TCheckBox;

    procedure LoadSettings();
    procedure SaveSettings();
    procedure UpdateSettings();

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSetup: TfrmSetup;

implementation

uses main, globals, f_strutils, f_ui, f_plugins, f_reg;

{$R *.DFM}

// loads all settings from INI
procedure TfrmSetup.LoadSettings();
begin
reg.OpenKey(sReg + '\Main',true);
if RegReadInt('Hints',1)=1 then cbxHints.Checked:=true else cbxHints.Checked:=false;
if RegReadInt('OpenAfterSave',1)=1 then cbxOpenAfterSave.Checked:=true else cbxOpenAfterSave.Checked:=false;
if RegReadInt('AutoApply',0)=1 then cbxAutoApply.Checked:=true else cbxAutoApply.Checked:=false;
if RegReadInt('DelTemp',0)=1 then cbxDeleteTempOnExit.Checked:=true else cbxDeleteTempOnExit.Checked:=false;
pkrColor.SelectionColor:=StringToColor(RegReadStr('Color','clAppWorkSpace'));
pkrFSColor.SelectionColor:=StringToColor(RegReadStr('FSColor','clBlack'));
if RegReadInt('FSCenter',1)=1 then cbxFSCenter.Checked:=true else cbxFSCenter.Checked:=false;
if RegReadInt('OpenDef',1)=1 then cbxAllFiles.Checked:=true else cbxAllFiles.Checked:=false;
reg.CloseKey();
reg.OpenKey(sReg + '\UI',true);
if RegReadInt('Handy',1)=1 then cbxHand.Checked:=true else cbxHand.Checked:=false;
if RegReadInt('FullPathInTitle',0)=1 then cbxFullPath.Checked:=true else cbxFullPath.Checked:=false;
reg.CloseKey();
reg.OpenKey(sReg + '\Web',true);
edtReferer.Text:=RegReadStr('Ref','');
edtUA.Text:=RegReadStr('UA','FuturisImagerC');
reg.CloseKey();
edtBrowseDef.Text:=infSettings.quick_mask;
reg.OpenKey(sFIPIS,true);
edtOpenDef.Text:=RegReadStr('DefaultFilter','');
reg.CloseKey();
end;

// saves all settings to INI
procedure TfrmSetup.SaveSettings();
begin
reg.OpenKey(sReg + '\Main',true);
if cbxHints.Checked then reg.WriteInteger('Hints',1) else reg.WriteInteger('Hints',0);
if cbxOpenAfterSave.Checked then reg.WriteInteger('OpenAfterSave',1) else reg.WriteInteger('OpenAfterSave',0);
if cbxAutoApply.Checked then reg.WriteInteger('AutoApply',1) else reg.WriteInteger('AutoApply',0);
if cbxDeleteTempOnExit.Checked then reg.WriteInteger('DelTemp',1) else reg.WriteInteger('DelTemp',0);
reg.WriteString('Color',ColorToString(pkrColor.SelectionColor));
reg.WriteString('FSColor',ColorToString(pkrFSColor.SelectionColor));
if cbxFSCenter.Checked then reg.WriteInteger('FSCenter',1) else reg.WriteInteger('FSCenter',0);
if cbxAllFiles.Checked then reg.WriteInteger('OpenDef',1) else reg.WriteInteger('OpenDef',0);
reg.CloseKey();
reg.OpenKey(sReg + '\UI',true);
if cbxFullPath.Checked then reg.WriteInteger('FullPathInTitle',1) else reg.WriteInteger('FullPathInTitle',0);
if cbxHand.Checked then reg.WriteInteger('Handy',1) else reg.WriteInteger('Handy',0);
reg.CloseKey();
reg.OpenKey(sReg + '\Web',true);
reg.WriteString('Ref',edtReferer.Text);
reg.WriteString('UA',edtUA.Text);
infSettings.quick_mask:=edtBrowseDef.Text;
reg.CloseKey();
reg.OpenKey(sFIPIS,true);
reg.WriteString('BrowsingMask',edtBrowseDef.Text);
reg.WriteString('DefaultFilter',edtOpenDef.Text);
reg.CloseKey();
end;

// updates all settings in real-time
procedure TfrmSetup.UpdateSettings();
begin
if cbxHints.Checked then
  begin
  Include(infSettings.options,opHints);
  Application.ShowHint:=true;
  end
else
  begin
  Exclude(infSettings.options,opHints);
  Application.ShowHint:=false;
  end;
if cbxOpenAfterSave.Checked then Include(infSettings.options,opOpenAfterSave) else Exclude(infSettings.options,opOpenAfterSave);
if cbxAutoApply.Checked then Include(infSettings.options,opAutoApply) else Exclude(infSettings.options,opAutoApply);
if cbxDeleteTempOnExit.Checked then Include(infSettings.options,opDelTempFiles) else Exclude(infSettings.options,opDelTempFiles);
infSettings.uagent:=edtUA.Text;
infSettings.appHome:=edtReferer.Text;
if infSettings.full_screen then frmMain.sbxMain.Color:=pkrFSColor.SelectionColor else frmMain.sbxMain.Color:=pkrColor.SelectionColor;
if cbxFSCenter.Checked then
  begin
  Include(infSettings.options,opFSCenter);
  if infSettings.full_screen then Center();
  end
else
  begin
  Exclude(infSettings.options,opFSCenter);
  if infSettings.full_screen then CenterCancel();
  end;
if cbxAllFiles.Checked then Include(infSettings.options,opOpenDef) else Exclude(infSettings.options,opOpenDef);
if cbxHand.Checked then
  begin
  infMouse.handy:=true;
  frmMain.imgMain.Cursor:=7;
  end
else
  begin
  infMouse.handy:=false;
  frmMain.imgMain.Cursor:=0;
  end;
SetDialogs();
if cbxFullPath.Checked then Include(infSettings.options,opFullPathInTitle) else Exclude(infSettings.options,opFullPathInTitle);
Header();
end;

procedure TfrmSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrmSetup.FormDestroy(Sender: TObject);
begin
frmSetup:=nil;
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

end.
