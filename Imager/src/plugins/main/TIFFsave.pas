unit TIFFsave;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, c_locales, c_const, c_reg;

type
  TfrmTIFFsave = class(TForm)
    gbxCompression: TGroupBox;
    rbnCNone: TRadioButton;
    rbnCLZW: TRadioButton;
    rbnCJPEG: TRadioButton;
    rbnCZLib: TRadioButton;
    rbnCPackBits: TRadioButton;
    rbnCG31: TRadioButton;
    rbnCG32: TRadioButton;
    rbnCG4: TRadioButton;
    gbxJPEG: TGroupBox;
    btnCancel: TButton;
    btnSave: TButton;
    tbrQuality: TTrackBar;
    lblQualityValue: TLabel;
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
  frmTIFFsave: TfrmTIFFsave;
  tiff_confirm: boolean = false;

implementation

{$R *.dfm}

procedure TfrmTIFFsave.btnSaveClick(Sender: TObject);
begin
tiff_confirm:=true;
Self.Close();
end;

procedure TfrmTIFFsave.btnCancelClick(Sender: TObject);
begin
Self.Close();
end;

procedure TfrmTIFFsave.tbrQualityChange(Sender: TObject);
begin
lblQualityValue.Caption:=IntToStr(tbrQuality.Position);
end;

procedure TfrmTIFFsave.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=VK_ESCAPE then
  Self.Close();
end;

procedure TfrmTIFFsave.FormCreate(Sender: TObject);
begin
    Self.Caption				:= LoadLStr(3093);

    gbxCompression.Caption		:= LoadLStr(3094);

    rbnCNone.Caption			:= LoadLStr(3095);
    rbnCLZW.Caption				:= LoadLStr(3096);
    rbnCJPEG.Caption			:= LoadLStr(3097);
    rbnCPackBits.Caption		:= LoadLStr(3098);
    rbnCZLib.Caption			:= LoadLStr(3099);
    rbnCG31.Caption				:= LoadLStr(3100);
    rbnCG32.Caption				:= LoadLStr(3101);
    rbnCG4.Caption				:= LoadLStr(3102);

    gbxJPEG.Caption				:= LoadLStr(3103);

    btnSave.Caption				:= LoadLStr(56);
    btnCancel.Caption			:= LoadLStr(51);
end;

procedure TfrmTIFFsave.CreateParams(var Params: TCreateParams);
begin
	Params.Style := (Params.Style or WS_POPUP);

	inherited;

	if (Owner is TForm) then
		Params.WndParent := (Owner as TWinControl).Handle
	else if Assigned(Screen.ActiveForm) then
		Params.WndParent := Screen.ActiveForm.Handle;
end;

end.
