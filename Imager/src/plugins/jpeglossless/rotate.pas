unit rotate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComObj, ShlObj, ActiveX, c_const, c_utils, c_locales,
  Buttons, ImageEnIO, c_reg;

type
  TfrmJPEG = class(TForm)
    btnCancel: TButton;
    sbnRotate90: TSpeedButton;
    sbnRotate180: TSpeedButton;
    sbnRotate270: TSpeedButton;
    sbnFlipH: TSpeedButton;
    sbnFlipV: TSpeedButton;
    sbnTranspose: TSpeedButton;
    sbnTransverse: TSpeedButton;
    sbnCut: TSpeedButton;
    sbnNone: TSpeedButton;
    cbxEXIF: TCheckBox;
    cbxBackup: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbnRotate90Click(Sender: TObject);
    procedure sbnRotate180Click(Sender: TObject);
    procedure sbnRotate270Click(Sender: TObject);
    procedure sbnFlipHClick(Sender: TObject);
    procedure sbnFlipVClick(Sender: TObject);
    procedure sbnTransposeClick(Sender: TObject);
    procedure sbnTransverseClick(Sender: TObject);
    procedure sbnCutClick(Sender: TObject);
    procedure sbnNoneClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
	frmJPEG: TfrmJPEG;
	transf: TIEJpegTransform = jtNone;
	apply_transf: boolean = true;
  

implementation

{$R *.DFM}

procedure TfrmJPEG.btnCancelClick(Sender: TObject);
begin
    apply_transf := false;
    transf := jtNone;

	Close();
end;

procedure TfrmJPEG.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    FxRegWBool('LosslessJPEG_UpdateExif', cbxEXIF.Checked);
    FxRegWBool('LosslessJPEG_MakeBackup', cbxBackup.Checked);

	Action := caFree;
end;

procedure TfrmJPEG.FormDestroy(Sender: TObject);
begin
	frmJPEG := nil;
end;

procedure TfrmJPEG.FormCreate(Sender: TObject);
begin
	Self.Caption        	:= LoadLStr(3400);

    sbnRotate90.Caption		:= LoadLStr(3404);
    sbnRotate180.Caption	:= LoadLStr(3405);
    sbnRotate270.Caption	:= LoadLStr(3406);
    sbnFlipH.Caption		:= LoadLStr(3407);
    sbnFlipV.Caption		:= LoadLStr(3408);
    sbnTranspose.Caption	:= LoadLStr(3409);
    sbnTransverse.Caption	:= LoadLStr(3410);
    sbnCut.Caption			:= LoadLStr(3411);
    sbnNone.Caption			:= LoadLStr(3412);
    cbxEXIF.Caption			:= LoadLStr(3414);
    cbxBackup.Caption		:= LoadLStr(3415);

    btnCancel.Caption		:= LoadLStr(51);

    cbxEXIF.Checked			:= FxRegRBool('LosslessJPEG_UpdateExif', true);
    cbxBackup.Checked		:= FxRegRBool('LosslessJPEG_MakeBackup', false);
end;

procedure TfrmJPEG.CreateParams(var Params: TCreateParams);
begin
	Params.Style := (Params.Style or WS_POPUP);

	inherited;

	if (Owner is TForm) then
		Params.WndParent := (Owner as TWinControl).Handle
	else if Assigned(Screen.ActiveForm) then
		Params.WndParent := Screen.ActiveForm.Handle;
end;

procedure TfrmJPEG.sbnRotate90Click(Sender: TObject);
begin
	transf := jtRotate90;

    Close();
end;

procedure TfrmJPEG.sbnRotate180Click(Sender: TObject);
begin
	transf := jtRotate180;

    Close();
end;

procedure TfrmJPEG.sbnRotate270Click(Sender: TObject);
begin
	transf := jtRotate270;

    Close();
end;

procedure TfrmJPEG.sbnFlipHClick(Sender: TObject);
begin
	transf := jtHorizFlip;

    Close();
end;

procedure TfrmJPEG.sbnFlipVClick(Sender: TObject);
begin
	transf := jtVertFlip;

    Close();
end;

procedure TfrmJPEG.sbnTransposeClick(Sender: TObject);
begin
	transf := jtTranspose;

    Close();
end;

procedure TfrmJPEG.sbnTransverseClick(Sender: TObject);
begin
	transf := jtTransverse;

    Close();
end;

procedure TfrmJPEG.sbnCutClick(Sender: TObject);
begin
	transf := jtCut;

    Close();
end;

procedure TfrmJPEG.sbnNoneClick(Sender: TObject);
begin
	transf := jtNone;

    Close();
end;

end.
