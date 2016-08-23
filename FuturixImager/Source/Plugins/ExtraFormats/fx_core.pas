unit fx_core;

interface

uses
  Windows, SysUtils, Classes, Graphics,
  ImageEnIO, ImageEnProc, hyieutils, hyiedefs,
  c_const, c_utils, c_str, c_graphics, c_ie;

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
  path: string;
begin
  Result.result_type := RT_BOOL;
  Result.result_value := FX_TRUE;

  path := Slash(ExtractFilePath(GetModuleName(HInstance)));

  info_call(PT_FNAME, 'Extra file formats support', '');

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

    info_call(PT_FDESCR, 'crw', FXL_FORMAT_CAMERA_CANON);
    info_call(PT_FDESCR, 'cr2', FXL_FORMAT_CAMERA_CANON);
    info_call(PT_FDESCR, 'dng', FXL_FORMAT_DNG);
    info_call(PT_FDESCR, 'nef', FXL_FORMAT_CAMERA_NIKON);
    info_call(PT_FDESCR, 'raw', FXL_FORMAT_CAMERA_RAW);
    info_call(PT_FDESCR, 'raf', FXL_FORMAT_CAMERA_FUJI);
    info_call(PT_FDESCR, 'x3f', FXL_FORMAT_CAMERA_RAW);
    info_call(PT_FDESCR, 'orf', FXL_FORMAT_CAMERA_RAW);
    info_call(PT_FDESCR, 'srf', FXL_FORMAT_CAMERA_RAW);
    info_call(PT_FDESCR, 'mrw', FXL_FORMAT_CAMERA_RAW);
    info_call(PT_FDESCR, 'dcr', FXL_FORMAT_CAMERA_RAW);
    info_call(PT_FDESCR, 'bay', FXL_FORMAT_CAMERA_RAW);
    info_call(PT_FDESCR, 'pef', FXL_FORMAT_CAMERA_RAW);
    end;

  if FileExists(path + FN_ADDJBIG) then
    begin
    info_call(PT_FOPEN, 'jbg', '');
    info_call(PT_FOPEN, 'jbig', '');
    info_call(PT_FOPEN, 'bie', '');

    info_call(PT_FNOTREC, 'bie', '');

    info_call(PT_FDESCR, 'jbg', FXL_FORMAT_JBIG);
    info_call(PT_FDESCR, 'jbig', FXL_FORMAT_JBIG);
    info_call(PT_FDESCR, 'bie', FXL_FORMAT_JBIG);
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

    info_call(PT_FDESCR, 'dcm',   FXL_FORMAT_DICOM);
    info_call(PT_FDESCR, 'dicom', FXL_FORMAT_DICOM);
    info_call(PT_FDESCR, 'cut',   FXL_FORMAT_RARE_DRHALO);
    info_call(PT_FDESCR, 'avs',   FXL_FORMAT_RARE_AVS);
    info_call(PT_FDESCR, 'cin',   FXL_FORMAT_RARE_CINEON);
    info_call(PT_FDESCR, 'dot',   FXL_FORMAT_RARE_GRAPHVIS);
    info_call(PT_FDESCR, 'dpx',   FXL_FORMAT_RARE_SMPTE);
    info_call(PT_FDESCR, 'fits',  FXL_FORMAT_RARE_FITS);
    info_call(PT_FDESCR, 'fpx',   FXL_FORMAT_FLASHPIX);
    info_call(PT_FDESCR, 'mat',   FXL_FORMAT_MATLAB);
    info_call(PT_FDESCR, 'miff',  FXL_FORMAT_MAGICK);
    info_call(PT_FDESCR, 'mtv',   FXL_FORMAT_RARE_MTV);
    info_call(PT_FDESCR, 'palm',  FXL_FORMAT_RARE_PALM);
    info_call(PT_FDESCR, 'pict',  FXL_FORMAT_PICT);
    info_call(PT_FDESCR, 'pix',   FXL_FORMAT_RARE_ALIAS_RLE);
    info_call(PT_FDESCR, 'pwp',   FXL_FORMAT_RARE_SFW);
    info_call(PT_FDESCR, 'rla',   FXL_FORMAT_RARE_ALIAS);
    info_call(PT_FDESCR, 'sgi',   FXL_FORMAT_RARE_IRIX);
    info_call(PT_FDESCR, 'sun',   FXL_FORMAT_RARE_SUN);
    info_call(PT_FDESCR, 'svg',   FXL_FORMAT_SVG);
    info_call(PT_FDESCR, 'ttf',   FXL_FORMAT_TTF);
    info_call(PT_FDESCR, 'vicar', FXL_FORMAT_RARE_VICAR);
    info_call(PT_FDESCR, 'viff',  FXL_FORMAT_RARE_VIFF);
    info_call(PT_FDESCR, 'xcf',   FXL_FORMAT_GIMP);
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
