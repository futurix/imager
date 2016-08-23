unit JPEGsave;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, c_locales, c_const, c_reg;

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
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  frmJPEGsave: TfrmJPEGsave;
  jpeg_confirm: boolean = false;


implementation

{$R *.dfm}

procedure TfrmJPEGsave.btnSaveClick(Sender: TObject);
begin
    FxRegWInt('SaverJPEG_Quality', tbrQuality.Position);
    FxRegWBool('SaverJPEG_Progressive', cbxProgressive.Checked);
    FxRegWBool('SaverJPEG_Optimized', cbxOptimized.Checked);

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

procedure TfrmJPEGsave.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

procedure TfrmJPEGsave.FormCreate(Sender: TObject);
begin
    tbrQuality.Position := FxRegRInt('SaverJPEG_Quality', 85);
    cbxProgressive.Checked := FxRegRBool('SaverJPEG_Progressive', false);
    cbxOptimized.Checked := FxRegRBool('SaverJPEG_Optimized', true);

	Self.Caption				:= LoadLStr(3086);

    gbxQuality.Caption			:= LoadLStr(3087);

    cbxProgressive.Caption		:= LoadLStr(3088);
    cbxOptimized.Caption		:= LoadLStr(3089);

    btnSave.Caption				:= LoadLStr(56);
    btnCancel.Caption			:= LoadLStr(51);
end;

procedure TfrmJPEGsave.CreateParams(var Params: TCreateParams);
begin
	Params.Style := (Params.Style or WS_POPUP);

	inherited;

	if (Owner is TForm) then
		Params.WndParent := (Owner as TWinControl).Handle
	else if Assigned(Screen.ActiveForm) then
		Params.WndParent := Screen.ActiveForm.Handle;
end;

end.
