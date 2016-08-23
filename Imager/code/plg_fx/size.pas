unit size;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, c_const, futuris_resample, ExtCtrls;

type
  TfrmResize = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    cbxMethod: TComboBox;
    edtWidth: TEdit;
    edtHeight: TEdit;
    lblHeight: TLabel;
    lblWidth: TLabel;
    lblMethod: TLabel;
    bvlSep: TBevel;
    cbxProp: TCheckBox;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtWidthChange(Sender: TObject);
    procedure edtHeightChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmResize: TfrmResize;
  no_change: boolean = true;
  scale: double = 1.0;


implementation

uses fx;

{$R *.DFM}

procedure TfrmResize.btnCancelClick(Sender: TObject);
begin
Close();
end;

procedure TfrmResize.btnOKClick(Sender: TObject);
var
  new_w,new_h: integer;
  flt: TResamplingFilter;
begin
canceled:=false;
flt:=sfBell;
try
  new_w:=StrToInt(edtWidth.Text);
  new_h:=StrToInt(edtHeight.Text);
  except
  on EConvertError do
    begin
    ShowMessage('You need to input valid numerals!');
    Exit;
    end;
  else Exit;
  end;
case cbxMethod.ItemIndex of
  0: flt:=sfBox;
  1: flt:=sfTriangle;
  2: flt:=sfHermite;
  3: flt:=sfBell;
  4: flt:=sfSpline;
  5: flt:=sfLanczos3;
  6: flt:=sfMitchell;
end;
Stretch(new_w,new_h,flt,0,bmp);
Close();
end;

procedure TfrmResize.FormCreate(Sender: TObject);
begin
    no_change := true;

	edtWidth.Text := IntToStr(bmp.Width);
	edtHeight.Text := IntToStr(bmp.Height);
	cbxMethod.ItemIndex := 3;

    no_change := false;
end;

procedure TfrmResize.edtWidthChange(Sender: TObject);
var
  	temp_value: integer;
begin
	try
        if ((Trim(edtWidth.Text) = '') or no_change) then
        	Exit;

  		temp_value := StrToInt(edtWidth.Text);
	except
  		on EConvertError do
    		begin
    		ShowMessage('You need to input valid numeral!');
    		Exit;
    		end;
  		else
        	Exit;
  	end;

    if (cbxProp.Checked and (scale > 0.0) and (temp_value <> 0)) then
    	begin
        no_change := true;
        edtHeight.Text := IntToStr(Round(temp_value / scale));
        no_change := false;
        end;
end;

procedure TfrmResize.edtHeightChange(Sender: TObject);
var
  	temp_value: integer;
begin
	try
        if ((Trim(edtHeight.Text) = '') or no_change) then
        	Exit;

  		temp_value := StrToInt(edtHeight.Text);
	except
  		on EConvertError do
    		begin
    		ShowMessage('You need to input valid numeral!');
    		Exit;
    		end;
  		else
        	Exit;
  	end;

    if (cbxProp.Checked and (scale > 0.0) and (temp_value <> 0)) then
    	begin
        no_change := true;
        edtWidth.Text := IntToStr(Round(temp_value * scale));
        no_change := false;
        end;
end;

end.
