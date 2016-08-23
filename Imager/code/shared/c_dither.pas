// dithering functions 
unit c_dither;

interface

uses Windows, SysUtils, Classes, Graphics, Consts;

const
  BitmapAllocationThreshold = 500000;

type
  TColorReduction =
    (rmNone, rmWindows20, rmWindows256, rmWindowsGray, rmMonochrome, rmGrayScale,
     rmNetscape, rmQuantize, rmQuantizeWindows, rmPalette );

  TDitherMode =
    (dmNearest, dmFloydSteinberg, dmStucki, dmSierra, dmJaJuNI, dmSteveArche,
     dmBurkes);

  function WebPalette: HPalette;

  function ReduceColors(Bitmap: TBitmap; ColorReduction: TColorReduction;
    DitherMode: TDitherMode; ReductionBits: integer; CustomPalette: hPalette): TBitmap;

resourcestring
  sOutOfMemDIB = 'Failed to allocate memory for DIB';
  sBadDimension	= 'Invalid image dimensions';
  sNoDIB = 'Image has no DIB';

implementation

function WebPalette: HPalette;
type
  TLogWebPalette	= packed record
    palVersion		: word;
    palNumEntries	: word;
    PalEntries		: array[0..5,0..5,0..5] of TPaletteEntry;
  end;
var
  r, g, b		: byte;
  LogWebPalette		: TLogWebPalette;
  LogPalette		: TLogpalette absolute LogWebPalette; // Stupid typecast
begin
  with LogWebPalette do
  begin
    palVersion:= $0300;
    palNumEntries:= 216;
    for r:=0 to 5 do
      for g:=0 to 5 do
        for b:=0 to 5 do
        begin
          with PalEntries[r,g,b] do
          begin
            peRed := 51 * r;
            peGreen := 51 * g;
            peBlue := 51 * b;
            peFlags := 0;
          end;
        end;
  end;
  Result := CreatePalette(Logpalette);
end;

function GDICheck(Value: Cardinal): Cardinal;
var
  ErrorCode		: integer;
  Buf			: array [byte] of char;

  function ReturnAddr: Pointer;
  // From classes.pas
  asm
    MOV		EAX,[EBP+4] // sysutils.pas says [EBP-4], but this works !
  end;

begin
  if (Value = 0) then
  begin
    ErrorCode := GetLastError;
    if (ErrorCode <> 0) and (FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, nil,
      ErrorCode, LOCALE_USER_DEFAULT, Buf, sizeof(Buf), nil) <> 0) then
      raise EOutOfResources.Create(Buf) at ReturnAddr
    else
      raise EOutOfResources.Create(SOutOfResources) at ReturnAddr;
  end;
  Result := Value;
end;

procedure Error(msg: string);
  function ReturnAddr: Pointer;
  // From classes.pas
  asm
    MOV		EAX,[EBP+4] // sysutils.pas says [EBP-4] !
  end;
begin
  raise EInvalidGraphic.Create(msg) at ReturnAddr;
end;

function AlignBit(Bits, BitsPerPixel, Alignment: Cardinal): Cardinal;
begin
  Dec(Alignment);
  Result := ((Bits * BitsPerPixel) + Alignment) and not Alignment;
  Result := Result SHR 3;
end;

procedure SetPixelFormat(Bitmap: TBitmap; PixelFormat: TPixelFormat);
begin
  Bitmap.PixelFormat := PixelFormat;
end;

type
  TDIB = class(TObject)
  private
    FBitmap		: TBitmap;
    FPixelFormat	: TPixelFormat;
  protected
    function GetScanline(Row: integer): pointer; virtual; abstract;
    constructor Create(ABitmap: TBitmap; APixelFormat: TPixelFormat);
  public
    property Scanline[Row: integer]: pointer read GetScanline;
    property Bitmap: TBitmap read FBitmap;
    property PixelFormat: TPixelFormat read FPixelFormat;
  end;

  TDIBReader = class(TDIB)
  private
  protected
    function GetScanline(Row: integer): pointer; override;
  public
    constructor Create(ABitmap: TBitmap; APixelFormat: TPixelFormat);
    destructor Destroy; override;
  end;

  TDIBWriter = class(TDIB)
  private
    FDIBInfo		: PBitmapInfo;
    FDIBBits		: pointer;
    FDIBInfoSize	: integer;
    FDIBBitsSize	: longInt;
    FPalette		: HPalette;
    FHeight		: integer;
    FWidth		: integer;
  protected
    procedure CreateDIB;
    procedure FreeDIB;
    procedure NeedDIB;
    function GetScanline(Row: integer): pointer; override;
  public
    constructor Create(ABitmap: TBitmap; APixelFormat: TPixelFormat;
      AWidth, AHeight: integer; APalette: HPalette);
    destructor Destroy; override;
    procedure UpdateBitmap;
    property Width: integer read FWidth;
    property Height: integer read FHeight;
    property Palette: HPalette read FPalette;
  end;

////////////////////////////////////////////////////////////////////////////////
constructor TDIB.Create(ABitmap: TBitmap; APixelFormat: TPixelFormat);
begin
  inherited Create;
  FBitmap := ABitmap;
  FPixelFormat := APixelFormat;
end;

////////////////////////////////////////////////////////////////////////////////
constructor TDIBReader.Create(ABitmap: TBitmap; APixelFormat: TPixelFormat);
begin
  inherited Create(ABitmap, APixelFormat);
  SetPixelFormat(FBitmap, FPixelFormat);
end;

destructor TDIBReader.Destroy;
begin
  inherited Destroy;
end;

function TDIBReader.GetScanline(Row: integer): pointer;
begin
  Result := FBitmap.ScanLine[Row];
end;

constructor TDIBWriter.Create(ABitmap: TBitmap; APixelFormat: TPixelFormat;
  AWidth, AHeight: integer; APalette: HPalette);
begin
  inherited Create(ABitmap, APixelFormat);

  // DIB writer only supports 8 or 24 bit bitmaps
  if not(APixelFormat in [pf8bit, pf24bit]) then
    Error(sInvalidPixelFormat);
  if (AWidth = 0) or (AHeight = 0) then
    Error(sBadDimension);

  FHeight := AHeight;
  FWidth := AWidth;
  FPalette := APalette;
  FDIBInfo := nil;
  FDIBBits := nil;
end;

destructor TDIBWriter.Destroy;
begin
  UpdateBitmap;
  FreeDIB;
  inherited Destroy;
end;

function TDIBWriter.GetScanline(Row: integer): pointer;
begin
  NeedDIB;

  if (FDIBBits = nil) then
    Error(sNoDIB);
  with FDIBInfo^.bmiHeader do
  begin
    if (Row < 0) or (Row >= Height) then
      raise EInvalidGraphicOperation.Create(SScanLine);
    GDIFlush;

    if biHeight > 0 then  // bottom-up DIB
      Row := biHeight - Row - 1;
    Result := PChar(Cardinal(FDIBBits) + Cardinal(Row) * AlignBit(biWidth, biBitCount, 32));
  end;
end;

procedure TDIBWriter.CreateDIB;
var
  SrcColors		: WORD;

  procedure ByteSwapColors(var Colors; Count: Integer);
  var   // convert RGB to BGR and vice-versa.  TRGBQuad <-> TPaletteEntry
    SysInfo: TSystemInfo;
  begin
    GetSystemInfo(SysInfo);
    asm
          MOV   EDX, Colors
          MOV   ECX, Count
          DEC   ECX
          JS    @@END
          LEA   EAX, SysInfo
          CMP   [EAX].TSystemInfo.wProcessorLevel, 3
          JE    @@386
    @@1:  MOV   EAX, [EDX+ECX*4]
          BSWAP EAX
          SHR   EAX,8
          MOV   [EDX+ECX*4],EAX
          DEC   ECX
          JNS   @@1
          JMP   @@END
    @@386:
          PUSH  EBX
    @@2:  XOR   EBX,EBX
          MOV   EAX, [EDX+ECX*4]
          MOV   BH, AL
          MOV   BL, AH
          SHR   EAX,16
          SHL   EBX,8
          MOV   BL, AL
          MOV   [EDX+ECX*4],EBX
          DEC   ECX
          JNS   @@2
          POP   EBX
      @@END:
    end;
  end;
begin
  FreeDIB;

  if (PixelFormat = pf8bit) then
    // 8 bit: Header and palette
    FDIBInfoSize := SizeOf(TBitmapInfoHeader) + SizeOf(TRGBQuad) * (1 shl 8)
  else
    // 24 bit: Header but no palette
    FDIBInfoSize := SizeOf(TBitmapInfoHeader);

  // Allocate TBitmapInfo structure
  GetMem(FDIBInfo, FDIBInfoSize);
  try
    FDIBInfo^.bmiHeader.biSize := SizeOf(FDIBInfo^.bmiHeader);
    FDIBInfo^.bmiHeader.biWidth := Width;
    FDIBInfo^.bmiHeader.biHeight := Height;
    FDIBInfo^.bmiHeader.biPlanes := 1;
    FDIBInfo^.bmiHeader.biSizeImage := 0;
    FDIBInfo^.bmiHeader.biCompression := BI_RGB;

    if (PixelFormat = pf8bit) then
    begin
      FDIBInfo^.bmiHeader.biBitCount := 8;
      // Find number of colors defined by palette
      if (Palette <> 0) and
        (GetObject(Palette, sizeof(SrcColors), @SrcColors) <> 0) and
        (SrcColors <> 0) then
      begin
        // Copy all colors...
        GetPaletteEntries(Palette, 0, SrcColors, FDIBInfo^.bmiColors[0]);
        // ...and convert BGR to RGB
        ByteSwapColors(FDIBInfo^.bmiColors[0], SrcColors);
      end else
        SrcColors := 0;

      // Finally zero any unused entried
      if (SrcColors < 256) then
        FillChar(pointer(LongInt(@FDIBInfo^.bmiColors)+SizeOf(TRGBQuad)*SrcColors)^,
          256 - SrcColors, 0);
      FDIBInfo^.bmiHeader.biClrUsed := 256;
      FDIBInfo^.bmiHeader.biClrImportant := SrcColors;
    end else
    begin
      FDIBInfo^.bmiHeader.biBitCount := 24;
      FDIBInfo^.bmiHeader.biClrUsed := 0;
      FDIBInfo^.bmiHeader.biClrImportant := 0;
    end;
    FDIBBitsSize := AlignBit(Width, FDIBInfo^.bmiHeader.biBitCount, 32) * Cardinal(abs(Height));

    FDIBBits := GlobalAllocPtr(GMEM_MOVEABLE, FDIBBitsSize);
    if (FDIBBits = nil) then
      raise EOutOfMemory.Create(sOutOfMemDIB);
  except
    FreeDIB;
    raise;
  end;
