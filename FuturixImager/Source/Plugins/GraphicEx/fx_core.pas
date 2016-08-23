unit fx_core;

interface

uses
  SysUtils, Classes, Windows, Graphics, GraphicEx,
  c_const, c_str;

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
begin
  Result.result_type := RT_BOOL;
  Result.result_value := FX_TRUE;

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

  info_call(PT_FDESCR, 'pcd', FXL_FORMAT_PCD);
  info_call(PT_FDESCR, 'cel', FXL_FORMAT_RARE_AUTODESK_IMG);
  info_call(PT_FDESCR, 'pic', FXL_FORMAT_RARE_AUTODESK_IMG);
  info_call(PT_FDESCR, 'psp', FXL_FORMAT_PSP);
  info_call(PT_FDESCR, 'eps', FXL_FORMAT_EPS);
end;

function PluginOpen(document_path, info: PWideChar; page: ULONG; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult;
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
  else if (ext = 'pcd') then
    begin
    TPCDGraphic.DefaultResolution := 4;

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
  else if (ext = 'psp') then
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
  FxCore2;

end.
