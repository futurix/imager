{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnCtlRsz
|
| Description: Helper component to allow moving/resizing graphic controls
|
| History: Nov 29, 2002 Originally written by Francesco Pucino, http://web.tiscalinet.it/delphipage
|
|---------------------------------------------------------------------------}
unit EnCtlRsz;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls;

type

TControlResizerEvent = procedure( Sender: TObject; OldBounds, NewBounds: TRect) of object;

TControlResizer = class( TGraphicControl)
private
    { Private declarations }
    FLineDC: HDC;
    FNewLeft, FNewTop, FNewWidth, FNewHeight: Integer;
    FMinWidth,
        FMinHeight: Integer;
    FMoving: Boolean;
    FSizing: Boolean;
    FTargetControl: TControl;
    FHookNW, FHookSW,
        FHookSE, FHookNE,
        FHookN, FHookW,
        FHookS, FHookE: TShape;
    FMaxPos,
        FMinPos,
        FDelta,
        FClick: TPoint;
    FBoxSize,
        FLineSize: Integer;
    FCtrl3D,
        FMovable, FResizable: Boolean;
    FControlChanging: Boolean;
    FOnResizing,
        FOnResized,
        FOnMoving,
        FOnMoved: TControlResizerEvent;
    FBoxColor: TColor;
    FHandlesCreated: Boolean;
    FOldBounds: TRect;
    procedure SetBoxSize( Value: Integer);
    procedure SetTargetControl( Value: TControl);
    procedure SetBoxColor( Value: TColor);
    procedure CreateHandles;