end;

procedure TDIBWriter.FreeDIB;
begin
  if (FDIBInfo <> nil) then
    FreeMem(FDIBInfo);
  if (FDIBBits <> nil) then
    GlobalFreePtr(FDIBBits);
  FDIBInfo := nil;
  FDIBBits := nil;
end;

procedure TDIBWriter.NeedDIB;
begin
  if (FDIBBits = nil) then
    CreateDIB;
end;

// Convert the DIB created by CreateDIB back to a TBitmap
procedure TDIBWriter.UpdateBitmap;
var
  Stream		: TMemoryStream;
  FileSize		: longInt;
  BitmapFileHeader	: TBitmapFileHeader;
begin
  if (FDIBBits = nil) then
    exit;
  begin
    // Write DIB to a stream in the BMP file format
    Stream := TMemoryStream.Create;
    try
      // Make room in stream for a TBitmapInfo and pixel data
      FileSize := sizeof(TBitmapFileHeader) + FDIBInfoSize + FDIBBitsSize;
      Stream.SetSize(FileSize);
      // Initialize file header
      FillChar(BitmapFileHeader, sizeof(TBitmapFileHeader), 0);
      with BitmapFileHeader do
      begin
        bfType := $4D42; // 'BM' = Windows BMP signature
        bfSize := FileSize; // File size (not needed)
        bfOffBits := sizeof(TBitmapFileHeader) + FDIBInfoSize; // Offset of pixel data
      end;
      // Save file header
      Stream.Write(BitmapFileHeader, sizeof(TBitmapFileHeader));
      // Save TBitmapInfo structure
      Stream.Write(FDIBInfo^, FDIBInfoSize);
      // Save pixel data
      Stream.Write(FDIBBits^, FDIBBitsSize);

      // Rewind and load bitmap from stream
      Stream.Position := 0;
      FBitmap.LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
  end;
end;

type
  TColorLookup = class(TObject)
  private
    FColors		: integer;
  public
    constructor Create(Palette: hPalette); virtual;
    function Lookup(Red, Green, Blue: BYTE; var R, G, B: BYTE): char; virtual; abstract;
    property Colors: integer read FColors;
  end;

  PRGBQuadArray = ^TRGBQuadArray;
  TRGBQuadArray = array[Byte] of TRGBQuad;

  BGRArray = array[0..0] of TRGBTriple;
  PBGRArray = ^BGRArray;

  PalArray =  array[byte] of TPaletteEntry;
  PPalArray = ^PalArray;

  TInverseLookup = array[0..1 SHL 15-1] of SmallInt;
  PInverseLookup = ^TInverseLookup;

  TFastColorLookup = class(TColorLookup)
  private
    FPaletteEntries	: PPalArray;
    FInverseLookup	: PInverseLookup;
  public
    constructor Create(Palette: hPalette); override;
    destructor Destroy; override;
    function Lookup(Red, Green, Blue: BYTE; var R, G, B: BYTE): char; override;
  end;

  TSlowColorLookup = class(TColorLookup)
  private
    FPaletteEntries	: PPalArray;
    FPalette		: hPalette;
  public
    constructor Create(Palette: hPalette); override;
    destructor Destroy; override;
    function Lookup(Red, Green, Blue: BYTE; var R, G, B: BYTE): char; override;
  end;

  TNetscapeColorLookup = class(TColorLookup)
  public
    constructor Create(Palette: hPalette); override;
    function Lookup(Red, Green, Blue: BYTE; var R, G, B: BYTE): char; override;
  end;

  TGrayWindowsLookup = class(TSlowColorLookup)
  public
    constructor Create(Palette: hPalette); override;
    function Lookup(Red, Green, Blue: BYTE; var R, G, B: BYTE): char; override;
  end;

  TGrayScaleLookup = class(TColorLookup)
  public
    constructor Create(Palette: hPalette); override;
    function Lookup(Red, Green, Blue: BYTE; var R, G, B: BYTE): char; override;
  end;

  TMonochromeLookup = class(TColorLookup)
  public
    constructor Create(Palette: hPalette); override;
    function Lookup(Red, Green, Blue: BYTE; var R, G, B: BYTE): char; override;
  end;

constructor TColorLookup.Create(Palette: hPalette);
begin
  inherited Create;
end;

constructor TFastColorLookup.Create(Palette: hPalette);
var
  i			: integer;
  InverseIndex		: integer;
begin
  inherited Create(Palette);

  GetMem(FPaletteEntries, sizeof(TPaletteEntry) * 256);
  FColors := GetPaletteEntries(Palette, 0, 256, FPaletteEntries^);

  New(FInverseLookup);
  for i := low(TInverseLookup) to high(TInverseLookup) do
    FInverseLookup^[i] := -1;

  if (FColors > 0) then
    for i := 0 to FColors-1 do
      with FPaletteEntries^[i] do
      begin
        InverseIndex := (peRed SHR 3) OR ((peGreen AND $F8) SHL 2) OR ((peBlue AND $F8) SHL 7);
        if (FInverseLookup^[InverseIndex] = -1) then
          FInverseLookup^[InverseIndex] := i;
      end;
end;

destructor TFastColorLookup.Destroy;
begin
  if (FPaletteEntries <> nil) then
    FreeMem(FPaletteEntries);
  if (FInverseLookup <> nil) then
    Dispose(FInverseLookup);

  inherited Destroy;
end;

function TFastColorLookup.Lookup(Red, Green, Blue: BYTE; var R, G, B: BYTE): char;
var
  i			: integer;
  InverseIndex		: integer;
  Delta			,
  MinDelta		,
  MinColor		: integer;
begin
  InverseIndex := (Red SHR 3) OR ((Green AND $F8) SHL 2) OR ((Blue AND $F8) SHL 7);

  if (FInverseLookup^[InverseIndex] <> -1) then
    Result := char(FInverseLookup^[InverseIndex])
  else
  begin
    MinDelta := 3 * (256 * 256);
    MinColor := 0;
    for i := 0 to FColors-1 do
      with FPaletteEntries[i] do
      begin
        Delta := ABS(peRed - Red) + ABS(peGreen - Green) + ABS(peBlue - Blue);
        if (Delta < MinDelta) then
        begin
          MinDelta := Delta;
          MinColor := i;
        end;
      end;
    Result := char(MinColor);
    FInverseLookup^[InverseIndex] := MinColor;
  end;

  with FPaletteEntries^[ord(Result)] do
  begin
    R := peRed;
    G := peGreen;
    B := peBlue;
  end;
end;

constructor TSlowColorLookup.Create(Palette: hPalette);
begin
  inherited Create(Palette);
  FPalette := Palette;
  FColors := GetPaletteEntries(Palette, 0, 256, nil^);
  if (FColors > 0) then
  begin
    GetMem(FPaletteEntries, sizeof(TPaletteEntry) * FColors);
    FColors := GetPaletteEntries(Palette, 0, 256, FPaletteEntries^);
  end;
end;

destructor TSlowColorLookup.Destroy;
begin
  if (FPaletteEntries <> nil) then
    FreeMem(FPaletteEntries);

  inherited Destroy;
end;

// Map color to arbitrary palette
function TSlowColorLookup.Lookup(Red, Green, Blue: BYTE; var R, G, B: BYTE): char;
begin
  Result := char(GetNearestPaletteIndex(FPalette, Red OR (Green SHL 8) OR (Blue SHL 16)));
  if (FPaletteEntries <> nil) then
    with FPaletteEntries^[ord(Result)] do
    begin
      R := peRed;
      G := peGreen;
      B := peBlue;
    end;
end;

constructor TNetscapeColorLookup.Create(Palette: hPalette);
begin
  inherited Create(Palette);
  FColors := 6*6*6;
end;

function TNetscapeColorLookup.Lookup(Red, Green, Blue: BYTE; var R, G, B: BYTE): char;
begin
  R := (Red+3) DIV 51;
  G := (Green+3) DIV 51;
  B := (Blue+3) DIV 51;
  Result := char(B + 6*G + 36*R);
  R := R * 51;
  G := G * 51;
  B := B * 51;
end;

constructor TGrayWindowsLookup.Create(Palette: hPalette);
begin
  inherited Create(Palette);
  FColors := 4;
end;

