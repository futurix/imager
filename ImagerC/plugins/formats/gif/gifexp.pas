unit gifexp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Registry, gifimage;

type
  TfrmGIFExport = class(TForm)
    pclGExport: TPageControl;
    shtSettings: TTabSheet;
    shtPreview: TTabSheet;
    btnCancel: TButton;
    btnOK: TButton;
    lblFileSize: TLabel;
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

const
     sReg = '\Software\Futuris\ImagerC';
     sFIPIS = '\Software\Futuris\FIPIS';
     sName = 'Futuris Imager';

var
  frmGIFExport: TfrmGIFExport;
  reg: TRegistry;
  bmp: TBitmap;
  tmp: string;

function FIPISexport(info: PChar; app: THandle; img: hBitmap):integer; stdcall;

implementation

{$R *.DFM}

function FIPISexport(info: PChar; app: THandle; img: hBitmap):integer;
begin
Application.Handle:=app;
bmp:=TBitmap.Create();
bmp.Handle:=img;
reg:=TRegistry.Create();
reg.RootKey:=HKEY_CURRENT_USER;
reg.OpenKey(sReg + '\Paths',true);
tmp:=reg.ReadString('Directory');
tmp:=tmp + 'temp\gif.tmp';
reg.CloseKey();
reg.Free();
// form
frmGIFExport:=TfrmGIFExport.Create(Application);
frmGIFExport.imgPreview.Picture.Bitmap.Assign(bmp);
frmGIFExport.Optimise();
frmGIFExport.ShowModal();
// cleaning
frmGIFExport.Free();
bmp.Free();
DeleteFile(tmp);
Result:=1;
end;

procedure TfrmGIFExport.Optimise();
var
   gif: TGifImage;
   clr: TColorReduction;
   dth: TDitherMode;
   fl: HWND;
   size: Longword;
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
gif.SaveToFile(tmp);
gif.LoadFromFile(tmp);
// previewing
imgPreview.Picture.Bitmap.Width:=gif.Width;
imgPreview.Picture.Bitmap.Height:=gif.Height;
imgPreview.Picture.Bitmap.Canvas.Draw(0,0,gif);
// calculating file size
fl:=CreateFile(PChar(tmp),GENERIC_READ,FILE_SHARE_READ + FILE_SHARE_WRITE,nil,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
size:=GetFileSize(fl,@size);
CloseHandle(fl);
lblFileSize.Caption:='File size: ' + IntToStr(size) + ' bytes';
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
if dlgGSave.Execute then if not FileExists(dlgGSave.FileName) then gif.SaveToFile(dlgGSave.FileName);
// freeing and closing
gif.Free();
Close();
end;

procedure TfrmGIFExport.shtPreviewShow(Sender: TObject);
begin
Optimise();
end;

end.
