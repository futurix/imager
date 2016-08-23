{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnRubber
|
| Description: Rubber band mouse handler class.
|
| Known issues: This mouse handler does not work when the related
|               TImageScrollBox has the Centered property True.
|
| History:
|          Feb 29, 2000. Michel Brazeau, first version
|          May     2000. W. Miller added methods to pass selected coords to ImageScrollbox
|          Jun     2000. M. Brazeau. Fix problems when resizing band when the scroll
|                        bars are not at left and top.
|          Jun 26, 2000. M. Brazeau, Add CropToSelection as suggested by W. Miller
|          Apr 7-9 2002. Brian Lowe, Dan Sox and Bill Miller,
|                                                  fixed colors when animated
|                                                  added grip handles
|                                                  added ShowGrips property
|                                                  added GripSize property
|                                                  added GripColor property
|                        Other improvements
|---------------------------------------------------------------------------}
unit EnRubber;

{$I Envision.Inc}

interface

uses
    Windows,  { for LoadCursor, TPoint }
    SysUtils, { for Exception }
    Classes,  { for TComponent }
    Controls, { for TMouseButton }
    EnDiGrph, { for TDibGraphic, NewDibGraphic }
    EnTransf, { for TResizeTransform }
    ExtCtrls, { for TImage }
    EnImgScr, { for TMouseHandler }
    Graphics, { for TGraphic }
    Forms;    { for TScrollingWinControl }


type

{--------------------------------------------------------------------------}

TProtectedScrollBox = class(TImageScrollBox);

TBandMovement = ( bmAllDirections, bmTopBottom, bmLeftRight, bmInside );

TGrabHandle = ( ghTopLeft, ghTop, ghTopRight,
                ghRight, ghBottomRight, ghBottom,
                ghBottomLeft, ghLeft, ghInside );

TRubberbandMouseHandler = class(TMouseHandler)
private
    FX1                 : Integer;
    FY1                 : Integer;
    FX2                 : Integer;
    FY2                 : Integer;
    FCanvas             : TCanvas;
    FImageScrollBox     : TProtectedScrollBox;
    FBandVisible        : Boolean;
    FBandMovement       : TBandMovement;
    FGrabHandle         : TGrabHandle;
    FSaveSize           : TPoint;

    FAnimated   	: Boolean;
    FAnimationTimer	: TTimer;
    FAnimationInterval  : Integer;
    FTempFore           : TColor;
    FTempBack           : TColor;
    FMouseX,FMouseY	: Integer;

    FShowGrips          : Boolean;
    FGripSize           : Integer;
    FGripColor          : TColor;

protected

    procedure SetAnimated(const Animation : Boolean);
    function GetAnimated: Boolean;
    procedure SetAnimationInterval(const Interval : Integer);
    function GetAnimationInterval : Integer;

    procedure SetBackgroundColor( const Color : TColor );
    function GetBackgroundColor : TColor;

    procedure SetForegroundColor( const Color : TColor );
    function GetForegroundColor : TColor;

    procedure SetGripSize(const GripSize : Integer);
    function GetGripSize : Integer;

    procedure SetShowGrips(const ShowGrips : Boolean);
    function GetShowGrips : Boolean;

    procedure SetGripColor(const Color: TColor);
    function GetGripColor: TColor;

    procedure SetLineStyle( const Style : TPenStyle );
    function GetLineStyle : TPenStyle;

    procedure SetLineMode(const Mode: TPenMode);
    function GetLineMode: TPenMode; 

    procedure BoundXY( var X, Y : Integer );

    procedure DrawBand;
    procedure RemoveBand;

    procedure GraphicDraw( Sender : TObject );

    procedure BeforeResize; override;
    procedure AfterResize; override;

    function MouseOnGrabHandle( const X, Y       : Integer;
                                var   GrabHandle : TGrabHandle ) : Boolean;

    { trigger the FOnRubberbandChange event  }
    procedure DoRubberbandChange( const   X1   : Integer;
                                  const   Y1   : Integer;
				  const   X2   : Integer;
				  const   Y2   : Integer );

