{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnAnEdit
|
| Description: Component which allows drawing annotations on a drawing surface.
|
| History: Nov 27, 2002 Originally written by Francesco Pucino, http://web.tiscalinet.it/delphipage
|
|---------------------------------------------------------------------------}
unit EnAnEdit;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, Menus, ExtCtrls, EnCtlRsz;

type

TGenericMark = class( TGraphicControl)
private
    FDisplayRect: TRect;
    FDisplayResolution: Integer;
    FMarkRect: TRect;
    FZoomFactor: Double;
    FControlResizer: TControlResizer;
    FEditMode: Boolean;
    FModified: Boolean;
    FColor: TColor;
    procedure SetDisplayRect( Value: TRect);
    procedure SetDisplayResolution( Value: Integer);
    procedure SetZoomFactor( Value: Double);
    procedure SetMarkRect( Value: TRect); virtual;
    procedure SetEditMode( Value: Boolean);
    procedure MovedOrSized( Sender: TObject; OldBounds, NewBounds: TRect);
    procedure SetColor( Value: TColor);
    function GetMarkAsBitmap: TBitmap; virtual;

    procedure SetAllowEdit( Value : Boolean );

public
    constructor Create( AOwner: TComponent); override;
    procedure Paint; override;
    procedure DrawMark( ACanvas: TCanvas; X, Y: Integer); virtual;
    property MarkRect: TRect read FMarkRect write SetMarkRect;
    property ZoomFactor: Double read FZoomFactor write SetZoomFactor;
    property EditMode: Boolean read FEditMode write SetEditMode;
    property Modified: Boolean read FModified write FModified;
    property Color: TColor read FColor write SetColor;
    property DisplayRect: TRect read FDisplayRect write SetDisplayRect;
    property DisplayResolution: Integer read FDisplayResolution write SetDisplayResolution;

    { MB Feb 03, 2003 }
    property AllowEdit : Boolean write SetAllowEdit;
end;

TStickNoteMark = class( TGenericMark)
private
    FText: string;
    FFont: TFont;
    procedure SetText( Value: string);
    procedure FontChanged( AFont: TObject);
    function GetMarkAsBitmap: TBitmap; override;
public
    constructor Create( AOWner: TComponent); override;
    property Text: string read FText write SetText;
    property Font: TFont read FFont;
end;

TRectangleMark = class( TGenericMark)
private
    FLineSize: Integer;
    FHightLight: Boolean;
    FFilled: Boolean;
    procedure SetLineSize( Value: Integer);
    procedure SetHightLight( Value: Boolean);
    procedure SetFilled( Value: Boolean);
    function GetMarkAsBitmap: TBitmap; override;
public
    constructor Create( AOWner: TComponent); override;
    procedure DrawMark( ACanvas: TCanvas; X, Y: Integer); override;
    property HightLight: Boolean read FHightLight write SetHightLight;
    property Filled: Boolean read FFilled write SetFilled;
    property LineSize: Integer read FLineSize write SetLineSize;
end;

TTextMark = class( TGenericMark)
private
    FText: string;
    FFont: TFont;
    procedure SetText( Value: string);
    procedure FontChanged( AFont: TObject);
    function GetMarkAsBitmap: TBitmap; override;
public
    constructor Create( AOWner: TComponent); override;
    property Text: string read FText write SetText;
    property Font: TFont read FFont;
end;

{ NEVER change order, ALWAYS add items after existing values. The ordinal
  values are stored persistently }
TLineOrientation = ( loTop,    { horizontal line }
                     loRight,  { vertical line }
                     loTLBR,   { negative slope }
                     loBLTR    { postive slope }
                   );

TLineMark = class( TGenericMark)
private
    FLineSize      : Integer;
    FOrientation   : TLineOrientation;
    procedure SetLineSize( Value: Integer);
    procedure SetOrientation( const Value : TLineOrientation );
    function GetMarkAsBitmap: TBitmap; override;
public
    constructor Create( AOWner: TComponent); override;
    destructor Destroy; override;
    property LineSize: Integer read FLineSize write SetLineSize;
    property Orientation : TLineOrientation read FOrientation
                                            write SetOrientation;
end;

TMultiLineMark = class( TGenericMark)
private
    FLineSize : Integer;
    FPoints   : TList;
    procedure SetLineSize( Value: Integer);
    function GetPoint( Index: Integer): PPoint;
    function GetPointsCount: Integer;
    procedure SetMarkRect( Value: TRect); override;
    function GetMarkAsBitmap: TBitmap; override;
public
    constructor Create( AOWner: TComponent); override;
    destructor Destroy; override;
    procedure AddPoint( Point: TPoint);
    procedure DeletePoint( Index: Integer);
    procedure ClearPoints;
    property LineSize: Integer read FLineSize write SetLineSize;
    property Points[Index: Integer]: PPoint read GetPoint;
    property PointsCount: Integer read GetPointsCount;
end;

TImageMark = class( TGenericMark)
private
    FDIBHandle: THandle;
    FTransparent : Boolean;
    procedure SetDIBHandle( Value: THandle);
    function GetMarkAsBitmap: TBitmap; override;
public
    constructor Create( AOWner: TComponent); override;
    destructor Destroy; override;
    property DIBHandle: THandle read FDIBHandle write SetDIBHandle;
    property Transparent : Boolean read FTransparent write FTransparent;
end;

