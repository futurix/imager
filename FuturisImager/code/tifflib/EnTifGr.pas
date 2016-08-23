{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnTifGr
|
| Description: TDibGraphic descendant for TIFF files.
|              Supports the following compression (read and write):
|                  CCITT group 3 (1d and 2d)
|                  CCITT Group 4
|                  Packbits
|                  LZW (requires Unisys license, SetLZWLicense must be called.)
|                  JPEG
|                  ZLib (not part of the official TIFF spec, maybe it will be
|                        incorporated to bypass the patent on LZW)
|
| History: Nov 11, 1998 Michel Brazeau, first version
|          Jan   , 2000 MB add support for custom tif tags
|          Jan   , 2001 MB add support for commonly used tif tags:
|
|                       DocumentNameTag
|                       ImageDescriptionTag
|                       ScannerMakeTag
|                       ScannerModelTag
|                       PageNameTag
|                       SoftwareTag
|                       DateTimeTag
|                       ArtistTag
|                       HostComputerTag
|
|                       Thank you to Olivier Freiman for this addition.

|
|---------------------------------------------------------------------------}
unit EnTifGr;

{$I Envision.Inc}

interface

uses
    Windows,  { for TRect, ColorRef, PMaxLogPalette }
    SysUtils, { for Exception, PByteArray }
    Classes,  { for TStream }
    EnMisc,   { for TImageFormat, DateToDateStr, TimeToTimeStr }
    EnDiGrph; { for TDibGraphic }


type

ETiffError = class(Exception);

{ LZW not supported for legal reasons }
TTiffCompression = ( tcNone, tcPackbits, tcLZW,
                     tcGroup3_1d, tcGroup3_2d, tcGroup4,
                     tcZLib, tcJPEG );

TCustomTiffTag = class(TObject)
    Read  : Boolean;
    Write : Boolean;
    Value : String;
end;

TTiffGraphic = class(TDibGraphic)
protected
    FCompression           : TTiffCompression;

    FRowsPerStrip          : LongInt;

    FCustomTags            : TList;

    FDocumentNameTag       : AnsiString;
    FImageDescriptionTag   : AnsiString;
    FScannerMakeTag        : AnsiString;
    FScannerModelTag       : AnsiString;
    FPageNameTag           : AnsiString;
    FSoftwareTag           : AnsiString;
    FDateTimeTag           : AnsiString;
    FArtistTag             : AnsiString;
    FHostComputerTag       : AnsiString;

    FAnnotationTag         : AnsiString;

    FJpegQuality           : TJpegQuality;

    procedure CreateCustomTags;
    procedure DestroyCustomTags;

    function GetCustomTiffTag( const Index : Integer ) : TCustomTiffTag;

    procedure SetCompression(const InCompression : TTiffCompression);
    procedure SetRowsPerStrip(const InRowsPerStrip : LongInt );

    function GetAnnotationTag : AnsiString;
    procedure SetAnnotationTag( const Tag : AnsiString );

    class function CanRead( const Stream : TStream ) : Boolean; override;

public
    constructor Create; override;
    destructor Destroy; override;

    { MB Aug 30, 2000. Override Assign to copy the FRowsPerStrip property. }
    procedure Assign(Source: TPersistent); override;

    procedure NewImage( const Width          : LongInt;
                        const Height         : LongInt;
                        const ImageFormat    : TImageFormat;
                              pPalette       : PMaxLogPalette;
                        const InXDotsPerInch : Word;
                        const InYDotsPerInch : Word ); override;

    property Compression : TTiffCompression
                read FCompression
                write SetCompression;

    function GetImageCount( const Stream : TStream ) : LongInt; override;

    procedure SingleLoadFromStream( const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  ); override;

    procedure SaveToStream(Stream: TStream); override;

    procedure AppendToStream(Stream : TStream); override;

    { The number of rows stored with each "strip" in the tiff file. When
      loading an image, the value is read. When saving, the value is used. }
    property RowsPerStrip : LongInt read FRowsPerStrip
                                    write SetRowsPerStrip;

    { 1 <= Index <= 19 }
    property CustomTags[ const Index : Integer ] : TCustomTiffTag
                                             read GetCustomTiffTag;

    property DocumentNameTag       : AnsiString read FDocumentNameTag write FDocumentNameTag;
    property ImageDescriptionTag   : AnsiString read FImageDescriptionTag write FImageDescriptionTag;
    property ScannerMakeTag        : AnsiString read FScannerMakeTag write FScannerMakeTag;
    property ScannerModelTag       : AnsiString read FScannerModelTag write FScannerModelTag;
    property PageNameTag           : AnsiString read FPageNameTag write FPageNameTag;
    property SoftwareTag           : AnsiString read FSoftwareTag write FSoftwareTag;
    property DateTimeTag           : AnsiString read FDateTimeTag write FDateTimeTag;
    property ArtistTag             : AnsiString read FArtistTag write FArtistTag;
    property HostComputerTag       : AnsiString read FHostComputerTag write FHostComputerTag;

    { the format of the Annotation tag is specific to Envision }
    property AnnotationTag         : AnsiString read GetAnnotationTag write SetAnnotationTag;

    { MB Apr 08, 2003. Thanks to Alon Gingold }
    property JpegQuality           : TJpegQuality read FJpegQuality write FJpegQuality;

end;

function TiffCompressionStr( const Compression : TTiffCompression ) : String;

procedure RaiseTiffError( const Msg : String );

{$J+}

{ the first tag is reserved for Envision annotations }
const CCustomTagValues : array[0..19] of Word =
    ( 40000, 40001, 40002, 40003,
      40004, 40005, 40006, 40007,
      40008, 40009, 40010, 40011,
      40012, 40013, 40014, 40015,
      40016, 40017, 40018, 40019 );

const CAnnotationTag   = Low(CCustomTagValues);

const CMinCustomTag    = CAnnotationTag + 1;
const CMaxCustomTag    = High(CCustomTagValues);


{--------------------------------------------------------------------------}

implementation

uses
    EnCLib,   { for TTiffHandle, ... }
    EnMsg,    { for EEnvisionError }
    EnTransf, { for TNegativeTransform }
    Graphics; { for TPicture }

const

{ MB Aug 30, 2000, add CDefaultRowsPerStrip
  The official default is 2^32, but a sufficiently large value
  is fine.
  Thanks to a user called Marcel }
CDefaultRowsPerStrip = MaxInt;

{--------------------------------------------------------------------------}

procedure RaiseTiffError( const Msg : String );
begin
    raise ETiffError.Create( ETiffError.ClassName + ' ' + Msg );
end;

{--------------------------------------------------------------------------}

function CheckColorMap( const Count         : Integer;
                        var   RedColorMap   : TWordArray;
                        var   GreenColorMap : TWordArray;
                        var   BlueColorMap  : TWordArray ) : LongInt;
var
    Index : Integer;
