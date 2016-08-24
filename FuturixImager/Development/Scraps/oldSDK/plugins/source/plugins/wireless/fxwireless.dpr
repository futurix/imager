library fxwireless;

uses
  SysUtils, Windows, Classes, Graphics,
  c_const, c_locales, bmp2wbmp;

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

    info_call(PT_FNAME, 'Wireless bitmaps support', '');

    info_call(PT_FSAVE, 'wbmp', '');
end;

function FxImgSave(document_path, info: PChar; img: HBITMAP; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
	bmp: TBitmap;
begin
    Result.result_type := RT_BOOL;
    Result.result_value := FX_FALSE;

	bmp := TBitmap.Create();

	try
        if (img <> 0) then
        	begin
            bmp.Handle := img;

            SaveAsWBmpFile(bmp, String(document_path));
            Result.result_value := FX_TRUE;
            end;

  		except
    		Result.result_value := FX_FALSE;
  		end;

	FreeAndNil(bmp);
end;

exports
	FxImgQuery, FxImgSave;

begin
end.
