unit fcapt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ASGCapture, c_const, c_reg, c_locales, StdCtrls;

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
    { Private declarations }
  public
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
	frmCapture: TfrmCapture;
	image: TBitmap;

function FxImgQuery(plugin_path: PChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
function FxImgImport(info: PChar; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;


implementation

{$R *.dfm}

function FxImgQuery(plugin_path: PChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult;
var
	temp_res: TFxImgResult;
begin
    Result.result_type := RT_BOOL;
    Result.result_value := FX_TRUE;

    if (@app_query <> nil) then
        begin
    	temp_res := app_query(CQ_GETLANGLIBS, 0, 0);

        if (temp_res.result_type = RT_HANDLE) then
        	begin
            locale_lib := temp_res.result_value;
            backup_lib := temp_res.result_xtra;
            end;
        end;

    info_call(PT_FNAME, 'Screen capture', '');
    info_call(PT_FROLE, PR_CAPTURE, '');

	info_call(PT_FIMPORT, PChar(LoadLStr(3110)), '');
end;

function FxImgImport(info: PChar; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult;
var
	temp_res: TFxImgResult;
begin
    Result.result_type := RT_HBITMAP;
    Result.result_value := 0;

	Application.Handle := app;
    
    if (@app_query <> nil) then
        begin
    	temp_res := app_query(CQ_GETLANGLIBS, 0, 0);

        if (temp_res.result_type = RT_HANDLE) then
        	begin
            locale_lib := temp_res.result_value;
            backup_lib := temp_res.result_xtra;
            end;
        end;

	image := TBitmap.Create();

	frmCapture := TfrmCapture.Create(Application);

	frmCapture.ShowModal();

 	FreeAndNil(frmCapture);

	if not image.Empty then
  		Result.result_value := image.ReleaseHandle()
	else
  		Result.result_value := 0;
        
	FreeAndNil(image);
end;

procedure TfrmCapture.FormCreate(Sender: TObject);
begin
    Self.Caption				:= LoadLStr(3111);

    btnCapture.Caption			:= LoadLStr(3112);
    btnCancel.Caption			:= LoadLStr(51);

    gbxCaptureType.Caption		:= LoadLStr(3113);

    rbnCaptDesktop.Caption		:= LoadLStr(3114);
    rbnCaptPolygon.Caption		:= LoadLStr(3115);
    rbnCaptSelection.Caption	:= LoadLStr(3116);
    rbnCaptActWindow.Caption	:= LoadLStr(3117);

    cbxHideImager.Caption		:= LoadLStr(3118);
    cbxCaptureCursor.Caption	:= LoadLStr(3119);
    cbxDelay.Caption			:= LoadLStr(3120);

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
    	Application.MainForm.Hide();
    	end;

	if rbnCaptDesktop.Checked then
  		image := scrCapture.CaptureDesktop()
	else if rbnCaptActWindow.Checked then
  		image := scrCapture.CaptureActiveWindow()
	else if rbnCaptSelection.Checked then
  		image := scrCapture.CaptureSelection()
	else if rbnCaptPolygon.Checked then
  		image := scrCapture.CapturePolygon();

  	Application.MainForm.Show();
	Self.Show();

	Self.Close();
end;

procedure TfrmCapture.btnCancelClick(Sender: TObject);
begin
	Close();
end;

procedure TfrmCapture.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	//
end;

procedure TfrmCapture.CreateParams(var Params: TCreateParams);
begin
	Params.Style := (Params.Style or WS_POPUP);

	inherited;

	if (Owner is TForm) then
		Params.WndParent := (Owner as TWinControl).Handle
	else if Assigned(Screen.ActiveForm) then
		Params.WndParent := Screen.ActiveForm.Handle;
end;

exports
	FxImgQuery, FxImgImport;

end.
