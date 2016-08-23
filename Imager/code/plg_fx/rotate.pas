unit rotate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, RotImg, ComCtrls, ColorPickerButton, c_const;

type
  TfrmRotate = class(TForm)
    sbxRotate: TScrollBox;
    imgRotate: TRotateImage;
    btnPreview: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    gbxAngle: TGroupBox;
    edtAngle: TEdit;
    gbxColor: TGroupBox;
    cbxAutoSize: TCheckBox;
    tbrAngle: TTrackBar;
    pkrColor: TColorPickerButton;
    btn90Left: TButton;
    btn90Right: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure cbxAutoSizeClick(Sender: TObject);
    procedure tbrAngleChange(Sender: TObject);
    procedure pkrColorChange(Sender: TObject);
    procedure btn90LeftClick(Sender: TObject);
    procedure btn90RightClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRotate: TfrmRotate;


implementation

uses fx;

{$R *.DFM}

procedure TfrmRotate.btnCancelClick(Sender: TObject);
begin
Close();
end;

procedure TfrmRotate.btnOKClick(Sender: TObject);
begin
canceled:=false;
bmp:=CreateRotatedBitmap(bmp,tbrAngle.Position,pkrColor.SelectionColor);
Close();
end;

procedure TfrmRotate.FormCreate(Sender: TObject);
begin
// loading image
imgRotate.Picture.Bitmap.Assign(bmp);
end;

procedure TfrmRotate.btnPreviewClick(Sender: TObject);
var
   r_angle: extended;
begin
r_angle:=0;
try
  r_angle:=StrToFloat(edtAngle.Text);
  except
  on EConvertError do
    begin
    Abort();
    Application.MessageBox('You need to provide correct rotation angle!','Error!',MB_OK+MB_ICONERROR);
    end;
  else Abort();
  end;
  imgRotate.Angle:=r_angle;
end;

procedure TfrmRotate.cbxAutoSizeClick(Sender: TObject);
begin
if cbxAutoSize.Checked=true then imgRotate.AutoSize:=true
else imgRotate.AutoSize:=false;
end;

procedure TfrmRotate.tbrAngleChange(Sender: TObject);
begin
edtAngle.Text:=IntToStr(tbrAngle.Position);
imgRotate.Angle:=tbrAngle.Position;
end;

procedure TfrmRotate.pkrColorChange(Sender: TObject);
begin
imgRotate.Color:=pkrColor.SelectionColor;
end;

procedure TfrmRotate.btn90LeftClick(Sender: TObject);
begin
if tbrAngle.Position=90 then tbrAngle.Position:=360
else if tbrAngle.Position=0 then tbrAngle.Position:=270
else tbrAngle.Position:=tbrAngle.Position-90;
end;

procedure TfrmRotate.btn90RightClick(Sender: TObject);
begin
if tbrAngle.Position=270 then tbrAngle.Position:=0
else if tbrAngle.Position=360 then tbrAngle.Position:=90
else tbrAngle.Position:=tbrAngle.Position+90;
end;

end.
