//------------------------------------------------------------------------------
// Component         TASGCapture
// Version:          4.1
// Date:             26 July 2005
// Compilers:        Delphi 4 - Delphi 7
// Author:           William Miller - w2m@hicomponents.com
// Copyright:        © 1992-2005 Adirondack Software & Graphics
// Latest version    http://www.hicomponents.com/apprehend                                                                         *
// Licence to use, terms and conditions:
//                   The code in the TASGCapture component is released as freeware
//                   provided you agree to the following terms & conditions:
//                   1. the copyright notice, terms and conditions are
//                   left unchanged
//                   2. modifications to the code by other authors must be
//                   clearly documented and accompanied by the modifier's name.
//                   3. the TASGCapture component may be freely compiled into binary
//                   format and no acknowledgement is required. However, a
//                   discrete acknowledgement would be appreciated (eg. in a
//                   program's 'About Box' and/or help file).
//
// Description:      Component to capture bitmaps of the screen.
//
// Acknowledgements: The key multimonitor portions in this component is developed by:
//                   Chris Thornton - www.thornsoft.com
//                   "Mouser" - www.donationcoder.com
//
// History: 1992-1999 - Developed screen capture routines
//          July 4, 2000.       William Miller, first BETA version
//          July 13, 2000.      William Miller, 2nd BETA version
//                              Changed CaptureRect.Pas to paint the rubberband
//                              on the form instead of a TImage to eliminate screen flicker.
//          July 15, 2000.      William Miller, 3nd BETA version
//                              Added animated rubberbanding and version property
//          September 21, 2000. William Miller. Compiled Release 1.0
//          October 20, 2001.   William Miller. Delphi 6 Build Release 1.5
//          March 16, 2002.     William Miller. Added ShowCursor Property
//          May 20, 2002.       Added capture cursor option to capturedesktop
//          June 23, 2002.      Added capture polygon function
//          September 28, 2003. Modified demos, added Delphi 7 package
//          June 24, 2004.      Added ShowHint property and CaptureREct Hint
//          April 13, 2005.     Multi-Monitor support (Object, Rectangle, Desktop,
//                              WholeDesktop) (Chris Thornton - www.thornsoft.com)
//          April 18, 2005.     Bitmap exposed (Chris Thornton)
//          May 26, 2005.       Added CaptureIcon function (32x32 area)
//          June 02, 2005.      Added Specific Size Selection, Various Multimonitor
//                              changes by ( Mouser )
//          June 06, 2005.      Various Multimonitor changes by Chris Thornton
//                              Bugfix, CaptureRect appeared on the wrong monitor
//                              BugFix, runtime error in the marching ants routine
//                              Monitor: New property that affects the screen and
//                              rectangle capturing. Instead of relying on the cursor to
//                              determine the screen to capture from, you can now
//                              override by setting a MonitorNum=0,1,2,3,etc. property.
//                              Default of -1 causes it to use monitor where the mouse is
//                              located
//          June 19, 2005.      Final 4.02 Release fizes...
//                              Multimonitor polygon fixes by ( Mouser )
//          June 26, 2005.      SpeedCapture function developed
//                              Fix for pixelformat problems
//
// "Mouser", 5/12/05
// Capturing large bitmaps very frequently caused crashing of my applications
// with insufficient memory type errors.
// After some time I tracked down this newsgroup post which suggests that
// the cure is to set the bitmap object to 24bits per pixel prior to filling it.
// See -> http://groups-beta.google.com/group/borland.public.delphi.graphics/browse_thread/thread/2575992b6bd62e66/203f09c94f0b1396?q=bitmap+delphi+%22not+enough+storage+is+available+to+process+this+command%22&rnum=1&hl=en#203f09c94f0b1396
//
// Other Added Features
//  functions for capturing specific HWND or TControl
//  auto determine active foreground window location in bitmap
//  fix for memory faults (see above)
//  capturing cursors during multimon capture
//  fixed cursor capture from active window
//
// if the following is defined and if ShowCursor is true
// then there is no prompt to position the cursor

unit ASGCapture;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Menus, Clipbrd, PixelFormatFix;

const
  ASG_COMPONENT_VERSION = '4.1';

