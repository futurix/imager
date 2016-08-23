unit gifexp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, gifimage, c_const, c_locales;

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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGIFExport: TfrmGIFExport;
  bmp: TBitmap;

function FxImgExport(info: PChar; img: HBITMAP; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;


implementation

{$R *.DFM}

function FxImgExport(info: PChar; img: HBITMAP; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult;
var
	temp_res: TFxImgResult;
begin
    Result.result_type := RT_BOOL;
    Result.result_value := FX_TRUE;

	Application.Handle := app;

    if (@app_query <> nil) then
        begin
    	temp_res := app_query(CQ_GETLANGLIBS, 0, 0);

        if (temp_res.result_type = RT_HANDLE) then
        	begin
            locale_lib := temp_res.result_value;
            backup_lib := temp_res.result_xtra;
            end;
        end;

	bmp := TBitmap.Create();
	bmp.Handle := img;

	// form
	frmGIFExport := TfrmGIFExport.Create(Application);
    frmGIFExport.imgPreview.Picture.Bitmap.Assign(bmp);
	frmGIFExport.Optimise();
	frmGIFExport.ShowModal();

	// cleaning
	FreeAndNil(frmGIFExport);
	FreeAndNil(bmp);
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

procedure TfrmGIFExport.FormCreate(Sender: TObject);
begin
	Self.Caption				:= LoadLStr(3021);

    btnOK.Caption				:= LoadLStr(50);
    btnCancel.Caption			:= LoadLStr(51);

    shtSettings.Caption			:= LoadLStr(3022);
    shtPreview.Caption			:= LoadLStr(3023);

    gbxColorReduction.Caption	:= LoadLStr(3024);

    rbnNone.Caption				:= LoadLStr(3025);
    rbnWindows20.Caption		:= LoadLStr(3026);
    rbnWindows256.Caption		:= LoadLStr(3027);
    rbnWindowsGray.Caption		:= LoadLStr(3028);
    rbnMonochrome.Caption		:= LoadLStr(3029);
    rbnGrayScale.Caption		:= LoadLStr(3030);
    rbnNetscape.Caption			:= LoadLStr(3031);
    rbnQuantizeWindows.Caption	:= LoadLStr(3032);

    gbxDither.Caption			:= LoadLStr(3033);

    rbnNearest.Caption			:= LoadLStr(3034);
    rbnFloydSteinberg.Caption	:= LoadLStr(3035);
    rbnStucki.Caption			:= LoadLStr(3036);
    rbnSierra.Caption			:= LoadLStr(3037);
    rbnJaJuNI.Caption			:= LoadLStr(3038);
    rbnStevArche.Caption		:= LoadLStr(3039);
    rbnBurkes.Caption			:= LoadLStr(3040);

    dlgGSave.Title				:= LoadLStr(3041);
    dlgGSave.Filter				:= LoadLStr(1002) + ' (*.gif)|*.gif';
end;

end.
