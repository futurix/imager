{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnScan
|
| Description: Scanning class.
|
| History: Feb 28, 1999. Michel Brazeau, first version
|          Feb 26, 2001. MB Add ability to scan multiple times without
|                        closing the source manager. See the OpenSource,
|                        AcquireWithSourceOpen and CloseSource. Thanks to
|                        Michael Mount.
|
|---------------------------------------------------------------------------}
unit EnScan;

{$I Envision.Inc}

interface

uses
    Windows,  { for THandle }
    Classes,  { for TStringList }
    SysUtils, { for Exception }
    EnTwain,  { for TTwainData }
    EnMisc;   { for TImageFormat, AddBackSlashToPath, TSingleRect }

type


TScanner = class(TObject)
protected
    FTwainData    : TTwainData;

    { FCreated is set True when the object is properly created. This
      is used when destroying a partially created TScanner }
    FCreated      : Boolean;

    FScanners     : TStringList;

    FScannerIndex : Integer;

    FShowUIProgress: Boolean; //mdm 02/18/2003

    { Physical width and height of the scanner bed }
    FPhysicalWidth,
    FPhysicalHeight: Single; //mdm 02/19/2003

    procedure LoadTwain;
    procedure UnloadTwain;

    procedure SetScannerIndexFromDefault;

    function GetShowUI : Boolean;
    procedure SetShowUI( const Show : Boolean );

    function GetRequestedXDpi : Word;
    procedure SetRequestedXDpi( const Dpi : Word );

    function GetRequestedYDpi : Word;
    procedure SetRequestedYDpi( const Dpi : Word );

    function GetRequestedImageFormat : TImageFormat;
    procedure SetRequestedImageFormat( const ImageFormat : TImageFormat );

    function GetProductName : String;
    procedure SetProductName( const Name : String );

    procedure SetScannerIndex( const Index : Integer );

    { Apply resolution and color depth settings to scanner }
    procedure ApplyOptions( var TwainData : TTwainData ); //mdm 02/18/2003

    function  GetPhysicalWidth: Single;                 //mdm 02/19/2003
    function  GetPhysicalHeight: Single;                //mdm 02/19/2003
    function  GetPhysicalSize(ICap: TW_UINT16): Single; //mdm 02/19/2003

public
    constructor Create;
    destructor Destroy; override;

    { IsConfigured returns True if the scanner drivers are configured on
      computer. }
    function IsConfigured : Boolean;

    { Displays a modal dialog box which allows the user to select the
      scanner. Returns False on user cancel.}
    function SelectScanner : Boolean;

    property Scanners : TStringList read FScanners;

    property ScannerIndex : Integer read FScannerIndex
                                    write SetScannerIndex;

    procedure Acquire( const AcquireEvent : TAcquireEvent;
                       const CallBackData : LongInt );

    { OpenSource, AcquireWithSouceOpen, and CloseSource may be used instead
      of Acquire, to leave the twain source opened between scans. }
    procedure OpenSource;
    procedure AcquireWithSourceOpen( const AcquireEvent : TAcquireEvent;
                                     const CallBackData : LongInt );
    procedure CloseSource;


    property  ShowUI : Boolean read GetShowUI
                               write SetShowUI;

    { these options are used  when ShowUI is set False before invoking
      Acquire.

      Defaults: RequestedXDpi        = 200
                RequestedYDpi        = 200
                RequestedImageFormat = ifBlackWhite

    }
    property  RequestedXDpi        : Word read GetRequestedXDpi
                                          write SetRequestedXDpi;

    property  RequestedYDpi        : Word read GetRequestedYDpi
                                          write SetRequestedYDpi;

    property  RequestedImageFormat : TImageFormat
                                       read GetRequestedImageFormat
                                       write SetRequestedImageFormat;

    { Control whether the Source Progress gauge is displayed when ShowUI = False }
    property  ShowUIProgress: Boolean
                                read FShowUIProgress
                                write FShowUIProgress; //mdm 02/18/2003
                                
    property  PhysicalWidth : Single
                                read GetPhysicalWidth;  //mdm 02/19/2003
    property  PhysicalHeight: Single
                                read GetPhysicalHeight; //mdm 02/19/2003

    { The ProductName may appear in the scanners interface. }
    property ProductName : String read GetProductName
                                  write SetProductName;

    { Get/Set the image layout (scanning area). If a scanner is not selected,
      the user will be requested to select one }
    function GetImageLayout( var Rect: TSingleRect ): Boolean;
    function SetImageLayout( const Rect: TSingleRect ): Boolean;


    function EnableFeeder : Boolean;
    function DisableFeeder : Boolean;
    function FeederLoaded : Boolean;

end;

EScannerError = class(Exception);

{ Access to the global scanner. Only created on first call }
function Scanner : TScanner;

{--------------------------------------------------------------------------}

implementation

uses
    Dialogs,  { for MessageDlg }
    EnMsg;    { msgXXXX }

