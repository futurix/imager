{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnImgScr
|
| Description: Image scroll box component
|
| History: May 15, 1999. Michel Brazeau, first version
|          Aug 30, 1999. Michel Brazeau allow loading images derived
|                        directly from TGraphic rather than TDibGraphic
|          Oct   , 1999. Michel Brazeau, add MouseMode property and
|                        TMouseHandler classes
|          May,    2000. W. Miller added OnSelectionChange Event
|          Jun 16, 2000. Remove OnPositionChange event and publish new
|                        mouse events by chaining.
|          Jun 20, 2000. Michel Brazeau add Rect parameter to OnQuickSelect
|                        handler, as suggested by Anthony Eischens
|          Dec 20, 2000. Michel Brazeau, added ZoomToSelection
|          Nov 13, 2001. Michel Brazeau, added ImageRect property, as
|                        suggested by David Bowrah
|
|---------------------------------------------------------------------------}
unit EnImgScr;

{$I Envision.Inc}

interface

uses
    Windows,  { for LoadCursor, TPoint }
    Messages, { for TWMSize }
    StdCtrls, { for TScrollBar }
    Classes,  { for TComponent }
    Controls, { for TMouseButton }
    EnAnEdit, { for TAnnotationsEditor }
    EnDiGrph, { for TDibGraphic, NewDibGraphic }
    EnTransf, { for TResizeTransform }
    EnMisc,   { for TEnvisionProgressEvent, BoundInteger }
    ExtCtrls, { for TImage }
    Graphics, { for TGraphic }
    Forms;    { for TScrollingWinControl }


type

TImageScrollBox = class;

TZoomChangeEvent = procedure( const Sender  : TImageScrollBox;
                              const Zoom    : Single ) of object;

TBeforeSaveEvent = procedure( const Sender  : TImageScrollBox;
                              const Graphic : TDibGraphic ) of object;

TRedrawEvent = procedure( const Graphic : TDibGraphic ) of object;

TRubberbandChangeEvent = procedure( const Rect : TRect ) of object;

{ MB Dec 19, 1999. Add zmFitToPage }
TZoomMode = ( zmOriginalSize,
              zmFullPage,
              zmFitWidth,
              zmFitHeight,
              zmPercent,
              zmFitToPage );

TMouseMode = ( mmDrag, mmQuickSelect, mmSelect, mmAnnotate, mmUser );

TQuickSelectEvent = procedure( const Sender  : TImageScrollBox;
                               const Graphic : TDibGraphic;
                               const Rect    : TRect ) of object;

{ MB Oct 22, 2002 }
TNewGraphicEvent = procedure( const Graphic : TDibGraphic ) of object;

TMouseHandler = class;

{ Thread class to read a graphic. The thread destroys itself after the
  graphic has been read. After thread execution, a new graphic is
  created and it must be destroyed externally. If unable to read
  FileName, Graphic is set to nil. }
TReadGraphicThread = class(TThread)
protected
    FFileName           : String;
    pFGraphic           : ^TDibGraphic;

    procedure Execute; override;

public
    constructor Create( const FileName : String;
                        var   Graphic  : TDibGraphic);
end;

TImageScrollBox = class(TScrollingWinControl)
protected

    FImage               : TImage;

    FSourceGraphic       : TDibGraphic;
    FResizedBWGraphic    : TDibGraphic;
    FResizeTransform     : TResizeTransform;
    FAntiAliasTransform  : TAntiAliasTransform;

    FMouseHandler        : TMouseHandler;
    FMouseMode           : TMouseMode;
    FOnQuickSelect       : TQuickSelectEvent;

    FZoomMode            : TZoomMode;
    FZoomPercent         : Single;
    FLastZoomPercent     : Single;

    FAntiAliased         : Boolean;

    FOnZoomChange        : TZoomChangeEvent;

    FOnBeforeSave        : TBeforeSaveEvent;

    FOnRedraw            : TRedrawEvent;

    FAnimated            : Boolean;

    FAnimationTimer      : TTimer;

    FFileName            : String;

    FCentered            : Boolean;

    FRedrawInProgress    : Boolean;

    FScrollInProgress    : Boolean;

    FOnBeginScroll       : TNotifyEvent;
    FOnEndScroll         : TNotifyEvent;

    { Chained mouse handler events,  do not name these events, FOnMouseXXXX
      as this will cause stack overflows because this names are used by the
      VCL in the base class. }
    FOnImageMouseMove    : TMouseMoveEvent;
    FOnImageMouseDown    : TMouseEvent;
    FOnImageMouseUp      : TMouseEvent;
    FOnImageDblClick     : TNotifyEvent;

    FOnRubberbandChange  : TRubberbandChangeEvent;

    { MB Nov 13, 2001 }
    FImageRect           : TRect;

    { MB Nov 30, 2001 }
    FOnReadWriteProgress : TEnvisionProgressEvent;

    { MB Mar 13, 2002 }
    FReadAheadFileName   : String;
    FReadAheadGraphic    : TDibGraphic;

    { MB Oct 08, 2002 }
    FMouseHandlerOwnership : Boolean;

    { MB Oct 22, 2002 }
    FOnNewGraphic          : TNewGraphicEvent;

    { MB Nov 06, 2002 }
    FAnnotationsStr        : AnsiString;

    { MB Jan 08, 2003 }
    FAlwaysShowAnnotations : Boolean;
    FDisplayEditor         : TAnnotationsEditor;

    procedure SetAlwaysShowAnnotations( const Show : Boolean );

    { trigger the FOnNewGraphic event }
    procedure DoNewGraphic( const Graphic : TGraphic ); virtual;

    procedure AnimateTimer( Sender : TObject );

    procedure SetZoomMode( const InZoomMode : TZoomMode );
    procedure SetZoomPercent( const InPercent : Single );

    function GetGraphic : TDibGraphic;
    procedure SetGraphic( const InGraphic : TDibGraphic );

    function GetDisplayedGraphic : TDibGraphic;

    procedure SetAntiAliased( const InAntiAliased : Boolean );

    { MB Aug 18, 1999. Resize is not virtual in Delphi 3, so the
     a message handler for WM_SIZE is used instead }
    procedure WMSize(var Message: TWMSize); message WM_SIZE;

    { MB Nov 27, 1999. In Delphi 3, the BeforeDestruction method is not
      available in TObject, so the WM_DESTROY message is used to
      free the mouse handler }
    procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;

    { MB Jan 30, 2000. Override to call UpdateWindow which reduces flickering
      on Windows NT }
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;

    function GetFrameCount : LongInt;
    function GetFrame(FrameNo : LongInt) : TDibGraphic;

    function GetCurrentFrame : LongInt;
    procedure SetCurrentFrame( const FrameNo : LongInt );

    function GetAnimated : Boolean;
    procedure SetAnimated( const InAnimated : Boolean );

    procedure SetMouseMode( const InMouseMode : TMouseMode );
    procedure ImageMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ImageDblClick(Sender : TObject);

    procedure RedrawBW;
    procedure RedrawNotBW;

    procedure CenterImage( const NewWidth  : LongInt;
                           const NewHeight : LongInt );

    { recalcuate FZoomPercent from the current zoom mode }
    procedure RecalcZoom;

    procedure SetFileName( const FileName : String );

    procedure SetCentered( const InCentered : Boolean );

    procedure SetMouseHandler( const MouseHandler : TMouseHandler );

    procedure SetReadAheadFileName( const FileName : String );

    function InternalLoadFromStream( const Stream       : TStream;
                                     const Extension    : String;
                                     const ImageNo      : LongInt;
                                     const ShowProgress : Boolean ) : TDibGraphic;

    function GetAnnotations : AnsiString;
    procedure SetAnnotations( const Str : AnsiString );

    procedure ShowAnnotations;
    procedure HideAnnotations;

