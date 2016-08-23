library fx_email;

uses
  SysUtils, Windows, Classes, Graphics, MAPI, c_const, c_utils, c_locales;

{$R *.RES}


function FxImgQuery(plugin_path: PChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
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

    info_call(PT_FNAME, 'E-mail Plug-in', '');

    info_call(PT_FTOOL, PChar(LoadLStr(3600)), ' ');
end;

function FxImgTool(document_path, info: PChar; img: HBITMAP; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
	temp_res: TFxImgResult;
	tmp: string;
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

	tmp := String(document_path);

	if (FileExists(tmp)) then
  		MapiSendDocuments(app, ';', document_path, '', 0)
	else
    	// unsaved files
  		MessageBox(wnd, PChar(LoadLStr(3085)), sAppName, MB_OK + MB_ICONWARNING);
end;

exports
	FxImgQuery, FxImgTool;

begin
end.
