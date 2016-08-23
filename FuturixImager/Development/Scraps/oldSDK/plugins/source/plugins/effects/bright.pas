unit bright;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, c_const, c_locales;

type
  TfrmBrightness = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    gbxBrightness: TGroupBox;
    trbBrightness: TTrackBar;
    lblValue: TLabel;
    procedure trbBrightnessChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure Compute(var modified_bitmap: TBitmap);
  public
    procedure CreateParams(var Params: TCreateParams); override;
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
	modified_bitmap: TBitmap;
begin
    if (@preview_func = nil) then
    	Exit;

	lblValue.Caption:=IntToStr(trbBrightness.Position);

    modified_bitmap := TBitmap.Create();

    Compute(modified_bitmap);

	preview_func(modified_bitmap.ReleaseHandle());
    FreeAndNil(modified_bitmap);
end;

procedure TfrmBrightness.Compute(var modified_bitmap: TBitmap);
var
	i, j, value: integer;
	OrigRow, DestRow: pRGBArray;
begin
	lblValue.Caption:=IntToStr(trbBrightness.Position);

	// get brightness increment value
	value := trbBrightness.Position;

    modified_bitmap.Assign(bmp);

	for i := 0 to (bmp.Height - 1) do
  		begin
  		OrigRow := bmp.ScanLine[i];
  		DestRow := modified_bitmap.ScanLine[i];

  		for j := 0 to (bmp.Width - 1) do
    		begin
    		// add brightness value to pixel's RGB values
    		if (value > 0) then
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
end;

procedure TfrmBrightness.btnCancelClick(Sender: TObject);
begin
	Close();
end;

procedure TfrmBrightness.btnOKClick(Sender: TObject);
var
	final_bitmap: TBitmap;
begin
	canceled := false;

    final_bitmap := TBitmap.Create();

    Compute(final_bitmap);
	bmp.Assign(final_bitmap);

    FreeAndNil(final_bitmap);

	Close();
end;

procedure TfrmBrightness.FormCreate(Sender: TObject);
begin
    Self.Caption			:= LoadLStr(3070);

    gbxBrightness.Caption	:= LoadLStr(3071);

    btnOK.Caption			:= LoadLStr(50);
    btnCancel.Caption		:= LoadLStr(51);

    if (@preview_func <> nil) then
    	preview_func(0);
end;

procedure TfrmBrightness.CreateParams(var Params: TCreateParams);
begin
	Params.Style := (Params.Style or WS_POPUP);

	inherited;

	if (Owner is TForm) then
		Params.WndParent := (Owner as TWinControl).Handle
	else if Assigned(Screen.ActiveForm) then
		Params.WndParent := Screen.ActiveForm.Handle;
end;

end.