type
  TASGScreenCapture = class ( TComponent )
  private
    fAutomatic: Boolean; // send image to clipboard
    fBitmap: TBitmap; // captured bitmap
    fDelay: Integer; // time needs for screen refresh
    // delay for screen refresh - may be set by enduser in Delay property
    fMinimized: Boolean; // minimise the form before capture
    fShowHint: Boolean; // show hint in CaptureRect
    fShowCursor: Boolean; // show the cursor in capturedesktop
    fOnCapture: TNotifyEvent; // fires after capture
    fMonitorNum: Integer; // force THIS screen in multi-monitor system
    fWidth: integer;
    fHeight: integer;
    procedure SetDelay ( const Value: Integer );
    procedure SetAutomatic ( const Value: Boolean );
    procedure SetMinimized ( const Value: Boolean );
    procedure SetCursor ( const Value: Boolean );
    procedure SetShowHint ( const Value: Boolean );
    function GetVersion: string;
    procedure SetVersion ( const Val: string );
    procedure CopyToClipboard;
  // Mouser, 5/15/05 - these provide support for auto-detecting active window
  //  so that caller can know where in the bitmap image the active window was.  this is used in my screenshot
  //  capture app to highlight the current window in screenshots.
  private
    fObjectLeft: Integer; // x pos of active object (during desktop capture)
    fObjectTop: Integer; // y pos of active object (during desktop capture)
    fObjectWidth: Integer; // width pos of active object (during desktop capture)
    fObjectHeight: Integer; // height pos of active object (during desktop capture)
  public
    property Bitmap: TBitmap read fBitmap; // Moved to "public", to expose to parent form.
    constructor Create ( AOwner: TComponent ); override;
    destructor Destroy; override;
    // Capture the desktop
    function CaptureDesktop: TBitmap;
    // Speed capture the desktop
    function SpeedCaptureDesktop: TBitmap;
    // Capture a bitmap image of the active window
    function CaptureWholeDesktop: TBitmap;
    // Capture a bitmap image of the whole desktop
    function CaptureActiveWindow: TBitmap;
    // Capture a bitmap of a selected object (Window, button, toolbar)
    function CaptureObject: TBitmap;
    // Capture a bitmap of a selected area
    function CaptureSelection: TBitmap;
    // Capture a bitmap of freehand selected area
    function CapturePolygon: TBitmap;
    // Capture a bitmap of 32x32 selected area
    function CaptureIcon: TBitmap;
    // Capture a bitmap of WidthxHeight selected area
    function CaptureSpecificSizeSelection ( CaptureWidth: integer; CaptureHeight: integer ): TBitmap;
    // ATTN: Mouser (www.donationcoder.com), 5/10/05 - you can manually capture an object or TControl
    //  very useful for capturing image of a specific form for example without user interaction, so you can print it, etc.
    function CaptureObjectByHWND ( const Handles: Integer ): TBitmap;
    function CaptureObjectByTControlp ( const tcontrolp: TControl ): TBitmap;
  published
    // If Automatic is true then copy captured bitmap to clipboard
    property Auto: Boolean read fAutomatic write fAutomatic default True;
    // Setting for Screen Refresh Time
    property Delay: Integer read fDelay write fDelay default 500;
    // If Minimize is true then the mainform of the application is
    // minimized and restored during screen capture
    property Minimize: Boolean read fMinimized write fMinimized default True;
    // show or hide cursor during screen capture
    property ShowCursor: Boolean read fShowCursor write fShowCursor default True;
    // If ShowHint is true then a hint is shown in DrawRect
    property ShowHint: Boolean read fShowHint write fShowHint default True;
    property OnCapture: TNotifyEvent read fOnCapture write fOnCapture;
    // Show component version
    property Version: string read GetVersion write SetVersion stored FALSE;
    // Force any particular screen with multi-monitor setup here.
    property MonitorNum: Integer read fMonitorNum write fMonitorNum default -1;
    // ATTN: Mouser, 5/15/05 - these provide support for auto-detecting active window
    //  so that caller can know where in the bitmap image the active window was.  this is used in my screenshot
    //  capture app to highlight the current window in screenshots.
    property ObjectLeft: Integer read fObjectLeft write fObjectLeft default 0;
    property ObjectTop: Integer read fObjectTop write fObjectTop default 0;
    property ObjectWidth: Integer read fObjectWidth write fObjectWidth default 0;
    property ObjectHeight: Integer read fObjectHeight write fObjectHeight default 0;
  end;

procedure Register;

implementation

uses
  CaptureTheDesktop, { for CaptureTheDesktop Form - nneded for cursor and onkey event }
  CaptureTheObject, { for CaptureTheObject Form  - needed for cursor }
  CaptureTheRect, { for CaptureTheRect Form  - needed for animated rubberbanding }
  CaptureFreeHand, { for CaptureFreehand form - needed for prompt dialog, cursor and selection }
  CaptureIcon, { for CaptureIcon Form  - needed for animated rubberbanding }
  CaptureSpecificRect, { for SpecificRect Form  - needed for animated rubberbanding }
  PromptDialog; { for prompt dialog }

// Create the component
constructor TASGScreenCapture.Create ( AOwner: TComponent );
begin
  inherited Create ( AOwner );
  fAutomatic := True;
  fMinimized := True;
  fShowCursor := False;
  fShowHint := True;
  fDelay := 500;
  fBitmap := TBitmap.Create;
  fWidth := 32;
  fHeight := 32;
  fMonitorNum := -1;
  DoPixelFormatFix ( fBitmap );
  SetDelay ( fDelay );
  SetAutomatic ( fAutomatic );
  SetMinimized ( FMinimized );
  SetCursor ( fShowCursor );
  SetShowHint ( fShowHint );
end;

// Destroy the component
destructor TASGScreenCapture.Destroy;
begin
  fBitmap.Free;
  inherited Destroy;
end;

// Set delay for screen refresh
procedure TASGScreenCapture.SetDelay ( const Value: Integer );
begin
  fDelay := Value;
end;

// Set minimized property
procedure TASGScreenCapture.SetMinimized ( const Value: Boolean );
begin
  if Value <> fMinimized then
    fMinimized := Value;
end;

// Set automatic property
procedure TASGScreenCapture.SetAutomatic ( const Value: Boolean );
begin
  fAutomatic := Value;
end;

// Get showcursor value
procedure TASGScreenCapture.SetCursor ( const Value: Boolean );
begin
  if Value <> fShowCursor then
    fShowCursor := Value;
end;

// Set showhint property
procedure TASGScreenCapture.SetShowHint ( const Value: Boolean );
begin
  fShowHint := Value;
end;

// Get version property
function TASGScreenCapture.GetVersion: string;
begin
  Result := ASG_COMPONENT_VERSION;
end;

// Set version property
procedure TASGScreenCapture.SetVersion ( const Val: string );
begin
  // Empty write method, just needed to get it to show up in Object Inspector
