unit fcapt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ASGCapture,
  c_const, c_reg;

type
  TfrmCapture = class(TForm)
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
    scrCapture: TASGScreenCapture;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCaptureClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  public
    parentWindow: HWND;
  end;

var
  frmCapture: TfrmCapture;
  image: TBitmap;

function FxCore2(p_intf: ULONG; app_query: TAppCallBack): TFxCore2Result; cdecl;
function PluginQuery(plugin_path: PChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
function PluginImport(info: PChar; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;


implementation

{$R *.dfm}

function FxCore2(p_intf: ULONG; app_query: TAppCallBack): TFxCore2Result;
begin
  Result.res := FX_FALSE;
  Result.data := nil;

  case p_intf of
    CP_FQUERY:
      begin
      Result.res := FX_TRUE;
      Result.data := @PluginQuery;
      end;

    CP_FIMPORT:
      begin
      Result.res := FX_TRUE;
      Result.data := @PluginImport;
      end;
  end;
end;

function PluginQuery(plugin_path: PWideChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult;
begin
  Result.result_type := RT_BOOL;
  Result.result_value := FX_TRUE;

  info_call(PT_FNAME, 'Screen capture', '');
  info_call(PT_FROLE, PR_CAPTURE, '');
  info_call(PT_FIMPORT, 'Screen Capture...', '');
end;

function PluginImport(info: PWideChar; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult;
begin
  Result.result_type := RT_HBITMAP;
  Result.result_value := 0;

  image := TBitmap.Create();

  frmCapture := TfrmCapture.Create(Application);
  frmCapture.parentWindow := wnd;
  frmCapture.ShowModal();
  FreeAndNil(frmCapture);

  if not image.Empty then
    begin
    image.PixelFormat := pf24bit;

    Result.result_value := image.ReleaseHandle();
    end
  else
    Result.result_value := 0;
        
  FreeAndNil(image);
end;

procedure TfrmCapture.FormCreate(Sender: TObject);
begin
  cbxHideImager.Checked := FxRegRBool('Capture_HideWnd', true);
  cbxCaptureCursor.Checked := FxRegRBool('Capture_Cursor', false);
  cbxDelay.Checked := FxRegRBool('Capture_Delay', true);

  case FxRegRInt('Capture_Type', 0) of
    0: rbnCaptDesktop.Checked := true;
    1: rbnCaptActWindow.Checked := true;
    2: rbnCaptSelection.Checked := true;
    3: rbnCaptPolygon.Checked := true;
  end;
end;

procedure TfrmCapture.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if rbnCaptDesktop.Checked then
    FxRegWInt('Capture_Type', 0)
  else if rbnCaptActWindow.Checked then
    FxRegWInt('Capture_Type', 1)
  else if rbnCaptSelection.Checked then
    FxRegWInt('Capture_Type', 2)
  else if rbnCaptPolygon.Checked then
    FxRegWInt('Capture_Type', 3);

  FxRegWBool('Capture_HideWnd', cbxHideImager.Checked);
  FxRegWBool('Capture_Cursor', cbxCaptureCursor.Checked);
  FxRegWBool('Capture_Delay', cbxDelay.Checked);
end;

procedure TfrmCapture.btnCaptureClick(Sender: TObject);
begin
  scrCapture.ShowCursor := cbxCaptureCursor.Checked;

  if cbxDelay.Checked then
    scrCapture.Delay := 5000
  else
    scrCapture.Delay := 500;

  if cbxHideImager.Checked then
    begin
    Self.Hide();
    ShowWindow(parentWindow, SW_HIDE);
    end;

  if rbnCaptDesktop.Checked then
    image := scrCapture.CaptureDesktop()
  else if rbnCaptActWindow.Checked then
    image := scrCapture.CaptureActiveWindow()
  else if rbnCaptSelection.Checked then
    image := scrCapture.CaptureSelection()
  else if rbnCaptPolygon.Checked then
    image := scrCapture.CapturePolygon();

  ShowWindow(parentWindow, SW_SHOW);
  Self.Show();

  Self.Close();
end;

procedure TfrmCapture.btnCancelClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmCapture.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Self.Close();
end;

exports
  FxCore2;

end.