var

InstanceCreated : Boolean;

GlobalScanner   : TScanner;


{--------------------------------------------------------------------------}

function Scanner : TScanner;
begin
    if GlobalScanner = nil then
        GlobalScanner := TScanner.Create;

    Result := GlobalScanner;
end;


{--------------------------------------------------------------------------}

constructor TScanner.Create;
begin
    inherited Create;

    if InstanceCreated then
        raise EScannerError.Create(msgOnlyOneScannerObjectPermitted);

    FScanners     := TStringList.Create;

    FScannerIndex := -1;

    FillChar(FTwainData, SizeOf(FTwainData), 0);
    with FTwainData.AppId do
    begin
        Id := 0;
        Version.MajorNum   := 1;
        Version.MinorNum   := 0;
        Version.Language   := TWLG_ENG;
        Version.Country    := TWCY_USA;
        {$Warnings Off}
        StrPCopy(@Version.Info, '');
        {$Warnings On}
        ProtocolMajor      := TWON_PROTOCOLMAJOR;
        ProtocolMinor      := TWON_PROTOCOLMINOR;
        SupportedGroups    := DG_IMAGE or DG_CONTROL;
        {$Warnings Off}
        StrPCopy(@Manufacturer, '');
        StrPCopy(@ProductFamily, '');
        StrPCopy(@ProductName, '');
        {$Warnings On}
    end;

    ShowUI               := True;
    ShowUIProgress       := True; // mdm 02/18/2003
    RequestedXDpi        := 200;
    RequestedYDpi        := 200;
    RequestedImageFormat := ifBlackWhite;

    InstanceCreated     := True;

    FCreated            := True;
    FPhysicalWidth      := 0.0; //mdm 02/19/2003 -  0 means we haven't fetched it
    FPhysicalHeight     := 0.0; //mdm 02/19/2003 - -1 means we tried to fetch and failed

    { the drivers are only loaded upon the first usage }
end;

{--------------------------------------------------------------------------}

destructor TScanner.Destroy;
var
    Index : Integer;
begin
    UnloadTwain;

    if FCreated then
        InstanceCreated := False;

    for Index := 0 to (FScanners.Count-1) do
        {$Warnings Off}
        FreeMem( Pointer(FScanners.Objects[Index]) );
        {$Warnings On}

    FScanners.Free;

    inherited Destroy;
end;

{--------------------------------------------------------------------------}

function TScanner.GetProductName : String;
begin
    {$Warnings Off}
    Result := PChar(@FTwainData.AppId.ProductName);
    {$Warnings On}
end;

{--------------------------------------------------------------------------}

procedure TScanner.SetProductName( const Name : String );
var
    Str32 : String[32];
begin
    Str32 := Name;
    {$Warnings Off}
    StrPCopy(@FTwainData.AppId.ProductName, Str32);
    {$Warnings On}
end;

{--------------------------------------------------------------------------}

function TScanner.GetShowUI : Boolean;
begin
    Result := FTwainData.ShowUI;
end;

{--------------------------------------------------------------------------}

procedure TScanner.SetShowUI( const Show : Boolean );
begin
    FTwainData.ShowUI := Show;
end;

{--------------------------------------------------------------------------}

function TScanner.GetRequestedXDpi : Word;
begin
    Result := FTwainData.XDpi;
end;

{--------------------------------------------------------------------------}

procedure TScanner.SetRequestedXDpi( const Dpi : Word );
begin
    FTwainData.XDpi := Dpi;
end;

{--------------------------------------------------------------------------}

function TScanner.GetRequestedYDpi : Word;
begin
    Result := FTwainData.YDpi;
end;

{--------------------------------------------------------------------------}

procedure TScanner.SetRequestedYDpi( const Dpi : Word );
begin
    FTwainData.YDpi := Dpi;
end;

{--------------------------------------------------------------------------}

function TScanner.GetRequestedImageFormat : TImageFormat;
begin
    Result := FTwainData.ImageFormat;
end;

{--------------------------------------------------------------------------}

procedure TScanner.SetRequestedImageFormat( const ImageFormat : TImageFormat );
begin
    FTwainData.ImageFormat := ImageFormat;
end;

{--------------------------------------------------------------------------}

//mdm 02/19/2003
function TScanner.GetPhysicalWidth: Single;
begin
  { Added 02/19/2003 - MDM }

  if (FPhysicalWidth = 0.0) then
    FPhysicalWidth  := GetPhysicalSize(ICAP_PHYSICALWIDTH);

  Result := FPhysicalWidth;

end; // function GetPhysicalWidth

{--------------------------------------------------------------------------}

//mdm 02/19/2003
function TScanner.GetPhysicalHeight: Single;
begin
  { Added 02/19/2003 - MDM }

  if (FPhysicalHeight = 0.0) then
    FPhysicalHeight := GetPhysicalSize(ICAP_PHYSICALHEIGHT);

  Result := FPhysicalHeight;

