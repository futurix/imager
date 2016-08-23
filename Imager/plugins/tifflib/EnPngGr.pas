{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnPngGr
|
| Description: TDibGraphic descendant for PNG files.
|
| History: Dec 29, 1998. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnPngGr;

{$I Envision.Inc}

interface

uses
    Classes,  { for TStream }
    SysUtils, { for Exception }
    EnDiGrph; { for TDibGraphic }

type

TPngCompressionLevel = (pcLow, pcMedium, pcHigh);

TPngGraphic = class(TDibGraphic)
protected
    FImageGamma              : Double;
    FBackgroundColor         : TRgb;
    FTransparentColor        : TRgb;

    FOverwriteFileBackground : Boolean;

    FCompressionLevel        : TPngCompressionLevel;
    FSaveProgressive         : Boolean;
    FSaveWithBackground      : Boolean;
    FSaveTransparent         : Boolean;

    class function CanRead( const Stream : TStream ) : Boolean; override;

public
    constructor Create; override;

    procedure SingleLoadFromStream( const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  ); override;
                                  
    procedure SaveToStream(Stream: TStream); override;

    property ImageGamma : Double read FImageGamma
                                 write FImageGamma;

    { Background used for images with a transparent color, or an
      alpha channel. Default is Black. See OverwriteFileBackground. }
    property BackgroundColor : TRgb read FBackgroundColor
                                    write FBackgroundColor;

    { if OverwriteFileBackground is True, even if the file specifies
      a background, the value in the Background property will be used
      as the background. Default is False. }
    property OverwriteFileBackground : Boolean
                                read FOverwriteFileBackground
                                write FOverwriteFileBackground;

    { default pcMedium }
    property CompressionLevel : TPngCompressionLevel
                                read FCompressionLevel
                                write FCompressionLevel;

    property SaveProgressive : Boolean read FSaveProgressive
                                        write FSaveProgressive;

    property SaveTransparent : Boolean read FSaveTransparent
                                       write FSaveTransparent;

    property SaveWithBackground : Boolean read FSaveWithBackground
                                          write FSaveWithBackground;

    property TransparentColor : TRgb read FTransparentColor
                                     write FTransparentColor;

end;

EPNGError = class(Exception);


var

{ MB Feb 25, 2002. Provide option to not display a message box on
  png library warnings. By defaults warnings are displayed. }
IgnorePNGWarnings : Boolean;

{--------------------------------------------------------------------------}

implementation

uses
    EnCLib,   { for png_XXXX }
    EnMisc,   { for CInchesPerMeter }
    EnMsg,    { for XXXXStr }
    Graphics, { for TPicture }
    Windows;  { for TRect }

{--------------------------------------------------------------------------}

procedure RaisePNGError( const Msg : String );
begin
    raise EPNGError.Create(Msg);
end;

{--------------------------------------------------------------------------}

constructor TPngGraphic.Create;
begin
    inherited Create;

    FImageGamma              := 0.5;

    FBackgroundColor         := MakeRgb(0,0,0);

    FOverwriteFileBackground := False;

    FCompressionLevel        := pcMedium;

    FSaveProgressive         := True;
end;

{--------------------------------------------------------------------------}

{$WARNINGS OFF}

procedure png_error_proc( png_ptr : png_structp;
                          msg     : png_const_charp ); cdecl;
begin
    RaisePNGError(msg);
end;

{--------------------------------------------------------------------------}

procedure png_warn_proc( png_ptr : png_structp;
                         msg     : png_const_charp ); cdecl;
begin
    if not IgnorePngWarnings then
        Windows.MessageBox( 0, msg, PChar('PNG Error'), MB_OK or MB_ICONWARNING);
end;

{--------------------------------------------------------------------------}

procedure png_read_proc( png_ptr  : png_structp;
                         pbuffer  : png_bytep;
                         size     : png_size_t ); cdecl;
var
    Stream : TStream;
begin
    Stream := TStream(png_get_io_ptr(png_ptr));
    Stream.Read(pBuffer^, Size);
end;

{--------------------------------------------------------------------------}

procedure png_write_proc( png_ptr  : png_structp;
                          pbuffer  : png_bytep;
                          size     : png_size_t ); cdecl;
var
    Stream : TStream;
begin
    Stream := TStream(png_get_io_ptr(png_ptr));
    Stream.Write(pBuffer^, Size);
end;

{--------------------------------------------------------------------------}

procedure png_flush_proc( png_ptr : png_structp); cdecl;
begin
end;

{$WARNINGS OFF}

{--------------------------------------------------------------------------}

procedure CopyPngPaletteToLogPalette( const PngPalette : png_palette;
                                      var   Palette    : TMaxLogPalette;
                                      const ColorCount : Integer );
var
    Index : Integer;
begin
    FillChar(Palette, SizeOf(Palette), 0);
    Palette.palVersion    := $0300;
    Palette.palNumEntries := ColorCount;
    for Index := 0 to (ColorCount-1) do
    begin  
        Palette.palPalEntry[Index].peRed   := PngPalette[Index].Red;
        Palette.palPalEntry[Index].peGreen := PngPalette[Index].Green;
        Palette.palPalEntry[Index].peBlue  := PngPalette[Index].Blue;
    end;
end;

{--------------------------------------------------------------------------}

procedure CopyLogPaletteToPngPalette( var   PngPalette : png_palette;
                                      const Palette    : TMaxLogPalette );
var
    Index : Integer;
begin
    FillChar(PngPalette, SizeOf(PngPalette), 0);
    for Index := 0 to (Palette.palNumEntries-1) do
    begin
        PngPalette[Index].Blue  := Palette.palPalEntry[Index].peBlue;
        PngPalette[Index].Green := Palette.palPalEntry[Index].peGreen;
        PngPalette[Index].Red   := Palette.palPalEntry[Index].peRed;
    end;
end;

{--------------------------------------------------------------------------}
(* MB Jan 03, 1998. Previous code reading row-by-row had problems with
   the first scan line, so now the image is read with png_read_image. For
   a 2 bit image, the memory requirements are reasonable.
procedure ReadConvert2To4Bit( const png_ptr   : png_structp;
                              const info_ptr  : png_infop;
                              const Dib       : TDibGraphic;
                              const Width     : LongInt;
                              const Height    : LongInt;
                              const Gray      : Boolean );
var
    PassNo             : Integer;
    pScanLine          : PByteArray;
    X,Y                : LongInt;
begin
    { assert: png_set_packing has been called. }

    GetMem(pScanLine, png_get_rowbytes(png_ptr, info_ptr));
    try
        for PassNo := 1 to PassCount do
        begin
            for Y := 0 to (Height-1) do
            begin
                png_read_row(png_ptr, png_bytep(pScanLine), nil);

                for X := 0 to (Width-1) do
                begin
                    if Gray then
                        Dib.PaletteIndex[X,Y] := pScanLine^[X] * 5
                    else
                        Dib.PaletteIndex[X,Y] := pScanLine^[X];
                end;
            end;
        end;
    finally
        FreeMem(pScanLine);
    end;
end;
*)

{--------------------------------------------------------------------------}

procedure ReadConvert2To4Bit( const png_ptr     : png_structp;
                              const info_ptr    : png_infop;
                              const Dib         : TDibGraphic;
                              const Width       : LongInt;
                              const Height      : LongInt;
                              const Gray        : Boolean;
                              var   LastPercent : ShortInt );
type
    TImage = array[0..(MaxLongInt div 4)-3] of PByteArray;
    TpImage = ^TImage;

    function GetPixelBc2( const ScanLine : PByteArray;
                          const X        : LongInt ) : LongInt;
    var
        pByte : ^Byte;
    begin
        pByte   := @ScanLine^[(X div 4)];

        Result := 0; { prevent compiler warning }

        case (X mod 4) of
            0 : Result := (pByte^ shr 6) and $03;
            1 : Result := (pByte^ shr 4) and $03;
            2 : Result := (pByte^ shr 2) and $03;
            3 : Result := pByte^ and $03;
        end;
    end;

    function AllocateImage( const RowWidth : LongInt;
                            const Height   : LongInt ) : TpImage;
    var
        RowNo : LongInt;
    begin
        GetMem(Result, Height * SizeOf(PByteArray));
        for RowNo := 0 to (Height-1) do
            GetMem(Result^[RowNo], RowWidth);
    end;

    procedure FreeImage( const RowWidth : LongInt;
                         const Height   : LongInt;
                         const pImage   : TpImage );
    var
        RowNo : LongInt;
    begin
        for RowNo := 0 to (Height-1) do
            FreeMem(pImage^[RowNo], RowWidth);
        FreeMem(pImage, Height * SizeOf(PByteArray));
    end;

var
    pImage      : TpImage;
    pScanLine   : PByteArray;
    X,Y         : LongInt;

begin
    pImage := AllocateImage(png_get_rowbytes(png_ptr, info_ptr), Height);
    try
        png_read_image(png_ptr, @pImage^[0]);

        for Y := 0 to (Height-1) do
        begin
            LastPercent := DoProgress( Dib, Dib.OnReadWriteProgress, Y, 0, Height-1, LastPercent );

            pScanLine := pImage^[Y];

            for X := 0 to (Width-1) do
            begin
                if Gray then
                    Dib.PaletteIndex[X,Y] := GetPixelBc2(pScanLine,X) * 5
                else
                    Dib.PaletteIndex[X,Y] := GetPixelBc2(pScanLine,X);
            end;
        end;

    finally
        FreeImage(png_get_rowbytes(png_ptr, info_ptr), Height, pImage);
    end;
end;

{--------------------------------------------------------------------------}

procedure ReadUsingScanLines( const png_ptr     : png_structp;
                              const Dib         : TDibGraphic;
                              const Height      : LongInt;
                              const PassCount   : Integer;
                              var   LastPercent : ShortInt );
var
    PassNo             : Integer;
    pScanLine          : PByteArray;
    Y                  : LongInt;
begin
    for PassNo := 1 to PassCount do
    begin
        for Y := 0 to (Height-1) do
        begin
            LastPercent := DoProgress( Dib, Dib.OnReadWriteProgress,
                                       Y + (Height-1)*(PassNo-1), 0,
                                       (Height-1)*PassCount, LastPercent );

            pScanLine := Dib.ScanLine[Y];
            png_read_row(png_ptr, png_bytep(pScanLine), nil);
        end;
    end;
end;

{--------------------------------------------------------------------------}

procedure TPngGraphic.SingleLoadFromStream(
                                    const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  );
var
    png_ptr            : png_structp;
    info_ptr           : png_infop;
    MagicBytes         : array[0..7] of Byte;

    Width              : Integer;
    Height             : Integer;
    BitDepth           : Integer;
    ColorType          : Integer;
    InterlaceType      : Integer;
    CompressionType    : Integer;
    FilterType         : Integer;

    ImageFormat        : TImageFormat;
    Convert2BitTo4Bit  : Boolean;

    res_x              : png_uint_32;
    res_y              : png_uint_32;
    unit_type          : Integer;

    ppngPalette        : png_palettep;
    ColorCount         : Integer;

    Palette            : TMaxLogPalette;
    pPalette           : PMaxLogPalette;

    Intent             : Integer;
    PassCount          : Integer;

    Background         : png_color_16;
    pBackground        : png_color_16p;

    LastPercent        : ShortInt;

begin
    LastPercent := -1;
    LastPercent := DoProgress( Self, FOnReadWriteProgress, 0, 0, 100, LastPercent );

    Stream.Read(MagicBytes, SizeOf(MagicBytes));

    if png_sig_cmp(@MagicBytes, 0, SizeOf(MagicBytes)) <> 0 then
        RaisePNGError(msgNotAValidPngFile);

    png_ptr := png_create_read_struct( PChar(PNG_LIBPNG_VER_STRING), nil,
                                       png_error_proc, png_warn_proc );
    if png_ptr = nil then
        RaisePNGError('png_create_read_struct failed');

    info_ptr := png_create_info_struct(png_ptr);
    if png_ptr = nil then
    begin
        png_destroy_read_struct(@png_ptr, nil, nil);
        RaisePNGError('png_create_info_struct failed');
    end;

    try
        png_set_read_fn(png_ptr, Pointer(Stream), png_read_proc);
        png_set_sig_bytes(png_ptr, SizeOf(MagicBytes));

        png_read_info(png_ptr, info_ptr);

        png_get_IHDR( png_ptr, info_ptr,
                      @Width, @Height, @BitDepth, @ColorType,
                      @InterlaceType, @CompressionType, @FilterType );

        Convert2BitTo4Bit := False;

        ImageFormat  := ifTrueColor; { prevent compiler warning }
        pPalette     := nil;

        if BitDepth = 1 then
        begin
            ImageFormat := ifBlackWhite;

            if not (ColorType in [ PNG_COLOR_TYPE_GRAY,
                                   PNG_COLOR_TYPE_PALETTE ]) then
                RaisePNGError(msgInvalidColorTypeForBitDepth);
        end
        else if BitDepth = 2 then
        begin
            case ColorType of
                PNG_COLOR_TYPE_GRAY :
                begin
                    ImageFormat  := ifGray16;
                    Convert2BitTo4Bit := True;
                end;
                PNG_COLOR_TYPE_PALETTE :
                begin
                    ImageFormat  := ifColor16;
                    Convert2BitTo4Bit := True;
                end;
                else
                    RaisePNGError(msgInvalidColorTypeForBitDepth);
            end;
        end
        else if BitDepth = 4 then
        begin
            case ColorType of
                PNG_COLOR_TYPE_GRAY    : ImageFormat  := ifGray16;
                PNG_COLOR_TYPE_PALETTE : ImageFormat  := ifColor16;
                else
                    RaisePNGError(msgInvalidColorTypeForBitDepth);
            end;
        end
        else if BitDepth = 8 then
        begin
            case ColorType of
                PNG_COLOR_TYPE_GRAY,
                PNG_COLOR_TYPE_GRAY_ALPHA  : ImageFormat := ifGray256;
                PNG_COLOR_TYPE_PALETTE     : ImageFormat := ifColor256;
                PNG_COLOR_TYPE_RGB,
                PNG_COLOR_TYPE_RGB_ALPHA   : ImageFormat := ifTrueColor;
                else
                    RaisePNGError(msgInvalidColorTypeForBitDepth);
            end;
        end
        else if BitDepth = 16 then
        begin
            png_set_strip_16(png_ptr);
            png_set_swap(png_ptr);

            case ColorType of
                PNG_COLOR_TYPE_GRAY,
                PNG_COLOR_TYPE_GRAY_ALPHA  : ImageFormat := ifGray256;
                PNG_COLOR_TYPE_PALETTE     : ImageFormat := ifColor256;
                PNG_COLOR_TYPE_RGB,
                PNG_COLOR_TYPE_RGB_ALPHA   : ImageFormat := ifTrueColor;
                else
                    RaisePNGError(msgInvalidColorTypeForBitDepth);
            end;
        end
        else
            RaisePNGError(msgInvalidBitDepth);

        if ImageFormat = ifTrueColor then
            png_set_bgr(png_ptr);

        if png_get_sRGB(png_ptr, info_ptr, @Intent) <> 0 then
            png_set_sRGB(png_ptr, info_ptr, intent)
        else if BitDepth > 2 then
        begin
            { MB. Dec 03, 1998. Only perform gamma adjustments with images
              with a bit count > 2. This has been determined empirically using
              test 2 bit gray scale images. }
            FImageGamma := 0;
            if (png_get_gAMA(png_ptr, info_ptr, @FImageGamma) <> 0) and
               (FImageGamma <> 0) then
                png_set_gamma( png_ptr, EnDiGrph.ScreenGamma, FImageGamma )
            else
            begin
                FImageGamma := 0.5;
                png_set_gamma( png_ptr, EnDiGrph.ScreenGamma, FImageGamma );
            end;
        end;

        FillChar(Background, SizeOf(Background), 0);
        Background.Red   := FBackgroundColor.Red;
        Background.Green := FBackgroundColor.Green;
        Background.Blue  := FBackgroundColor.Blue;

        if png_get_bKGD(png_ptr, info_ptr, @pBackground) <> 0 then
        begin
            { file specifies a background }

            if OverwriteFileBackground then
            begin
                pBackground := @Background;
                png_set_background( png_ptr, pBackground,
                                    PNG_BACKGROUND_GAMMA_SCREEN, 0, 1.0 );
            end
            else
                png_set_background( png_ptr, pBackground,
                                    PNG_BACKGROUND_GAMMA_FILE, 1, 1.0 );
        end
        else
        begin
            { file does not specify a backround }
            pBackground := @Background;
            png_set_background( png_ptr, pBackground,
                                PNG_BACKGROUND_GAMMA_SCREEN, 0, 1.0 );
        end;

        png_get_pHYs( png_ptr, info_ptr,
                      @res_x, @res_y, @unit_type );

        if unit_type = PNG_RESOLUTION_METER then
        begin
            res_x := Round(res_x * CMetersPerInch);
            res_y := Round(res_y * CMetersPerInch);
        end
        else
        begin
            res_x := 0;
            res_y := 0;
        end;

        { png_set_interlace_handling must be called before
          png_read_update_info }

        PassCount := 1; { prevent compiler warning }
        if InterlaceType = PNG_INTERLACE_NONE then
            PassCount := 1
        else if InterlaceType = PNG_INTERLACE_ADAM7 then
            PassCount := png_set_interlace_handling(png_ptr)
        else
            RaisePNGError('Interlace type not valid');

        png_read_update_info(png_ptr, info_ptr);

        if (ColorType and PNG_COLOR_MASK_PALETTE) <> 0 then
        begin
           if (png_get_PLTE( png_ptr, info_ptr, @ppngPalette, @ColorCount) = 0) then
               RaisePNGError('png_get_PLTE failed')
           else
           begin
               CopyPngPaletteToLogPalette(ppngPalette^, Palette, ColorCount);
               pPalette := @Palette;
           end;
        end;

        Self.NewImage( Width, Height, ImageFormat, pPalette, res_x, res_y );

        if Convert2BitTo4Bit then
            ReadConvert2To4Bit( png_ptr, info_ptr, Self, Width, Height,
                                (ImageFormat = ifGray16), LastPercent)
        else
            ReadUsingScanLines(png_ptr, Self, Height, PassCount, LastPercent);

    finally
        png_destroy_read_struct(@png_ptr, @info_ptr, nil);
    end;

    DoProgress( Self, FOnReadWriteProgress, 100, 0, 100, LastPercent );
end;

{--------------------------------------------------------------------------}

procedure TPngGraphic.SaveToStream(Stream: TStream);
var
    png_ptr            : png_structp;
    info_ptr           : png_infop;

    BitDepth           : Integer;
    InterlaceType      : Integer;
    ColorType          : Integer;

    PngPalette         : png_palette;

    Y                  : LongInt;
    PassNo             : Integer;
    PassCount          : Integer;

    PngColor           : png_color_16;

    TransparentPalette : array[0..255] of Byte;
    TransparentIndex   : Integer;
    Index              : Integer;

    LastPercent        : ShortInt;

    function GetColorType( const ImageFormat : TImageFormat ) : Integer;
    begin
        case ImageFormat of
            ifBlackWhite : Result := PNG_COLOR_TYPE_GRAY;
            ifGray16     : Result := PNG_COLOR_TYPE_GRAY;
            ifGray256    : Result := PNG_COLOR_TYPE_GRAY;
            ifColor16    : Result := PNG_COLOR_TYPE_PALETTE;
            ifColor256   : Result := PNG_COLOR_TYPE_PALETTE;
            ifTrueColor  : Result := PNG_COLOR_TYPE_RGB;
            else
                raise EEnvisionError.Create(msgInvalidImageFormat);
        end;
    end;

begin
    LastPercent := -1;
    LastPercent := DoProgress( Self, FOnReadWriteProgress, 0, 0, 100, LastPercent );

    png_ptr := png_create_write_struct( PChar(PNG_LIBPNG_VER_STRING), nil,
                                        png_error_proc, png_warn_proc );
    if png_ptr = nil then
        RaisePNGError('png_create_write_struct failed');

    info_ptr := png_create_info_struct(png_ptr);
    if png_ptr = nil then
    begin
        png_destroy_write_struct(@png_ptr, nil);
        RaisePNGError('png_create_info_struct failed');
    end;

    try
        png_set_write_fn(png_ptr, Pointer(Stream), png_write_proc, png_flush_proc);

        BitDepth := GetBitDepth(Self.ImageFormat);
        if BitDepth > 8 then
            BitDepth := 8;

        ColorType := GetColorType(Self.ImageFormat);

        if FSaveProgressive then
            InterlaceType := PNG_INTERLACE_ADAM7
        else
            InterlaceType := PNG_INTERLACE_NONE;

        png_set_IHDR( png_ptr, info_ptr, Self.Width, Self.Height,
                      BitDepth, ColorType,
                      InterlaceType,
                      PNG_COMPRESSION_TYPE_BASE,
                      PNG_FILTER_TYPE_BASE );


        if ColorType = PNG_COLOR_TYPE_PALETTE then
        begin
            CopyLogPaletteToPngPalette( PngPalette,
                                        Self.Palette );

            png_set_PLTE(png_ptr, info_ptr, @PngPalette, Self.Palette.palNumEntries);
        end;

        png_set_pHYs( png_ptr, info_ptr,
                      Round(Self.XDotsPerInch / CMetersPerInch),
                      Round(Self.YDotsPerInch / CMetersPerInch),
                      PNG_RESOLUTION_METER );

        png_set_gAMA(png_ptr, info_ptr, FImageGamma);

        if SaveWithBackground then
        begin
            FillChar(PngColor, SizeOf(PngColor), 0);
            if ImageFormat in [ifColor16, ifColor256] then
                PngColor.Index    := RgbToPaletteConverter.GetIndex(BackgroundColor)
            else if ImageFormat = ifTrueColor then
            begin
                PngColor.Red      := BackgroundColor.Red;
                PngColor.Green    := BackgroundColor.Green;
                PngColor.Blue     := BackgroundColor.Blue;
            end
            else if ImageFormat in [ifBlackWhite, ifGray16, ifGray256] then
                PngColor.Gray     := RgbToPaletteConverter.GetIndex(BackgroundColor);

            png_set_bKGD(png_ptr, info_ptr, @PngColor);
        end;

        if SaveTransparent then
        begin
            if ImageFormat = ifTrueColor then
            begin
                PngColor.Index    := 0;
                PngColor.Red      := TransparentColor.Red;
                PngColor.Green    := TransparentColor.Green;
                PngColor.Blue     := TransparentColor.Blue;
                PngColor.Gray     := 0;

                png_set_tRNS(png_ptr, info_ptr, nil, 1, @PngColor)
            end
            else if ImageFormat = ifColor16 then
            begin
                FillChar(TransparentPalette, SizeOf(TransparentPalette), 255);
                TransparentIndex := RgbToPaletteConverter.GetIndex(TransparentColor);
                for Index := 0 to 15 do
                begin
                    if Index = TransparentIndex then
                    begin
                        TransparentPalette[Index] := 0;
                        break;
                    end;
                end;

                png_set_tRNS(png_ptr, info_ptr, @TransparentPalette, 16, nil);
            end
            else if ImageFormat = ifColor256 then
            begin
                FillChar(TransparentPalette, SizeOf(TransparentPalette), 255);
                TransparentIndex := RgbToPaletteConverter.GetIndex(TransparentColor);
                for Index := 0 to 255 do
                begin
                    if Index = TransparentIndex then
                    begin
                        TransparentPalette[Index] := 0;
                        break;
                    end;
                end;

                png_set_tRNS(png_ptr, info_ptr, @TransparentPalette, 256, nil);
            end
            else if ImageFormat in [ifBlackWhite, ifGray16, ifGray256] then
            begin
                { MB Jan 08, 2000. There seems to be a problem with the LibPng
                  which does not load the background color properly when
                  reading a 16 shades of gray image. For this reason the
                  Envision library  will not save transparent gray scale
                  images. The simple workaround is to save the images as
                  16 or 256 colors with a palette containing only gray values.
                FillChar(PngColor, SizeOf(PngColor), 0);
                PngColor.Gray  := RgbToPaletteConverter.GetIndex(TransparentColor);

                png_set_tRNS(png_ptr, info_ptr, nil, 1, @PngColor)
                }
                raise EPngError.Create(msgGrayScaleTransparentPngNotSupported);
            end;

        end;

        case FCompressionLevel of
            pcLow    : png_set_compression_level(png_ptr, Z_BEST_SPEED);
            pcMedium : png_set_compression_level(png_ptr, Z_MEDIUM);
            pcHigh   : png_set_compression_level(png_ptr, Z_BEST_COMPRESSION);
        end;

        png_write_info(png_ptr, info_ptr);

        if ImageFormat = ifTrueColor then
            png_set_bgr(png_ptr);

        if InterlaceType = PNG_INTERLACE_ADAM7 then
            PassCount := png_set_interlace_handling(png_ptr)
        else
            PassCount := 1;

        for PassNo := 1 to PassCount do
        begin
            for Y := 0 to (Self.Height-1) do
            begin
                png_write_row(png_ptr, png_bytep(Self.ScanLine[Y]));

                LastPercent := DoProgress( Self, OnReadWriteProgress,
                                           Y + (Self.Height-1)*(PassNo-1), 0,
                                           (Self.Height-1)*PassCount, LastPercent );
            end;
        end;

        png_write_end(png_ptr, info_ptr);

    finally
        png_destroy_write_struct(@png_ptr, @info_ptr);
    end;

    DoProgress( Self, FOnReadWriteProgress, 100, 0, 100, LastPercent );
end;

{--------------------------------------------------------------------------}
type

TPngId = packed array[1..8] of Byte;

class function TPngGraphic.CanRead( const Stream : TStream ) : Boolean;
var
    Id : TPngId;
begin
    Stream.Read( Id, SizeOf(Id));
    Stream.Seek( -(SizeOf(Id)), soFromCurrent );

    Result := (Id[1] = $89) and
              (Id[2] = $50) and
              (Id[3] = $4E) and
              (Id[4] = $47) and
              (Id[5] = $0D) and
              (Id[6] = $0A) and
              (Id[7] = $1A) and
              (Id[8] = $0A);
end;

{--------------------------------------------------------------------------}

initialization

    IgnorePNGWarnings := True;

    {$ifdef __RegisterEnvisionPng}
    RegisterDibGraphic('PNG', 'Portable Network Graphic', TPngGraphic);
    {$endif}

finalization

end.