public
    constructor Create( const InImageScrollBox : TImageScrollBox );
    destructor Destroy; override;
    procedure MouseDown( const Button : TMouseButton;
                     	 const Shift  : TShiftState;
                         const X, Y   : Integer ); override;

    procedure MouseUp( const Button : TMouseButton;
                       const Shift  : TShiftState;
                       const X, Y   : Integer ); override;
    procedure MouseMove( const Shift : TShiftState;
                         const X, Y  : Integer ); override;

    procedure CopySelectionToClipBoard;

    { Crop the currently selected region, and the selected region will replace
      the entire graphic in the related TImageScrollBox }
    procedure CropToSelection;
    procedure ExtractSelection(Dest: TDibGraphic); //mdm 03/01/2003

    { Returns the selection defined by the rubber band. The size of the selection
      is with respect to the resized (ie, displayed graphic). For example,
      the selection may be larger than the original graphic if the image is
      displayed with a zoom > 100% }
    procedure GetSelection( var Rect: TRect );
    function GetXFactor: Double;
    function GetYFactor: Double;

    { Returns the selection defined by the rubber band. The size of the selection
      is with respect to the original graphic, no matter what the zoom value
      is. }
    procedure GetSourceSelection( var Rect : TRect );
    procedure ClearSelection;

    property ForegroundColor: TColor read GetForegroundColor write SetForegroundColor;
    property BackgroundColor: TColor read GetBackgroundColor write SetBackgroundColor;
    property LineStyle: TPenStyle read GetLineStyle write SetLineStyle;
    property LineMode: TPenMode read GetLineMode write SetLineMode;

    property SelectionActive: Boolean read FBandVisible write FBandVisible;

    property Animated : Boolean read GetAnimated write SetAnimated;
    property AnimationInterval : Integer read GetAnimationInterval write SetAnimationInterval;
    procedure DrawBandTimerEvent(Sender : TObject);

    property ShowGrips: Boolean read GetShowGrips write SetShowGrips;
    property GripSize: Integer read GetGripSize write SetGripSize;
    property GripColor: TColor read GetGripColor write SetGripColor;

end;

ERubberbandError = class(Exception);


{--------------------------------------------------------------------------}

implementation

uses
    ClipBrd,  { for ClipBoard }
    Dialogs,  { for MessageDlg }
    EnMsg,    { for msgXXXX }
    EnMisc;   { for BoundInteger }

{--------------------------------------------------------------------------}

const

CHandleGrabPixelSize = 4;
crHandOpened         = 100;
crHandClosed         = 101;

{--------------------------------------------------------------------------}

function GrabHandleToBandMovement( const GrabHandle : TGrabHandle ) : TBandMovement;
begin
    case GrabHandle of

        ghTopLeft,
        ghBottomRight,
        ghTopRight,
        ghBottomLeft   : Result := bmAllDirections;

	ghTop,
        ghBottom       : Result := bmTopBottom;

	ghLeft,
        ghRight        : Result := bmLeftRight;

	ghInside       : Result := bmInside;

	else
	    raise Exception.Create('Invalid GrabHandle, GrabHandleToBandMovement');
    end;
end;

{--------------------------------------------------------------------------}

function GrabHandleToCursor( const GrabHandle : TGrabHandle ) : TCursor;
begin
    case GrabHandle of

        ghTopLeft,
        ghBottomRight  : Result := crSizeNWSE;

        ghTop,
        ghBottom       : Result := crSizeNS;

        ghTopRight,
        ghBottomLeft   : Result := crSizeNESW;

        ghLeft,
        ghRight        : Result := crSizeWE;

        ghInside       : Result := crHandOpened;

        else
            raise Exception.Create('Invalid GrabHandle, GrabHandleToCursor');
    end;
end;

{--------------------------------------------------------------------------}

constructor TRubberbandMouseHandler.Create( const InImageScrollBox : TImageScrollBox );
begin
    inherited Create(InImageScrollBox);

    FImageScrollBox := TProtectedScrollBox(InImageScrollBox);
    FImageScrollBox.FImage.Cursor := crDefault;

    FCanvas                  := TCanvas.Create;
    FCanvas.Handle           := GetDC(FImageScrollBox.Handle);
    FCanvas.Pen.Mode         := pmCopy;
    FCanvas.Pen.Style        := psDot;
    ForeGroundColor          := clWhite;
    BackGroundColor          := clNavy;
    FBandVisible             := False;

    FBandMovement            := bmAllDirections;

    FImageScrollBox.DisplayedGraphic.AfterDraw := GraphicDraw;

    FAnimationTimer          := TTimer.Create(InImageScrollBox);
    FAnimated                := False;
    FAnimationInterval       := 400;
    FAnimationTimer.OnTimer  := DrawBandTimerEvent;;
    FAnimationTimer.Enabled  := FAnimated;
    FAnimationTimer.Interval := FAnimationInterval;
    FTempFore                := ForeGroundColor;
    FTempBack                := BackGroundColor;

    FShowGrips               := False;
    FGripSize                := 6;
    FGripColor               := BackGroundColor;
end;

{--------------------------------------------------------------------------}

destructor TRubberbandMouseHandler.Destroy;
begin
    if FBandVisible then
        RemoveBand;

    FAnimationTimer.Enabled := False;
    FAnimationTimer.Free;

    FImageScrollBox.DisplayedGraphic.AfterDraw := nil;
    ReleaseDC(FImageScrollBox.Handle, FCanvas.Handle);
    FCanvas.Free;

    inherited Destroy;
end;