begin
    for Index := 0 to (Count-1) do
    begin
        if (RedColorMap[Index] >= 256) or
           (GreenColorMap[Index] >= 256) or
           (BlueColorMap[Index] >= 256) then
        begin
            Result := 16;
            Exit;
        end;
    end;

    Result := 8; { assume 8 bit color map }
end;

{--------------------------------------------------------------------------}

function Cvt( Value : Word ) : Byte;
begin
    { As reported by tomaz@neosys.si, Tomaz Koritnik, multiple by 255, not
      256 }
    Result := (((Value) * LongInt(255)) div ((1 shl 16)-1));
end;

{--------------------------------------------------------------------------}

{$WARNINGS OFF}

function GetTiffPalette( const TiffHandle : TTiffHandle;
                         var   Palette    : TMaxLogPalette ) : Boolean;
var
    BitsPerSample              : Word;
    PhotometricInterpretation  : SmallInt;
    pRedColorMap               : TpWordArray;
    pGreenColorMap             : TpWordArray;
    pBlueColorMap              : TpWordArray;
    Palette16Bits              : Boolean;
    PaletteIndex               : Integer;

begin
    Result := False;
    FillChar(Palette, SizeOf(Palette), 0);

    TIFFGetField(TiffHandle, TIFFTAG_PHOTOMETRIC, PhotometricInterpretation);
    TIFFGetField(TiffHandle, TIFFTAG_BITSPERSAMPLE, BitsPerSample);

    if (PhotometricInterpretation <> 3) then
        Exit;

    Palette.palNumEntries := (1 shl BitsPerSample);
    Palette.palVersion    := $0300;

    TIFFGetField3( TiffHandle, TIFFTAG_COLORMAP,
                   pRedColorMap, pGreenColorMap, pBlueColorMap);

    { Is the palette 16 or 8 bits ? }
    if (CheckColorMap( Palette.palNumEntries,
                       pRedColorMap^, pGreenColorMap^, pBlueColorMap^) = 16) then
        Palette16Bits := True
    else
        Palette16Bits := False;

    { load the palette in the pixel graphic }
    for PaletteIndex := (Palette.palNumEntries-1) downto 0 do
    begin
        { a tiff palette has the red and blue entries reversed compared to
          a windows palette }
        if Palette16Bits then
        begin
            Palette.palPalEntry[PaletteIndex].peBlue :=
                                 Cvt(pBlueColorMap^[PaletteIndex]);
            Palette.palPalEntry[PaletteIndex].peGreen :=
                                 Cvt(pGreenColorMap^[PaletteIndex]);
            Palette.palPalEntry[PaletteIndex].peRed :=
                                 Cvt(pRedColorMap^[PaletteIndex]);
        end
        else
        begin
            Palette.palPalEntry[PaletteIndex].peBlue :=
                                 Byte(pBlueColorMap^[PaletteIndex]);
            Palette.palPalEntry[PaletteIndex].peGreen :=
                                 Byte(pGreenColorMap^[PaletteIndex]);
            Palette.palPalEntry[PaletteIndex].peRed :=
                                 Byte(pRedColorMap^[PaletteIndex]);
        end;
    end;

    Result := True;
end;

{--------------------------------------------------------------------------}

procedure SetTiffPalette( const TiffHandle : TTiffHandle;
                          const Palette    : TMaxLogPalette );
var
    pRedColorMap               : TpWordArray;
    pGreenColorMap             : TpWordArray;
    pBlueColorMap              : TpWordArray;
    PaletteIndex               : Integer;

    PaletteSize                : Word;

begin
    if Palette.palNumEntries <= 16 then
        PaletteSize := 16
    else
        PaletteSize := 256;

    GetMem( pRedColorMap, SizeOf(Word)*PaletteSize);
    GetMem( pGreenColorMap, SizeOf(Word)*PaletteSize);
    GetMem( pBlueColorMap, SizeOf(Word)*PaletteSize);
    try
        FillChar( pRedColorMap^, SizeOf(Word)*PaletteSize, 0);
        FillChar( pGreenColorMap^, SizeOf(Word)*PaletteSize, 0);
        FillChar( pBlueColorMap^, SizeOf(Word)*PaletteSize, 0);

        { load the palette in the pixel graphic }
        for PaletteIndex := (Palette.palNumEntries-1) downto 0 do
        begin
            { a 16 bit palette is more common for TIFF, so multiple each entry
              by 255.

              MB Jan 13, 2002. Each entry is multiplied by 256 not 255, and I don't quite
              remember the reason.  }
            pBlueColorMap^[PaletteIndex]  := Palette.palPalEntry[PaletteIndex].peBlue*256;
            pGreenColorMap^[PaletteIndex] := Palette.palPalEntry[PaletteIndex].peGreen*256;
            pRedColorMap^[PaletteIndex]   := Palette.palPalEntry[PaletteIndex].peRed*256;
        end;

        TIFFSetColorMap( TiffHandle,
                         pRedColorMap, pGreenColorMap, pBlueColorMap);
    finally
        FreeMem( pRedColorMap, SizeOf(Word)*PaletteSize);
        FreeMem( pGreenColorMap, SizeOf(Word)*PaletteSize);
        FreeMem( pBlueColorMap, SizeOf(Word)*PaletteSize);
    end;

end;

{--------------------------------------------------------------------------}

{ read a PChar tag from a tiff file. If the tag is not present, '' is
  returned }
function ReadPCharTag( const TiffHandle   : TTiffHandle;
                       const Tag          : Word ) : AnsiString;
var
    pZString : PChar;
begin
    if TIFFGetField(TiffHandle, Tag, pZString) then
        Result := pZString
    else
        Result := '';
end;

{--------------------------------------------------------------------------}

(*

MB Dec 01, 1998 Not used anymore. Inverted palettes such as some TIFF
black&white and gray palettes, are handled by reversing the bit values
themselves.
procedure ReversePalette( var   Palette    : TMaxLogPalette );
var
    Index    : Integer;
    NewIndex : Integer;
    TempR,
    TempG,
    TempB : Byte;

begin
    for Index := 0 to ((Palette.palNumEntries div 2)-1) do
    begin
        NewIndex := Palette.palNumEntries-Index-1;

        TempR := Palette.palPalEntry[Index].peRed;
        TempG := Palette.palPalEntry[Index].peGreen;
        TempB := Palette.palPalEntry[Index].peBlue;

        Palette.palPalEntry[Index].peRed :=
                             Palette.palPalEntry[NewIndex].peRed;
        Palette.palPalEntry[Index].peGreen :=
                             Palette.palPalEntry[NewIndex].peGreen;
        Palette.palPalEntry[Index].peBlue :=
                             Palette.palPalEntry[NewIndex].peBlue;

        Palette.palPalEntry[NewIndex].peRed   := TempR;
        Palette.palPalEntry[NewIndex].peGreen := TempG;
        Palette.palPalEntry[NewIndex].peBlue  := TempB;
    end;
end;
*)

