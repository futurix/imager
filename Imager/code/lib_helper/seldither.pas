unit seldither;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls,
  c_dither;

type
  TfrmDither = class(TForm)
    gbxColorReduction: TGroupBox;
    gbxDithering: TGroupBox;
    btnOK: TButton;
    rbnCRnone: TRadioButton;
    rbnCRwin20: TRadioButton;
    rbnCRwin256: TRadioButton;
    rbnCRwinGr: TRadioButton;
    rbnCRmono: TRadioButton;
    rbnCRgrayscale: TRadioButton;
    rbnCRnetscape: TRadioButton;
    rbnCRquant: TRadioButton;
    rbnCRquantWin: TRadioButton;
    rbnDNear: TRadioButton;
    rbnDfs: TRadioButton;
    rbnDsierra: TRadioButton;
    rbnDjajuni: TRadioButton;
    rbnDstucki: TRadioButton;
    rbnDstevearche: TRadioButton;
    rbnDburkes: TRadioButton;
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDither: TfrmDither;

function FHelpDitherOnDemand(bitmap: HBITMAP; clr: TColorReduction; dth: TDitherMode; app: THandle):HBITMAP; stdcall;
function FHelpDither(bitmap: HBITMAP; app, wnd: THandle):HBITMAP; stdcall;

implementation

{$R *.dfm}

function FHelpDitherOnDemand(bitmap: HBITMAP; clr: TColorReduction; dth: TDitherMode; app: THandle):HBITMAP;
var
  tmp, output: TBitmap;
begin
tmp:=TBitmap.Create();
tmp.Handle:=bitmap;
output:=ReduceColors(tmp,clr,dth,2,0);

Result:=output.ReleaseHandle();
FreeAndNil(output);
FreeAndNil(tmp);
end;

function FHelpDither(bitmap: HBITMAP; app, wnd: THandle):HBITMAP;
var
  clr: TColorReduction;
  dth: TDitherMode;
  tmp, output: TBitmap;
begin
Application.Handle:=app;
frmDither:=TfrmDither.Create(nil);
frmDither.ShowModal();

// setting color reduction
if frmDither.rbnCRnone.Checked then clr:=rmNone
  else if frmDither.rbnCRwin20.Checked then clr:=rmWindows20
  else if frmDither.rbnCRwin256.Checked then clr:=rmWindows256
  else if frmDither.rbnCRwinGr.Checked then clr:=rmWindowsGray
  else if frmDither.rbnCRmono.Checked then clr:=rmMonochrome
  else if frmDither.rbnCRgrayscale.Checked then clr:=rmGrayScale
  else if frmDither.rbnCRnetscape.Checked then clr:=rmNetscape
  else if frmDither.rbnCRquant.Checked then clr:=rmQuantize
  else if frmDither.rbnCRquantWin.Checked then clr:=rmQuantizeWindows
  else clr:=rmQuantize;
// setting dithering
if frmDither.rbnDNear.Checked then dth:=dmNearest
  else if frmDither.rbnDfs.Checked then dth:=dmFloydSteinberg
  else if frmDither.rbnDstucki.Checked then dth:=dmStucki
  else if frmDither.rbnDsierra.Checked then dth:=dmSierra
  else if frmDither.rbnDjajuni.Checked then dth:=dmJaJuNI
  else if frmDither.rbnDstevearche.Checked then dth:=dmSteveArche
  else if frmDither.rbnDburkes.Checked then dth:=dmBurkes
  else dth:=dmFloydSteinberg;

tmp:=TBitmap.Create();
tmp.Handle:=bitmap;
output:=ReduceColors(tmp,clr,dth,2,0);

Result:=output.ReleaseHandle();
FreeAndNil(output);
FreeAndNil(tmp);
FreeAndNil(frmDither);
end;

procedure TfrmDither.btnOKClick(Sender: TObject);
begin
Self.Close();
end;

procedure TfrmDither.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=VK_ESCAPE then
  Self.Close();
end;

end.