end;

// Copies bitmap to clipboard
procedure TASGScreenCapture.CopyToClipboard;
begin
  Clipboard.Assign ( fBitmap );
end;

// Capture Image of Screen or windows Desktop
// Multi-Monitor by Chris Thornton 04/14/2005
// Note: Multi-Monitor aware, but only captures CURRENT monitor only.
//       Use CaptureWholeDesktop for wide-format, multi-monitor capture.
function TASGScreenCapture.CaptureDesktop: TBitmap;
var
  Handles: HWND;
  ScreenDC: HDC;
  Rect: TRect;
  lpPal: PLogPalette;
  CursorInfo: TCursorInfo;
  hCursor: HIcon;
  rCursor: TIconInfo;
  iCursorLeft: integer;
  iCursorTop: integer;
  iMouseThread: Cardinal;
  iCurrentThread: Cardinal;
  P: TPoint;
  // Mouser, 5/15/05 - support for identifying active foreground window
  ActHandles: HWnd;
  ActRect: TRect;
  // Mouser - for deciding what monitor we are on
  M: Integer;
  dml: Integer;
  dmt: Integer;
begin
  // Get mainform out of the way
  if fMinimized then
    Application.Minimize;
  // Give screen time to refresh by delay
  Sleep ( fDelay );
  Result := nil;
  CaptureTheDesktop.ForceMonitorNum := fMonitorNum; // Thornsoft - capture from specific monitor
  // Mouser, 5/15/05 - support for identifying active foreground window
  ActHandles := GetForegroundWindow ( );
  ScreenDC := GetWindowDC ( ActHandles );
  try
    GetWindowRect ( ActHandles, ActRect );
    fObjectLeft := ActRect.Left;
    fObjectTop := ActRect.Top;
    fObjectWidth := ActRect.Right - ActRect.Left;
    fObjectHeight := ActRect.Bottom - ActRect.Top;
  finally; ReleaseDC ( ActHandles, ScreenDC ); end;
  if fShowCursor then
  begin
    CaptureDesktopForm := TCaptureDesktopForm.Create ( Self );
    try
      // If property set (larger than -1), CaptureDesktopForm.M will now be fMonitorNum
      // Show info dialog - then freed by parent CaptureDesktopForm
      frmPosition := TfrmPosition.Create ( CaptureDesktopForm );
      frmPosition.Left := Screen.Monitors [ CaptureDesktopForm.M ].Width - frmPosition.Width;
      frmPosition.Top := Screen.Monitors [ CaptureDesktopForm.M ].Top;
      frmPosition.Show;
      frmPosition.Update;
      if CaptureDesktopForm.ShowModal = mrOK then
      begin
        // Give screen time to refresh by delay
        Sleep ( fDelay );
        Handles := GetDesktopWindow ( );
        ScreenDC := GetDC ( Handles );
        try
          GetWindowRect ( Handles, Rect );
          // ATTN: Mouser (www.donationcoder.com), 5/18/05 - needs correction for multimon case (note this code is never called by me since i have this block tested on FALSE)
          fObjectLeft := ActRect.Left - CaptureDesktopForm.Left;
          fObjectTop := ActRect.Top - CaptureDesktopForm.Top;
        // Do we have a palette device? - Thanks to Joe C. Hecht
          if ( GetDeviceCaps ( ScreenDC, RASTERCAPS ) and RC_PALETTE = RC_PALETTE ) then
          begin
          // Allocate memory for a logical palette
            GetMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) );
            try
          // Zero it out to be neat
              FillChar ( lpPal^, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ),
                #0 );
          // Fill in the palette version
              lpPal^.palVersion := $300;
          // Grab the system palette entries
              lpPal^.palNumEntries :=
                GetSystemPaletteEntries ( ScreenDC, 0, 256, lpPal^.palPalEntry );
              if ( lpPal^.PalNumEntries <> 0 ) then
            // Create the palette
                fBitmap.Palette := CreatePalette ( lpPal^ );
            finally; FreeMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) ); end;
          end;
          fBitmap.Width := Screen.Monitors [ CaptureDesktopForm.M ].Width;
          fBitmap.Height := Screen.Monitors [ CaptureDesktopForm.M ].Height;
          BitBlt ( fBitmap.Canvas.Handle, 0, 0, fBitmap.Width, fBitmap.Height,
            CaptureDesktopForm.fBmp.Canvas.Handle, 0, 0, SRCCOPY );
            // Get cursor information
          GetCursorPos ( P );
          CursorInfo.cbSize := SizeOf ( CursorInfo );
          GetCursorInfo ( CursorInfo );
          iMouseThread := GetWindowThreadProcessId ( WindowFromPoint ( P ), nil );
          iCurrentThread := GetCurrentThreadId ( );
          if iCurrentThread = iMouseThread then
            hCursor := GetCursor ( )
          else
          begin
            AttachThreadInput ( iCurrentThread, iMouseThread, True );
            hCursor := GetCursor ( );
            AttachThreadInput ( iCurrentThread, iMouseThread, False );
          end;
            // determine absolute position of cursor image
          GetIconInfo ( hCursor, rCursor );
          iCursorLeft := P.X - Integer ( rCursor.xHotspot );
          iCursorTop := P.Y - Integer ( rCursor.yHotspot );
          DrawIconEx ( fBitmap.Canvas.Handle, iCursorLeft - Screen.Monitors [ CaptureDesktopForm.M ].Left,
            iCursorTop - Screen.Monitors [ CaptureDesktopForm.M ].Top, CursorInfo.hCursor, 0,
            0, 0, 0, DI_NORMAL );
        finally ReleaseDC ( Handles, ScreenDC ); end;
        Result := TBitmap.Create;
        DoPixelFormatFix ( Result );
        Result.Assign ( fBitmap );
        if fAutomatic then
          CopyToClipboard;
        if Assigned ( fOnCapture ) then
          fOnCapture ( Self );
      end;
    finally; CaptureDesktopForm.Free; end;
  end
  else
  begin
      // If property set (larger than -1), CaptureDesktopForm.M will now be fMonitorNum
    Handles := GetDesktopWindow ( );
    ScreenDC := GetDC ( Handles );
    try
    // Mouser, 5/12/05 -  get cursor before showing form in case we want to overlay it
      GetCursorPos ( P );
      CursorInfo.cbSize := SizeOf ( CursorInfo );
      GetCursorInfo ( CursorInfo );
      // Mouser - decide what monitor to capture from
      if ( fMonitorNum >= 0 ) and ( fMonitorNum <= Screen.MonitorCount - 1 ) then
        M := fMonitorNum {Override}
      else
        M := Screen.MonitorFromPoint ( P, mdNearest ).MonitorNum; // Here I am!  Monitors[M]
      // decide left, top, width, heighy
      dml := Screen.Monitors [ M ].Left;
      dmt := Screen.Monitors [ M ].Top;
      // Mouser, 5/18/05 -  correct for multimon capture
      fObjectLeft := ActRect.Left - dml;
      fObjectTop := ActRect.Top - dmt;
      P.X := P.X - dml;
      P.Y := P.Y - dmt;
      GetWindowRect ( Handles, Rect );
      // Do we have a palette device? - Thanks to Joe C. Hecht
      if ( GetDeviceCaps ( ScreenDC, RASTERCAPS ) and RC_PALETTE = RC_PALETTE ) then
      begin
        // Allocate memory for a logical palette
        GetMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) );
        try
        // Zero it out to be neat
          FillChar ( lpPal^, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ),
            #0 );
        // Fill in the palette version
          lpPal^.palVersion := $300;
        // Grab the system palette entries
          lpPal^.palNumEntries :=
            GetSystemPaletteEntries ( ScreenDC, 0, 256, lpPal^.palPalEntry );
          if ( lpPal^.PalNumEntries <> 0 ) then
          // Create the palette
            fBitmap.Palette := CreatePalette ( lpPal^ );
        finally; FreeMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) ); end;
      end;
      fBitmap.Width := Screen.Monitors [ M ].Width;
      fBitmap.Height := Screen.Monitors [ M ].Height;
        // Mouser - Need to take multiple monitors into consideration here too - new way grabs from screen
        //BitBlt ( fBitmap.Canvas.Handle, 0, 0, fBitmap.Width, fBitmap.Height, CaptureDesktopForm.fBmp.Canvas.Handle, 0, 0, SRCCOPY );
      BitBlt ( fBitmap.Canvas.handle, 0, 0, Screen.Monitors [ M ].Width, Screen.Monitors [ M ].Height, ScreenDC, Screen.Monitors [ M ].Left, Screen.Monitors [ M ].Top, srcCopy );
        // Mouser, 5/18/05 - ok here is our improved mouse cursor capture code
      if fShowCursor then
      begin
          // To overlay cursor on screen dump
        if ( P.X > 0 ) and ( P.Y > 0 ) and ( P.X < fBitmap.Width - 16 ) and ( P.Y < fBitmap.Height - 16 ) then
        begin
          DrawIconEx ( fBitmap.Canvas.Handle, P.X, P.Y, CursorInfo.hCursor, 0, 0, 0, 0, DI_NORMAL );
        end
      end;
    finally ReleaseDC ( Handles, ScreenDC ); end;
    Result := TBitmap.Create;
    DoPixelFormatFix ( Result );
    Result.Assign ( fBitmap );
    if fAutomatic then
      CopyToClipboard;
    if Assigned ( fOnCapture ) then
      fOnCapture ( Self );
  end;
  if fMinimized then
    // Restore mainform to original state
    Application.Restore;
