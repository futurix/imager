library fxwic;

uses
  SysUtils, Windows, Classes, Graphics,
  ImageEnIO, ImageEnProc, hyieutils, hyiedefs,
  c_const, c_utils, c_locales, c_reg,
  iewic;

{$R *.RES}


function FxImgQuery(plugin_path: PChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
	temp_res: TFxImgResult;
  wic: TIEWICReader;
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

  info_call(PT_FNAME, 'Experimental WIC support plug-in', '');

  // Windows Imaging Component
  wic := TIEWICReader.Create();

  if wic.IsAvailable then
    begin
    info_call(PT_FOPEN, 'jpg', '');
    info_call(PT_FOPEN, 'jpeg', '');
    info_call(PT_FOPEN, 'png', '');
    info_call(PT_FOPEN, 'tif', '');
    info_call(PT_FOPEN, 'tiff', '');

    wic.Free();
    end;
end;

function FxImgOpen(document_path, info: PChar; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
  bmp: TBitmap;
  wic: TIEWICReader;
  img: TIEBitmap;
  ftype: integer;
  ext: string;
begin
  Result.result_type := RT_HBITMAP;
  Result.result_value := 0;

  wic := TIEWICReader.Create();

  if wic.IsAvailable then
    begin
    ext := LowerCase(ExtractExt(String(document_path)));

    if ((ext = 'tif') or (ext = 'tiff')) then
      ftype := ioTIFF
    else if (ext = 'png') then
      ftype := ioPNG
    else
      ftype := ioJPEG;

    if wic.Open(String(document_path), ftype) then
      begin
      bmp := TBitmap.Create();
      img := TIEBitmap.Create();

      wic.GetFrame(0, img);

      img.PixelFormat := ie24RGB;
      bmp.Assign(img.VclBitmap);
      bmp.PixelFormat := pf24bit;
      Result.result_value := bmp.ReleaseHandle();

      FreeAndNil(img);
    	FreeAndNil(bmp);
      end;

    wic.Free();
    end;
end;

exports
  FxImgQuery, FxImgOpen;

begin
end.
