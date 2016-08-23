unit bright;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, c_const;

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

const
    MaxPixelCount   =  32768;

type
    pRGBArray  =  ^TRGBArray;
    TRGBArray  =  ARRAY[0..MaxPixelCount-1] OF TRGBTriple;

function Min(a, b: integer): integer;
function Max(a, b: integer): integer;


implementation

uses fx;

{$R *.DFM}

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
      end
    else
      begin
      // RGB values must be greater or equal than 0
      DestRow[j].rgbtRed := Max(0, OrigRow[j].rgbtRed + value);
      DestRow[j].rgbtGreen := Max(0, OrigRow[j].rgbtGreen + value);
      DestRow[j].rgbtBlue := Max(0, OrigRow[j].rgbtBlue + value);
      end;
    end;
  end;

  imgMod.Repaint();
end;

procedure TfrmBrightness.btnCancelClick(Sender: TObject);
begin
Close();
end;

procedure TfrmBrightness.btnOKClick(Sender: TObject);
begin
canceled := false;
bmp.Assign(imgMod.Picture.Bitmap);
Close();
end;

end.