{--------------------------------------------------------------------------}

function IsCCITTCompressed( const TiffHandle  : TTiffHandle;
                            const CompressTag : Word ) : Boolean;
begin
    Result := (CompressTag = COMPRESSION_CCITTFAX3) or
	      (CompressTag = COMPRESSION_CCITTFAX4) or
	      (CompressTag = COMPRESSION_CCITTRLE) or
	      (CompressTag = COMPRESSION_CCITTRLEW);
end;

{--------------------------------------------------------------------------}

function TiffCompressionStr( const Compression : TTiffCompression ) : String;
begin
    Result := '';
    case Compression of
        tcNone       : Result := 'None';
        tcPackbits   : Result := 'Packbits';
        tcLZW        : Result := 'LZW';
        tcGroup3_1d  : Result := 'CCITT Group 3, 1D';
        tcGroup3_2d  : Result := 'CCITT Group 3, 2D';
        tcGroup4     : Result := 'CCITT Group 4';
        tcZLib       : Result := 'ZLib';
        tcJPEG       : Result := 'JPEG';
    end;
end;

{--------------------------------------------------------------------------}

procedure RaiseCompressionNotSupported( const ImageFormat : TImageFormat;
                                        const Compression : TTiffCompression );
begin
    raise EEnvisionError.Create(
              Format( msgTiffCompressionNotSupported,
                      [ TiffCompressionStr(Compression),
                        ImageFormatStr(ImageFormat)]));
end;

{--------------------------------------------------------------------------}

procedure ReadUsingScanLines( const TiffHandle     : TTiffHandle;
                              const Dib            : TDibGraphic;
                              const ImageLength    : LongInt;
                              const ScanLineSize   : LongInt;
                              var   LastPercent    : ShortInt );
var
    pScanLine    : PByteArray;
    DibScanLine  : PByteArray;
    Row          : LongInt;

begin
    GetMem(pScanLine, ScanLineSize);
    try
        for Row := 0 to (ImageLength-1) do
        begin
            LastPercent := DoProgress( Dib, Dib.OnReadWriteProgress, Row, 0, ImageLength-1, LastPercent );

            { MB May 17, 1999. Don't check for return code. Some rare images
              seem to have one or a few corrupted scan lines but the are
              still readable.
            if TIFFReadScanline(TiffHandle, pScanLine, Row) = -1 then
                RaiseTiffError('TIFFReadScanLine');
            }
            TIFFReadScanline(TiffHandle, pScanLine, Row);

            DibScanLine := Dib.ScanLine[Row];

            Move( pScanLine^, DibScanLine^[0], ScanLineSize);
        end;
    finally
        FreeMem(pScanLine, ScanLineSize);
    end;
end;

{--------------------------------------------------------------------------}

{ MB Apr 4,5, 2002 }
procedure ReadPalette16Bits( const TiffHandle     : TTiffHandle;
                          const Dib            : TDibGraphic;
                          const ImageLength    : LongInt;
                          const ScanLineSize   : LongInt;
                          var   LastPercent    : ShortInt );
var
    pScanLine    : PByteArray;
    Row          : LongInt;
    X            : LongInt;
    pWordValue   : ^Word;

begin
    GetMem(pScanLine, ScanLineSize);
    try
        for Row := 0 to (ImageLength-1) do
        begin
            LastPercent := DoProgress( Dib, Dib.OnReadWriteProgress, Row, 0, ImageLength-1, LastPercent );

            { MB May 17, 1999. Don't check for return code. Some rare images
              seem to have one or a few corrupted scan lines but the are
              still readable.
            if TIFFReadScanline(TiffHandle, pScanLine, Row) = -1 then
                RaiseTiffError('TIFFReadScanLine');
            }
            TIFFReadScanline(TiffHandle, pScanLine, Row);

            for X := 0 to (Dib.Width-1) do
            begin
                pWordValue := @pScanLine^[X*2];
                Dib.PaletteIndex[X, Row] := pWordValue^ div 256;
            end;
        end;
    finally
        FreeMem(pScanLine, ScanLineSize);
    end;
end;

{--------------------------------------------------------------------------}

procedure ReadUsingRGBAImage( const TiffHandle     : TTiffHandle;
                              const Dib            : TDibGraphic;
                              const ImageWidth     : LongInt;
                              const ImageLength    : LongInt );
var
    Stream       : TMemoryStream;
    X            : LongInt;
    Y            : LongInt;
    RGB          : TRgb;
    TempByte     : Byte;

begin

    Stream := TMemoryStream.Create;
    try
        DoProgress( Dib, Dib.OnReadWriteProgress, 5, 0, 100, -1 );

        Stream.SetSize(ImageWidth * ImageLength * 4);

        DoProgress( Dib, Dib.OnReadWriteProgress, 10, 0, 100, -1 );

        if TIFFReadRGBAImage( TiffHandle, ImageWidth, ImageLength,
                              Stream.Memory, 1) <> 0 then
        begin
            DoProgress( Dib, Dib.OnReadWriteProgress, 80, 0, 100, -1 );

            for Y := (ImageLength-1) downto 0 do
            begin
                for X := 0 to (ImageWidth-1) do
                begin
                    Stream.Read(Rgb, SizeOf(Rgb));

                    TempByte := Rgb.Red;
                    Rgb.Red  := Rgb.Blue;
                    Rgb.Blue := TempByte;

                    Dib.RGB[X, Y] := Rgb;
                end;
            end;

            DoProgress( Dib, Dib.OnReadWriteProgress, 90, 0, 100, -1 );

        end;

    finally
        Stream.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure ReadUsingStrips( const TiffHandle     : TTiffHandle;
                           const Dib            : TDibGraphic;
                           const ImageWidth     : LongInt;
                           const ImageLength    : LongInt;
                           const SamplePerPixel : LongInt;
                           const ScanLineSize   : LongInt;
                           const RowsPerStrip   : LongInt;
                           var   LastPercent    : ShortInt );
var
    pStrip                     : PByteArray;
    StripSize                  : LongInt;
    RowCount                   : LongInt;
    RowIndex                   : LongInt;
    Y                          : LongInt;
    X                          : LongInt;
    DibScanLine                : PByteArray;
    Rgb                        : TRgb;

