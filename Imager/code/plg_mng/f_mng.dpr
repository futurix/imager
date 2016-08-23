library f_mng;

uses
  c_const,
  Windows, Graphics, SysUtils, Classes,
  mpLibMNG, mpMNGZLIB;

{$R *.RES}
{$R sRGBprof.res}

{****************************************************************************}

var HFHandle   : mng_handle;
    IFRslt     : mng_retcode;
    SFFileName : string;
    OFFile     : file;
    BFFirst    : boolean;
    BFLast     : boolean;
    BFWriting  : boolean;
    IFDelay    : integer;
    OFBitmap   : TBitmap;

{****************************************************************************}
{**                                                                        **}
{****************************************************************************}

{$F+}
function XNG_alloc (IHSize : mng_size_t) : mng_ptr; stdcall;
{$F-}
begin
  GetMem   (Result,  IHSize);
  FillChar (Result^, IHSize, 0);
end;

{****************************************************************************}

{$F+}
procedure XNG_free (PHPtr  : mng_ptr;
                    IHSize : mng_size_t); stdcall;
{$F-}
begin
  FreeMem (PHPtr, IHSize);
end;

{****************************************************************************}

{$F+}
function XNG_gettickcount (HHHandle : mng_handle) : mng_uint32; stdcall;
{$F-}
begin
  Result := Windows.GetTickCount;
end;

{****************************************************************************}

{$F+}
function XNG_openstream (HHHandle : mng_handle) : mng_bool; stdcall;
{$F-}
begin
  AssignFile (OFFile, SFFileName);

  if BFWriting then
    Rewrite  (OFFile, 1)
  else
    Reset    (OFFile, 1);

  Result := MNG_TRUE;
end;

{****************************************************************************}

{$F+}
function XNG_closestream (HHHandle : mng_handle) : mng_bool; stdcall;
{$F-}
begin
  CloseFile (OFFile);
  Result := MNG_TRUE;
end;

{****************************************************************************}

{$F+}
function XNG_readdata (    HHHandle : mng_handle;
                           PHBuf    : mng_ptr;
                           IHBuflen : mng_uint32;
                       var IHRead   : mng_uint32) : mng_bool; stdcall;
{$F-}
begin
  if not BFWriting then
  begin
    if EOF (OFFile) then
      IHRead := 0
    else
      BlockRead (OFFile, PHBuf^, IHBuflen, IHRead);
  end;

  Result := MNG_TRUE;
end;

{****************************************************************************}

{$F+}
function XNG_writedata (    HHHandle  : mng_handle;
                            PHBuf     : mng_ptr;
                            IHBuflen  : mng_uint32;
                        var IHWritten : mng_uint32) : mng_bool; stdcall;
{$F-}
begin
  if BFWriting then
    BlockWrite (OFFile, PHBuf^, IHBuflen, IHWritten);

  Result := MNG_TRUE;
end;

{****************************************************************************}

{$F+}
function XNG_errorproc (HHHandle    : mng_handle;
                        IHErrorcode : mng_retcode;
                        IHSeverity  : mng_uint8;
                        IHChunkname : mng_chunkid;
                        IHChunkseq  : mng_uint32;
                        IHExtra1    : mng_int32;
                        IHExtra2    : mng_int32;
                        SHErrortext : mng_pchar ) : mng_bool; stdcall;
{$F-}
begin
  Result := MNG_TRUE;
end;

{****************************************************************************}

{$F+}
function XNG_processheader (HHHandle : mng_handle;
                            IHWidth  : mng_uint32;
                            IHHeight : mng_uint32) : mng_bool; stdcall;
{$F-}
begin
  with OFBitmap do
  begin
    Width       := IHWidth;
    Height      := IHHeight;
    HandleType  := bmDIB;
    PixelFormat := pf24bit;
  end;

  Result := MNG_TRUE;
end;

{****************************************************************************}

