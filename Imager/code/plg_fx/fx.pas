unit fx;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, FxImage,
  c_const;

type
  TfrmFX = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    sbxPreview: TScrollBox;
    tbrAmount: TTrackBar;
    imgPreview: TImage;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBarChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  eff: TProEffectImage;
  frmFX: TfrmFX;
  bmp: TBitmap;
  canceled: boolean = true;
  effect: string = 'Gaussian Blur';

function FIPISfilter(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;
function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;

implementation

{$R *.DFM}

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL;
begin
	func(PT_FFILTER,'Gaussian Blur',' ');
	func(PT_FFILTER,'Split Blur',' ');
	func(PT_FFILTER,'Colour Noise',' ');
	func(PT_FFILTER,'Monochrome Noise',' ');
	func(PT_FFILTER,'Antialias',' ');
	func(PT_FFILTER,'Contrast',' ');
	//func(PT_FFILTER,'Fish Eye',' ');
	func(PT_FFILTER,'Lightness',' ');
	func(PT_FFILTER,'Darkness',' ');
	func(PT_FFILTER,'Saturation',' ');
	func(PT_FFILTER,'Mosaic',' ');
	//func(PT_FFILTER,'Twist',' ');
	func(PT_FFILTER,'Tile',' ');
	func(PT_FFILTER,'Emboss',' ');
	func(PT_FFILTER,'Solarize',' ');
	func(PT_FFILTER,'Posterize',' ');
	func(PT_FFILTER,'Grayscale',' ');
	Result:=true;
end;

function FIPISfilter(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap;
var
  local: TBitmap;
begin
// tuning form
Application.Handle:=app;

effect:=info;

// tuning bitmap
bmp:=TBitmap.Create();
bmp.Handle:=img;
bmp.PixelFormat:=pf24bit;
local:=TBitmap.Create();
local.Assign(local);
eff:=TProEffectImage.Create(nil);
eff.Picture.Assign(bmp);

// starting
frmFX:=TfrmFX.Create(Application);

if preview then
  begin
  if effect='Gaussian Blur' then eff.Effect_GaussianBlur(1)
  else if effect='Split Blur' then eff.Effect_SplitBlur(10)
  else if effect='Colour Noise' then eff.Effect_AddColorNoise(100)
  else if effect='Monochrome Noise' then eff.Effect_AddMonoNoise(100)
  else if effect='Antialias' then eff.Effect_AntiAlias()
  else if effect='Contrast' then eff.Effect_Contrast(150)
  else if effect='Fish Eye' then eff.Effect_FishEye(1)
  else if effect='Lightness' then eff.Effect_Lightness(100)
  else if effect='Darkness' then eff.Effect_Darkness(100)
  else if effect='Saturation' then eff.Effect_Saturation(64)
  else if effect='Mosaic' then eff.Effect_Mosaic(10)
  else if effect='Twist' then eff.Effect_Twist(101)
  else if effect='Tile' then eff.Effect_Tile(2)
  else if effect='Emboss' then eff.Effect_Emboss()
  else if effect='Solarize' then eff.Effect_Solorize(100)
  else if effect='Posterize' then eff.Effect_Posterize(50)
  else if effect='Grayscale' then eff.Effect_GrayScale();

  canceled:=false;
  bmp.Assign(eff.Picture.Bitmap);
  end
else
  begin
  if effect='Antialias' then
    begin
    eff.Effect_AntiAlias();
    canceled:=false;
    bmp.Assign(eff.Picture.Bitmap);
    end
  else if effect='Emboss' then
    begin
    eff.Effect_Emboss();
    canceled:=false;
    bmp.Assign(eff.Picture.Bitmap);
    end
  else if effect='Grayscale' then
    begin
    eff.Effect_GrayScale();
    canceled:=false;
    bmp.Assign(eff.Picture.Bitmap);
    end
  else
    begin
    frmFX.TrackBarChange(frmFX);
    frmFX.ShowModal();
    end;
  end;

FreeAndNil(frmFX);

// ending
if canceled then
  Result:=0
else
  begin
  local.Assign(bmp);
  Result:=local.ReleaseHandle();
  end;

FreeAndNil(bmp);
FreeAndNil(local);
FreeAndNil(eff);
end;


procedure TfrmFX.TrackBarChange(Sender: TObject);
begin
eff.Picture.Assign(bmp);

if effect='Gaussian Blur' then eff.Effect_GaussianBlur(tbrAmount.Position)
else if effect='Split Blur' then eff.Effect_SplitBlur(tbrAmount.Position)
else if effect='Colour Noise' then eff.Effect_AddColorNoise(tbrAmount.Position * 3)
else if effect='Monochrome Noise' then eff.Effect_AddMonoNoise(tbrAmount.Position * 3)
else if effect='Antialias' then eff.Effect_AntiAlias()
else if effect='Contrast' then eff.Effect_Contrast(tbrAmount.Position * 3)
else if effect='Fish Eye' then eff.Effect_FishEye(tbrAmount.Position div 10+1)
else if effect='Lightness' then eff.Effect_Lightness(tbrAmount.Position * 2)
else if effect='Darkness' then eff.Effect_Darkness(tbrAmount.Position * 2)
else if effect='Saturation' then eff.Effect_Saturation(255-((tbrAmount.Position * 255) div 100))
else if effect='Mosaic' then eff.Effect_Mosaic(tbrAmount.Position div 2)
else if effect='Twist' then eff.Effect_Twist(200-(tbrAmount.Position * 2)+1)
else if effect='Tile' then eff.Effect_Tile(tbrAmount.Position div 10)
else if effect='Emboss' then eff.Effect_Emboss()
else if effect='Solarize' then eff.Effect_Solorize(255-((tbrAmount.Position * 255) div 100))
else if effect='Posterize' then eff.Effect_Posterize(((tbrAmount.Position * 255) div 100)+1)
else if effect='Grayscale' then eff.Effect_GrayScale();

imgPreview.Picture.Assign(eff.Picture);
end;

procedure TfrmFX.btnCancelClick(Sender: TObject);
begin
Close();
end;

procedure TfrmFX.btnOKClick(Sender: TObject);
begin
canceled:=false;
bmp.Assign(imgPreview.Picture.Bitmap);
Close();
end;

procedure TfrmFX.FormCreate(Sender: TObject);
begin
Self.Caption:=effect;

// loading image
imgPreview.Picture.Bitmap.Assign(bmp);
end;

exports
  FIPISquery, FIPISfilter;

procedure TfrmFX.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=VK_ESCAPE then
  btnCancelClick(Self);
end;

end.