end;

function TASGScreenCapture.SpeedCaptureDesktop: TBitmap;
var
  Handles: HWND;
  ScreenDC: HDC;
  Rect: TRect;
  lpPal: PLogPalette;
  CursorInfo: TCursorInfo;
  P: TPoint;
  ActHandles: HWnd;
  ActRect: TRect;
  M: Integer;
  dml: Integer;
  dmt: Integer;
begin
  // Get mainform out of the way
  if fMinimized then
    Application.Minimize;
  // Give screen time to refresh by delay
  Sleep ( fDelay );
  CaptureTheDesktop.ForceMonitorNum := fMonitorNum; // Thornsoft - capture from specific monitor
  // Mouser, 5/15/05 - support for identifying active foreground window
  ActHandles := GetForegroundWindow ( );
  ScreenDC := GetWindowDC ( ActHandles );
  try
    GetWindowRect ( ActHandles, ActRect );
    fObjectLeft := ActRect.Left;
    fObjectTop := ActRect.Top;
    fObjectWidth := ActRect.Right - ActRect.Left;
    fObjectHeight := ActRect.Bottom - ActRect.Top;
  finally; ReleaseDC ( ActHandles, ScreenDC ); end;
  Handles := GetDesktopWindow ( );
  ScreenDC := GetDC ( Handles );
  try
    // Mouser, 5/12/05 -  get cursor before showing form in case we want to overlay it
    GetCursorPos ( P );
    CursorInfo.cbSize := SizeOf ( CursorInfo );
    GetCursorInfo ( CursorInfo );
    // Mouser - decide what monitor to capture from
    if ( fMonitorNum >= 0 ) and ( fMonitorNum <= Screen.MonitorCount - 1 ) then
      M := fMonitorNum {Override}
    else
      M := Screen.MonitorFromPoint ( P, mdNearest ).MonitorNum; // Here I am!  Monitors[M]
      // Decide left, top, width, height
    dml := Screen.Monitors [ M ].Left;
    dmt := Screen.Monitors [ M ].Top;
    // Mouser, 5/18/05 -  correct for multimon capture
    fObjectLeft := ActRect.Left - dml;
    fObjectTop := ActRect.Top - dmt;
    P.X := P.X - dml;
    P.Y := P.Y - dmt;
    GetWindowRect ( Handles, Rect );
      // Do we have a palette device? - Thanks to Joe C. Hecht
    if ( GetDeviceCaps ( ScreenDC, RASTERCAPS ) and RC_PALETTE = RC_PALETTE ) then
    begin
        // Allocate memory for a logical palette
      GetMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) );
      try
        // Zero it out to be neat
        FillChar ( lpPal^, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ), #0 );
        // Fill in the palette version
        lpPal^.palVersion := $300;
        // Grab the system palette entries
        lpPal^.palNumEntries :=
          GetSystemPaletteEntries ( ScreenDC, 0, 256, lpPal^.palPalEntry );
        if ( lpPal^.PalNumEntries <> 0 ) then
          // Create the palette
          fBitmap.Palette := CreatePalette ( lpPal^ );
      finally; FreeMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) ); end;
    end;
    fBitmap.Width := Screen.Monitors [ M ].Width;
    fBitmap.Height := Screen.Monitors [ M ].Height;
      // Mouser - Need to take multiple monitors into consideration here too - grabs from screen
    BitBlt ( fBitmap.Canvas.handle, 0, 0, Screen.Monitors [ M ].Width, Screen.Monitors [ M ].Height, ScreenDC, Screen.Monitors [ M ].Left, Screen.Monitors [ M ].Top, srcCopy );
      // Mouser, 5/18/05 - ok here is our improved mouse cursor capture code
    if fShowCursor then
    begin
        // To overlay cursor on screen dump
      if ( P.X > 0 ) and ( P.Y > 0 ) and ( P.X < fBitmap.Width - 16 ) and ( P.Y < fBitmap.Height - 16 ) then
      begin
        DrawIconEx ( fBitmap.Canvas.Handle, P.X, P.Y, CursorInfo.hCursor, 0, 0, 0, 0, DI_NORMAL );
      end
    end;
  finally ReleaseDC ( Handles, ScreenDC ); end;
  Result := TBitmap.Create;
  DoPixelFormatFix ( Result );
  Result.Assign ( fBitmap );
  if fAutomatic then
    CopyToClipboard;
  if Assigned ( fOnCapture ) then
    fOnCapture ( Self );
  if fMinimized then
    // Restore mainform to original state
    Application.Restore;