end; // function GetPhysicalWidth

{--------------------------------------------------------------------------}

procedure TScanner.LoadTwain;
var
    TempStr       : String;
    Handle32      : TW_INT32;
    Identity      : TW_IDENTITY;
    pIdentity     : ^TW_IDENTITY;
begin
    if FTwainData.DllHandle <> 0 then
        Exit; { already loaded }

    SetLength(TempStr, 255);

    {$Warnings Off}
    if GetWindowsDirectory(PChar(TempStr), 255) = 0 then
    {$Warnings On}
        raise EScannerError.Create('GetWindowsDirectory failed');

    {$Warnings Off}
    SetLength(TempStr, StrLen(PChar(TempStr)));
    {$Warnings On}

    TempStr := AddBackSlashToPath(TempStr) + CTwainDllFileName;

    {$Warnings Off}
    FTwainData.DllHandle := LoadLibrary(PChar(TempStr));
    {$Warnings On}

    if FTwainData.DllHandle <=  HINSTANCE_ERROR then
    begin
        { set DllHandle to 0 for proper clean up in UnloadTwain}
        FTwainData.DllHandle := 0;
        raise EScannerError.Create('LoadLibrary(' + TempStr + ') failed');
    end;

    TempStr := 'DSM_Entry';

    {$Warnings Off}
    FTwainData.DSMEntry := TDSM_Entry(GetProcAddress(
                                        FTwainData.DLLHandle, PChar(TempStr)));
    {$Warnings On}

    {$Warnings Off}
    if @FTwainData.DSMEntry = nil then
        raise EScannerError.Create('GetProcAddress failed: ' + TempStr);
    {$Warnings On}

    {$Warnings Off}
    FTwainData.ParentHandle := CreateWindow(
                                 PChar('STATIC'), PChar('Twain Window'),
                                 WS_POPUPWINDOW,
                                 Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT),
                                 Integer(CW_USEDEFAULT), Integer(CW_USEDEFAULT),
                                 HWND_DESKTOP,
                                 0,
                                 hInstance,
                                 nil);
    {$Warnings On}
    if FTwainData.ParentHandle = 0 then
        raise EScannerError.Create('CreateWindow failed');

    Handle32 := FTwainData.ParentHandle;
    {$Warnings Off}
    if not CallTriplet( nil, @FTwainData.AppId,
                        DG_CONTROL, DAT_PARENT, MSG_OPENDSM,
                        @Handle32, nil, FTwainData.DsmEntry) then
        raise EScannerError.Create(msgUnableToOpenTWAINSourceManager);
    {$Warnings On}

    { assert: TWAIN is currently in state 3, 'Source Manager Opened' }

    { get list of scanners }
    {$Warnings Off}
    if CallTriplet( nil, @FTwainData.AppId,
                    DG_CONTROL, DAT_IDENTITY, MSG_GETFIRST,
                    @Identity, nil, FTwainData.DsmEntry) then
    repeat
         FScanners.Add( Identity.ProductName );

         GetMem( pIdentity, SizeOf(TW_IDENTITY));
         pIdentity^ := Identity;

         FScanners.Objects[FScanners.Count-1] := TObject(pIdentity);
    until not CallTriplet( nil, @FTwainData.AppId,
                           DG_CONTROL, DAT_IDENTITY, MSG_GETNEXT,
                           @Identity, nil, FTwainData.DsmEntry);
    {$Warnings On}

    SetScannerIndexFromDefault;

end;

{--------------------------------------------------------------------------}

procedure TScanner.UnloadTwain;
var
    Handle32      : TW_INT32;
begin
    if FTwainData.ParentHandle <> 0 then
    begin
        Handle32 := FTwainData.ParentHandle;
        {$Warnings Off}
        CallTriplet( nil, @FTwainData.AppId,
                     DG_CONTROL, DAT_PARENT, MSG_CLOSEDSM, @Handle32,
                     nil, FTwainData.DsmEntry);
        {$Warnings On}

        DestroyWindow(FTwainData.ParentHandle);
        FTwainData.ParentHandle := 0;
    end;

    if FTwainData.DLLHandle <> 0 then
    begin
        FreeLibrary(FTwainData.DLLHandle);

        FTwainData.DLLHandle := 0;
        FTwainData.DSMEntry  := nil;
    end;
end;

{--------------------------------------------------------------------------}

function TScanner.SelectScanner : Boolean;
begin
    LoadTwain;

    FillChar(FTwainData.SourceId, SizeOf(FTwainData.SourceId), 0);

    {$Warnings Off}
    Result := CallTriplet( nil, @FTwainData.AppId,
                           DG_CONTROL, DAT_IDENTITY, MSG_USERSELECT,
                           @FTwainData.SourceId, nil, FTwainData.DsmEntry);
    {$Warnings On}

    SetScannerIndexFromDefault;