begin
    StripSize := TIFFStripSize(TiffHandle);

    GetMem(pStrip, StripSize);
    try
        { read the tiff lines and save them in the pixel graphic
          with RGB mode, we have to change the order of the 3 samples RGB <=> BGR }
        RowIndex := 0;
        while RowIndex < ImageLength do
        begin
            LastPercent := DoProgress( Dib, Dib.OnReadWriteProgress, RowIndex, 0, ImageLength, LastPercent );

            if (RowIndex + RowsPerStrip) > ImageLength then
                RowCount := ImageLength - RowIndex
            else
                RowCount := RowsPerStrip;

            (*
            if TIFFReadEncodedStrip( TiffHandle,
                                     TIFFComputeStrip(TiffHandle, RowIndex, 0),
                                     pStrip, RowCount*ScanLineSize) = -1 then
                RaiseTiffError('TIFFReadEncodedStrip')
            else                                                    ??
            *)
            { MB Jun 11, 2003 On some files, TiffReadEncodedStrip can return
              an error, which is probably a warning, because the file continues
              to load propery }
            TIFFReadEncodedStrip( TiffHandle,
                                     TIFFComputeStrip(TiffHandle, RowIndex, 0),
                                     pStrip, RowCount*ScanLineSize);
            begin
                for Y := 0 to (RowCount-1) do
                begin
                    if (SamplePerPixel = 3) or
                       (SamplePerPixel = 4) then
                    begin
                        { RGB }
                        for X := 0 to (ImageWidth-1) do
                        begin
                            { MB Dec 20, 1998. A range check error for some
                              reason occurs with range checking on. }
                            {$ifopt R+}
                                {$R-}
                            {$endif}
                            Rgb.Blue  := pStrip^[Y*ScanLineSize+X*SamplePerPixel+2];
                            Rgb.Green := pStrip^[Y*ScanLineSize+X*SamplePerPixel+1];
                            Rgb.Red   := pStrip^[Y*ScanLineSize+X*SamplePerPixel+0];
                            Dib.RGB[X, (Y+RowIndex)] := Rgb;
                        end
                    end
                    else
                    begin
                        { palette based }
                        DibScanLine := Dib.ScanLine[Y+RowIndex];
                        Move( pStrip^[Y*ScanLineSize], DibScanLine^[0], ScanLineSize);
                    end;
                end;
            end;

            RowIndex := RowIndex + RowsPerStrip;
        end;
    finally
        FreeMem(pStrip, StripSize);
    end;
end;

{--------------------------------------------------------------------------}

procedure ReadTags( const TiffHandle  : TTiffHandle;
                    const TiffGraphic : TTiffGraphic );
var
    Index     : Integer;
    Tag       : TCustomTiffTag;
begin
    for Index := Low(CCustomTagValues) to High(CCustomTagValues) do
    begin
        Tag := TCustomTiffTag(TiffGraphic.FCustomTags[Index]);

        if Tag.Read then
            Tag.Value := ReadPCharTag( TiffHandle, CCustomTagValues[Index] )
        else
            Tag.Value := '';
    end;

    { MB Jan 31, 2001. Handle common tags }
    TiffGraphic.FDocumentNameTag       := ReadPCharTag( TiffHandle, TIFFTAG_DOCUMENTNAME );
    TiffGraphic.FImageDescriptionTag   := ReadPCharTag( TiffHandle, TIFFTAG_IMAGEDESCRIPTION );
    TiffGraphic.FScannerMakeTag        := ReadPCharTag( TiffHandle, TIFFTAG_MAKE );
    TiffGraphic.FScannerModelTag       := ReadPCharTag( TiffHandle, TIFFTAG_MODEL );
    TiffGraphic.FPageNameTag           := ReadPCharTag( TiffHandle, TIFFTAG_PAGENAME );
    TiffGraphic.FSoftwareTag           := ReadPCharTag( TiffHandle, TIFFTAG_SOFTWARE );
    TiffGraphic.FDateTimeTag           := ReadPCharTag( TiffHandle, TIFFTAG_DATETIME );
    TiffGraphic.FArtistTag             := ReadPCharTag( TiffHandle, TIFFTAG_ARTIST );
    TiffGraphic.FHostComputerTag       := ReadPCharTag( TiffHandle, TIFFTAG_HOSTCOMPUTER );
end;

{--------------------------------------------------------------------------}

procedure WriteTags( const TiffHandle  : TTiffHandle;
                     const TiffGraphic : TTiffGraphic );
var
    Index     : Integer;
    Tag       : TCustomTiffTag;
begin
    for Index := Low(CCustomTagValues) to High(CCustomTagValues) do
    begin
        Tag := TCustomTiffTag(TiffGraphic.FCustomTags[Index]);

        if Tag.Write then
        begin
            TIFFSetPCharField( TiffHandle, CCustomTagValues[Index], PChar(Tag.Value));
        end;
    end;

    { MB Jan 31, 2001. Handle common tags }

    if TiffGraphic.FDocumentNameTag <> '' then
        TIFFSetPCharField( TiffHandle, TIFFTAG_DOCUMENTNAME, PChar(TiffGraphic.FDocumentNameTag));

    if TiffGraphic.FImageDescriptionTag <> '' then
        TIFFSetPCharField( TiffHandle, TIFFTAG_IMAGEDESCRIPTION, PChar(TiffGraphic.FImageDescriptionTag));

    if TiffGraphic.FScannerMakeTag <> '' then
        TIFFSetPCharField( TiffHandle, TIFFTAG_MAKE, PChar(TiffGraphic.FScannerMakeTag));

    if TiffGraphic.FScannerModelTag <> '' then
        TIFFSetPCharField( TiffHandle, TIFFTAG_MODEL, PChar(TiffGraphic.FScannerModelTag));

    if TiffGraphic.FPageNameTag <> '' then
        TIFFSetPCharField( TiffHandle, TIFFTAG_PAGENAME, PChar(TiffGraphic.FPageNameTag));

    if TiffGraphic.FSoftwareTag <> '' then
        TIFFSetPCharField( TiffHandle, TIFFTAG_SOFTWARE, PChar(TiffGraphic.FSoftwareTag));

    if TiffGraphic.FDateTimeTag <> '' then
        TIFFSetPCharField( TiffHandle, TIFFTAG_DATETIME, PChar(TiffGraphic.FDateTimeTag));

    if TiffGraphic.FArtistTag <> '' then
        TIFFSetPCharField( TiffHandle, TIFFTAG_ARTIST, PChar(TiffGraphic.FArtistTag));

    if TiffGraphic.FHostComputerTag <> '' then
        TIFFSetPCharField( TiffHandle, TIFFTAG_HOSTCOMPUTER, PChar(TiffGraphic.FHostComputerTag));
end;

{--------------------------------------------------------------------------}

procedure ReadDibFromTiffStream( const Dib          : TTiffGraphic;
                                 const Stream       : TStream;
                                 const ImageToLoad  : LongInt;
                                 var   RowsPerStrip : LongInt;
                                 var   LastPercent  : ShortInt );
