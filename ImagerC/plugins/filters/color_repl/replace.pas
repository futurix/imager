unit replace;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ColorPickerButton;

type
  TfrmColorReplacer = class(TForm)
    sbxReplace: TScrollBox;
    btnCancel: TButton;
    btnOK: TButton;
    lblColorToReplace: TLabel;
    lblReplacementColor: TLabel;
    imgPreview: TImage;
    btnPreview: TButton;
    dlgColor: TColorDialog;
    pkrRColor: TColorPickerButton;
    pkrColor: TColorPickerButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure imgPreviewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmColorReplacer: TfrmColorReplacer;
  gbmp: TBitmap;
  cancelled: boolean = true;

function FIPISfilter(info: PChar; app: THandle; img: hBitmap):hBitmap; stdcall;

implementation

{$R *.DFM}

function FIPISfilter(info: PChar; app: THandle; img: hBitmap):hBitmap;
var
   bmp: TBitmap;
begin
// tuning form
Application.Handle:=app;
// tuning bitmap
gbmp:=TBitmap.Create();
gbmp.Handle:=img;
bmp:=TBitmap.Create();
// starting
frmColorReplacer:=TfrmColorReplacer.Create(Application);
frmColorReplacer.ShowModal();
// ending
bmp.Assign(gbmp);
if cancelled then Result:=0 else begin
                                 bmp.Assign(gbmp);
                                 Result:=bmp.ReleaseHandle();
                                 end;
gbmp.Free();
frmColorReplacer.Free();
bmp.Free();
end;

procedure TfrmColorReplacer.FormCreate(Sender: TObject);
begin
imgPreview.Picture.Bitmap.Assign(gbmp);
end;

procedure TfrmColorReplacer.btnCancelClick(Sender: TObject);
begin
Close();
end;

procedure TfrmColorReplacer.btnOKClick(Sender: TObject);
begin
btnPreviewClick(frmColorReplacer);
gbmp.Assign(imgPreview.Picture.Bitmap);
cancelled:=false;
Close();
end;

procedure TfrmColorReplacer.btnPreviewClick(Sender: TObject);
var
   i,j: integer;
begin
Caption:='Color Replace (working)';
imgPreview.Picture.Bitmap.Assign(gbmp);
for i:=0 to (imgPreview.Width-1) do begin
                                    for j:=0 to (imgPreview.Height-1) do begin
                                                                         if imgPreview.Picture.Bitmap.Canvas.Pixels[i,j]=pkrColor.SelectionColor then imgPreview.Picture.Bitmap.Canvas.Pixels[i,j]:=pkrRColor.SelectionColor;
                                                                         end;
                                    end;
Caption:='Color Replace';
end;

procedure TfrmColorReplacer.imgPreviewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
pkrColor.SelectionColor:=imgPreview.Picture.Bitmap.Canvas.Pixels[X,Y];
end;

end.