protected
    { Protected declarations }
    procedure SetParent( AParent: TWinControl); override;
    procedure SetHandlesParent( AParent: TWinControl);
    procedure ManageMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ManageMouseMove( Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ManageMouseUp( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ManageMovingMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ManageMovingMouseMove( Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ManageMovingMouseUp( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure WMEraseBack( var Message: TMessage); message WM_ERASEBKGND;
    procedure RealignHandles;
    procedure UpdateTargetControl;
    procedure UpdatePosFromTargetControl;
    procedure AllocateLineDC;
    procedure DrawLine;
    procedure ReleaseLineDC;
    procedure Resized; virtual;
    procedure Moved; virtual;
public
    { Public declarations }
    constructor Create( AOwner: TComponent); override;
    procedure SetBounds( ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure HideHandles;
    procedure ShowHandles;
    procedure CMVisibleChanged( var Message: TMessage); message CM_VISIBLECHANGED;
published
    { Published declarations }
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property PopupMenu;
    property Width default 25;
    property Height default 25;
    property MinWidth: Integer read FMinWidth write FMinWidth;
    property MinHeight: Integer read FMinHeight write FMinHeight;
    property BoxSize: Integer read FBoxSize write SetBoxSize;
    property BoxColor: TColor read FBoxColor write SetBoxColor;
    property LineSize: Integer read FLineSize write FLineSize;
    property Resizable: Boolean read FResizable write FResizable;
    property Movable: Boolean read FMovable write FMovable;
    property TargetControl: TControl read FTargetControl write SetTargetControl;
    property OnResizing: TControlResizerEvent read FOnResizing write FOnResizing;
    property OnResized: TControlResizerEvent read FOnResized write FOnResized;
    property OnMoving: TControlResizerEvent read FOnMoving write FOnMoving;
    property OnMoved: TControlResizerEvent read FOnMoved write FOnMoved;
end;

const

CDefaultResizerBoxSize = 5;

implementation


constructor TControlResizer.Create( AOwner: TComponent);
begin
    inherited Create( AOwner);
    ControlStyle := ControlStyle - [csOpaque];
    FCtrl3D := False;
    FLineSize := 2;
    Width := 25;
    Height := 25;
    FTargetControl := nil;
    FSizing := False;
    FMoving := False;
    FControlChanging := False;
    FMinWidth := 8;
    FMinHeight := 8;
    FMovable := True;
    FResizable := True;
    Cursor := crSize;
    FHookNW := nil;
    FHookSW := nil;
    FHookNE := nil;
    FHookSE := nil;
    FHookN := nil;
    FHookS := nil;
    FHookE := nil;
    FHookW := nil;
    // Consente di muovere il controllo
    OnMouseDown := ManageMovingMouseDown;
    OnMouseMove := ManageMovingMouseMove;
    OnMouseUp := ManageMovingMouseUp;
    // Aggiorna la visualizzazione del controllo
    FBoxColor := clBlack;
    FBoxSize := CDefaultResizerBoxSize;
    FHandlesCreated := False;
end;

procedure TControlResizer.CMVisibleChanged( var Message: TMessage);
begin
    if Visible then
        ShowHandles
    else
        HideHandles;
end;

procedure TControlResizer.CreateHandles;
begin
    if FHandlesCreated then
        Exit;
    // Crea il quadrato Nord Ovest
    FHookNW := TShape.Create( Self);
    FHookNW.Cursor := crSizeNWSE;
    FHookNW.Visible := False;
    FHookNW.OnMouseDown := ManageMouseDown;
    FHookNW.OnMouseMove := ManageMouseMove;
    FHookNW.OnMouseUp := ManageMouseUp;
    // Crea il quadrato Sud Ovest
    FHookSW := TShape.Create( Self);
    FHookSW.Cursor := crSizeNESW;
    FHookSW.Visible := False;
    FHookSW.OnMouseDown := ManageMouseDown;
    FHookSW.OnMouseMove := ManageMouseMove;
    FHookSW.OnMouseUp := ManageMouseUp;
    // Crea il quadrato Sud Est
    FHookSE := TShape.Create( Self);
    FHookSE.Cursor := crSizeNWSE;
    FHookSE.Visible := False;
    FHookSE.OnMouseDown := ManageMouseDown;
    FHookSE.OnMouseMove := ManageMouseMove;
    FHookSE.OnMouseUp := ManageMouseUp;
    // Crea il quadrato Nord Est
    FHookNE := TShape.Create( Self);
    FHookNE.Cursor := crSizeNESW;
    FHookNE.Visible := False;
    FHookNE.OnMouseDown := ManageMouseDown;
    FHookNE.OnMouseMove := ManageMouseMove;
    FHookNE.OnMouseUp := ManageMouseUp;
    // Crea il quadrato Nord
    FHookN := TShape.Create( Self);
    FHookN.Cursor := crSizeNS;
    FHookN.Visible := False;
    //FHookN.Shape:=stCircle;
    FHookN.OnMouseDown := ManageMouseDown;
    FHookN.OnMouseMove := ManageMouseMove;
    FHookN.OnMouseUp := ManageMouseUp;
    // Crea il quadrato Ovest
    FHookW := TShape.Create( Self);
    FHookW.Cursor := crSizeWE;
    FHookW.Visible := False;
    //FHookW.Shape:=stCircle;
    FHookW.OnMouseDown := ManageMouseDown;
    FHookW.OnMouseMove := ManageMouseMove;
    FHookW.OnMouseUp := ManageMouseUp;
    // Crea il quadrato Sud
    FHookS := TShape.Create( Self);
    FHookS.Cursor := crSizeNS;
    FHookS.Visible := False;
    //FHookS.Shape:=stCircle;
    FHookS.OnMouseDown := ManageMouseDown;
    FHookS.OnMouseMove := ManageMouseMove;
    FHookS.OnMouseUp := ManageMouseUp;
    // Crea il quadrato Est
    FHookE := TShape.Create( Self);
    FHookE.Cursor := crSizeWE;
    FHookE.Visible := False;
    //FHookE.Shape:=stCircle;
    FHookE.OnMouseDown := ManageMouseDown;
    FHookE.OnMouseMove := ManageMouseMove;
    FHookE.OnMouseUp := ManageMouseUp;
    FHandlesCreated := True;
end;

procedure TControlResizer.ManageMovingMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    // Se è in fase di cambiamento, non gestisce la procedura
    if FControlChanging then
        Exit;
    // Controlla che ia stato premuto il pulsante sinistro del mouse
    if ( mbLeft = Button) and ( FMovable) and ( not FMoving) then
    begin
        // Imposta la cattura del mouse
        SetCaptureControl( TControl( Sender));
        // Memorizza la differenza del clik dall' angolo superiore sinistro
        FClick.X := -X;
        FClick.Y := -Y;
        // Abilita lo spostamento
        FMoving := True;
        HideHandles;
        // Memorizza le coordinate iniziali
        FNewWidth := Width;
        FNewHeight := Height;
        FNewLeft := Left;
        FNewTop := Top;
        // Recupera il DC
        AllocateLineDC;
        // Disegna la linea
        DrawLine;
    end;
end;

procedure TControlResizer.ManageMovingMouseMove( Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
    // Se è in fase di cambiamento, non gestisce la procedura
    if FControlChanging then
        Exit;
    if FMoving then
    begin
        // Nasconde la linea
        DrawLine;
        // Calcola l' entità dello spostamento
        FDelta.X := X + FClick.X;
        FDelta.Y := Y + FClick.Y;
        // Calcola la nuova posizione
        FNewLeft := Left + FDelta.X;
        FNewTop := Top + FDelta.Y;
        FNewWidth := Width;
        FNewHeight := Height;
        // Disegna la linea
        DrawLine;
    end;
end;

procedure TControlResizer.Moved;
begin
    // Richiama il metodo per notificare il movimento avvenuto
    if Assigned( FOnMoved) then
        FOnMoved( Self, FOldBounds, BoundsRect);
end;

procedure TControlResizer.ManageMovingMouseUp( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    // Se è in fase di cambiamento, non gestisce la procedura
    if FControlChanging then
        Exit;
    // Verifica se è stato rilasciato il pulsante sinistro del mouse
    if ( mbLeft = Button) and ( FMoving) then
    begin
        // Imposta la cattura del mouse
        SetCaptureControl( nil);
        // Nascxonde la linea
        DrawLine;
        // Rilascia il DC;
        ReleaseLineDC;
        // disabilita il ridimensionamento
        FMoving := False;
        // Controlla se è stato spostato effettivamente
        if ( FNewLeft <> Left) or ( FNewTop <> Top) then
        begin
            // Sposta il controllo
            FOldBounds := BoundsRect;
            SetBounds( FNewLeft, FNewTop, FNewWidth, FNewHeight);
            // Aggiorna dimensioni e posizione del controllo associato
            UpdateTargetControl;
            // Richiama il metodo per notificare il movimento avvenuto
            Moved;
        end;
        ShowHandles;
    end;
end;

procedure TControlResizer.ManageMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    // Se è in fase di cambiamento, non gestisce la procedura
    if FControlChanging then
        Exit;
    // Controlla che ia stato premuto il pulsante sinistro del mouse
    if ( mbLeft = Button) and ( FResizable) then
    begin
        // Imposta la cattura del mouse
        SetCaptureControl( TControl( Sender));
        // Nasconde i box
        HideHandles;
        // Memorizza la differenza del clik dall' angolo superiore sinistro
        FClick.X := -X;
        FClick.Y := -Y;
        // Controlla se è la maniglia NW
        if Sender = FHookNW then
        begin
            // Calcola la posizione minima e massima della x e della y
            FMinPos.X := -MaxInt;
            FMinPos.Y := -MaxInt;
            FMaxPos.X := Width;
            FMaxPos.Y := Height;
        end;
        // Controlla se è la maniglia SW
        if Sender = FHookSW then
        begin
            // Calcola la posizione minima e massima della x e della y
            FMinPos.X := -MaxInt;
            FMinPos.Y := -Height;
            FMaxPos.X := Width;
            FMaxPos.Y := MaxInt;
        end;
        // Controlla se è la maniglia SE
        if Sender = FHookSE then
        begin
            // Calcola la posizione minima e massima della x e della y
            FMinPos.X := -Width;
            FMinPos.Y := -Height;
            FMaxPos.X := MaxInt;
            FMaxPos.Y := MaxInt;
        end;
        // Controlla se è la maniglia NE
        if Sender = FHookNE then
        begin
            // Calcola la posizione minima e massima della x e della y
            FMinPos.X := -Width;
            FMinPos.Y := -MaxInt;
            FMaxPos.X := MaxInt;
            FMaxPos.Y := Height;
        end;
        // Controlla se è la maniglia N
        if Sender = FHookN then
        begin
            // Calcola la posizione minima e massima della x e della y
            FMinPos.X := 0;
            FMinPos.Y := -MaxInt;
            FMaxPos.X := 0;
            FMaxPos.Y := Height;
        end;
        // Controlla se è la maniglia W
        if Sender = FHookW then
        begin
            // Calcola la posizione minima e massima della x e della y
            FMinPos.X := -MaxInt;
            FMinPos.Y := 0;
            FMaxPos.X := Width;
            FMaxPos.Y := 0;
        end;
        // Controlla se è la maniglia S
        if Sender = FHookS then
        begin
            // Calcola la posizione minima e massima della x e della y
            FMinPos.X := 0;
            FMinPos.Y := -Height;
            FMaxPos.X := 0;
            FMaxPos.Y := MaxInt;
        end;
        // Controlla se è la maniglia E
        if Sender = FHookE then
        begin
            // Calcola la posizione minima e massima della x e della y
            FMinPos.X := -Width;
            FMinPos.Y := 0;
            FMaxPos.X := MaxInt;
            FMaxPos.Y := 0;
        end;
        // Visualizza il pulsante abbassato
        if FCtrl3D then
            TPanel( Sender).BevelOuter := bvLowered;
        // Memorizza le coordinate iniziali
        FNewWidth := Width;
        FNewHeight := Height;
        FNewLeft := Left;
        FNewTop := Top;
        // Recupera il DC
        AllocateLineDC;
        // Disegna la linea
        DrawLine;
        // Abilita il ridimensionamento
        FSizing := True;
    end;
end;

procedure TControlResizer.ManageMouseMove( Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
    // Se è in fase di cambiamento, non gestisce la procedura
    if FControlChanging then
        Exit;
    if FSizing then
    begin
        // Cancella la vecchia linea
        DrawLine;
        // Verifica se X ed Y sono all' interno del range consentito
        if X > FMaxPos.X then
            X := FMaxPos.X;
        if X < FMinPos.X then
            X := FMinPos.X;
        if Y > FMaxPos.Y then
            Y := FMaxPos.Y;
        if Y < FMinPos.Y then
            Y := FMinPos.Y;
        // Calcola l' entità dello spostamento
        FDelta.X := X + FClick.X;
        FDelta.Y := Y + FClick.Y;
        FNewWidth := Width;
        FNewHeight := Height;
        FNewLeft := Left;
        FNewTop := Top;
        // Conrolla se è stato spostaa la maniglia NW
        if Sender = FHookNW then
        begin
            // Calcola la nuova posizione
            FNewLeft := Left + FDelta.X;
            FNewTop := Top + FDelta.Y;
            FNewWidth := Width - FDelta.X;
            FNewHeight := Height - FDelta.Y;
        end;
        // Controlla se è stato spostato il SW
        if Sender = FHookSW then
        begin
            // Calcola la nuova posizione
            FNewLeft := Left + FDelta.X;
            FNewWidth := Width - FDelta.X;
            FNewHeight := Height + FDelta.Y;
        end;
        // Controlla se è stato spostato il SE
        if Sender = FHookSE then
        begin
            // Calcola la nuova posizione
            FNewWidth := Width + FDelta.X;
            FNewHeight := Height + FDelta.Y;
        end;
        // Controlla se è stato spostato il SE
        if Sender = FHookNE then
        begin
            // Calcola la nuova posizione
            FNewTop := Top + FDelta.Y;
            FNewWidth := Width + FDelta.X;
            FNewHeight := Height - FDelta.Y;
        end;
        // Conrolla se è stato spostata la maniglia N
        if Sender = FHookN then
        begin
            // Calcola la nuova posizione
            FNewTop := Top + FDelta.Y;
            FNewHeight := Height - FDelta.Y;
        end;
        // Controlla se è stato spostato il W
        if Sender = FHookW then
        begin
            // Calcola la nuova posizione
            FNewLeft := Left + FDelta.X;
            FNewWidth := Width - FDelta.X;
        end;
        // Controlla se è stato spostato il S
        if Sender = FHookS then
        begin
            // Calcola la nuova posizione
            FNewHeight := Height + FDelta.Y;
        end;
        // Controlla se è stato spostato il E
        if Sender = FHookE then
        begin
            // Calcola la nuova posizione
            FNewWidth := Width + FDelta.X;
        end;
        // Controlla se le dimensioni sono nei limiti
        if FNewWidth < MinWidth then
            FNewWidth := MinWidth;
        if FNewHeight < MinHeight then
            FNewHeight := MinHeight;
        // Disegna la nuova linea
        DrawLine;
    end;
end;

procedure TControlResizer.Resized;
begin
    // Richiama il metodo per notificare il ridimensionamento avvenuto
    if Assigned( FOnResized) then
        FOnResized( Self, FOldBounds, BoundsRect); //Rect(FNewLeft+FBoxSize,FNewTop+FBoxSize,FNewWidth-(FBoxSize*2),FNewHeight-(FBoxSize*2)));
end;

procedure TControlResizer.ManageMouseUp( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    // Se è in fase di cambiamento, non gestisce la procedura
    if FControlChanging then
        Exit;
    // Verifica se è stato rilasciato il pulsante sinistro del mouse
    if ( mbLeft = Button) then
    begin
        // Imposta la cattura del mouse
        SetCaptureControl( nil);
        // Elimina la vecchia linea
        DrawLine;
        // Rilascia il DC
        ReleaseLineDC;
        // disabilita il ridimensionamento
        FSizing := False;
        // Visualizza l' effetto di rialzo del pulsante
        if FCtrl3D then
            TPanel( Sender).BevelOuter := bvRaised;
        // Verifica se X ed Y sono all' interno del range consentito
        if X > FMaxPos.X then
            X := FMaxPos.X;
        if X < FMinPos.X then
            X := FMinPos.X;
        if Y > FMaxPos.Y then
            Y := FMaxPos.Y;
        if Y < FMinPos.Y then
            Y := FMinPos.Y;
        // Calcola l' entità dello spostamento
        FDelta.X := X + FClick.X;
        FDelta.Y := Y + FClick.Y;
        FOldBounds := BoundsRect;
        // Conrolla se è stato spostaa la maniglia NW
        if Sender = FHookNW then
            // Calcola la nuova posizione
            SetBounds( Left + FDelta.X, Top + FDelta.Y, Width - FDelta.X, Height - FDelta.Y);
        // Controlla se è stato spostato il SW
        if Sender = FHookSW then
            // Calcola la nuova posizione
            SetBounds( Left + FDelta.X, Top, Width - FDelta.X, Height + FDelta.Y);
        // Controlla se è stato spostato il SE
        if Sender = FHookSE then
            // Calcola la nuova posizione
            SetBounds( Left, Top, Width + FDelta.X, Height + FDelta.Y);
        // Controlla se è stato spostato il SE
        if Sender = FHookNE then
            // Calcola la nuova posizione
            SetBounds( Left, Top + FDelta.Y, Width + FDelta.X, Height - FDelta.Y);
        // Conrolla se è stato spostaa la maniglia N
        if Sender = FHookN then
            // Calcola la nuova posizione
            SetBounds( Left, Top + FDelta.Y, Width, Height - FDelta.Y);
        // Controlla se è stato spostato il W
        if Sender = FHookW then
            // Calcola la nuova posizione
            SetBounds( Left + FDelta.X, Top, Width - FDelta.X, Height);
        // Controlla se è stato spostato il S
        if Sender = FHookS then
            // Calcola la nuova posizione
            SetBounds( Left, Top, Width, Height + FDelta.Y);
        // Controlla se è stato spostato il E
        if Sender = FHookE then
            // Calcola la nuova posizione
            SetBounds( Left, Top, Width + FDelta.X, Height);
        // Visualizza i box
        ShowHandles;
        // Aggiorna dimensioni e posizione del controllo associato
        UpdateTargetControl;
        // Richiama il metodo per notificare il ridimensionamento avvenuto
        Resized;
    end;
end;

procedure TControlResizer.UpdatePosFromTargetControl;
begin
    // Controlla se il controllo è stato assiciato
    if Assigned( FTargetControl) then
        SetBounds( FTargetControl.Left - FBoxSize, FTargetControl.Top - FBoxSize, FTargetControl.Width + ( FBoxSize * 2), FTargetControl.Height + ( FBoxSize * 2));
end;

procedure TControlResizer.UpdateTargetControl;
begin
    // Esce se in fase di aggiornamento
    if FControlChanging then
        Exit;
    // Esce se è invisibile
    if not Visible then
        Exit;
    // Controlla se deve ridimensionare un controllo associato
    if Assigned( FTargetControl) then
    begin
        // Ridimensiona il controllo
        if ( ( Width - ( FBoxSize * 2)) > 0) and ( Height - ( FBoxSize * 2) > 0) then
        begin
            FTargetControl.SetBounds( Left + FBoxSize, Top + FBoxSize, Width - ( FBoxSize * 2), Height - ( FBoxSize * 2));
        end;
    end;
end;

procedure TControlResizer.HideHandles;
begin
    if not Assigned( FHookNW) then
        Exit;
    // Nasconde il controllo
    FHookNW.Visible := False;
    FHookSW.Visible := False;
    FHookSE.Visible := False;
    FHookNE.Visible := False;
    FHookN.Visible := False;
    FHookW.Visible := False;
    FHookS.Visible := False;
    FHookE.Visible := False;
    // Ridisegna il parente
    if Assigned( Parent) then
        Parent.Update;
end;

procedure TControlResizer.ShowHandles;
begin
    if not FHandlesCreated then
    begin
        CreateHandles;
        SetHandlesParent( Parent);
        RealignHandles;
    end;
    // Visualizza il controllo
    FHookNW.Visible := True;
    FHookSW.Visible := True;
    FHookSE.Visible := True;
    FHookNE.Visible := True;
    FHookN.Visible := True;
    FHookW.Visible := True;
    FHookS.Visible := True;
    FHookE.Visible := True;
end;

procedure TControlResizer.RealignHandles;
var
    Delta: Integer;
begin
    if not FHandlesCreated then
        Exit;
    Delta := FBoxSize div 2;
    // Posiziona il gancio a Nord Ovest
    if Assigned( FHookNW) then
        FHookNW.SetBounds( Left + 0 - Delta, Top + 0 - Delta, FBoxSize, FBoxSize);
    // Posiziona il gancio a Sud Ovest
    if Assigned( FHookSW) then
        FHookSW.SetBounds( Left + 0 - Delta, Top + ( Height - FHookSW.Height) + Delta, FBoxSize, FBoxSize);
    // Posiziona il gancio a Sud Est
    if Assigned( FHookSE) then
        FHookSE.SetBounds( Left + Width - FHookSE.Width + Delta, Top + Height - FHookSE.Height + Delta, FBoxSize, FBoxSize);
    // Posiziona il gancio a Nord Est
    if Assigned( FHookNE) then
        FHookNE.SetBounds( Left + Width - FHookNE.Width + Delta, Top + 0 - Delta, FBoxSize, FBoxSize);
    // Posiziona il gancio a Nord
    if Assigned( FHookN) then
        FHookN.SetBounds( Left + ( Width - FHookN.Width) div 2, Top + 0 - Delta, FBoxSize, FBoxSize);
    // Posiziona il gancio a Ovest
    if Assigned( FHookW) then
        FHookW.SetBounds( Left + 0 - Delta, Top + ( Height - FHookW.Height) div 2, FBoxSize, FBoxSize);
    // Posiziona il gancio a Sud
    if Assigned( FHookS) then
        FHookS.SetBounds( Left + ( Width - FHookS.Width) div 2, Top + ( Height - FHookS.Height) + Delta, FBoxSize, FBoxSize);
    // Posiziona il gancio a Est
    if Assigned( FHookE) then
        FHookE.SetBounds( Left + Width - FHookE.Width + Delta, Top + ( Height - FHookE.Height) div 2, FBoxSize, FBoxSize);
end;

procedure TControlResizer.SetBoxSize( Value: Integer);
begin
    FBoxSize := Value;
    RealignHandles;
end;

procedure TControlResizer.SetBoxColor( Value: TColor);
begin
    FBoxColor := Value;
    if not FHandlesCreated then
        Exit;
    if Assigned( FHookNW) then
        FHookNW.Brush.Color := FBoxColor;
    if Assigned( FHookSW) then
        FHookSW.Brush.Color := FBoxColor;
    if Assigned( FHookSE) then
        FHookSE.Brush.Color := FBoxColor;
    if Assigned( FHookNE) then
        FHookNE.Brush.Color := FBoxColor;
    if Assigned( FHookN) then
        FHookN.Brush.Color := FBoxColor;
    if Assigned( FHookW) then
        FHookW.Brush.Color := FBoxColor;
    if Assigned( FHookS) then
        FHookS.Brush.Color := FBoxColor;
    if Assigned( FHookE) then
        FHookE.Brush.Color := FBoxColor;
end;

procedure TControlResizer.SetHandlesParent( AParent: TWinControl);
begin
    if not FHandlesCreated then
        Exit;
    if Assigned( FHookNW) then
        FHookNW.Parent := AParent;
    if Assigned( FHookSW) then
        FHookSW.Parent := AParent;
    if Assigned( FHookSE) then
        FHookSE.Parent := AParent;
    if Assigned( FHookNE) then
        FHookNE.Parent := AParent;
    if Assigned( FHookN) then
        FHookN.Parent := AParent;
    if Assigned( FHookW) then
        FHookW.Parent := AParent;
    if Assigned( FHookS) then
        FHookS.Parent := AParent;
    if Assigned( FHookE) then
        FHookE.Parent := AParent;
    RealignHandles;
end;

procedure TControlResizer.SetParent( AParent: TWinControl);
begin
    inherited SetParent( AParent);
    SetHandlesParent( AParent);
end;

procedure TControlResizer.SetBounds( ALeft, ATop, AWidth, AHeight: Integer);
begin
    inherited SetBounds( ALeft, ATop, AWidth, AHeight);
    RealignHandles;
end;

procedure TControlResizer.SetTargetControl( Value: TControl);
begin
    // Se si cerca di reimpostare lo stesso controllo, esce
    if Value = FTargetControl then
        Exit;
    // Controlla se viene richiamata mentre è già in progresso
    if FControlChanging then
        Exit;
    // Imposta il flag per evitare il riposizionamento
    FControlChanging := True;
    try
        HideHandles;
        // Controlla se è stato passato un valore valido
        if Assigned( Value) then
        begin
            // Imposta lo stesso parente del controllo da usare
            Parent := Value.Parent;
            FTargetControl := Value;
            // Processa il tutto
            Application.ProcessMessages;
            // Imposta le sue nuove dimensioni
            UpdatePosFromTargetControl;
            Application.ProcessMessages;
            // Si posiziona sopra a tutti
            SetZOrder( True);
            // Processa il tutto
            Application.ProcessMessages;
            ShowHandles;
        end
        else
        begin
            Parent := nil;
            FTargetControl := nil;
            // Processa il tutto
            Application.ProcessMessages;
        end;
    finally
        FControlChanging := False;
    end;
end;

procedure TControlResizer.WMEraseBack( var Message: TMessage);
begin
    // Non cancella il background
    Message.Result := 1;
end;

procedure TControlResizer.AllocateLineDC;
begin
    FLineDC := GetDCEx( Parent.Handle, 0, DCX_CACHE or DCX_CLIPSIBLINGS or DCX_LOCKWINDOWUPDATE);
end;

procedure TControlResizer.DrawLine;
var
    Spessore: Integer;
begin
    for Spessore := 0 to FLineSize - 1 do
        DrawFocusRect( FLineDC, Rect( FNewLeft + Spessore, FNewTop + Spessore, FNewLeft + FNewWidth - Spessore, FNewTop + FNewHeight - Spessore));
    // Richiama il metodo per notificare il movimento
    if ( FMoving) and Assigned( FOnMoving) then
        FOnMoving( Self, BoundsRect, Rect( FNewLeft + FBoxSize, FNewTop + FBoxSize, FNewWidth - ( FBoxSize * 2), FNewHeight - ( FBoxSize * 2)));
    // Richiama il metodo per notificare il ridimensionamento
    if ( FSizing) and Assigned( FOnResizing) then
        FOnResizing( Self, BoundsRect, Rect( FNewLeft + FBoxSize, FNewTop + FBoxSize, FNewWidth - ( FBoxSize * 2), FNewHeight - ( FBoxSize * 2)));
end;

procedure TControlResizer.ReleaseLineDC;
begin
    ReleaseDC( Parent.Handle, FLineDC);
end;

end.


