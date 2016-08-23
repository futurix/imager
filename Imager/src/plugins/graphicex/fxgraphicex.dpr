library fxgraphicex;

uses
  FastMM, SysUtils, Classes, Windows, Graphics, GraphicEx,
  c_const, c_locales;

{$R *.res}

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

    info_call(PT_FNAME, 'GraphicEx Plug-in', '');

	info_call(PT_FOPEN, 'pcd', '');
	info_call(PT_FOPEN, 'cel', '');
	info_call(PT_FOPEN, 'pic', '');
	info_call(PT_FOPEN, 'psd', '');
	info_call(PT_FOPEN, 'pdd', '');
	info_call(PT_FOPEN, 'psp', '');

	info_call(PT_FDESCR, 'pcd', PChar(LoadLStr(1017) + ' (*.pcd)'));
	info_call(PT_FDESCR, 'cel', PChar(LoadLStr(1019) + ' (*.cel)'));
	info_call(PT_FDESCR, 'pic', PChar(LoadLStr(1019) + ' (*.pic)'));
	info_call(PT_FDESCR, 'psd', PChar(LoadLStr(1020) + ' (*.psd)'));
	info_call(PT_FDESCR, 'pdd', PChar(LoadLStr(1021) + ' (*.pdd)'));
	info_call(PT_FDESCR, 'psp', PChar(LoadLStr(1022) + ' (*.psp)'));
end;

function FxImgOpen(document_path, info: PChar; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
	bmp: TBitmap;
	dsk: TAutodeskGraphic;
	pcd: TPCDGraphic;
	psd: TPSDGraphic;
	psp: TPSPGraphic;
    ext: string;
begin
    Result.result_type := RT_HBITMAP;
    Result.result_value := 0;

    ext := LowerCase(info);

	if ((ext = 'cel') or (ext = 'pic')) then
  		begin
  		dsk := TAutodeskGraphic.Create();
  		bmp := TBitmap.Create();

  		try
    		dsk.LoadFromFile(document_path);
    		bmp.Assign(dsk);

    		Result.result_value := bmp.ReleaseHandle();

    		except
            	Result.result_value := 0;
    		end;

  		FreeAndNil(dsk);
  		FreeAndNil(bmp);
  		end
	else if ((ext = 'psd') or (ext = 'pdd')) then
  		begin
  		psd := TPSDGraphic.Create();
  		bmp := TBitmap.Create();

  		try
    		psd.LoadFromFile(document_path);
    		bmp.Assign(psd);

    		Result.result_value := bmp.ReleaseHandle();

    		except
            	Result.result_value := 0;
    		end;

  		FreeAndNil(psd);
  		FreeAndNil(bmp);
  		end
    else if (ext='pcd') then
  		begin
  		pcd := TPCDGraphic.Create();
  		bmp := TBitmap.Create();

  		try
    		pcd.LoadFromFile(document_path);
    		bmp.Assign(pcd);

    		Result.result_value := bmp.ReleaseHandle();

    		except
            	Result.result_value := 0;
    		end;

  		FreeAndNil(pcd);
  		FreeAndNil(bmp);
  		end
	else if (ext='psp') then
  		begin
  		psp := TPSPGraphic.Create();
  		bmp := TBitmap.Create();

  		try
    		psp.LoadFromFile(document_path);
    		bmp.Assign(psp);

    		Result.result_value := bmp.ReleaseHandle();

    		except
            	Result.result_value := 0;
    		end;

  		FreeAndNil(psp);
  		FreeAndNil(bmp);
  		end;
end;

exports
	FxImgQuery, FxImgOpen;

begin
end.