{$F+}
function XNG_processtext (HHHandle      : mng_handle;
                          IHType        : mng_uint8;
                          SHKeyword     : mng_pchar;
                          SHText        : mng_pchar;
                          SHLanguage    : mng_pchar;
                          SHTranslation : mng_pchar) : mng_bool; stdcall;
{$F-}
begin
  Result := MNG_TRUE;
end;

{****************************************************************************}

{$F+}
function XNG_getcanvasline (HHHandle : mng_handle;
                            IHLineNr : mng_uint32) : mng_ptr; stdcall;
{$F-}
begin
  Result := OFBitmap.ScanLine [IHLineNr];
end;

{****************************************************************************}

{$F+}
function XNG_refresh (HHHandle : mng_handle;
                      IHX, IHY : mng_uint32;
                      IHWidth  : mng_uint32;
                      IHHeight : mng_uint32) : mng_bool; stdcall;
{$F-}
begin
  Result := MNG_TRUE;
end;

{****************************************************************************}

{$F+}
function XNG_settimer (HHHandle : mng_handle;
                       IHMSecs  : mng_uint32) : mng_bool; stdcall;
{$F-}
begin
  IFDelay := IHMSecs;
  Result  := MNG_TRUE;
end;

{****************************************************************************}
{**                                                                        **}
{****************************************************************************}

procedure ShowXNGerror;

var iSeverity  : mng_uint8;
    iChunkname : mng_chunkid;
    iChunkseq  : mng_uint32;
    iExtra1    : mng_int32;
    iExtra2    : mng_int32;
    zErrortext : mng_pchar;
//    SHMsg      : string;

begin
  IFRslt := mng_getlasterror (HFHandle, iSeverity, iChunkname, iChunkseq,
                                        iExtra1, iExtra2, zErrortext);

{  SHMsg  := 'Error in libmng!!!' + #13#10 + StrPas (zErrorText) + #13#10 +
            Format ('[Error = %d; Severity = %d; Chunknr = %d; Extra = %d/%d]',
                    [IFRslt, iSeverity, iChunkseq, iExtra1, iExtra2]);
  Windows.MessageBox (0, PChar (SHMsg), 'Libmng error', MB_OK); }
end;

{****************************************************************************}

procedure InitializeXNG;

var OHFile : TResourceStream;

begin
  HFHandle := mng_initialize (nil, XNG_alloc, XNG_free, nil);

  if HFHandle = MNG_NULL then
  begin
    ShowXNGerror;
    Exit;
  end;

  if not BFWriting then
  begin
    OHFile := TResourceStream.Create (HINSTANCE, 'sRGB', RT_RCDATA);

    try
      if (mng_set_srgb           (HFHandle, true                      ) <> MNG_NOERROR) or
         (mng_set_outputprofile2 (HFHandle, OHFile.Size, OHFile.Memory) <> MNG_NOERROR) or
         (mng_set_storechunks    (HFHandle, MNG_FALSE                 ) <> MNG_NOERROR) then
      begin
        ShowXNGerror;
        Exit;
      end;
    finally
      OHFile.Free;
    end;
  end;

  if (mng_setcb_openstream    (HFHandle, XNG_openstream   ) <> MNG_NOERROR) or
     (mng_setcb_closestream   (HFHandle, XNG_closestream  ) <> MNG_NOERROR) or
     (mng_setcb_readdata      (HFHandle, XNG_readdata     ) <> MNG_NOERROR) or
     (mng_setcb_writedata     (HFHandle, XNG_writedata    ) <> MNG_NOERROR) or
     (mng_setcb_errorproc     (HFHandle, XNG_errorproc    ) <> MNG_NOERROR) or
     (mng_setcb_processheader (HFHandle, XNG_processheader) <> MNG_NOERROR) or
     (mng_setcb_processtext   (HFHandle, XNG_processtext  ) <> MNG_NOERROR) or
     (mng_setcb_getcanvasline (HFHandle, XNG_getcanvasline) <> MNG_NOERROR) or
     (mng_setcb_refresh       (HFHandle, XNG_refresh      ) <> MNG_NOERROR) or
     (mng_setcb_gettickcount  (HFHandle, XNG_gettickcount ) <> MNG_NOERROR) or
     (mng_setcb_settimer      (HFHandle, XNG_settimer     ) <> MNG_NOERROR) then
    ShowXNGerror
  else
  if (mng_set_canvasstyle     (HFHandle, MNG_CANVAS_BGR8  ) <> MNG_NOERROR) or
     (mng_set_bkgdstyle       (HFHandle, MNG_CANVAS_BGR8  ) <> MNG_NOERROR) or
     (mng_set_bgcolor         (HFHandle, $7F, $7F, $7F    ) <> MNG_NOERROR) then
    ShowXNGerror;
