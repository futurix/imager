unit crop;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls,
  c_const;

type
  TfrmCrop = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    edtTop: TEdit;
    edtBottom: TEdit;
    edtRight: TEdit;
    edtLeft: TEdit;
    udTop: TUpDown;
    udBottom: TUpDown;
    udRight: TUpDown;
    udLeft: TUpDown;
    lblTop: TLabel;
    lblLeft: TLabel;
    lblRight: TLabel;
    lblBottom: TLabel;
    sbxPreview: TScrollBox;
    imgPreview: TImage;
    btnPreview: TButton;
    btnReset: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure imgPreviewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure udTopClick(Sender: TObject; Button: TUDBtnType);
    procedure udLeftClick(Sender: TObject; Button: TUDBtnType);
    procedure udRightClick(Sender: TObject; Button: TUDBtnType);
    procedure udBottomClick(Sender: TObject; Button: TUDBtnType);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
function FIPISfilter(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;

var
  frmCrop: TfrmCrop;
  bmp: TBitmap;
  canceled: boolean = true;
  top_left: boolean = true;

implementation

{$R *.DFM}

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL;
begin
func(PT_FFILTER,'Crop',' ');
Result:=true;
end;

function FIPISfilter(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap;
begin
if preview then
  Result:=0
else
  begin
  // tuning form
  Application.Handle:=app;

  // tuning bitmap
  bmp:=TBitmap.Create();
  bmp.Handle:=img;

  // starting
  frmCrop:=TfrmCrop.Create(Application);
  frmCrop.imgPreview.Picture.Bitmap.Assign(bmp);

  // displaying
  frmCrop.ShowModal();
  frmCrop.Free();

  // ending
  if canceled then
    Result:=0
  else
    Result:=bmp.ReleaseHandle;
  bmp.Free();
  end;
end;

procedure TfrmCrop.btnCancelClick(Sender: TObject);
begin
Close();
end;

procedure TfrmCrop.btnOKClick(Sender: TObject);
begin
canceled:=false;
btnPreviewClick(btnOK);
bmp.Assign(imgPreview.Picture.Bitmap);
Close();
end;

procedure TfrmCrop.FormCreate(Sender: TObject);
begin
udTop.Max:=bmp.Height-1;
udLeft.Max:=bmp.Width-1;
udBottom.Max:=bmp.Height-1;
udRight.Max:=bmp.Width-1;
end;

procedure TfrmCrop.btnPreviewClick(Sender: TObject);
var
  tmp: TBitmap;
begin
tmp:=TBitmap.Create();
tmp.Width:=bmp.Width-StrToInt(edtLeft.Text)-StrToInt(edtRight.Text);
tmp.Height:=bmp.Height-StrToInt(edtTop.Text)-StrToInt(edtBottom.Text);
tmp.Canvas.CopyRect(tmp.Canvas.ClipRect,bmp.Canvas,Rect(StrToInt(edtLeft.Text),StrToInt(edtTop.Text),bmp.Width-1-StrToInt(edtRight.Text),bmp.Height-1-StrToInt(edtBottom.Text)));
imgPreview.Picture.Bitmap.Assign(tmp);
tmp.Free();
end;

procedure TfrmCrop.btnResetClick(Sender: TObject);
begin
udTop.Position:=0;
udLeft.Position:=0;
udBottom.Position:=0;
udRight.Position:=0;
imgPreview.Picture.Bitmap.Assign(bmp);
end;

procedure TfrmCrop.imgPreviewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
if top_left then begin
                 // top-left
                 edtLeft.Text:=IntToStr(X+1);
                 edtTop.Text:=IntToStr(Y+1);
                 top_left:=false;
                 end
else begin
     // bottom-right
     edtBottom.Text:=IntToStr(bmp.Height-Y+1);
     edtRight.Text:=IntToStr(bmp.Width-X+1);
     top_left:=true;
     end;
end;

procedure TfrmCrop.udTopClick(Sender: TObject; Button: TUDBtnType);
begin
// check opposite up/down
if bmp.Height-udTop.Position-udBottom.Position<=0
   then udBottom.Position:=bmp.Height-udTop.Position-1;
// preview
btnPreviewClick(frmCrop);
end;

procedure TfrmCrop.udLeftClick(Sender: TObject; Button: TUDBtnType);
begin
// check opposite up/down
if bmp.Width-udLeft.Position-udRight.Position<=0
   then udRight.Position:=bmp.Width-udLeft.Position-1;
// preview
btnPreviewClick(frmCrop);
end;

procedure TfrmCrop.udRightClick(Sender: TObject; Button: TUDBtnType);
begin
// check opposite up/down
if bmp.Width-udRight.Position-udLeft.Position<=0
   then udLeft.Position:=bmp.Width-udRight.Position-1;
// preview
btnPreviewClick(frmCrop);
end;

procedure TfrmCrop.udBottomClick(Sender: TObject; Button: TUDBtnType);
begin
// check opposite up/down
if bmp.Height-udBottom.Position-udTop.Position<=0
   then udTop.Position:=bmp.Height-udBottom.Position-1;
// preview
btnPreviewClick(frmCrop);
end;

exports
	FIPISquery, FIPISfilter;

end.