public

    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    { returns the number of images in a file. Useful to determinte the
      number of images in multi-image files such as TIFF. For single
      image file formats, 1 is returned. }
    function ImageCountFromFile( const FileName : String ) : LongInt;

    { see ImageCountFromFile }
    function ImageCountFromStream( const Stream    : TStream;
                                   const Extension : String ) : LongInt;

    { Load an image from a file. ImageNo must be 1 for single image file
      formats. For multiple image file formats (such as TIFF), ImageNo
      specifies the image to load. If ImageNo is 0, all images are loaded
      into memory and they are accessed with the CurrentFrame, and
      FrameCount properties. }
    procedure LoadFromFile( const FileName : String;
                            const ImageNo  : LongInt );

    { see LoadFromFile description }
    procedure LoadFromStream( const Stream    : TStream;
                              const Extension : String;
                              const ImageNo   : LongInt );
                              {$ifdef __Delphi4AndAbove}
                              overload;
                              {$endif} //mdm 02/21/2003 D3 support

    {$ifdef __Delphi4AndAbove}
    { load an image by determine the format from the contents of the Stream }
    procedure LoadFromStream( const Stream  : TStream;
                              const ImageNo : LongInt ); overload;
    {$endif}

    { save the currently displayed image to FileName in the format
      specified by the extension of FileName. To save a multi-image file such as
      TIFF, use AppendToFile/AppendToStream }
    procedure SaveToFile( const FileName  : String );

    { see SaveToFile description }
    procedure SaveToStream( const Stream    : TStream;
                            const Extension : String );

    { append the current displayed image to FileName. FileName must be
      a multi-image file format such as TIFF. }
    procedure AppendToFile( const FileName  : String );

    procedure AppendToStream( const Stream    : TStream;
                              const Extension : String );

    { clear the image in the scroll box }
    procedure Clear;

    { the Graphic property provides access to the source graphic being
      displayed in the image scroll box. Graphic.Canvas can be used to
      make changes to the Graphic. Redraw(True) must be called after
      making changes to the Graphic. }
    property Graphic : TDibGraphic read GetGraphic
                                   write SetGraphic;

    { the DisplayedGraphic property provides access to the resized graphic
      displayed in the image scroll box. Note that any change made to the
      displayed graphic will be lost when Redraw is called. }
    property DisplayedGraphic : TDibGraphic read GetDisplayedGraphic;


    procedure Redraw( const GraphicChanged : Boolean ); dynamic;

    property FrameCount : LongInt read GetFrameCount;
    property Frames[FrameNo: LongInt] : TDibGraphic read GetFrame;
    property CurrentFrame : LongInt read GetCurrentFrame
                                    write SetCurrentFrame;

    { if the image was loaded with ImageNo = 0, and the format is a multi-image
      format, setting Animated to True will animate the display of the
      images. }
    property Animated : Boolean read GetAnimated
                                write SetAnimated
                                default False;

    property MouseMode : TMouseMode read FMouseMode
                                    write SetMouseMode;

    { When setting the MouseHandler, the image scroll box becomes the
      owner of the object. The user must not free the object after it
      assigned to the MouseHandler property. This must be assigned a value
      only after setting the mouse mode to mmUser. }
    property MouseHandler : TMouseHandler read FMouseHandler
                                          write SetMouseHandler;

    { Read only access to the offset positions of the TImage on the scroll box.
      When the image is not Centered, the offset starts at 0,0 }
    property ImageRect: TRect read FImageRect;

    property ScrollInProgress : Boolean read FScrollInProgress;

    { Copy the currently selected region to the clipboard. If the MouseHandler
      is not TRubberbandMouseHandler, or a region is not selected, an
      EEnvisionError exception is raised. }
    procedure CopySelectionToClipboard;

    { Crop the currently selected region, and the selected region will replace
      the entire graphic in the  TImageScrollBox . If the MouseHandler
      is not TRubberbandMouseHandler, or a region is not selected, an
      EEnvisionError exception is raised.  }
    procedure CropToSelection;

    { extracts the currently selected region and copies it to Dest. If the
      MouseHandler is not TRubberbandMouseHandler, or a region is not selected,
      an EEnvisionError exception is raised. }
    procedure ExtractSelection(const Dest: TDibGraphic); //mdm 03/01/2003

    { Copy a graphic to the currently selected region. If the MouseHandler
      is not TRubberbandMouseHandler, or a region is not selected, an
      EEnvisionError exception is raised.  }
    procedure CopyGraphicIntoSelection( const Graphic : TGraphic );

    { Increase the zoom to display the selected region. May only be used when
      the mouse mode is mmSelect and a region is selected; otherwise an
      exception will be raised. }
    procedure ZoomToSelection;

    { procedure assign to the image scroll box the image currently loaded
      in the windows clipboard. Returns False when an image was not
      available in the clipboard (the current image is not changed in this
      case) }
    function AssignFromClipboard : Boolean;

    { annotation related properties and methods }

    { adding of graphical elements. The MouseMode must be mmAnnotate }
    procedure AddNote;
    procedure AddText;
    procedure AddRectangle;
    procedure AddLine;
    procedure AddImage; { MB Apr 11, 2003 }

    procedure BurnAnnotations;

    { read or write the annotations. If the mouse mode is mmAnnotate, writing to the
      property will update the annotations }
    property Annotations : AnsiString read GetAnnotations
                                      write SetAnnotations;

    { MB Jan 08, 2003. If True, annotations are displayed even when MouseMode
      is not mmAnnotate }
    property AlwaysShowAnnotations : Boolean read FAlwaysShowAnnotations
                                             write SetAlwaysShowAnnotations;

published

    property FileName : String read FFileName
                               write SetFileName;

    property ReadAheadFileName : String read FReadAheadFileName
                                        write SetReadAheadFileName;

    property AntiAliased : Boolean read FAntiAliased
                                   write SetAntiAliased
                                   default False;

    property ZoomMode : TZoomMode read FZoomMode
                                  write SetZoomMode
                                  default zmOriginalSize;

    property ZoomPercent : Single read FZoomPercent
                                  write SetZoomPercent;

    { if Centered is True, the image will be drawn in the center of the scroll }
    property Centered : Boolean read FCentered
                                write SetCentered
                                default False;

    property OnZoomChange : TZoomChangeEvent read FOnZoomChange
                                             write FOnZoomChange;

    property OnBeforeSave : TBeforeSaveEvent read FOnBeforeSave
                                             write FOnBeforeSave;

    property OnRedraw : TRedrawEvent read FOnRedraw
                                     write FOnRedraw;

    property OnNewGraphic : TNewGraphicEvent read FOnNewGraphic
                                             write FOnNewGraphic;

    property OnQuickSelect : TQuickSelectEvent read FOnQuickSelect
                                               write FOnQuickSelect;

    { Publish new mouse events which are chained from the FImage mouse
      events.  }
    property OnImageMouseMove : TMouseMoveEvent read FOnImageMouseMove
                                                write FOnImageMouseMove;
    property OnImageMouseDown : TMouseEvent read FOnImageMouseDown
                                            write FOnImageMouseDown;
    property OnImageMouseUp   : TMouseEvent read FOnImageMouseUp
                                            write FOnImageMouseUp;
    { MB Sep 23, 2002. }
    property OnImageDblClick  : TNotifyEvent read FOnImageDblClick
                                             write FOnImageDblClick;

    property OnRubberbandChange : TRubberbandChangeEvent
                                             read FOnRubberbandChange
                                             write FOnRubberbandChange;

    property OnReadWriteProgress : TEnvisionProgressEvent
                                     read FOnReadWriteProgress
                                     write FOnReadWriteProgress;

    property OnBeginScroll : TNotifyEvent read FOnBeginScroll
                                          write FOnBeginScroll;

    property OnEndScroll : TNotifyEvent read FOnEndScroll
                                        write FOnEndScroll;
    { If True, the mouse handler is owned by the image scroll box, and it
      will be destroyed everytime a new mouse handler is assigned and
      when the scroll box is destroyed. Default is True }
    property MouseHandlerOwnership : Boolean read FMouseHandlerOwnership
                                             write FMouseHandlerOwnership;

    property Align;

    {$ifdef __Delphi4AndAbove}
    property Anchors;
    property DockSite;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnResize;
    property OnStartDock;
    property OnUnDock;
    {$endif}
    property DragCursor;
    property DragMode;
    property Enabled;
    property Color nodefault;
    property Ctl3D;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;

    { MB Oct 11, 2002 }
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;



end;                                                  

{--------------------------------------------------------------------------}

TMouseHandler = class(TObject)
protected
    FImageScrollBox : TImageScrollBox;
    FMouseIsDown    : Boolean;

    procedure BeforeResize; virtual;
    procedure AfterResize; virtual;	// Added May 26, 2001 - BAL

    procedure MouseDown( const Button : TMouseButton;
                         const Shift  : TShiftState;
                         const X, Y   : Integer ); virtual;

    procedure MouseUp( const Button : TMouseButton;
                       const Shift  : TShiftState;
                       const X, Y   : Integer ); virtual;

    procedure MouseMove( const Shift : TShiftState;
                         const X, Y  : Integer ); virtual;

    procedure MouseDblClick( Sender : TObject); virtual; //mdm 03/02/2003