function TGrayWindowsLookup.Lookup(Red, Green, Blue: BYTE; var R, G, B: BYTE): char;
begin
  Result := inherited Lookup(MulDiv(Red, 77, 256),
    MulDiv(Green, 150, 256), MulDiv(Blue, 29, 256), R, G, B);
end;

constructor TGrayScaleLookup.Create(Palette: hPalette);
begin
  inherited Create(Palette);
  FColors := 256;
end;

function TGrayScaleLookup.Lookup(Red, Green, Blue: BYTE; var R, G, B: BYTE): char;
begin
  Result := char((Blue*29 + Green*150 + Red*77) DIV 256);
  R := ord(Result);
  G := ord(Result);
  B := ord(Result);
end;

constructor TMonochromeLookup.Create(Palette: hPalette);
begin
  inherited Create(Palette);
  FColors := 2;
end;

function TMonochromeLookup.Lookup(Red, Green, Blue: BYTE; var R, G, B: BYTE): char;
begin
  if ((Blue*29 + Green*150 + Red*77) > 32512) then
  begin
    Result := #1;
    R := 255;
    G := 255;
    B := 255;
  end else
  begin
    Result := #0;
    R := 0;
    G := 0;
    B := 0;
  end;
end;

type
  TDitherEngine = class
  private
  protected
    FDirection		: integer;
    FColumn		: integer;
    FLookup		: TColorLookup;
    Width		: integer;
  public
    constructor Create(AWidth: integer; Lookup: TColorLookup); virtual;
    function Dither(Red, Green, Blue: BYTE; var R, G, B: BYTE): char; virtual;
    procedure NextLine; virtual;
    procedure NextColumn;

    property Direction: integer read FDirection;
    property Column: integer read FColumn;
  end;

  TErrorTerm		= Integer;
  TErrors		= array[0..0] of TErrorTerm;
  PErrors		= ^TErrors;

  TFloydSteinbergDitherer = class(TDitherEngine)
  private
    ErrorsR		,
    ErrorsG		,
    ErrorsB		: PErrors;
    ErrorR		,
    ErrorG		,
    ErrorB		: PErrors;
    CurrentErrorR	,
    CurrentErrorG	,
    CurrentErrorB	,
    BelowErrorR		,
    BelowErrorG		,
    BelowErrorB		,
    BelowPrevErrorR	,
    BelowPrevErrorG	,
    BelowPrevErrorB	: TErrorTerm;
  public
    constructor Create(AWidth: integer; Lookup: TColorLookup); override;
    destructor Destroy; override;
    function Dither(Red, Green, Blue: BYTE; var R, G, B: BYTE): char; override;
    procedure NextLine; override;
  end;

  T5by3Ditherer = class(TDitherEngine)
  private
    ErrorsR0		,
    ErrorsG0		,
    ErrorsB0		,
    ErrorsR1		,
    ErrorsG1		,
    ErrorsB1		,
    ErrorsR2		,
    ErrorsG2		,
    ErrorsB2		: PErrors;
    ErrorR0		,
    ErrorG0		,
    ErrorB0		,
    ErrorR1		,
    ErrorG1		,
    ErrorB1		,
    ErrorR2		,
    ErrorG2		,
    ErrorB2		: PErrors;
    FDirection2		: integer;
  protected
    FDivisor		: integer;
    procedure Propagate(Errors0, Errors1, Errors2: PErrors; Error: integer); virtual; abstract;
  public
    constructor Create(AWidth: integer; Lookup: TColorLookup); override;
    destructor Destroy; override;
    function Dither(Red, Green, Blue: BYTE; var R, G, B: BYTE): char; override;
    procedure NextLine; override;
  end;

  TStuckiDitherer = class(T5by3Ditherer)
  protected
    procedure Propagate(Errors0, Errors1, Errors2: PErrors; Error: integer); override;
  public
    constructor Create(AWidth: integer; Lookup: TColorLookup); override;
  end;

  TSierraDitherer = class(T5by3Ditherer)
  protected
    procedure Propagate(Errors0, Errors1, Errors2: PErrors; Error: integer); override;
  public
    constructor Create(AWidth: integer; Lookup: TColorLookup); override;
  end;

  TJaJuNiDitherer = class(T5by3Ditherer)
  protected
    procedure Propagate(Errors0, Errors1, Errors2: PErrors; Error: integer); override;
  public
    constructor Create(AWidth: integer; Lookup: TColorLookup); override;
  end;

  TSteveArcheDitherer = class(TDitherEngine)
  private
    ErrorsR0		,
    ErrorsG0		,
    ErrorsB0		,
    ErrorsR1		,
    ErrorsG1		,
    ErrorsB1		,
    ErrorsR2		,
    ErrorsG2		,
    ErrorsB2		,
    ErrorsR3		,
    ErrorsG3		,
    ErrorsB3		: PErrors;
    ErrorR0		,
    ErrorG0		,
    ErrorB0		,
    ErrorR1		,
    ErrorG1		,
    ErrorB1		,
    ErrorR2		,
    ErrorG2		,
    ErrorB2		,
    ErrorR3		,
    ErrorG3		,
    ErrorB3		: PErrors;
    FDirection2		,
    FDirection3		: integer;
  public
    constructor Create(AWidth: integer; Lookup: TColorLookup); override;
    destructor Destroy; override;
    function Dither(Red, Green, Blue: BYTE; var R, G, B: BYTE): char; override;
    procedure NextLine; override;
  end;

  TBurkesDitherer = class(TDitherEngine)
  private
    ErrorsR0		,
    ErrorsG0		,
    ErrorsB0		,
    ErrorsR1		,
    ErrorsG1		,
    ErrorsB1		: PErrors;
    ErrorR0		,
    ErrorG0		,
    ErrorB0		,
    ErrorR1		,
    ErrorG1		,
    ErrorB1		: PErrors;
    FDirection2		: integer;
  public
    constructor Create(AWidth: integer; Lookup: TColorLookup); override;
    destructor Destroy; override;
    function Dither(Red, Green, Blue: BYTE; var R, G, B: BYTE): char; override;
    procedure NextLine; override;
  end;

constructor TDitherEngine.Create(AWidth: integer; Lookup: TColorLookup);
begin
  inherited Create;

  FLookup := Lookup;
  Width := AWidth;

  FDirection := 1;
  FColumn := 0;
end;

function TDitherEngine.Dither(Red, Green, Blue: BYTE; var R, G, B: BYTE): char;
begin
  Result := FLookup.Lookup(Red, Green, Blue, R, G, B);
  NextColumn;
end;

procedure TDitherEngine.NextLine;
begin
  FDirection := -FDirection;
  if (FDirection = 1) then
    FColumn := 0
  else
    FColumn := Width-1;
end;

procedure TDitherEngine.NextColumn;
begin
  inc(FColumn, FDirection);
end;

constructor TFloydSteinbergDitherer.Create(AWidth: integer; Lookup: TColorLookup);
begin
  inherited Create(AWidth, Lookup);
  GetMem(ErrorsR, sizeof(TErrorTerm)*(Width+2));
  GetMem(ErrorsG, sizeof(TErrorTerm)*(Width+2));
  GetMem(ErrorsB, sizeof(TErrorTerm)*(Width+2));
  FillChar(ErrorsR^, sizeof(TErrorTerm)*(Width+2), 0);
  FillChar(ErrorsG^, sizeof(TErrorTerm)*(Width+2), 0);
  FillChar(ErrorsB^, sizeof(TErrorTerm)*(Width+2), 0);
  ErrorR := ErrorsR;
  ErrorG := ErrorsG;
  ErrorB := ErrorsB;
  CurrentErrorR := 0;
  CurrentErrorG := CurrentErrorR;
  CurrentErrorB := CurrentErrorR;
  BelowErrorR := CurrentErrorR;
  BelowErrorG := CurrentErrorR;
  BelowErrorB := CurrentErrorR;
  BelowPrevErrorR := CurrentErrorR;
  BelowPrevErrorG := CurrentErrorR;
  BelowPrevErrorB := CurrentErrorR;
end;

destructor TFloydSteinbergDitherer.Destroy;
begin
  FreeMem(ErrorsR);
  FreeMem(ErrorsG);
  FreeMem(ErrorsB);
  inherited Destroy;
end;

function TFloydSteinbergDitherer.Dither(Red, Green, Blue: BYTE; var R, G, B: BYTE): char;
var
  BelowNextError	: TErrorTerm;
  Delta			: TErrorTerm;