end;

// CaptureWholeDesktop
function TASGScreenCapture.CaptureWholeDesktop: TBitmap;
var
  Handles: HWND;
  ScreenDC: HDC;
  lpPal: PLogPalette;
  // ATTN: Mouser, 5/15/05 - support for identifying active foreground window, and grabbing cursor
  P: TPoint;
  w: Integer;
  h: Integer;
  ActHandles: HWnd;
  ActRect: TRect;
  CursorInfo: TCursorInfo;
begin
  // Get mainform out of the way
  if fMinimized then
    Application.Minimize;
  // Give screen time to refresh by delay
  Sleep ( fDelay );
  // Mouser, 5/15/05 - support for identifying active foreground window
  ActHandles := GetForegroundWindow ( );
  ScreenDC := GetWindowDC ( ActHandles );
  try
    GetWindowRect ( ActHandles, ActRect );
    fObjectLeft := ActRect.Left - 0;
    fObjectTop := ActRect.Top - 0;
    fObjectWidth := ActRect.Right - ActRect.Left;
    fObjectHeight := ActRect.Bottom - ActRect.Top;
  finally; ReleaseDC ( ActHandles, ScreenDC ); end;
  // Mouser, 5/18/05 - needs correction for multimon case
  fObjectLeft := ActRect.Left - Screen.DesktopLeft;
  fObjectTop := ActRect.Top - Screen.DesktopTop;
  // Mouser, 5/12/05 -  get cursor before showing form in case we want to overlay it
  GetCursorPos ( P );
  CursorInfo.cbSize := SizeOf ( CursorInfo );
  GetCursorInfo ( CursorInfo );
  begin
    Handles := GetDesktopWindow ( );
    ScreenDC := GetDC ( Handles );
    try
      // Do we have a palette device? - Thanks to Joe C. Hecht
      if ( GetDeviceCaps ( ScreenDC, RASTERCAPS ) and RC_PALETTE = RC_PALETTE ) then
      begin
        // Allocate memory for a logical palette
        GetMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) );
        try
        // Zero it out to be neat
          FillChar ( lpPal^, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ),
            #0 );
        // Fill in the palette version
          lpPal^.palVersion := $300;
        // Grab the system palette entries
          lpPal^.palNumEntries :=
            GetSystemPaletteEntries ( ScreenDC, 0, 256, lpPal^.palPalEntry );
          if ( lpPal^.PalNumEntries <> 0 ) then
          // Create the palette
            fBitmap.Palette := CreatePalette ( lpPal^ );
        finally; FreeMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) ); end;
      end;
        // Simply draw the whole desktop from 0,0 onto the big, wide bitmap.
        // Mouser, 5/18/05 - needs correction for multimon case  (?)
      w := Screen.DesktopWidth;
      h := Screen.DesktopHeight;
      fBitmap.Width := w;
      fBitmap.Height := h;
      BitBlt ( fBitmap.Canvas.Handle, 0, 0, fBitmap.Width, fBitmap.Height, ScreenDC, Screen.DesktopLeft, Screen.DesktopTop, SRCCOPY );
        // Mouser, 5/18/05 - ok here is our improved mouse cursor capture code
      if fShowCursor then
      begin
          // To overlay cursor on screen dump
        P.X := P.X - Screen.DesktopLeft;
        P.Y := P.Y - Screen.DesktopTop;
        if ( P.X > 0 ) and ( P.Y > 0 ) and ( P.X < fBitmap.Width - 16 ) and ( P.Y < fBitmap.Height - 16 ) then
        begin
          DrawIconEx ( fBitmap.Canvas.Handle, P.X, P.Y, CursorInfo.hCursor, 0, 0, 0, 0, DI_NORMAL );
        end
      end;
    finally ReleaseDC ( Handles, ScreenDC ); end;
    Result := TBitmap.Create;
    DoPixelFormatFix ( Result );
    Result.Assign ( fBitmap );
    if fAutomatic then
      CopyToClipboard;
    if Assigned ( fOnCapture ) then
      fOnCapture ( Self );
  end;
  if fMinimized then
    Application.Restore;
