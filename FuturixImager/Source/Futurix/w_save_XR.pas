unit w_save_XR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  c_const, c_reg;

type
  TfrmXRsave = class(TForm)
    btnSave: TButton;
    btnCancel: TButton;
    tbrQuality: TTrackBar;
    lblQualityValue: TLabel;
    cbxLossless: TCheckBox;
    gbxQuality: TGroupBox;
    bvlSep: TBevel;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tbrQualityChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
  public
    xr_confirm: boolean;
  end;

var
  frmXRsave: TfrmXRsave;


implementation

{$R *.dfm}

procedure TfrmXRsave.btnSaveClick(Sender: TObject);
begin
  FxRegWInt('XR_Quality', tbrQuality.Position);
  FxRegWBool('XR_Lossless', cbxLossless.Checked);

  xr_confirm := true;
  Self.Close();
end;

procedure TfrmXRsave.btnCancelClick(Sender: TObject);
begin
  Self.Close();
end;

procedure TfrmXRsave.tbrQualityChange(Sender: TObject);
begin
  lblQualityValue.Caption := IntToStr(tbrQuality.Position);
end;

procedure TfrmXRsave.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Self.Close();
end;

procedure TfrmXRsave.FormCreate(Sender: TObject);
begin
  xr_confirm := false;

  tbrQuality.Position   := FxRegRInt('XR_Quality', 80);
  cbxLossless.Checked   := FxRegRBool('XR_Lossless', false);
end;

end.