begin
  CurrentErrorR := Red + (CurrentErrorR + ErrorR[0] + 8) DIV 16;
  if (CurrentErrorR < 0) then
    CurrentErrorR := 0
  else if (CurrentErrorR > 255) then
    CurrentErrorR := 255;

  CurrentErrorG := Green + (CurrentErrorG + ErrorG[0] + 8) DIV 16;
  if (CurrentErrorG < 0) then
    CurrentErrorG := 0
  else if (CurrentErrorG > 255) then
    CurrentErrorG := 255;

  CurrentErrorB := Blue + (CurrentErrorB + ErrorB[0] + 8) DIV 16;
  if (CurrentErrorB < 0) then
    CurrentErrorB := 0
  else if (CurrentErrorB > 255) then
    CurrentErrorB := 255;

  Result := inherited Dither(CurrentErrorR, CurrentErrorG, CurrentErrorB, R, G, B);

  CurrentErrorR := CurrentErrorR - R;
  if (CurrentErrorR <> 0) then
  begin
    BelowNextError := CurrentErrorR;			// Error * 1

    Delta := CurrentErrorR * 2;
    inc(CurrentErrorR, Delta);
    ErrorR[0] := BelowPrevErrorR + CurrentErrorR;	// Error * 3

    inc(CurrentErrorR, Delta);
    BelowPrevErrorR := BelowErrorR + CurrentErrorR;	// Error * 5

    BelowErrorR := BelowNextError;			// Error * 1

    inc(CurrentErrorR, Delta);				// Error * 7
  end;

  CurrentErrorG := CurrentErrorG - G;
  if (CurrentErrorG <> 0) then
  begin
    BelowNextError := CurrentErrorG;			// Error * 1

    Delta := CurrentErrorG * 2;
    inc(CurrentErrorG, Delta);
    ErrorG[0] := BelowPrevErrorG + CurrentErrorG;	// Error * 3

    inc(CurrentErrorG, Delta);
    BelowPrevErrorG := BelowErrorG + CurrentErrorG;	// Error * 5

    BelowErrorG := BelowNextError;			// Error * 1

    inc(CurrentErrorG, Delta);				// Error * 7
  end;

  CurrentErrorB := CurrentErrorB - B;
  if (CurrentErrorB <> 0) then
  begin
    BelowNextError := CurrentErrorB;			// Error * 1

    Delta := CurrentErrorB * 2;
    inc(CurrentErrorB, Delta);
    ErrorB[0] := BelowPrevErrorB + CurrentErrorB;	// Error * 3

    inc(CurrentErrorB, Delta);
    BelowPrevErrorB := BelowErrorB + CurrentErrorB;	// Error * 5

    BelowErrorB := BelowNextError;			// Error * 1

    inc(CurrentErrorB, Delta);				// Error * 7
  end;

  if (Direction = 1) then
  begin
    inc(longInt(ErrorR), sizeof(TErrorTerm));
    inc(longInt(ErrorG), sizeof(TErrorTerm));
    inc(longInt(ErrorB), sizeof(TErrorTerm));
  end else
  begin
    dec(longInt(ErrorR), sizeof(TErrorTerm));
    dec(longInt(ErrorG), sizeof(TErrorTerm));
    dec(longInt(ErrorB), sizeof(TErrorTerm));
  end;
end;

procedure TFloydSteinbergDitherer.NextLine;
begin
  ErrorR[0] := BelowPrevErrorR;
  ErrorG[0] := BelowPrevErrorG;
  ErrorB[0] := BelowPrevErrorB;

  CurrentErrorR := 0;
  CurrentErrorG := CurrentErrorR;
  CurrentErrorB := CurrentErrorG;
  BelowErrorR := CurrentErrorG;
  BelowErrorG := CurrentErrorG;
  BelowErrorB := CurrentErrorG;
  BelowPrevErrorR := CurrentErrorG;
  BelowPrevErrorG := CurrentErrorG;
  BelowPrevErrorB := CurrentErrorG;

  inherited NextLine;

  if (Direction = 1) then
  begin
    ErrorR := ErrorsR;
    ErrorG := ErrorsG;
    ErrorB := ErrorsB;
  end else
  begin
    ErrorR := @ErrorsR[Width+1];
    ErrorG := @ErrorsG[Width+1];
    ErrorB := @ErrorsB[Width+1];
  end;
end;

constructor T5by3Ditherer.Create(AWidth: integer; Lookup: TColorLookup);
begin
  inherited Create(AWidth, Lookup);

  GetMem(ErrorsR0, sizeof(TErrorTerm)*(Width+4));
  GetMem(ErrorsG0, sizeof(TErrorTerm)*(Width+4));
  GetMem(ErrorsB0, sizeof(TErrorTerm)*(Width+4));
  GetMem(ErrorsR1, sizeof(TErrorTerm)*(Width+4));
  GetMem(ErrorsG1, sizeof(TErrorTerm)*(Width+4));
  GetMem(ErrorsB1, sizeof(TErrorTerm)*(Width+4));
  GetMem(ErrorsR2, sizeof(TErrorTerm)*(Width+4));
  GetMem(ErrorsG2, sizeof(TErrorTerm)*(Width+4));
  GetMem(ErrorsB2, sizeof(TErrorTerm)*(Width+4));
  FillChar(ErrorsR0^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsG0^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsB0^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsR1^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsG1^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsB1^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsR2^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsG2^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsB2^, sizeof(TErrorTerm)*(Width+4), 0);

  FDivisor := 1;
  FDirection2 := 2 * Direction;
  ErrorR0 := PErrors(longInt(ErrorsR0)+2*sizeof(TErrorTerm));
  ErrorG0 := PErrors(longInt(ErrorsG0)+2*sizeof(TErrorTerm));
  ErrorB0 := PErrors(longInt(ErrorsB0)+2*sizeof(TErrorTerm));
  ErrorR1 := PErrors(longInt(ErrorsR1)+2*sizeof(TErrorTerm));
  ErrorG1 := PErrors(longInt(ErrorsG1)+2*sizeof(TErrorTerm));
  ErrorB1 := PErrors(longInt(ErrorsB1)+2*sizeof(TErrorTerm));
  ErrorR2 := PErrors(longInt(ErrorsR2)+2*sizeof(TErrorTerm));
  ErrorG2 := PErrors(longInt(ErrorsG2)+2*sizeof(TErrorTerm));
  ErrorB2 := PErrors(longInt(ErrorsB2)+2*sizeof(TErrorTerm));
end;

destructor T5by3Ditherer.Destroy;
begin
  FreeMem(ErrorsR0);
  FreeMem(ErrorsG0);
  FreeMem(ErrorsB0);
  FreeMem(ErrorsR1);
  FreeMem(ErrorsG1);
  FreeMem(ErrorsB1);
  FreeMem(ErrorsR2);
  FreeMem(ErrorsG2);
  FreeMem(ErrorsB2);
  inherited Destroy;
end;

function T5by3Ditherer.Dither(Red, Green, Blue: BYTE; var R, G, B: BYTE): char;
var
  ColorR		,
  ColorG		,
  ColorB		: integer;
begin
  ColorR := Red + (ErrorR0[0] + FDivisor DIV 2) DIV FDivisor;
  if (ColorR < 0) then
    ColorR := 0
  else if (ColorR > 255) then
    ColorR := 255;

  ColorG := Green + (ErrorG0[0] + FDivisor DIV 2) DIV FDivisor;
  if (ColorG < 0) then
    ColorG := 0
  else if (ColorG > 255) then
    ColorG := 255;

  ColorB := Blue + (ErrorB0[0] + FDivisor DIV 2) DIV FDivisor;
  if (ColorB < 0) then
    ColorB := 0
  else if (ColorB > 255) then
    ColorB := 255;

  Result := inherited Dither(ColorR, ColorG, ColorB, R, G, B);

  Propagate(ErrorR0, ErrorR1, ErrorR2, ColorR - R);
  Propagate(ErrorG0, ErrorG1, ErrorG2, ColorG - G);
  Propagate(ErrorB0, ErrorB1, ErrorB2, ColorB - B);

  if (Direction = 1) then
  begin
    inc(longInt(ErrorR0), sizeof(TErrorTerm));
    inc(longInt(ErrorG0), sizeof(TErrorTerm));
    inc(longInt(ErrorB0), sizeof(TErrorTerm));
    inc(longInt(ErrorR1), sizeof(TErrorTerm));
    inc(longInt(ErrorG1), sizeof(TErrorTerm));
    inc(longInt(ErrorB1), sizeof(TErrorTerm));
    inc(longInt(ErrorR2), sizeof(TErrorTerm));
    inc(longInt(ErrorG2), sizeof(TErrorTerm));
    inc(longInt(ErrorB2), sizeof(TErrorTerm));
  end else
  begin
    dec(longInt(ErrorR0), sizeof(TErrorTerm));
    dec(longInt(ErrorG0), sizeof(TErrorTerm));
    dec(longInt(ErrorB0), sizeof(TErrorTerm));
    dec(longInt(ErrorR1), sizeof(TErrorTerm));
    dec(longInt(ErrorG1), sizeof(TErrorTerm));
    dec(longInt(ErrorB1), sizeof(TErrorTerm));
    dec(longInt(ErrorR2), sizeof(TErrorTerm));
    dec(longInt(ErrorG2), sizeof(TErrorTerm));
    dec(longInt(ErrorB2), sizeof(TErrorTerm));
  end;
end;

procedure T5by3Ditherer.NextLine;
var
  TempErrors		: PErrors;
begin
  FillChar(ErrorsR0^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsG0^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsB0^, sizeof(TErrorTerm)*(Width+4), 0);

  TempErrors := ErrorsR0;
  ErrorsR0 := ErrorsR1;
  ErrorsR1 := ErrorsR2;
  ErrorsR2 := TempErrors;

  TempErrors := ErrorsG0;
  ErrorsG0 := ErrorsG1;
  ErrorsG1 := ErrorsG2;
  ErrorsG2 := TempErrors;

  TempErrors := ErrorsB0;
  ErrorsB0 := ErrorsB1;
  ErrorsB1 := ErrorsB2;
  ErrorsB2 := TempErrors;

  inherited NextLine;

  FDirection2 := 2 * Direction;
  if (Direction = 1) then
  begin
    ErrorR0 := PErrors(longInt(ErrorsR0)+2*sizeof(TErrorTerm));
    ErrorG0 := PErrors(longInt(ErrorsG0)+2*sizeof(TErrorTerm));
    ErrorB0 := PErrors(longInt(ErrorsB0)+2*sizeof(TErrorTerm));
    ErrorR1 := PErrors(longInt(ErrorsR1)+2*sizeof(TErrorTerm));
    ErrorG1 := PErrors(longInt(ErrorsG1)+2*sizeof(TErrorTerm));
    ErrorB1 := PErrors(longInt(ErrorsB1)+2*sizeof(TErrorTerm));
    ErrorR2 := PErrors(longInt(ErrorsR2)+2*sizeof(TErrorTerm));
    ErrorG2 := PErrors(longInt(ErrorsG2)+2*sizeof(TErrorTerm));
    ErrorB2 := PErrors(longInt(ErrorsB2)+2*sizeof(TErrorTerm));
  end else
  begin
    ErrorR0 := @ErrorsR0[Width+1];
    ErrorG0 := @ErrorsG0[Width+1];
    ErrorB0 := @ErrorsB0[Width+1];
    ErrorR1 := @ErrorsR1[Width+1];
    ErrorG1 := @ErrorsG1[Width+1];
    ErrorB1 := @ErrorsB1[Width+1];
    ErrorR2 := @ErrorsR2[Width+1];
    ErrorG2 := @ErrorsG2[Width+1];
    ErrorB2 := @ErrorsB2[Width+1];
  end;