end;

// Capture Active Window. If window not active then it captures desktop
function TASGScreenCapture.CaptureActiveWindow: TBitmap;
var
  Handles: HWnd;
  Rect: TRect;
  ScreenDC: HDC;
  lpPal: PLogPalette;
  CursorInfo: TCursorInfo;
  hCursor: HIcon;
  rCursor: TIconInfo;
  iCursorLeft: integer;
  iCursorTop: integer;
  iMouseThread: Cardinal;
  iCurrentThread: Cardinal;
  P: TPoint;
begin
  // Get mainform out of the way
  if fMinimized then
    Application.Minimize;
  // Give screen time to refresh by delay
  Sleep ( fDelay );
  Handles := GetForegroundWindow ( );
  ScreenDC := GetWindowDC ( Handles );
  try
  // Do we have a palette device? - Thanks to Joe C. Hecht
    if ( GetDeviceCaps ( ScreenDC, RASTERCAPS ) and RC_PALETTE = RC_PALETTE ) then
    begin
    // Allocate memory for a logical palette
      GetMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) );
      try
    // Zero it out to be neat
        FillChar ( lpPal^, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ), #0 );
    // Fill in the palette version
        lpPal^.palVersion := $300;
    // Grab the system palette entries
        lpPal^.palNumEntries :=
          GetSystemPaletteEntries ( ScreenDC, 0, 256, lpPal^.palPalEntry );
        if ( lpPal^.PalNumEntries <> 0 ) then
      // Create the palette
          fBitmap.Palette := CreatePalette ( lpPal^ );
      finally; FreeMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) ); end;
    end;
    GetWindowRect ( Handles, Rect );
    fBitmap.Width := Rect.Right - Rect.Left;
    fBitmap.Height := Rect.Bottom - Rect.Top;
    BitBlt ( fBitmap.Canvas.Handle, 0, 0, fBitmap.Width, fBitmap.Height, ScreenDC, 0, 0, SRCCOPY );
    if fShowCursor then
    begin
      // Get cursor information
      GetCursorPos ( P );
      CursorInfo.cbSize := SizeOf ( CursorInfo );
      GetCursorInfo ( CursorInfo );
      CursorInfo.cbSize := SizeOf ( CursorInfo );
      GetCursorInfo ( CursorInfo );
      iMouseThread := GetWindowThreadProcessId ( WindowFromPoint ( P ), nil );
      iCurrentThread := GetCurrentThreadId ( );
      if iCurrentThread = iMouseThread then
        hCursor := GetCursor ( )
      else
      begin
        AttachThreadInput ( iCurrentThread, iMouseThread, True );
        hCursor := GetCursor ( );
        AttachThreadInput ( iCurrentThread, iMouseThread, False );
      end;
      // Determine absolute position of cursor image
      GetIconInfo ( hCursor, rCursor );
      // Mouser, 5/18/05 -  correct for window pos
      P.X := P.X - Rect.Left;
      P.Y := P.Y - Rect.Top;
      iCursorLeft := P.X - Integer ( rCursor.xHotspot );
      iCursorTop := P.Y - Integer ( rCursor.yHotspot );
      //  To overlay cursor on screen dump
      DrawIconEx ( fBitmap.Canvas.Handle, iCursorLeft, iCursorTop, CursorInfo.hCursor, 32, 32, 0,
        0, DI_NORMAL );
    end;
  finally; ReleaseDC ( Handles, ScreenDC ); end;
  Result := TBitmap.Create;
  DoPixelFormatFix ( Result );
  Result.Assign ( fBitmap );
  if fAutomatic then
    CopyToClipboard;
  if Assigned ( fOnCapture ) then
    fOnCapture ( Self );
    // Restore mainform to original state
  if fMinimized then
    Application.Restore;
end;

// Capture Selected Object
function TASGScreenCapture.CaptureObject: TBitmap;
var
  Rect: TRect;
  P1: TPoint;
  Handles: HWnd;
  ScreenDC: HDC;
  lpPal: PLogPalette;
