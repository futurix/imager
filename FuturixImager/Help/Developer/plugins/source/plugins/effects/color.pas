unit color;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, c_const, c_locales;

type
  TfrmColor = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    trbRed: TTrackBar;
    trbGreen: TTrackBar;
    trbBlue: TTrackBar;
    lblValRed: TLabel;
    lblRed: TLabel;
    lblGreen: TLabel;
    lblBlue: TLabel;
    lblValGreen: TLabel;
    lblValBlue: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrackBarChange(Sender: TObject);
  private
    procedure Compute(var temp_bitmap: TBitmap);
  public
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  frmColor: TfrmColor;

const
  MaxPixelCount   =  32768;

type
  pRGBArray  =  ^TRGBArray;
  TRGBArray  =  array[0..MaxPixelCount-1] OF TRGBTriple;

function Min(a, b: integer): integer;
function Max(a, b: integer): integer;


implementation

uses fx;

{$R *.DFM}

procedure TfrmColor.TrackBarChange(Sender: TObject);
var
	preview_bitmap: TBitmap;
begin
	if (@preview_func = nil) then
    	Exit;

    preview_bitmap := TBitmap.Create();
    Compute(preview_bitmap);

    preview_func(preview_bitmap.ReleaseHandle());

    FreeAndNil(preview_bitmap);
end;

procedure TfrmColor.Compute(var temp_bitmap: TBitmap);
var
	i, j, RedValue, GreenValue, BlueValue: integer;
	OrigRow, DestRow: pRGBArray;
begin
	temp_bitmap.Assign(bmp);

	// get brightness increment value
	RedValue := trbRed.Position;
	GreenValue := trbGreen.Position;
	BlueValue := trbBlue.Position;

	if (RedValue <= 0) then
  		lblValRed.Caption := IntToStr(RedValue)
	else
  		lblValRed.Caption := Format('+%d',[RedValue]);

    if (GreenValue <= 0) then
  		lblValGreen.Caption:=IntToStr(GreenValue)
	else
  		lblValGreen.Caption:=Format('+%d',[GreenValue]);

	if BlueValue<=0 then
  		lblValBlue.Caption:=IntToStr(BlueValue)
	else
  		lblValBlue.Caption:=Format('+%d',[BlueValue]);

	// for each row of pixels
	for i := 0 to (bmp.Height - 1) do
  		begin
  		OrigRow := bmp.ScanLine[i];
  		DestRow := temp_bitmap.ScanLine[i];

  		// for each pixel in row
  		for j := 0 to (bmp.Width - 1) do
    		begin
    		// add brightness value to pixel's RGB values
    		if (RedValue > 0) then DestRow[j].rgbtRed:=Min(255,OrigRow[j].rgbtRed + RedValue) else DestRow[j].rgbtRed:=Max(0,OrigRow[j].rgbtRed + RedValue);
    		if (GreenValue > 0) then DestRow[j].rgbtGreen:=Min(255,OrigRow[j].rgbtGreen + GreenValue) else DestRow[j].rgbtGreen:=Max(0,OrigRow[j].rgbtGreen + GreenValue);
    		if (BlueValue > 0) then DestRow[j].rgbtBlue:=Min(255,OrigRow[j].rgbtBlue + BlueValue) else DestRow[j].rgbtBlue:=Max(0,OrigRow[j].rgbtBlue + BlueValue);
    		end;
  		end;
end;

function Min(a, b: integer): integer;
begin
	if (a < b) then
  		Result := a
	else
  		Result := b;
end;

function Max(a, b: integer): integer;
begin
	if (a > b) then
  		Result := a
	else
  		Result := b;
end;

procedure TfrmColor.btnCancelClick(Sender: TObject);
begin
	Close();
end;

procedure TfrmColor.btnOKClick(Sender: TObject);
var
	result_bitmap: TBitmap;
begin
	canceled := false;

    result_bitmap := TBitmap.Create();

    Compute(result_bitmap);
    bmp.Assign(result_bitmap);

    FreeAndNil(result_bitmap);

	Close();
end;

procedure TfrmColor.FormCreate(Sender: TObject);
begin
    Self.Caption		:= LoadLStr(3075);

    lblRed.Caption		:= LoadLStr(3076);
    lblGreen.Caption	:= LoadLStr(3077);
    lblBlue.Caption		:= LoadLStr(3078);

    btnOK.Caption		:= LoadLStr(50);
    btnCancel.Caption	:= LoadLStr(51);

	// loading image
	if (@preview_func <> nil) then
        preview_func(0);
end;

procedure TfrmColor.CreateParams(var Params: TCreateParams);
begin
	Params.Style := (Params.Style or WS_POPUP);

	inherited;

	if (Owner is TForm) then
		Params.WndParent := (Owner as TWinControl).Handle
	else if Assigned(Screen.ActiveForm) then
		Params.WndParent := Screen.ActiveForm.Handle;
end;

end.