public
    constructor Create( const InImageScrollBox : TImageScrollBox );

    property ImageScrollBox : TImageScrollBox read FImageScrollBox;
end;

{--------------------------------------------------------------------------}

TDragMouseHandler = class(TMouseHandler)
protected
    FScreenCursor        : TCursor;
    FStartMousePos       : TPoint;
    FStartScrollPos      : TPoint;

    procedure MouseDown( const Button : TMouseButton;
                         const Shift  : TShiftState;
                         const X, Y   : Integer ); override;

    procedure MouseUp( const Button : TMouseButton;
                       const Shift  : TShiftState;
                       const X, Y   : Integer ); override;

    procedure MouseMove( const Shift : TShiftState;
                         const X, Y  : Integer ); override;

public
    constructor Create( const InImageScrollBox : TImageScrollBox );
end;

{--------------------------------------------------------------------------}

TQuickSelectMouseHandler = class(TMouseHandler)
protected
    FX1               : Integer;
    FY1               : Integer;
    FX2               : Integer;
    FY2               : Integer;

    FCanvas           : TCanvas;

    procedure BoundXY( var X, Y : Integer );

    procedure DrawBand;
    procedure RemoveBand;
    procedure DrawXORBand;

    procedure MouseDown( const Button : TMouseButton;
                         const Shift  : TShiftState;
                         const X, Y   : Integer ); override;

    procedure MouseUp( const Button : TMouseButton;
                       const Shift  : TShiftState;
                       const X, Y   : Integer ); override;

    procedure MouseMove( const Shift : TShiftState;
                         const X, Y  : Integer ); override;

public
    constructor Create( const InImageScrollBox : TImageScrollBox );
    destructor Destroy; override;
end;

{--------------------------------------------------------------------------}

implementation

{$R EnImgScr.R32}

uses
    SysUtils, { for fmOpenRead }
    ClipBrd,  { for TClipBoard }
    ExtDlgs,  { for TOpenPictureDialog }
    Dialogs,  { for ofPathMustExist, ... }
    EnMsg,    { for msgXXXX }
    EnTifGr,  { for TTiffGraphic }
    EnAnnota, { for TAnnotationMouseHandler }
    EnRubber; { for TRubberBandMouseHandler }

const

crHandOpened  = 100;
crHandClosed  = 101;

{--------------------------------------------------------------------------}

constructor TReadGraphicThread.Create( const FileName : String;
                                       var   Graphic  : TDibGraphic);
begin
    {$WARNINGS OFF}
    pFGraphic       := @Graphic;
    {$WARNINGS ON}

    FFileName       := FileName;

    inherited Create( False );

    Priority             := tpLowest;
    Self.FreeOnTerminate := True;
end;

{--------------------------------------------------------------------------}

procedure TReadGraphicThread.Execute;
var
    NewGraphic : TDibGraphic;
begin
    pFGraphic^ := nil;

    if not FileExists( FFileName ) then
        Exit;

    NewGraphic := NewDibGraphic( FFileName );
    if NewGraphic = nil then
        Exit;

    try

        NewGraphic.LoadFromFile(FFileName);

        { only assign FGraphic after graphic loaded successfully }
        pFGraphic^ := NewGraphic;

    except
        NewGraphic.Free;
        Exit;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetReadAheadFileName( const FileName : String );
begin
    FReadAheadFileName := FileName;

    FReadAheadGraphic.Free;
    FReadAheadGraphic := nil;

    TReadGraphicThread.Create( FileName, FReadAheadGraphic );
end;

{--------------------------------------------------------------------------}

constructor TImageScrollBox.Create(AOwner : TComponent);
var
    Graphic : TDibGraphic;
begin
    inherited Create(AOwner);

    { MB Sep 08, 1999. Set default size useful when dropped on a form at
      design time }
    Self.Width  := 100;
    Self.Height := 100;

    Self.AutoScroll  := False;

    Self.HorzScrollBar.Tracking := True;
    Self.VertScrollBar.Tracking := True;

    FImageRect              := Rect(0,0,0,0);

    FImage                  := TImage.Create(Self);
    FImage.Parent           := Self;
    FImage.Visible          := False;
    FImage.Left             := 0;
    FImage.Top              := 0;
    FImage.Stretch          := False;

    { MB Sep 25, 1999. Free the assigned graphic as a copy is created. }
    Graphic := TDibGraphic.Create;
    try
        FImage.Picture.Graphic  := Graphic;
    finally
        Graphic.Free;
    end;

    FSourceGraphic          := TDibGraphic.Create;
    FResizedBWGraphic       := TDibGraphic.Create;

    FResizeTransform        := TResizeTransform.Create;
    FAntiAliasTransform     := TAntiAliasTransform.Create;

    FAnimated               := False;
    FAnimationTimer         := TTimer.Create(Self);
    FAnimationTimer.OnTimer := AnimateTimer;
    FAnimationTimer.Enabled := False;

    { annotation display editor must be set before the mouse mode }
    FDisplayEditor := TAnnotationsEditor.Create(nil);
    FDisplayEditor.DisplaySurface     := Self;
    FDisplayEditor.DisplayResolution  := Screen.PixelsPerInch;

    FMouseMode              := mmUser;
    MouseMode               := mmDrag;

    FImage.OnMouseDown      := Self.ImageMouseDown;
    FImage.OnMouseMove      := Self.ImageMouseMove;
    FImage.OnMouseUp        := Self.ImageMouseUp;
    FImage.OnDblClick       := Self.ImageDblClick;

    { MB Jun 16, 2000. These don't seem to be necessary. For the moment
      they are commented out, to check for possible side effects
      MB Sep 23, 2002. Reactivate these events to ensure they trigger
      on the scroll box when the displayed image does not cover the
      scroll box completely
    }
    Self.OnMouseDown        := Self.ImageMouseDown;
    Self.OnMouseMove        := Self.ImageMouseMove;
    Self.OnMouseUp          := Self.ImageMouseUp;
    Self.OnDblClick         := Self.ImageDblClick;

    FZoomMode               := zmOriginalSize;
    FZoomPercent            := 100.0;
    FLastZoomPercent        := 100.0;

    FAntiAliased            := False;

    FCentered               := False;

    FRedrawInProgress       := False;

    FMouseHandlerOwnership  := True;

    FAnnotationsStr         := '';
end;

{--------------------------------------------------------------------------}

destructor TImageScrollBox.Destroy;
begin
    FDisplayEditor.Free;

    FReadAheadGraphic.Free;

    FAnimationTimer.Enabled := False;

    FAntiAliasTransform.Free;
    FResizeTransform.Free;
    FResizedBWGraphic.Free;

    { MB Sep 25, 1999. Fix memory leak }
    FSourceGraphic.Free;

    { MB Nov 28, 2000. As reported by Steen Jansdal, the WMDestroy method
      may not be invoked if the TImageScrollBox is invisible. It is safe to
      call FMouseHandler.Free, because if it is already destroyed it will be
      nil. }
    if FMouseHandlerOwnership then
    begin
        FMouseHandler.Free;

        { Aug 26, 2002, Brian Etherington. Prevent error in WMDestroy }
        FMouseHandler := nil;
    end;
    
    inherited Destroy;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.WMDestroy(var Message: TWMDestroy);
begin
    { the mouse handler object may not be destroyed in the destructor,
      because the mouse handler may make reference to FImageScrollBox.Handle,
      and the Handle property is not valid in the destructor.

      MB Jul 31, 2000. Set the mouse handler to nil after freeing it. For
      some reason at design time, WMDestroy may be called twice, causing an
      access violation when closing a form at design time. This has been
      reproduced when a form contained a TRzSplitter from the Raize
      components.
    }
    if FMouseHandlerOwnership then
    begin
        FMouseHandler.Free;
        FMouseHandler := nil;
    end;

    inherited;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.WMHScroll(var Message: TWMHScroll);
begin
    if Message.ScrollCode = SB_ENDSCROLL then
    begin
        if FScrollInProgress and Assigned(FOnEndScroll) then
            FOnEndScroll(Self);

        FScrollInProgress := False;
    end
    else
    begin
        if not FScrollInProgress and Assigned(FOnBeginScroll) then
            FOnBeginScroll(Self);

        FScrollInProgress := True;
    end;

    inherited;

    UpdateWindow(Self.Handle);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.WMVScroll(var Message: TWMVScroll);