end;

{****************************************************************************}

procedure CleanupXNG;
begin
  if mng_cleanup (HFHandle) <> MNG_NOERROR then
    ShowXNGerror;
    
  HFHandle := MNG_NULL;
end;


{****************************************************************************}

procedure LoadXNG (SHFileName : string);
begin
  SFFileName := SHFileName;
  if (mng_read (HFHandle) <> MNG_NOERROR) then
    ShowXNGerror;
end;

{****************************************************************************}

procedure DisplayFirstFrameXNG;
begin
  IFRslt := mng_display (HFHandle);

  if mng_get_imagetype (HFHandle) <> mng_it_mng then
  begin
    while IFRslt = MNG_NEEDTIMERWAIT do
    begin
      Windows.Sleep (IFDelay);
      IFRslt := mng_display_resume (HFHandle);
    end;
  end;

  if (IFRslt <> MNG_NOERROR) and (IFRslt <> MNG_NEEDTIMERWAIT) then
    ShowXNGerror;
end;

{****************************************************************************}

procedure DisplayXNG;
begin
  IFRslt := mng_display (HFHandle);
  if (IFRslt <> MNG_NOERROR) and (IFRslt <> MNG_NEEDTIMERWAIT) then
    ShowXNGerror;
end;

{****************************************************************************}

procedure DisplayResumeXNG;
begin
  IFRslt := mng_display_resume (HFHandle);
  if (IFRslt <> MNG_NOERROR) and (IFRslt <> MNG_NEEDTIMERWAIT) then
    ShowXNGerror;
end;

{****************************************************************************}

procedure RestartXNG;
begin
  if (mng_display_reset (HFHandle) <> MNG_NOERROR) then
    ShowXNGerror;

  BFFirst := true;
  IFRslt  := mng_display (HFHandle);

  if (IFRslt <> MNG_NOERROR) and (IFRslt <> MNG_NEEDTIMERWAIT) then
    ShowXNGerror;
end;

{****************************************************************************}

function SavePNG (img : hBitmap; path : string) : integer;

type TBytes     = packed array [0 .. 2] of byte;
     PBytes     = ^TBytes;

var OHBitmap    : TBitmap;
    IHW, IHH    : integer;
    SHRawData   : string;
    IHBitDepth  : byte;
    IHColorType : byte;
    IHMaxCol    : integer;
    AHPalette   : mng_palette8;
    AHCount     : array [0 .. 255] of integer;

{===========================================================================}

procedure DetermineNrOfColors;

var IHX, IHY : integer;
    IHZ      : integer;
    OHTemp   : PBytes;

begin
  IHMaxCol := 0;
  IHY      := 0;

  while (IHY < IHH) and (IHMaxCol <= 256) do
  begin
    OHTemp := PBytes (OHBitmap.Scanline [IHY]);
    IHX    := 0;

    while (IHX < IHW) and (IHMaxCol <= 256) do
    begin
      IHZ := 0;

      while (IHZ < IHMaxCol) and
            ( (OHTemp^ [2] <> AHPalette [IHZ].iRed  ) or
              (OHTemp^ [1] <> AHPalette [IHZ].iGreen) or
              (OHTemp^ [0] <> AHPalette [IHZ].iBlue )    ) do
        inc (IHZ);

      if IHZ < IHMaxCol then
      begin
        inc (AHCount [IHZ]);
      end
      else
      begin
        if IHMaxCol < 256 then
        begin
          AHPalette [IHMaxCol].iRed   := OHTemp^ [2];
          AHPalette [IHMaxCol].iGreen := OHTemp^ [1];
          AHPalette [IHMaxCol].iBlue  := OHTemp^ [0];
          AHCount   [IHMaxCol]        := 1;
        end;

        inc (IHMaxCol);
      end;

      OHTemp := PBytes (integer (OHTemp) + 3);
      inc (IHX);
    end;

    inc (IHY);
  end;