{--------------------------------------------------------------------------}
procedure TRubberbandMouseHandler.SetAnimated(const Animation : Boolean);
begin
    FAnimated := Animation;
    FAnimationTimer.Enabled := FAnimated;
end;

{--------------------------------------------------------------------------}

function  TRubberbandMouseHandler.GetAnimated : Boolean;
begin
    FAnimated := FAnimationTimer.Enabled;
    Result    := FAnimated;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.SetAnimationInterval(const Interval : Integer);
begin
    FAnimationInterval       := Interval;
    FAnimationTimer.Interval := FAnimationInterval;
end;

{--------------------------------------------------------------------------}

function  TRubberbandMouseHandler.GetAnimationInterval : Integer;
begin
    FAnimationInterval := FAnimationTimer.Interval;
    Result := FAnimationInterval;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.SetGripSize(const GripSize: Integer);
begin
    FGripSize := GripSize;
end;

{--------------------------------------------------------------------------}

function TRubberbandMouseHandler.GetGripSize: Integer;
begin
    Result := FGripSize;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.SetShowGrips(const ShowGrips : Boolean);
begin
    FShowGrips := ShowGrips;
end;

{--------------------------------------------------------------------------}

function TRubberbandMouseHandler.GetShowGrips: Boolean;
begin
    Result := FShowGrips;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.SetGripColor(const Color: TColor);
begin
    FGripColor := Color;
end;

{--------------------------------------------------------------------------}

function TRubberbandMouseHandler.GetGripColor: TColor;
begin
    Result := FGripColor;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.SetBackgroundColor( const Color : TColor );
begin
    FTempBack           := Color;
    FCanvas.Brush.Color := Color;
end;

{--------------------------------------------------------------------------}

function TRubberbandMouseHandler.GetBackgroundColor : TColor;
begin
    FTempBack := FCanvas.Brush.Color;
    Result    := FCanvas.Brush.Color;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.SetForegroundColor( const Color : TColor );
begin
    FTempBack         := Color;
    FCanvas.Pen.Color := Color;
end;

{--------------------------------------------------------------------------}

function TRubberbandMouseHandler.GetForegroundColor : TColor;
begin
   FTempFore := FCanvas.Pen.Color;
   Result    := FCanvas.Pen.Color;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.SetLineStyle( const Style : TPenStyle );
begin
    if not (Style in [psSolid, psDash, psDot, psDashDot, psDashDotDot]) then
        raise EEnvisionError.Create(msgInvalidRubberbandLineStyle);

    FCanvas.Pen.Style := Style;
end;

{--------------------------------------------------------------------------}

function TRubberbandMouseHandler.GetLineStyle : TPenStyle;
begin
    Result := FCanvas.Pen.Style;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.SetLineMode(const Mode: TPenMode);
begin
    FCanvas.Pen.Mode := Mode;
end;

{--------------------------------------------------------------------------}

function TRubberbandMouseHandler.GetLineMode: TPenMode;
begin
    Result := FCanvas.Pen.Mode;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.GraphicDraw( Sender : TObject );
begin
    if FBandVisible then
	DrawBand;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.BoundXY( var X, Y : Integer );
var
    Graphic : TDibGraphic;
begin
    Graphic := FImageScrollBox.FImage.Picture.Graphic as TDibGraphic;

    if Y < 0 then
        Y := 0;

    if X < 0 then
        X := 0;

    if X >= Graphic.Width then
        X := Graphic.Width - 1;

    if Y >= Graphic.Height then
        Y := Graphic.Height - 1;
end;

{--------------------------------------------------------------------------}

procedure AdjustRect(var Rect : TRect);
var
    I : Integer;
begin
    if Rect.Left > Rect.Right then
    begin
        I          := Rect.Left;
        Rect.Left  := Rect.Right;
	Rect.Right := I;
    end;

    if Rect.Top > Rect.Bottom then
    begin
        I           := Rect.Top;
        Rect.Top    := Rect.Bottom;
    	Rect.Bottom := I;
    end;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.DrawBandTimerEvent(Sender : TObject);
begin
    if FBandVisible then
    begin
        if ForegroundColor = FTempFore then
            ForeGroundColor := FTempBack
        else
            ForeGroundColor := FTempFore;

        if BackgroundColor = FTempBack then
            BackGroundColor := FTempFore
        else
            BackGroundColor := FTempBack;

        DrawBand;
    end;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.DrawBand;
var
    OldBrushColor  : TColor;

    function MakeGrabRect(X, Y: Integer): TRect;
    var
      HOffset,
      VOffset,
      GripOffset: Integer;
    begin
      { Added 03/01/2003 - MDM }

      HOffset    := X - FImageScrollBox.HorzScrollBar.Position;
      VOffset    := Y - FImageScrollBox.VertScrollBar.Position;
      GripOffset := FGripSize div 2;

      IntersectRect(Result,
                    FImageScrollbox.FImageRect,
                    Rect(HOffset - GripOffset,
                         VOffset - GripOffset,
                         HOffset + GripOffset,
                         VOffset + GripOffset));

    end;