end;

{--------------------------------------------------------------------------}

procedure TScanner.SetScannerIndexFromDefault;
var
    Identity      : TW_IDENTITY;
    Index         : Integer;
begin
    {$Warnings Off}
    if not CallTriplet( nil, @FTwainData.AppId,
                        DG_CONTROL, DAT_IDENTITY, MSG_GETDEFAULT,
                        @Identity, nil, FTwainData.DsmEntry) then
    {$Warnings On}
         raise EScannerError.Create(msgUnableToGetTwainDefaultSource);

    Index := FScanners.IndexOf(Identity.ProductName);
    if Index >= 0 then
        FScannerIndex := Index;

    { Reset physical sizes on scanner change }
    FPhysicalWidth  := 0.0; //mdm 02/19/2003
    FPhysicalHeight := 0.0; //mdm 02/19/2003

end;

{--------------------------------------------------------------------------}

procedure TScanner.SetScannerIndex( const Index : Integer );
begin
    if (Index < 0) or (Index >= FScanners.Count) then
        Exit;

    FScannerIndex := Index;

    { Reset physical sizes on scanner change }
    FPhysicalWidth  := 0.0; //mdm 02/19/2003
    FPhysicalHeight := 0.0; //mdm 02/19/2003

end;

{--------------------------------------------------------------------------}

function TScanner.IsConfigured : Boolean;
begin
    { check is loaded first }
    Result := (FTwainData.DLLHandle <> 0);

    if not Result then
    begin
        Result := True;
        try
            LoadTwain;
        except
            Result := False;
        end;
    end;
end;

{--------------------------------------------------------------------------}

function Fix32ToSingle(const Fix32 : TW_FIX32) : Single;
begin
    Result := 1.0 * Fix32.Whole + (1.0 * Fix32.Frac / 65536.0);
end;

{--------------------------------------------------------------------------}

function SingleToFix32(const SingleValue : Single) : TW_FIX32;
var
    Value  : TW_INT32;
begin
    Value := TW_INT32(Round(SingleValue * 65536.0 + 0.50));
    Result.Whole := LOWORD(Value shr 16);
    Result.Frac  := LOWORD(Value and $0000FFFF);
end;

{--------------------------------------------------------------------------}

{ for debugging }
procedure ShowLayout( const Layout : TW_ImageLayout );
var
    Str : String;
begin
    Str := 'Frame.Left: ' + FloatToStr(Fix32ToSingle(Layout.Frame.Left)) + #13 +
           'Frame.Top: ' + FloatToStr(Fix32ToSingle(Layout.Frame.Top)) + #13 +
           'Frame.Right: ' + FloatToStr(Fix32ToSingle(Layout.Frame.Right)) + #13 +
           'Frame.Bottom: ' + FloatToStr(Fix32ToSingle(Layout.Frame.Bottom)) + #13 +
           Format( 'DocumentNumber: %d', [Layout.DocumentNumber]) + #13 +
           Format( 'PageNumber: %d', [Layout.PageNumber]) + #13 +
           Format( 'FrameNumber: %d', [Layout.FrameNumber]);

    MessageDlg(Str, mtInformation, [mbOk], 0);

end;

{--------------------------------------------------------------------------}

function TScanner.GetImageLayout( var Rect: TSingleRect ): Boolean;
var
    twRC          : TW_UINT16;
    twImageLayout : TW_IMAGELAYOUT;
begin
    if FTwainData.SourceID.ID = 0 then
        raise EScannerError.Create(msgTwainSourceMustBeOpen);

    FillChar(twImageLayout, SizeOf(twImageLayout), 0);
    {$Warnings Off}
    twRc := FTwainData.DsmEntry( @FTwainData.AppId, @FTwainData.SourceId,
                                 DG_IMAGE, DAT_IMAGELAYOUT, MSG_GET, @twImageLayout );
    {$Warnings On}
    case twRC of
        TWRC_SUCCESS :
        begin
            Rect.Left   := FIX32ToSingle( twImageLayout.Frame.Left );
            Rect.Top    := FIX32ToSingle( twImageLayout.Frame.Top );
            Rect.Right  := FIX32ToSingle( twImageLayout.Frame.Right );
            Rect.Bottom := FIX32ToSingle( twImageLayout.Frame.Bottom );
            Result      := True;

            //ShowLayout(twImageLayout);
        end
        else
        begin
            Rect.Left   := -1;
            Rect.Top    := -1;
            Rect.Right  := -1;
            Rect.Bottom := -1;
            Result      := False;
        end;
    end;
end;

{--------------------------------------------------------------------------}
{ MB Feb 26, 2001. Moved from .Acquire is this routine is now shared
  applies the current options in pTwainData^ to the currently opened
  source. }
{ mdm 02/18/2003.  Put in protected section of Scanner. }
procedure TScanner.ApplyOptions( var TwainData : TTwainData );
var
    Fix32     : TW_FIX32;
    PixelType : TW_UINT16;
    BitDepth  : TW_UINT16;

