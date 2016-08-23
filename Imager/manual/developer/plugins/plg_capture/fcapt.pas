unit fcapt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ASGCapture, c_const, c_reg, StdCtrls;

type
  TfrmCapture = class(TForm)
    scrCapture: TASGScreenCapture;
    btnCapture: TButton;
    btnCancel: TButton;
    gbxCaptureType: TGroupBox;
    rbnCaptDesktop: TRadioButton;
    rbnCaptActWindow: TRadioButton;
    rbnCaptSelection: TRadioButton;
    rbnCaptPolygon: TRadioButton;
    cbxHideImager: TCheckBox;
    cbxCaptureCursor: TCheckBox;
    cbxDelay: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCaptureClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCapture: TfrmCapture;
  image: TBitmap;
  reg: TFuturisRegistry;

function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
function FImport(info: PChar; app, wnd: THandle):hBitmap; stdcall;

implementation

{$R *.dfm}

function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL;
begin
func(PT_FIMPORT,'Screen Capture...',' ');
Result:=true;
end;

function FImport(info: PChar; app, wnd: THandle):hBitmap;
begin
Application.Handle:=app;
Application.MainForm.Hide();

image:=TBitmap.Create();

frmCapture:=TfrmCapture.Create(Application);
frmCapture.ShowModal();

Application.MainForm.Show();
FreeAndNil(frmCapture);

if image.Empty=false then
  Result:=image.ReleaseHandle()
else
  Result:=0;
FreeAndNil(image);
end;

exports
  FQuery, FImport;

procedure TfrmCapture.FormCreate(Sender: TObject);
begin
reg:=TFuturisRegistry.Create();
reg.RootKey:=HKEY_CURRENT_USER;
reg.OpenKey(sReg + '\ScreenCapture',true);
cbxHideImager.Checked:=reg.RBool('HideWnd',true);
cbxCaptureCursor.Checked:=reg.RBool('CaptureCursor',false);
cbxDelay.Checked:=reg.RBool('CaptureDelay',true);
case reg.RInt('CaptureType',0) of
	0: rbnCaptDesktop.Checked:=true;
    1: rbnCaptActWindow.Checked:=true;
    2: rbnCaptSelection.Checked:=true;
    3: rbnCaptPolygon.Checked:=true;
    end;
reg.CloseKey();
end;

procedure TfrmCapture.FormClose(Sender: TObject; var Action: TCloseAction);
begin
reg.OpenKey(sReg + '\ScreenCapture',true);
if rbnCaptDesktop.Checked then
  begin
  reg.WInteger('CaptureType', 0);
  end
else if rbnCaptActWindow.Checked then
  begin
  reg.WInteger('CaptureType', 1);
  end
else if rbnCaptSelection.Checked then
  begin
  reg.WInteger('CaptureType', 2);
  end
else if rbnCaptPolygon.Checked then
  begin
  reg.WInteger('CaptureType', 3);
  end;
reg.WBool('HideWnd', cbxHideImager.Checked);
reg.WBool('CaptureCursor', cbxCaptureCursor.Checked);
reg.WBool('CaptureDelay', cbxDelay.Checked);
reg.CloseKey();

FreeAndNil(reg);
end;

procedure TfrmCapture.btnCaptureClick(Sender: TObject);
begin
scrCapture.ShowCursor:=cbxCaptureCursor.Checked;
if cbxDelay.Checked then
    scrCapture.Delay:=5000
else
	scrCapture.Delay:=500;
if cbxHideImager.Checked then
  	Self.Hide();

if rbnCaptDesktop.Checked then
  begin
  image:=scrCapture.CaptureDesktop();
  end
else if rbnCaptActWindow.Checked then
  begin
  image:=scrCapture.CaptureActiveWindow();
  end
else if rbnCaptSelection.Checked then
  begin
  image:=scrCapture.CaptureSelection();
  end
else if rbnCaptPolygon.Checked then
  begin
  image:=scrCapture.CapturePolygon();
  end;

Self.Show();
Self.Close();
end;

procedure TfrmCapture.btnCancelClick(Sender: TObject);
begin
Self.Close();
end;

end.