begin
    //mdm 03/01/2003 - Make sure the selection is actually in the source image
    //                 This was previously downsizing the selection area when
    //                 the selection was moved and one side or another hit the
    //                 image outer boundary.  It was also creating band artifacts
    //                 when the mouse was initially clicked and dragged outside
    //                 the image boundaries.
    if not (PtInRect(FImageScrollbox.FImageRect, Point(FX1, FY1)) and
            PtInRect(FImageScrollbox.FImageRect, Point(FX2, FY2))) then
      Exit;

    FCanvas.MoveTo(FX1-FImageScrollBox.HorzScrollBar.Position, FY1-FImageScrollBox.VertScrollBar.Position);

    FCanvas.LineTo(FX2-FImageScrollBox.HorzScrollBar.Position, FY1-FImageScrollBox.VertScrollBar.Position);
    FCanvas.LineTo(FX2-FImageScrollBox.HorzScrollBar.Position, FY2-FImageScrollBox.VertScrollBar.Position);
    FCanvas.LineTo(FX1-FImageScrollBox.HorzScrollBar.Position, FY2-FImageScrollBox.VertScrollBar.Position);
    FCanvas.LineTo(FX1-FImageScrollBox.HorzScrollBar.Position, FY1-FImageScrollBox.VertScrollBar.Position);

    if FShowGrips then
    begin
        OldBrushColor := FCanvas.Brush.Color;
        try
            BackgroundColor := FGripColor;

            //mdm 03/01/2003 - Grip handles were being allowed to overlap the
            //                 image boundaries and that overlap was not being
            //                 cleared when removed.  The MakeGrabRect function
            //                 now restricts the grab handle rect to an area
            //                 within the image boundaries.
            FCanvas.FillRect(MakeGrabRect(FX1, FY1));
            FCanvas.FillRect(MakeGrabRect(FX2, FY1));
            FCanvas.FillRect(MakeGrabRect(FX2, FY2));
            FCanvas.FillRect(MakeGrabRect(FX1, FY2));
        finally
            BackgroundColor := OldBrushColor;
        end;

        { MB May 16, 2002. Very strange, if a call to FillRect is not done after
          restoring the BackgroundColor, there were strange effects. For example,
          after drawing the band with grips, then changing the vertical scroll
          bar position, the band would be refresh with the brush color set
          to the grip color }
        FCanvas.FillRect( Rect( 1, 1, 0, 0 ));

    end;

    FBandVisible := True;

end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.RemoveBand;
var
    Graphic : TDibGraphic;
    Rect    : TRect;
begin
    Graphic     := FImageScrollBox.DisplayedGraphic;

    Rect.Top    := FY1-FImageScrollBox.VertScrollBar.Position;

    Rect.Bottom := FY2-FImageScrollBox.VertScrollBar.Position;

    Rect.Left   := FX1-FImageScrollBox.HorzScrollBar.Position;

    Rect.Right  := FX2-FImageScrollBox.HorzScrollBar.Position;

    AdjustRect(Rect);


    if FShowGrips then
    begin
        BitBlt( FCanvas.Handle,
                Rect.Left - FGripSize div 2,
                Rect.Top - FGripSize div 2,
                FGripSize,
                FGripSize,
                Graphic.DC,
                Rect.Left + FImageScrollBox.HorzScrollBar.Position - FGripSize div 2,
                Rect.Top + FImageScrollBox.VertScrollBar.Position - FGripSize div 2,
                SRCCOPY );

        BitBlt( FCanvas.Handle,
                Rect.Right - FGripSize div 2,
                Rect.Top - FGripSize div 2,
                FGripSize,
                FGripSize,
                Graphic.DC,
                Rect.Right + FImageScrollBox.HorzScrollBar.Position - FGripSize div 2,
                Rect.Top + FImageScrollBox.VertScrollBar.Position - FGripSize div 2,
                SRCCOPY );

        BitBlt( FCanvas.Handle,
                Rect.Left - FGripSize div 2,
                Rect.Bottom - FGripSize div 2,
                FGripSize,
                FGripSize,
                Graphic.DC,
                Rect.Left + FImageScrollBox.HorzScrollBar.Position - FGripSize div 2,
                Rect.Bottom + FImageScrollBox.VertScrollBar.Position - FGripSize div 2,
                SRCCOPY );

        BitBlt( FCanvas.Handle,
                Rect.Right - FGripSize div 2,
                Rect.Bottom - FGripSize div 2,
                FGripSize,
                FGripSize,
                Graphic.DC,
                Rect.Right + FImageScrollBox.HorzScrollBar.Position - FGripSize div 2,
                Rect.Bottom + FImageScrollBox.VertScrollBar.Position - FGripSize div 2,
                SRCCOPY );

    end;

    { top horizontal line }
    BitBlt( FCanvas.Handle,
	    Rect.Left,
	    Rect.Top,
	    Rect.Right + FImageScrollBox.HorzScrollBar.Position, //mdm 03/03/2003
	    1,
	    Graphic.DC,
	    Rect.Left + FImageScrollBox.HorzScrollBar.Position,
	    Rect.Top + FImageScrollBox.VertScrollBar.Position,
	    SRCCOPY );

    { right vertical line }
    BitBlt( FCanvas.Handle,
	    Rect.Right,
	    Rect.Top,
	    1,
	    Rect.Bottom + FImageScrollBox.VertScrollBar.Position, //mdm 03/03/2003
	    Graphic.DC,
	    Rect.Right + FImageScrollBox.HorzScrollBar.Position,
	    Rect.Top + FImageScrollBox.VertScrollBar.Position,
	    SRCCOPY);

    { bottom horizontal line }
    BitBlt( FCanvas.Handle,
	    Rect.Left,
	    Rect.Bottom,
	    Rect.Right + FImageScrollBox.HorzScrollBar.Position, //mdm 03/03/2003
	    1,
	    Graphic.DC,
	    Rect.Left + FImageScrollBox.HorzScrollBar.Position,
	    Rect.Bottom + FImageScrollBox.VertScrollBar.Position,
	    SRCCOPY);

    { left vertical line }
    BitBlt( FCanvas.Handle,
	    Rect.Left,
	    Rect.Top,
	    1,
	    Rect.Bottom + FImageScrollBox.VertScrollBar.Position, //mdm 03/03/2003
	    Graphic.DC,
	    Rect.Left + FImageScrollBox.HorzScrollBar.Position,
	    Rect.Top + FImageScrollBox.VertScrollBar.Position,
	    SRCCOPY);

    FBandVisible := False;
