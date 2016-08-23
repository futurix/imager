unit w_lsJPEG_rotate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComObj, ShlObj, ActiveX, Buttons,
  ImageEnIO,
  c_const, c_utils, c_reg;

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
  public
    transf: TIEJpegTransform;
    apply_transf: boolean;
    cut_rect: TRect;
    img_width: integer;
    img_height: integer;
  end;

var
  frmJPEG: TfrmJPEG;


implementation

uses w_lsJPEG_cut;

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
  transf := jtNone;
  apply_transf := true;
  img_width := 0;
  img_height := 0;

  cbxEXIF.Checked := FxRegRBool('LosslessJPEG_UpdateExif', true);
  cbxBackup.Checked := FxRegRBool('LosslessJPEG_MakeBackup', false);
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

  if not Assigned(frmCut) then
    begin
    frmCut := TfrmCut.Create(Application);
    frmCut.ShowModal();
    FreeAndNil(frmCut);
    end;

  Close();
end;

procedure TfrmJPEG.sbnNoneClick(Sender: TObject);
begin
  transf := jtNone;

  Close();
end;

end.