end;

constructor TStuckiDitherer.Create(AWidth: integer; Lookup: TColorLookup);
begin
  inherited Create(AWidth, Lookup);
  FDivisor := 42;
end;

procedure TStuckiDitherer.Propagate(Errors0, Errors1, Errors2: PErrors; Error: integer);
begin
  if (Error = 0) then
    exit;

  inc(Errors2[FDirection2], Error);
  inc(Errors2[-FDirection2], Error);

  Error := Error + Error;
  inc(Errors1[FDirection2], Error);
  inc(Errors1[-FDirection2], Error);
  inc(Errors2[Direction], Error);
  inc(Errors2[-Direction], Error);

  Error := Error + Error;
  inc(Errors0[FDirection2], Error);
  inc(Errors1[-Direction], Error);
  inc(Errors1[Direction], Error);
  inc(Errors2[0], Error);

  Error := Error + Error;
  inc(Errors0[Direction], Error);
  inc(Errors1[0], Error);
end;

constructor TSierraDitherer.Create(AWidth: integer; Lookup: TColorLookup);
begin
  inherited Create(AWidth, Lookup);
  FDivisor := 32;
end;

procedure TSierraDitherer.Propagate(Errors0, Errors1, Errors2: PErrors; Error: integer);
var
  TempError		: integer;
begin
  if (Error = 0) then
    exit;

  TempError := Error + Error;
  inc(Errors1[FDirection2], TempError);
  inc(Errors1[-FDirection2], TempError);
  inc(Errors2[Direction], TempError);
  inc(Errors2[-Direction], TempError);

  inc(TempError, Error);
  inc(Errors0[FDirection2], TempError);
  inc(Errors2[0], TempError);

  inc(TempError, Error);
  inc(Errors1[-Direction], TempError);
  inc(Errors1[Direction], TempError);

  inc(TempError, Error);
  inc(Errors0[Direction], TempError);
  inc(Errors1[0], TempError);
end;

constructor TJaJuNiDitherer.Create(AWidth: integer; Lookup: TColorLookup);
begin
  inherited Create(AWidth, Lookup);
  FDivisor := 38;
end;

procedure TJaJuNiDitherer.Propagate(Errors0, Errors1, Errors2: PErrors; Error: integer);
var
  TempError		: integer;
begin
  if (Error = 0) then
    exit;
  inc(Errors2[FDirection2], Error);
  inc(Errors2[-FDirection2], Error);

  TempError := Error + Error;
  inc(Error, TempError);
  inc(Errors1[FDirection2], Error);	
  inc(Errors1[-FDirection2], Error);
  inc(Errors2[Direction], Error);
  inc(Errors2[-Direction], Error);

  inc(Error, TempError);
  inc(Errors0[FDirection2], Error);
  inc(Errors1[-Direction], Error);
  inc(Errors1[Direction], Error);
  inc(Errors2[0], Error);

  inc(Error, TempError);
  inc(Errors0[Direction], Error);
  inc(Errors1[0], Error);
end;

constructor TSteveArcheDitherer.Create(AWidth: integer; Lookup: TColorLookup);
begin
  inherited Create(AWidth, Lookup);

  GetMem(ErrorsR0, sizeof(TErrorTerm)*(Width+6));
  GetMem(ErrorsG0, sizeof(TErrorTerm)*(Width+6));
  GetMem(ErrorsB0, sizeof(TErrorTerm)*(Width+6));
  GetMem(ErrorsR1, sizeof(TErrorTerm)*(Width+6));
  GetMem(ErrorsG1, sizeof(TErrorTerm)*(Width+6));
  GetMem(ErrorsB1, sizeof(TErrorTerm)*(Width+6));
  GetMem(ErrorsR2, sizeof(TErrorTerm)*(Width+6));
  GetMem(ErrorsG2, sizeof(TErrorTerm)*(Width+6));
  GetMem(ErrorsB2, sizeof(TErrorTerm)*(Width+6));
  GetMem(ErrorsR3, sizeof(TErrorTerm)*(Width+6));
  GetMem(ErrorsG3, sizeof(TErrorTerm)*(Width+6));
  GetMem(ErrorsB3, sizeof(TErrorTerm)*(Width+6));
  FillChar(ErrorsR0^, sizeof(TErrorTerm)*(Width+6), 0);
  FillChar(ErrorsG0^, sizeof(TErrorTerm)*(Width+6), 0);
  FillChar(ErrorsB0^, sizeof(TErrorTerm)*(Width+6), 0);
  FillChar(ErrorsR1^, sizeof(TErrorTerm)*(Width+6), 0);
  FillChar(ErrorsG1^, sizeof(TErrorTerm)*(Width+6), 0);
  FillChar(ErrorsB1^, sizeof(TErrorTerm)*(Width+6), 0);
  FillChar(ErrorsR2^, sizeof(TErrorTerm)*(Width+6), 0);
  FillChar(ErrorsG2^, sizeof(TErrorTerm)*(Width+6), 0);
  FillChar(ErrorsB2^, sizeof(TErrorTerm)*(Width+6), 0);
  FillChar(ErrorsR3^, sizeof(TErrorTerm)*(Width+6), 0);
  FillChar(ErrorsG3^, sizeof(TErrorTerm)*(Width+6), 0);
  FillChar(ErrorsB3^, sizeof(TErrorTerm)*(Width+6), 0);

  FDirection2 := 2 * Direction;
  FDirection3 := 3 * Direction;

  ErrorR0 := PErrors(longInt(ErrorsR0)+3*sizeof(TErrorTerm));
  ErrorG0 := PErrors(longInt(ErrorsG0)+3*sizeof(TErrorTerm));
  ErrorB0 := PErrors(longInt(ErrorsB0)+3*sizeof(TErrorTerm));
  ErrorR1 := PErrors(longInt(ErrorsR1)+3*sizeof(TErrorTerm));
  ErrorG1 := PErrors(longInt(ErrorsG1)+3*sizeof(TErrorTerm));
  ErrorB1 := PErrors(longInt(ErrorsB1)+3*sizeof(TErrorTerm));
  ErrorR2 := PErrors(longInt(ErrorsR2)+3*sizeof(TErrorTerm));
  ErrorG2 := PErrors(longInt(ErrorsG2)+3*sizeof(TErrorTerm));
  ErrorB2 := PErrors(longInt(ErrorsB2)+3*sizeof(TErrorTerm));
  ErrorR3 := PErrors(longInt(ErrorsR3)+3*sizeof(TErrorTerm));
  ErrorG3 := PErrors(longInt(ErrorsG3)+3*sizeof(TErrorTerm));
  ErrorB3 := PErrors(longInt(ErrorsB3)+3*sizeof(TErrorTerm));
end;

destructor TSteveArcheDitherer.Destroy;
begin
  FreeMem(ErrorsR0);
  FreeMem(ErrorsG0);
  FreeMem(ErrorsB0);
  FreeMem(ErrorsR1);
  FreeMem(ErrorsG1);
  FreeMem(ErrorsB1);
  FreeMem(ErrorsR2);
  FreeMem(ErrorsG2);
  FreeMem(ErrorsB2);
  FreeMem(ErrorsR3);
  FreeMem(ErrorsG3);
  FreeMem(ErrorsB3);
  inherited Destroy;
end;

function TSteveArcheDitherer.Dither(Red, Green, Blue: BYTE; var R, G, B: BYTE): char;
var
  ColorR		,
  ColorG		,
  ColorB		: integer;

  procedure Propagate(Errors0, Errors1, Errors2, Errors3: PErrors; Error: integer);
  var
    TempError		: integer;
  begin
    if (Error = 0) then
      exit;
    TempError := 5 * Error;
    inc(Errors3[FDirection3], TempError);
    inc(Errors3[-FDirection3], TempError);

    TempError := 12 * Error;
    inc(Errors1[-FDirection3], TempError);
    inc(Errors2[-FDirection2], TempError);
    inc(Errors2[FDirection2], TempError);
    inc(Errors3[-Direction], TempError);
    inc(Errors3[Direction], TempError);

    inc(Errors1[FDirection3], 16 * TempError);

    TempError := 26 * Error;
    inc(Errors1[-Direction], TempError);
    inc(Errors2[0], TempError);

    inc(Errors1[Direction], 30 * Error);

    inc(Errors0[FDirection2], 32 * Error);
  end;