begin
    Fix32.Whole := TwainData.XDpi;
    Fix32.Frac  := 0;
    {$Warnings Off}
    SetSingleValueCap( ICAP_XRESOLUTION, TWTY_FIX32, Fix32.Long,
                       @TwainData.SourceId, @TwainData.AppId, TwainData.DsmEntry);
    {$Warnings On}

    Fix32.Whole := TwainData.YDpi;
    Fix32.Frac  := 0;
    {$Warnings Off}
    SetSingleValueCap( ICAP_YRESOLUTION, TWTY_FIX32, Fix32.Long,
                       @TwainData.SourceId, @TwainData.AppId, TwainData.DsmEntry);
    {$Warnings On}

    case TwainData.ImageFormat of

        ifBlackWhite :
        begin
            PixelType := TWPT_BW;
            BitDepth  := 1;
        end;

        ifGray16 :
        begin
            PixelType := TWPT_GRAY;
            BitDepth  := 4;
        end;

        ifGray256:
        begin
            PixelType := TWPT_GRAY;
            BitDepth  := 8;
        end;

        ifColor16 :
        begin
            PixelType := TWPT_PALETTE;
            BitDepth  := 4;
        end;

        ifColor256:
        begin
            PixelType := TWPT_PALETTE;
            BitDepth  := 8;
        end;

        ifTrueColor:
        begin
            PixelType := TWPT_RGB;
            BitDepth  := 24;
        end;

        else
            raise ETwainError.Create('Invalid image type');
    end; { case }

    { NOTE: pixel type must be set before bit depth }
    {$Warnings Off}
    SetSingleValueCap( ICAP_PIXELTYPE, TWTY_UINT16, PixelType,
                       @TwainData.SourceId, @TwainData.AppId, TwainData.DsmEntry);
    SetSingleValueCap( ICAP_BITDEPTH, TWTY_UINT16, BitDepth,
                       @TwainData.SourceId, @TwainData.AppId, TwainData.DsmEntry);

    { Turn off or on the source progress }
    SetSingleValueCap( CAP_INDICATORS, TWTY_BOOL, Integer(ShowUIProgress),
                       @TwainData.SourceId, @TwainData.AppId, TwainData.DsmEntry); //mdm 02/18/2003
    (* mdm 02/28/2003 - Testing
    SetSingleValueCap( ICAP_AUTOBRIGHT, TWTY_BOOL, 1,
                       @TwainData.SourceId, @TwainData.AppId, TwainData.DsmEntry); //mdm 02/18/2003
    *)
    {$Warnings On}
end; { ApplyOptions }

{--------------------------------------------------------------------------}

function TScanner.SetImageLayout( const Rect: TSingleRect ): Boolean;
var
    twRC          : TW_UINT16;
    twImageLayout : TW_IMAGELAYOUT;
begin
    if FTwainData.SourceID.ID = 0 then
        raise EScannerError.Create(msgTwainSourceMustBeOpen);

    FillChar(twImageLayout, SizeOf(twImageLayout), 0);
    {$Warnings Off}
    FTwainData.DsmEntry( @FTwainData.AppId, @FTwainData.SourceId, DG_IMAGE,
                         DAT_IMAGELAYOUT, MSG_GET, @twImageLayout );
    {$Warnings On}

    twImageLayout.Frame.Left   := SingleToFix32( Rect.Left );
    twImageLayout.Frame.Top    := SingleToFix32( Rect.Top );
    twImageLayout.Frame.Right  := SingleToFix32( Rect.Right );
    twImageLayout.Frame.Bottom := SingleToFix32( Rect.Bottom );

    {$Warnings Off}
    twRc := FTwainData.DsmEntry( @FTwainData.AppId, @FTwainData.SourceId,
                                 DG_IMAGE, DAT_IMAGELAYOUT, MSG_SET, @twImageLayout );
    {$Warnings On}
    Result := (twRC = TWRC_SUCCESS);
end;

{--------------------------------------------------------------------------}

procedure TScanner.Acquire( const AcquireEvent : TAcquireEvent;
                            const CallBackData : LongInt );
var
    WasEnabled    : Boolean;
    TwainUI       : TW_USERINTERFACE;
    pSourceID     : PTW_IDENTITY;

