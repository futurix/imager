unit ScanOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, c_const, c_locales, c_reg, c_utils;

type
  TfrmScanOpt = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    rgpSystem: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  frmScanOpt: TfrmScanOpt;


implementation

{$R *.dfm}

procedure TfrmScanOpt.FormCreate(Sender: TObject);
begin
  Self.Caption          := LoadLStr(3701);

  rgpSystem.Caption     := LoadLStr(3702);
  rgpSystem.Items[0]    := LoadLStr(3704);
  rgpSystem.Items[1]    := LoadLStr(3705);

  btnOK.Caption         := LoadLStr(50);
  btnCancel.Caption     := LoadLStr(51);

  rgpSystem.ItemIndex   := FxRegRInt('Imaging_Subsystem', 0);
end;

procedure TfrmScanOpt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // doing nothing
end;

procedure TfrmScanOpt.CreateParams(var Params: TCreateParams);
begin
  Params.Style := (Params.Style or WS_POPUP);

  inherited;

  if (Owner is TForm) then
    Params.WndParent := (Owner as TWinControl).Handle
  else if Assigned(Screen.ActiveForm) then
    Params.WndParent := Screen.ActiveForm.Handle;
end;

procedure TfrmScanOpt.btnOKClick(Sender: TObject);
begin
  FxRegWInt('Imaging_Subsystem', rgpSystem.ItemIndex);

  Close();
end;

procedure TfrmScanOpt.btnCancelClick(Sender: TObject);
begin
  Close();
end;

end.