begin
  ColorR := Red + (ErrorR0[0] + 100) DIV 200;
  if (ColorR < 0) then
    ColorR := 0
  else if (ColorR > 255) then
    ColorR := 255;

  ColorG := Green + (ErrorG0[0] + 100) DIV 200;
  if (ColorG < 0) then
    ColorG := 0
  else if (ColorG > 255) then
    ColorG := 255;

  ColorB := Blue + (ErrorB0[0] + 100) DIV 200;
  if (ColorB < 0) then
    ColorB := 0
  else if (ColorB > 255) then
    ColorB := 255;

  Result := inherited Dither(ColorR, ColorG, ColorB, R, G, B);

  Propagate(ErrorR0, ErrorR1, ErrorR2, ErrorR3, ColorR - R);
  Propagate(ErrorG0, ErrorG1, ErrorG2, ErrorG3, ColorG - G);
  Propagate(ErrorB0, ErrorB1, ErrorB2, ErrorB3, ColorB - B);

  if (Direction = 1) then
  begin
    inc(longInt(ErrorR0), sizeof(TErrorTerm));
    inc(longInt(ErrorG0), sizeof(TErrorTerm));
    inc(longInt(ErrorB0), sizeof(TErrorTerm));
    inc(longInt(ErrorR1), sizeof(TErrorTerm));
    inc(longInt(ErrorG1), sizeof(TErrorTerm));
    inc(longInt(ErrorB1), sizeof(TErrorTerm));
    inc(longInt(ErrorR2), sizeof(TErrorTerm));
    inc(longInt(ErrorG2), sizeof(TErrorTerm));
    inc(longInt(ErrorB2), sizeof(TErrorTerm));
    inc(longInt(ErrorR3), sizeof(TErrorTerm));
    inc(longInt(ErrorG3), sizeof(TErrorTerm));
    inc(longInt(ErrorB3), sizeof(TErrorTerm));
  end else
  begin
    dec(longInt(ErrorR0), sizeof(TErrorTerm));
    dec(longInt(ErrorG0), sizeof(TErrorTerm));
    dec(longInt(ErrorB0), sizeof(TErrorTerm));
    dec(longInt(ErrorR1), sizeof(TErrorTerm));
    dec(longInt(ErrorG1), sizeof(TErrorTerm));
    dec(longInt(ErrorB1), sizeof(TErrorTerm));
    dec(longInt(ErrorR2), sizeof(TErrorTerm));
    dec(longInt(ErrorG2), sizeof(TErrorTerm));
    dec(longInt(ErrorB2), sizeof(TErrorTerm));
    dec(longInt(ErrorR3), sizeof(TErrorTerm));
    dec(longInt(ErrorG3), sizeof(TErrorTerm));
    dec(longInt(ErrorB3), sizeof(TErrorTerm));
  end;
end;

procedure TSteveArcheDitherer.NextLine;
var
  TempErrors		: PErrors;
begin
  FillChar(ErrorsR0^, sizeof(TErrorTerm)*(Width+6), 0);
  FillChar(ErrorsG0^, sizeof(TErrorTerm)*(Width+6), 0);
  FillChar(ErrorsB0^, sizeof(TErrorTerm)*(Width+6), 0);

  TempErrors := ErrorsR0;
  ErrorsR0 := ErrorsR1;
  ErrorsR1 := ErrorsR2;
  ErrorsR2 := ErrorsR3;
  ErrorsR3 := TempErrors;

  TempErrors := ErrorsG0;
  ErrorsG0 := ErrorsG1;
  ErrorsG1 := ErrorsG2;
  ErrorsG2 := ErrorsG3;
  ErrorsG3 := TempErrors;

  TempErrors := ErrorsB0;
  ErrorsB0 := ErrorsB1;
  ErrorsB1 := ErrorsB2;
  ErrorsB2 := ErrorsB3;
  ErrorsB3 := TempErrors;

  inherited NextLine;

  FDirection2 := 2 * Direction;
  FDirection3 := 3 * Direction;

  if (Direction = 1) then
  begin
    ErrorR0 := PErrors(longInt(ErrorsR0)+3*sizeof(TErrorTerm));
    ErrorG0 := PErrors(longInt(ErrorsG0)+3*sizeof(TErrorTerm));
    ErrorB0 := PErrors(longInt(ErrorsB0)+3*sizeof(TErrorTerm));
    ErrorR1 := PErrors(longInt(ErrorsR1)+3*sizeof(TErrorTerm));
    ErrorG1 := PErrors(longInt(ErrorsG1)+3*sizeof(TErrorTerm));
    ErrorB1 := PErrors(longInt(ErrorsB1)+3*sizeof(TErrorTerm));
    ErrorR2 := PErrors(longInt(ErrorsR2)+3*sizeof(TErrorTerm));
    ErrorG2 := PErrors(longInt(ErrorsG2)+3*sizeof(TErrorTerm));
    ErrorB2 := PErrors(longInt(ErrorsB2)+3*sizeof(TErrorTerm));
    ErrorR3 := PErrors(longInt(ErrorsR3)+3*sizeof(TErrorTerm));
    ErrorG3 := PErrors(longInt(ErrorsG3)+3*sizeof(TErrorTerm));
    ErrorB3 := PErrors(longInt(ErrorsB3)+3*sizeof(TErrorTerm));
  end else
  begin
    ErrorR0 := @ErrorsR0[Width+2];
    ErrorG0 := @ErrorsG0[Width+2];
    ErrorB0 := @ErrorsB0[Width+2];
    ErrorR1 := @ErrorsR1[Width+2];
    ErrorG1 := @ErrorsG1[Width+2];
    ErrorB1 := @ErrorsB1[Width+2];
    ErrorR2 := @ErrorsR2[Width+2];
    ErrorG2 := @ErrorsG2[Width+2];
    ErrorB2 := @ErrorsB2[Width+2];
    ErrorR3 := @ErrorsR2[Width+2];
    ErrorG3 := @ErrorsG2[Width+2];
    ErrorB3 := @ErrorsB2[Width+2];
  end;
end;

constructor TBurkesDitherer.Create(AWidth: integer; Lookup: TColorLookup);
begin
  inherited Create(AWidth, Lookup);

  GetMem(ErrorsR0, sizeof(TErrorTerm)*(Width+4));
  GetMem(ErrorsG0, sizeof(TErrorTerm)*(Width+4));
  GetMem(ErrorsB0, sizeof(TErrorTerm)*(Width+4));
  GetMem(ErrorsR1, sizeof(TErrorTerm)*(Width+4));
  GetMem(ErrorsG1, sizeof(TErrorTerm)*(Width+4));
  GetMem(ErrorsB1, sizeof(TErrorTerm)*(Width+4));
  FillChar(ErrorsR0^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsG0^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsB0^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsR1^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsG1^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsB1^, sizeof(TErrorTerm)*(Width+4), 0);

  FDirection2 := 2 * Direction;
  ErrorR0 := PErrors(longInt(ErrorsR0)+2*sizeof(TErrorTerm));
  ErrorG0 := PErrors(longInt(ErrorsG0)+2*sizeof(TErrorTerm));
  ErrorB0 := PErrors(longInt(ErrorsB0)+2*sizeof(TErrorTerm));
  ErrorR1 := PErrors(longInt(ErrorsR1)+2*sizeof(TErrorTerm));
  ErrorG1 := PErrors(longInt(ErrorsG1)+2*sizeof(TErrorTerm));
  ErrorB1 := PErrors(longInt(ErrorsB1)+2*sizeof(TErrorTerm));
end;

destructor TBurkesDitherer.Destroy;
begin
  FreeMem(ErrorsR0);
  FreeMem(ErrorsG0);
  FreeMem(ErrorsB0);
  FreeMem(ErrorsR1);
  FreeMem(ErrorsG1);
  FreeMem(ErrorsB1);
  inherited Destroy;
end;

function TBurkesDitherer.Dither(Red, Green, Blue: BYTE; var R, G, B: BYTE): char;
var
  ErrorR		,
  ErrorG		,
  ErrorB		: integer; 

  procedure Propagate(Errors0, Errors1: PErrors; Error: integer);
  begin
    if (Error = 0) then
      exit;
    inc(Error, Error);
    inc(Errors1[FDirection2], Error);
    inc(Errors1[-FDirection2], Error);

    inc(Error, Error);
    inc(Errors0[FDirection2], Error);
    inc(Errors1[-Direction], Error);
    inc(Errors1[Direction], Error);

    inc(Error, Error);
    inc(Errors0[Direction], Error);
    inc(Errors1[0], Error);
  end;

begin
  ErrorR := Red + (ErrorR0[0] + 16) DIV 32;
  if (ErrorR < 0) then
    ErrorR := 0
  else if (ErrorR > 255) then
    ErrorR := 255;

  ErrorG := Green + (ErrorG0[0] + 16) DIV 32;
  if (ErrorG < 0) then
    ErrorG := 0
  else if (ErrorG > 255) then
    ErrorG := 255;

  ErrorB := Blue + (ErrorB0[0] + 16) DIV 32;
  if (ErrorB < 0) then
    ErrorB := 0
  else if (ErrorB > 255) then
    ErrorB := 255;

  Result := inherited Dither(ErrorR, ErrorG, ErrorB, R, G, B);

  Propagate(ErrorR0, ErrorR1, ErrorR - R);
  Propagate(ErrorG0, ErrorG1, ErrorG - G);
  Propagate(ErrorB0, ErrorB1, ErrorB - B);

  if (Direction = 1) then
  begin
    inc(longInt(ErrorR0), sizeof(TErrorTerm));
    inc(longInt(ErrorG0), sizeof(TErrorTerm));
    inc(longInt(ErrorB0), sizeof(TErrorTerm));
    inc(longInt(ErrorR1), sizeof(TErrorTerm));
    inc(longInt(ErrorG1), sizeof(TErrorTerm));
    inc(longInt(ErrorB1), sizeof(TErrorTerm));
  end else
  begin
    dec(longInt(ErrorR0), sizeof(TErrorTerm));
    dec(longInt(ErrorG0), sizeof(TErrorTerm));
    dec(longInt(ErrorB0), sizeof(TErrorTerm));
    dec(longInt(ErrorR1), sizeof(TErrorTerm));
    dec(longInt(ErrorG1), sizeof(TErrorTerm));
    dec(longInt(ErrorB1), sizeof(TErrorTerm));
  end;
