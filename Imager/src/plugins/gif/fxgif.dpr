library fxgif;

uses
  FastMM,
  SysUtils,
  Classes,
  Windows,
  Graphics,
  gifimage,
  c_const,
  c_locales,
  gifexp in 'gifexp.pas' {frmGIFExport};

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

    if (Win32Platform = VER_PLATFORM_WIN32_NT) then
        begin
        info_call(PT_FNAME, 'GIF Export Plug-in', '');

		info_call(PT_FEXPORT, PChar(LoadLStr(3020)), '');
        end;
end;

exports
	FxImgQuery, FxImgExport;

begin
end.
 