var
    TiffHandle                 : TTiffHandle;
    ImageLength                : LongInt;
    ImageWidth                 : LongInt;
    BitsPerSample              : Word;
    SamplePerPixel             : LongInt;
    ScanLineSize               : LongInt;
    PhotometricInterpretation  : Word;
    PlanarConfig               : Word;
    CompressTag                : Word;
    CCITTCompressed            : Boolean;
    UseReadRGBAImage           : Boolean;
    Palette                    : TMaxLogPalette;
    BitCount                   : Integer;
    ImageFormat                : TImageFormat;
    Group3Options              : LongInt;
    ResolutionUnit             : Word;
    XResolution                : Single;
    YResolution                : Single;
    Inverted                   : Boolean;
    NegativeTransform          : TNegativeTransform;
    XDpi                       : Word;
    YDpi                       : Word;
    Palette16Bits              : Boolean;

begin
    { MB Mar 08, 1999. Do NOT seek to the beginning of the stream,
      as this prevents the image from being loaded at design time
      in a TImage component. }

    TiffHandle := TIFFOpen(Stream, omRead);
    if TiffHandle = nil then
        RaiseTiffError('TIFFOpen');

    try
        TIFFSetDirectory(TiffHandle, ImageToLoad-1);

        TIFFGetField(TiffHandle, TIFFTAG_IMAGEWIDTH, ImageWidth);
        TIFFGetField(TiffHandle, TIFFTAG_IMAGELENGTH, ImageLength);

        { MB May 18, 1999. Some CCITT compressed files do not have
          the photometric interpretation tag, so a default is used if the
          tag is not present. }
        if not TIFFGetField(TiffHandle, TIFFTAG_PHOTOMETRIC, PhotometricInterpretation) then
            PhotometricInterpretation := 0;

        TIFFGetField(TiffHandle, TIFFTAG_COMPRESSION, CompressTag);

        CCITTCompressed := IsCCITTCompressed(TiffHandle, CompressTag);

        { MB May 18, 1999. Some CCITT compressed files do not have the
          bits per sample tag. }
        if not TIFFGetField(TiffHandle, TIFFTAG_BITSPERSAMPLE, BitsPerSample) then
        begin
            if CCITTCompressed then
                BitsPerSample := 1
            else
                RaiseTiffError('Bits per sample not specified');
        end;

        TIFFGetField(TiffHandle, TIFFTAG_PLANARCONFIG, PlanarConfig);

        if not TIFFGetField(TiffHandle, TIFFTAG_RESOLUTIONUNIT, ResolutionUnit) then
            { an exception is raised for files that don't specify the
              resolution: the TIFF spec default is used in that case }
            ResolutionUnit := RESUNIT_INCH;

        { MB May 30, 2002. As reported by Chris Boesch, some files have
          RESUNIT_NONE as resolution unit. In that case, don't assume
          centimeter resolution. }

        if TIFFGetField(TiffHandle, TIFFTAG_XRESOLUTION, XResolution) then
        begin
            if (ResolutionUnit = RESUNIT_INCH) or (ResolutionUnit = RESUNIT_NONE) then
                XDpi := Round(XResolution)
            else
                XDpi := Round(XResolution * CCentimetersPerInch);
        end
        else
            XDpi := 0;

        if TIFFGetField(TiffHandle, TIFFTAG_YRESOLUTION, YResolution) then
        begin
            if (ResolutionUnit = RESUNIT_INCH) or (ResolutionUnit = RESUNIT_NONE) then
                YDpi := Round(YResolution)
            else
                YDpi := Round(YResolution * CCentimetersPerInch);
        end
        else
            YDpi := 0;

//        if (CompressTag = COMPRESSION_LZW) then
//            RaiseLZWCompressionNotSupported;

        ScanLineSize := TIFFScanlineSize(TiffHandle);

        SamplePerPixel := Round((ScanLineSize*1.0)/ImageWidth);
        if SamplePerPixel <= 0 then
            SamplePerPixel := 1;

        BitCount := (BitsPerSample*SamplePerPixel);

        { move after computer bit count, to check 16 bit images }
        UseReadRGBAImage := (CompressTag = COMPRESSION_JPEG) or
                            (TIFFIsTiled(TiffHandle) <> 0) or
                            (PhotometricInterpretation in [5,6]) or
                            (BitsPerSample > 8) or
                            (PlanarConfig > 1) or
                            (not (BitCount in [1, 4, 8, 24]));

        ImageFormat := ifTrueColor;

        Inverted    := False;

        if (PhotometricInterpretation = 1) and CCITTCompressed then
            PhotometricInterpretation := 0;

        if (BitsPerSample = 1) and
           (PhotometricInterpretation = 1)then
        begin
            SetBWPalette(Palette);
            ImageFormat := ifBlackWhite;
        end;

        if (BitsPerSample = 1) and
           (PhotometricInterpretation = 0) then
        begin
            SetBWPalette(Palette);
            Inverted := True;
            ImageFormat := ifBlackWhite;
        end;

        if (BitsPerSample = 4) and
           (PhotometricInterpretation = 1) then
        begin
            SetGray16Palette(Palette);
            ImageFormat := ifGray16;
        end;

        if (BitsPerSample = 4) and
           (PhotometricInterpretation = 0) then
        begin
            SetGray16Palette(Palette);
            Inverted := True;
            ImageFormat := ifGray16;
        end;

        if (BitsPerSample = 8) and
           (PhotometricInterpretation = 1) then
        begin
            SetGray256Palette(Palette);
            ImageFormat := ifGray256;
        end;

        if (BitsPerSample = 8) and
           (PhotometricInterpretation = 0) then
        begin
            SetGray256Palette(Palette);
            { MB Dec 03, 1998. I'm not quite sure why, but don't invert
              if the image is read with ReadRGBAImage }
            Inverted    := not UseReadRGBAImage;
            ImageFormat := ifGray256;
        end;

        Palette16Bits := False;

        { PhotometricInterpretation = 0,1 B/W or gray scale palette
          PhotometricInterpretation = 2 image is RGB
          PhotometricInterpretation = 3 image have a color palette }
        if (PhotometricInterpretation = 3) then
        begin
            GetTiffPalette(TiffHandle, Palette);
            if BitsPerSample > 4 then
                ImageFormat := ifColor256
            else
                ImageFormat := ifColor16;

            Palette16Bits := (BitCount = 16);
        end;

        { MB Apr 4, 2002 }
        if (BitsPerSample = 16) and
           (PhotometricInterpretation in [0,1]) then
        begin
            { 16 bit gray not handled by ReadRGBAImage }
            SetGray256Palette(Palette);
            ImageFormat := ifGray256;
            if (PhotometricInterpretation = 0) then
                 Inverted := True;
            Palette16Bits := True;
        end;


        if (PhotometricInterpretation = 0) and
           (CompressTag = COMPRESSION_JPEG) then
            Inverted := True;

        Dib.NewImage( ImageWidth, ImageLength,
                      ImageFormat, @Palette,
                      XDpi, YDpi );

        ReadTags(TiffHandle, Dib);

        { set the compression after Dib.NewImage to override the defaults }
        case CompressTag of
            COMPRESSION_NONE      : Dib.Compression := tcNone;
            COMPRESSION_CCITTRLEW,
            COMPRESSION_CCITTRLE  : Dib.Compression := tcGroup3_1d;
            COMPRESSION_CCITTFAX3 :
            begin
                if TIFFGetField(TiffHandle, TIFFTAG_GROUP3OPTIONS, Group3Options) then
                begin
                    if (Group3Options and GROUP3OPT_2DENCODING) <> 0 then
                        Dib.Compression := tcGroup3_2d
                    else
                        Dib.Compression := tcGroup3_1d;
                end
                else
                    { MB. Sep 11, 2000. Some fax 3 images don't specify 1d or 2d, so
                      a default of 1d is used. I'm not sure if this is valid
                      according to the tiff specification }
                    Dib.Compression := tcGroup3_1d;

            end;
            COMPRESSION_LZW       : Dib.Compression := tcLZW;
            COMPRESSION_CCITTFAX4 : Dib.Compression := tcGroup4;
            COMPRESSION_PACKBITS  : Dib.Compression := tcPackbits;
            COMPRESSION_DEFLATE	  : Dib.Compression := tcZLib;
            COMPRESSION_JPEG      : Dib.Compression := tcJPEG;

            else
                RaiseTiffError(
                            Format(msgUnsupportedCompressionTag, [CompressTag]));

        end; { case }

        if TIFFGetField(TiffHandle, TIFFTAG_ROWSPERSTRIP, RowsPerStrip) then
        begin
            { MB Feb 04, 2002. Some tiff files specify a RowsPerStrip of -1.
              With the file, ..\support\Piotr Wypych\9S34W1516s.tiff, using
              ImageLength strip seems to work. }
            if RowsPerStrip = -1 then
                RowsPerStrip := ImageLength;
        end
        else
            Dib.FRowsPerStrip := CDefaultRowsPerStrip;

        if Palette16Bits then
            ReadPalette16Bits(TiffHandle, Dib, ImageLength, ScanLineSize, LastPercent)
        else if CCITTCompressed then
            ReadUsingScanLines(TiffHandle, Dib, ImageLength, ScanLineSize, LastPercent)
        else if UseReadRGBAImage then
            { these images are hard to handle, ie, YCbCr, CMYK color models,
              so ReadUsingRGBAImage is used at the expense of using a bit more
              memory. }
            ReadUsingRGBAImage(TiffHandle, Dib, ImageWidth, ImageLength )
        else
        begin
            ReadUsingStrips( TiffHandle, Dib,
                             ImageWidth, ImageLength,
                             SamplePerPixel, ScanLineSize, RowsPerStrip, LastPercent );
        end;

        if Inverted then
        begin
            NegativeTransform := TNegativeTransform.Create;
            try
                NegativeTransform.Apply(Dib);
            finally
                NegativeTransform.Free;
            end;
        end;

    finally
        TIFFClose(TiffHandle);
    end;
