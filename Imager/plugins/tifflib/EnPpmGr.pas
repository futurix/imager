{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnPpmGr
|
| Description: TDibGraphic descendant for PPM files.
|
| History: Apr 12, 2002. www.smokingun.co.uk first version
|          May 10, 2002  www.smokingun.co.uk Added CanRead method for Library
|                                            Version 1.2
|
|---------------------------------------------------------------------------}
unit EnPpmGr;

{$I Envision.Inc}

interface

uses
    Classes, { for TStream }
    EnDiGrph; { for TDibGraphic }

type

    TPpmMode = ( pmAscii, pmBinary);

    TPpmGraphic = class( TDibGraphic)
    protected
        FMode: TPpmMode;
        class function CanRead( const Stream: TStream): Boolean; override;

    private
        procedure RaisePPMError( const Msg: string);

    public
        constructor Create; override;

        procedure SingleLoadFromStream( const Stream: TStream;
            const ImageToLoad: LongInt
            ); override;

        procedure SaveToStream( Stream: TStream); override;

        property Mode: TPpmMode read FMode write FMode;

    end;

    {--------------------------------------------------------------------------}

implementation

uses
    SysUtils, { for Format, IntToStr, ... }
    EnMsg, { for msgXXXX }
    EnMisc; { for EEnvisionError }

const

    CCreatedByStr = '# Created By Envision Image Library';

    {--------------------------------------------------------------------------}

constructor TPpmGraphic.Create;
begin
    inherited Create;

    FMode := pmAscii;

end;

{--------------------------------------------------------------------------}

procedure TPpmGraphic.RaisePPMError( const Msg: string);
begin
    raise EEnvisionError.Create( Msg);
end;

{--------------------------------------------------------------------------}

procedure TPpmGraphic.SingleLoadFromStream(
    const Stream: TStream;
    const ImageToLoad: LongInt
    );