begin
    if Message.ScrollCode = SB_ENDSCROLL then
    begin
        if FScrollInProgress and Assigned(FOnEndScroll) then
            FOnEndScroll(Self);

        FScrollInProgress := False;
    end
    else
    begin
        if not FScrollInProgress and Assigned(FOnBeginScroll) then
            FOnBeginScroll(Self);

        FScrollInProgress := True;
    end;

    inherited;

    UpdateWindow(Self.Handle);
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.ImageCountFromFile( const FileName : String ) : LongInt;
var
    Stream : TFileStream;
begin
    Stream  := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
    try
        Result := ImageCountFromStream(Stream, FileName);
    finally
        Stream.Free;
    end;
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.ImageCountFromStream( const Stream    : TStream;
                                               const Extension : String ) : LongInt;
var
    TempGraphic : TDibGraphic;
begin
    if FindDibGraphicClass(Extension) = nil then
        Result := 1
    else
    begin
        TempGraphic := NewDibGraphic(Extension);
        try
            Result := TempGraphic.GetImageCount(Stream);
        finally
            TempGraphic.Free;
        end;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.DoNewGraphic( const Graphic : TGraphic );
begin
    if Assigned(FOnNewGraphic) then
        FOnNewGraphic(FSourceGraphic);

    if Graphic is TTiffGraphic then
        Self.Annotations := TTiffGraphic(Graphic).AnnotationTag;

    if AlwaysShowAnnotations and (MouseMode <> mmAnnotate) then
        ShowAnnotations;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.LoadFromFile( const FileName : String;
                                        const ImageNo  : LongInt );
var
    Stream      : TFileStream;
    WasAnimated : Boolean;
begin
    WasAnimated := Self.Animated;
    try
        if WasAnimated then
            Self.Animated := False;

        if (AnsiCompareText( FileName, ReadAheadFileName ) = 0) and
           (FReadAheadGraphic <> nil) then
        begin
            FSourceGraphic.Free;
            FSourceGraphic     := FReadAheadGraphic;
            FReadAheadGraphic  := nil;
            FReadAheadFileName := '';

            DoNewGraphic(FSourceGraphic);

            Redraw(True);
        end
        else
        begin
            Stream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
            try
                LoadFromStream(Stream, FileName, ImageNo);
            finally
                Stream.Free;
            end;
        end;

        { MB Nov 13, 2001 }
        FFileName := FileName;

    finally
        if WasAnimated then
            Self.Animated := True;
    end;
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.InternalLoadFromStream(
                                 const Stream       : TStream;
                                 const Extension    : String;
                                 const ImageNo      : LongInt;
                                 const ShowProgress : Boolean ) : TDibGraphic;

    function LoadDibGraphic : TDibGraphic;
    begin
        Result := NewDibGraphic(Extension);
        try
            if ShowProgress then
                Result.OnReadWriteProgress := Self.OnReadWriteProgress;

            if ImageNo = 0 then
                Result.MultiLoad   := True
            else
                Result.ImageToLoad := ImageNo;

            Result.LoadFromStream(Stream);
        except
            Result.Free;
            raise;
        end;
    end;

    function LoadGraphic : TDibGraphic;
    var
        Picture    : TPicture;
        FileStream : TFileStream;
        FileName   : String;
    begin
        { The VCL does not have any routine to obtain a TGraphicClass from
          a file name (?!) so a TPicture is used to load the graphic from
          a temporary file. }
        if ShowProgress then
            DoProgress( Self, FOnReadWriteProgress, 0, 0, 100, -1 );

        Picture := TPicture.Create;
        try
            { Extension may be the actual file when this method is called
              from LoadFromFile. This prevents creating a temporary file. }
            FileName := Extension;
            if not FileExists(FileName) then
            begin
                FileName := GetTempFileName('En', Extension);
                FileStream := TFileStream.Create(FileName, fmCreate);
                try
                    FileStream.CopyFrom(Stream, Stream.Size);
                finally
                    FileStream.Free;
                end;
            end;

            if ShowProgress then
                DoProgress( Self, FOnReadWriteProgress, 25, 0, 100, -1 );

            try
                { MB Nov 07, 1999. Under Delphi 3, when testing with Anders
                  Melander's TGifImage, an exception is raised, EFOpenError, unable
                  to open file "...". With Delphi 4 and 5, this works fine.
                  I'm not sure if this is a problem TGifImage or the VCL
                  itself.  }
                Picture.LoadFromFile(FileName);

                if ShowProgress then
                    DoProgress( Self, FOnReadWriteProgress, 90, 0, 100, -1 );

                Result := TDibGraphic.Create;
                Result.Assign(Picture.Graphic);

            finally
                if FileName <> Extension then
                    DeleteFile(FileName);
            end;

        finally
            Picture.Free;
        end;

        if ShowProgress then
            DoProgress( Self, FOnReadWriteProgress, 100, 0, 100, -1 );
    end;
begin
    { MB July 02, 2002. Clear the selection when opening new image }
    if MouseHandler is TRubberbandMouseHandler then
        TRubberbandMouseHandler(MouseHandler).ClearSelection;

    if FindDibGraphicClass(Extension) = nil then
        Result := LoadGraphic
    else
        Result := LoadDibGraphic;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.LoadFromStream( const Stream    : TStream;
                                          const Extension : String;
                                          const ImageNo   : LongInt );

begin
    FSourceGraphic.Free;
    try
        FSourceGraphic := InternalLoadFromStream( Stream, Extension, ImageNo, True );
    except
        { set FSourceGraphic to nil, so that Free may later be called on it.
          Apr 24, 2002. Set FSourceGraphic to a valid empty graphic, as some
          code may call ImageScrollBox.Graphic.IsEmpty }
        FSourceGraphic := TDibGraphic.Create;
        raise;
    end;

    DoNewGraphic(FSourceGraphic);

    Redraw(True);

end;

{--------------------------------------------------------------------------}

{$ifdef __Delphi4AndAbove}

procedure TImageScrollBox.LoadFromStream( const Stream  : TStream;
                                          const ImageNo : LongInt );
var
    GraphicClass : TDibGraphicClass;
    Graphic      : TDibGraphic;
begin
    GraphicClass := GuessDibGraphicClass(Stream);
    if GraphicClass = nil then
        raise EEnvisionError.Create(msgUnableToDetermineGraphicFormat);

    Graphic := GraphicClass.Create;
    try
        Graphic.OnReadWriteProgress := Self.OnReadWriteProgress;

        if ImageNo = 0 then
            Graphic.MultiLoad   := True
        else
            Graphic.ImageToLoad := ImageNo;

        Graphic.LoadFromStream(Stream);
    except
        Graphic.Free;
        raise;
    end;

    FSourceGraphic.Free;
    FSourceGraphic := Graphic;

    DoNewGraphic(FSourceGraphic);

    Redraw(True);

end;

{$endif} //mdm 02/21/2003

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SaveToFile( const FileName  : String );
var
    Stream : TFileStream;
begin
    Stream := TFileStream.Create(FileName, fmCreate);
    try
        SaveToStream(Stream, ExtractFileExt(FileName));

        FFileName := FileName;

    finally
        Stream.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SaveToStream( const Stream    : TStream;
                                        const Extension : String );
var
    TempGraphic    : TDibGraphic;
begin
    TempGraphic := NewDibGraphic(Extension);
    if TempGraphic = nil then
        raise EEnvisionError.Create(Format(msgFileFormatNotSupported, [Extension]));

    BeginHourglass;
    try
        TempGraphic.Assign(FSourceGraphic);

        if TempGraphic is TTiffGraphic then
            TTiffGraphic(TempGraphic).AnnotationTag := Self.Annotations; 

        if Assigned(FOnBeforeSave) then
            FOnBeforeSave(Self, TempGraphic);

        TempGraphic.OnReadWriteProgress := Self.OnReadWriteProgress;

        TempGraphic.SaveToStream(Stream);
    finally
        EndHourglass;
        TempGraphic.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.AppendToFile( const FileName  : String );
var
    Stream : TFileStream;
begin
    Stream := TFileStream.Create(FileName, fmOpenReadWrite);
    try
        AppendToStream(Stream, ExtractFileExt(FileName));
    finally
        Stream.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.AppendToStream( const Stream    : TStream;
                                          const Extension : String );
var
    TempGraphic    : TDibGraphic;