end;

{--------------------------------------------------------------------------}

function TRubberbandMouseHandler.MouseOnGrabHandle(
                                            const X, Y       : Integer;
                                            var   GrabHandle : TGrabHandle ) : Boolean;
var
    LocalYOffset  : Integer;
    LocalXOffset  : Integer;
begin
    Result := True;

    LocalXOffset  := FImageScrollBox.HorzScrollBar.Position;
    LocalYOffset  := FImageScrollBox.VertScrollBar.Position;

    { MB Apr 9, 2002. Check corners first }
    if (Abs(X - FX2 + LocalXOffset) < CHandleGrabPixelSize) and
       (Abs(Y - FY2 + LocalYOffset) < CHandleGrabPixelSize) then
        GrabHandle := ghBottomRight
    else if (Abs(X - FX1 + LocalXOffset) < CHandleGrabPixelSize) and
            (Abs(Y - FY1 + LocalYOffset) < CHandleGrabPixelSize) then
        GrabHandle := ghTopLeft
    else if (Abs(X - FX2 + LocalXOffset) < CHandleGrabPixelSize) and
            (Abs(Y - FY1 + LocalYOffset) < CHandleGrabPixelSize) then
        GrabHandle := ghTopRight
    else if (Abs(X - FX1 + LocalXOffset) < CHandleGrabPixelSize) and
            (Abs(Y - FY2 + LocalYOffset) < CHandleGrabPixelSize) then
       GrabHandle := ghBottomLeft
    else if (Abs(Y - FY1 + LocalYOffset) < CHandleGrabPixelSize) and
            ( (X >= (FX1 - LocalXOffset)) and (X <= (FX2 - LocalXOffset)) )  then
        GrabHandle := ghTop
    else if (Abs(Y - FY2 + LocalYOffset) < CHandleGrabPixelSize) and
            ( (X >= (FX1 - LocalXOffset)) and (X <= (FX2 - LocalXOffset)) ) then
        GrabHandle := ghBottom
    else if (Abs(X - FX1 + LocalXOffset) < CHandleGrabPixelSize) and
            ( (Y >= (FY1 - LocalYOffset)) and (Y <= (FY2 - LocalYOffset)) ) then
        GrabHandle := ghLeft
    else if (Abs(X - FX2 + LocalXOffset) < CHandleGrabPixelSize) and
            ( (Y >= (FY1 - LocalYOffset)) and (Y <= (FY2 - LocalYOffset)) ) then
        GrabHandle := ghRight
    else if PtInRect(Rect(FX1- LocalXOffset+CHandleGrabPixelSize,FY1- LocalYOffset-CHandleGrabPixelSize,FX2- LocalXOffset-CHandleGrabPixelSize,FY2- LocalYOffset+CHandleGrabPixelSize),Point(X,Y))then
        GrabHandle     := ghInside
    else
        Result     := False;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.MouseDown(
        				     const Button : TMouseButton;
					     const Shift  : TShiftState;
					     const X, Y   : Integer );