end;

{===========================================================================}

procedure SwapEntry (IHX, IHY : integer);

var IHB : byte;
    IHI : integer;

begin
  IHB                    := AHPalette [IHX].iRed;
  AHPalette [IHX].iRed   := AHPalette [IHY].iRed;
  AHPalette [IHY].iRed   := IHB;
  IHB                    := AHPalette [IHX].iGreen;
  AHPalette [IHX].iGreen := AHPalette [IHY].iGreen;
  AHPalette [IHY].iGreen := IHB;
  IHB                    := AHPalette [IHX].iBlue;
  AHPalette [IHX].iBlue  := AHPalette [IHY].iBlue;
  AHPalette [IHY].iBlue  := IHB;
  IHI                    := AHCount   [IHX];
  AHCount   [IHX]        := AHCount   [IHY];
  AHCount   [IHY]        := IHI;
end;

{===========================================================================}

procedure SortPalette;

var IHX, IHY : integer;

begin
  for IHX := 0 to IHMaxCol-2 do
    for IHY := IHX to IHMaxCol-2 do
      if AHCount [IHY] < AHCount [IHY+1] then
        SwapEntry (IHY, IHY+1);
end;

{===========================================================================}

procedure CreateIndexedData1;

var IHX, IHY : integer;
    IHR      : integer;
    IHZ      : integer;
    OHTemp   : PBytes;
    IHLineW  : integer;