begin
    LoadTwain;

    {$Warnings Off}
    pSourceID     := Pointer(FScanners.Objects[FScannerIndex]);
    {$Warnings On}

    { The twain documentation on dg_control|dat_identity|msg_opends seems to
      indicate to pass the complete pSourceID obtained before to select
      explicitely the scanner. After testing, this was giving an error, and
      simply setting the ProductName seems to work fine. }
    FTwainData.SourceID.ProductName := pSourceID^.ProductName;

    {$Warnings Off}
    if not CallTriplet( nil, @FTwainData.AppId, DG_CONTROL, DAT_IDENTITY, MSG_OPENDS,
                        @FTwainData.SourceID, nil, FTwainData.DsmEntry) then
    {$Warnings On}
        raise ETwainError.Create(msgUnableToOpenTwainSource);

    try
        WasEnabled := not EnableWindow(FTwainData.ParentHandle, False);
        try
            { ensure native transfer mode is used }
            {$Warnings Off}
            SetSingleValueCap( ICAP_XFERMECH, TWTY_UINT16, TWSX_NATIVE,
                               @FTwainData.SourceId, @FTwainData.AppId, FTwainData.DsmEntry);

            { ensure any number of images may be scanned }
            SetSingleValueCap( CAP_XFERCOUNT, TWTY_INT16, -1,
                               @FTwainData.SourceId, @FTwainData.AppId, FTwainData.DsmEntry);

            { ensure units is inches }
            SetSingleValueCap( ICAP_UNITS, TWTY_UINT16, TWUN_INCHES,
                               @FTwainData.SourceId, @FTwainData.AppId, FTwainData.DsmEntry);
            {$Warnings On}

            if not FTwainData.ShowUI then
                ApplyOptions(FTwainData);

            FillChar(TwainUI, SizeOf(TwainUI), 0);
            TwainUI.ShowUI  := FTwainData.ShowUI;
            TwainUI.hParent := FTwainData.ParentHandle;

            {$Warnings Off}
            if not CallTriplet( @FTwainData.SourceId, @FTwainData.AppId,
                                DG_CONTROL, DAT_USERINTERFACE,
                                MSG_ENABLEDS, @TwainUI, nil, FTwainData.DsmEntry) then
            {$Warnings On}
                raise ETwainError.Create('Unable to enable twain source.');

            try
                {$Warnings Off}
                ProcessImages( AcquireEvent,
                               @FTwainData.SourceId, @FTwainData.AppId,
                               FTwainData.DsmEntry, CallBackData);
                {$Warnings On}
            finally
                {$Warnings Off}
                CallTriplet(
                    @FTwainData.SourceId, @FTwainData.AppId,
                    DG_CONTROL, DAT_USERINTERFACE, MSG_DISABLEDS, @TwainUI,
                    nil, FTwainData.DsmEntry);
                {$Warnings On}
            end;

        finally
            EnableWindow(FTwainData.ParentHandle, WasEnabled);
        end;

    finally
        if FTwainData.SourceId.Id <> 0 then
        begin
            {$Warnings Off}
            if not CallTriplet( nil, @FTwainData.AppId, DG_CONTROL, DAT_IDENTITY, MSG_CLOSEDS,
                                @FTwainData.SourceId, nil, FTwainData.DsmEntry) then
            {$Warnings On}
                raise ETwainError.Create('Unable to close TWAIN data source');

            FillChar(FTwainData.SourceId, SizeOf(FTwainData.SourceId), 0);
        end;
    end;
end;

{--------------------------------------------------------------------------}

procedure TScanner.OpenSource;
var
    pSourceID     : ^TW_IDENTITY;

