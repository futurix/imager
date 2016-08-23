{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnAnnota
|
| Description: Annotation mouse handler.
|
| History: May 25, 2002. Michel Brazeau, start mouse handler
|
|---------------------------------------------------------------------------}
unit EnAnnota;

{$I Envision.Inc}

interface

uses
    EnAnEdit, { for TAnnotationsEditor }
    Menus,    { for TPopupMenu }
    Windows,  { for TPoint, TRect }
    SysUtils, { for Exception }
    Classes,  { for TShiftState }
    Controls, { for TMouseButton }
    Graphics, { for TColor }
    EnDiGrph, { for TDibGraphic }
    EnImgScr; { for TImageScrollBox, TMouseHandler }

type

TProtectedScrollBox = class(TImageScrollBox);

TAnnotationMouseHandler = class(TMouseHandler)
protected

    FImageScrollBox         : TProtectedScrollBox;

    FEditor                 : TAnnotationsEditor;
    FMenu                   : TPopupMenu;

    LastAnnotationSelected  : TGenericMark;

    OldNewGraphic           : TNewGraphicEvent;

    procedure BeforeResize; override;
    procedure AfterResize; override;

    procedure PropertiesDialog( Sender : TObject ); virtual;
    procedure DeleteAnnotation( Sender : TObject ); virtual;
    procedure AnnotationClick( Sender:TObject ); virtual;

    procedure ImageScrollBoxNewGraphic( const Graphic : TDibGraphic );

    function SaveToString : AnsiString;
    procedure LoadFromString( const Str : AnsiString );

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

    procedure AddNote;
    procedure AddText;
    procedure AddRectangle;
    procedure AddLine;
    procedure AddImage; { MB Apr 11, 2003 }

    procedure Burn;

    { load/save annotations via the AnnotationsStr property }
    property AnnotationsStr : AnsiString read SaveToString
                                         write LoadFromString;
end;

EAnnotationError = class(Exception);

{--------------------------------------------------------------------------}

implementation


uses
    Forms,    { for Screen }
    EnAnProp, { for TAnnotationPropertiesDialog }
    EnMsg,    { for msgXXXX }
    EnMisc;   { for SwapIntegers }

{--------------------------------------------------------------------------}

constructor TAnnotationMouseHandler.Create( const InImageScrollBox : TImageScrollBox );
var
    MenuItem : TMenuItem;
begin
    inherited Create(InImageScrollBox);

    FImageScrollBox := TProtectedScrollBox(InImageScrollBox);
    FImageScrollBox.FImage.Cursor := crDefault;

    FEditor                := TAnnotationsEditor.Create(nil);
    FEditor.DisplaySurface := FImageScrollBox;
    FMenu                  := TPopupMenu.Create(nil);

    MenuItem := TMenuItem.Create(FMenu);
    MenuItem.Caption := msgPropertiesDialog;
    MenuItem.OnClick := PropertiesDialog;
    FMenu.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(FMenu);
    MenuItem.Caption := msgDelete;
    MenuItem.OnClick := DeleteAnnotation;
    FMenu.Items.Add(MenuItem);

    FEditor.PopupMenu              := FMenu;

    FEditor.OnAnnotationClick      := AnnotationClick;

    OldNewGraphic                 := InImageScrollBox.OnNewGraphic;
    InImageScrollBox.OnNewGraphic := ImageScrollBoxNewGraphic;
    
    ImageScrollBoxNewGraphic( InImageScrollBox.Graphic );
end;

{--------------------------------------------------------------------------}

destructor TAnnotationMouseHandler.Destroy;
begin
    { restore event handlers }
    FImageScrollBox.OnNewGraphic := OldNewGraphic;

    FMenu.Free;
    FEditor.Free;

    inherited Destroy;
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.ImageScrollBoxNewGraphic( const Graphic : TDibGraphic );
begin
    if Assigned(OldNewGraphic) then
        OldNewGraphic(Graphic);

    FEditor.Clear;

    FEditor.DisplayRect          := Classes.Rect( 0, 0, Graphic.Width, Graphic.Height);
    FEditor.DisplayResolution    := Screen.PixelsPerInch; //} FImageScrollBox.Graphic.YDotsPerInch;
    FEditor.Visible              := True;
    FEditor.ZoomFactor           := FImageScrollBox.ZoomPercent;
    FEditor.DisplayVertScrollBar := FImageScrollBox.VertScrollBar;
    FEditor.DisplayHorzScrollBar := FImageScrollBox.HorzScrollBar;
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.BeforeResize;
begin
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.AfterResize;
begin
    FEditor.Visible        := not FImageScrollBox.Centered;
    
    FEditor.ZoomFactor     := FImageScrollBox.ZoomPercent;
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.PropertiesDialog( Sender : TObject );
var
    Properties : TAnnotationsPropertyDialog;

