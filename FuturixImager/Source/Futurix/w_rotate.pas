unit w_rotate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImageEnProc, c_const, c_locales, c_reg;

type
  TfrmRotate = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    lblAngle: TLabel;
    lblQuality: TLabel;
    updAngle: TUpDown;
    edtAngle: TEdit;
    cmbQuality: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtAngleChange(Sender: TObject);
    procedure cmbQualityChange(Sender: TObject);
  private
    no_change: boolean;
  public
    procedure Localize();
  end;

var
  frmRotate: TfrmRotate;


implementation

uses main, w_editor;

{$R *.dfm}

procedure TfrmRotate.FormCreate(Sender: TObject);
begin
  no_change := false;

  Localize();

  // working
  if Assigned(frmEditor) then
    ProcessPreview(0);

  // loading settings
  updAngle.Position := FxRegRInt('Angle', 90, sModules + '\Rotate');
  cmbQuality.ItemIndex := FxRegRInt('Quality', 3, sModules + '\Rotate');
end;

procedure TfrmRotate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmRotate.FormDestroy(Sender: TObject);
begin
  frmRotate := nil;
end;

procedure TfrmRotate.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    Self.Close();
end;

procedure TfrmRotate.btnOKClick(Sender: TObject);
var
  tmp_aa: boolean;
  tmp_mode: TIEAntialiasMode;
begin
  // saving settings
  FxRegWInt('Angle', updAngle.Position, sModules + '\Rotate');
  FxRegWInt('Quality', cmbQuality.ItemIndex, sModules + '\Rotate');

  if Assigned(frmEditor) then
    begin
    case cmbQuality.ItemIndex of
      0:
        begin
        tmp_aa := true;
        tmp_mode := ierBicubic;
        end;
      1:
        begin
        tmp_aa := true;
        tmp_mode := ierBilinear;
        end;
      2:
        begin
        tmp_aa := true;
        tmp_mode := ierFast;
        end;
      3:
        begin
        tmp_aa := false;
        tmp_mode := ierBicubic;
        end;
      else
        begin
        tmp_aa := true;
        tmp_mode := ierBicubic;
        end;
    end;

    frmEditor.proc.Rotate(updAngle.Position, tmp_aa, tmp_mode, frmEditor.sbxColor.Color);
    frmEditor.proc.ClearAllRedo();
    end;

  Self.Close();
end;

procedure TfrmRotate.btnCancelClick(Sender: TObject);
begin
  Self.Close();
end;

procedure TfrmRotate.edtAngleChange(Sender: TObject);
var
  tmp_aa: boolean;
  tmp_mode: TIEAntialiasMode;
  tmp_value: integer;
begin
  if no_change then
    Exit;

  no_change := true;

  try
    tmp_value := StrToInt(edtAngle.Text);
  except
    tmp_value := 0;
  end;

  if (tmp_value < 0) then
    updAngle.Position := 0
  else if (tmp_value > 360) then
    updAngle.Position := 360;

  if Assigned(frmEditor) then
    begin
    case cmbQuality.ItemIndex of
      0:
        begin
        tmp_aa := true;
        tmp_mode := ierBicubic;
        end;
      1:
        begin
        tmp_aa := true;
        tmp_mode := ierBilinear;
        end;
      2:
        begin
        tmp_aa := true;
        tmp_mode := ierFast;
        end;
      3:
        begin
        tmp_aa := false;
        tmp_mode := ierBicubic;
        end;
      else
        begin
        tmp_aa := false;
        tmp_mode := ierBicubic;
        end;
    end;

    frmEditor.imgPreview.IEBitmap.AssignImage(frmEditor.img.IEBitmap);

    if (updAngle.Position = 0) then
      frmEditor.imgPreview.Proc.Rotate(360, tmp_aa, tmp_mode, frmEditor.sbxColor.Color)
    else
      frmEditor.imgPreview.Proc.Rotate(updAngle.Position, tmp_aa, tmp_mode, frmEditor.sbxColor.Color);
    end;

  no_change := false;
end;

procedure TfrmRotate.cmbQualityChange(Sender: TObject);
begin
  edtAngleChange(Self);
end;

procedure TfrmRotate.Localize();
begin
  Self.Caption            := LoadLStr(800);
  lblAngle.Caption        := LoadLStr(801);
  lblQuality.Caption      := LoadLStr(802);
  cmbQuality.Items[0]     := LoadLStr(803);
  cmbQuality.Items[1]     := LoadLStr(804);
  cmbQuality.Items[2]     := LoadLStr(805);
  cmbQuality.Items[3]     := LoadLStr(806);
  btnOK.Caption           := LoadLStr(50);
  btnCancel.Caption       := LoadLStr(51);
end;

end.
