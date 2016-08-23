{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnEpxGr
|
| Description: TDibGraphic descendant for EPS files.
|
| Note: The support only allows viewing EPS files that have a preview
|
| History: Nov 21, 2001. Michel Brazeau, first version
|                        Thanks to Steve McMahon
|
|---------------------------------------------------------------------------}
unit EnEpsGr;

{$I Envision.Inc}

interface

uses
    Classes,  { for TStream }
    EnDiGrph; { for TDibGraphic }

type

TEPSGraphic = class(TDibGraphic)
public
    procedure SingleLoadFromStream( const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  ); override;

protected
    class function CanRead( const Stream : TStream ) : Boolean; override;
end;

{--------------------------------------------------------------------------}

implementation

uses
    EnMsg,    { for msgXXXX }
    EnMisc,   { for DoProgress }
    EnTifGr,  { for TTiffGraphic }
    EnWmfGr,  { for TMetaFileGraphic }
    Graphics; { for EInvalidGraphic }


{
0-3 Must be hex C5D0D3C6 (byte 0=C5).
4-7 Byte position in file for start of PostScript language code section.
8-11 Byte length of PostScript language section.
12-15 Byte position in file for start of Metafile screen representation.
16-19 Byte length of Metafile section (PSize).
20-23 Byte position of TIFF representation.
24-27 Byte length of TIFF section.
}

type

TEPSFileHeader = packed record
    Signature  : Cardinal;
    PSStart    : Cardinal;
    PSLengh    : Cardinal;
    WMFStart   : Cardinal;
    WMFLength  : Cardinal;
    TIFFStart  : Cardinal;
    TIFFLength : Cardinal;
end;

{--------------------------------------------------------------------------}

procedure TEPSGraphic.SingleLoadFromStream(
                                   const Stream      : TStream;
                                   const ImageToLoad : LongInt
                                  );
var
    FileHeader   : TEPSFileHeader;
    MemoryStream : TMemoryStream;
    Start        : Integer;
    Count        : Integer;
    Graphic      : TDibGraphic;
begin
    Stream.Seek(0, soFromBeginning);
    Stream.ReadBuffer(FileHeader, SizeOf(FileHeader));
    if FileHeader.Signature <> $C6D3D0C5 then
        raise EInvalidGraphic.Create(msgEPSFileDoesNotHavePreview);

    Graphic := nil;
    try
        if FileHeader.TIFFLength > 0 then
        begin
            Start   := FileHeader.TIFFStart;
            Count   := FileHeader.TIFFLength;
            Graphic := TTiffGraphic.Create;
        end
        else if FileHeader.WMFLength > 0 then
        begin
            Start   := FileHeader.WMFStart;
            Count   := FileHeader.WMFLength;
            Graphic := TMetaFileGraphic.Create;
        end
        else
             raise EInvalidGraphic.Create(msgEPSFileDoesNotHavePreview);

        MemoryStream := TMemoryStream.Create;
        try
            MemoryStream.SetSize(Count);
            Stream.Seek(Start, soFromBeginning);
            if MemoryStream.CopyFrom(Stream, Count) <> Count then
              raise EInvalidGraphic.Create(msgEPSFileDoesNotHavePreview);

            MemoryStream.Seek(0, soFromBeginning);

            Graphic.OnReadWriteProgress := Self.FOnReadWriteProgress;

            Graphic.LoadFromStream(MemoryStream);

            Self.Assign(Graphic);

        finally
             MemoryStream.free;
        end;

    finally
        Graphic.Free;
    end;
end;

{--------------------------------------------------------------------------}

class function TEPSGraphic.CanRead( const Stream : TStream ) : Boolean;
var
    Signature : Cardinal;
begin
    Stream.Read( Signature, SizeOf(Signature));
    Stream.Seek( -(SizeOf(Signature)), soFromCurrent );

    Result := (Signature = $C6D3D0C5);
end;

{--------------------------------------------------------------------------}

initialization

    {$ifdef __RegisterEnvisionEPS}
    RegisterDibGraphic('EPS', 'Encapsulated postscript', TEPSGraphic);
    {$endif}

finalization

end.

