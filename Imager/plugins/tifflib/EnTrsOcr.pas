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
unit EnTrsOcr;

{$I Envision.Inc}

interface

uses
    Classes,  { for TStringList }
    TransOCR, { for TOCRJobInfo, ... }
    EnMisc,   { for TEnvisionProgressEvent }
    EnDiGrph, { for TDibGraphic }
    EnOcrEng; { for TOcrDriver }


type

TTransymOcrOptions = ( tooDeskew,
                       tooNoiseRemove,
                       tooLineRemove,
                       tooDeshade,
                       tooInvert,
                       tooSectioning,
                       tooMergeBreak,
                       tooLineReject,
                       tooCharacterReject,
                       tooUseDictionary );


TTransymOcrOptionsSet = set of TTransymOcrOptions;

TTransymOcrDriver = class(TOcrDriver)
protected
    FJobNo    : LongInt;
    FOptions  : TTransymOcrOptionsSet;


public
    constructor Create; override;
    destructor Destroy; override;

    procedure Recognize( const Graphic       : TDibGraphic;
                         const Output        : TStrings;
                         const ProgressEvent : TEnvisionProgressEvent ); override;


    property Options : TTransymOcrOptionsSet read FOptions
                                             write FOptions;

end;

{--------------------------------------------------------------------------}

implementation

uses
    Windows,  { for THandle }
    ClipBrd;  { for TClipBoard }

{--------------------------------------------------------------------------}

procedure SetJobOptions( const Options    : TTransymOcrOptionsSet;
                         var   JobInfo    : TOCRJobInfo );
begin
    FillChar( JobInfo, SizeOf(JobInfo), 0);
    JobInfo.JobType   := TOCRJOBTYPE_DIBCLIPBOARD;
    JobInfo.PageNo    := 0;

    JobInfo.ProcessOptions.InvertWholePage     := OCRFalse;
    JobInfo.ProcessOptions.Orientation         := TOCRJOBORIENT_OFF;

    if tooDeskew in Options then
        JobInfo.ProcessOptions.DeskewOff  := OCRFalse
    else
        JobInfo.ProcessOptions.DeskewOff  := OCRTrue;

    if tooNoiseRemove in Options then
        JobInfo.ProcessOptions.NoiseRemoveOff  := OCRFalse
    else
        JobInfo.ProcessOptions.NoiseRemoveOff  := OCRTrue;

    if tooLineRemove in Options then
        JobInfo.ProcessOptions.LineRemoveOff  := OCRFalse
    else
        JobInfo.ProcessOptions.LineRemoveOff  := OCRTrue;

    if tooDeshade in Options then
        JobInfo.ProcessOptions.DeshadeOff  := OCRFalse
    else
        JobInfo.ProcessOptions.DeshadeOff  := OCRTrue;

    if tooInvert in Options then
        JobInfo.ProcessOptions.InvertOff  := OCRFalse
    else
        JobInfo.ProcessOptions.InvertOff  := OCRTrue;

    if tooSectioning in Options then
        JobInfo.ProcessOptions.SectioningOn  := OCRTrue
    else
        JobInfo.ProcessOptions.SectioningOn  := OCRFalse;

    if tooMergeBreak in Options then
        JobInfo.ProcessOptions.MergeBreakOff  := OCRFalse
    else
        JobInfo.ProcessOptions.MergeBreakOff  := OCRTrue;

    if tooLineReject in Options then
        JobInfo.ProcessOptions.LineRejectOff  := OCRFalse
    else
        JobInfo.ProcessOptions.LineRejectOff  := OCRTrue;

    if tooCharacterReject in Options then
        JobInfo.ProcessOptions.CharacterRejectOff  := OCRFalse
    else
        JobInfo.ProcessOptions.CharacterRejectOff  := OCRTrue;

    if tooUseDictionary in Options then
        JobInfo.ProcessOptions.LexOff  := OCRFalse
    else
        JobInfo.ProcessOptions.LexOff  := OCRTrue;
end;

