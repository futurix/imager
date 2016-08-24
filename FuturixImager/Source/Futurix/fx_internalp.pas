unit fx_internalp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  c_const, c_locales;

function InternalCore2(p_intf: ULONG; app_query: TAppCallBack): TFxCore2Result; cdecl;
function InternalPluginQuery(plugin_path: PWideChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;


implementation

function InternalCore2(p_intf: ULONG; app_query: TAppCallBack): TFxCore2Result;
begin
  Result.res := FX_FALSE;
  Result.data := nil;

  case p_intf of
    CP_FQUERY:
      begin
      Result.res := FX_TRUE;
      Result.data := @InternalPluginQuery;
      end;

    {CP_FOPEN:
      begin
      Result.res := FX_TRUE;
      Result.data := @FxImgOpen;
      end;}
  end;
end;

function InternalPluginQuery(plugin_path: PWideChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult;
begin
  Result.result_type := RT_BOOL;
  Result.result_value := FX_TRUE;

  info_call(PT_FOPEN, 'jpg', '');
  info_call(PT_FOPEN, 'jpeg', '');
  info_call(PT_FOPEN, 'jfif', '');
  info_call(PT_FOPEN, 'jpe', '');
  info_call(PT_FOPEN, 'jp2', '');
  info_call(PT_FOPEN, 'jpc', '');
  info_call(PT_FOPEN, 'j2k', '');
  info_call(PT_FOPEN, 'j2c', '');
  info_call(PT_FOPEN, 'gif', '');
  info_call(PT_FOPEN, 'pbm', '');
  info_call(PT_FOPEN, 'pgm', '');
  info_call(PT_FOPEN, 'ppm', '');
  info_call(PT_FOPEN, 'bmp', '');
  info_call(PT_FOPEN, 'dib', '');
  info_call(PT_FOPEN, 'emf', '');
  info_call(PT_FOPEN, 'wmf', '');
  info_call(PT_FOPEN, 'pcx', '');
  info_call(PT_FOPEN, 'dcx', '');
  info_call(PT_FOPEN, 'png', '');
  info_call(PT_FOPEN, 'tga', '');
  info_call(PT_FOPEN, 'tif', '');
  info_call(PT_FOPEN, 'tiff', '');
  info_call(PT_FOPEN, 'wbmp', '');
  info_call(PT_FOPEN, 'wbm', '');
  info_call(PT_FOPEN, 'psd', '');

  info_call(PT_FNOTREC, 'dcx', '');
  info_call(PT_FNOTREC, 'jpe', '');
  info_call(PT_FNOTREC, 'jfif', '');

  info_call(PT_FDESCR, 'jpg', PWideChar(LoadLStr(1000)));
  info_call(PT_FDESCR, 'jpeg', PWideChar(LoadLStr(1000)));
  info_call(PT_FDESCR, 'jfif', PWideChar(LoadLStr(1000)));
  info_call(PT_FDESCR, 'jpe', PWideChar(LoadLStr(1000)));
  info_call(PT_FDESCR, 'jp2', PWideChar(LoadLStr(1001)));
  info_call(PT_FDESCR, 'jpc', PWideChar(LoadLStr(1001)));
  info_call(PT_FDESCR, 'j2k', PWideChar(LoadLStr(1001)));
  info_call(PT_FDESCR, 'j2c', PWideChar(LoadLStr(1001)));
  info_call(PT_FDESCR, 'gif', PWideChar(LoadLStr(1002)));
  info_call(PT_FDESCR, 'pbm', PWideChar(LoadLStr(1003)));
  info_call(PT_FDESCR, 'pgm', PWideChar(LoadLStr(1004)));
  info_call(PT_FDESCR, 'ppm', PWideChar(LoadLStr(1005)));
  info_call(PT_FDESCR, 'bmp', PWideChar(LoadLStr(1006)));
  info_call(PT_FDESCR, 'dib', PWideChar(LoadLStr(1006)));
  info_call(PT_FDESCR, 'emf', PWideChar(LoadLStr(1007)));
  info_call(PT_FDESCR, 'wmf', PWideChar(LoadLStr(1008)));
  info_call(PT_FDESCR, 'pcx', PWideChar(LoadLStr(1009)));
  info_call(PT_FDESCR, 'dcx', PWideChar(LoadLStr(1010)));
  info_call(PT_FDESCR, 'png', PWideChar(LoadLStr(1011)));
  info_call(PT_FDESCR, 'tga', PWideChar(LoadLStr(1012)));
  info_call(PT_FDESCR, 'tif', PWideChar(LoadLStr(1013)));
  info_call(PT_FDESCR, 'tiff', PWideChar(LoadLStr(1013)));
  info_call(PT_FDESCR, 'wbmp', PWideChar(LoadLStr(1014)));
  info_call(PT_FDESCR, 'wbm', PWideChar(LoadLStr(1014)));
  info_call(PT_FDESCR, 'psd', PWideChar(LoadLStr(1020)));
end;

end.
