{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnAnProp
|
| Description: Form to edit annotation properties.
|
| History: Nov 29, 2002 Originally written by Francesco Pucino, http://web.tiscalinet.it/delphipage
|
|---------------------------------------------------------------------------}
unit EnAnProp;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls, ExtCtrls, ComCtrls, EnAnEdit, ExtDlgs, Mask;

type

TAnnotationsPropertyDialog = class( TForm)
    Bevel: TBevel;
    OkBtn: TButton;
    CancelBtn: TButton;
    Label1: TLabel;
    EditTop: TMaskEdit;
    EditLeft: TMaskEdit;
    Label2: TLabel;
    EditRight: TMaskEdit;
    EditBottom: TMaskEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PageControl: TPageControl;
    TabSheetText: TTabSheet;
    MemoText: TMemo;
    Label6: TLabel;
    CheckBoxVisible: TCheckBox;
    Label7: TLabel;
    EditFont: TMaskEdit;
    ButtonFont: TButton;
    FontDialog: TFontDialog;
    TabSheetRectangle: TTabSheet;
    Label9: TLabel;
    CheckBoxRectangleHightLight: TCheckBox;
    CheckBoxRectangleFilled: TCheckBox;
    EditRectanglePen: TMaskEdit;
    TabSheetLine: TTabSheet;
    Label10: TLabel;
    EditLinePen: TMaskEdit;
    TabSheetImage: TTabSheet;
    Image: TImage;
    Label11: TLabel;
    ButtonLoad: TButton;
    ButtonClear: TButton;
    LineRG: TRadioGroup;
    ColorShape: TShape;
    ColorDialog: TColorDialog;
    ColorButton: TButton;
    TransparentImageCB: TCheckBox;
    OpenPictureDialog: TOpenPictureDialog;
    procedure ButtonFontClick( Sender: TObject);
    procedure ButtonLoadClick( Sender: TObject);
    procedure ButtonClearClick( Sender: TObject);
    procedure ColorButtonClick( Sender: TObject);
private
    { Private declarations }
public
    { Public declarations }
    procedure SetValues( AnnotationMark: TGenericMark);
    procedure GetValues( AnnotationMark: TGenericMark);
end;


implementation

{$R *.dfm}

uses
    EnMisc,       { for RectWidth, RectHeight }
    EnTransf,     { for TResizeTransform }
    EnDiGrph;     { for TDibGraphic }

function GetFontDescription( Font: TFont): string;
begin
    Result := Font.Name + ', ' + IntToStr( Font.Size);
    if fsBold in Font.Style then
        Result := Result + ', Bold';
    if fsItalic in Font.Style then
        Result := Result + ', Italic';
    if fsUnderline in Font.Style then
        Result := Result + ', Underline';
    if fsStrikeout in Font.Style then
        Result := Result + ', Strikeout';
end;

procedure TAnnotationsPropertyDialog.SetValues( AnnotationMark: TGenericMark);
var
    Graphic : TDibGraphic;
begin
    EditLeft.Text := IntToStr(AnnotationMark.MarkRect.Left);
    EditTop.Text := IntToStr(AnnotationMark.MarkRect.Top);
    EditRight.Text := IntToStr(AnnotationMark.MarkRect.Right);
    EditBottom.Text := IntToStr(AnnotationMark.MarkRect.Bottom);

    ColorShape.Brush.Color := AnnotationMark.Color;

    CheckBoxVisible.Checked := AnnotationMark.Visible;
    if AnnotationMark is TStickNoteMark then
    begin
        PageControl.ActivePage := TabSheetText;
        FontDialog.Font.Assign( TStickNoteMark( AnnotationMark).Font);
        EditFont.Text := GetFontDescription( FontDialog.Font);
        EditFont.Font.Color := FontDialog.Font.Color;
        MemoText.Lines.Text := TStickNoteMark( AnnotationMark).Text;
    end
    else if AnnotationMark is TRectangleMark then
    begin
        PageControl.ActivePage := TabSheetRectangle;
        CheckBoxRectangleFilled.Checked := TRectangleMark( AnnotationMark).Filled;
        CheckBoxRectangleHightLight.Checked := TRectangleMark( AnnotationMark).HightLight;
        EditRectanglePen.Text := IntToStr(TRectangleMark( AnnotationMark).LineSize);
    end
    else if AnnotationMark is TTextMark then
    begin
        PageControl.ActivePage := TabSheetText;
        FontDialog.Font.Assign( TTextMark( AnnotationMark).Font);
        EditFont.Text          := GetFontDescription( FontDialog.Font);
        EditFont.Font.Color    := FontDialog.Font.Color;
        MemoText.Lines.Text    := TTextMark( AnnotationMark).Text;
    end
    else if AnnotationMark is TLineMark then
    begin
        PageControl.ActivePage := TabSheetLine;
        EditLinePen.Text   := IntToStr(TLineMark(AnnotationMark).LineSize);
        LineRG.ItemIndex   := Ord( TLineMark(AnnotationMark).Orientation);
    end
    else if AnnotationMark is TImageMark then
    begin
        PageControl.ActivePage := TabSheetImage;
        TransparentImageCB.Checked := TImageMark( AnnotationMark).Transparent;
        if TImageMark( AnnotationMark).DIBHandle <> 0 then
        begin
            Graphic := TDibGraphic.Create;
            try
                { assigning to Graphic makes a copy }
                Image.Picture.Graphic := Graphic;
                TDibGraphic(Image.Picture.Graphic).AssignFromDibHandle(
                                         TImageMark( AnnotationMark).DIBHandle);
            finally
                Graphic.Free;
            end;
        end;
    end
