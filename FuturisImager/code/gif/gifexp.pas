unit gifexp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, gifimage, c_const;

type
  TfrmGIFExport = class(TForm)
    pclGExport: TPageControl;
    shtSettings: TTabSheet;
    shtPreview: TTabSheet;
    btnCancel: TButton;
    btnOK: TButton;
    gbxColorReduction: TGroupBox;
    gbxDither: TGroupBox;
    sbxPreview: TScrollBox;
    imgPreview: TImage;
    rbnNearest: TRadioButton;
    rbnFloydSteinberg: TRadioButton;
    rbnStucki: TRadioButton;
    rbnSierra: TRadioButton;
    rbnJaJuNI: TRadioButton;
    rbnStevArche: TRadioButton;
    rbnBurkes: TRadioButton;
    rbnNone: TRadioButton;
    rbnWindows20: TRadioButton;
    rbnWindows256: TRadioButton;
    rbnWindowsGray: TRadioButton;
    rbnMonochrome: TRadioButton;
    rbnGrayScale: TRadioButton;
    rbnNetscape: TRadioButton;
    rbnQuantizeWindows: TRadioButton;
    dlgGSave: TSaveDialog;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure Optimise();
    procedure shtPreviewShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGIFExport: TfrmGIFExport;
  bmp: TBitmap;

function FIPISexport(info: PChar; app, wnd: THandle; img: hBitmap):integer; stdcall;

implementation

{$R *.DFM}

function FIPISexport(info: PChar; app, wnd: THandle; img: hBitmap):integer;
begin
Application.Handle:=app;
bmp:=TBitmap.Create();
bmp.Handle:=img;

// form
frmGIFExport:=TfrmGIFExport.Create(Application);
frmGIFExport.imgPreview.Picture.Bitmap.Assign(bmp);
frmGIFExport.Optimise();
frmGIFExport.ShowModal();

// cleaning
frmGIFExport.Free();
bmp.Free();
Result:=1;
end;

procedure TfrmGIFExport.Optimise();
var
   gif: TGifImage;
   clr: TColorReduction;
   dth: TDitherMode;
   tbmp: TBitmap;
begin
// setting color reduction
if rbnNone.Checked then clr:=rmNone
  else if rbnWindows20.Checked then clr:=rmWindows20
  else if rbnWindows256.Checked then clr:=rmWindows256
  else if rbnWindowsGray.Checked then clr:=rmWindowsGray
  else if rbnMonochrome.Checked then clr:=rmMonochrome
  else if rbnGrayScale.Checked then clr:=rmGrayScale
  else if rbnNetscape.Checked then clr:=rmNetscape
  else if rbnQuantizeWindows.Checked then clr:=rmQuantizeWindows
  else clr:=rmQuantizeWindows;

// setting dithering
if rbnNearest.Checked then dth:=dmNearest
  else if rbnFloydSteinberg.Checked then dth:=dmFloydSteinberg
  else if rbnStucki.Checked then dth:=dmStucki
  else if rbnSierra.Checked then dth:=dmSierra
  else if rbnJaJuNI.Checked then dth:=dmJaJuNI
  else if rbnStevArche.Checked then dth:=dmSteveArche
  else if rbnBurkes.Checked then dth:=dmBurkes
  else dth:=dmFloydSteinberg;

// creating and preoptimising
gif:=TGifImage.Create();
tbmp:=TBitmap.Create();
tbmp.Assign(ReduceColors(bmp,clr,dth,2,0));
gif.Add(tbmp);
tbmp.Free();

// optimising
gif.Optimize([ooCrop, ooMerge, ooCleanup, ooColorMap],clr,dth,2);
gif.OptimizeColorMap();

// previewing
imgPreview.Picture.Bitmap.Width:=gif.Width;
imgPreview.Picture.Bitmap.Height:=gif.Height;
imgPreview.Picture.Bitmap.Canvas.Draw(0,0,gif);

// freeing
gif.Free();
end;

procedure TfrmGIFExport.btnCancelClick(Sender: TObject);
begin
Close();
end;

procedure TfrmGIFExport.btnOKClick(Sender: TObject);
var
  gif: TGifImage;
  clr: TColorReduction;
  dth: TDitherMode;
  tbmp: TBitmap;
begin
// setting color reduction
if rbnNone.Checked then clr:=rmNone
  else if rbnWindows20.Checked then clr:=rmWindows20
  else if rbnWindows256.Checked then clr:=rmWindows256
  else if rbnWindowsGray.Checked then clr:=rmWindowsGray
  else if rbnMonochrome.Checked then clr:=rmMonochrome
  else if rbnGrayScale.Checked then clr:=rmGrayScale
  else if rbnNetscape.Checked then clr:=rmNetscape
  else if rbnQuantizeWindows.Checked then clr:=rmQuantizeWindows
  else clr:=rmQuantizeWindows;

// setting dithering
if rbnNearest.Checked then dth:=dmNearest
  else if rbnFloydSteinberg.Checked then dth:=dmFloydSteinberg
  else if rbnStucki.Checked then dth:=dmStucki
  else if rbnSierra.Checked then dth:=dmSierra
  else if rbnJaJuNI.Checked then dth:=dmJaJuNI
  else if rbnStevArche.Checked then dth:=dmSteveArche
  else if rbnBurkes.Checked then dth:=dmBurkes
  else dth:=dmFloydSteinberg;

// creating and preoptimising
gif:=TGifImage.Create();
tbmp:=TBitmap.Create();
tbmp.Assign(ReduceColors(bmp,clr,dth,2,0));
gif.Add(tbmp);
tbmp.Free();

// optimising
gif.Optimize([ooCrop, ooMerge, ooCleanup, ooColorMap],clr,dth,2);
gif.OptimizeColorMap();

// working
if dlgGSave.Execute then
  if not FileExists(dlgGSave.FileName) then
    gif.SaveToFile(dlgGSave.FileName);

// freeing and closing
gif.Free();
Close();
end;

procedure TfrmGIFExport.shtPreviewShow(Sender: TObject);
begin
Optimise();
end;

end.