end;

procedure TBurkesDitherer.NextLine;
var
  TempErrors		: PErrors;
begin
  FillChar(ErrorsR0^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsG0^, sizeof(TErrorTerm)*(Width+4), 0);
  FillChar(ErrorsB0^, sizeof(TErrorTerm)*(Width+4), 0);

  TempErrors := ErrorsR0;
  ErrorsR0 := ErrorsR1;
  ErrorsR1 := TempErrors;

  TempErrors := ErrorsG0;
  ErrorsG0 := ErrorsG1;
  ErrorsG1 := TempErrors;

  TempErrors := ErrorsB0;
  ErrorsB0 := ErrorsB1;
  ErrorsB1 := TempErrors;

  inherited NextLine;

  FDirection2 := 2 * Direction;
  if (Direction = 1) then
  begin
    ErrorR0 := PErrors(longInt(ErrorsR0)+2*sizeof(TErrorTerm));
    ErrorG0 := PErrors(longInt(ErrorsG0)+2*sizeof(TErrorTerm));
    ErrorB0 := PErrors(longInt(ErrorsB0)+2*sizeof(TErrorTerm));
    ErrorR1 := PErrors(longInt(ErrorsR1)+2*sizeof(TErrorTerm));
    ErrorG1 := PErrors(longInt(ErrorsG1)+2*sizeof(TErrorTerm));
    ErrorB1 := PErrors(longInt(ErrorsB1)+2*sizeof(TErrorTerm));
  end else
  begin
    ErrorR0 := @ErrorsR0[Width+1];
    ErrorG0 := @ErrorsG0[Width+1];
    ErrorB0 := @ErrorsB0[Width+1];
    ErrorR1 := @ErrorsR1[Width+1];
    ErrorG1 := @ErrorsG1[Width+1];
    ErrorB1 := @ErrorsB1[Width+1];
  end;
end;

type
  TOctreeNode = class;

  TReducibleNodes = array[0..7] of TOctreeNode;

  TOctreeNode = Class(TObject)
  public
    IsLeaf		: Boolean;
    PixelCount		: integer;
    RedSum		: integer;
    GreenSum		: integer;
    BlueSum		: integer;
    Next		: TOctreeNode;
    Child		: TReducibleNodes;

    constructor Create(Level: integer; ColorBits: integer; var LeafCount: integer;
      var ReducibleNodes: TReducibleNodes);
    destructor Destroy; override;
  end;

  TColorQuantizer = class(TObject)
  private
    FTree		: TOctreeNode;
    FLeafCount		: integer;
    FReducibleNodes	: TReducibleNodes;
    FMaxColors		: integer;
    FColorBits		: integer;

  protected
    procedure AddColor(var Node: TOctreeNode; r, g, b: byte; ColorBits: integer;
      Level: integer; var LeafCount: integer; var ReducibleNodes: TReducibleNodes);
    procedure DeleteTree(var Node: TOctreeNode);
    procedure GetPaletteColors(const Node: TOctreeNode;
      var RGBQuadArray: TRGBQuadArray; var Index: integer);
    procedure ReduceTree(ColorBits: integer; var LeafCount: integer;
      var ReducibleNodes: TReducibleNodes);

  public
    constructor Create(MaxColors: integer; ColorBits: integer);
    destructor Destroy; override;

    procedure GetColorTable(var RGBQuadArray: TRGBQuadArray);
    function ProcessImage(const DIB: TDIBReader): boolean;

    property ColorCount: integer read FLeafCount;
  end;

constructor TOctreeNode.Create(Level: integer; ColorBits: integer;
  var LeafCount: integer; var ReducibleNodes: TReducibleNodes);
var
  i			: integer;
begin
  PixelCount := 0;
  RedSum := 0;
  GreenSum := 0;
  BlueSum := 0;
  for i := Low(Child) to High(Child) do
    Child[i] := nil;

  IsLeaf := (Level = ColorBits);
  if (IsLeaf) then
  begin
    Next := nil;
    inc(LeafCount);
  end else
  begin
    Next := ReducibleNodes[Level];
    ReducibleNodes[Level] := self;
  end;
end;

destructor TOctreeNode.Destroy;
var
  i			: integer;
begin
  for i := High(Child) downto Low(Child) do
    Child[i].Free;
end;

constructor TColorQuantizer.Create(MaxColors: integer; ColorBits: integer);
var
  i			: integer;
begin
  ASSERT(ColorBits <= 8, 'ColorBits must be 8 or less');

  FTree := nil;
  FLeafCount := 0;

  for i := Low(FReducibleNodes) to High(FReducibleNodes) do
    FReducibleNodes[i] := nil;

  FMaxColors := MaxColors;
  FColorBits := ColorBits;
end;

destructor TColorQuantizer.Destroy;
begin
  if (FTree <> nil) then
    DeleteTree(FTree);
end;

procedure TColorQuantizer.GetColorTable(var RGBQuadArray: TRGBQuadArray);
var
  Index			: integer;
begin
  Index := 0;
  GetPaletteColors(FTree, RGBQuadArray, Index);
end;

function TColorQuantizer.ProcessImage(const DIB: TDIBReader): boolean;
var
  i			,
  j			: integer;
  ScanLine		: pointer;
  Pixel			: PRGBTriple;
begin
  Result := True;

  for j := 0 to DIB.Bitmap.Height-1 do
  begin
    Scanline := DIB.Scanline[j];
    Pixel := ScanLine;
    for i := 0 to DIB.Bitmap.Width-1 do
    begin
      with Pixel^ do
        AddColor(FTree, rgbtRed, rgbtGreen, rgbtBlue,
                 FColorBits, 0, FLeafCount, FReducibleNodes);

      while FLeafCount > FMaxColors do
        ReduceTree(FColorbits, FLeafCount, FReducibleNodes);
      inc(Pixel);
    end;
  end;
end;

procedure TColorQuantizer.AddColor(var Node: TOctreeNode; r,g,b: byte;
  ColorBits: integer; Level: integer; var LeafCount: integer;
  var ReducibleNodes: TReducibleNodes);
const
  Mask:  array[0..7] of BYTE = ($80, $40, $20, $10, $08, $04, $02, $01);
var
  Index			: integer;
  Shift			: integer;
begin
  if (Node = nil) then
    Node := TOctreeNode.Create(Level, ColorBits, LeafCount, ReducibleNodes);

  if (Node.IsLeaf) then
  begin
    inc(Node.PixelCount);
    inc(Node.RedSum, r);
    inc(Node.GreenSum, g);
    inc(Node.BlueSum, b);
  end else
  begin
    Shift := 7 - Level;

    Index := (((r and mask[Level]) SHR Shift) SHL 2)  or
             (((g and mask[Level]) SHR Shift) SHL 1)  or
              ((b and mask[Level]) SHR Shift);
    AddColor(Node.Child[Index], r, g, b, ColorBits, Level+1, LeafCount, ReducibleNodes);
  end;
end;

procedure TColorQuantizer.DeleteTree(var Node: TOctreeNode);
var
  i			: integer;
begin
  for i := High(TReducibleNodes) downto Low(TReducibleNodes) do
    if (Node.Child[i] <> nil) then
      DeleteTree(Node.Child[i]);

  Node.Free;
  Node := nil;
end;

procedure TColorQuantizer.GetPaletteColors(const Node: TOctreeNode;
  var RGBQuadArray: TRGBQuadArray; var Index: integer);
var
  i			: integer;
begin
  if (Node.IsLeaf) then
  begin
    with RGBQuadArray[Index] do
    begin
      if (Node.PixelCount <> 0) then
      begin
        rgbRed   := BYTE(Node.RedSum   DIV Node.PixelCount);
        rgbGreen := BYTE(Node.GreenSum DIV Node.PixelCount);
        rgbBlue  := BYTE(Node.BlueSum  DIV Node.PixelCount);
      end else
      begin
        rgbRed := 0;
        rgbGreen := 0;
        rgbBlue := 0;
      end;
      rgbReserved := 0;
    end;
    inc(Index);
  end else
  begin
    for i := Low(Node.Child) to High(Node.Child) do
      if (Node.Child[i] <> nil) then
        GetPaletteColors(Node.Child[i], RGBQuadArray, Index);
  end;
end;

procedure TColorQuantizer.ReduceTree(ColorBits: integer; var LeafCount: integer;
  var ReducibleNodes: TReducibleNodes);
var
  RedSum		,
  GreenSum		,
  BlueSum 		: integer;
  Children		: integer;
  i			: integer;
  Node			: TOctreeNode;