var
    Buffer     : array[0..4095] of char;
    BufLen     : Integer;
    Idx        : Integer;
    StreamByte : Byte;
    Bits       : Byte;
    BitNo      : Integer;
    EOF        : Boolean;

    function GetCh: char;
    begin
        if Idx = BufLen then
        begin
            Idx := 0;
            BufLen := Stream.Read( Buffer, SizeOf( Buffer));
            if BufLen = 0 then
            begin
                if EOF then
                    RaisePPMError( msgInvalidPPMFile);
                Buffer[0] := #10;
                BufLen := 1;
                Idx := 0;
                EOF := true;
            end;
        end;
        Result := Buffer[Idx];
        Inc( Idx);
    end;

    function SkipEndLine: char;
    begin
        repeat
            Result := getCh;
        until Result in [#13, #10];
    end;

    function ReadChar: char;
    begin
        Result := GetCh;
        if Result = '#' then
            Result := SkipEndLine;
        if ( Result in [#13, #10]) then
            Result := ' ';
    end;

    function ReadBit: Byte;
    begin
        if BitNo = 8 then
        begin
            Bits := Byte( GetCh);
            BitNo := 0;
        end;
        Result := ( Bits and ( $80 shr BitNo)) shr ( 7 - BitNo);
        Inc( BitNo);
    end;

    function ReadInteger: Integer;
    var
        ch: char;
    begin
        repeat
            ch := ReadChar;
        until ch in ['0'..'9'];

        Result := 0;
        repeat
            Result := ( 10 * Result) + ( Ord( ch) - Ord( '0'));
            ch := ReadChar;
        until not ( ch in ['0'..'9'])
    end;

    procedure ReadPBMAscii;
    var
        x, y: Integer;
        w, h: Integer;
    begin
        w := ReadInteger;
        h := ReadInteger;

        NewImage( w, h, ifBlackWhite, nil, 0, 0);

        for y := 0 to h - 1 do
        begin
            for x := 0 to w - 1 do
            begin
                PaletteIndex[x, y] := ReadInteger xor $01;
            end;
        end;
    end;

    procedure ReadPGMAscii;
    var
        x, y: Integer;
        w, h: Integer;
    begin
        w := ReadInteger;
        h := ReadInteger;

        // skip max colours
        ReadInteger;

        NewImage( w, h, ifGray256, nil, 0, 0);

        for y := 0 to h - 1 do
        begin
            for x := 0 to w - 1 do
            begin
                PaletteIndex[x, y] := ReadInteger;
            end;
        end;
    end;

    procedure ReadPPMAscii;
    var
        x, y: Integer;
        w, h: Integer;
        r, g, b: Byte;
    begin
        w := ReadInteger;
        h := ReadInteger;

        // skip max colours
        ReadInteger;

        NewImage( w, h, ifTrueColor, nil, 0, 0);

        for y := 0 to h - 1 do
        begin
            for x := 0 to w - 1 do
            begin
                r := ReadInteger;
                g := ReadInteger;
                b := ReadInteger;
                RGB[x, y] := MakeRgb( r, g, b);
            end;
        end;
    end;

    procedure ReadPBMBinary;
    var
        x, y: Integer;
        w, h: Integer;
    begin
        w := ReadInteger;
        h := ReadInteger;

        NewImage( w, h, ifBlackWhite, nil, 0, 0);

        for y := 0 to h - 1 do
        begin
            // Initialise Bit Count to force 1st read
               // NB Pixels are not continous as per documention!!!
            BitNo := 8;
            for x := 0 to w - 1 do
            begin
                PaletteIndex[x, y] := ReadBit xor $01;
            end;
        end;
    end;

    procedure ReadPGMBinary;
    var
        x, y: Integer;
        w, h: Integer;
    begin
        w := ReadInteger;
        h := ReadInteger;

        // skip past end of Line
        GetCh;

        NewImage( w, h, ifGray256, nil, 0, 0);

        for y := 0 to h - 1 do
        begin
            for x := 0 to w - 1 do
            begin
                PaletteIndex[x, y] := Byte( GetCh);
            end;
        end;
    end;

    procedure ReadPPMBinary;
    var
        x, y: Integer;
        w, h: Integer;
        r, g, b: Byte;
    begin
        w := ReadInteger;
        h := ReadInteger;

        // skip past end of Line
        GetCh;

        NewImage( w, h, ifTrueColor, nil, 0, 0);

        for y := 0 to h - 1 do
        begin
            for x := 0 to w - 1 do
            begin
                r := Byte( GetCh);
                g := Byte( GetCh);
                b := Byte( GetCh);
                RGB[x, y] := MakeRgb( r, g, b);
            end;
        end;
    end;

begin
    EOF := false;
    Idx := 0;
    BufLen := 0;

    StreamByte := Byte( ReadChar);
    if StreamByte <> Byte( 'P') then
        RaisePPMError( msgInvalidPPMFile);

    StreamByte := Ord( ReadChar) - Ord( '0');
    case StreamByte of
        1: {// PBM ASCII (B/W)}
            begin
                FMode := pmAscii;
                ReadPBMAscii;
            end;
        2: {// PGM ASCII (Grey Scale)}
            begin
                FMode := pmAscii;
                ReadPGMAscii;
            end;
        3: {// PPM ASCII (True Colour)}
            begin
                FMode := pmAscii;
                ReadPPMAscii;
            end;
        4: {// PBM Binary (B/W)}
            begin
                FMode := pmBinary;
                ReadPBMbinary;
            end;
        5: {// PGM Binary (Grey Scale)}
            begin
                FMode := pmBinary;
                ReadPGMBinary;
            end;
        6: {// PPM Binary (True Colour)}
            begin
                FMode := pmBinary;
                ReadPPMBinary;
            end;
    else
        RaisePPMError( msgInvalidPPMFile);
    end;

end;

{--------------------------------------------------------------------------}

procedure TPPMGraphic.SaveToStream( Stream: TStream);
var
    Buffer: array[0..4095] of char;
    LineLen: Integer;
    Idx: Integer;
    Bits: Byte;
    BitNo: Integer;

    procedure PutCh( ch: char);
    begin
        if Idx = sizeOf( Buffer) then
        begin
            Stream.Write( Buffer, Idx);
            Idx := 0;
        end;
        Buffer[Idx] := ch;
        Inc( Idx);
    end;

    procedure PutString( s: AnsiString);
    var
        i: Integer;
    begin
        if LineLen <> 0 then
            PutCh( #10);
        for i := 1 to Length( s) do
            PutCh( s[i]);
        PutCh( #10);
        LineLen := 0;
    end;

    procedure PutInteger( n: Integer);
    var
        i: Integer;
        s: AnsiString;
    begin
        s := IntToStr( n);
        // Maximum Line Length allowed in
        // ASCII Mode Files is 70 Characters
        if LineLen + Length( s) > 69 then
        begin
            PutCh( #10);
            LineLen := 0;
        end;
        if LineLen > 0 then
            PutCh( ' ');
        for i := 1 to Length( s) do
            PutCh( s[i]);
        LineLen := LineLen + Length( s) + 1;
    end;

    procedure PutBit( bt: Byte);
    begin
        if BitNo = 8 then
        begin
            PutCh( Char( Bits));
            Bits := 0;
            BitNo := 0;
        end;
        Bits := Bits or ( bt shl ( 7 - BitNo));
        Inc( BitNo);
    end;

    procedure SavePBMAscii;
    var
        x, y: Integer;
    begin
        PutString( 'P1');
        PutString( CCreatedByStr);

        PutString( Format( '%d %d', [Width, Height]));

        for y := 0 to Height - 1 do
        begin
            for x := 0 to Width - 1 do
            begin
                PutInteger( PaletteIndex[x, y] xor 1);
            end;
        end;
        PutCh( #10);
    end;

    procedure SavePGMAscii;
    var
        x, y: Integer;
    begin
        PutString( 'P2');
        PutString( CCreatedByStr);

        PutString( Format( '%d %d', [Width, Height]));
        PutString( '255');

        for y := 0 to Height - 1 do
        begin
            for x := 0 to Width - 1 do
            begin
                PutInteger( PaletteIndex[x, y]);
            end;
        end;
        PutCh( #10);
    end;

    procedure SavePPMAscii;
    var
        x, y: Integer;
        c: TRgb;
    begin
        PutString( 'P3');
        PutString( CCreatedByStr);

        PutString( Format( '%d %d', [Width, Height]));
        PutString( '255');

        for y := 0 to Height - 1 do
        begin
            for x := 0 to Width - 1 do
            begin
                c := RGB[x, y];
                PutInteger( c.Red);
                PutInteger( c.Green);
                PutInteger( c.Blue);
            end;
        end;
        PutCh( #10);
    end;

    procedure SavePBMBinary;
    var
        x, y: Integer;
    begin
        PutString( 'P4');
        PutString( CCreatedByStr);

        PutString( Format( '%d %d', [Width, Height]));

        for y := 0 to Height - 1 do
        begin
            for x := 0 to Width - 1 do
            begin
                PutBit( PaletteIndex[x, y] xor 1);
            end;
            // Ensure next bit starts on a Byte Boundary
            if BitNo > 0 then
                BitNo := 8;
        end;
        // Flush Final Byte
        if BitNo > 0 then
            PutCh( Char( Bits));
    end;

    procedure SavePGMBinary;
    var
        x, y: Integer;
    begin
        PutString( 'P5');
        PutString( CCreatedByStr);

        PutString( Format( '%d %d', [Width, Height]));
        PutString( '255');

        for y := 0 to Height - 1 do
        begin
            for x := 0 to Width - 1 do
            begin
                PutCh( Char( PaletteIndex[x, y]));
            end;
        end;
    end;

    procedure SavePPMBinary;
    var
        x, y: Integer;
        c: TRgb;
    begin
        PutString( 'P6');
        PutString( CCreatedByStr);

        PutString( Format( '%d %d', [Width, Height]));
        PutString( '255');

        for y := 0 to Height - 1 do
        begin
            for x := 0 to Width - 1 do
            begin
                c := RGB[x, y];
                PutCh( Char( c.Red));
                PutCh( Char( c.Green));
                PutCh( Char( c.Blue));
            end;
        end;
    end;

begin
    // Initialse Buffer vars
    LineLen := 0;
    Idx := 0;
    Bits := 0;
    BitNo := 0;

    case imageFormat of
        ifBlackWhite:
            begin
                if FMode = pmAscii then
                    SavePBMAscii
                else
                    SavePBMBinary;
            end;
        ifGray16, ifGray256:
            begin
                if FMode = pmAscii then
                    SavePGMAscii
                else
                    SavePGMBinary;
            end;
    else
        begin
            if FMode = pmAscii then
                SavePPMAscii
            else
                SavePPMBinary;
        end;
    end;

    // Finally Flush Buffer To Stream
    if Idx > 0 then
        Stream.Write( Buffer, Idx);
end;
{--------------------------------------------------------------------------}

class function TPPMGraphic.CanRead( const Stream: TStream): Boolean;
var
    Signature: array[0..1] of char;
    SubType: Integer;
begin
    Stream.Read( Signature, 2);
    Stream.Seek( -2, soFromCurrent);

    SubType := Ord( Signature[1]) - Ord( '0');
    Result := ( Signature[0] = 'P') and ( SubType > 0) and ( SubType < 7);
end;

{--------------------------------------------------------------------------}
initialization

    {$IFDEF __RegisterEnvisionPpm}
    RegisterDibGraphic( 'PPM', 'Portable Pixelmap', TPpmGraphic);
    RegisterDibGraphic( 'PGM', 'Portable Greymap', TPpmGraphic);
    RegisterDibGraphic( 'PBM', 'Portable Bitmap', TPpmGraphic);
    {$ENDIF}

finalization

end.
