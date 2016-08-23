{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnTgaGr
|
| Description: TDibGraphic descendant for TGA files. TGA files do not
|              support image resolution.
|
| History: Feb 28, 1999. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnTgaGr;

{$I Envision.Inc}

interface

uses
    Classes,  { for TStream }
    SysUtils, { for Exception }
    EnDiGrph; { for TDibGraphic }

type

TTgaGraphic = class(TDibGraphic)
public
    constructor Create; override;

    procedure LoadFromStream(Stream: TStream); override;

    procedure SaveToStream(Stream: TStream); override;

protected
    class function CanRead( const Stream : TStream ) : Boolean; override;
end;

ETgaError = class(Exception);

{--------------------------------------------------------------------------}

implementation

uses
    EnMsg,    { for msgXXXX }
    EnGbm,    { for LoadGraphicWithGbm, SaveGraphicWithGbm }
    EnMisc;   { for ifGray256, ... }

const

CSampleTgaFileName = 'File.tga';


{--------------------------------------------------------------------------}

constructor TTgaGraphic.Create;
begin
    inherited Create;

end;

{--------------------------------------------------------------------------}

procedure TTgaGraphic.LoadFromStream(Stream: TStream);
var
    Position    : LongInt;
    ImageStream : TStream;

begin
    Position := Stream.Position;

    ImageStream := nil;
    try
        if Position <> 0 then
        begin
            { when loading images from DFM files, the image
              stream is included when a larger stream. The GBM
              library does not handle this, so a new stream
              must be created. }
            ImageStream := TMemoryStream.Create;

            TMemoryStream(ImageStream).SetSize(Stream.Size-Stream.Position);
            ImageStream.CopyFrom(Stream, Stream.Size-Stream.Position)
        end
        else
            ImageStream := Stream;

        ImageStream.Seek(0, soFromBeginning);

        LoadGraphicWithGbm( ImageStream, Self, CSampleTgaFileName, '', FOnReadWriteProgress );

    finally
        if Position <> 0 then
            ImageStream.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure TTgaGraphic.SaveToStream(Stream: TStream);
begin
    if not (Self.ImageFormat in [ifGray256, ifColor256, ifTrueColor]) then
        raise ETgaError.Create(msgTGAMustBeTrueColorOr8Bit);

    SaveGraphicWithGbm( Stream, Self, CSampleTgaFileName, FOnReadWriteProgress );
end;

{--------------------------------------------------------------------------}

type

TTgaHeader = packed record
    IDLength        : Byte;
    ColorMapType    : Byte;
    ImageType       : Byte;
    CMapStart       : Word;
    CMapLength      : Word;
    CMapDepth       : Byte;
    XOffset         : Word;
    YOffset         : Word;
    Width           : Word;
    Height          : Word;
    PixelDepth      : Byte;
    ImageDescriptor : Byte;
end;

const TGA_UNCOMP_CM  = 1;
const TGA_UNCOMP_RGB = 2;
const TGA_UNCOMP_BW  = 3;
const TGA_RL_CM      = 9;
const TGA_RL_RGB     = 10;
const TGA_RL_BW      = 11;

class function TTgaGraphic.CanRead( const Stream : TStream ) : Boolean;
var
    Header : TTgaHeader;
begin
    Stream.Read( Header, SizeOf(Header));
    Stream.Seek( -(SizeOf(Header)), soFromCurrent );

    case Header.ImageType of
        TGA_RL_BW,
        TGA_UNCOMP_BW : Result := (Header.PixelDepth = 8);

	TGA_RL_CM,
	TGA_UNCOMP_CM  : Result := (Header.PixelDepth = 8) and
                                   (Header.CMapDepth  = 24);
	TGA_RL_RGB,
	TGA_UNCOMP_RGB : Result := (Header.PixelDepth in [16,24,32]);

        else
            Result := False;
    end;
end;

{--------------------------------------------------------------------------}


initialization
    {$ifdef __RegisterEnvisionTga}
    RegisterDibGraphic('TGA', 'Truevision Targa', TTgaGraphic);
    RegisterDibGraphic('VST', 'Truevision Vista', TTgaGraphic);
    RegisterDibGraphic('AFI', 'Truevision Targa', TTgaGraphic);
    {$endif}

finalization

end.

