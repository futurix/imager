{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnWmfGr
|
| Description: TDibGraphic descendant for WMF/EMF files.
|
| History: Dec 24, 1998. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnWmfGr;

{$I Envision.Inc}

interface

uses
    Classes,  { for TStream }
    EnDiGrph; { for TDibGraphic }

type

TMetaFileGraphic = class(TDibGraphic)
protected
    FBackgroundColor : TRgb;

public
    constructor Create; override;

    procedure SingleLoadFromStream( const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  ); override;
    procedure SaveToStream(Stream: TStream); override;

    { background color used when loading the metafile }
    property BackgroundColor : TRgb read FBackgroundColor
                                    write FBackgroundColor;

protected
    class function CanRead( const Stream : TStream ) : Boolean; override;
end;

{--------------------------------------------------------------------------}

implementation

uses
    Windows,  { for TRect }
    Graphics, { for TMetaFile }
    EnMisc;   { for ifTrueColor }

{--------------------------------------------------------------------------}

type

TProtectedMetaFile = class(TMetaFile);

constructor TMetaFileGraphic.Create;
begin
    inherited Create;

    FBackgroundColor := CWhiteRgb;
end;

{--------------------------------------------------------------------------}

procedure TMetaFileGraphic.SingleLoadFromStream(
                                   const Stream      : TStream;
                                   const ImageToLoad : LongInt
                                  );

var
    MetaFile : TMetaFile;
    Rect     : TRect;
begin
    DoProgress( Self, FOnReadWriteProgress, 0, 0, 100, -1 );

    MetaFile := TMetaFile.Create;
    try
        MetaFile.LoadFromStream(Stream);

        DoProgress( Self, FOnReadWriteProgress, 95, 0, 100, -1 );

        Self.NewImage( MetaFile.Width, MetaFile.Height,
                       ifTrueColor, nil, 0, 0 );

        { MB Dec 18, 2001. Use the background color specified by the user }
        Self.Fill( FBackgroundColor );

        Rect.Left   := 0;
        Rect.Top    := 0;
        Rect.Right  := MetaFile.Width;
        Rect.Bottom := MetaFile.Height;

        TProtectedMetaFile(MetaFile).Draw(Self.Canvas, Rect);
    finally
        MetaFile.Free;
    end;

    DoProgress( Self, FOnReadWriteProgress, 100, 0, 100, -1 );

end;

{--------------------------------------------------------------------------}

procedure TMetaFileGraphic.SaveToStream(Stream: TStream);
var
    MetaFile : TMetaFile;
    Canvas   : TMetaFileCanvas;
begin
    DoProgress( Self, FOnReadWriteProgress, 0, 0, 100, -1 );

    MetaFile := TMetaFile.Create;
    try
        MetaFile.Width  := Self.Width;
        MetaFile.Height := Self.Height;
        Canvas := TMetafileCanvas.Create(Metafile, 0);
        try
            Canvas.Draw(0, 0, Self);
        finally
            Canvas.Free;
        end;

        DoProgress( Self, FOnReadWriteProgress, 5, 0, 100, -1 );

        MetaFile.SaveToStream(Stream);
    finally
        MetaFile.Free;
    end;

    DoProgress( Self, FOnReadWriteProgress, 100, 0, 100, -1 );

end;

{--------------------------------------------------------------------------}

class function TMetaFileGraphic.CanRead( const Stream : TStream ) : Boolean;

    function IsEnhanced : Boolean;
    var
        Header : Windows.TEnhMetaHeader;
    begin
        Stream.Read(Header, Sizeof(Header));
        Stream.Seek(-Sizeof(Header), soFromCurrent);
        Result := (Header.iType      = Windows.EMR_HEADER) and
                  (Header.dSignature = Windows.ENHMETA_SIGNATURE)
    end;

    function IsRegular : Boolean;
    var
        Key : Cardinal;
    begin
        Stream.Read( Key, SizeOf(Key) );
        Stream.Seek( -SizeOf(Key), soFromCurrent);
        Result := (Key = $9AC6CDD7);
    end;


begin
    Result := IsEnhanced or IsRegular;
end;

{--------------------------------------------------------------------------}

initialization

    {$ifdef __RegisterEnvisionWmf}
    RegisterDibGraphic('WMF', 'Windows meta file', TMetaFileGraphic);
    RegisterDibGraphic('EMF', 'Enhanced meta file', TMetaFileGraphic);
    {$endif}

finalization

end.

