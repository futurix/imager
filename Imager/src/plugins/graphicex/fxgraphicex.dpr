library fxgraphicex;

uses
  SysUtils, Classes, Windows, Graphics, GraphicEx,
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

    info_call(PT_FNAME, 'GraphicEx integration', '');

	info_call(PT_FOPEN, 'pcd', '');
	info_call(PT_FOPEN, 'cel', '');
	info_call(PT_FOPEN, 'pic', '');
	info_call(PT_FOPEN, 'psp', '');
    info_call(PT_FOPEN, 'eps', '');

    info_call(PT_FNOTREC, 'cel', '');
    info_call(PT_FNOTREC, 'pic', '');
    info_call(PT_FNOTREC, 'psp', '');
    info_call(PT_FNOTREC, 'eps', '');

	info_call(PT_FDESCR, 'pcd', PChar(LoadLStr(1017)));
	info_call(PT_FDESCR, 'cel', PChar(LoadLStr(1019)));
	info_call(PT_FDESCR, 'pic', PChar(LoadLStr(1019)));
	info_call(PT_FDESCR, 'psp', PChar(LoadLStr(1022)));
	info_call(PT_FDESCR, 'eps', PChar(LoadLStr(1018)));
end;

function FxImgOpen(document_path, info: PChar; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
	bmp: TBitmap;
	dsk: TAutodeskGraphic;
	pcd: TPCDGraphic;
	psp: TPSPGraphic;
    eps: TEPSGraphic;
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
	else if (ext = 'eps') then
		begin
  		eps := TEPSGraphic.Create();
  		bmp := TBitmap.Create();

  		try
    		eps.LoadFromFile(document_path);
    		bmp.Assign(eps);
    		Result.result_value := bmp.ReleaseHandle();
            
  		except
        	Result.result_value := 0;
  		end;

  		FreeAndNil(eps);
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