begin
    TempGraphic := NewDibGraphic(Extension);
    if TempGraphic = nil then
        raise EEnvisionError.Create(Format(msgFileFormatNotSupported, [Extension]));

    BeginHourglass;
    try
        TempGraphic.Assign(FSourceGraphic);

        if TempGraphic is TTiffGraphic then
            TTiffGraphic(TempGraphic).AnnotationTag := Self.Annotations; 

        if Assigned(FOnBeforeSave) then
            FOnBeforeSave(Self, TempGraphic);

        TempGraphic.OnReadWriteProgress := Self.OnReadWriteProgress;

        TempGraphic.AppendToStream(Stream);
    finally
        EndHourglass;
        TempGraphic.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.Clear;
begin
    FSourceGraphic.Clear;
    FFileName        := '';
    Self.Annotations := '';

    if MouseHandler is TRubberbandMouseHandler then	// Added May 26, 2001 - BAL
        TRubberbandMouseHandler(MouseHandler).ClearSelection;

    DoNewGraphic(FSourceGraphic);

    Redraw(True);

end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.AnimateTimer( Sender : TObject );
begin
    if FrameCount <= 1 then
        Exit;

    FAnimationTimer.Enabled := False;
    try
        if CurrentFrame = FrameCount then
            CurrentFrame := 1
        else
            CurrentFrame := CurrentFrame + 1;
    finally
        FAnimationTimer.Interval := FSourceGraphic.ImageDelay;
        FAnimationTimer.Enabled  := True;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.WMSize(var Message : TWMSize);
begin
    inherited;

    if not FRedrawInProgress then
        Redraw(False);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetGraphic( const InGraphic : TDibGraphic );
begin
    FSourceGraphic.Assign(InGraphic);

    { MB Oct 22, 2002 }
    FFileName       := '';

    { MB Jan 16, 2003 }
    FAnnotationsStr := '';
    FDisplayEditor.Clear;

    DoNewGraphic(FSourceGraphic);

    Redraw(True);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetAntiAliased( const InAntiAliased : Boolean );
begin
    if FAntiAliased = InAntiAliased then
        Exit;

    FAntiAliased := InAntiAliased;

    if FSourceGraphic.ImageFormat = ifBlackWhite then
        Redraw(False);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetFileName( const FileName : String );
begin
    { MB Nov 13, 2001. FFileName now assigned in LoadFromFile }

    if FileName <> '' then
        LoadFromFile(FileName, 1)
    else
        Self.Clear;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetCentered( const InCentered : Boolean );
begin
    if InCentered <> FCentered then
    begin
        FCentered := InCentered;

        if Assigned(FMouseHandler) then
            MouseHandler.BeforeResize;

        Redraw(False);

        if Assigned(FMouseHandler) then	
            MouseHandler.AfterResize;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetMouseMode( const InMouseMode : TMouseMode );
begin
    if FMouseMode = InMouseMode then
        Exit;

    if FMouseHandler is TAnnotationMouseHandler then
        FAnnotationsStr := TAnnotationMouseHandler(FMouseHandler).AnnotationsStr;

    case InMouseMode of

        mmDrag        :
        begin
            SetMouseHandler(TDragMouseHandler.Create(Self));
            FMouseHandlerOwnership := True;
        end;

        mmQuickSelect :
        begin
            SetMouseHandler(TQuickSelectMouseHandler.Create(Self));
            FMouseHandlerOwnership := True;
        end;

        mmSelect      :
        begin
            SetMouseHandler(TRubberBandMouseHandler.Create(Self));
            FMouseHandlerOwnership := True;
        end;

        mmAnnotate   :
        begin
            SetMouseHandler(TAnnotationMouseHandler.Create(Self));
            FMouseHandlerOwnership := True;

            TAnnotationMouseHandler(FMouseHandler).AnnotationsStr := FAnnotationsStr;
        end;

        mmUser        :
        begin
            if FMouseHandlerOwnership then
                FMouseHandler.Free;

            FMouseHandler := nil;

            FImage.Cursor := crDefault;
        end;
    end; { case }

    FMouseMode := InMouseMode;

    if AlwaysShowAnnotations and (MouseMode <> mmAnnotate) then
        ShowAnnotations
    else
        HideAnnotations;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetMouseHandler( const MouseHandler : TMouseHandler );
begin
    if FMouseHandlerOwnership then
        FMouseHandler.Free;

    FMouseHandler := MouseHandler;
end;

