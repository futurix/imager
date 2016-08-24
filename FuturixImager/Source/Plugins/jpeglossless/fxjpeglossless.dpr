library fxjpeglossless;

uses
  Windows,
  SysUtils,
  Classes,
  Forms,
  c_const,
  c_locales,
  ImageEnIO,
  rotate in 'rotate.pas' {frmJPEG},
  cut in 'cut.pas' {frmCut};

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

    info_call(PT_FNAME, 'JPEG lossless transformations', '');
    info_call(PT_FROLE, PR_JPEGLL, '');

  info_call(PT_FTOOL, PChar(LoadLStr(3401)), ' ');
end;

function FxImgTool(document_path, info: PChar; img: HBITMAP; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
  temp_res: TFxImgResult;
    io: TImageEnIO;
    markers: TIEJpegCopyMarkers;
begin
    Result.result_type := RT_BOOL;
    Result.result_value := FX_TRUE;

  Application.Handle := app;

    if (@app_query <> nil) then
        begin
      temp_res := app_query(CQ_GETLANGLIBS, 0, 0);

        if (temp_res.result_type = RT_HANDLE) then
          begin
            locale_lib := temp_res.result_value;
            backup_lib := temp_res.result_xtra;
            end;
        end;

    io := TImageEnIO.Create(nil);
    io.ParamsFromFile(PChar(document_path));

    if ((not io.Aborting) and (io.Params.FileType = ioJPEG)) then
      begin
        if (((io.Params.Width mod 8) <> 0) or ((io.Params.Height mod 8) <> 0)) then
          MessageBox(wnd, PChar(LoadLStr(3413)), sAppName, MB_OK or MB_ICONWARNING);

        img_width := io.Params.Width;
        img_height := io.Params.Height;
        cut_rect := Rect(0, 0, 0, 0);

      frmJPEG := TfrmJPEG.Create(Application);
      frmJPEG.ShowModal();

        if (apply_transf) then
          begin
            if (transf = jtNone) then
              markers := jcCopyNone
            else
              markers := jcCopyAll;

            if (frmJPEG.cbxBackup.Checked) then
              CopyFile(document_path, PChar(ChangeFileExt(String(document_path), '.jpg.bak')), false);

            JpegLosslessTransform2(document_path, transf, false, markers, cut_rect, frmJPEG.cbxEXIF.Checked);

        Result.result_type := RT_INT;
        Result.result_value := 1;
            StrLCopy(Result.result_string_data, document_path, 2048);
            end;

      FreeAndNil(frmJPEG);
        end
    else
        MessageBox(wnd, PChar(LoadLStr(3402)), sAppName, MB_OK or MB_ICONWARNING);

    FreeAndNil(io);
end;

exports
  FxImgQuery, FxImgTool;

begin
end.
 