var
    LocalX         : Integer;
    LocalY         : Integer;
    OnHandle       : Boolean;

begin
    { The rubberband mouse handler does not work when the image is centered }
    if FImageScrollBox.Centered then
        Exit;

    LocalX := X + FImageScrollBox.FImage.Left;
    LocalY := Y + FImageScrollBox.FImage.Top;

    OnHandle := FBandVisible and
    		MouseOnGrabHandle( LocalX, LocalY, FGrabHandle );

    if FImageScrollBox.AlwaysShowAnnotations then
        FImageScrollBox.FDisplayEditor.BurnIn(FImageScrollBox.DisplayedGraphic.Canvas);

    FMouseIsDown:= True;
    FMouseX := X;
    FMouseY := Y;
    if OnHandle then
    begin
    	FBandMovement := GrabHandleToBandMovement(FGrabHandle);
    	case FGrabHandle of
      	    ghTopLeft:
	    begin
	    	SwapIntegers(FX1, FX2);
	    	SwapIntegers(FY1, FY2);
	    end;

	    ghTop        : SwapIntegers(FY1, FY2);

	    ghTopRight   : SwapIntegers(FY1, FY2);

	    ghBottomLeft : SwapIntegers(FX1, FX2);
	    ghLeft       : SwapIntegers(FX1, FX2);
        end;
    end
    else
    begin
    	if FBandVisible then
	begin
	    RemoveBand;
	    DoRubberbandChange(0,0,0,0);
        end;

        FBandMovement := bmAllDirections;
        FGrabHandle   := ghBottomRight;

        FX1 := X;
        FY1 := Y;
        FX2 := FX1;
        FY2 := FY1;
    end;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.MouseMove(
                                             const Shift : TShiftState;
                                             const X, Y  : Integer );
var
    LocalX     : Integer;
    LocalY     : Integer;
    DeltaX     : Integer;
    DeltaY     : Integer;
begin
    LocalX    := X + FImageScrollBox.FImage.Left;
    LocalY    := Y + FImageScrollBox.FImage.Top;
    if not FMouseIsDown and FBandVisible then
    begin
        if MouseOnGrabHandle( LocalX, LocalY, FGrabHandle ) then
            FImageScrollBox.FImage.Cursor := GrabHandleToCursor(FGrabHandle)
        else FImageScrollBox.FImage.Cursor := crDefault;
            Exit;
    end;

    if FGrabHandle in [ ghBottomLeft, ghTopRight,ghTopLeft, ghBottomRight ] then
    begin
    	LocalX := LocalX + FImageScrollBox.HorzScrollBar.Position;
    	LocalY := LocalY + FImageScrollBox.VertScrollBar.Position;
    end;

    if FGrabHandle in [ghTop, ghBottom] then
        LocalY := LocalY + FImageScrollBox.VertScrollBar.Position;

    if FGrabHandle in [ghLeft, ghRight] then
        LocalX := LocalX + FImageScrollBox.HorzScrollBar.Position;

    BoundXY(LocalX,LocalY);
    if FMouseIsDown and (ssLeft in Shift) then
    begin
    	if FBandMovement = bmTopBottom then
            LocalX := FX2;

	if FBandMovement = bmLeftRight then
            LocalY := FY2;

        if FBandMovement = bmInside then
        begin
	    RemoveBand;
            DeltaX   := X-FMouseX;
            DeltaY   := Y-FMouseY;
            FMouseX  := X;
            FMouseY  := Y;
            if (FX1 + DeltaX >= 0) and
               (FY1 + DeltaY >= 0) and
               (FX2 + DeltaX < FImageScrollbox.FImage.Picture.Graphic.Width) and
               (FY2 + DeltaY < FImageScrollbox.FImage.Picture.Graphic.Height) then
            begin
            FX1      := FX1+DeltaX;
	    FY1      := FY1+DeltaY;
	    FX2      := FX2+DeltaX;
	    FY2      := FY2+DeltaY;
	    BoundXY( FX1,FY1);
	    BoundXY( FX2,FY2);
            end;
	    DrawBand;
	    DoRubberbandChange(FX1, FY1, FX2, FY2);
            Exit;
        end;

        RemoveBand;
	FX2 := LocalX;
	FY2 := LocalY;
	DrawBand;
	DoRubberbandChange(FX1, FY1, FX2, FY2);
    end;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.DoRubberbandChange(
  				const   X1   : Integer;
      			        const   Y1   : Integer;
				const   X2   : Integer;
				const   Y2   : Integer );
var
    Rect : TRect;
