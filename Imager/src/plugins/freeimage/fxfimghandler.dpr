library fxfimghandler;

uses
  FastMM, SysUtils, Windows, Classes, Graphics,
  ImageEnIO, ImageEnProc, hyieutils, IEMView,
  freeimage, c_const, c_locales;

var
	mp_filename: string = '';

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

    info_call(PT_FNAME, 'FreeImage Plug-in', '');

	info_call(PT_FOPEN, 'koa', '');
	info_call(PT_FOPEN, 'iff', '');
	info_call(PT_FOPEN, 'ilbm', '');
	info_call(PT_FOPEN, 'lbm', '');
	info_call(PT_FOPEN, 'dds', '');
	info_call(PT_FOPEN, 'ras', '');
	info_call(PT_FOPEN, 'xbm', '');
	info_call(PT_FOPEN, 'xpm', '');
	info_call(PT_FOPEN, 'ico', '');
	info_call(PT_FOPEN, 'hdr', '');

	info_call(PT_FOPENMULTI, 'ico', '');

	info_call(PT_FDESCR, 'koa', PChar(LoadLStr(1023) + ' (*.koa)'));
	info_call(PT_FDESCR, 'iff', PChar(LoadLStr(1024) + ' (*.iff)'));
	info_call(PT_FDESCR, 'ilbm', PChar(LoadLStr(1024) + ' (*.ilbm)'));
	info_call(PT_FDESCR, 'lbm', PChar(LoadLStr(1024) + ' (*.lbm)'));
	info_call(PT_FDESCR, 'dds', PChar(LoadLStr(1025) + ' (*.dds)'));
	info_call(PT_FDESCR, 'ras', PChar(LoadLStr(1026) + ' (*.ras)'));
	info_call(PT_FDESCR, 'xbm', PChar(LoadLStr(1027) + ' (*.xbm)'));
	info_call(PT_FDESCR, 'xpm', PChar(LoadLStr(1028) + ' (*.xpm)'));
	info_call(PT_FDESCR, 'ico', PChar(LoadLStr(1029) + ' (*.ico)'));
	info_call(PT_FDESCR, 'hdr', PChar(LoadLStr(1030) + ' (*.hdr)'));
end;

function FxImgOpen(document_path, info: PChar; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
	dib: PFIBITMAP;
	t: FREE_IMAGE_FORMAT;
	bmp: HBITMAP;
	bitm: TBitmap;
    ext: string;
begin
    Result.result_type := RT_HBITMAP;
    Result.result_value := 0;

    ext := LowerCase(info);

	// analyzing
	if ext = 'koa' then
    	t := FIF_KOALA
	else if ext = 'iff' then
    	t := FIF_IFF
	else if ext = 'ilbm' then
    	t := FIF_LBM
	else if ext = 'lbm' then
    	t := FIF_LBM
	else if ext = 'dds' then
    	t := FIF_DDS
	else if ext = 'ras' then
    	t := FIF_RAS
	else if ext = 'xbm' then
    	t := FIF_XBM
	else if ext = 'xpm' then
    	t := FIF_XPM
	else if ext = 'ico' then
    	t := FIF_ICO
	else if ext = 'hdr' then
    	t := FIF_HDR
	else
    	t := FreeImage_GetFileType(PChar(document_path), 16);

	if (t <> FIF_UNKNOWN) then
  		begin
  		dib := FreeImage_Load(t, PChar(document_path), 0);

 		if (dib <> nil) then
    		begin
    		bitm := TBitmap.Create();

    		if (t = FIF_HDR) then
    			dib := FreeImage_ToneMapping(dib, FITMO_DRAGO03, 1, 0);

    		bmp := CreateDIBitmap(GetDC(0), FreeImage_GetInfoHeader(dib)^, CBM_INIT, PAnsiChar(FreeImage_GetBits(dib)), FreeImage_GetInfo(dib^)^, DIB_RGB_COLORS);
    		bitm.Handle := bmp;
    		bitm.PixelFormat := pf24bit;
    		Result.result_value := bitm.ReleaseHandle();
    		FreeAndNil(bitm);
    		FreeImage_Unload(dib);
    		end;
  		end;
end;

function FxImgMultiStart(document_path, info: PChar; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
	mp: PFIMULTIBITMAP;
begin
    Result.result_type := RT_INT;
    Result.result_value := 0;

    mp_filename := document_path;

	mp := FreeImage_OpenMultiBitmap(FIF_ICO, PChar(mp_filename), false, true, false);

	if (mp <> nil) then
  		begin
  		Result.result_value := FreeImage_GetPageCount(mp);
        FreeImage_CloseMultiBitmap(mp, 0);
  		end;
end;

function FxImgMultiGetPage(page_index: integer; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
	mp: PFIMULTIBITMAP;
  	dib: PFIBITMAP;
  	bmp: HBITMAP;
  	bitm: TBitmap;
begin
    Result.result_type := RT_HBITMAP;
    Result.result_value := 0;

    mp := FreeImage_OpenMultiBitmap(FIF_ICO, PChar(mp_filename), false, true, false);

	if (mp <> nil) then
  		begin
		dib := FreeImage_LockPage(mp, page_index);

		if (dib <> nil) then
  			begin
  			bitm := TBitmap.Create();
 			bmp := CreateDIBitmap(GetDC(0), FreeImage_GetInfoHeader(dib)^, CBM_INIT, PAnsiChar(FreeImage_GetBits(dib)), FreeImage_GetInfo(dib^)^, DIB_RGB_COLORS);
  			bitm.Handle := bmp;
  			bitm.PixelFormat := pf24bit;
  			Result.result_value := bitm.ReleaseHandle();
  			FreeAndNil(bitm);
  			FreeImage_UnlockPage(mp, dib, false);
  			end;

        FreeImage_CloseMultiBitmap(mp, 0);
        end;
end;

function FxImgMultiStop(app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
begin
    Result.result_type := RT_BOOL;
    Result.result_value := FX_TRUE;
end;

exports
	FxImgQuery, FxImgOpen,
	FxImgMultiStart, FxImgMultiGetPage, FxImgMultiStop;

begin
end.
