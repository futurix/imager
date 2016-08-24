unit fx_core;

interface

uses
  Windows, SysUtils, Classes, Graphics,
  ImageEnIO, ImageEnProc, hyieutils, hyiedefs,
  c_const, c_utils, c_locales, c_graphics, c_ie;

const
  // plug-in filenames
  FN_ADDRAW       = 'fxraw.dll';
  FN_ADDJBIG      = 'fxjbig.dll';
  FN_ADDMAGICK    = 'fxmagick.dll';

var
  init_raw: boolean = false;
  init_magick: boolean = false;
  init_jbig: boolean = false;

function FxCore2(p_intf: ULONG; app_query: TAppCallBack): TFxCore2Result; cdecl;
function PluginQuery(plugin_path: PWideChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
function PluginOpen(document_path, info: PWideChar; page: ULONG; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;


implementation

function FxCore2(p_intf: ULONG; app_query: TAppCallBack): TFxCore2Result;
begin
  Result.res := FX_FALSE;
  Result.data := nil;

  case p_intf of
    CP_FQUERY:
      begin
      Result.res := FX_TRUE;
      Result.data := @PluginQuery;
      end;

    CP_FOPEN:
      begin
      Result.res := FX_TRUE;
      Result.data := @PluginOpen;
      end;
  end;
end;

function PluginQuery(plugin_path: PWideChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult;
var
  temp_res: TFxImgResult;
  path: string;
begin
  Result.result_type := RT_BOOL;
  Result.result_value := FX_TRUE;

  if (@app_query <> nil) then
    begin
    temp_res := app_query(CQ_GETLANGLIBS, 0, 0);

    if (temp_res.result_type = RT_HANDLE) then
      begin
      OverrideLocalizationLibraries(temp_res.result_value, temp_res.result_xtra);

      //!//
      legacy_locale := locale_lib;
      end;
    end;

  path := Slash(ExtractFilePath(GetModuleName(HInstance)));

  info_call(PT_FNAME, 'Extra file format support', '');

  if FileExists(path + FN_ADDRAW) then
    begin
    info_call(PT_FOPEN, 'crw', '');
    info_call(PT_FOPEN, 'cr2', '');
    info_call(PT_FOPEN, 'dng', '');
    info_call(PT_FOPEN, 'nef', '');
    info_call(PT_FOPEN, 'raw', '');
    info_call(PT_FOPEN, 'raf', '');
    info_call(PT_FOPEN, 'x3f', '');
    info_call(PT_FOPEN, 'orf', '');
    info_call(PT_FOPEN, 'srf', '');
    info_call(PT_FOPEN, 'mrw', '');
    info_call(PT_FOPEN, 'dcr', '');
    info_call(PT_FOPEN, 'bay', '');
    info_call(PT_FOPEN, 'pef', '');

    info_call(PT_FNOTREC, 'x3f', '');
    info_call(PT_FNOTREC, 'orf', '');
    info_call(PT_FNOTREC, 'srf', '');
    info_call(PT_FNOTREC, 'mrw', '');
    info_call(PT_FNOTREC, 'dcr', '');
    info_call(PT_FNOTREC, 'bay', '');
    info_call(PT_FNOTREC, 'pef', '');

    info_call(PT_FDESCR, 'crw', PWideChar(LoadLStr(1035)));
    info_call(PT_FDESCR, 'cr2', PWideChar(LoadLStr(1035)));
    info_call(PT_FDESCR, 'dng', PWideChar(LoadLStr(1036)));
    info_call(PT_FDESCR, 'nef', PWideChar(LoadLStr(1037)));
    info_call(PT_FDESCR, 'raw', PWideChar(LoadLStr(1038)));
    info_call(PT_FDESCR, 'raf', PWideChar(LoadLStr(1039)));
    info_call(PT_FDESCR, 'x3f', PWideChar(LoadLStr(1038)));
    info_call(PT_FDESCR, 'orf', PWideChar(LoadLStr(1038)));
    info_call(PT_FDESCR, 'srf', PWideChar(LoadLStr(1038)));
    info_call(PT_FDESCR, 'mrw', PWideChar(LoadLStr(1038)));
    info_call(PT_FDESCR, 'dcr', PWideChar(LoadLStr(1038)));
    info_call(PT_FDESCR, 'bay', PWideChar(LoadLStr(1038)));
    info_call(PT_FDESCR, 'pef', PWideChar(LoadLStr(1038)));
    end;

  if FileExists(path + FN_ADDJBIG) then
    begin
    info_call(PT_FOPEN, 'jbg', '');
    info_call(PT_FOPEN, 'jbig', '');
    info_call(PT_FOPEN, 'bie', '');

    info_call(PT_FNOTREC, 'bie', '');

    info_call(PT_FDESCR, 'jbg', PWideChar(LoadLStr(1040)));
    info_call(PT_FDESCR, 'jbig', PWideChar(LoadLStr(1040)));
    info_call(PT_FDESCR, 'bie', PWideChar(LoadLStr(1040)));
    end;

  if FileExists(path + FN_ADDMAGICK) then
    begin
    info_call(PT_FOPEN, 'dcm', '');
    info_call(PT_FOPEN, 'dicom', '');
    info_call(PT_FOPEN, 'cut', '');
    info_call(PT_FOPEN, 'avs', '');
    info_call(PT_FOPEN, 'cin', '');
    info_call(PT_FOPEN, 'dot', '');
    info_call(PT_FOPEN, 'dpx', '');
    info_call(PT_FOPEN, 'fits', '');
    info_call(PT_FOPEN, 'fpx', '');
    info_call(PT_FOPEN, 'mat', '');
    info_call(PT_FOPEN, 'miff', '');
    info_call(PT_FOPEN, 'mtv', '');
    info_call(PT_FOPEN, 'palm', '');
    info_call(PT_FOPEN, 'pict', '');
    info_call(PT_FOPEN, 'pix', '');
    info_call(PT_FOPEN, 'pwp', '');
    info_call(PT_FOPEN, 'rla', '');
    info_call(PT_FOPEN, 'sgi', '');
    info_call(PT_FOPEN, 'sun', '');
    info_call(PT_FOPEN, 'svg', '');
    info_call(PT_FOPEN, 'ttf', '');
    info_call(PT_FOPEN, 'vicar', '');
    info_call(PT_FOPEN, 'viff', '');
    info_call(PT_FOPEN, 'xcf', '');

    info_call(PT_FNOTREC, 'avs', '');
    info_call(PT_FNOTREC, 'cin', '');
    info_call(PT_FNOTREC, 'cut', '');
    info_call(PT_FNOTREC, 'dot', '');
    info_call(PT_FNOTREC, 'dpx', '');
    info_call(PT_FNOTREC, 'fits', '');
    info_call(PT_FNOTREC, 'mat', '');
    info_call(PT_FNOTREC, 'miff', '');
    info_call(PT_FNOTREC, 'mtv', '');
    info_call(PT_FNOTREC, 'palm', '');
    info_call(PT_FNOTREC, 'pix', '');
    info_call(PT_FNOTREC, 'pwp', '');
    info_call(PT_FNOTREC, 'sun', '');
    info_call(PT_FNOTREC, 'svg', '');
    info_call(PT_FNOTREC, 'ttf', '');
    info_call(PT_FNOTREC, 'vicar', '');
    info_call(PT_FNOTREC, 'viff', '');

    info_call(PT_FDESCR, 'dcm',   PWideChar(LoadLStr(1041)));
    info_call(PT_FDESCR, 'dicom', PWideChar(LoadLStr(1041)));
    info_call(PT_FDESCR, 'cut',   PWideChar(LoadLStr(1042)));
    info_call(PT_FDESCR, 'avs',   PWideChar(LoadLStr(1043)));
    info_call(PT_FDESCR, 'cin',   PWideChar(LoadLStr(1044)));
    info_call(PT_FDESCR, 'dot',   PWideChar(LoadLStr(1045)));
    info_call(PT_FDESCR, 'dpx',   PWideChar(LoadLStr(1046)));
    info_call(PT_FDESCR, 'fits',  PWideChar(LoadLStr(1047)));
    info_call(PT_FDESCR, 'fpx',   PWideChar(LoadLStr(1048)));
    info_call(PT_FDESCR, 'mat',   PWideChar(LoadLStr(1049)));
    info_call(PT_FDESCR, 'miff',  PWideChar(LoadLStr(1050)));
    info_call(PT_FDESCR, 'mtv',   PWideChar(LoadLStr(1051)));
    info_call(PT_FDESCR, 'palm',  PWideChar(LoadLStr(1052)));
    info_call(PT_FDESCR, 'pict',  PWideChar(LoadLStr(1053)));
    info_call(PT_FDESCR, 'pix',   PWideChar(LoadLStr(1054)));
    info_call(PT_FDESCR, 'pwp',   PWideChar(LoadLStr(1055)));
    info_call(PT_FDESCR, 'rla',   PWideChar(LoadLStr(1056)));
    info_call(PT_FDESCR, 'sgi',   PWideChar(LoadLStr(1057)));
    info_call(PT_FDESCR, 'sun',   PWideChar(LoadLStr(1058)));
    info_call(PT_FDESCR, 'svg',   PWideChar(LoadLStr(1059)));
    info_call(PT_FDESCR, 'ttf',   PWideChar(LoadLStr(1060)));
    info_call(PT_FDESCR, 'vicar', PWideChar(LoadLStr(1061)));
    info_call(PT_FDESCR, 'viff',  PWideChar(LoadLStr(1062)));
    info_call(PT_FDESCR, 'xcf',   PWideChar(LoadLStr(1063)));
    end;
end;

function PluginOpen(document_path, info: PWideChar; page: ULONG; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult;
var
  bmp: TBitmap;
  io: TImageEnIO;
  path, ext: string;
  is_raw, is_jbig, is_magick: boolean;
begin
  Result.result_type := RT_HBITMAP;
  Result.result_value := 0;
  Result.result_xtra := 1;

  // initialization
  ext := LowerCase(ExtractExt(string(document_path)));
  path := Slash(ExtractFilePath(GetModuleName(HInstance)));

  is_raw :=
    ((ext = 'crw') or (ext = 'cr2') or (ext = 'dng') or (ext = 'nef') or
    (ext = 'raw') or (ext = 'raf') or (ext = 'x3f') or (ext = 'orf') or
    (ext = 'srf') or (ext = 'mrw') or (ext = 'dcr') or (ext = 'bay') or (ext = 'pef'));
  is_jbig :=
    ((ext = 'jbg') or (ext = 'jbig') or (ext = 'bie'));
  is_magick :=
    ((ext = 'dcm') or (ext = 'dicom') or (ext = 'cut') or (ext = 'avs') or
    (ext = 'cin') or (ext = 'dot') or (ext = 'dpx') or (ext = 'fits') or
    (ext = 'fpx') or (ext = 'mat') or (ext = 'miff') or (ext = 'mtv') or
    (ext = 'palm') or (ext = 'pict') or (ext = 'pix') or (ext = 'pwp') or
    (ext = 'rla') or (ext = 'sgi') or (ext = 'sun') or (ext = 'svg') or
    (ext = 'ttf') or (ext = 'vicar') or (ext = 'viff') or (ext = 'xcf'));

  if ((not init_raw) and is_raw and (FileExists(path + FN_ADDRAW))) then
    begin
    IEFileFormatRemove(ioRAW);
    IEAddExtIOPlugIn(path + FN_ADDRAW);

    init_raw := true;
    end;

  if ((not init_jbig) and is_jbig and (FileExists(path + FN_ADDJBIG))) then
    begin
    IEAddExtIOPlugIn(path + FN_ADDJBIG);

    init_jbig := true;
    end;

  if ((not init_magick) and is_magick and (FileExists(path + FN_ADDMAGICK))) then
    begin
    IEAddExtIOPlugIn(path + FN_ADDMAGICK);

    init_magick := true;
    end;

  iegEnableCMS := true;

  io := TImageEnIO.Create(nil);
  bmp := TBitmap.Create();

  io.Params.JPEG_DCTMethod := ioJPEG_IFAST;
  io.Params.BMP_HandleTransparency := true;
  io.Params.IsNativePixelFormat := true;

  io.LoadFromFile(String(document_path));

  if io.Aborting then
    io.LoadFromFileAuto(String(document_path));

  if not io.Aborting then
    begin
    io.IEBitmap.PrepareAlphaForExternalUse();
    if (io.IEBitmap.PixelFormat <> ie32RGB) then
      io.IEBitmap.PixelFormat := ie24RGB;

    io.IEBitmap.CopyToTBitmap(bmp);
    bmp.ApplyLimits();
    Result.result_value := bmp.ReleaseHandle();
    end;

  FreeAndNil(io);
  FreeAndNil(bmp);
end;

exports
  FxCore2;

end.