begin
  i := Colorbits - 1;
  while (i > 0) and (ReducibleNodes[i] = nil) do
    dec(i);

  Node := ReducibleNodes[i];
  ReducibleNodes[i] := Node.Next;

  RedSum   := 0;
  GreenSum := 0;
  BlueSum  := 0;
  Children := 0;

  for i := Low(ReducibleNodes) to High(ReducibleNodes) do
    if (Node.Child[i] <> nil) then
    begin
      inc(RedSum, Node.Child[i].RedSum);
      inc(GreenSum, Node.Child[i].GreenSum);
      inc(BlueSum, Node.Child[i].BlueSum);
      inc(Node.PixelCount, Node.Child[i].PixelCount);
      Node.Child[i].Free;
      Node.Child[i] := nil;
      inc(Children);
    end;

  Node.IsLeaf := TRUE;
  Node.RedSum := RedSum;
  Node.GreenSum := GreenSum;
  Node.BlueSum := BlueSum;
  dec(LeafCount, Children-1);
end;

function doCreateOptimizedPaletteFromSingleBitmap(const DIB: TDIBReader;
  Colors, ColorBits: integer; Windows: boolean): hPalette;
var
  SystemPalette		: HPalette;
  ColorQuantizer	: TColorQuantizer;
  i			: integer;
  LogicalPalette	: TMaxLogPalette;
  RGBQuadArray		: TRGBQuadArray;
  Offset		: integer;
begin
  LogicalPalette.palVersion := $0300;
  LogicalPalette.palNumEntries := Colors;

  if (Windows) then
  begin
    SystemPalette := GetStockObject(DEFAULT_PALETTE);
    GetPaletteEntries(SystemPalette, 0, 10, LogicalPalette.palPalEntry[0]);
    GetPaletteEntries(SystemPalette, 10, 10, LogicalPalette.palPalEntry[245]);
    Colors := 236;
    Offset := 10;
    LogicalPalette.palNumEntries := 256;
  end else
    Offset := 0;

  ColorQuantizer := TColorQuantizer.Create(Colors, ColorBits);
  try
    ColorQuantizer.ProcessImage(DIB);
    ColorQuantizer.GetColorTable(RGBQuadArray);
  finally
    ColorQuantizer.Free;
  end;

  for i := 0 to Colors-1 do
    with LogicalPalette.palPalEntry[i+Offset] do
    begin
      peRed   := RGBQuadArray[i].rgbRed;
      peGreen := RGBQuadArray[i].rgbGreen;
      peBlue  := RGBQuadArray[i].rgbBlue;
      peFlags := RGBQuadArray[i].rgbReserved;
    end;
  Result := CreatePalette(pLogPalette(@LogicalPalette)^);
end;

function CreateOptimizedPaletteFromSingleBitmap(const Bitmap: TBitmap;
  Colors, ColorBits: integer; Windows: boolean): hPalette;
var
  DIB			: TDIBReader;
begin
  DIB := TDIBReader.Create(Bitmap, pf24bit);
  try
    Result := doCreateOptimizedPaletteFromSingleBitmap(DIB, Colors, ColorBits, Windows);
  finally
    DIB.Free;
  end;
end;

function ReduceColors(Bitmap: TBitmap; ColorReduction: TColorReduction;
  DitherMode: TDitherMode; ReductionBits: integer; CustomPalette: hPalette): TBitmap;
var
  Palette		: hPalette;
  ColorLookup		: TColorLookup;
  Ditherer		: TDitherEngine;
  Row			: Integer;
  DIBResult		: TDIBWriter;
  DIBSource		: TDIBReader;
  SrcScanLine		,
  Src			: PRGBTriple;
  DstScanLine		,
  Dst			: PChar;
  BGR			: TRGBTriple;

  function GrayScalePalette: hPalette;
  var
    i			: integer;
    Pal			: TMaxLogPalette;
  begin
    Pal.palVersion := $0300;
    Pal.palNumEntries := 256;
    for i := 0 to 255 do
    begin
      with (Pal.palPalEntry[i]) do
      begin
        peRed := i;
        peGreen := i;
        peBlue  := i;
        peFlags := PC_NOCOLLAPSE;
      end;
    end;
    Result := CreatePalette(pLogPalette(@Pal)^);
  end;

  function MonochromePalette: hPalette;
  var
    i			: integer;
    Pal			: TMaxLogPalette;
  const
    Values		: array[0..1] of byte
    			= (0, 255);
  begin
    Pal.palVersion := $0300;
    Pal.palNumEntries := 2;
    for i := 0 to 1 do
    begin
      with (Pal.palPalEntry[i]) do
      begin
        peRed := Values[i];
        peGreen := Values[i];
        peBlue  := Values[i];
        peFlags := PC_NOCOLLAPSE;
      end;
    end;
    Result := CreatePalette(pLogPalette(@Pal)^);
  end;

  function WindowsGrayScalePalette: hPalette;
  var
    i			: integer;
    Pal			: TMaxLogPalette;
  const
    Values		: array[0..3] of byte
    			= (0, 128, 192, 255);
  begin
    Pal.palVersion := $0300;
    Pal.palNumEntries := 4;
    for i := 0 to 3 do
    begin
      with (Pal.palPalEntry[i]) do
      begin
        peRed := Values[i];
        peGreen := Values[i];
        peBlue  := Values[i];
        peFlags := PC_NOCOLLAPSE;
      end;
    end;
    Result := CreatePalette(pLogPalette(@Pal)^);
  end;

  function WindowsHalftonePalette: hPalette;
  var
    DC			: HDC;
  begin
    DC := GDICheck(GetDC(0));
    try
      Result := CreateHalfTonePalette(DC);
    finally
      ReleaseDC(0, DC);
    end;
  end;

begin

  Result := TBitmap.Create;
  try

    if (ColorReduction = rmNone) then
    begin
      Result.Assign(Bitmap);
      SetPixelFormat(Result, pf24bit);
      exit;
    end;

    if (Bitmap.Width*Bitmap.Height > BitmapAllocationThreshold) then
      SetPixelFormat(Result, pf1bit);

    ColorLookup := nil;
    Ditherer := nil;
    DIBResult := nil;
    DIBSource := nil;
    Palette := 0;
    try

      DIBSource := TDIBReader.Create(Bitmap, pf24bit);

      case (ColorReduction) of
        rmQuantize:
          Palette := doCreateOptimizedPaletteFromSingleBitmap(DIBSource, 1 SHL ReductionBits, 8, False);
        rmQuantizeWindows:
          Palette := CreateOptimizedPaletteFromSingleBitmap(Bitmap, 256, 8, True);
        rmNetscape:
          Palette := WebPalette;
        rmGrayScale:
          Palette := GrayScalePalette;
        rmMonochrome:
          Palette := MonochromePalette;
        rmWindowsGray:
          Palette := WindowsGrayScalePalette;
        rmWindows20:
          Palette := GetStockObject(DEFAULT_PALETTE);
        rmWindows256:
          Palette := WindowsHalftonePalette;
        rmPalette:
          Palette := CopyPalette(CustomPalette);
      else
        exit;
      end;

      case (ColorReduction) of
        rmQuantize:
          ColorLookup := TFastColorLookup.Create(Palette);
        rmNetscape:
          ColorLookup := TNetscapeColorLookup.Create(Palette);
        rmGrayScale:
          ColorLookup := TGrayScaleLookup.Create(Palette);
        rmMonochrome:
          ColorLookup := TMonochromeLookup.Create(Palette);
      else
        ColorLookup := TFastColorLookup.Create(Palette);
      end;

      if (ColorLookup.Colors = 0) then
        exit;

      case (DitherMode) of
        dmNearest:
          Ditherer := TDitherEngine.Create(Bitmap.Width, ColorLookup);
        dmFloydSteinberg:
          Ditherer := TFloydSteinbergDitherer.Create(Bitmap.Width, ColorLookup);
        dmStucki:
          Ditherer := TStuckiDitherer.Create(Bitmap.Width, ColorLookup);
        dmSierra:
          Ditherer := TSierraDitherer.Create(Bitmap.Width, ColorLookup);
        dmJaJuNI:
          Ditherer := TJaJuNIDitherer.Create(Bitmap.Width, ColorLookup);
        dmSteveArche:
          Ditherer := TSteveArcheDitherer.Create(Bitmap.Width, ColorLookup);
        dmBurkes:
          Ditherer := TBurkesDitherer.Create(Bitmap.Width, ColorLookup);
      else
        exit;
      end;

      DIBResult := TDIBWriter.Create(Result, pf8bit, Bitmap.Width, Bitmap.Height,
        Palette);

      Row := 0;
      while (Row < Bitmap.Height) do
      begin
        SrcScanline := DIBSource.ScanLine[Row];
        DstScanline := DIBResult.ScanLine[Row];
        Src := pointer(longInt(SrcScanLine) + Ditherer.Column*sizeof(TRGBTriple));
        Dst := pointer(longInt(DstScanLine) + Ditherer.Column);

        while (Ditherer.Column < Ditherer.Width) and (Ditherer.Column >= 0) do
        begin
          BGR := Src^;
          Dst^ := Ditherer.Dither(BGR.rgbtRed, BGR.rgbtGreen, BGR.rgbtBlue,
            BGR.rgbtRed, BGR.rgbtGreen, BGR.rgbtBlue);

          inc(Src, Ditherer.Direction);
          inc(Dst, Ditherer.Direction);
        end;

        Inc(Row);
        Ditherer.NextLine;
      end;
    finally
      if (ColorLookup <> nil) then
        ColorLookup.Free;
      if (Ditherer <> nil) then
        Ditherer.Free;
      if (DIBResult <> nil) then
        DIBResult.Free;
      if (DIBSource <> nil) then
        DIBSource.Free;
      if (Palette <> 0) then
        DeleteObject(Palette);
    end;
  except
    Result.Free;
    raise;
  end;
end;

end.