begin
  Result := nil;
  // Get mainform out of the way
  if fMinimized then
    Application.Minimize;
  // Give screen time to refresh by delay
  Sleep ( fDelay );
  // ATTN: 06/18/05 - Force monitor (copied from capture rect procedure
  CaptureTheObject.ForceMonitorNum := fMonitorNum; // Thornsoft - capture from specific monitor
  CaptureObjectForm := TCaptureObjectForm.Create ( Application );
  try
    if CaptureObjectForm.ShowModal = mrOK then
    begin
      // Get cursor position
      GetCursorPos ( P1 );
      Handles := WindowFromPoint ( P1 );
      // Get mainform out of the way
      GetWindowRect ( Handles, Rect );
      with fBitmap, Rect do
      begin
        Width := ( Right - Left );
        Height := ( Bottom - Top );
        ScreenDC := GetDC ( 0 );
        try
        // Do we have a palette device? - Thanks to Joe C. Hecht
          if ( GetDeviceCaps ( ScreenDC, RASTERCAPS ) and RC_PALETTE = RC_PALETTE ) then
          begin
          // Allocate memory for a logical palette
            GetMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) );
            try
          // Zero it out to be neat
              FillChar ( lpPal^, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ),
                #0 );
          // Fill in the palette version
              lpPal^.palVersion := $300;
          // Grab the system palette entries
              lpPal^.palNumEntries :=
                GetSystemPaletteEntries ( ScreenDC, 0, 256, lpPal^.palPalEntry );
              if ( lpPal^.PalNumEntries <> 0 ) then
            // Create the palette
                fBitmap.Palette := CreatePalette ( lpPal^ );
            finally; FreeMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) ); end;
          end;
        finally; ReleaseDC ( 0, ScreenDC ); end;
      end;
      // Need to take multiple monitors into consideration here too
      BitBlt ( fBitmap.Canvas.Handle, 0, 0, fBitmap.Width, fBitmap.Height,
        CaptureObjectForm.fBmp.Canvas.Handle,
        Rect.Left - Screen.Monitors [ CaptureObjectForm.M ].Left, Rect.Top - Screen.Monitors [ CaptureObjectForm.M ].Top, SRCCOPY );
        // Copy bitmap to function result
      Result := TBitmap.Create;
      DoPixelFormatFix ( Result );
      Result.Assign ( fBitmap );
    end;
  finally; CaptureObjectForm.Free; end;
  if fAutomatic then
    CopyToClipboard;
  if Assigned ( fOnCapture ) then
    fOnCapture ( Self );
    // Restore mainform to original state
  if fMinimized then
    Application.Restore;
end;

// Capture Selection
function TASGScreenCapture.CaptureSelection: TBitmap;
// Mouser, 5/15/05 - support for identifying active foreground window
var
  ActHandles: HWnd;
  ActRect: TRect;
  ScreenDC: HDC;
begin
  Result := nil;
  // Get mainform out of the way
  if fMinimized then
    Application.Minimize;
  // Give screen time to refresh by delay
  Sleep ( fDelay );
  // Mouser, 5/15/05 - support for identifying active foreground window
  ActHandles := GetForegroundWindow ( );
  ScreenDC := GetWindowDC ( ActHandles );
  try
    GetWindowRect ( ActHandles, ActRect );
    fObjectLeft := ActRect.Left - 0;
    fObjectTop := ActRect.Top - 0;
    fObjectWidth := ActRect.Right - ActRect.Left;
    fObjectHeight := ActRect.Bottom - ActRect.Top;
  finally; ReleaseDC ( ActHandles, ScreenDC ); end;
  // Create and show form to capture Rect
  CaptureTheRect.ForceMonitorNum := fMonitorNum; // Thornsoft - capture from specific monitor
  CaptureRectForm := TCaptureRectForm.Create ( Application );
  try
    if fShowHint then
      CaptureRectForm.ShowHint := True
    else
      CaptureRectForm.ShowHint := False;
    if CaptureRectForm.ShowModal = mrOK then
    begin
      //Sleep ( fDelay );
      Result := TBitmap.Create;
      // Mouser, 5/18/05 - needs correction for multimon case
      fObjectLeft := CaptureRectForm.ScreenToBitmapX ( ActRect.Left );
      fObjectTop := CaptureRectForm.ScreenToBitmapY ( ActRect.Top );
      DoPixelFormatFix ( Result );
      FBitmap.Assign ( CaptureRectForm.RectBitmap );
      Result.Assign ( fBitmap );
      if fAutomatic then
        CopyToClipboard;
      if Assigned ( fOnCapture ) then
        fOnCapture ( Self );
    end;
  finally; CaptureRectForm.Free; end;
  // Restore mainform to original state
  if fMinimized then
    Application.Restore;
end;

// CapturePolygon Selection
function TASGScreenCapture.CapturePolygon: TBitmap;
begin
  Result := nil;
  // Get mainform out of the way
  if fMinimized then
    Application.Minimize;
  // Give screen time to refresh by delay
  Sleep ( fDelay );
  CaptureFreehandForm := TCaptureFreehandForm.Create ( Application );
  try
    if fShowHint then
      CaptureFreehandForm.ShowHint := True
    else
      CaptureFreehandForm.ShowHint := False;
    if CaptureFreehandForm.ShowModal = mrOK then
    begin
      // Show selection
      fBitmap.Assign ( CaptureFreehandForm.fCapBMP );
      // Copy bitmap to function result
      Result := TBitmap.Create;
      DoPixelFormatFix ( Result );
      Result.Assign ( fBitmap );
    end;
  finally; CaptureFreehandForm.Free; end;
    // Restore mainform to original state
  if fMinimized then
    Application.Restore;