end;

{$WARNINGS ON}

{--------------------------------------------------------------------------}

constructor TTiffGraphic.Create;
begin
    inherited Create;

    { MB Aug 30, 2000. Ensure a default value for FRowPerStrip is set in the
      event that the tiff graphic is not loaded from a file. }
    FRowsPerStrip := CDefaultRowsPerStrip;

    CreateCustomTags;

    { always read/write the annotation tag }
    {$Warnings Off}
    TCustomTiffTag(FCustomTags[CAnnotationTag]).Write := True;
    TCustomTiffTag(FCustomTags[CAnnotationTag]).Read := True;
    {$Warnings On}
end;

{--------------------------------------------------------------------------}

destructor TTiffGraphic.Destroy;
begin
    DestroyCustomTags;

    inherited Destroy;
end;

{--------------------------------------------------------------------------}

procedure TTiffGraphic.CreateCustomTags;
var
    Index : Integer;
begin
    FCustomTags := TList.Create;

    for Index := Low(CCustomTagValues) to High(CCustomTagValues) do
        FCustomTags.Add(TCustomTiffTag.Create);
end;

{--------------------------------------------------------------------------}

procedure TTiffGraphic.DestroyCustomTags;
var
    Index : Integer;
begin
    {$WARNINGS OFF}
    for Index := Low(CCustomTagValues) to High(CCustomTagValues) do
        TCustomTiffTag(FCustomTags[Index]).Free;
    {$WARNINGS ON}
    FCustomTags.Free;
    FCustomTags := nil;
end;

{--------------------------------------------------------------------------}

procedure TTiffGraphic.Assign(Source: TPersistent);
begin
    inherited Assign(Source);

    if Source is TTiffGraphic then
        Self.FRowsPerStrip := TTiffGraphic(Source).FRowsPerStrip;
end;

{--------------------------------------------------------------------------}

procedure TTiffGraphic.NewImage( const Width          : LongInt;
                                 const Height         : LongInt;
                                 const ImageFormat    : TImageFormat;
                                       pPalette       : PMaxLogPalette;
                                 const InXDotsPerInch : Word;
                                 const InYDotsPerInch : Word
                                );
begin
    inherited NewImage( Width, Height, ImageFormat, pPalette,
                        InXDotsPerInch, InYDotsPerInch );

    case ImageFormat of
        ifBlackWhite : Self.Compression := tcGroup4;
        ifGray16,
        ifGray256,
        ifColor16,
        ifColor256,
        ifTrueColor  : Self.Compression := tcPackbits;
    end;
end;

{--------------------------------------------------------------------------}
{$WARNINGS OFF}
function TTiffGraphic.GetImageCount( const Stream : TStream ) : LongInt;
var
    TiffHandle : TTiffHandle;
begin
    TiffHandle := TIFFOpen(Stream, omRead);
    if TiffHandle = nil then
        RaiseTiffError('TIFFOpen');
    try
        Result := TiffImageCount(TiffHandle);
    finally
        TiffClose(TiffHandle);
    end;
end;
{$WARNINGS ON}

{--------------------------------------------------------------------------}

procedure TTiffGraphic.SetRowsPerStrip( const InRowsPerStrip : LongInt );
begin
    { MB Jun 20, 2000. The upper bound is choosen arbitrarily. I have seen a file
      with 2200 rows per strip }
    FRowsPerStrip := BoundInteger(InRowsPerStrip, 1, 4096);
end;

{--------------------------------------------------------------------------}

procedure TTiffGraphic.SetCompression( const InCompression : TTiffCompression );
begin
    case ImageFormat of

        ifBlackWhite :
        begin
            if not (InCompression in [ tcNone, tcPackbits, tcZLib, tcLZW,
                                     tcGroup3_1d, tcGroup3_2d,
                                     tcGroup4 ]) then
                RaiseCompressionNotSupported(ImageFormat, InCompression);
        end;

        ifGray16,
        ifColor16,
        ifColor256 :
        begin
            if not (InCompression in [ tcNone, tcPackbits, tcLZW,
                                     tcZlib ]) then
                RaiseCompressionNotSupported(ImageFormat, InCompression);
        end;

        ifGray256:
        begin
            if not (InCompression in [ tcNone, tcPackbits, tcLZW,
                                     tcZlib, tcJPEG ]) then
                RaiseCompressionNotSupported(ImageFormat, InCompression);
        end;

        ifTrueColor :
        begin
            if not (InCompression in [ tcNone, tcPackbits, tcLZW,
                                     tcZlib, tcJPEG ]) then
                RaiseCompressionNotSupported(ImageFormat, InCompression);
        end;
    end;

    FCompression := InCompression;

