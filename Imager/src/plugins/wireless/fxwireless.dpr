library fxwireless;

uses
  FastMM, SysUtils, Windows, Classes, Graphics,
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

    info_call(PT_FNAME, 'Wireless Bitmap Plug-in', '');

    info_call(PT_FOPEN, 'wbmp', '');
    info_call(PT_FOPEN, 'wbm', '');
    info_call(PT_FSAVE, 'wbmp', '');

    info_call(PT_FDESCR, 'wbmp', PChar(LoadLStr(1014) + ' (*.wbmp)'));
    info_call(PT_FDESCR, 'wbm', PChar(LoadLStr(1014) + ' (*.wbm)'));
end;

function FxImgOpen(document_path, info: PChar; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
	bmp: TBitmap;
begin
	bmp := TBitmap.Create();

    try
  		try
  			LoadFromWBmpFile(bmp, String(document_path));

  			Result.result_type := RT_HBITMAP;
           	Result.result_value := bmp.ReleaseHandle();
  		except
  			Result.result_type := RT_BOOL;
           	Result.result_value := FX_FALSE;
  		end;

		finally
  			FreeAndNil(bmp);
		end;
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
	FxImgQuery, FxImgOpen, FxImgSave;

begin
end.