begin
    if Assigned (FImageScrollBox.FOnRubberbandChange) then
    begin
    	Rect.Left   := X1;
    	Rect.Top    := Y1;
    	Rect.Right  := X2;
    	Rect.Bottom := Y2;

    	if Rect.Bottom < Rect.Top then
      	    SwapIntegers(Rect.Bottom, Rect.Top);

	if Rect.Right < Rect.Left then
	    SwapIntegers(Rect.Right, Rect.Left);

	FImageScrollBox.FOnRubberbandChange(Rect);
    end;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.MouseUp(
				  const Button : TMouseButton;
				  const Shift  : TShiftState;
				  const X, Y   : Integer );
begin
    if FMouseIsDown then
    begin
    	if FBandVisible then
    	begin
	    if FX2 < FX1 then
	    	SwapIntegers(FX2, FX1);

	    if FY2 < FY1 then
	    	SwapIntegers(FY2, FY1);
        end;

	if FBandVisible and
	   ((FX1 = FX2) or (FY1 = FY2)) then
	    RemoveBand;

	FMouseIsDown := False;
    end;
end;

{--------------------------------------------------------------------------}

(* MB Feb 18, 2002. Old code based on DisplayedGraphic
procedure TRubberbandMouseHandler.CopySelectionToClipBoard;
var
    Rect             : TRect;
    Graphic          : TDibGraphic;
    CropTransform    : TCropTransform;
    DisplayedGraphic : TDibGraphic;
begin
    if not SelectionActive then
        raise ERubberbandError.Create(msgRegionNotSelected);

    DisplayedGraphic := TDibGraphic(FImageScrollBox.FImage.Picture.Graphic);

    Rect.Top    := FY1;
    Rect.Bottom := FY2;
    Rect.Left   := FX1;
    Rect.Right  := FX2;

    AdjustRect(Rect);

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

            Clipboard.Assign(Graphic);
        finally
            CropTransform.Free;
            Graphic.Free;
        end;
    end;
end;
*)

procedure TRubberbandMouseHandler.CopySelectionToClipBoard;
var
     Rect             : TRect;
     Graphic          : TDibGraphic;
     CropTransform    : TCropTransform;
     DisplayedGraphic : TDibGraphic;
     SourceWidth      : Integer;
     SourceHeight     : Integer;
begin
     if not SelectionActive then
         raise ERubberbandError.Create(msgRegionNotSelected);

     DisplayedGraphic := TDibGraphic(FImageScrollBox.FImage.Picture.Graphic);

     SourceWidth    := FImageScrollBox.FSourceGraphic.Width;
     SourceHeight   := FImageScrollBox.FSourceGraphic.Height;

     Rect.Top       := FY1 * SourceHeight div DisplayedGraphic.Height;
     Rect.Bottom    := FY2 * SourceHeight div DisplayedGraphic.Height;
     Rect.Left      := FX1 * SourceWidth div DisplayedGraphic.Width;
     Rect.Right     := FX2 * SourceWidth div DisplayedGraphic.Width;

     AdjustRect(Rect);

     if ((Rect.Right - Rect.Left) >= 1) and
        ((Rect.Bottom - Rect.Top) >= 1) then
     begin
         Graphic       := TDibGraphic.Create;
         CropTransform := TCropTransform.Create;
         try
             CropTransform.Top    := Rect.Top;
             CropTransform.Left   := Rect.Left;
             CropTransform.Bottom := SourceHeight - Rect.Bottom;
             CropTransform.Right  := SourceWidth  - Rect.Right;

             CropTransform.ApplyOnDest( FImageScrollBox.FSourceGraphic, Graphic);

             Clipboard.Assign(Graphic);

         finally
             CropTransform.Free;
             Graphic.Free;
         end;
     end;
end;

{--------------------------------------------------------------------------}

(* Nov 13, 2001 Old version uses zoomed image
procedure TRubberbandMouseHandler.CropToSelection;
var
    Rect             : TRect;
    Graphic          : TDibGraphic;
    CropTransform    : TCropTransform;
    DisplayedGraphic : TDibGraphic;
begin
    if not SelectionActive then
        raise ERubberbandError.Create(msgRegionNotSelected);

    DisplayedGraphic := TDibGraphic(FImageScrollBox.FImage.Picture.Graphic);

    Rect.Top    := FY1;
    Rect.Bottom := FY2;
    Rect.Left   := FX1;
    Rect.Right  := FX2;

    AdjustRect(Rect);

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
            FImageScrollBox.Graphic.Assign(Graphic);
            FImageScrollBox.Redraw ( True );
        finally
            CropTransform.Free;
            Graphic.Free;
        end;
    end;
end;
*)

{--------------------------------------------------------------------------}

{ Nov 13, 2001. New version, using the source graphic. Thanks to Jan Seyfarth }
procedure TRubberbandMouseHandler.CropToSelection;
var
     Rect             : TRect;
     Graphic          : TDibGraphic;