begin
  SortPalette;

  IHLineW     := ((IHW + 7) shr 3) + 1;
  SHRawData   := StringOfChar (#0, IHLineW * IHH);
  IHBitDepth  := 1;
  IHColorType := 3;
  IHY         := 0;

  while IHY < IHH do
  begin
    OHTemp := PBytes (OHBitmap.Scanline [IHY]);
    IHR    := (IHY * IHLineW) + 2;
    IHX    := 0;

    while IHX < IHW do
    begin
      IHZ := 0;

      while (IHZ < IHMaxCol) and
            ( (OHTemp^ [2] <> AHPalette [IHZ].iRed  ) or
              (OHTemp^ [1] <> AHPalette [IHZ].iGreen) or
              (OHTemp^ [0] <> AHPalette [IHZ].iBlue )    ) do
        inc (IHZ);

      case (IHX mod 8) of
        0 : SHRawData [IHR] := chr ((IHZ and $01) shl 7);
        1 : SHRawData [IHR] := chr (ord (SHRawData [IHR]) + (IHZ and $01) shl 6);
        2 : SHRawData [IHR] := chr (ord (SHRawData [IHR]) + (IHZ and $01) shl 5);
        3 : SHRawData [IHR] := chr (ord (SHRawData [IHR]) + (IHZ and $01) shl 4);
        4 : SHRawData [IHR] := chr (ord (SHRawData [IHR]) + (IHZ and $01) shl 3);
        5 : SHRawData [IHR] := chr (ord (SHRawData [IHR]) + (IHZ and $01) shl 2);
        6 : SHRawData [IHR] := chr (ord (SHRawData [IHR]) + (IHZ and $01) shl 1);
      else  SHRawData [IHR] := chr (ord (SHRawData [IHR]) + (IHZ and $01));
      end;

      OHTemp := PBytes (integer (OHTemp) + 3);

      if (IHX mod 8) = 7 then
        inc (IHR);

      inc (IHX);
    end;

    inc (IHY);
  end;
end;

{===========================================================================}

procedure CreateIndexedData2;

var IHX, IHY : integer;
    IHR      : integer;
    IHZ      : integer;
    OHTemp   : PBytes;
    IHLineW  : integer;

begin
  SortPalette;

  IHLineW     := ((IHW + 3) shr 2) + 1;
  SHRawData   := StringOfChar (#0, IHLineW * IHH);
  IHBitDepth  := 2;
  IHColorType := 3;
  IHY         := 0;

  while IHY < IHH do
  begin
    OHTemp := PBytes (OHBitmap.Scanline [IHY]);
    IHR    := (IHY * IHLineW) + 2;
    IHX    := 0;

    while IHX < IHW do
    begin
      IHZ := 0;

      while (IHZ < IHMaxCol) and
            ( (OHTemp^ [2] <> AHPalette [IHZ].iRed  ) or
              (OHTemp^ [1] <> AHPalette [IHZ].iGreen) or
              (OHTemp^ [0] <> AHPalette [IHZ].iBlue )    ) do
        inc (IHZ);

      case (IHX mod 4) of
        0 : SHRawData [IHR] := chr ((IHZ and $03) shl 6);
        1 : SHRawData [IHR] := chr (ord (SHRawData [IHR]) + (IHZ and $03) shl 4);
        2 : SHRawData [IHR] := chr (ord (SHRawData [IHR]) + (IHZ and $03) shl 2);
      else  SHRawData [IHR] := chr (ord (SHRawData [IHR]) + (IHZ and $03));
      end;

      OHTemp := PBytes (integer (OHTemp) + 3);

      if (IHX mod 4) = 3 then
        inc (IHR);

      inc (IHX);
    end;

    inc (IHY);
  end;
end;

{===========================================================================}

procedure CreateIndexedData4;

var IHX, IHY : integer;
    IHR      : integer;
    IHZ      : integer;
    OHTemp   : PBytes;
    IHLineW  : integer;

begin
  SortPalette;

  IHLineW     := ((IHW + 1) shr 1) + 1;
  SHRawData   := StringOfChar (#0, IHLineW * IHH);
  IHBitDepth  := 4;
  IHColorType := 3;
  IHY         := 0;

  while IHY < IHH do
  begin
    OHTemp := PBytes (OHBitmap.Scanline [IHY]);
    IHR    := (IHY * IHLineW) + 2;
    IHX    := 0;

    while IHX < IHW do
    begin
      IHZ := 0;

      while (IHZ < IHMaxCol) and
            ( (OHTemp^ [2] <> AHPalette [IHZ].iRed  ) or
              (OHTemp^ [1] <> AHPalette [IHZ].iGreen) or
              (OHTemp^ [0] <> AHPalette [IHZ].iBlue )    ) do
        inc (IHZ);

      if (IHX mod 2) = 0 then
        SHRawData [IHR] := chr ((IHZ and $0F) shl 4)
      else
        SHRawData [IHR] := chr (ord (SHRawData [IHR]) + (IHZ and $0F));

      OHTemp := PBytes (integer (OHTemp) + 3);

      if (IHX mod 2) = 1 then
        inc (IHR);

      inc (IHX);
    end;

    inc (IHY);
  end;
end;

{===========================================================================}

procedure CreateIndexedData8;

var IHX, IHY : integer;
    IHR      : integer;
    IHZ      : integer;
    OHTemp   : PBytes;

begin
  SortPalette;

  SHRawData   := StringOfChar (#0, (IHW + 1) * IHH);
  IHBitDepth  := 8;
  IHColorType := 3;
  IHY         := 0;

  while IHY < IHH do
  begin
    OHTemp := PBytes (OHBitmap.Scanline [IHY]);
    IHR    := (IHY * (IHW + 1)) + 2;
    IHX    := 0;

    while IHX < IHW do
    begin
      IHZ := 0;

      while (IHZ < IHMaxCol) and
            ( (OHTemp^ [2] <> AHPalette [IHZ].iRed  ) or
              (OHTemp^ [1] <> AHPalette [IHZ].iGreen) or
              (OHTemp^ [0] <> AHPalette [IHZ].iBlue )    ) do
        inc (IHZ);

      SHRawData [IHR] := chr (IHZ);

      OHTemp := PBytes (integer (OHTemp) + 3);
      inc (IHX);
      inc (IHR);
    end;

    inc (IHY);
  end;
end;

{===========================================================================}

procedure CreateRGBAdata;

var IHX, IHY : integer;
    IHR      : integer;
    OHTemp   : PBytes;

begin
  SHRawData   := StringOfChar (#0, ((IHW * 3) + 1) * IHH);
  IHBitDepth  := 8;
  IHColorType := 2;
  IHY         := 0;

  while IHY < IHH do
  begin
    OHTemp := PBytes (OHBitmap.Scanline [IHY]);
    IHR    := (IHY * ((IHW * 3) + 1)) + 2;
    IHX    := 0;

    while IHX < IHW do
    begin
      SHRawData [IHR] := chr (OHTemp [2]);
      inc (IHR);
      SHRawData [IHR] := chr (OHTemp [1]);
      inc (IHR);
      SHRawData [IHR] := chr (OHTemp [0]);
      inc (IHR);

      OHTemp := PBytes (integer (OHTemp) + 3);
      inc (IHX);
    end;

    inc (IHY);
  end;
end;

{===========================================================================}

procedure WritePNG;

var IHBuflen : integer;
    SHBuf    : string;
    IHRslt   : integer;

begin
  BFWriting  := true;
  SFFileName := path;

  try
    InitializeXNG;

    try
      IHBufLen := length (SHRawData) + 1000;

      repeat
        SHBuf  := StringOfChar  (#0, IHBufLen);
        IHRslt := DeflateString2 (SHRawData, SHBuf, Z_BEST_COMPRESSION,
                                  Z_DEFLATED, 15, Z_MAX_MEM_LEVEL, Z_FILTERED);

        if IHRslt = Z_BUF_ERROR then
          IHBufLen := IHBufLen + 1000;

      until IHRslt <> Z_BUF_ERROR;

      if IHRslt <> 0 then
      begin
        ShowXNGerror;
        exit;
      end;

      if mng_reset (HFHandle) <> MNG_NOERROR then
      begin
        ShowXNGerror;
        exit;
      end;

      if mng_create (HFHandle) <> MNG_NOERROR then
      begin
        ShowXNGerror;
        exit;
      end;

      if (mng_putchunk_ihdr (HFHandle, IHW, IHH, IHBitdepth,
                             IHColortype, 0, 0, 0) <> MNG_NOERROR) then
      begin
        ShowXNGerror;
        exit;
      end;

      if mng_putchunk_gama (HFHandle, MNG_FALSE, 45455) <> MNG_NOERROR then
      begin
        ShowXNGerror;
        exit;
      end;

      if mng_putchunk_srgb (HFHandle, MNG_FALSE, 1) <> MNG_NOERROR then
      begin
        ShowXNGerror;
        exit;
      end;

      if IHColorType = 3 then
      begin
        if IHMaxCol > 0 then
        begin
          if (mng_putchunk_plte (HFHandle, IHMaxCol, AHPalette) <> MNG_NOERROR) then
          begin
            ShowXNGerror;
            exit;
          end;
        end;
      end;

      if (mng_putchunk_idat (HFHandle, length (SHBuf), @SHBuf [1]) <> MNG_NOERROR) then
      begin
        ShowXNGerror;
        exit;
      end;

      if mng_putchunk_iend (HFHandle) <> MNG_NOERROR then
      begin
        ShowXNGerror;
        exit;
      end;

      if mng_write (HFHandle) <> MNG_NOERROR then
      begin
        ShowXNGerror;
        exit;
      end;

    finally
      CleanupXNG;
    end;

  finally
    BFWriting := false;
  end;
end;

{===========================================================================}

begin
  Result := 0;
  OHBitmap := TBitmap.Create;

  try
    OHBitmap.Handle      := img;
    OHBitmap.HandleType  := bmDIB;
    OHBitmap.PixelFormat := pf24bit;
    IHW                  := OHBitmap.Width;
    IHH                  := OHBitmap.Height;

    DetermineNrOfColors;

    if IHMaxCol <= 256 then
    begin
      if IHMaxCol <= 2 then
        CreateIndexedData1
      else
      if IHMaxCol <= 4 then
        CreateIndexedData2
      else
      if IHMaxCol <= 16 then
        CreateIndexedData4
      else
        CreateIndexedData8;
    end
    else
      CreateRGBAdata;

    WritePNG;

  finally
    OHBitmap.Free;
  end;
end;

{****************************************************************************}
{**                                                                        **}
{****************************************************************************}

function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; cdecl;
begin
func(PT_FOPEN,'mng','Multiple-image Network Graphics (*.mng)');
func(PT_FOPEN,'jng','JPEG Network Graphics (*.jng)');

func(PT_FOPENANIM,'mng',' ');

Result:=true;
end;

{****************************************************************************}

function FOpen (path, ext : PChar; app : THandle) : hBitmap; cdecl;
begin
  OFBitmap := TBitmap.Create;

  try
    InitializeXNG;

    try
      LoadXNG (path);
      DisplayFirstFrameXNG;

      Result := OFBitmap.ReleaseHandle;

    finally
      CleanupXNG;
    end;

  finally
    OFBitmap.Free;
    OFBitmap := nil;
  end;
end;

{****************************************************************************}

function FAnimStart (filename, ext : PChar; app : THandle) : integer; cdecl;
begin
  OFBitmap   := TBitmap.Create;
  SFFileName := filename;
  BFFirst    := true;
  BFLast     := false;

  InitializeXNG;
  LoadXNG (filename);
  DisplayXNG;

  if (IFRslt <> MNG_NOERROR) and (IFRslt <> MNG_NEEDTIMERWAIT) then
    Result := 0
  else
    Result := 1;
end;

{****************************************************************************}

function FAnimRestart () : integer; cdecl;
begin
  BFFirst := true;
  BFLast  := false;
  
  RestartXNG;

  if (IFRslt <> MNG_NOERROR) and (IFRslt <> MNG_NEEDTIMERWAIT) then
    Result := 0
  else
    Result := 1;
end;

{****************************************************************************}

function FAnimGetFrame (var img : hBitmap; var delay : integer) : integer; cdecl;

var OHBitmap : TBitmap;

begin
  if not BFFirst then
    DisplayResumeXNG;

  if BFLast then
    img      := 0
  else
  begin
    OHBitmap := TBitmap.Create;

    try
      OHBitmap.Assign (OFBitmap);
      img    := OHBitmap.ReleaseHandle;
    finally
      OHBitmap.Free;
    end;
  end;

  delay      := IFDelay;
  BFFirst    := false;

  if IFRslt = MNG_NOERROR then
    BFLast   := true;

  if (IFRslt <> MNG_NOERROR) and (IFRslt <> MNG_NEEDTIMERWAIT) then
    Result   := 0
  else
    Result   := 1;
end;

{****************************************************************************}

function FAnimStop () : integer; cdecl;
begin
  CleanupXNG;

  OFBitmap.Free;

  if IFRslt <> MNG_NOERROR then
    Result := 0
  else
    Result := 1;
end;

{****************************************************************************}

exports
  FQuery, FOpen,
  FAnimStart, FAnimRestart, FAnimGetFrame, FAnimStop;

{****************************************************************************}

begin
  HFHandle   := MNG_NULL;
  IFRslt     := 0;
  SFFileName := '';
  BFFirst    := true;
  BFLast     := false;
  BFWriting  := false;
  IFDelay    := 0;
  OFBitmap   := nil;
end.
