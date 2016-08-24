unit XRsave;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, c_locales, c_const, c_reg;

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
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  frmXRsave: TfrmXRsave;
  xr_confirm: boolean = false;


implementation

{$R *.dfm}

procedure TfrmXRsave.btnSaveClick(Sender: TObject);
begin
  FxRegWInt('SaverXR_Quality', tbrQuality.Position);
  FxRegWBool('SaverXR_Lossless', cbxLossless.Checked);

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
  tbrQuality.Position := FxRegRInt('SaverXR_Quality', 80);
  cbxLossless.Checked := FxRegRBool('SaverXR_Lossless', false);

  Self.Caption          := LoadLStr(3650);
  gbxQuality.Caption    := LoadLStr(3087);

  cbxLossless.Caption    := LoadLStr(3651);

  btnSave.Caption        := LoadLStr(56);
  btnCancel.Caption      := LoadLStr(51);
end;

procedure TfrmXRsave.CreateParams(var Params: TCreateParams);
begin
  Params.Style := (Params.Style or WS_POPUP);

  inherited;

  if (Owner is TForm) then
    Params.WndParent := (Owner as TWinControl).Handle
  else if Assigned(Screen.ActiveForm) then
    Params.WndParent := Screen.ActiveForm.Handle;
end;

end.