{ NOTE about the Sender in the mouse events as discussed with Ed Fessler:

Hi Ed,

I looked at the source, and the Sender is the original Sender from the VCL, ie, the object on which the X,Y coordinates are from. I can make the Sender the TImageScrollBox box, but then the X,Y coordinates will not be with respect to the client area of the image scroll. 

This also gets confusing, because the mouse event may come from the TImage on the scroll box or from the TScrollBox if the mouse event is not on the image (when the image does not take up the entire scroll box.

To make things simpler, I'll make the Sender the TImageScrollBox. Just locate the 

procedure TImageScrollBox.ImageMouseDown
procedure TImageScrollBox.ImageMouseMoveprocedure procedure TImageScrollBox.ImageMouseUp
procedure TImageScrollBox.ImageDblClick

and replace the Sender with Self. I have updated my code base.

}

{--------------------------------------------------------------------------}

procedure TImageScrollBox.ImageMouseDown(
         Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Assigned(FMouseHandler) then
        FMouseHandler.MouseDown(Button, Shift, X, Y);

    { MB Jun 15, 2000. Chain to new event }
    if Assigned(Self.FOnImageMouseDown) then
        FOnImageMouseDown(Self, Button, Shift, X, Y);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.ImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
    if Assigned(FMouseHandler) then
        FMouseHandler.MouseMove(Shift, X, Y);

    { MB Jun 15, 2000. Chain to new event }
    if Assigned(Self.FOnImageMouseMove) then
        FOnImageMouseMove(Self, Shift, X, Y);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.ImageMouseUp(
                 Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Assigned(FMouseHandler) then
        FMouseHandler.MouseUp(Button, Shift, X, Y);

    { MB Jun 15, 2000. Chain to new event }
    if Assigned(Self.FOnImageMouseUp) then
        FOnImageMouseUp(Self, Button, Shift, X, Y);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.ImageDblClick( Sender: TObject );
begin
    if Assigned(FMouseHandler) then
        FMouseHandler.MouseDblClick(Sender); //mdm 03/02/2003

    if Assigned(Self.FOnImageDblClick) then
        FOnImageDblClick(Self);
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.GetGraphic : TDibGraphic;
begin
    Result := FSourceGraphic;
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.GetDisplayedGraphic : TDibGraphic;
begin
    Result := TDibGraphic(FImage.Picture.Graphic);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetZoomMode( const InZoomMode : TZoomMode );
begin
    { MB Mar 11, 2002. Only change if needed }
    if FZoomMode <> InZoomMode then
    begin
        FZoomMode := InZoomMode;
        Redraw(False);
    end;
end;

{--------------------------------------------------------------------------}
procedure TImageScrollBox.SetZoomPercent( const InPercent : Single );
begin
    { MB Mar 11, 2002. Only change if needed }
    if ( FZoomMode = zmPercent ) and ( FZoomPercent = InPercent ) then
        Exit;

    if FSourceGraphic.IsEmpty or (InPercent <= 0.1) then
        Exit;

    FLastZoomPercent := FZoomPercent;
    FZoomPercent     := InPercent;
    FZoomMode        := zmPercent;

    { Since RecalcZoom will not change the zoom percent value,
      MouseHandler.BeforeResize must be called explicitely, as it will
      not be called by Redraw }
    if Assigned(FMouseHandler) then
        MouseHandler.BeforeResize;

    Redraw(False);

    if Assigned(FMouseHandler) then	// Added May 26, 2001 - BAL
        MouseHandler.AfterResize;

    if Assigned(FOnZoomChange) then	// Added May 26, 2001 - BAL
    	FOnZoomChange(Self, FZoomPercent);

    FDisplayEditor.ZoomFactor := Self.ZoomPercent;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.RecalcZoom;
var
    XFactor  : Single;
    YFactor  : Single;

begin
    case FZoomMode of
        zmFullPage, zmFitToPage :
        begin
            Self.VertScrollBar.Visible := False;
            XFactor := Self.ClientWidth / (FSourceGraphic.Width*1.0);

            Self.HorzScrollBar.Visible := False;
            YFactor := Self.ClientHeight / (FSourceGraphic.Height*1.0);

            if XFactor < YFactor then
                FZoomPercent := XFactor * 100
            else
                FZoomPercent := YFactor * 100;

            { with FitToPage, an image is never enlarged }
            if (FZoomMode = zmFitToPage) and
               (FZoomPercent > 100) then
                FZoomPercent := 100;

        end;

        zmFitWidth :
        begin
            XFactor := Self.ClientWidth / (FSourceGraphic.Width*1.0);
            FZoomPercent := XFactor * 100
        end;

        zmFitHeight :
        begin
            Self.VertScrollBar.Visible := False;
            Self.HorzScrollBar.Visible := False;

            YFactor := Self.ClientHeight / (FSourceGraphic.Height*1.0);
            FZoomPercent := YFactor * 100
        end;

        zmPercent :
        begin
            { keep current value }
        end;
        else
            { zmOriginal }
            FZoomPercent := 100;
    end; { case }
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.CenterImage( const NewWidth  : LongInt;
                                       const NewHeight : LongInt );
begin
    if Assigned(FMouseHandler) then
        MouseHandler.BeforeResize;

    { Sep 12, 1999. Thanks to Dan Parsons, dan@robonews.com for centering
      code }
    if (Self.Height > NewHeight) then
        FImage.Top := SafeTrunc((Self.Height - NewHeight)/2)
    else
        FImage.Top := 0;

    if (Self.Width > NewWidth) then
        FImage.Left := SafeTrunc((Self.Width - NewWidth)/2)
    else
        FImage.Left := 0;

    if Assigned(FMouseHandler) then	// Added May 26, 2001 - BAL
    	MouseHandler.AfterResize;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.Redraw( const GraphicChanged : Boolean );
var
    ZoomChanged   : Boolean;

begin
    if (Self.Parent = nil) or
       not Self.Visible then
        Exit;

    if FRedrawInProgress then
        Exit;

    FRedrawInProgress := True;
    try

        if FSourceGraphic.IsEmpty then
        begin
            DisplayedGraphic.Clear;

            Self.HorzScrollBar.Visible := False;
            Self.VertScrollBar.Visible := False;

            FImage.Visible := False;
            Exit;
        end;

        { MB Mar 02, 2000. Move outside of RedrawBW and RedrawNotBW.

          MB Apr 04, 2001. Change triggering of OnZoomChange by adding
          the FLastZoomPercent data member }
        RecalcZoom;
        ZoomChanged := (FLastZoomPercent <> FZoomPercent);
        if Assigned(FOnZoomChange) and ZoomChanged then
            FOnZoomChange(Self, FZoomPercent);
        FLastZoomPercent := FZoomPercent;

       { When GraphicChanged is True and the zoom value is not changed
         MouseHandler.BeforeResize must still be called, for example, to remove
         any selection with the TRubberBandMouseHandler }
        if Assigned(FMouseHandler) and
           (ZoomChanged or GraphicChanged) then
            MouseHandler.BeforeResize;

        if FSourceGraphic.ImageFormat = ifBlackWhite then
            RedrawBW
        else
            RedrawNotBW;

        if Assigned(FOnRedraw) then
            FOnRedraw(FSourceGraphic);

        if not FImage.Visible  then
            FImage.Visible := True;

        if Assigned(FMouseHandler)  and
          (ZoomChanged or GraphicChanged) then	// Added May 26, 2001 - BAL
	    MouseHandler.AfterResize;

        FDisplayEditor.ZoomFactor := Self.ZoomPercent;

    finally
        FRedrawInProgress := False;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.RedrawNotBW;
var
    NewWidth         : LongInt;
    NewHeight        : LongInt;

begin
    NewWidth   := SafeTrunc((FSourceGraphic.Width*1.0) * ((FZoomPercent) / 100.0));
    NewHeight  := SafeTrunc((FSourceGraphic.Height*1.0) * ((FZoomPercent) / 100.0));

    { MB Dec 21, 1999. Check size is not 0, to prevent failure in
      CreateDibSection call }
    if NewWidth <= 0 then
        NewWidth := 1;

    if NewHeight <= 0 then
        NewHeight := 1;

    Self.HorzScrollBar.Visible := NewWidth > Self.ClientWidth;
    Self.VertScrollBar.Visible := NewHeight > Self.ClientHeight;

    { MB Oct 07, 2002. Make the displayed graphic always true color to
      allow annotations on the DisplayedGraphic }
    FResizeTransform.Width              := NewWidth;
    FResizeTransform.Height             := NewHeight;
    FResizeTransform.OverrideDestFormat := True;
    FResizeTransform.DestFormat         := ifTrueColor;
    FResizeTransform.ApplyOnDest(FSourceGraphic, DisplayedGraphic);

    FImage.Width             := NewWidth;
    FImage.Height            := NewHeight;

    Self.HorzScrollBar.Range := NewWidth;
    Self.VertScrollBar.Range := NewHeight;

    Self.HorzScrollBar.Position := 0;
    Self.VertScrollBar.Position := 0;

    if FCentered then
        CenterImage(NewWidth, NewHeight)
    else
    begin
        FImage.Top  := 0;
        FImage.Left := 0;
    end;

    FImageRect := Rect(FImage.Left,FImage.Top,FImage.Left + FImage.Width,FImage.Top + FImage.Height);

    FImage.Invalidate;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.RedrawBW;
var
    NewWidth         : LongInt;
    NewHeight        : LongInt;

begin
    NewWidth   := SafeTrunc((FSourceGraphic.Width*1.0) * ((FZoomPercent) / 100.0));
    NewHeight  := SafeTrunc((FSourceGraphic.Height*1.0) * ((FZoomPercent) / 100.0));

    { MB Dec 21, 1999. Check size is not 0, to prevent failure in
      CreateDibSection call }
    if NewWidth <= 0 then
        NewWidth := 1;

    if NewHeight <= 0 then
        NewHeight := 1;

    Self.HorzScrollBar.Visible := NewWidth > Self.ClientWidth;
    Self.VertScrollBar.Visible := NewHeight > Self.ClientHeight;

    { MB Oct 07, 2002. Make the displayed graphic always true color to
      allow annotations on the DisplayedGraphic }
    FResizeTransform.Width              := NewWidth;
    FResizeTransform.Height             := NewHeight;
    FResizeTransform.OverrideDestFormat := True;
    FResizeTransform.DestFormat         := ifTrueColor;

    { MB Nov 21, 2001. Recode with new antialias transform that does the refile }
    if FAntiAliased then
    begin
        { MB Nov 21, 2001. Resize with the antialias transform }
        FAntiAliasTransform.Width  := NewWidth;
        FAntiAliasTransform.Height := NewHeight;
        FAntiAliasTransform.ApplyOnDest(FSourceGraphic, DisplayedGraphic);

        { MB Oct 08, 2002. Convert to true color for annotations }
        FResizeTransform.Apply(DisplayedGraphic);
    end
    else
        FResizeTransform.ApplyOnDest(FSourceGraphic, DisplayedGraphic);

    FImage.Width             := NewWidth;
    FImage.Height            := NewHeight;

    Self.HorzScrollBar.Range := NewWidth;
    Self.VertScrollBar.Range := NewHeight;

    Self.HorzScrollBar.Position := 0;
    Self.VertScrollBar.Position := 0;

    if FCentered then
        CenterImage(NewWidth, NewHeight)
    else
    begin
        FImage.Top  := 0;
        FImage.Left := 0;
    end;

    FImageRect := Rect(FImage.Left,FImage.Top,FImage.Left + FImage.Width,FImage.Top + FImage.Height);

    FImage.Invalidate;
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.GetFrameCount : LongInt;
begin
    Result := FSourceGraphic.FrameCount;
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.GetFrame(FrameNo : LongInt) : TDibGraphic;
begin
    Result := FSourceGraphic.Frames[FrameNo];
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.GetCurrentFrame : LongInt;
begin
    Result := FSourceGraphic.CurrentFrame;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetCurrentFrame( const FrameNo : LongInt );
begin
    FSourceGraphic.CurrentFrame := FrameNo;
    Redraw(True);
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.GetAnimated : Boolean;
begin
    Result := FAnimated;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetAnimated( const InAnimated : Boolean );
var
    FrameNo : Integer;
begin
    if InAnimated = FAnimated then
        Exit;

    FAnimated := InAnimated;

    if FAnimated and (FrameCount > 1) then
    begin
        { set the dimensions of Image to the largest frame }
        for FrameNo := 1 to FSourceGraphic.FrameCount do
        begin
            if FSourceGraphic.Frames[FrameNo].Width > FImage.Width then
                FImage.Width := FSourceGraphic.Frames[FrameNo].Width;

            if FSourceGraphic.Frames[FrameNo].Height > FImage.Height then
                FImage.Height := FSourceGraphic.Frames[FrameNo].Height;
        end;

        FAnimationTimer.Interval := FSourceGraphic.ImageDelay;
        FAnimationTimer.Enabled  := True;
    end
    else
    begin
        FAnimationTimer.Enabled  := False;
        FAnimated                := False;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.CopySelectionToClipboard;
begin
    if not (MouseHandler is TRubberbandMouseHandler) then
        raise EEnvisionError.Create(msgRubberbandHandlerNotActive);

    TRubberbandMouseHandler(MouseHandler).CopySelectionToClipboard;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.CropToSelection;
begin
    if not (MouseHandler is TRubberbandMouseHandler) then
        raise EEnvisionError.Create(msgRubberbandHandlerNotActive);

    TRubberbandMouseHandler(MouseHandler).CropToSelection;
    TRubberbandMouseHandler(MouseHandler).ClearSelection;
end;

{--------------------------------------------------------------------------}

//mdm 03/01/2003
procedure TImageScrollBox.ExtractSelection(const Dest: TDibGraphic);
begin
    if not (MouseHandler is TRubberbandMouseHandler) then
        raise EEnvisionError.Create(msgRubberbandHandlerNotActive);

    TRubberbandMouseHandler(MouseHandler).ExtractSelection(Dest);
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.CopyGraphicIntoSelection( const Graphic : TGraphic );
var
     Rect          : Windows.TRect;
begin
    if not (MouseHandler is TRubberbandMouseHandler) then
        raise EEnvisionError.Create(msgRubberbandHandlerNotActive);

    TRubberbandMouseHandler(MouseHandler).GetSourceSelection(Rect);

    Self.Graphic.Canvas.StretchDraw(Rect, Graphic);
end;


{--------------------------------------------------------------------------}

procedure TImageScrollBox.ZoomToSelection;
var
    Rect        : Windows.TRect;
    MH          : TRubberBandMouseHandler;

    XZoom       : Single;
    YZoom       : Single;

    OldZoom     : Single;

begin
    if not (MouseHandler is TRubberbandMouseHandler) then
        raise EEnvisionError.Create(msgRubberbandHandlerNotActive);

    MH := TRubberbandMouseHandler(MouseHandler);

    if not MH.SelectionActive then
        raise ERubberbandError.Create(msgRegionNotSelected);

    MH.GetSelection(Rect);

    MH.ClearSelection;

    OldZoom := ZoomPercent;

    XZoom   := ZoomPercent * (Self.Width / (Rect.Right - Rect.Left + 1) * 1.0);
    YZoom   := ZoomPercent * (Self.Height / (Rect.Bottom - Rect.Top + 1) * 1.0);

    { limit the zoom value to 1000 % }
    SetZoomPercent( MinFloat(MinFloat(XZoom,1000), YZoom) );

    HorzScrollBar.Position := SafeTrunc(Rect.Left * (ZoomPercent / OldZoom));
    VertScrollBar.Position := SafeTrunc(Rect.Top * (ZoomPercent / OldZoom));
end;


{--------------------------------------------------------------------------}

function TImageScrollBox.AssignFromClipBoard : Boolean;
begin
    Result := Clipboard.HasFormat(CF_BITMAP);

    if Result then
    begin
        { MB Jan 17, 2002. Previously the clipboard was assigned directly to
          Self.Graphic. This caused some confusion because if Self.Graphic
          was a TTiffGraphic, it may include annotations which were not
          cleared. To avoid future side effects, an new TDibGraphic is
          loaded everytime an image is copied from the clipboard. }
        FSourceGraphic.Free;
        FSourceGraphic := TDibGraphic.Create;
        FSourceGraphic.Assign(Clipboard);

        FFileName       := '';

        FAnnotationsStr := '';

        FDisplayEditor.Clear;

        DoNewGraphic(FSourceGraphic);

        Redraw(True);
    end;
end;

{--------------------------------------------------------------------------}

function TImageScrollBox.GetAnnotations : AnsiString;
begin
    { refresh the annotations if this is the current mouse handler }
    if (FMouseHandler is TAnnotationMouseHandler) then
        FAnnotationsStr := TAnnotationMouseHandler(FMouseHandler).AnnotationsStr;

    Result          := FAnnotationsStr;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetAnnotations( const Str : AnsiString );
begin
    if (FMouseHandler is TAnnotationMouseHandler) then
        TAnnotationMouseHandler(FMouseHandler).AnnotationsStr := Str;

    FAnnotationsStr := Str;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.ShowAnnotations;
begin
    if Graphic.IsEmpty or (FAnnotationsStr = '') or (MouseMode = mmAnnotate) then
        Exit;

    FDisplayEditor.DisplayRect          := Classes.Rect( 0, 0, Self.Graphic.Width, Self.Graphic.Height);
    FDisplayEditor.Visible              := True;
    FDisplayEditor.ZoomFactor           := Self.ZoomPercent;
    FDisplayEditor.DisplayVertScrollBar := Self.VertScrollBar;
    FDisplayEditor.DisplayHorzScrollBar := Self.HorzScrollBar;

    FDisplayEditor.LoadFromString(FAnnotationsStr);

    FDisplayEditor.AllowEdit            := False;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.HideAnnotations;
begin
    FDisplayEditor.Visible := False;
end;
{--------------------------------------------------------------------------}

procedure TImageScrollBox.AddNote;
begin
    if (FMouseHandler is TAnnotationMouseHandler) and
       (not FSourceGraphic.IsEmpty) then
        TAnnotationMouseHandler(FMouseHandler).AddNote;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.AddText;
begin
    if (FMouseHandler is TAnnotationMouseHandler) and
       (not FSourceGraphic.IsEmpty) then
        TAnnotationMouseHandler(FMouseHandler).AddText;
end;

{--------------------------------------------------------------------------}
procedure TImageScrollBox.AddRectangle;
begin
    if (FMouseHandler is TAnnotationMouseHandler) and
       (not FSourceGraphic.IsEmpty) then
        TAnnotationMouseHandler(FMouseHandler).AddRectangle;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.AddLine;
begin
    if (FMouseHandler is TAnnotationMouseHandler) and
       (not FSourceGraphic.IsEmpty) then
        TAnnotationMouseHandler(FMouseHandler).AddLine;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.AddImage;
begin
    if (FMouseHandler is TAnnotationMouseHandler) and
       (not FSourceGraphic.IsEmpty) then
        TAnnotationMouseHandler(FMouseHandler).AddImage;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.BurnAnnotations;
var
    Transform : TImageFormatTransform;

begin
    if not (FMouseHandler is TAnnotationMouseHandler) then
        Exit;

    Transform := TImageFormatTransform.Create;
    try
        Transform.ImageFormat := ifTrueColor;
        Transform.Apply(Self.Graphic);
    finally
        Transform.Free;
    end;

    TAnnotationMouseHandler(FMouseHandler).Burn;
end;

{--------------------------------------------------------------------------}

procedure TImageScrollBox.SetAlwaysShowAnnotations( const Show : Boolean );
begin
    if FAlwaysShowAnnotations = Show then
        Exit;

    FAlwaysShowAnnotations := Show;

    if Show then
        ShowAnnotations
    else
        HideAnnotations;
end;

{--------------------------------------------------------------------------}

constructor TMouseHandler.Create( const InImageScrollBox : TImageScrollBox );
begin
    inherited Create;

    FImageScrollBox := InImageScrollBox;
end;

{--------------------------------------------------------------------------}

procedure TMouseHandler.MouseDown(
                         const Button : TMouseButton;
                         const Shift  : TShiftState;
                         const X, Y   : Integer );
begin
    FMouseIsDown := True;
end;

{--------------------------------------------------------------------------}

procedure TMouseHandler.MouseUp(
                       const Button : TMouseButton;
                       const Shift  : TShiftState;
                       const X, Y   : Integer );
begin
    FMouseIsDown := False;
end;

{--------------------------------------------------------------------------}

procedure TMouseHandler.MouseMove(
                     const Shift : TShiftState;
                     const X, Y  : Integer );
begin
end;

{--------------------------------------------------------------------------}

procedure TMouseHandler.MouseDblClick( Sender : TObject );
begin
  //mdm 03/02/2003
end;

{--------------------------------------------------------------------------}

procedure TMouseHandler.BeforeResize;
begin
end;

{--------------------------------------------------------------------------}

procedure TMouseHandler.AfterResize;
begin
end;

{--------------------------------------------------------------------------}

constructor TDragMouseHandler.Create( const InImageScrollBox : TImageScrollBox );
begin
    inherited Create(InImageScrollBox);

    FImageScrollBox.FImage.Cursor := crHandOpened;
end;

{--------------------------------------------------------------------------}

procedure TDragMouseHandler.MouseDown(
                     const Button : TMouseButton;
                     const Shift  : TShiftState;
                     const X, Y   : Integer );
begin
    { The cursor of the screen must be changes. Changing the cursor of the
      image not sufficient.

      MB Nov 22, 2002. Don't drag with both left/right buttons are pressed }
    if (ImageScrollBox.VertScrollBar.Visible or
        ImageScrollBox.HorzScrollBar.Visible )
        and
       (Button <> mbRight) then
    begin
        FMouseIsDown     := True;

        FStartMousePos.X := X;
        FStartMousePos.Y := Y;

        FScreenCursor    := Screen.Cursor;

        Screen.Cursor    := crHandClosed;
    end;
end;

{--------------------------------------------------------------------------}

procedure TDragMouseHandler.MouseUp(
                       const Button : TMouseButton;
                       const Shift  : TShiftState;
                       const X, Y   : Integer );
begin
    if FMouseIsDown then
    begin
        if Screen.Cursor = crHandClosed then
        begin
            Screen.Cursor  := FScreenCursor;
        end;

        FMouseIsDown := False;
    end;
end;

{--------------------------------------------------------------------------}

procedure TDragMouseHandler.MouseMove(
                         const Shift : TShiftState;
                         const X, Y  : Integer );
begin
    if FMouseIsDown then
    begin
        ImageScrollBox.HorzScrollBar.Position :=  ImageScrollBox.HorzScrollBar.Position + FStartMousePos.X - X;
        ImageScrollBox.VertScrollBar.Position :=  ImageScrollBox.VertScrollBar.Position + FStartMousePos.Y - Y;
        UpdateWindow(ImageScrollBox.Handle);
    end;
end;

{--------------------------------------------------------------------------}

constructor TQuickSelectMouseHandler.Create( const InImageScrollBox : TImageScrollBox );
begin
    inherited Create(InImageScrollBox);

    FCanvas           := TCanvas.Create;

    FImageScrollBox.FImage.Cursor := crDefault;
end;

{--------------------------------------------------------------------------}

destructor TQuickSelectMouseHandler.Destroy;
begin
    FCanvas.Free;

    inherited Destroy;
end;

{--------------------------------------------------------------------------}

procedure TQuickSelectMouseHandler.BoundXY( var X, Y : Integer );
var
    Graphic : TDibGraphic;
begin
    Graphic := FImageScrollBox.DisplayedGraphic;

    if X < FImageScrollBox.FImage.Left then
        X := FImageScrollBox.FImage.Left;

    if Y < FImageScrollBox.FImage.Top then
        Y := FImageScrollBox.FImage.Top;

    if X >= (Graphic.Width + FImageScrollBox.FImage.Left) then
        X := Graphic.Width + FImageScrollBox.FImage.Left - 1;

    if Y >= (Graphic.Height + FImageScrollBox.FImage.Top) then
        Y := Graphic.Height + FImageScrollBox.FImage.Top - 1;
end;

{--------------------------------------------------------------------------}

{ Adjust Rect to Left and Top fields are to the left and top of the
  Right and Bottom fields. }
function AdjustRect(Rect : TRect): TRect;
begin
    with Rect do
    begin
        if Left > Right then
        begin
            if Top > Bottom then
                Result := Classes.Rect(Right,Bottom,Left,Top)
            else
                Result := Classes.Rect(Right,Top,Left,Bottom)
        end
        else
        begin
            if Top > Bottom then
                Result := Classes.Rect(Left,Bottom,Right,Top)
            else
                Result := Classes.Rect(Left,Top,Right,Bottom);
        end;
    end;
end;

{--------------------------------------------------------------------------}

procedure TQuickSelectMouseHandler.DrawXORBand;
begin
    FCanvas.MoveTo(FX1, FY1);

    FCanvas.LineTo(FX2, FY1);
    FCanvas.LineTo(FX2, FY2);
    FCanvas.LineTo(FX1, FY2);
    FCanvas.LineTo(FX1, FY1);
end;

{--------------------------------------------------------------------------}

procedure TQuickSelectMouseHandler.DrawBand;
begin
    DrawXORBand;
end;

{--------------------------------------------------------------------------}

procedure TQuickSelectMouseHandler.RemoveBand;
begin
    DrawXORBand;
end;

{--------------------------------------------------------------------------}

procedure TQuickSelectMouseHandler.MouseDown(
                     const Button : TMouseButton;
                     const Shift  : TShiftState;
                     const X, Y   : Integer );
begin
    { The drag mouse handler does not work when the image is centered }
    if FImageScrollBox.Centered then
        Exit;

    FMouseIsDown     := True;

    { the device context handle is obtained here, because when obtained
      in the constructor, an exception was raised when releasing the
      device context in the destructor. }
    FCanvas.Handle    := GetDC(FImageScrollBox.Handle);
    FCanvas.Pen.Color := clBlack;
    FCanvas.Pen.Mode  := pmXOR;
    FCanvas.Pen.Style := psDot;

    FX1 := X + FImageScrollBox.FImage.Left;
    FY1 := Y + FImageScrollBox.FImage.Top;

    FX2 := FX1;
    FY2 := FY1;

		DrawBand; // BAL
end;

{--------------------------------------------------------------------------}

procedure TQuickSelectMouseHandler.MouseMove(
                         const Shift : TShiftState;
                         const X, Y  : Integer );
var
    LocalX  : Integer;
    LocalY  : Integer;
begin
    if FMouseIsDown and (ssLeft in Shift) then
    begin
        LocalX  := X + FImageScrollBox.FImage.Left;
        LocalY  := Y + FImageScrollBox.FImage.Top;

        BoundXY(LocalX,LocalY);

        RemoveBand;

        FX2 := LocalX;
        FY2 := LocalY;

        DrawBand;
    end;
end;

{--------------------------------------------------------------------------}

procedure TQuickSelectMouseHandler.MouseUp(
                       const Button : TMouseButton;
                       const Shift  : TShiftState;
                       const X, Y   : Integer );
var
    Rect             : TRect;
    Graphic          : TDibGraphic;
    CropTransform    : TCropTransform;
    DisplayedGraphic : TDibGraphic;
begin
    if FMouseIsDown then
    begin
        RemoveBand;

        DisplayedGraphic := TDibGraphic(FImageScrollBox.FImage.Picture.Graphic);

        Rect.Right := X;
        if Rect.Right > DisplayedGraphic.Width then
            Rect.Right := DisplayedGraphic.Width;
        if Rect.Right < 0 then
            Rect.Right := 0;

        Rect.Bottom := Y;
        if Rect.Bottom > DisplayedGraphic.Height then
            Rect.Bottom := DisplayedGraphic.Height;
        if Rect.Bottom < 0 then
            Rect.Bottom := 0;

        Rect.Left := FX1 - FImageScrollBox.FImage.Left;
        Rect.Top  := FY1 - FImageScrollBox.FImage.Top;

        Rect := AdjustRect(Rect);

        if ((Rect.Right - Rect.Left) >= 1) and
           ((Rect.Bottom - Rect.Top) >= 1) then
        begin
            Graphic := TDibGraphic.Create;
            CropTransform := TCropTransform.Create;
            try
                CropTransform.Top    := Rect.Top;
                CropTransform.Left   := Rect.Left;
                CropTransform.Bottom := DisplayedGraphic.Height - Rect.Bottom;
                CropTransform.Right  := DisplayedGraphic.Width - Rect.Right;

                CropTransform.ApplyOnDest(DisplayedGraphic, Graphic);

                if Assigned(FImageScrollBox.FOnQuickSelect) then
                    FImageScrollBox.FOnQuickSelect( FImageScrollBox,
                                                    Graphic, Rect);

            finally
                CropTransform.Free;
                Graphic.Free;
            end;
        end;

        ReleaseDC(FImageScrollBox.Handle, FCanvas.Handle);

        { clear the canvas handle to 0, otherwise the next rubber band was
          not drawn in pmXOR mode. } 
        FCanvas.Handle := 0;

        FMouseIsDown := False;
    end;
end;

{--------------------------------------------------------------------------}

initialization
    Screen.Cursors[crHandOpened] := LoadCursor(hInstance, 'HANDOPENEDCURSOR');
    Screen.Cursors[crHandClosed] := LoadCursor(hInstance, 'HANDCLOSEDCURSOR');
end.