end;

{--------------------------------------------------------------------------}

function TTiffGraphic.GetAnnotationTag : AnsiString;
begin
    {$Warnings Off}
    Result := TCustomTiffTag(FCustomTags[CAnnotationTag]).Value;
    {$Warnings On}
end;

{--------------------------------------------------------------------------}

procedure TTiffGraphic.SetAnnotationTag( const Tag : AnsiString );
begin
    {$Warnings Off}
    TCustomTiffTag(FCustomTags[CAnnotationTag]).Value := Tag;
    {$Warnings On}
end;

{--------------------------------------------------------------------------}

function TTiffGraphic.GetCustomTiffTag( const Index : Integer ) : TCustomTiffTag;
begin
    if (Index >= CMinCustomTag) and (Index <= CMaxCustomTag) then
    begin
        {$WARNINGS OFF}
        Result := TCustomTiffTag(FCustomTags[Index]);
        {$WARNINGS ON}
    end
    else
        Result := nil;
end;

{--------------------------------------------------------------------------}

procedure TTiffGraphic.SingleLoadFromStream(
                                      const Stream      : TStream;
                                      const ImageToLoad : LongInt
                                    );
var
    Position    : LongInt;
    ImageStream : TStream;
    LastPercent : ShortInt;
begin
    LastPercent := -1;
    LastPercent := DoProgress( Self, FOnReadWriteProgress, 0, 0, 100, LastPercent );

    Position := Stream.Position;

    ImageStream := nil;
    try
        if Position <> 0 then
        begin
            { when loading images from DFM files, the image
              stream is included when a larger stream. The LibTiff
              library does not handle this, so a new stream
              must be created. }
            ImageStream := TMemoryStream.Create;

            TMemoryStream(ImageStream).SetSize(Stream.Size-Stream.Position);
            ImageStream.CopyFrom(Stream, Stream.Size-Stream.Position)
        end
        else
            ImageStream := Stream;

        ImageStream.Seek(0, soFromBeginning);

        ReadDibFromTiffStream(Self, ImageStream, ImageToLoad, FRowsPerStrip, LastPercent);

    finally
        if Position <> 0 then
            ImageStream.Free;
    end;

    DoProgress( Self, OnReadWriteProgress, 100, 0, 100, -1 );

end;

{--------------------------------------------------------------------------}
{$WARNINGS OFF}
procedure WriteDibToTiffStream( const Dib          : TTiffGraphic;
                                const Stream       : TStream;
                                const WriteMode    : TTiffOpenMode;
                                      RowsPerStrip : LongInt );
var
    TiffHandle                : TTiffHandle;
    CompressTag               : Word;
    PhotometricInterpretation : Word;
    Row                       : LongInt;
    Palette                   : TMaxLogPalette;
    pScanLine                 : PByteArray;
    ModifiedScanLine          : Boolean;
    Index                     : LongInt;
    LastPercent               : ShortInt;