TAnnotationsEditor = class( TComponent)
private
    FDisplaySurface: TWinControl;
    FDisplayResolution: Integer;
    FDisplayRect: TRect;
    FDisplayHorzScrollBar: TControlScrollBar;
    FDisplayVertScrollBar: TControlScrollBar;
    FVisible: Boolean;
    FMarks: TList;
    FZoomFactor: Double;
    FEditMode: Boolean;
    FChanged: Boolean;
    FOnAnnotationClick: TNotifyEvent;
    FOnAnnotationDblClick: TNotifyEvent;
    FOnAnnotationMouseDown: TMouseEvent;
    FOnAnnotationMouseMove: TMouseMoveEvent;
    FOnAnnotationMouseUp: TMouseEvent;
    FPopupMenu: TPopupMenu;
    procedure SetDisplaySurface( DS: TWinControl);
    procedure SetDisplayRect( Value: TRect);
    procedure SetDisplayResolution( Value: Integer);
    function GetVisualMark( Index: Integer): TGenericMark;
    procedure SetZoomFactor( Value: Double);
    procedure SetEditMode( Value: Boolean);
    function GetChanged: Boolean;
    procedure ClickPerformed( Sender: TObject);
    procedure DblClickPerformed( Sender: TObject);
    procedure MouseDownPerformed( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseMovePerformed( Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MouseUpPerformed( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SetPopupMenu( Value: TPopupMenu);
    procedure SetVisible( Value: Boolean);
    function GetCount: Integer;
    procedure SetAllowEdit( Value : Boolean );

public
    constructor Create( AOwner: TComponent); override;
    destructor Destroy; override;
    function AddStickNote: TStickNoteMark;
    function AddRectangle: TRectangleMark;
    function AddText: TTextMark;
    function AddMultiLine: TMultiLineMark;
    function AddLine : TLineMark;
    function AddImage: TImageMark;
    procedure Clear;
    procedure Delete( Index: Integer);
    function FindIndex( Mark: TGenericMark): Integer;
    procedure BurnIn( Canvas: TCanvas);

    { MB Jan 08, 2003 }
    procedure LoadFromString( const Str : AnsiString );
    function SaveToString : AnsiString;

    property DisplaySurface: TWinControl read FDisplaySurface write SetDisplaySurface;
    property DisplayRect: TRect read FDisplayRect write SetDisplayRect;
    property DisplayResolution: Integer read FDisplayResolution write SetDisplayResolution;
    property DisplayVertScrollBar: TControlScrollBar read FDisplayVertScrollBar write FDisplayVertScrollBar;
    property DisplayHorzScrollBar: TControlScrollBar read FDisplayHorzScrollBar write FDisplayHorzScrollBar;
    property Items[Index: Integer]: TGenericMark read GetVisualMark; default;
    property ZoomFactor: Double read FZoomFactor write SetZoomFactor;
    property EditMode: Boolean read FEditMode write SetEditMode;
    property Changed: Boolean read GetChanged;
    property OnAnnotationClick: TNotifyEvent read FOnAnnotationClick write FOnAnnotationClick;
    property OnAnnotationDblClick: TNotifyEvent read FOnAnnotationDblClick write FOnAnnotationDblClick;
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property Visible: Boolean read FVisible write SetVisible;
    property Count: Integer read GetCount;
    property AllowEdit : Boolean write SetAllowEdit;
end;

function BitmapToDIB( Bitmap: TBitmap): Integer;
procedure DIBToBitmap( DIBHandle: THandle; Bitmap: TBitmap);

implementation

uses
    EnPpmGr, { for TPpmGraphic }
    EnMisc;  { for Ceiling }

resourcestring
    rsInvalidParentForMark = 'Invalid Parent for Mark';


constructor TAnnotationsEditor.Create( AOwner: TComponent);
begin
    inherited Create( AOwner);
    FMarks := TList.Create;
    FChanged := False;
    FEditMode := False;
end;

destructor TAnnotationsEditor.Destroy;
begin
    Clear;
    FMarks.Free;
    inherited Destroy;
end;

function TAnnotationsEditor.GetVisualMark( Index: Integer): TGenericMark;
begin
    Result := FMarks[Index];
end;

procedure TAnnotationsEditor.Delete( Index: Integer);
begin
    {$Warnings Off}
    TGenericMark( FMarks[Index]).Free;
    {$Warnings On}
    FMarks.Delete( Index);
end;

procedure TAnnotationsEditor.Clear;
begin
    while FMarks.Count > 0 do
    begin
        {$Warnings Off}
        TGenericMark( FMarks[FMarks.Count - 1]).Free;
        {$Warnings On}
        FMarks.Delete( FMarks.Count - 1);
    end;
    FChanged := True;
end;

function TAnnotationsEditor.FindIndex( Mark: TGenericMark): Integer;
var
    i: Integer;
begin
    Result := -1;
    for i := 0 to FMarks.Count - 1 do
        if Mark = FMarks[i] then
        begin
            Result := i;
            break;
        end;
end;

function TAnnotationsEditor.GetChanged: Boolean;
var
    i: integer;
begin
    Result := False;
    for i := 0 to FMarks.Count - 1 do
        {$Warnings Off}
        if TGenericMark( FMarks[i]).Modified then
            Result := True;
        {$Warnings On}
end;

function TAnnotationsEditor.AddStickNote: TStickNoteMark;
begin
    FChanged := True;
    Result := TStickNoteMark( Items[FMarks.Add( TStickNoteMark.Create( Self))]);
    Result.ZoomFactor := FZoomFactor;
    Result.Parent := FDisplaySurface;
    Result.EditMode := FEditMode;
end;

function TAnnotationsEditor.AddRectangle: TRectangleMark;
begin
    FChanged := True;
    Result := TRectangleMark( Items[FMarks.Add( TRectangleMark.Create( Self))]);
    Result.ZoomFactor := FZoomFactor;
    Result.Parent := FDisplaySurface;
    Result.EditMode := FEditMode;
end;

function TAnnotationsEditor.AddText: TTextMark;
begin
    FChanged := True;
    Result := TTextMark( Items[FMarks.Add( TTextMark.Create( Self))]);
    Result.ZoomFactor := FZoomFactor;
    Result.Parent := FDisplaySurface;
    Result.EditMode := FEditMode;
end;

function TAnnotationsEditor.AddMultiLine: TMultiLineMark;
begin
    FChanged := True;
    Result := TMultiLineMark( Items[FMarks.Add( TMultiLineMark.Create( Self))]);
    Result.ZoomFactor := FZoomFactor;
    Result.Parent := FDisplaySurface;
    Result.EditMode := FEditMode;
end;

function TAnnotationsEditor.AddLine: TLineMark;
begin
    FChanged := True;
    Result := TLineMark( Items[FMarks.Add( TLineMark.Create( Self))]);
    Result.ZoomFactor := FZoomFactor;
    Result.Parent := FDisplaySurface;
    Result.EditMode := FEditMode;
end;

function TAnnotationsEditor.AddImage: TImageMark;
begin
    FChanged := True;
    Result := TImageMark( Items[FMarks.Add( TImageMark.Create( Self))]);
    Result.ZoomFactor := FZoomFactor;
    Result.Parent := FDisplaySurface;
    Result.EditMode := FEditMode;
end;

procedure TAnnotationsEditor.SetDisplaySurface( DS: TWinControl);
var
    i: integer;
begin
    if DS = FDisplaySurface then
        Exit;
    FDisplaySurface := DS;
    for i := 0 to FMarks.Count - 1 do
        {$Warnings Off}
        TGenericMark( FMarks[i]).Parent := FDisplaySurface;
        {$Warnings On}
end;

procedure TAnnotationsEditor.SetDisplayRect( Value: TRect);
var
    i: integer;
begin
    FDisplayRect := Value;
    for i := 0 to FMarks.Count - 1 do
        {$Warnings Off}
        TGenericMark( FMarks[i]).DisplayRect := Value;
        {$Warnings On}
end;

procedure TAnnotationsEditor.SetDisplayResolution( Value: Integer);
var
    i: Integer;
begin
    FDisplayResolution := Value;
    for i := 0 to FMarks.Count - 1 do
        {$Warnings Off}
        TGenericMark( FMarks[i]).DisplayResolution := Value;
        {$Warnings On}

end;

procedure TAnnotationsEditor.SetZoomFactor( Value: Double);
var
    i: Integer;
begin
    if Value = FZoomFactor then
        Exit;
    FZoomFactor := Value;
    for i := 0 to FMarks.Count - 1 do
        {$Warnings Off}
        TGenericMark( FMarks[i]).ZoomFactor := Value;
        {$Warnings On}
end;

procedure TAnnotationsEditor.SetEditMode( Value: Boolean);
var
    I: Integer;
begin
    //if Value=FEditMode then Exit;
    FEditMode := Value;
    for i := 0 to FMarks.Count - 1 do
    begin
        {$Warnings Off}
        TGenericMark( FMarks[i]).EditMode := FEditMode;
        {$Warnings On}
    end;
end;

procedure TAnnotationsEditor.SetAllowEdit( Value : Boolean );
var
    I: Integer;
begin
    for i := 0 to FMarks.Count - 1 do
    begin
        {$Warnings Off}
        TGenericMark( FMarks[i]).Enabled := Value;
        {$Warnings On}
    end;
end;

procedure TAnnotationsEditor.ClickPerformed( Sender: TObject);
begin
    if Assigned( FOnAnnotationClick) then
        FOnAnnotationClick( Sender);
end;

procedure TAnnotationsEditor.DblClickPerformed( Sender: TObject);
begin
    if Assigned( FOnAnnotationDblClick) then
        FOnAnnotationDblClick( Sender);
end;

procedure TAnnotationsEditor.MouseDownPerformed( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Assigned( FOnAnnotationMouseDown) then
        FOnAnnotationMouseDown( Sender, Button, Shift, X, Y);
end;

procedure TAnnotationsEditor.MouseMovePerformed( Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
    if Assigned( FOnAnnotationMouseMove) then
        FOnAnnotationMouseMove( Sender, Shift, X, Y);
end;

procedure TAnnotationsEditor.MouseUpPerformed( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if Assigned( FOnAnnotationMouseUp) then
        FOnAnnotationMouseUp( Sender, Button, Shift, X, Y);
end;

procedure TAnnotationsEditor.SetPopupMenu( Value: TPopupMenu);
var
    i: Integer;
begin
    if Value = FPopupMenu then
        Exit;
    FPopupMenu := Value;
    for i := 0 to FMarks.Count - 1 do
        {$Warnings Off}
        TGenericMark( FMarks[i]).PopupMenu := FPopupMenu;
        {$Warnings On}
end;

procedure TAnnotationsEditor.SetVisible( Value: Boolean);
var
    i: Integer;
begin
    FVisible := Value;
    for i := 0 to FMarks.Count - 1 do
        {$Warnings Off}
        TGenericMark( FMarks[i]).Visible := Value;
        {$Warnings On}
end;

function TAnnotationsEditor.GetCount: Integer;
begin
    Result := FMarks.Count;
end;

procedure TAnnotationsEditor.BurnIn( Canvas: TCanvas);
var
    i: integer;
begin
    for i := 0 to FMarks.Count - 1 do
        {$Warnings Off}
        TGenericMark( FMarks[i]).DrawMark( Canvas, TGenericMark( FMarks[i]).Left, TGenericMark( FMarks[i]).Top);
        {$Warnings On}
end;

{--------------------------------------------------------------------------}

procedure Check( const Condition : Boolean;
                 const Msg       : String );
begin
    if not Condition then
        raise Exception.Create(Msg);
end;

const

anStickNote = 1;
anRectangle = 2;
anLine      = 3;
anText      = 4;
anImage     = 5;  { MB Apr 11, 2003 }

{--------------------------------------------------------------------------}

procedure WriteInteger( const Value : Integer;
                        var   Str   : AnsiString );
begin
    Str := Str + '(' + IntToStr(Value) + ')';
end;

{--------------------------------------------------------------------------}

function ReadInteger( const Str   : AnsiString;
                      var   Index : Integer ) : Integer;
var
    ValueStr : String;
begin
    Inc(Index);
    Check( Length(Str) >= Index, 'Invalid position in ReadInteger');

    Check( Str[Index] = '(', '( expected in ReadInteger' );

    Inc(Index);
    Check( Length(Str) >= Index, 'Invalid position in ReadInteger');

    ValueStr := '';

    while Str[Index] <> ')' do
    begin
        ValueStr := ValueStr + Str[Index];
        Inc(Index);
        Check( Length(Str) >= Index, 'Invalid position in ReadInteger');
    end;

    Result := StrToInt(ValueStr);
end;



{--------------------------------------------------------------------------}

procedure WriteString( const Value : AnsiString;
                       var   Str   : AnsiString );
begin
    WriteInteger( Length(Value), Str );
    Str := Str + Value;
end;

{--------------------------------------------------------------------------}

function ReadString( const Str   : AnsiString;
                     var   Index : Integer ) : String;
var
    Length : Integer;
begin
    Length := ReadInteger(Str, Index);

    SetLength( Result, Length );
    Result := Copy( Str, Index+1, Length );

    Index := Index + Length;
end;

{--------------------------------------------------------------------------}

procedure WriteBoolean( const Value : Boolean;
                        var   Str   : AnsiString );
begin
    if Value then
        WriteInteger(1, Str)
    else
        WriteInteger(0, Str);
end;

{--------------------------------------------------------------------------}

function ReadBoolean( const Str   : AnsiString;
                      var   Index : Integer ) : Boolean;
begin
    if ReadInteger(Str, Index) = 0 then
        Result := False
    else
        Result := True;
end;

{--------------------------------------------------------------------------}

procedure WriteRect( const Rect    : TRect;
                     var   Str     : AnsiString );
begin
    WriteInteger(Rect.Left, Str);
    WriteInteger(Rect.Top, Str);
    WriteInteger(Rect.Right, Str);
    WriteInteger(Rect.Bottom, Str);
end;

{--------------------------------------------------------------------------}

function ReadRect( const Str   : AnsiString;
                   var   Index : Integer ) : TRect;
begin
    Result.Left   := ReadInteger(Str, Index);
    Result.Top    := ReadInteger(Str, Index);
    Result.Right  := ReadInteger(Str, Index);
    Result.Bottom := ReadInteger(Str, Index);
end;

{--------------------------------------------------------------------------}

procedure WriteFont( const Font    : TFont;
                     var   Str     : AnsiString );
begin
    WriteInteger( Font.Color,Str);

    WriteString( Font.Name, Str );
    WriteInteger( Font.Size, Str );
    WriteBoolean( fsItalic in Font.Style, Str );
    WriteBoolean( fsUnderline in Font.Style, Str );
    WriteBoolean( fsStrikeOut in Font.Style, Str );
    WriteBoolean( fsBold in Font.Style, Str );
end;

{--------------------------------------------------------------------------}

function ReadFont( const Font  : TFont;
                   const Str   : AnsiString;
                   var   Index : Integer ) : TRect;
begin
    Font.Color := ReadInteger(Str, Index);
    Font.Name  := ReadString( Str, Index );
    Font.Size  := ReadInteger( Str, Index );

    Font.Style := [];

    if ReadBoolean( Str, Index ) then
        Font.Style := Font.Style + [fsItalic];
    if ReadBoolean( Str, Index ) then
        Font.Style := Font.Style + [fsUnderline];
    if ReadBoolean( Str, Index ) then
        Font.Style := Font.Style + [fsStrikeOut];
    if ReadBoolean( Str, Index ) then
        Font.Style := Font.Style + [fsBold];
end;

{--------------------------------------------------------------------------}

procedure WriteGenericMark( const Mark    : TGenericMark;
                            var   Str     : AnsiString );
begin
    WriteRect( Mark.MarkRect, Str );
    WriteBoolean(Mark.Visible, Str);
    WriteInteger(Mark.Color, Str);
end;

{--------------------------------------------------------------------------}

procedure ReadGenericMark( const Mark    : TGenericMark;
                           const Str     : AnsiString;
                           var   Index   : Integer );
begin
    Mark.MarkRect := ReadRect( Str, Index );
    Mark.Visible  := ReadBoolean( Str, Index );
    Mark.Color := ReadInteger(Str, Index);
end;

{--------------------------------------------------------------------------}

procedure WriteStickNote( const Mark    : TStickNoteMark;
                          var   Str     : AnsiString );
begin
    WriteInteger( anStickNote, Str );

    WriteGenericMark( Mark, Str);

    WriteString( Mark.Text, Str );

    WriteFont( Mark.Font, Str );
end;

{--------------------------------------------------------------------------}

procedure ReadStickNote( const Mark    : TStickNoteMark;
                         const Str     : AnsiString;
                         var   Index   : Integer );
begin
    ReadGenericMark(Mark, Str, Index );

    Mark.Text  := ReadString( Str, Index );

    ReadFont( Mark.Font, Str, Index );
end;

{--------------------------------------------------------------------------}

procedure WriteRectangle( const Mark    : TRectangleMark;
                          var   Str     : AnsiString );
begin
    WriteInteger( anRectangle, Str );

    WriteGenericMark( Mark, Str);

    WriteBoolean(Mark.HightLight, Str);
    WriteBoolean(Mark.Filled, Str);

    WriteInteger(Mark.LineSize, Str);
end;

{--------------------------------------------------------------------------}

procedure ReadRectangle( const Mark    : TRectangleMark;
                         const Str     : AnsiString;
                         var   Index   : Integer );
begin
    ReadGenericMark(Mark, Str, Index );

    Mark.Hightlight := ReadBoolean( Str, Index );
    Mark.Filled     := ReadBoolean( Str, Index );
    Mark.LineSize   := ReadInteger( Str, Index );
end;

{--------------------------------------------------------------------------}

procedure WriteText( const Mark    : TTextMark;
                     var   Str     : AnsiString );
begin
    WriteInteger( anText, Str );

    WriteGenericMark( Mark, Str);

    WriteString(Mark.Text, Str);
    WriteFont(Mark.Font, Str);
end;

{--------------------------------------------------------------------------}

procedure ReadText( const Mark    : TTextMark;
                    const Str     : AnsiString;
                    var   Index   : Integer );
begin
    ReadGenericMark(Mark, Str, Index );

    Mark.Text       := ReadString( Str, Index );
    ReadFont( Mark.Font, Str, Index );
end;

{--------------------------------------------------------------------------}

procedure WriteLine( const Mark    : TLineMark;
                     var   Str     : AnsiString );
begin
    WriteInteger( anLine, Str );

    WriteGenericMark( Mark, Str);

    WriteInteger( Mark.LineSize, Str );

    WriteInteger( Ord(Mark.Orientation), Str );
end;

{--------------------------------------------------------------------------}

procedure ReadLine( const Mark    : TLineMark;
                    const Str     : AnsiString;
                    var   Index   : Integer );
begin
    ReadGenericMark(Mark, Str, Index );

    Mark.LineSize := ReadInteger( Str, Index );

    Mark.Orientation := TLineOrientation(ReadInteger( Str, Index ));
end;

{--------------------------------------------------------------------------}

procedure WriteImage( const Mark    : TImageMark;
                      var   Str     : AnsiString );
var
    PpmGraphic : TPpmGraphic;
    Stream     : TMemoryStream;
    DataStr    : AnsiString;
begin
    WriteInteger( anImage, Str );

    WriteGenericMark( Mark, Str);

    WriteBoolean( Mark.Transparent, Str );

    if Mark.DIBHandle = 0 then
        WriteBoolean( False, Str )
    else
    begin
        WriteBoolean( True, Str );

        PpmGraphic := TPpmGraphic.Create;
        Stream     := TMemoryStream.Create;
        try
            PpmGraphic.AssignFromDIBHandle(Mark.DIBHandle);
            PpmGraphic.Mode := pmAscii;
            PpmGraphic.SaveToStream(Stream);

            WriteInteger( Stream.Size, Str );

            SetLength( DataStr, Stream.Size );
            Stream.Seek( 0, soFromBeginning );
            Stream.ReadBuffer( DataStr[1], Stream.Size );

            WriteString( DataStr, Str );

        finally
            Stream.Free;
            PpmGraphic.Free;
        end;
    end;
end;

{--------------------------------------------------------------------------}

procedure ReadImage( const Mark    : TImageMark;
                     const Str     : AnsiString;
                     var   Index   : Integer );
var
    PpmGraphic : TPpmGraphic;
    Stream     : TMemoryStream;
    DataStr    : AnsiString;
    Assigned   : Boolean;
begin
    ReadGenericMark(Mark, Str, Index );

    Mark.Transparent := ReadBoolean(Str, Index);

    Assigned         := ReadBoolean(Str, Index);

    if Assigned then
    begin
        PpmGraphic := TPpmGraphic.Create;
        Stream     := TMemoryStream.Create;
        try
            Stream.SetSize( ReadInteger(Str, Index) );

            DataStr := ReadString(Str, Index);

            Stream.WriteBuffer( DataStr[1], Stream.Size );
            Stream.Seek( 0, soFromBeginning );

            PpmGraphic.LoadFromStream(Stream);

            Mark.DIBHandle := PpmGraphic.AsDibHandle;

        finally
            Stream.Free;
            PpmGraphic.Free;
        end;
    end;
end;

{--------------------------------------------------------------------------}

procedure TAnnotationsEditor.LoadFromString( const Str : AnsiString );
var
    AnnotationNo     : Integer;
    Mark             : TGenericMark;
    Count            : Integer;
    StrIndex         : Integer;
    AnnotationType   : Integer;

begin
    Self.Clear;
    if Str = '' then
        Exit;

    StrIndex := 0;
    Count    := ReadInteger( Str, StrIndex );

    for AnnotationNo := 1 to Count do
    begin
        AnnotationType := ReadInteger( Str, StrIndex );

        case AnnotationType of
            anStickNote :
            begin
                Mark := Self.AddStickNote;
                ReadStickNote( TStickNoteMark(Mark), Str, StrIndex );
            end;

            anRectangle :
            begin
                Mark := Self.AddRectangle;
                ReadRectangle( TRectangleMark(Mark), Str, StrIndex );
            end;

            anLine :
            begin
                Mark := Self.AddLine;
                ReadLine( TLineMark(Mark), Str, StrIndex );
            end;

            anText :
            begin
                Mark := Self.AddText;
                ReadText( TTextMark(Mark), Str, StrIndex );
            end;

            anImage :
            begin
                Mark := Self.AddImage;
                ReadImage( TImageMark(Mark), Str, StrIndex );
            end;

        end; { case }
    end;
end;

function TAnnotationsEditor.SaveToString : AnsiString;
var
    AnnotationNo : Integer;
    Mark         : TGenericMark;
begin
    Result      := '';

    if Self.Count = 0 then
        Exit;

    WriteInteger( Self.Count, Result );

    for AnnotationNo := 0 to Self.Count-1 do
    begin
        Mark := Self.Items[AnnotationNo];

        if Mark is TStickNoteMark then
            WriteStickNote( TStickNoteMark(Mark), Result )
        else if Mark is TRectangleMark then
            WriteRectangle( TRectangleMark(Mark), Result )
        else if Mark is TLineMark then
            WriteLine( TLineMark(Mark), Result )
        else if Mark is TTextMark then
            WriteText( TTextMark(Mark), Result )
        else if Mark is TImageMark then
            WriteImage( TImageMark(Mark), Result)
    end;
end;

//==============================================================================
// TVisualMark
//==============================================================================

constructor TGenericMark.Create( AOwner: TComponent);
begin
    inherited Create( AOwner);
    FEditMode := False;
    FModified := False;
    FControlResizer := nil;

    if not ( AOwner is TAnnotationsEditor) then
        raise Exception.Create( rsInvalidParentForMark);

    OnClick := TAnnotationsEditor( AOwner).ClickPerformed;
    OnDblClick := TAnnotationsEditor( AOwner).DblClickPerformed;
    OnMouseDown := TAnnotationsEditor( AOwner).MouseDownPerformed;
    OnMouseUp := TAnnotationsEditor( AOwner).MouseUpPerformed;
    OnMouseMove := TAnnotationsEditor( AOwner).MouseMovePerformed;
    PopupMenu := TAnnotationsEditor( AOwner).PopupMenu;
    FDisplayRect := TAnnotationsEditor( AOwner).DisplayRect;
    FDisplayResolution := TAnnotationsEditor( AOwner).DisplayResolution;
end;

function ScaleRect( const Rect : TRect;
                    const Zoom : Double ) : TRect;
begin
    Result.Left   := Round( Rect.Left * Zoom / 100);
    Result.Top    := Round( Rect.Top * Zoom / 100);
    Result.Right  := Round( Rect.Right * Zoom / 100);
    Result.Bottom := Round( Rect.Bottom * Zoom / 100);
end;

procedure TGenericMark.SetMarkRect( Value: TRect);
var
    TempRect: TRect;
begin
    FMarkRect := Value;

    if not IsRectEmpty( FDisplayRect) then
    begin
        if FMarkRect.Left < FDisplayRect.Left then
            FMarkRect.Left := FDisplayRect.Left;
        if FMarkRect.Top < FDisplayRect.Top then
            FMarkRect.Top := FDisplayRect.Top;
        if FMarkRect.Right > FDisplayRect.Right then
            FMarkRect.Right := FDisplayRect.Right;
        if FMarkRect.Bottom > FDisplayRect.Bottom then
            FMarkRect.Bottom := FDisplayRect.Bottom;
    end;

    TempRect := ScaleRect( FMarkRect, FZoomFactor );

    if Assigned( TAnnotationsEditor( Owner).DisplayHorzScrollBar) then
        OffsetRect( TempRect, -TAnnotationsEditor( Owner).DisplayHorzScrollBar.Position, 0);
    if Assigned( TAnnotationsEditor( Owner).DisplayVertScrollBar) then
        OffsetRect( TempRect, 0, -TAnnotationsEditor( Owner).DisplayVertScrollBar.Position);

    //OffsetRect(TempRect,FDisplayOffset.X,FDisplayOffset.Y);

    BoundsRect := TempRect;
    if FEditMode then
        FControlResizer.BoundsRect := BoundsRect;
end;

procedure TGenericMark.SetZoomFactor( Value: Double);
var
    TempRect: TRect;
begin
    FZoomFactor := Value;

    TempRect := ScaleRect( FMarkRect, FZoomFactor );
    BoundsRect := TempRect;
    if FEditMode then
        FControlResizer.BoundsRect := BoundsRect;
end;

procedure TGenericMark.SetAllowEdit( Value : Boolean );
begin
    Self.Enabled := Value;
end;

procedure TGenericMark.SetEditMode( Value: Boolean);
begin
    if FEditMode = Value then
        Exit;
    FEditMode := Value;
    if FEditMode then
    begin
        if not Assigned( FControlResizer) then
        begin
            FControlResizer := TControlResizer.Create( Self);
            FControlResizer.TargetControl := Self;
            FControlResizer.OnMoved := MovedOrSized;
            FControlResizer.OnResized := MovedOrSized;
            FControlResizer.Movable := True;
            FControlResizer.ReSizable := True;
            FControlResizer.BoundsRect := BoundsRect;
            FControlResizer.BoxColor := clBlue;
            FControlResizer.PopupMenu := PopupMenu;
        end;
        FControlResizer.BoundsRect := BoundsRect;
    end;
    if Assigned( FControlResizer) then
        FControlResizer.Visible := FEditMode;
end;

procedure TGenericMark.MovedOrSized( Sender: TObject; OldBounds, NewBounds: TRect);
var
    TempRect: TRect;
begin
    FModified := True;

    if Assigned( TAnnotationsEditor( Owner).DisplayHorzScrollBar) then
        OffsetRect( NewBounds, TAnnotationsEditor( Owner).DisplayHorzScrollBar.Position, 0);
    if Assigned( TAnnotationsEditor( Owner).DisplayVertScrollBar) then
        OffsetRect( NewBounds, 0, TAnnotationsEditor( Owner).DisplayVertScrollBar.Position);

    TempRect.Left := Round( NewBounds.Left / ZoomFactor * 100);
    TempRect.Top := Round( NewBounds.Top / ZoomFactor * 100);
    TempRect.Right := Round( NewBounds.Right / ZoomFactor * 100);
    TempRect.Bottom := Round( NewBounds.Bottom / ZoomFactor * 100);

    MarkRect := TempRect;
end;

procedure TGenericMark.SetColor( Value: TColor);
begin
    if Value = FColor then
        Exit;
    FColor := Value;
    Invalidate;
end;

procedure TGenericMark.SetDisplayRect( Value: TRect);
begin
    FDisplayRect := Value;
    // To-Do: Probably should "cut" marks crossing borders...
end;

procedure TGenericMark.SetDisplayResolution( Value: Integer);
begin
    if Value = FDisplayResolution then
        Exit;
    FDisplayResolution := Value;
    Invalidate;
end;

function TGenericMark.GetMarkAsBitmap: TBitmap;
begin
    Result := TBitmap.Create;
    Result.Width := ( FMarkRect.Right - FMarkRect.Left) + 1;
    Result.Height := ( FMarkRect.Bottom - FMarkRect.Top) + 1;
    Result.Monochrome := False;
end;

procedure TGenericMark.DrawMark( ACanvas: TCanvas; X, Y: Integer);
var
    Bitmap: TBitmap;
    OutRect: TRect;
begin
    Bitmap := GetMarkAsBitmap;
    try
        OutRect := BoundsRect;
        OffsetRect( OutRect, -Left, -Top);
        OffsetRect( OutRect, X, Y);
        ACanvas.CopyMode := cmSrcCopy;
        ACanvas.StretchDraw( OutRect, Bitmap);
    finally
        Bitmap.Free;
    end;
end;

procedure TGenericMark.Paint;
begin
    inherited Paint;
    try
        DrawMark( Canvas, 0, 0);
    except
    end;
end;

//==============================================================================
// TStickNoteMark
//==============================================================================

constructor TStickNoteMark.Create( AOWner: TComponent);
begin
    inherited Create( AOwner);
    FFont := TFont.Create;
    FFont.Name := 'Arial';
    FFont.Size := 12;
    FFont.OnChange := FontChanged;
    FColor := clYellow;
    FText := 'Stick Note';
end;

procedure TStickNoteMark.FontChanged( AFont: TObject);
begin
    Invalidate;
end;

procedure TStickNoteMark.SetText( Value: string);
begin
    if Value = FText then
        Exit;
    FText := Value;
    Invalidate;
end;

function TStickNoteMark.GetMarkAsBitmap: TBitmap;
var
    OutRect: TRect;
    Off: Integer;
begin
    Result := inherited GetMarkAsBitmap;

    Result.Canvas.Brush.Style := bsSolid;
    if FColor = clGray then
        Result.Canvas.Brush.Color := clWhite
    else
        Result.Canvas.Brush.Color := clGray;

    Result.TransparentColor := Result.Canvas.Brush.Color;
    Result.Transparent      := True;
    OutRect := Rect( 0, 0, Result.Width - 1, Result.Height - 1);
    { MB Dec 3. This adjust prevents a white line on the right and bottom
      edges when the zoom > 100. The white bitmap from inherited GetMarkAsBitmap
      was not covered completely }
    if FZoomFactor > 100 then
    begin
        OutRect.Right  := OutRect.Right + 1;
        OutRect.Bottom := OutRect.Bottom + 1;
    end;
    Result.Canvas.FillRect( OutRect);

    Result.Canvas.Brush.Color := clBlack;
    Result.Canvas.Brush.Style := bsSolid;
    Off := Round( Result.Width * 0.025);
    OutRect := Rect( Off, Off, Result.Width, Result.Height);
    Result.Canvas.FillRect( OutRect);

    Result.Canvas.Brush.Color := FColor;
    OutRect := Rect( 0, 0, Result.Width - Off, Result.Height - Off);
    Result.Canvas.FillRect( OutRect);

    Result.Canvas.Font.Assign( FFont);
    Result.Canvas.Font.Size := Round( Result.Canvas.Font.Size * FDisplayResolution / 72);
    SetBkMode( Result.Canvas.Handle, Transparent);
    {$Warnings Off}
    DrawText( Result.Canvas.Handle, PChar( FText), Length( FText), OutRect, DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX);
    {$Warnings On}
end;

//==============================================================================
// TRectangleMark
//==============================================================================

constructor TRectangleMark.Create( AOwner: TComponent);
begin
    inherited Create( AOwner);
    FColor := clLime;
    FLineSize := 4;
    FFilled := True;
    FHightLight := True;
end;

procedure TRectangleMark.SetLineSize( Value: Integer);
begin
    if Value = FLineSize then
        Exit;
    FLineSize := Value;
    Invalidate;
end;

procedure TRectangleMark.SetHightLight( Value: Boolean);
begin
    if Value = FHightLight then
        Exit;
    FHightLight := Value;
    Invalidate;
end;

procedure TRectangleMark.SetFilled( Value: Boolean);
begin
    if Value = FFilled then
        Exit;
    FFilled := Value;
    Invalidate;
end;

function TRectangleMark.GetMarkAsBitmap: TBitmap;
var
    Rect : TRect;
begin
    Result := inherited GetMarkAsBitmap;
    if FFilled then
    begin
        Result.Canvas.Brush.Color := FColor;
        Result.Canvas.Brush.Style := bsSolid;
        Result.Canvas.FillRect( Result.Canvas.ClipRect);
        Result.Transparent := False;
    end
    else
    begin
        if FColor = clWhite then
            Result.Canvas.Brush.Color := clBlack
        else
            Result.Canvas.Brush.Color := clWhite;
        Result.TransparentColor := Result.Canvas.Brush.Color;
        Result.Transparent := True;
        Result.Canvas.Brush.Style := bsSolid;
        Result.Canvas.FillRect( Result.Canvas.ClipRect);
        Result.Canvas.Brush.Style := bsClear;
        Result.Canvas.Pen.Color := FColor;
        Result.Canvas.Pen.Width := FLineSize;
        Rect := Result.Canvas.ClipRect;
        Result.Canvas.Rectangle( Rect.TopLeft.X, Rect.TopLeft.Y,
                                 Rect.BottomRight.X, Rect.BottomRight.Y );
    end;
end;

procedure TRectangleMark.DrawMark( ACanvas: TCanvas; X, Y: Integer);
var
    Bitmap: TBitmap;
    OutRect: TRect;
begin
    Bitmap := GetMarkAsBitmap;
    try
        OutRect := BoundsRect;
        OffsetRect( OutRect, -Left, -Top);
        OffsetRect( OutRect, X, Y);
        //SetBkMode(Canvas.Handle,Transparent);
        if FHightLight then
            ACanvas.CopyMode := cmSrcAnd
        else
            ACanvas.CopyMode := cmSrcCopy;
        ACanvas.StretchDraw( OutRect, Bitmap);
    finally
        Bitmap.Free;
    end;
end;

//==============================================================================
// TTextMark
//==============================================================================

constructor TTextMark.Create( AOWner: TComponent);
begin
    inherited Create( AOwner);
    FFont := TFont.Create;
    FFont.Name := 'Arial';
    FFont.Size := 12;
    FFont.OnChange := FontChanged;
    FColor := clYellow;
    FText := 'Text';
end;

procedure TTextMark.FontChanged( AFont: TObject);
begin
    Invalidate;
end;

procedure TTextMark.SetText( Value: string);
begin
    if Value = FText then
        Exit;
    FText := Value;
    Invalidate;
end;

function TTextMark.GetMarkAsBitmap: TBitmap;
var
    OutRect: TRect;
begin
    Result := inherited GetMarkAsBitmap;
    if FFont.Color = clWhite then
        Result.Canvas.Brush.Color := clBlack
    else
        Result.Canvas.Brush.Color := clWhite;
    Result.Canvas.Brush.Style := bsSolid;
    OutRect := Rect( 0, 0, Result.Width, Result.Height);
    Result.Canvas.FillRect( OutRect);
    Result.TransparentColor := Result.Canvas.Brush.Color;
    Result.Transparent := True;
    Result.Canvas.Font.Assign( FFont);
    Result.Canvas.Font.Size := Result.Canvas.Font.Size * Round( FDisplayResolution / 96);
    SetBkMode( Result.Canvas.Handle, Transparent);
    {$Warnings Off}
    DrawText( Result.Canvas.Handle, PChar( FText), Length( FText), OutRect, DT_LEFT or DT_WORDBREAK or DT_EXPANDTABS or DT_NOPREFIX);
    {$Warnings On}
    Result.TransparentColor := FColor;
    Result.Transparent := True;
end;

//==============================================================================
// TMultiLineMark
//==============================================================================

constructor TMultiLineMark.Create( AOwner: TComponent);
begin
    inherited Create( AOwner);
    FColor := clNavy;
    FLineSize := 4;
    FPoints := TList.Create;
end;

destructor TMultiLineMark.Destroy;
begin
    ClearPoints;
    FPoints.Free;
    inherited Destroy;
end;

procedure TMultiLineMark.SetLineSize( Value: Integer);
begin
    if Value = FLineSize then
        Exit;
    FLineSize := Value;
    Invalidate;
end;

function TMultiLineMark.GetPoint( Index: Integer): PPoint;
begin
    Result := FPoints[Index];
end;

procedure TMultiLineMark.AddPoint( Point: TPoint);
var
    TempPoint: PPoint;
begin
    New( TempPoint);
    TempPoint^ := Point;
    FPoints.Add( TempPoint);
end;

procedure TMultiLineMark.DeletePoint( Index: Integer);
begin
    Dispose( FPoints[Index]);
    FPoints.Delete( Index);
end;

procedure TMultiLineMark.ClearPoints;
var
    i: integer;
begin
    for i := 0 to FPoints.Count - 1 do
        Dispose( FPoints[i]);
    FPoints.Clear;
end;

function TMultiLineMark.GetPointsCount: Integer;
begin
    Result := FPoints.Count;
end;

procedure TMultiLineMark.SetMarkRect( Value: TRect);
var
    XF, YF: Double;
    i: integer;
begin
    if ( ( MarkRect.Right - MarkRect.Left) > 0) and ( ( MarkRect.Bottom - MarkRect.Top) > 0) then
    begin
        XF := ( Value.Right - Value.Left) / ( MarkRect.Right - MarkRect.Left);
        YF := ( Value.Bottom - Value.Top) / ( MarkRect.Bottom - MarkRect.Top);
        for i := 0 to PointsCount - 1 do
        begin
            Points[i].X := Round( Points[i].X * XF);
            Points[i].Y := Round( Points[i].Y * YF);
        end;
    end;
    inherited SetMarkRect( Value);
end;

function TMultiLineMark.GetMarkAsBitmap: TBitmap;
var
    OutRect: TRect;
    I: Integer;
begin
    Result := inherited GetMarkAsBitmap;
    if FColor = clWhite then
        Result.Canvas.Brush.Color := clBlack
    else
        Result.Canvas.Brush.Color := clWhite;
    Result.Canvas.Brush.Style := bsSolid;
    OutRect := Rect( 0, 0, Result.Width, Result.Height);
    Result.Canvas.FillRect( OutRect);
    Result.TransparentColor := Result.Canvas.Brush.Color;
    Result.Transparent := True;
    Result.Canvas.Brush.Style := bsClear;
    Result.Canvas.Pen.Color := FColor;
    Result.Canvas.Pen.Width := FLineSize;
    if PointsCount > 0 then
        Result.Canvas.MoveTo( Points[0].X, Points[0].Y);
    for i := 1 to PointsCount - 1 do
        Result.Canvas.LineTo( Points[i].X, Points[i].Y);
end;

//==============================================================================
// TLineMark
//==============================================================================

constructor TLineMark.Create( AOWner: TComponent);
begin
    inherited Create( AOwner);
    FColor       := clNavy;
    FLineSize    := 4;
    FOrientation := loTLBR;
end;

destructor TLineMark.Destroy;
begin
    inherited Destroy;
end;

procedure TLineMark.SetLineSize( Value: Integer);
begin
    if Value = FLineSize then
        Exit;
    FLineSize := Value;
    Invalidate;
end;

procedure TLineMark.SetOrientation( const Value : TLineOrientation );
begin
    if Value = FOrientation then
        Exit;
    FOrientation := Value;
    Invalidate;
end;

function TLineMark.GetMarkAsBitmap: TBitmap;
var
    Rect    : TRect;
    BoxSize : Integer;
begin
    Result := inherited GetMarkAsBitmap;
    if FColor = clWhite then
        Result.Canvas.Brush.Color := clBlack
    else
        Result.Canvas.Brush.Color := clWhite;

    Result.Canvas.Brush.Style := bsSolid;
    Result.TransparentColor   := Result.Canvas.Brush.Color;
    Result.Transparent        := True;
    Result.Canvas.Brush.Style := bsClear;
    Result.Canvas.Pen.Color   := FColor;
    Result.Canvas.Pen.Width   := FLineSize;

    Result.Canvas.FillRect( Result.Canvas.ClipRect);
    Rect := Result.Canvas.ClipRect;

    if FControlResizer = nil then
        { not editing }
        BoxSize := CDefaultResizerBoxSize
    else
        BoxSize := FControlResizer.BoxSize;

    case FOrientation of
        loTop :
        begin
            Result.Canvas.MoveTo( Rect.Left, Rect.Top + BoxSize);
            Result.Canvas.LineTo( Rect.Right, Rect.Top + BoxSize );
        end;

        loRight :
        begin
            Result.Canvas.MoveTo( Rect.Right - BoxSize, Rect.Top);
            Result.Canvas.LineTo( Rect.Right - BoxSize, Rect.Bottom );
        end;

        loTLBR :
        begin
            Result.Canvas.MoveTo( Rect.Left, Rect.Top);
            Result.Canvas.LineTo( Rect.Right, Rect.Bottom );
        end;

        loBLTR :
        begin
            Result.Canvas.MoveTo( Rect.Left, Rect.Bottom);
            Result.Canvas.LineTo( Rect.Right, Rect.Top );
        end;
    end; { case }
end;

//==============================================================================
// TImageMark
//==============================================================================

constructor TImageMark.Create( AOwner: TComponent);
begin
    inherited Create( AOwner);
    FColor     := clBlack;
    FDIBHandle := 0;
end;

destructor TImageMark.Destroy;
begin
    if FDIBHandle <> 0 then
        GlobalFree( FDIBHandle);

    inherited Destroy;
end;

procedure TImageMark.SetDIBHandle( Value: THandle);
begin
    if Value = FDIBHandle then
        Exit;
    if FDIBHandle <> 0 then
        GlobalFree( FDIBHandle);
    FDIBHandle := Value;
    Invalidate;
end;

function TImageMark.GetMarkAsBitmap: TBitmap;
var
    OutRect: TRect;

begin
    Result := inherited GetMarkAsBitmap;
    if FDIBHandle = 0 then
    begin
        Result.Canvas.Brush.Color := FColor;
        Result.Canvas.Brush.Style := bsSolid;
        OutRect := Rect( 0, 0, Result.Width - 1, Result.Height - 1);
        Result.Canvas.FillRect( OutRect);
    end
    else
    begin
        DIBToBitmap( FDIBHandle, Result);
    end;

    Result.Transparent := Self.Transparent;
end;

//==============================================================================
// Utilities
//==============================================================================

procedure DIBToBitmap( DIBHandle: THandle; Bitmap: TBitmap);
var
    Stream: TMemoryStream;
    Header: TBitmapFileHeader;
    {$Warnings Off}
    P: Pointer;
    {$Warnings On}
begin
    if DIBHandle = 0 then
        Exit;
    Stream := TMemoryStream.Create;
    try
        FillChar( Header, SizeOf( Header), 0);
        Header.bfType := $4D42;
        Header.bfSize := GlobalSize( DIBHandle) + SizeOf( Header);
        Stream.Write( Header, SizeOf( Header));
        {$Warnings Off}
        P := GlobalLock( DIBHandle);
        try
            Stream.Write( P^, GlobalSize( DIBHandle));
        finally
            GlobalUnLock( DIBHandle);
        end;
        {$Warnings On}
        Stream.Position := 0;
        Bitmap.LoadFromStream( Stream);
    finally
        Stream.Free;
    end;
end;

function BitmapToDIB( Bitmap: TBitmap): Integer;
var
    Stream: TMemoryStream;
    Header: TBitmapFileHeader;
    Size: Integer;
    {$Warnings Off}
    P: Pointer;
    {$Warnings On}
begin
    Stream := TMemoryStream.Create;
    try
        Bitmap.SaveToStream( Stream);
        Stream.Position := 0;
        Stream.Read( Header, SizeOf( Header));
        Size := Stream.Size - SizeOf( Header);
        Result := GlobalAlloc( GHND, Size);
        {$Warnings Off}
        P := GlobalLock( Result);
        try
            Stream.Read( P^, Size)
        finally
            GlobalUnlock( Result);
        end;
        {$Warnings On}
    finally
        Stream.Free;
    end;
end;

end.