begin
     if not SelectionActive then
         raise ERubberbandError.Create(msgRegionNotSelected);

     GetSourceSelection(Rect);

     if ((Rect.Right - Rect.Left) >= 1) and
        ((Rect.Bottom - Rect.Top) >= 1) then
     begin
         Graphic       := TDibGraphic.Create;
         try
           ExtractSelection(Graphic);
           FImageScrollBox.Graphic.Assign(Graphic);
           FImageScrollBox.Redraw ( True );
         finally
           Graphic.Free;
         end;
     end;
end;

{--------------------------------------------------------------------------}

{ Added 03/01/2003 - MDM }
procedure TRubberbandMouseHandler.ExtractSelection(Dest: TDibGraphic);
var
     Rect             : TRect;
     CropTransform    : TCropTransform;
begin
     if (Dest = nil) then
         raise ERubberbandError.Create('Graphic not assigned!');

     if not SelectionActive then
         raise ERubberbandError.Create(msgRegionNotSelected);

     GetSourceSelection(Rect);

     if ((Rect.Right - Rect.Left) >= 1) and
        ((Rect.Bottom - Rect.Top) >= 1) then
     begin
         CropTransform := TCropTransform.Create;
         try
             CropTransform.CropMode := cmExtractRect;
             CropTransform.Top      := Rect.Top;
             CropTransform.Left     := Rect.Left;
             CropTransform.Bottom   := Rect.Bottom;
             CropTransform.Right    := Rect.Right;

             CropTransform.ApplyOnDest(FImageScrollBox.FSourceGraphic, Dest);

         finally
             CropTransform.Free;

         end;
     end;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.GetSelection( var Rect : TRect );
begin
    if not FBandVisible then
        raise ERubberbandError.Create(msgRegionNotSelected);

    Rect.Top    := FY1;
    Rect.Bottom := FY2;
    Rect.Left   := FX1;
    Rect.Right  := FX2;

    AdjustRect(Rect);
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.GetSourceSelection( var Rect: TRect );
var
    XFactor, YFactor: double;
begin
    GetSelection(Rect);

    XFactor := GetXFactor;
    YFactor := GetYFactor;

    Rect.Left   := Round(Rect.Left * XFactor);
    Rect.Right  := Round(Rect.Right * XFactor);
    Rect.Top    := Round(Rect.Top * YFactor);
    Rect.Bottom := Round(Rect.Bottom * YFactor);
end;

{--------------------------------------------------------------------------}

function TRubberbandMouseHandler.GetXFactor: Double;
var
    Graphic, DisplayedGraphic: TDibGraphic;
begin
    Graphic := FImageScrollBox.Graphic;
    DisplayedGraphic := TDibGraphic(FImageScrollBox.FImage.Picture.Graphic);

    Result := Graphic.Width / (DisplayedGraphic.Width);
end;

{--------------------------------------------------------------------------}

function TRubberbandMouseHandler.GetYFactor: Double;
var
    Graphic, DisplayedGraphic: TDibGraphic;
begin
    Graphic := FImageScrollBox.Graphic;
    DisplayedGraphic := TDibGraphic(FImageScrollBox.FImage.Picture.Graphic);

    Result := Graphic.Height / (DisplayedGraphic.Height);
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.ClearSelection;
begin
    if FBandVisible then
    begin
    	RemoveBand;
    	DoRubberbandChange(0,0,0,0);
    end;
end;                  

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.BeforeResize;
var
    DisplayedGraphic: TDibGraphic;
begin
    if FBandVisible then
    begin
    	RemoveBand;

        if not FImageScrollBox.Centered then
        begin
            DisplayedGraphic := TDibGraphic(FImageScrollBox.FImage.Picture.Graphic);
            FSaveSize := Point(DisplayedGraphic.Width, DisplayedGraphic.Height);

            { Required for AfterResize; anyway it really is visible, just temporarily
              hidden during resize. }
            FBandVisible := True;
        end;
    end;
end;

{--------------------------------------------------------------------------}

procedure TRubberbandMouseHandler.AfterResize;
var
    XFactor, YFactor : Double;
    DisplayedGraphic : TDibGraphic;
begin
    if FBandVisible then
    begin
        { Create resized band based on new image size }
    	DisplayedGraphic := TDibGraphic(FImageScrollBox.FImage.Picture.Graphic);

    	XFactor := (DisplayedGraphic.Width) / (FSaveSize.X);
    	YFactor := (DisplayedGraphic.Height) / (FSaveSize.Y);

    	FX1 := SafeTrunc(FX1 * XFactor);
    	FY1 := SafeTrunc(FY1 * YFactor);
    	FX2 := SafeTrunc(FX2 * XFactor);
    	FY2 := SafeTrunc(FY2 * YFactor);

        DrawBand;

	DoRubberbandChange(FX1, FY1, FX2, FY2);
    end;
end;

{--------------------------------------------------------------------------}

end.