{--------------------------------------------------------------------------}

constructor TTransymOcrDriver.Create;
begin
    { don't call inherited Create, as it is an abstract method which will
      cause an access violation }
    FJobNo := -1;

    LoadTOCREngine;

    {$Warnings Off}
    CheckOCRCall(OCRInitialise(@FJobNo));
    {$Warnings On}

    { set the default options }
    FOptions := [ tooDeskew,
                  tooNoiseRemove,
                  tooLineRemove,
                  tooDeshade,
                  tooSectioning,
                  tooMergeBreak,
                  tooLineReject,
                  tooUseDictionary,
                  tooCharacterReject
                ];

end;

{--------------------------------------------------------------------------}

destructor TTransymOcrDriver.Destroy;
begin
    if FJobNo <> -1 then
        CheckOCRCall(OCRShutDown(FJobNo));

    UnloadTOCREngine;

    inherited Destroy;
end;

{--------------------------------------------------------------------------}

procedure TTransymOcrDriver.Recognize( const Graphic       : TDibGraphic;
                                       const Output        : TStrings;
                                       const ProgressEvent : TEnvisionProgressEvent );
var
    JobStatus          : LongInt;
    ResultSize         : LongInt;
    pOCRResults        : TpOCRResults;
    {$Warnings Off}
    ResultsPtr         : Pointer;
    {$Warnings On}
    ItemNo             : LongInt;
    Text               : AnsiString;
    DibHandle          : Windows.THandle;
    JobInfo            : TOCRJobInfo;
    LastPercent        : Byte;
    Progress           : Single;
    Orientation        : LongInt;

begin
    { MB Nov 22, 2002
      workaround a bug where somethings the first line of text was not recognized.
      Just add one black pixel in the top/left corner. }
    Graphic.RGB[0,0] := MakeRgb(0,0,0);

    DibHandle := Graphic.AsDibHandle;
    ClipBoard.SetAsHandle( CF_DIB, DibHandle );

    SetJobOptions( FOptions, JobInfo );

    {$Warnings Off}
    CheckOCRCall(OCRDoJob(FJobNo, @JobInfo));
    {$Warnings On}

    JobStatus := -1;

    LastPercent := DoProgress( Self, ProgressEvent, 0, 0, 100, -1 );

    repeat

        {$Warnings Off}
        CheckOCRCall(OCRGetJobStatusEx(FJobNo, @JobStatus, @Progress, @Orientation));
        {$Warnings On}

        LastPercent := DoProgress( Self, ProgressEvent, SafeTrunc(Progress*100), 0, 100, LastPercent );

        if JobStatus = TOCRJOBSTATUS_BUSY then
            Sleep(0);

    until (JobStatus <> TOCRJOBSTATUS_BUSY);

    DoProgress( Self, ProgressEvent, 100, 0, 100, LastPercent );


    if JobStatus = TOCRJOBSTATUS_DONE then
    begin
        ResultSize := 0;

        {$Warnings Off}
        CheckOCRCall( OCRGetJobResults( FJobNo, @ResultSize, nil ));
        {$Warnings On}

        if ResultSize > 0 then
        begin
            {$Warnings Off}
            GetMem( ResultsPtr, ResultSize );
            {$Warnings On}
            try
                {$Warnings Off}
                pOCRResults := ResultsPtr;
                {$Warnings On}

                pOCRResults^.Header.NumItems := 0;

                {$Warnings Off}
                CheckOCRCall( OCRGetJobResults( FJobNo, @ResultSize, ResultsPtr ));
                {$Warnings On}

                Text := '';
                for ItemNo := 0 to pOCRResults^.Header.NumItems-1 do
                    Text := Text + Char( pOCRResults.Items[ItemNo].OCRCha);

                {$Warnings Off}
                Output.SetText(PChar(Text));
                {$Warnings On}

            finally
                {$Warnings Off}
                FreeMem( ResultsPtr );
                {$Warnings On}
            end;
        end;
    end;
end;

{--------------------------------------------------------------------------}

end.

