unit bright;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls;

type
  TfrmBrightness = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    gbxBrightness: TGroupBox;
    trbBrightness: TTrackBar;
    sbxOrig: TScrollBox;
    sbxMod: TScrollBox;
    lblOriginal: TLabel;
    lblModified: TLabel;
    imgOrig: TImage;
    imgMod: TImage;
    lblValue: TLabel;
    procedure trbBrightnessChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBrightness: TfrmBrightness;
  bmp: TBitmap;
  cancelled: boolean = true;

const
    MaxPixelCount   =  32768;

type
    pRGBArray  =  ^TRGBArray;
    TRGBArray  =  ARRAY[0..MaxPixelCount-1] OF TRGBTriple;

function Min(a, b: integer): integer;
function Max(a, b: integer): integer;
function FIPISfilter(info: PChar; app: THandle; img: hBitmap):hBitmap; stdcall;

implementation

{$R *.DFM}

function FIPISfilter(info: PChar; app: THandle; img: hBitmap):hBitmap;
var
   lbmp: TBitmap;
begin
// tuning internals
Application.Handle:=app;
frmBrightness:=TfrmBrightness.Create(Application);
bmp:=TBitmap.Create();
bmp.Handle:=img;
frmBrightness.imgOrig.Picture.Bitmap.Assign(bmp);
frmBrightness.imgMod.Picture.Bitmap.Assign(bmp);
frmBrightness.ShowModal();
// sending result
if not cancelled then begin
                      lbmp:=TBitmap.Create();
                      lbmp.Assign(bmp);
                      Result:=lbmp.ReleaseHandle();
                      lbmp.Free();
                      end
else Result:=0;
bmp.Free();
frmBrightness.Free();
end;

function Min(a, b: integer): integer;
begin
  if a < b then result := a
  else result := b;
end;

function Max(a, b: integer): integer;
begin
  if a > b then result := a
  else result := b;
end;

procedure TfrmBrightness.trbBrightnessChange(Sender: TObject);
var
   i, j, value: integer;
   OrigRow, DestRow: pRGBArray;
begin
lblValue.Caption:=IntToStr(trbBrightness.Position);
// get brightness increment value
value:=trbBrightness.Position;

for i := 0 to imgOrig.Picture.Height - 1 do
  begin
    OrigRow := imgOrig.Picture.Bitmap.ScanLine[i];
    DestRow := imgMod.Picture.Bitmap.ScanLine[i];

    for j := 0 to imgOrig.Picture.Width - 1 do
    begin
        // add brightness value to pixel's RGB values
      if value > 0 then
      begin
          // RGB values must be less than 256
        DestRow[j].rgbtRed := Min(255, OrigRow[j].rgbtRed + value);
        DestRow[j].rgbtGreen := Min(255, OrigRow[j].rgbtGreen + value);
        DestRow[j].rgbtBlue := Min(255, OrigRow[j].rgbtBlue + value);
      end else begin
          // RGB values must be greater or equal than 0
        DestRow[j].rgbtRed := Max(0, OrigRow[j].rgbtRed + value);
        DestRow[j].rgbtGreen := Max(0, OrigRow[j].rgbtGreen + value);
        DestRow[j].rgbtBlue := Max(0, OrigRow[j].rgbtBlue + value);
      end;
    end;
  end;

  imgMod.Repaint;
end;

procedure TfrmBrightness.btnCancelClick(Sender: TObject);
begin
Close();
end;

procedure TfrmBrightness.btnOKClick(Sender: TObject);
begin
cancelled:=false;
bmp.Assign(imgMod.Picture.Bitmap);
Close();
end;

end.