{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnThbnFm
|
| Description: Thumbnail viewer form.
|
| Future enhancements: Cache resized images in the FileLB.Items.Objects as
|                      TMemoryStream objects, possible as TBitmapGraphic or
|                      another format with compression
|
| History:       , 2000. MB initial version
|          May 24, 2001. MB Finalize code
|          Nov   , 2001. MB Finalize layout, add splitters
|
|---------------------------------------------------------------------------}
unit EnThbnFm;

interface

uses
    EnImgScr,
    EnTransf, { for TResizeTransform }

  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileCtrl, ExtCtrls, Grids;

type
  TThumbnailForm = class(TForm)
    ButtonPanel: TPanel;
    OkBtn: TButton;
    CancelBtn: TButton;
    HelpBtn: TButton;
    FileEdit: TEdit;
    FilterCB: TFilterComboBox;
    DirectoryLB: TDirectoryListBox;
    DriveCB: TDriveComboBox;
    DrawGrid: TDrawGrid;
    FileNameLbl: TLabel;
    FilterLbl: TLabel;
    FileLB: TFileListBox;
    LeftSplitter: TSplitter;
    BottomSplitter: TSplitter;
    procedure FormCreate(Sender: TObject);
    procedure DrawGridDrawCell(Sender: TObject; Col, Row: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure FilterCBChange(Sender: TObject);
    procedure FileEditKeyPress(Sender: TObject; var Key: Char);
    procedure DirectoryLBChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DrawGridDblClick(Sender: TObject);
    procedure FileLBDblClick(Sender: TObject);
    procedure FileLBClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ButtonPanelResize(Sender: TObject);
    procedure DrawGridClick(Sender: TObject);

  protected
    { Private declarations }
    FPicture            : TPicture;

    FThumbnailWidth     : Integer;
    FThumbnailHeight    : Integer;

    FEnlargeSmallImages : Boolean;

    FResizeTransform    : TResizeTransform;

    procedure SetThumbnailWidth( const Width : Integer );
    procedure SetThumbnailHeight( const Height : Integer );

    function RowColToIndex( const Row  : Integer;
                            const Col  : Integer ) : Integer;

    procedure IndexToRowCol( const Index : Integer;
                             var   Row   : Integer;
                             var   Col   : Integer );

    function GetResizeable : Boolean;
    procedure SetResizeable( const InResizeable : Boolean );

    function GetShowHelpButton : Boolean;
    procedure SetShowHelpButton( const InShowHelpButton : Boolean );

  public
    { Public declarations }
    function Execute( var FileName : String ) : Boolean;

    property ThumbnailWidth  : Integer read FThumbnailWidth
                                       write SetThumbnailWidth;

    property ThumbnailHeight : Integer read FThumbnailHeight
                                       write SetThumbnailHeight;

    property EnlargeSmallImages : Boolean read FEnlargeSmallImages
                                          write FEnlargeSmallImages;

    property Resizeable : Boolean read GetResizeable
                                 write SetResizeable;

    { If ShowHelpButton is True, the HelpContext property of the form
      should be set before invoking Execute }
    property ShowHelpButton : Boolean read GetShowHelpButton
                                      write SetShowHelpButton;
  end;

{--------------------------------------------------------------------------}

implementation

{$R *.DFM}

uses
    EnDiGrph, { for TDibGraphic }
    EnMisc;   { for ifTrueColor, SafeTrunc }

{--------------------------------------------------------------------------}

procedure TThumbnailForm.FormCreate(Sender: TObject);
begin
    FPicture         := TPicture.Create;
    FResizeTransform := TResizeTransform.Create;

    Resizeable        := False;
    ShowHelpButton    := False;

    ThumbnailWidth   := 100;
    ThumbnailHeight  := 100;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.FormDestroy(Sender: TObject);
begin
    FResizeTransform.Free;
    FPicture.Free;
end;

{--------------------------------------------------------------------------}

function TThumbnailForm.Execute( var FileName : String ) : Boolean;
var
    Index : Integer;
begin
    FilterCB.Filter := GraphicFilter(TDibGraphic);

    DirectoryLBChange(Self);

    FormResize(Self);

    Result := (Self.ShowModal = mrOk);

    if Result then
    begin
        Index := RowColToIndex(DrawGrid.Row, DrawGrid.Col);
        if Index <= (FileLB.Items.Count-1) then
            FileName := FileLB.Items[Index]
        else
            Result := False;
    end;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.DrawGridDrawCell(Sender: TObject; Col,
  Row: Integer; Rect: TRect; State: TGridDrawState);
var
    ValidImage   : Boolean;
    Index        : Integer;
    SmallRect    : TRect;
    Width        : Integer;
    Height       : Integer;

    procedure DrawStretched;
    var
        Factor : Single;
    begin
        if FPicture.Graphic.Width > FPicture.Graphic.Height then
            Factor := Width / FPicture.Graphic.Width
        else
            Factor := Height / FPicture.Graphic.Height;

        FResizeTransform.Width  := SafeTrunc(FPicture.Graphic.Width * Factor);
        FResizeTransform.Height := SafeTrunc(FPicture.Graphic.Height * Factor);

        if FResizeTransform.Width < 2 then
            FResizeTransform.Width := 2;

        if FResizeTransform.Height < 2 then
            FResizeTransform.Height := 2;

        FResizeTransform.Apply( FPicture.Graphic as TDibGraphic );

        DrawGrid.Canvas.Draw( SmallRect.Left + (Width - FPicture.Graphic.Width) div 2,
                              SmallRect.Top + (Height - FPicture.Graphic.Height) div 2,
                              FPicture.Graphic );
    end;

begin
    try
        Index    := RowColToIndex(Row,Col);

        if (Index < 0) or (Index >= FileLb.Items.Count) then
            ValidImage := False
        else
        begin
            FPicture.LoadFromFile(FileLb.Items[Index]);
            ValidImage := True;
        end;
    except
        ValidImage := False;
    end;

    DrawGrid.Canvas.Brush.Color := clWhite;
    DrawGrid.Canvas.FillRect(Rect);

    if ValidImage then
    begin
        SmallRect.Top    := Rect.Top + 4;
        SmallRect.Bottom := Rect.Bottom - 4;
        SmallRect.Right  := Rect.Right - 4;
        SmallRect.Left   := Rect.Left + 4;

        Width  := SmallRect.Right - SmallRect.Left + 1;
        Height := SmallRect.Bottom - SmallRect.Top + 1;

        if (FPicture.Graphic.Width  < Width) and
           (FPicture.Graphic.Height < Height) then
        begin
            if EnlargeSmallImages then
                 DrawStretched
            else
                 DrawGrid.Canvas.Draw( SmallRect.Left + (Width - FPicture.Graphic.Width) div 2,
                                       SmallRect.Top + (Height - FPicture.Graphic.Height) div 2,
                                       FPicture.Graphic );
        end
        else
            DrawStretched;
    end;
end;

{--------------------------------------------------------------------------}

function TThumbnailForm.RowColToIndex( const Row  : Integer;
                                       const Col  : Integer ) : Integer;
begin
    Result := Row * DrawGrid.ColCount + Col;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.IndexToRowCol( const Index : Integer;
                                        var   Row   : Integer;
                                        var   Col   : Integer );
begin
    Row := Index div DrawGrid.ColCount;
    Col := Index mod DrawGrid.ColCount;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.FilterCBChange(Sender: TObject);
begin
    DirectoryLBChange(Self);
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.SetThumbnailWidth( const Width : Integer );
begin
    FThumbnailWidth          := Width;
    DrawGrid.DefaultColWidth := Width;

    { the +6 prevents the horizontal scroll bar from appearing in the
      draw grid }
    DrawGrid.ColCount        := DrawGrid.Width div (Width+6);
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.SetThumbnailHeight( const Height : Integer );
begin
    FThumbnailHeight          := Height;
    DrawGrid.DefaultRowHeight := Height;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.FileEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    FileLB.ApplyFilePath(FileEdit.Text);
    Key := #0;
  end;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.DirectoryLBChange(Sender: TObject);
begin
    if (FileLB.Items.Count mod DrawGrid.ColCount) = 0 then
        DrawGrid.RowCount := FileLb.Items.Count div DrawGrid.ColCount
    else
        DrawGrid.RowCount := (FileLb.Items.Count div DrawGrid.ColCount) + 1;

    DrawGrid.Invalidate;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_ESCAPE then
        ModalResult := mrCancel;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.DrawGridDblClick(Sender: TObject);
begin
    if (DrawGrid.Col >= 0) and (DrawGrid.Row >= 0) then
        ModalResult := mrOk;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.FileLBDblClick(Sender: TObject);

begin
    if FileLB.ItemIndex >= 0 then
    begin
        FileLBClick(Self);
        ModalResult := mrOk;
    end;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.FileLBClick(Sender: TObject);
var
    Row    : Integer;
    Col    : Integer;
begin
    if FileLB.ItemIndex >= 0 then
    begin
        IndexToRowCol( FileLB.ItemIndex, Row, Col );
        DrawGrid.Row  := Row;
        DrawGrid.Col  := Col;

        DrawGrid.SetFocus;
    end;
end;

{--------------------------------------------------------------------------}

function TThumbnailForm.GetResizeable : Boolean;
begin
    Result := (Self.BorderStyle = bsSizeable);
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.SetResizeable( const InResizeable : Boolean );
begin
    if InResizeable then
    begin
        Self.BorderStyle := bsSizeable;
        Self.BorderIcons := [biMaximize, biSystemMenu];
    end
    else
        Self.BorderStyle := bsDialog;
end;

{--------------------------------------------------------------------------}

function TThumbnailForm.GetShowHelpButton : Boolean;
begin
    Result := HelpBtn.Visible;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.SetShowHelpButton( const InShowHelpButton : Boolean );
begin
    HelpBtn.Visible := InShowHelpButton;
    HelpBtn.Enabled := InShowHelpButton;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.FormResize(Sender: TObject);
begin
    HelpBtn.Left      := ButtonPanel.Width - HelpBtn.Width - 6;
    CancelBtn.Left    := HelpBtn.Left;
    OkBtn.Left        := HelpBtn.Left;

    FileEdit.Left     := HelpBtn.Left - FileEdit.Width - 10;
    FileNameLbl.Left  := FileEdit.Left;
    FilterLbl.Left    := FileEdit.Left;
    FilterCB.Left     := FileEdit.Left;

    DriveCB.Width     := FileEdit.Left - 16;
    DirectoryLB.Width := DriveCB.Width;

    SetThumbnailWidth( FThumbnailWidth );

    DirectoryLBChange(Self);
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.ButtonPanelResize(Sender: TObject);
begin
    if ButtonPanel.Height < 100 then
        ButtonPanel.Height := 100;

    DirectoryLB.Height := ButtonPanel.Height - DriveCB.Height - 12;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailForm.DrawGridClick(Sender: TObject);
begin
    if (DrawGrid.Row >= 0) and (DrawGrid.Col >= 0) then
    begin
        FileLB.ItemIndex := RowColToIndex( DrawGrid.Row, DrawGrid.Col );
    end;
end;

{--------------------------------------------------------------------------}

end.