end;

// Capture 32x32 Selection
function TASGScreenCapture.CaptureIcon: TBitmap;
begin
  Result := nil;
  // Get mainform out of the way
  if fMinimized then
    Application.Minimize;
  // Give screen time to refresh by delay
  Sleep ( fDelay );
  // Create and show form to capture Rect
  CaptureIconForm := TCaptureIconForm.Create ( Application );
  try
    if fShowHint then
      CaptureIconForm.ShowHint := True
    else
      CaptureIconForm.ShowHint := False;
    if CaptureIconForm.ShowModal = mrOK then
    begin
      Result := TBitmap.Create;
      FBitmap.Assign ( CaptureIconForm.RectBitmap );
      DoPixelFormatFix ( Result );
      Result.Assign ( fBitmap );
      if fAutomatic then
        CopyToClipboard;
      if Assigned ( fOnCapture ) then
        fOnCapture ( Self );
    end;
  finally; CaptureIconForm.Free; end;
    // Restore mainform to original state
  if fMinimized then
    Application.Restore;
end;

// Capture SpecificSize Selection
function TASGScreenCapture.CaptureSpecificSizeSelection ( CaptureWidth: integer; CaptureHeight: integer ): TBitmap;
begin
  Result := nil;
  // Get mainform out of the way
  if fMinimized then
    Application.Minimize;
  // Give screen time to refresh by delay
  Sleep ( fDelay );
  // Create and show form to capture Rect
  // ATTN: 06/18/05 - Force monitor (copied from capture rect procedure
  CaptureSpecificRect.ForceMonitorNum := fMonitorNum; // Thornsoft - capture from specific monitor
  CaptureSpecificRectForm := TCaptureSpecificRectForm.Create ( Application );
  try
    CaptureSpecificRectForm.CaptureHeight := CaptureHeight;
    CaptureSpecificRectForm.CaptureWidth := CaptureWidth;
    fWidth := CaptureWidth;
    fHeight := CaptureHeight;
    if fShowHint then
      CaptureSpecificRectForm.ShowHint := True
    else
      CaptureSpecificRectForm.ShowHint := False;
    if CaptureSpecificRectForm.ShowModal = mrOK then
    begin
      Result := TBitmap.Create;
      FBitmap.Assign ( CaptureSpecificRectForm.RectBitmap );
      DoPixelFormatFix ( Result );
      Result.Assign ( fBitmap );
      if fAutomatic then
        CopyToClipboard;
      if Assigned ( fOnCapture ) then
        fOnCapture ( Self );
    end;
  finally; CaptureSpecificRectForm.Free; end;
    // Restore mainform to original state
  if fMinimized then
    Application.Restore;
end;

// Mouser, 5/12/05 - capture specific window by Handle
// Capture Specific handle Object
function TASGScreenCapture.CaptureObjectByHWND ( const Handles: Integer ): TBitmap;
var
  Rect: TRect;
  ScreenDC: HDC;
  lpPal: PLogPalette;
begin
  // Get mainform out of the way
  if fMinimized then
    Application.Minimize;
  Sleep ( fDelay );
  GetWindowRect ( Handles, Rect );
  with fBitmap, Rect do
  begin
    Width := Right - Left;
    Height := Bottom - Top;
    ScreenDC := GetDC ( 0 );
    try
        // do we have a palette device? - Thanks to Joe C. Hecht
      if ( GetDeviceCaps ( ScreenDC, RASTERCAPS ) and RC_PALETTE = RC_PALETTE ) then
      begin
          // allocate memory for a logical palette
        GetMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) );
        try
          // zero it out to be neat
          FillChar ( lpPal^, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ), #0 );
         // fill in the palette version
          lpPal^.palVersion := $300;
         // grab the system palette entries
          lpPal^.palNumEntries :=
            GetSystemPaletteEntries ( ScreenDC, 0, 256, lpPal^.palPalEntry );
          if ( lpPal^.PalNumEntries <> 0 ) then
          // create the palette
            fBitmap.Palette := CreatePalette ( lpPal^ );
        finally; FreeMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) ); end;
      end;
      BitBlt ( fBitmap.Canvas.Handle, 0, 0, fBitmap.Width, fBitmap.Height, ScreenDC, Rect.Left, Rect.Top, SRCCOPY );
    // copy bitmap to function result
      Result := TBitmap.Create;
      DoPixelFormatFix ( Result );
      Result.Assign ( fBitmap );
      if fAutomatic then
        CopyToClipboard;
      if Assigned ( fOnCapture ) then
        fOnCapture ( Self );
    finally; ReleaseDC ( 0, ScreenDC ); end;
      // Restore mainform to original state
    if fMinimized then
      Application.Restore;
  end;
end;

// Mouser, 5/12/05 - Capture Specific Object by tcontrol
function TASGScreenCapture.CaptureObjectByTControlp ( const tcontrolp: TControl ): TBitmap;
var
  Handles: HWND;
  tp: TPoint;
begin
  tp.x := 0;
  tp.y := 0;
  tp := tcontrolp.ClientToScreen ( tp );
  Handles := WindowFromPoint ( tp );
  Result := CaptureObjectByHWND ( Handles );
end;

procedure Register;
begin
  RegisterComponents ( 'Custom', [ TASGScreenCapture ] );
end;

end.

