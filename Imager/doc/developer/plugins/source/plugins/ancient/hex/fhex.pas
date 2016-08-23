unit fhex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, MPHexEditor, c_const, c_locales, StdCtrls;

type
  TfrmHex = class(TForm)
    hexEditor: TMPHexEditor;
    pnlBottom: TPanel;
    btnClose: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
	frmHex: TfrmHex;

function FxImgQuery(plugin_path: PChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
function FxImgTool(document_path, info: PChar; img: HBITMAP; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;


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

    info_call(PT_FNAME, 'HEX viewer', '');
    info_call(PT_FROLE, PR_HEX, '');

	info_call(PT_FTOOL, PChar(LoadLStr(3015)), ' ');
end;

function FxImgTool(document_path, info: PChar; img: HBITMAP; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult;
var
	temp_res: TFxImgResult;
begin
    Result.result_type := RT_BOOL;
    Result.result_value := FX_TRUE;

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

	if ((String(document_path) <> '') and (FileExists(String(document_path)))) then
		begin
		frmHex := TfrmHex.Create(Application);
		frmHex.hexEditor.LoadFromFile(String(document_path));
		frmHex.ShowModal();
		FreeAndNil(frmHex);
		end
	else
		Application.MessageBox(PChar(LoadLStr(3017)), sAppName, MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmHex.btnCloseClick(Sender: TObject);
begin
	Close();
end;

procedure TfrmHex.FormCreate(Sender: TObject);
begin
	Self.Caption		:= LoadLStr(3016);

    btnClose.Caption	:= LoadLStr(54);
end;

procedure TfrmHex.CreateParams(var Params: TCreateParams);
begin
	Params.Style := (Params.Style or WS_POPUP);

	inherited;

	if (Owner is TForm) then
		Params.WndParent := (Owner as TWinControl).Handle
	else if Assigned(Screen.ActiveForm) then
		Params.WndParent := Screen.ActiveForm.Handle;
end;

exports
	FxImgQuery, FxImgTool;

end.
