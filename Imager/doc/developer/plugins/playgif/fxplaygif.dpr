library fxplaygif;

uses
  SysUtils, Windows, Classes, Graphics,
  c_const, c_locales, c_utils,
  GDIPAPI, GDIPOBJ;

var
	gimg: TGPBitmap;
	gframe: cardinal = 0;

{$R *.res}

function FxImgQuery(plugin_path: PChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
begin
    Result.result_type := RT_BOOL;
    Result.result_value := FX_TRUE;

    info_call(PT_FNAME, 'Animated GIF Playback Plug-in', '');

    info_call(PT_FOPENANIM, 'gif', '');
end;

function FxImgAnimStart(document_path, info: PChar; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
begin
    Result.result_type := RT_BOOL;
    Result.result_value := FX_TRUE;

	// initializing GDI+
	StartupInput.DebugEventCallback := nil;
	StartupInput.SuppressBackgroundThread := False;
	StartupInput.SuppressExternalCodecs := False;
	StartupInput.GdiplusVersion := 1;
	GdiplusStartup(gdiplusToken, @StartupInput, nil);

	// working
	gimg := TGPBitmap.Create(WideString(document_path));

	if (gimg.GetFrameCount(FrameDimensionTime) <= 1) then
  		Result.result_value := FX_FALSE;
end;

function FxImgAnimRestart(app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
begin
    Result.result_type := RT_BOOL;
    Result.result_value := FX_TRUE;

	gframe := 0;

	//gframe := gimg.GetFrameCount(FrameDimensionTime)-1;
end;

function FxImgAnimGetFrame(app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
	bmp: TBitmap;
	tmp: HBITMAP;
	isize: integer;
	iitem: PPropertyItem;
type
	ac = array of Longword;
begin
    Result.result_type := RT_INT;
    Result.result_value := 0;

	Inc(gframe);
	if (gframe = gimg.GetFrameCount(FrameDimensionTime)) then
  		gframe := 0;

	gimg.SelectActiveFrame(FrameDimensionTime, gframe);

	bmp := TBitmap.Create();

	if (gimg.GetHBITMAP(aclWhite, tmp) = OK) then
  		begin
  		bmp.Handle := tmp;
  		Result.result_value := bmp.ReleaseHandle();

  		isize := gimg.GetPropertyItemSize(PropertyTagFrameDelay);
  		GetMem(iitem, isize);
  		gimg.GetPropertyItem(PropertyTagFrameDelay, isize, iitem);
  		Result.result_xtra := (ac(iitem.value)[gframe]) * 10;
  		FreeMem(iitem, isize);
  		end
	else
  		begin
  		Result.result_value := 0;
  		Result.result_xtra := 0;
  		end;
        
	FreeAndNil(bmp);
end;

function FxImgAnimStop(app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
begin
	Result.result_type := RT_BOOL;
	Result.result_value := FX_TRUE;

	FreeAndNil(gimg);

	// stopping GDI+
	if assigned(GenericSansSerifFontFamily) then
    	GenericSansSerifFontFamily.Free();
	if assigned(GenericSerifFontFamily) then
    	GenericSerifFontFamily.Free();
	if assigned(GenericMonospaceFontFamily) then
    	GenericMonospaceFontFamily.Free();
	if assigned(GenericTypographicStringFormatBuffer) then
    	GenericTypographicStringFormatBuffer.free();
	if assigned(GenericDefaultStringFormatBuffer) then
    	GenericDefaultStringFormatBuffer.Free();
	GdiplusShutdown(gdiplusToken);
end;

exports
	FxImgQuery,
	FxImgAnimStart, FxImgAnimRestart, FxImgAnimGetFrame, FxImgAnimStop;

begin
end.
 