begin
    LoadTwain;

    {$Warnings Off}
    pSourceID     := Pointer(FScanners.Objects[FScannerIndex]);
    {$Warnings On}

    { The twain documentation on dg_control|dat_identity|msg_opends seems to
      indicate to pass the complete pSourceID obtained before to select
      explicitely the scanner. After testing, this was giving an error, and
      simply setting the ProductName seems to work fine. }
    FTwainData.SourceID.ProductName := pSourceID^.ProductName;

    {$Warnings Off}
    if not CallTriplet( nil, @FTwainData.AppId, DG_CONTROL, DAT_IDENTITY, MSG_OPENDS,
                        @FTwainData.SourceID, nil, FTwainData.DsmEntry) then
    {$Warnings On}
        raise ETwainError.Create(msgUnableToOpenTwainSource);
    try
        { ensure native transfer mode is used }
        {$Warnings Off}
        SetSingleValueCap( ICAP_XFERMECH, TWTY_UINT16, TWSX_NATIVE,
                           @FTwainData.SourceId, @FTwainData.AppId, FTwainData.DsmEntry);

        { ensure any number of images may be scanned }
        SetSingleValueCap( CAP_XFERCOUNT, TWTY_INT16, -1,
                           @FTwainData.SourceId, @FTwainData.AppId, FTwainData.DsmEntry);

        { ensure units is inches }
        SetSingleValueCap( ICAP_UNITS, TWTY_UINT16, TWUN_INCHES,
                           @FTwainData.SourceId, @FTwainData.AppId, FTwainData.DsmEntry);
        {$Warnings On}

        { apply the options even if ShowUI is True, as this may set the default
          in the scanner's interface. }
        ApplyOptions(FTwainData);

    except
        CloseSource;
    end;
end;

{--------------------------------------------------------------------------}

procedure TScanner.AcquireWithSourceOpen( const AcquireEvent : TAcquireEvent;
                                          const CallBackData : LongInt );
var
    TwainUI       : TW_USERINTERFACE;
begin
    if FTwainData.SourceID.ID = 0 then
        raise EScannerError.Create(msgTwainSourceMustBeOpen);

    try
        { Options may have changed between scans if we're keeping the source open }
        if not FTwainData.ShowUI then
            ApplyOptions(FTwainData); //mdm 02/13/2003

        FillChar(TwainUI, SizeOf(TwainUI), 0);
        TwainUI.ShowUI  := FTwainData.ShowUI;
        TwainUI.hParent := FTwainData.ParentHandle;

        {$Warnings Off}
        if not CallTriplet( @FTwainData.SourceId, @FTwainData.AppId,
                            DG_CONTROL, DAT_USERINTERFACE,
                            MSG_ENABLEDS, @TwainUI, nil, FTwainData.DsmEntry) then
        {$Warnings On}
            raise ETwainError.Create('Unable to enable twain source.');

        {$Warnings Off}
        ProcessImages( AcquireEvent,
                       @FTwainData.SourceId, @FTwainData.AppId,
                       FTwainData.DsmEntry, CallBackData);
        {$Warnings On}

    finally
        {$Warnings Off}
        CallTriplet( @FTwainData.SourceId, @FTwainData.AppId,
                     DG_CONTROL, DAT_USERINTERFACE,
                     MSG_DISABLEDS, @TwainUI, nil, FTwainData.DsmEntry);
        {$Warnings On}
    end;
end;

{--------------------------------------------------------------------------}

procedure TScanner.CloseSource;
var
  TwainUI: TW_USERINTERFACE;
begin
    if FTwainData.SourceId.Id <> 0 then
    begin
        try
            FillChar(TwainUI, SizeOf(TwainUI), 0);
            TwainUI.ShowUI  := FTwainData.ShowUI;
            TwainUI.hParent := FTwainData.ParentHandle;

            {$Warnings Off}
            CallTriplet(
                @FTwainData.SourceId, @FTwainData.AppId,
                DG_CONTROL, DAT_USERINTERFACE, MSG_DISABLEDS, @TwainUI,
                nil, FTwainData.DsmEntry);
            {$Warnings On}

        finally
            {$Warnings Off}
            if not CallTriplet( nil, @FTwainData.AppId, DG_CONTROL, DAT_IDENTITY, MSG_CLOSEDS,
                                @FTwainData.SourceId, nil, FTwainData.DsmEntry) then
            {$Warnings On}
                raise ETwainError.Create('Unable to close TWAIN data source');

            FillChar(FTwainData.SourceId, SizeOf(FTwainData.SourceId), 0);
        end;
    end;
end;

{--------------------------------------------------------------------------}

function TScanner.EnableFeeder: Boolean;
var
    Cap     : TW_CAPABILITY;
    p       : pTW_ONEVALUE;
    Status  : TW_INT16;
begin
    LoadTwain;
    Cap.Cap        := CAP_FEEDERENABLED;
    Cap.ConType    := TWON_ONEVALUE;
    Cap.hContainer := 0;
    {$Warnings Off}
    status := FTwainData.DsmEntry( @FTwainData.AppId, @FTwainData.SourceId,
                                   DG_CONTROL, DAT_CAPABILITY, MSG_GET,
                                   TW_MEMREF(@Cap) );
    {$Warnings On}
    if Status <> TWRC_SUCCESS then
    begin
        GlobalFree( Cap.hContainer );
        Result := False;
    end
    else
    begin
        p := pTW_ONEVALUE(GlobalLock( cap.hContainer ));
        if Boolean(p^.Item) = True then
        begin
            GlobalUnlock( cap.hContainer );
            GlobalFree( cap.hContainer );
            Result := True;
        end
        else
        begin
            p^.ItemType := TWTY_BOOL;
            p^.Item     := Cardinal(True);
            GlobalUnlock( cap.hContainer );
            {$Warnings Off}
            status := FTwainData.DsmEntry( @FTwainData.appID, @FTwainData.SourceId,
                                           DG_CONTROL, DAT_CAPABILITY, MSG_SET,
                                           TW_MEMREF(@cap) );
            {$Warnings On}
            GlobalFree( cap.hContainer );
            if Status = TWRC_SUCCESS then
                Result := True
            else
                Result := False;
        end;
    end;
end;

{--------------------------------------------------------------------------}

function TScanner.DisableFeeder: Boolean;
var
    Cap    : TW_CAPABILITY;
    p      : pTW_ONEVALUE;
    Status : TW_INT16;
begin
    LoadTwain;
    Cap.Cap        := CAP_FEEDERENABLED;
    Cap.ConType    := TWON_ONEVALUE;
    Cap.hContainer := 0;
    { get feeder status }
    {$Warnings Off}
    Status := FTwainData.DsmEntry( @FTwainData.AppId,
                                   @FTwainData.SourceId, DG_CONTROL, DAT_CAPABILITY, MSG_GET,
                                   TW_MEMREF(@Cap) );
    {$Warnings On}
    if Status <> TWRC_SUCCESS then
    begin
        { error or no feeder support }
        GlobalFree( CAp.hContainer );
        Result := False;
    end
    else
    begin
        { check feeder status }
        p := pTW_ONEVALUE(GlobalLock( cap.hContainer ));
        if Boolean(p^.Item) = True then
        begin
            { feeder is enabled }
            GlobalUnlock( cap.hContainer );
            p.ItemType := TWTY_BOOL;
            p.Item := Cardinal(False);
            GlobalUnlock( cap.hContainer );
            { disable feeder }
            {$Warnings Off}
            Status := FTwainData.DsmEntry( @FTwainData.appID,
                                           @FTwainData.SourceId, DG_CONTROL, DAT_CAPABILITY, MSG_SET,
                                           TW_MEMREF(@cap) );
            {$Warnings On}
            GlobalFree( cap.hContainer );
            if Status = TWRC_SUCCESS then
                Result := True
            else
                Result := False;

            GlobalFree( cap.hContainer );
            Cap.Cap        := CAP_FEEDERENABLED;
            Cap.ConType    := TWON_ONEVALUE;
            Cap.hContainer := 0;
            { check if feeder is really disabled }
            {$Warnings Off}
            status := FTwainData.DsmEntry( @FTwainData.AppId,
                                           @FTwainData.SourceId, DG_CONTROL, DAT_CAPABILITY, MSG_GET,
                                           TW_MEMREF(@Cap) );
            {$Warnings On}
            if Status = TWRC_SUCCESS then
            begin
              p := pTW_ONEVALUE(GlobalLock( cap.hContainer ));
              if Boolean(p.Item) = True then
                  Result := False
              else
                  Result:= True;
            end;
        end
        else
        begin
            Result := True;
            GlobalUnlock( cap.hContainer );
            GlobalFree( cap.hContainer );
        end;
    end;
end;

{--------------------------------------------------------------------------}

function TScanner.FeederLoaded: Boolean;
var
  Cap    : TW_CAPABILITY;
  Status : TW_INT16;
  p      : pTW_ONEVALUE;
begin
    LoadTwain;
    Cap.Cap      := CAP_FEEDERLOADED;
    Cap.ConType  := TWON_DONTCARE16;
    {$Warnings Off}
    status       := FTwainData.DsmEntry( @FTwainData.AppId,
                                         @FTwainData.SourceId, DG_CONTROL, DAT_CAPABILITY, MSG_GET,
                                         @Cap );
    {$Warnings On}
    if status <> TWRC_SUCCESS then
        Result := False
    else
    begin
        p := pTW_ONEVALUE(GlobalLock( Cap.hContainer ) );
        if Boolean(p^.Item) = True then
            Result := True
        else
            Result := False;
        GlobalUnlock( cap.hContainer );
        GlobalFree( cap.hContainer );
    end;
end;

{--------------------------------------------------------------------------}

//mdm 02/18/2003 
function TScanner.GetPhysicalSize(ICap: TW_UINT16): Single;
var
  Cap    : TW_CAPABILITY;
  Status : TW_INT16;
  p      : pTW_ONEVALUE;
begin
  { Added 02/19/2003 - MDM }

  if (FTwainData.SourceID.ID = 0) then
      raise EScannerError.Create(msgTwainSourceMustBeOpen);

  Result       := -1.0;

  Cap.Cap      := ICap;
  Cap.ConType  := TWON_DONTCARE16;
  {$Warnings Off}
  { ensure units is inches }
  SetSingleValueCap( ICAP_UNITS,
                     TWTY_UINT16,
                     TWUN_INCHES,
                     @FTwainData.SourceId,
                     @FTwainData.AppId,
                     FTwainData.DsmEntry);

  status := FTwainData.DsmEntry( @FTwainData.AppId,
                                 @FTwainData.SourceId,
                                 DG_CONTROL,
                                 DAT_CAPABILITY,
                                 MSG_GET,
                                 @Cap );
  {$Warnings On}
  if status = TWRC_SUCCESS then begin
      p := pTW_ONEVALUE(GlobalLock( Cap.hContainer ) );
      Result := Fix32ToSingle(TW_FIX32(p^.Item));
      GlobalUnlock( cap.hContainer );
      GlobalFree( cap.hContainer );
  end
  else
      ShowMessage('Failed to get physical dimension.')

end; // function GetPhysicalSize: Single

{--------------------------------------------------------------------------}

initialization

    InstanceCreated := False;
    GlobalScanner   := nil;

finalization

    if GlobalScanner <> nil then
         GlobalScanner.Free;

end.