end;

procedure TAnnotationsPropertyDialog.GetValues( AnnotationMark: TGenericMark);
var
    TempRect        : TRect;
    Graphic         : TDibGraphic;
    ResizeTransform : TResizeTransform;

begin
    TempRect.Left           := StrToInt(Trim(EditLeft.Text));
    TempRect.Top            := StrToInt(Trim(EditTop.Text));
    TempRect.Right          := StrToInt(Trim(EditRight.Text));
    TempRect.Bottom         := StrToInt(Trim(EditBottom.Text));
    AnnotationMark.MarkRect := TempRect;
    AnnotationMark.Color    := ColorShape.Brush.Color;
    AnnotationMark.Visible  := CheckBoxVisible.Checked;
    if AnnotationMark is TStickNoteMark then
    begin
        TStickNoteMark( AnnotationMark).Font.Assign( FontDialog.Font);
        TStickNoteMark( AnnotationMark).Text := MemoText.Lines.Text;
    end
    else if AnnotationMark is TRectangleMark then
    begin
        TRectangleMark( AnnotationMark).Filled     := CheckBoxRectangleFilled.Checked;
        TRectangleMark( AnnotationMark).HightLight := CheckBoxRectangleHightLight.Checked;
        TRectangleMark( AnnotationMark).LineSize   := StrToInt(Trim(EditRectanglePen.Text));
    end
    else if AnnotationMark is TTextMark then
    begin
        TTextMark( AnnotationMark).Font.Assign( FontDialog.Font);
        TTextMark( AnnotationMark).Text := MemoText.Lines.Text;
    end
    else if AnnotationMark is TLineMark then
    begin
        TLineMark( AnnotationMark).LineSize    := StrToInt(Trim(EditLinePen.Text));
        TLineMark( AnnotationMark).Orientation := TLineOrientation(LineRG.ItemIndex);
    end
    else if AnnotationMark is TImageMark then
    begin
        TImageMark( AnnotationMark).Transparent := TransparentImageCB.Checked;

        Graphic := TDibGraphic.Create;
        try
            Graphic.Assign( Image.Picture.Graphic );

            if Graphic.IsEmpty then
                TImageMark( AnnotationMark).DIBHandle := 0
            else
            begin
                { If the graphic selected by the user is larger than the annotation,
                  resize it.
                  Otherwise, when large images are selected, the resulting size of
                  the annotations string was huge, because the graphics are not
                  stored in a compressed form, but stored as readable text using
                  the ppm format }
                if (Graphic.Width  > RectWidth(AnnotationMark.MarkRect)) or
                   (Graphic.Height > RectHeight(AnnotationMark.MarkRect)) then
                begin
                    ResizeTransform := TResizeTransform.Create;
                    try                                   
                        ResizeTransform.Interpolated := False;
                        ResizeTransform.Width        := RectWidth(AnnotationMark.MarkRect);
                        ResizeTransform.Height       := RectHeight(AnnotationMark.MarkRect);
                        ResizeTransform.Apply(Graphic);
                    finally
                        ResizeTransform.Free;
                    end;
                end;

                TImageMark( AnnotationMark).DIBHandle := Graphic.AsDibHandle;

            end;
        finally
            Graphic.Free;
        end;
    end;
end;

procedure TAnnotationsPropertyDialog.ButtonFontClick( Sender: TObject);
begin
    if FontDialog.Execute then
    begin
        EditFont.Text := GetFontDescription( FontDialog.Font);
        EditFont.Font.Color := FontDialog.Font.Color;
    end;
end;

procedure TAnnotationsPropertyDialog.ButtonLoadClick( Sender: TObject);
begin
    if OpenPictureDialog.Execute then
    begin
        Image.Picture.LoadFromFile(OpenPictureDialog.FileName);
    end;
end;

procedure TAnnotationsPropertyDialog.ButtonClearClick( Sender: TObject);
begin
    Image.Picture.Graphic := nil;
    Image.Repaint;
end;

procedure TAnnotationsPropertyDialog.ColorButtonClick( Sender: TObject);
begin
    if ColorDialog.Execute then
        ColorShape.Brush.Color := ColorDialog.Color;
end;

end.
  