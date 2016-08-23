//------------------------------------------------------------------------------
//  Apprehend Version  : 4.1
//  Copyright (c) 2005 : Adirondack Software & Graphics
//  Created            : 1-09-1992
//  Last Modification  : 07-26-2005
//  Description        : CaptureTheObject Unit
//------------------------------------------------------------------------------

unit CaptureTheObject;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, PixelFormatFix;

type
  TCaptureObjectForm = class ( TForm )
    procedure FormCreate ( Sender: TObject );
    procedure FormMouseUp ( Sender: TObject;Button: TMouseButton;
      Shift: TShiftState;X, Y: Integer );
    procedure FormDestroy ( Sender: TObject );
    procedure FormActivate ( Sender: TObject );
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure WMEraseBkGnd ( var Msg: TWMEraseBkGnd ); message WM_ERASEBKGND;
  public
    { Public declarations }
    M: Integer; // Which monitor are we on?
    fBmp: TBitmap;
  end;

var
  CaptureObjectForm: TCaptureObjectForm;
  ForceMonitorNum : Integer;

implementation

{$R *.DFM}
{$R CaptureObject.Res}

// Create the form
procedure TCaptureObjectForm.FormCreate ( Sender: TObject );
var
  ScreenDC: HDC;
  lpPal: PLogPalette;
  P : TPoint;   // Where is the mouse now?
const
  crHand = -18;
begin
  GetCursorPos ( P ); // Where am I?
  // Mouser, 6/18/05 - copied from CaptureTheRect
  if (ForceMonitorNum >=0) and (ForceMonitorNum <= Screen.MonitorCount-1)
    then M := ForceMonitorNum  {Override}
    else M := Screen.MonitorFromPoint ( P, mdNearest ).MonitorNum; // Here I am!  Monitors[M]
  Screen.Cursors [ crHand ] := LoadCursor ( hInstance, pChar ( 'CURSOR_1' ) );
  Cursor := crHand;
  fBMP := TBitmap.Create;
  DoPixelFormatFix(fBMP);
  fBMP.Width := Screen.Monitors[M].Width;   // Size to active monitor, which may differ from the primary.
  fBMP.Height := Screen.Monitors[M].Height;
  ScreenDC := GetDC ( 0 );
  // do we have a palette device? - Thanks to Joe C. Hecht
  if ( GetDeviceCaps ( ScreenDC, RASTERCAPS ) and RC_PALETTE = RC_PALETTE ) then
  begin
     // allocate memory for a logical palette
    GetMem ( lpPal, Sizeof ( TLOGPALETTE ) + ( 255 * Sizeof ( TPALETTEENTRY ) ) );
     // zero it out to be neat
    FillChar ( lpPal^, Sizeof ( TLOGPALETTE ) + ( 255 * Sizeof ( TPALETTEENTRY ) ), #0 );
     // fill in the palette version
    lpPal^.palVersion := $300;
     // grab the system palette entries
    lpPal^.palNumEntries :=
      GetSystemPaletteEntries ( ScreenDC, 0, 256, lpPal^.palPalEntry );
    if ( lpPal^.PalNumEntries <> 0 ) then
     // create the palette
      fBMP.Palette := CreatePalette ( lpPal^ );
    FreeMem ( lpPal, sizeof ( TLOGPALETTE ) + ( 255 * sizeof ( TPALETTEENTRY ) ) );
  end;
  BitBlt (fBMP.Canvas.handle, 0, 0, Screen.Monitors[M].Width, Screen.Monitors[M].Height, ScreenDC,
            Screen.Monitors[M].Left, Screen.Monitors[M].Top, srcCopy );
  // Mouse also must be bounded by the current monitor.
  SetBounds ( 0, 0, Screen.Monitors[M].Width, Screen.Monitors[M].Height );
  ReleaseDC ( 0, ScreenDC );
  SetBounds ( 0, 0, Screen.Width, Screen.Height );
end;

// Upon showing the form, move it to the upper-left of the active monitor.
procedure TCaptureObjectForm.FormShow(Sender: TObject);
begin
  Self.Left := Screen.Monitors[M].Left;
  Self.Top  := Screen.Monitors[M].Top
end;

// Process FormMouseUp event
procedure TCaptureObjectForm.FormMouseUp ( Sender: TObject;Button: TMouseButton;
  Shift: TShiftState;X, Y: Integer );
begin
  ModalResult := mrOK;
  //CaptureObjectForm := nil;
end;

// Form Destroy
procedure TCaptureObjectForm.FormDestroy ( Sender: TObject );
begin
  fBMP.Free;
  Screen.Cursor := crDefault;
  CaptureObjectForm := nil;
end;

// Activate the Form
procedure TCaptureObjectForm.FormActivate ( Sender: TObject );
const
  crHand = -18;
begin
  Screen.Cursors [ crHand ] := LoadCursor ( hInstance, pChar ( 'CURSOR_1' ) );
  Cursor := crHand;
end;

procedure TCaptureObjectForm.WMEraseBkGnd ( var Msg: TWMEraseBkGnd );
begin
  Msg.Result := 1;
end;


end.
