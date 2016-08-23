unit w_save_JPEG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls,
  c_const, c_reg;

type
  TfrmJPEGsave = class(TForm)
    btnSave: TButton;
    btnCancel: TButton;
    tbrQuality: TTrackBar;
    lblQualityValue: TLabel;
    cbxProgressive: TCheckBox;
    gbxQuality: TGroupBox;
    cbxOptimized: TCheckBox;
    bvlSep: TBevel;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tbrQualityChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
  public
    jpeg_confirm: boolean;
  end;

var
  frmJPEGsave: TfrmJPEGsave;


implementation

{$R *.dfm}

procedure TfrmJPEGsave.btnSaveClick(Sender: TObject);
begin
  FxRegWInt('JPEG_Quality', tbrQuality.Position);
  FxRegWBool('JPEG_Progressive', cbxProgressive.Checked);
  FxRegWBool('JPEG_Optimized', cbxOptimized.Checked);

  jpeg_confirm := true;
  Self.Close();
end;

procedure TfrmJPEGsave.btnCancelClick(Sender: TObject);
begin
  Self.Close();
end;

procedure TfrmJPEGsave.tbrQualityChange(Sender: TObject);
begin
  lblQualityValue.Caption := IntToStr(tbrQuality.Position);
end;

procedure TfrmJPEGsave.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Self.Close();
end;

procedure TfrmJPEGsave.FormCreate(Sender: TObject);
begin
  jpeg_confirm := false;

  tbrQuality.Position := FxRegRInt('JPEG_Quality', 85);
  cbxProgressive.Checked := FxRegRBool('JPEG_Progressive', false);
  cbxOptimized.Checked := FxRegRBool('JPEG_Optimized', true);
end;

end.
