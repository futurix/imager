{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnIcoGr
|
| Description: TDibGraphic descendant for ICO files.
|
| History: Dec 24, 1998. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnIcoGr;

{$I Envision.Inc}

interface

uses
    Classes,  { for TStream }
    EnDiGrph; { for TDibGraphic }

type

TIconGraphic = class(TDibGraphic)
protected
    FBackgroundColor : TRgb;

public
    constructor Create; override;

    procedure SingleLoadFromStream( const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  ); override;

    procedure SaveToStream(Stream: TStream); override;

    { background color used when loading icon }
    property BackgroundColor : TRgb read FBackgroundColor
                                    write FBackgroundColor;


protected
    class function CanRead( const Stream : TStream ) : Boolean; override;
end;

{--------------------------------------------------------------------------}

implementation

uses
    Windows,  { for TRect }
    Graphics, { for TIcon }
    EnMisc;   { for TImageFormat }

{--------------------------------------------------------------------------}

type

TProtectedIcon = class(TIcon);

{--------------------------------------------------------------------------}

constructor TIconGraphic.Create;
begin
    inherited Create;

    FBackgroundColor := CWhiteRgb;
end;

{--------------------------------------------------------------------------}

procedure TIconGraphic.SingleLoadFromStream(
                                    const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  );

var
    Icon : TIcon;
    Rect : TRect;
begin
    DoProgress( Self, FOnReadWriteProgress, 0, 0, 100, -1 );

    Icon := TIcon.Create;
    try
        Icon.LoadFromStream(Stream);
                                    
        DoProgress( Self, FOnReadWriteProgress, 95, 0, 100, -1 );

        Self.NewImage( Icon.Width, Icon.Height,
                       ifTrueColor, nil, 0, 0 );
        Rect.Left   := 0;
        Rect.Top    := 0;
        Rect.Right  := Icon.Width;
        Rect.Bottom := Icon.Height;

        { MB Dec 18, 2001. Use the background color specified by the user }
        Self.Fill( FBackgroundColor );

        TProtectedIcon(Icon).Draw(Self.Canvas, Rect);
    finally
        Icon.Free;
    end;

    DoProgress( Self, FOnReadWriteProgress, 100, 0, 100, -1 );

end;

{--------------------------------------------------------------------------}

{ original Icon conversion code from internet newsgroup by:
  George H. Silva 1997 snappy@global2000.net }
procedure TIconGraphic.SaveToStream(Stream: TStream);
var
    Mask     : Graphics.TBitmap;
    Color    : Graphics.TBitmap;
    IconInfo : TIconInfo;
    Icon     : Graphics.TIcon;
begin
    DoProgress( Self, FOnReadWriteProgress, 0, 0, 100, -1 );
                          
    Icon   := nil;
    Mask   := nil;
    Color  := nil;
    try
        FillChar(IconInfo,SizeOf(TIconInfo),0);
        IconInfo.fIcon := True;
        Color          := Graphics.TBitmap.Create;
        Mask           := Graphics.TBitmap.Create;
        Icon           := Graphics.TIcon.Create;
        Color.Height   := GetSystemMetrics(SM_CYICON);
        Color.Width    := GetSystemMetrics(SM_CXICON);
        Mask.Height    := Color.Height;
        Mask.Width     := Color.Width;
        Mask.Canvas.Brush.Color := clBlack;
        Mask.Canvas.FillRect(Bounds(0,0,Mask.Width,Mask.Height));
        IconInfo.hbmMask  := Mask.Handle;
        { using StretchDraw the entire original is stretched
        Color.Canvas.StretchDraw(Bounds(0,0,Color.Width,Color.Height),Self);
        }
        Color.Canvas.Draw(0, 0, Self);

        IconInfo.hbmColor := Color.Handle;
        Icon.Handle := CreateIconIndirect(IconInfo);

        DoProgress( Self, FOnReadWriteProgress, 10, 0, 100, -1 );

        Icon.SaveToStream(Stream);
    finally
        Mask.Free;
        Color.Free;
        Icon.Free;
    end;

    DoProgress( Self, FOnReadWriteProgress, 100, 0, 100, -1 );

end;

{--------------------------------------------------------------------------}

(* some icon format notes found on the net:

Icon-Resource File Format

An icon-resource file contains image data for icons used by Windows
applications. The file consists of an icon directory identifying the number
and types of icon images in the file, plus one or more icon images. The
default filename extension for an icon-resource file is .ICO.

Icon Directory

Each icon-resource file starts with an icon directory. The icon directory,
defined as an ICONDIR structure, specifies the number of icons in the
resource and the dimensions and color format of each icon image. The ICONDIR
structure has the following form:



typedef struct ICONDIR {
    WORD          idReserved;
    WORD          idType;
    WORD          idCount;
    ICONDIRENTRY  idEntries[1];
} ICONHEADER;

Following are the members in the ICONDIR structure:

idReserved      Reserved; must be zero.
idType          Specifies the resource type. This member is set to 1.
idCount         Specifies the number of entries in the directory.
idEntries       Specifies an array of ICONDIRENTRY structures containing
information about individual icons. The idCount member specifies the number
of structures in the array.

The ICONDIRENTRY structure specifies the dimensions and color format for an
icon. The structure has the following form:

struct IconDirectoryEntry {
    BYTE  bWidth;
    BYTE  bHeight;
    BYTE  bColorCount;
    BYTE  bReserved;
    WORD  wPlanes;
    WORD  wBitCount;
    DWORD dwBytesInRes;
    DWORD dwImageOffset;
};

Following are the members in the ICONDIRENTRY structure:

bWidth          Specifies the width of the icon, in pixels. Acceptable values
are 16, 32, and 64.

bHeight         Specifies the height of the icon, in pixels. Acceptable
values are 16, 32, and 64.

bColorCount     Specifies the number of colors in the icon. Acceptable values
are 2, 8, and 16.

bReserved       Reserved; must be zero.
wPlanes         Specifies the number of color planes in the icon bitmap.
wBitCount       Specifies the number of bits in the icon bitmap. 
dwBytesInRes    Specifies the size of the resource, in bytes.
dwImageOffset   Specifies the offset, in bytes, from the beginning of the
file to the icon image.
*)

const
  rc3_StockIcon = 0;
  rc3_Icon      = 1;

type

TIconHeader = packed record
    Reserved : Word;
    wType    : Word;
    Count    : Word;
end;


TIconDirectory = packed record
    Width       : Byte;
    Height      : Byte;
    ColorCount  : Byte;
    Reserved    : Byte;
    Planes      : Word;
    BitCount    : Word;
    BytesInRes  : Cardinal;
    ImageOffset : Cardinal;
end;

{--------------------------------------------------------------------------}

class function TIconGraphic.CanRead( const Stream : TStream ) : Boolean;
var
    Header    : TIconHeader;
    Directory : TIconDirectory;
begin
    Stream.Read( Header, SizeOf(Header));
    Stream.Read( Directory, SizeOf(Directory));
    Stream.Seek( -(SizeOf(Directory)), soFromCurrent );
    Stream.Seek( -(SizeOf(Header)), soFromCurrent );

    Result := (Header.wType in [rc3_StockIcon, rc3_Icon]) and
              (Header.Count > 0) and
              (Directory.Width in [16,32,64]) and
              (Directory.Height in [16,32,64]);
end;

{--------------------------------------------------------------------------}

initialization

    {$ifdef __RegisterEnvisionIco}
    RegisterDibGraphic('ICO', 'Windows icon', TIconGraphic);
    {$endif}

finalization

end.

