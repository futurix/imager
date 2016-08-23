{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnOcrEng
|
| Description: TOCREngine class.
|
| History: Mar 21, 2002. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnOcrEng;

{$I Envision.Inc}

interface

uses
    Windows,  { for TRect }
    Classes,  { for TStringList }
    EnMisc,   { for TEnvisionProgressEvent }
    EnDiGrph; { for TDibGraphic }


type

TOcrDriver = class(TObject)
public
    constructor Create; virtual; abstract;

    { A derived driver class must override this method to perform the recognition.
      Progress event may be nil }
    procedure Recognize( const Graphic       : TDibGraphic;
                         const Output        : TStrings;
                         const ProgressEvent : TEnvisionProgressEvent ); virtual; abstract;

end;

TOcrDriverClass = class of TOcrDriver;

TOcrEngine = class(TObject)
protected
    FDriver : TOcrDriver;
public
    constructor Create( const OcrDriverClass : TOcrDriverClass );
    destructor Destroy; override;

    procedure Recognize( const Graphic       : TDibGraphic;
                         const Output        : TStrings;
                         const ProgressEvent : TEnvisionProgressEvent );

    procedure RecognizeRegion( const Graphic       : TDibGraphic;
                               const Region        : Windows.TRect;
                               const Output        : TStrings;
                               const ProgressEvent : TEnvisionProgressEvent );

    property Driver : TOcrDriver read FDriver;

end;

{--------------------------------------------------------------------------}

implementation

uses
    EnTransf; { TCropTransform }

constructor TOcrEngine.Create( const OcrDriverClass : TOcrDriverClass );
begin
    inherited Create;

    FDriver := OcrDriverClass.Create;
end;

{--------------------------------------------------------------------------}

destructor TOcrEngine.Destroy;
begin
    FDriver.Free;

    inherited Destroy;
end;

{--------------------------------------------------------------------------}

procedure TOcrEngine.Recognize( const Graphic       : TDibGraphic;
                                const Output        : TStrings;
                                const ProgressEvent : TEnvisionProgressEvent );
begin
    FDriver.Recognize( Graphic, Output, ProgressEvent );
end;

{--------------------------------------------------------------------------}

procedure TOcrEngine.RecognizeRegion( const Graphic       : TDibGraphic;
                                      const Region        : Windows.TRect;
                                      const Output        : TStrings;
                                      const ProgressEvent : TEnvisionProgressEvent );
var
    SubGraphic : TDibGraphic;
    Transform  : TCropTransform;
begin
    Transform  := TCropTransform.Create;
    SubGraphic := TDibGraphic.Create;
    try
        Transform.CropMode  := cmExtractRect;
        Transform.Left      := Region.Left;
        Transform.Right     := Region.Right;
        Transform.Top       := Region.Top;
        Transform.Bottom    := Region.Bottom;

        Transform.ApplyOnDest(Graphic, SubGraphic);

        FDriver.Recognize( SubGraphic, Output, ProgressEvent );

    finally
        SubGraphic.Free;
        Transform.Free;
    end;

end;

{--------------------------------------------------------------------------}

end.

