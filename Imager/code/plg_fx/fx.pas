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

function FFilter(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap; cdecl;
function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; cdecl;

implementation

uses bright, color, size, rotate, crop;

{$R *.DFM}

function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL;
begin
    func(PT_FFILTER,'Resize',' ');
    func(PT_FFILTER,'Rotate',' ');
    func(PT_FFILTER,'Crop',' ');
    func(PT_FFILTER,'Colour Tweak',' ');
    func(PT_FFILTER,'Brightness',' ');
	func(PT_FFILTER,'Gaussian Blur',' ');
	func(PT_FFILTER,'Split Blur',' ');
	func(PT_FFILTER,'Colour Noise',' ');
	func(PT_FFILTER,'Monochrome Noise',' ');
	func(PT_FFILTER,'Antialias',' ');
	func(PT_FFILTER,'Contrast',' ');
	func(PT_FFILTER,'Lightness',' ');
	func(PT_FFILTER,'Darkness',' ');
	func(PT_FFILTER,'Saturation',' ');
	func(PT_FFILTER,'Mosaic',' ');
	func(PT_FFILTER,'Tile',' ');
	func(PT_FFILTER,'Emboss',' ');
	func(PT_FFILTER,'Solarize',' ');
	func(PT_FFILTER,'Posterize',' ');
	func(PT_FFILTER,'Grayscale',' ');
	Result:=true;
end;

function FFilter(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap;
var
  local: TBitmap;
  has_preview: boolean;
begin
// tuning defaults
Application.Handle := app;
effect := info;
has_preview := true;

// tuning bitmap
bmp := TBitmap.Create();
bmp.Handle := img;
bmp.PixelFormat := pf24bit;

// working
if preview then
  begin
  if effect='Gaussian Blur' then 
  	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_GaussianBlur(1);
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Resize' then
  	begin
    has_preview := false;
    end
  else if effect='Rotate' then
  	begin
    has_preview := false;
    end
  else if effect='Crop' then
  	begin
    has_preview := false;
    end
  else if effect='Colour Tweak' then
  	begin
    frmColor := TfrmColor.Create(Application);
  	frmColor.trbRed.Position:=128;
  	frmColor.TrackBarChange(frmColor);
  	bmp.Assign(frmColor.imgPreview.Picture.Bitmap);
    FreeAndNil(frmColor);
    end
  else if effect='Split Blur' then
  	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_SplitBlur(10);
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Colour Noise' then
  	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_AddColorNoise(100);
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Monochrome Noise' then
  	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_AddMonoNoise(100);
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Antialias' then
  	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_AntiAlias();
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Contrast' then
  	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_Contrast(150);
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Lightness' then
  	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_Lightness(100);
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Darkness' then
  	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_Darkness(100);
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Saturation' then
  	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_Saturation(64);
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Mosaic' then
  	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_Mosaic(10);
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Tile' then
  	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_Tile(2);
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Emboss' then
  	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_Emboss();
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Solarize' then
  	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_Solorize(100);
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Posterize' then
  	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_Posterize(50);
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Grayscale' then
  	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_GrayScale();
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Brightness' then
  	begin
    frmBrightness:=TfrmBrightness.Create(Application);
	frmBrightness.imgOrig.Picture.Bitmap.Assign(bmp);
	frmBrightness.imgMod.Picture.Bitmap.Assign(bmp);
   	frmBrightness.trbBrightness.Position:=128;
  	frmBrightness.trbBrightnessChange(frmBrightness);
  	bmp.Assign(frmBrightness.imgMod.Picture.Bitmap);
    FreeAndNil(frmBrightness);
	end;

  canceled := false;
  end
else
  begin
  if effect='Antialias' then
    begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_AntiAlias();
    canceled:=false;
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Resize' then
  	begin
  	// scale
  	scale := (bmp.Width / bmp.Height);

  	// starting
  	frmResize := TfrmResize.Create(Application);
  	frmResize.ShowModal();
  	FreeAndNil(frmResize);
    end
  else if effect='Rotate' then
  	begin
  	frmRotate := TfrmRotate.Create(Application);
  	frmRotate.ShowModal();
 	FreeAndNil(frmRotate);

  	bmp.PixelFormat:=pf24Bit;
    end
  else if effect='Crop' then
  	begin
  	frmCrop := TfrmCrop.Create(Application);
  	frmCrop.imgPreview.Picture.Bitmap.Assign(bmp);
  	frmCrop.ShowModal();
  	FreeAndNil(frmCrop);
    end
  else if effect='Colour Tweak' then
  	begin
    frmColor := TfrmColor.Create(Application);
    frmColor.ShowModal();
    FreeAndNil(frmColor);
    end
  else if effect='Emboss' then
	begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
	eff.Effect_Emboss();
	canceled:=false;
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Grayscale' then
    begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
    eff.Effect_GrayScale();
    canceled:=false;
    bmp.Assign(eff.Picture.Bitmap);
    FreeAndNil(eff);
    end
  else if effect='Brightness' then
    begin
    frmBrightness := TfrmBrightness.Create(Application);
	frmBrightness.imgOrig.Picture.Bitmap.Assign(bmp);
	frmBrightness.imgMod.Picture.Bitmap.Assign(bmp);
    frmBrightness.ShowModal();
    FreeAndNil(frmBrightness);
    end
  else
    begin
	eff := TProEffectImage.Create(nil);
	eff.Picture.Assign(bmp);
	frmFX:=TfrmFX.Create(Application);
    frmFX.TrackBarChange(frmFX);
    frmFX.ShowModal();
    FreeAndNil(frmFX);
    FreeAndNil(eff);
    end;
  end;

// ending
if canceled then
  Result := 0
else
  begin
  if ((preview = true) and (has_preview = false)) then
  	Result := 0
  else
  	begin
  	local := TBitmap.Create();
  	local.Assign(bmp);
  	Result := local.ReleaseHandle();
  	FreeAndNil(local);
  	end;
  end;

FreeAndNil(bmp);
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
else if effect='Lightness' then eff.Effect_Lightness(tbrAmount.Position * 2)
else if effect='Darkness' then eff.Effect_Darkness(tbrAmount.Position * 2)
else if effect='Saturation' then eff.Effect_Saturation(255-((tbrAmount.Position * 255) div 100))
else if effect='Mosaic' then eff.Effect_Mosaic(tbrAmount.Position div 2)
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

procedure TfrmFX.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=VK_ESCAPE then
  btnCancelClick(Self);
end;

exports
  FQuery, FFilter;

end.
