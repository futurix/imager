unit fx;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, FxImage, c_const, c_locales;

type
  TfrmFX = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    tbrAmount: TTrackBar;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBarChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  eff: TProEffectImage;
  frmFX: TfrmFX;
  bmp: TBitmap;
  canceled: boolean = true;
  effect: string = '';
  preview_func: TPreviewCallBack = nil;

function FxImgQuery(plugin_path: PChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
function FxImgFilter(info: PChar; img: HBITMAP; preview_call: TPreviewCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;


implementation

uses bright, color;

{$R *.DFM}

function FxImgQuery(plugin_path: PChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult;
var
	temp_res: TFxImgResult;
begin
    Result.result_type := RT_BOOL;
    Result.result_value := FX_TRUE;

    if (@app_query <> nil) then
        begin
    	temp_res := app_query(CQ_GETLANGLIBS, 0, 0);

        if (temp_res.result_type = RT_HANDLE) then
        	begin
            locale_lib := temp_res.result_value;
            backup_lib := temp_res.result_xtra;
            end;
        end;

    info_call(PT_FNAME, 'Various Filters Plug-in', '');

    info_call(PT_FFILTER, PChar(LoadLStr(3050)), '');
    info_call(PT_FFILTER, PChar(LoadLStr(3051)), '');
	info_call(PT_FFILTER, PChar(LoadLStr(3052)), '');
	info_call(PT_FFILTER, PChar(LoadLStr(3053)), '');
	info_call(PT_FFILTER, PChar(LoadLStr(3054)), '');
	info_call(PT_FFILTER, PChar(LoadLStr(3055)), '');
	info_call(PT_FFILTER, PChar(LoadLStr(3056)), '');
	info_call(PT_FFILTER, PChar(LoadLStr(3059)), '');
	info_call(PT_FFILTER, PChar(LoadLStr(3060)), '');
	info_call(PT_FFILTER, PChar(LoadLStr(3061)), '');
	info_call(PT_FFILTER, PChar(LoadLStr(3062)), '');
	info_call(PT_FFILTER, PChar(LoadLStr(3063)), '');
	info_call(PT_FFILTER, PChar(LoadLStr(3064)), '');
end;

function FxImgFilter(info: PChar; img: HBITMAP; preview_call: TPreviewCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult;
var
	temp_res: TFxImgResult;
	local: TBitmap;
begin
    Result.result_type := RT_HBITMAP;
    Result.result_value := 0;

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

    preview_func := preview_call;
	effect := info;

    if (effect = '') then
    	effect := LoadLStr(3052);

	// tuning bitmap
	bmp := TBitmap.Create();
	bmp.Handle := img;
	bmp.PixelFormat := pf24bit;

	// working
	if (effect = LoadLStr(3055)) then
		begin
		eff := TProEffectImage.Create(nil);
		eff.Picture.Assign(bmp);
    	eff.Effect_AntiAlias();
    	canceled := false;
    	bmp.Assign(eff.Picture.Bitmap);
    	FreeAndNil(eff);
    	end
	else if (effect = LoadLStr(3050)) then
  		begin
    	frmColor := TfrmColor.Create(Application);
    	frmColor.ShowModal();
    	FreeAndNil(frmColor);
    	end
	else if (effect = LoadLStr(3062)) then
		begin
		eff := TProEffectImage.Create(nil);
		eff.Picture.Assign(bmp);
		eff.Effect_Emboss();
		canceled := false;
    	bmp.Assign(eff.Picture.Bitmap);
    	FreeAndNil(eff);
    	end
    else if (effect = LoadLStr(3051)) then
    	begin
    	frmBrightness := TfrmBrightness.Create(Application);
    	frmBrightness.ShowModal();
    	FreeAndNil(frmBrightness);
    	end
	else
    	begin
		eff := TProEffectImage.Create(nil);
		eff.Picture.Assign(bmp);
		frmFX := TfrmFX.Create(Application);

        if (effect=LoadLStr(3056)) then
        	frmFX.tbrAmount.Position := 50;

    	frmFX.TrackBarChange(frmFX);
    	frmFX.ShowModal();
    	FreeAndNil(frmFX);
    	FreeAndNil(eff);
    	end;

	// ending
	if canceled then
  		Result.result_value := 0
	else
  		begin
        local := TBitmap.Create();
        local.Assign(bmp);
        Result.result_value := local.ReleaseHandle();
        FreeAndNil(local);
  		end;

	FreeAndNil(bmp);
end;


procedure TfrmFX.TrackBarChange(Sender: TObject);
var
	tmp_bitmap: TBitmap;
begin
	eff.Picture.Assign(bmp);

	if effect=LoadLStr(3052) then eff.Effect_GaussianBlur(tbrAmount.Position)
	else if effect=LoadLStr(3053) then eff.Effect_SplitBlur(tbrAmount.Position)
	else if effect=LoadLStr(3054) then eff.Effect_AddColorNoise(tbrAmount.Position * 3)
	else if effect=LoadLStr(3055) then eff.Effect_AntiAlias()
	else if effect=LoadLStr(3056) then
        begin
        if (tbrAmount.Position > 50) then
        	begin
            // positive
            eff.Effect_Contrast(((tbrAmount.Position - 50) * 2) * 3);
            end
        else if (tbrAmount.Position = 50) then
        	begin
            // zero
            eff.Effect_Contrast(0);
            end
        else
        	begin
            // negative
            eff.Effect_Contrast(((tbrAmount.Position * 2) - 100) * 3);
			end;
        end
	else if effect=LoadLStr(3059) then eff.Effect_Saturation(255-((tbrAmount.Position * 255) div 100))
	else if effect=LoadLStr(3060) then eff.Effect_Mosaic(tbrAmount.Position div 2)
	else if effect=LoadLStr(3061) then eff.Effect_Tile(tbrAmount.Position div 10)
	else if effect=LoadLStr(3062) then eff.Effect_Emboss()
	else if effect=LoadLStr(3063) then eff.Effect_Solorize(255-((tbrAmount.Position * 255) div 100))
	else if effect=LoadLStr(3064) then eff.Effect_Posterize(((tbrAmount.Position * 255) div 100)+1);

    if (@preview_func <> nil) then
    	begin
    	tmp_bitmap := TBitmap.Create();
    	tmp_bitmap.Assign(eff.Picture);

        preview_func(tmp_bitmap.ReleaseHandle());

        FreeAndNil(tmp_bitmap);
    	end;
end;

procedure TfrmFX.btnCancelClick(Sender: TObject);
begin
	Close();
end;

procedure TfrmFX.btnOKClick(Sender: TObject);
begin
	canceled := false;

	bmp.Assign(eff.Picture);

	Close();
end;

procedure TfrmFX.FormCreate(Sender: TObject);
begin
	Self.Caption 		:= effect;

    btnOK.Caption		:= LoadLStr(50);
    btnCancel.Caption	:= LoadLStr(51);

    if (@preview_func <> nil) then
    	preview_func(0);
end;

procedure TfrmFX.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if (Key = VK_ESCAPE) then
  		btnCancelClick(Self);
end;

procedure TfrmFX.CreateParams(var Params: TCreateParams);
begin
	Params.Style := (Params.Style or WS_POPUP);

	inherited;

	if (Owner is TForm) then
		Params.WndParent := (Owner as TWinControl).Handle
	else if Assigned(Screen.ActiveForm) then
		Params.WndParent := Screen.ActiveForm.Handle;
end;

exports
	FxImgQuery, FxImgFilter;

end.