begin
    if LastAnnotationSelected = nil then
        Exit;

    Properties := TAnnotationsPropertyDialog.Create(nil);
    try
        Properties.SetValues(LastAnnotationSelected);

         if Properties.ShowModal = mrOk then
            Properties.GetValues(LastAnnotationSelected);
    finally
        Properties.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.DeleteAnnotation( Sender : TObject );
var
    Index : Integer;
begin
    if LastAnnotationSelected = nil then
        Exit;

    Index := FEditor.FindIndex(LastAnnotationSelected);
    if Index >= 0 then
        FEditor.Delete(Index);
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.AnnotationClick( Sender : TObject );
begin
    FEditor.EditMode               := False;
    LastAnnotationSelected        := Sender as TGenericMark;
    TGenericMark(Sender).EditMode := True;
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.MouseDown(
        				     const Button : TMouseButton;
					     const Shift  : TShiftState;
					     const X, Y   : Integer );
begin
    { The Annotation mouse handler does not work when the image is centered }
    if FImageScrollBox.Centered then
        Exit;

    FEditor.EditMode       := False;
    LastAnnotationSelected := nil;
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.MouseMove(
                                             const Shift : TShiftState;
                                             const X, Y  : Integer );
begin
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.MouseUp(
				  const Button : TMouseButton;
				  const Shift  : TShiftState;
				  const X, Y   : Integer );
begin
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.AddNote;
var
    Mark    : TGenericMark;
begin
    Mark := FEditor.AddStickNote;
    Mark.MarkRect := Rect( FImageScrollBox.HorzScrollBar.Position + 5,
                           FImageScrollBox.VertScrollBar.Position + 5,
                           FImageScrollBox.HorzScrollBar.Position + 200,
                           FImageScrollBox.VertScrollBar.Position + 200 );
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.AddRectangle;
var
    Mark : TGenericMark;
begin
    Mark          := FEditor.AddRectangle;
    Mark.MarkRect := Rect( FImageScrollBox.HorzScrollBar.Position + 5,
                           FImageScrollBox.VertScrollBar.Position + 5,
                           FImageScrollBox.HorzScrollBar.Position + 200,
                           FImageScrollBox.VertScrollBar.Position + 200);
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.AddText;
var
    Mark : TTextMark;
begin
    Mark            := FEditor.AddText;
    Mark.MarkRect   := Rect( FImageScrollBox.HorzScrollBar.Position + 5,
                             FImageScrollBox.VertScrollBar.Position + 5,
                             FImageScrollBox.HorzScrollBar.Position + 400,
                             FImageScrollBox.VertScrollBar.Position + 100);
    Mark.Font.Color := clRed;
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.AddLine;
var
    Mark : TLineMark;
begin
    Mark := FEditor.AddLine;
    Mark.MarkRect := Rect( FImageScrollBox.HorzScrollBar.Position + 10,
                           FImageScrollBox.VertScrollBar.Position + 10,
                           FImageScrollBox.HorzScrollBar.Position + 200,
                           FImageScrollBox.VertScrollBar.Position + 200);
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.AddImage;
var
    Mark : TImageMark;
begin
    Mark := FEditor.AddImage;
    Mark.MarkRect := Rect( FImageScrollBox.HorzScrollBar.Position + 10,
                           FImageScrollBox.VertScrollBar.Position + 10,
                           FImageScrollBox.HorzScrollBar.Position + 200,
                           FImageScrollBox.VertScrollBar.Position + 200);
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.Burn;
begin
    FEditor.ZoomFactor := 100;
    FEditor.BurnIn(FImageScrollBox.Graphic.Canvas);
    FEditor.Clear;
    FImageScrollBox.Redraw(True);
end;

{--------------------------------------------------------------------------}

function TAnnotationMouseHandler.SaveToString : AnsiString;
begin
    Result := FEditor.SaveToString;
end;

{--------------------------------------------------------------------------}

procedure TAnnotationMouseHandler.LoadFromString( const Str : AnsiString );
begin
    FEditor.LoadFromString(Str);
end;

{--------------------------------------------------------------------------}

end.

