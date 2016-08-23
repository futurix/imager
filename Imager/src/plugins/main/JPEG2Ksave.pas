unit JPEG2Ksave;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, c_locales, c_const, c_reg;

type
  TfrmJPsave = class(TForm)
    cbxLossless: TCheckBox;
    gbxCompression: TGroupBox;
    btnSave: TButton;
    btnCancel: TButton;
    lblQualityValue: TLabel;
    tbrQuality: TTrackBar;
    procedure cbxLosslessKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbxLosslessClick(Sender: TObject);
    procedure cbxLosslessMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tbrQualityChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
	frmJPsave: TfrmJPsave;
	jp2_confirm: boolean = false;


implementation

{$R *.dfm}

procedure TfrmJPsave.cbxLosslessKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	tbrQuality.Enabled := (not cbxLossless.Checked);
	lblQualityValue.Enabled := (not cbxLossless.Checked);
end;

procedure TfrmJPsave.cbxLosslessClick(Sender: TObject);
begin
	tbrQuality.Enabled := (not cbxLossless.Checked);
	lblQualityValue.Enabled := (not cbxLossless.Checked);
end;

procedure TfrmJPsave.cbxLosslessMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
	tbrQuality.Enabled := (not cbxLossless.Checked);
	lblQualityValue.Enabled := (not cbxLossless.Checked);
end;

procedure TfrmJPsave.btnSaveClick(Sender: TObject);
begin
    FxRegWInt('SaverJPEG2000_Quality', tbrQuality.Position);
    FxRegWBool('SaverJPEG2000_Lossless', cbxLossless.Checked);

	jp2_confirm := true;
	Self.Close();
end;

procedure TfrmJPsave.btnCancelClick(Sender: TObject);
begin
	Self.Close();
end;

procedure TfrmJPsave.tbrQualityChange(Sender: TObject);
begin
	lblQualityValue.Caption := IntToStr(tbrQuality.Position);
end;

procedure TfrmJPsave.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

procedure TfrmJPsave.FormCreate(Sender: TObject);
begin
    tbrQuality.Position := FxRegRInt('SaverJPEG2000_Quality', 50);
    cbxLossless.Checked := FxRegRBool('SaverJPEG2000_Lossless', true);

    cbxLosslessClick(Self);

    Self.Caption				:= LoadLStr(3090);

    gbxCompression.Caption		:= LoadLStr(3091);
    cbxLossless.Caption			:= LoadLStr(3092);

    btnSave.Caption				:= LoadLStr(56);
    btnCancel.Caption			:= LoadLStr(51);
end;

procedure TfrmJPsave.CreateParams(var Params: TCreateParams);
begin
	Params.Style := (Params.Style or WS_POPUP);

	inherited;

	if (Owner is TForm) then
		Params.WndParent := (Owner as TWinControl).Handle
	else if Assigned(Screen.ActiveForm) then
		Params.WndParent := Screen.ActiveForm.Handle;
end;

end.