begin
    LastPercent := -1;
    LastPercent := DoProgress( Dib, Dib.OnReadWriteProgress, 0, 0, 100, LastPercent );

    TiffHandle := TIFFOpen(Stream, WriteMode);
    if TiffHandle = nil then
        RaiseTiffError('TIFFOpen');

    try
        CompressTag := COMPRESSION_NONE;
        case Dib.Compression of
            tcPackbits   : CompressTag := COMPRESSION_PACKBITS;
            tcGroup3_1d,
            tcGroup3_2d:
            begin
                { the compression tag must be set before setting the group 3
                  options }
                CompressTag := COMPRESSION_CCITTFAX3;
                TIFFSetIntField(TiffHandle, TIFFTAG_COMPRESSION, CompressTag);
                if Dib.Compression = tcGroup3_2d then
                    TIFFSetIntField(TiffHandle, TIFFTAG_GROUP3OPTIONS, 1)
                else
                    TIFFSetIntField(TiffHandle, TIFFTAG_GROUP3OPTIONS, 0);
            end;
            tcGroup4     :
            begin
                CompressTag  := COMPRESSION_CCITTFAX4;
            end;

            tcLZW        : CompressTag := COMPRESSION_LZW;
            tcZLib       : CompressTag := COMPRESSION_DEFLATE;
            tcJPEG       :
            begin
                CompressTag  := COMPRESSION_JPEG;
                RowsPerStrip := 8; { must be 8 for JPEG }
            end;
        end;

        { MB Jul 13, 2000. If RowsPerStrip is not set, use the internal libtiff
          default. }
        if RowsPerStrip > 0 then
            TIFFSetIntField(TiffHandle, TIFFTAG_ROWSPERSTRIP, RowsPerStrip);

        TIFFSetIntField(TiffHandle, TIFFTAG_COMPRESSION, CompressTag);

        if (CompressTag = COMPRESSION_JPEG) then
            TIFFVSetIntField( TiffHandle, TIFFTAG_JPEGQUALITY, DIB.JPegQuality);

        TIFFSetIntField(TiffHandle, TIFFTAG_PLANARCONFIG, 1);

        WriteTags( TiffHandle, Dib );

        if Dib.SoftwareTag = '' then
            TIFFSetPCharField( TiffHandle, TIFFTAG_SOFTWARE,
                               PChar('Envision Image Library'));

        if Dib.DateTimeTag = '' then
            TIFFSetPCharField( TiffHandle, TIFFTAG_DATETIME,
                               PChar(
                                  DateToDateStr( SysUtils.Date,
                                  'yyyy:mm:dd' ) + ' ' +
                                  TimeToTimeStr( SysUtils.Time,
                                                'hh:nn:ss')));

        TIFFSetIntField(TiffHandle, TIFFTAG_RESOLUTIONUNIT, RESUNIT_INCH);
        TIFFSetFloatField(TiffHandle, TIFFTAG_XRESOLUTION, Dib.XDotsPerInch);
        TIFFSetFloatField(TiffHandle, TIFFTAG_YRESOLUTION, Dib.YDotsPerInch);

        TIFFSetIntField(TiffHandle, TIFFTAG_IMAGEWIDTH, Dib.Width);

        TIFFSetIntField(TiffHandle, TIFFTAG_IMAGELENGTH, Dib.Height);

        case Dib.ImageFormat of
            ifBlackWhite:
            begin
                TIFFSetIntField(TiffHandle, TIFFTAG_BITSPERSAMPLE, 1);
                TIFFSetIntField(TiffHandle, TIFFTAG_SAMPLESPERPIXEL, 1);

                if Dib.Compression in [tcGroup3_1d, tcGroup3_2d, tcGroup4] then
                    PhotometricInterpretation := 0
                else
                    PhotometricInterpretation := 1;

                TIFFSetIntField( TiffHandle, TIFFTAG_PHOTOMETRIC,
                                 PhotometricInterpretation)
            end;

            ifGray16,
            ifGray256:
            begin
                if Dib.ImageFormat = ifGray16 then
                    TIFFSetIntField(TiffHandle, TIFFTAG_BITSPERSAMPLE, 4)
                else
                    TIFFSetIntField(TiffHandle, TIFFTAG_BITSPERSAMPLE, 8);

                TIFFSetIntField(TiffHandle, TIFFTAG_SAMPLESPERPIXEL, 1);
                TIFFSetIntField(TiffHandle, TIFFTAG_PHOTOMETRIC, 1);
            end;

            ifColor16,
            ifColor256:
            begin
                if Dib.ImageFormat = ifColor16 then
                    TIFFSetIntField(TiffHandle, TIFFTAG_BITSPERSAMPLE, 4)
                else
                    TIFFSetIntField(TiffHandle, TIFFTAG_BITSPERSAMPLE, 8);

                TIFFSetIntField(TiffHandle, TIFFTAG_SAMPLESPERPIXEL, 1);
                TIFFSetIntField(TiffHandle, TIFFTAG_PHOTOMETRIC, 3);

                { MB Apr 17, 2002. For some reason, to 256 value had been
                  changed to 2 }
                Palette.palNumEntries := GetPaletteEntries(
                                           Dib.PaletteHandle,
                                           0,
                                           256,
                                           Palette.palPalEntry );
                SetTiffPalette( TiffHandle, Palette );
            end;

            ifTrueColor:
            begin
                TIFFSetIntField(TiffHandle, TIFFTAG_BITSPERSAMPLE, 8);
                TIFFSetIntField(TiffHandle, TIFFTAG_SAMPLESPERPIXEL, 3);
                TIFFSetIntField(TiffHandle, TIFFTAG_PHOTOMETRIC, 2);
            end;
        end; { case }

        ModifiedScanLine := (
                             (Dib.ImageFormat = ifBlackWhite) and
                             (Dib.Compression in [tcGroup3_1d, tcGroup3_2d, tcGroup4])
                            )
                            or
                            (Dib.ImageFormat = ifTrueColor);

        pScanLine := nil; { prevent compiler warning }

        if ModifiedScanLine then
            GetMem(pScanLine, Dib.ScanLineSize);

        try

            for Row := 0 to (Dib.Height-1) do
            begin

                LastPercent := DoProgress( Dib, Dib.OnReadWriteProgress, Row, 0, Dib.Height-1, LastPercent );

                if ModifiedScanLine then
                begin
                    { CCITT compress requires Black = 1 }

                    Move(Dib.ScanLine[Row]^, pScanLine^, Dib.ScanLineSize);

                    if Dib.ImageFormat = ifBlackWhite then
                    begin
                        for Index := 0 to (Dib.ScanLineSize-1) do
                            pScanLine^[Index] := not pScanLine^[Index];
                    end;

                    if Dib.ImageFormat = ifTrueColor then
                    begin
                        { R and B values must be swapped after loading the file
                          with many different image viewers. }
                        SwapRBOnScanLine(pScanLine, Dib.ScanLineSize);
                    end;
                end
                else
                    pScanLine := Dib.ScanLine[Row];

                if TIFFWriteScanline(TiffHandle, pScanLine, Row) = -1 then
                    RaiseTiffError('TIFFWriteScanLine');
            end;

        finally
            if ModifiedScanLine then
                FreeMem(pScanLine, Dib.ScanLineSize);
        end;

    finally
        TIFFClose(TiffHandle);
    end;

    DoProgress( Dib, Dib.OnReadWriteProgress, 100, 0, 100, -1 );

end;
{$WARNINGS ON}
{--------------------------------------------------------------------------}

procedure TTiffGraphic.SaveToStream(Stream: TStream);
var
    Position    : LongInt;
    ImageStream : TStream;

begin
    Position := Stream.Position;

    ImageStream := nil;
    try
        if Position <> 0 then
        begin
            { when saving images from DFM files, the image
              stream is included within a larger stream. The LibTiff
              library does not handle this, so a new stream
              must be created. }
            ImageStream := TMemoryStream.Create;
        end
        else
            ImageStream := Stream;

        WriteDibToTiffStream(Self, ImageStream, omWrite, FRowsPerStrip);

        if Position <> 0 then
        begin
            ImageStream.Seek(0, soFromBeginning);
            Stream.CopyFrom(ImageStream, ImageStream.Size);
        end;

    finally
        if Position <> 0 then
            ImageStream.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure TTiffGraphic.AppendToStream(Stream : TStream);
begin
    if Stream.Size = 0 then
        { the stream is empty, this is not really an append operation. }
        SaveToStream(Stream)
    else
    begin
        Stream.Seek(0, soFromBeginning);
        WriteDibToTiffStream(Self, Stream, omAppend, FRowsPerStrip);
    end;
end;

{--------------------------------------------------------------------------}

class function TTiffGraphic.CanRead( const Stream : TStream ) : Boolean;
var
    Signature : array[1..4] of Byte;
begin
    Stream.Read( Signature, SizeOf(Signature));
    Stream.Seek( -(SizeOf(Signature)), soFromCurrent );

    Result := (
               (Signature[1] = $4D) and
               (Signature[2] = $4D) and
               (Signature[3] = $00) and
               (Signature[4] = $2A)
              )
              or
              (
               (Signature[1] = $49) and
               (Signature[2] = $49) and
               (Signature[3] = $2A) and
               (Signature[4] = $00)
              );
end;

{--------------------------------------------------------------------------}

initialization

    SetTiffTagValues( CCustomTagValues[0], CCustomTagValues[1], CCustomTagValues[2], CCustomTagValues[3],
                      CCustomTagValues[4], CCustomTagValues[5], CCustomTagValues[6], CCustomTagValues[7],
                      CCustomTagValues[8], CCustomTagValues[9], CCustomTagValues[10], CCustomTagValues[11],
                      CCustomTagValues[12], CCustomTagValues[13], CCustomTagValues[14], CCustomTagValues[15],
                      CCustomTagValues[16], CCustomTagValues[17], CCustomTagValues[18], CCustomTagValues[19]
                    );


    {$ifdef __RegisterEnvisionTif}
    RegisterDibGraphic('TIF', 'TIFF file', TTiffGraphic);
    RegisterDibGraphic('TIFF', 'TIFF file', TTiffGraphic);
    {$endif}

finalization

end.

