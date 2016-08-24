library fxmain;

uses
  SysUtils, Windows, Classes, Graphics, Forms, Dialogs,
  ImageEnIO, ImageEnProc, hyieutils, hyiedefs, iewic,
  c_const, c_utils, c_locales, c_reg, c_graphics, c_ie,
  JPEG2Ksave in 'JPEG2Ksave.pas' {frmJPsave},
  TIFFsave in 'TIFFsave.pas' {frmTIFFsave},
  JPEGsave in 'JPEGsave.pas' {frmJPEGsave},
  ScanOptions in 'ScanOptions.pas' {frmScanOpt},
  XRsave in 'XRsave.pas' {frmXRsave};

{$R *.RES}


function FxImgQuery(plugin_path: PWideChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
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

  info_call(PT_FNAME, 'Core functions', '');
  info_call(PT_FROLE, PR_SCAN, '');
  info_call(PT_FCONFIG, PWideChar(LoadLStr(3700)), '');

  info_call(PT_FOPEN, 'tif', '');
  info_call(PT_FOPEN, 'tiff', '');
  info_call(PT_FOPEN, 'dcx', '');
  info_call(PT_FOPEN, 'cur', '');

  info_call(PT_FSAVE, 'jp2', '');
  info_call(PT_FSAVE, 'j2k', '');
  info_call(PT_FSAVE, 'bmp', '');
  info_call(PT_FSAVE, 'jpg', '');
  info_call(PT_FSAVE, 'pcx', '');
  info_call(PT_FSAVE, 'png', '');
  info_call(PT_FSAVE, 'pbm', '');
  info_call(PT_FSAVE, 'pgm', '');
  info_call(PT_FSAVE, 'ppm', '');
  info_call(PT_FSAVE, 'tga', '');
  info_call(PT_FSAVE, 'tif', '');
  info_call(PT_FSAVE, 'gif', '');
  info_call(PT_FSAVE, 'pdf', '');
  info_call(PT_FSAVE, 'ps', '');
  info_call(PT_FSAVE, 'txt', '');
  info_call(PT_FSAVE, 'psd', '');

  info_call(PT_FIMPORT, PWideChar(LoadLStr(3080)), ' ');

  info_call(PT_FDESCR, 'pdf', PWideChar(LoadLStr(1031)));
  info_call(PT_FDESCR, 'ps', PWideChar(LoadLStr(1032)));
  info_call(PT_FDESCR, 'cur', PWideChar(LoadLStr(1033)));
  info_call(PT_FDESCR, 'txt', PWideChar(LoadLStr(1034)));

  // Windows Imaging Component
  wic := TIEWICReader.Create();

  if wic.IsAvailable then
    begin
    info_call(PT_FOPEN, 'hdp', '');
    info_call(PT_FOPEN, 'wdp', '');

    info_call(PT_FSAVE, 'hdp', '');

    info_call(PT_FNOTREC, 'wdp', '');

    info_call(PT_FDESCR, 'hdp', PWideChar(LoadLStr(1065)));
    info_call(PT_FDESCR, 'wdp', PWideChar(LoadLStr(1065)));

    wic.Free();
    end;
end;

function FxImgOpen(document_path, info: PWideChar; page: ULONG; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
  bmp, tmp: TBitmap;
  io: TImageEnIO;
  imh: THandle;
  pic: TPicture;
  iif: TIconInfo;
  ext: string;
begin
  Result.result_type := RT_HBITMAP;
  Result.result_value := 0;
  Result.result_xtra := 1;

  ext := LowerCase(ExtractExt(string(document_path)));

  if (ext = 'cur') then
    begin
    imh := LoadImage(HInstance, document_path, IMAGE_ICON, 0, 0, LR_LOADFROMFILE + LR_DEFAULTCOLOR);

    if (imh <> 0) then
      begin
      bmp := TBitmap.Create();
      tmp := TBitmap.Create();
      pic := TPicture.Create();

      pic.Icon.Handle := imh;
      GetIconInfo(imh, iif);

      if (iif.hbmColor <> 0) then
        tmp.Handle := iif.hbmColor
      else
        tmp.Handle := iif.hbmMask;

      bmp.Width := tmp.Width;
      bmp.Height := tmp.Height;
      bmp.Canvas.Draw(0, 0, pic.Graphic);
      bmp.ApplyLimits();

      Result.result_value := bmp.ReleaseHandle();

      FreeAndNil(pic);
      FreeAndNil(bmp);
      FreeAndNil(tmp);
      end;
    end
  else
    begin
    iegEnableCMS := true;

    io := TImageEnIO.Create(nil);
    bmp := TBitmap.Create();

    io.Params.JPEG_DCTMethod := ioJPEG_IFAST;
    io.Params.IsNativePixelFormat := true;

    if (ext = 'dcx') then
      begin
      io.Params.DCX_ImageIndex := page;
      Result.result_xtra := EnumDCXIm(String(document_path));


      if (Result.result_xtra > 0) then
        io.LoadFromFileDCX(String(document_path));
      end
    else if ((ext = 'tif') or (ext = 'tiff')) then
      begin
      io.Params.TIFF_ImageIndex := page;

      Result.result_xtra := io.LoadFromFileTIFF(String(document_path));
      end
    else
      io.LoadFromFile(String(document_path));

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
end;

function FxImgSave(document_path, info: PWideChar; img: HBITMAP; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
  temp_res: TFxImgResult;
  bmp: TBitmap;
  mex: string;
  io: TImageEnIO;
  proc: TImageEnProc;
begin
  Result.result_type := RT_BOOL;
  Result.result_value := FX_FALSE;

  if (@app_query <> nil) then
    begin
    temp_res := app_query(CQ_GETLANGLIBS, 0, 0);

    if (temp_res.result_type = RT_HANDLE) then
      begin
      locale_lib := temp_res.result_value;
      backup_lib := temp_res.result_xtra;
      end;
    end;

  iegEnableCMS := true;

  bmp := TBitmap.Create();
  bmp.Handle := img;
  bmp.ApplyLimits();

  mex := ExtractExt(String(document_path));

  if ((mex = 'jp2') or (mex = 'j2k')) then
    begin
    frmJPsave := TfrmJPsave.Create(nil);
    frmJPsave.ShowModal();

    if jp2_confirm then
      begin
      io := TImageEnIO.Create(nil);
      io.IEBitmap.Assign(bmp);
      io.IEBitmap.PrepareAlphaAfterAssignment();

      if frmJPsave.cbxLossless.Checked then
        io.Params.J2000_Rate := 1.0
      else
        io.Params.J2000_Rate := (frmJPsave.tbrQuality.Position / 100);

      if (io.Params.J2000_Rate < 0.001) then
        io.Params.J2000_Rate := 0.001;

      if (mex = 'j2k') then
        io.SaveToFileJ2K(String(document_path))
      else
        io.SaveToFileJP2(String(document_path));

      if not io.Aborting then
        Result.result_value := FX_TRUE;

      FreeAndNil(io);
      end;

    FreeAndNil(frmJPsave);
    end
        
  else if (mex = 'bmp') then
    begin
    io := TImageEnIO.Create(nil);
    io.IEBitmap.Assign(bmp);
    io.IEBitmap.PrepareAlphaAfterAssignment();

    io.Params.BMP_HandleTransparency := true;

    io.SaveToFileBMP(String(document_path));

    if not io.Aborting then
      Result.result_value := FX_TRUE;

    FreeAndNil(io);
    end

  else if (mex = 'jpg') then
    begin
    frmJPEGsave := TfrmJPEGsave.Create(nil);
    frmJPEGsave.ShowModal();

    if jpeg_confirm then
      begin
      io := TImageEnIO.Create(nil);
      io.IEBitmap.Assign(bmp);
      io.IEBitmap.PrepareAlphaAfterAssignment();

      if (frmJPEGsave.tbrQuality.Position > 0) then
        io.Params.JPEG_Quality := frmJPEGsave.tbrQuality.Position
      else
        io.Params.JPEG_Quality := 1;
      io.Params.JPEG_Progressive := frmJPEGsave.cbxProgressive.Checked;
      io.Params.JPEG_OptimalHuffman := frmJPEGsave.cbxOptimized.Checked;

      io.SaveToFileJpeg(String(document_path));

      if not io.Aborting then
        Result.result_value := FX_TRUE;

      FreeAndNil(io);
      end;

    FreeAndNil(frmJPEGsave);
    end

  else if (mex = 'hdp') then
    begin
    frmXRsave := TfrmXRsave.Create(nil);
    frmXRsave.ShowModal();

    if xr_confirm then
      begin
      io := TImageEnIO.Create(nil);
      io.IEBitmap.Assign(bmp);
      io.IEBitmap.PrepareAlphaAfterAssignment();

      io.Params.HDP_ImageQuality := frmXRsave.tbrQuality.Position / 100;
      io.Params.HDP_Lossless := frmXRsave.cbxLossless.Checked;

      io.SaveToFileHDP(String(document_path));

      if not io.Aborting then
        Result.result_value := FX_TRUE;

      FreeAndNil(io);
      end;

    FreeAndNil(frmXRsave);
    end

  else if (mex = 'pcx') then
    begin
    io := TImageEnIO.Create(nil);
    io.IEBitmap.Assign(bmp);
    io.IEBitmap.PrepareAlphaAfterAssignment();

    io.Params.PCX_Compression := ioPCX_RLE;
    io.SaveToFilePCX(String(document_path));

    if not io.Aborting then
      Result.result_value := FX_TRUE;

    FreeAndNil(io);
    end

  else if (mex = 'png') then
    begin
    io := TImageEnIO.Create(nil);
    io.IEBitmap.Assign(bmp);
    io.IEBitmap.PrepareAlphaAfterAssignment();

    io.Params.PNG_Filter := ioPNG_FILTER_SUB;
    io.Params.PNG_Compression := 9;
    io.SaveToFilePNG(String(document_path));

    if not io.Aborting then
      Result.result_value := FX_TRUE;

    FreeAndNil(io);
    end

  else if (mex = 'psd') then
    begin
    io := TImageEnIO.Create(nil);
    io.IEBitmap.Assign(bmp);
    io.IEBitmap.PrepareAlphaAfterAssignment();

    io.SaveToFilePSD(String(document_path));

    if not io.Aborting then
      Result.result_value := FX_TRUE;

    FreeAndNil(io);
    end

  else if ((mex = 'pbm') or (mex = 'pgm') or (mex = 'ppm')) then
    begin
    io := TImageEnIO.Create(nil);
    io.IEBitmap.Assign(bmp);
    io.IEBitmap.PrepareAlphaAfterAssignment();

    io.IEBitmap.DefaultDitherMethod := ieOrdered;

    if (mex = 'pbm') then
      begin
      io.IEBitmap.PixelFormat := ie1g;
      io.Params.BitsPerSample := 1;
      io.Params.SamplesPerPixel := 1;
      end
    else if (mex = 'pgm') then
      begin
      io.IEBitmap.PixelFormat := ie8g;
      io.Params.BitsPerSample := 8;
      io.Params.SamplesPerPixel := 1;
      end
    else
      begin
      io.IEBitmap.PixelFormat := ie24RGB;
      io.Params.BitsPerSample := 8;
      io.Params.SamplesPerPixel := 3;
      end;

    io.SaveToFilePXM(String(document_path));

    if not io.Aborting then
      Result.result_value := FX_TRUE;

    FreeAndNil(io);
    end

  else if (mex = 'tga') then
    begin
    io := TImageEnIO.Create(nil);
    io.IEBitmap.Assign(bmp);
    io.IEBitmap.PrepareAlphaAfterAssignment();

    io.Params.TGA_Compressed := true;
    io.SaveToFileTGA(String(document_path));

    if not io.Aborting then
      Result.result_value := FX_TRUE;

    FreeAndNil(io);
    end

  else if (mex = 'gif') then
    begin
    io := TImageEnIO.Create(nil);
    io.IEBitmap.Assign(bmp);
    io.IEBitmap.PrepareAlphaAfterAssignment();

    io.SaveToFileGIF(String(document_path));

    if not io.Aborting then
      Result.result_value := FX_TRUE;

    FreeAndNil(io);
    end

  else if (mex = 'pdf') then
    begin
    io := TImageEnIO.Create(nil);

    io.CreatePDFFile(String(document_path));

    io.IEBitmap.Assign(bmp);
    io.IEBitmap.PrepareAlphaAfterAssignment();
    io.Params.PDF_Producer := sAppName;
    io.Params.PDF_Compression:= ioPDF_JPEG;
    io.SaveToPDF();

    io.ClosePDFFile();

    if not io.Aborting then
      Result.result_value := FX_TRUE;

    FreeAndNil(io);
    end

  else if (mex = 'ps') then
    begin
    io := TImageEnIO.Create(nil);

    io.CreatePSFile(String(document_path));

    io.IEBitmap.Assign(bmp);
    io.IEBitmap.PrepareAlphaAfterAssignment();
    io.Params.PS_Compression := ioPS_JPEG;
    io.SaveToPS();

    io.ClosePSFile();

    if not io.Aborting then
      Result.result_value := FX_TRUE;

    FreeAndNil(io);
    end

  else if (mex = 'txt') then
    begin
    io := TImageEnIO.Create(nil);

    io.IEBitmap.Assign(bmp);
    io.IEBitmap.PrepareAlphaAfterAssignment();

    proc := TImageEnProc.Create(nil);
    proc.AttachedIEBitmap := io.IEBitmap;

    if (io.IEBitmap.Width > 80) then
      proc.Resample(80, -1);

    io.SaveToText(String(document_path), ioUnknown, ietfASCIIArt);

    Result.result_value := FX_FALSE;

    FreeAndNil(proc);
    FreeAndNil(io);
    end

  else if (mex = 'tif') then
    begin
    frmTIFFsave := TfrmTIFFsave.Create(nil);
    frmTIFFsave.ShowModal();

    if tiff_confirm then
      begin
      io := TImageEnIO.Create(nil);
      io.IEBitmap.Assign(bmp);
      io.IEBitmap.PrepareAlphaAfterAssignment();

      io.IEBitmap.DefaultDitherMethod := ieOrdered;

      if frmTIFFsave.rbnCNone.Checked then
        io.Params.TIFF_Compression := ioTIFF_UNCOMPRESSED
      else if frmTIFFsave.rbnCLZW.Checked then
        io.Params.TIFF_Compression := IoTIFF_LZW
      else if frmTIFFsave.rbnCJPEG.Checked then
        begin
        io.Params.TIFF_Compression := ioTIFF_JPEG;

        if (frmTIFFsave.tbrQuality.Position > 0) then
          io.Params.TIFF_JPEGQuality := frmTIFFsave.tbrQuality.Position
        else
          io.Params.TIFF_JPEGQuality := 1;
        end
      else if frmTIFFsave.rbnCPackBits.Checked then
        io.Params.TIFF_Compression := ioTIFF_PACKBITS
      else if frmTIFFsave.rbnCG31.Checked then
        begin
        io.IEBitmap.PixelFormat := ie1g;
        io.Params.TIFF_Compression := ioTIFF_G3FAX1D;
        end
      else if frmTIFFsave.rbnCG32.Checked then
        begin
        io.IEBitmap.PixelFormat := ie1g;
        io.Params.TIFF_Compression := ioTIFF_G3FAX2D;
        end
      else if frmTIFFsave.rbnCG4.Checked then
        begin
        io.IEBitmap.PixelFormat := ie1g;
        io.Params.TIFF_Compression := ioTIFF_G4FAX;
        end
      else if frmTIFFsave.rbnCZlib.Checked then
        io.Params.TIFF_Compression := ioTIFF_CCITT1D
      else if frmTIFFsave.rbnZIP.Checked then
        io.Params.TIFF_Compression := ioTIFF_ZIP
      else
        io.Params.TIFF_Compression := IoTIFF_LZW;

      io.SaveToFileTIFF(String(document_path));

      if not io.Aborting then
        Result.result_value := FX_TRUE;

      FreeAndNil(io);
      end;

    FreeAndNil(frmTIFFsave);
    end;

  FreeAndNil(bmp);
end;

function FxImgImport(info: PWideChar; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
  temp_res: TFxImgResult;
  bmp: TBitmap;
  io: TImageEnIO;
  api: TIEAcquireApi;
begin
  Result.result_type := RT_HBITMAP;
  Result.result_value := 0;

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

  if ((string(info) = LoadLStr(3080)) or (string(info) = PR_SCAN)) then
    begin
    api := ieaWIA;

    if (FxRegRInt('Imaging_Subsystem', 0) = 1) then
      api := ieaTWain;

    // working
    io := TImageEnIO.Create(nil);
    bmp := TBitmap.Create();

    if ((api = ieaWIA) and (io.WIAParams.DevicesInfoCount = 0)) then
      MessageBox(wnd, PWideChar(LoadLStr(3707)), sAppName, MB_OK or MB_ICONERROR);

    if (io.SelectAcquireSource(api) and io.Acquire(api)) then
      begin
      io.IEBitmap.PrepareAlphaForExternalUse();
      io.IEBitmap.CopyToTBitmap(bmp);
      bmp.ApplyLimits();
      Result.result_value := bmp.ReleaseHandle();
      end;

    FreeAndNil(io);
    FreeAndNil(bmp);
    end;
end;

function FxImgCfg(info: PWideChar; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
  temp_res: TFxImgResult;
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

  frmScanOpt := TfrmScanOpt.Create(Application);
  frmScanOpt.ShowModal();
  FreeAndNil(frmScanOpt);
end;

exports
  FxImgQuery, FxImgOpen, FxImgSave, FxImgImport, FxImgCfg;

begin
end.
