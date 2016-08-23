unit w_resize;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, hyiedefs,
  c_const, c_reg;

type
  TfrmResize = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    lblWidth: TLabel;
    lblHeight: TLabel;
    edtSizeW: TEdit;
    edtSizeH: TEdit;
    lblPercent: TLabel;
    cbxProportions: TCheckBox;
    edtScaleW: TEdit;
    edtScaleH: TEdit;
    lblMethod: TLabel;
    cmbQuality: TComboBox;
    lblPixels: TLabel;
    pclType: TPageControl;
    shtSize: TTabSheet;
    shtScale: TTabSheet;
    lblWidthS: TLabel;
    lblHeightS: TLabel;
    shtMethod: TTabSheet;
    updSizeW: TUpDown;
    updSizeH: TUpDown;
    updScaleW: TUpDown;
    updScaleH: TUpDown;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtSizeWChange(Sender: TObject);
    procedure edtSizeHChange(Sender: TObject);
    procedure edtScaleWChange(Sender: TObject);
    procedure edtScaleHChange(Sender: TObject);
    procedure updSizeWChangingEx(Sender: TObject; var AllowChange: Boolean; NewValue: Smallint; Direction: TUpDownDirection);
    procedure updSizeHChangingEx(Sender: TObject; var AllowChange: Boolean; NewValue: Smallint; Direction: TUpDownDirection);
    procedure updScaleWChangingEx(Sender: TObject; var AllowChange: Boolean; NewValue: Smallint; Direction: TUpDownDirection);
    procedure updScaleHChangingEx(Sender: TObject; var AllowChange: Boolean; NewValue: Smallint; Direction: TUpDownDirection);
  private
    no_change: boolean;
  public
    orig_width: integer;
    orig_height: integer;
    xy_scale: double;
  end;

var
  frmResize: TfrmResize;


implementation

uses w_editor, w_main;

{$R *.dfm}

procedure TfrmResize.FormCreate(Sender: TObject);
begin
  orig_width := 100;
  orig_height := 100;
  xy_scale := 1.0;
  no_change := true;

  cmbQuality.ItemIndex := FxRegRInt('Resize_Method', 0);
  cbxProportions.Checked := FxRegRBool('Resize_SaveProportions', true);

  if Assigned(frmEditor) then
    begin
    edtSizeW.Text := IntToStr(frmEditor.img.IEBitmap.Width);
    edtSizeH.Text := IntToStr(frmEditor.img.IEBitmap.Height);
    edtScaleW.Text := '100';
    edtScaleH.Text := '100';

    orig_width := frmEditor.img.IEBitmap.Width;
    orig_height := frmEditor.img.IEBitmap.Height;
    xy_scale := (orig_width / orig_height);

    no_change := false;
    end
  else
    ShowMessage('Resize impossible - no editor window open.');
end;

procedure TfrmResize.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmResize.FormDestroy(Sender: TObject);
begin
  frmResize := nil;
end;

procedure TfrmResize.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    Self.Close();
end;

procedure TfrmResize.btnOKClick(Sender: TObject);
var
  new_width, new_height, temp_w, temp_h: integer;
  about_signal: boolean;
  filter: TResampleFilter;
begin
  // saving settings
  FxRegWInt('Resize_Method', cmbQuality.ItemIndex);
  FxRegWBool('Resize_SaveProportions', cbxProportions.Checked);

  // working
  about_signal := true;
  new_width := 0;
  new_height := 0;
    
  if Assigned(frmEditor) then
    begin
    if ((pclType.ActivePage = shtSize) or (pclType.ActivePage = shtMethod)) then
      begin
      // resize by pixels
      try
        temp_w := StrToInt(edtSizeW.Text);
        temp_h := StrToInt(edtSizeH.Text);
      except
        temp_w := 0;
        temp_h := 0;
      end;

      if ((temp_w > 0) and (temp_h > 0)) then
        begin
        new_width := temp_w;
        new_height := temp_h;
        end;
      end
    else
      begin
      // resize by percentage
      try
        temp_w := StrToInt(edtScaleW.Text);
        temp_h := StrToInt(edtScaleH.Text);
      except
        temp_w := 0;
        temp_h := 0;
      end;

      if ((temp_w > 0) and (temp_h > 0)) then
        begin
        new_width := Round(orig_width * (temp_w / 100));
        new_height := Round(orig_height * (temp_h / 100));
        end;
      end;

    if ((new_width > 0) and (new_height > 0)) then
      begin
      case cmbQuality.ItemIndex of
        0: filter := rfBicubic;
        1: filter := rfBilinear;
        2: filter := rfFastLinear;
        3: filter := rfLinear;
        4: filter := rfNearest;
        5: filter := rfMitchell;
        6: filter := rfLanczos3;
        7: filter := rfBSpline;
        8: filter := rfBell;
        9: filter := rfHermite;
        10: filter := rfTriangle;
        11: filter := rfNone;
        else
          filter := rfBicubic;
      end;

      frmEditor.proc.Resample(new_width, new_height, filter);
      frmEditor.proc.ClearAllRedo();

      about_signal := false;
      end;
    end;

  if not about_signal then
    Self.Close();
end;

procedure TfrmResize.btnCancelClick(Sender: TObject);
begin
  Self.Close();
end;

procedure TfrmResize.edtSizeWChange(Sender: TObject);
var
  tmp_value: integer;
begin
  if no_change then
    Exit;
        
  try
    tmp_value := StrToInt(edtSizeW.Text);
  except
    tmp_value := 0;
  end;

  if ((tmp_value > 0) and cbxProportions.Checked) then
    begin
    no_change := true;
    edtSizeH.Text := IntToStr(Round(tmp_value / xy_scale));
    no_change := false;
    end;
end;

procedure TfrmResize.edtSizeHChange(Sender: TObject);
var
  tmp_value: integer;
begin
  if no_change then
    Exit;

  try
    tmp_value := StrToInt(edtSizeH.Text);
  except
    tmp_value := 0;
  end;

  if ((tmp_value > 0) and cbxProportions.Checked) then
    begin
    no_change := true;
    edtSizeW.Text := IntToStr(Round(tmp_value * xy_scale));
    no_change := false;
    end;
end;

procedure TfrmResize.edtScaleWChange(Sender: TObject);
var
  tmp_value: integer;
begin
  if no_change then
    Exit;

  try
    tmp_value := StrToInt(edtScaleW.Text);
  except
    tmp_value := 0;
  end;

  if ((tmp_value > 0) and cbxProportions.Checked) then
    begin
    no_change := true;
    edtScaleH.Text := edtScaleW.Text;
    no_change := false;
    end;
end;

procedure TfrmResize.edtScaleHChange(Sender: TObject);
var
  tmp_value: integer;
begin
  if no_change then
    Exit;

  try
    tmp_value := StrToInt(edtScaleH.Text);
  except
    tmp_value := 0;
  end;

  if ((tmp_value > 0) and cbxProportions.Checked) then
    begin
    no_change := true;
    edtScaleW.Text := edtScaleH.Text;
    no_change := false;
    end;
end;

procedure TfrmResize.updSizeWChangingEx(Sender: TObject; var AllowChange: Boolean; NewValue: Smallint; Direction: TUpDownDirection);
var
  tmp_value: integer;
begin
  if no_change then
    Exit;

  try
    tmp_value := StrToInt(edtSizeW.Text);
  except
    tmp_value := 0;
  end;

  if (tmp_value > 0) then
    begin
    if (Direction = updUp) then
      edtSizeW.Text := IntToStr(tmp_value + 1)
    else if ((Direction = updDown) and (tmp_value <> 1)) then
      edtSizeW.Text := IntToStr(tmp_value - 1);
    end
  else
    edtSizeW.Text := IntToStr(orig_width);
end;

procedure TfrmResize.updSizeHChangingEx(Sender: TObject; var AllowChange: Boolean; NewValue: Smallint; Direction: TUpDownDirection);
var
  tmp_value: integer;
begin
  if no_change then
    Exit;

  try
    tmp_value := StrToInt(edtSizeH.Text);
  except
    tmp_value := 0;
  end;

  if (tmp_value > 0) then
    begin
    if (Direction = updUp) then
      edtSizeH.Text := IntToStr(tmp_value + 1)
    else if ((Direction = updDown) and (tmp_value <> 1)) then
      edtSizeH.Text := IntToStr(tmp_value - 1);
    end
  else
    edtSizeH.Text := IntToStr(orig_height);
end;

procedure TfrmResize.updScaleWChangingEx(Sender: TObject; var AllowChange: Boolean; NewValue: Smallint; Direction: TUpDownDirection);
var
  tmp_value: integer;
begin
  if no_change then
    Exit;

  try
    tmp_value := StrToInt(edtScaleW.Text);
  except
    tmp_value := 0;
  end;

  if (tmp_value > 0) then
    begin
    if (Direction = updUp) then
      edtScaleW.Text := IntToStr(tmp_value + 1)
    else if ((Direction = updDown) and (tmp_value <> 1)) then
      edtScaleW.Text := IntToStr(tmp_value - 1);
    end
  else
    edtScaleW.Text := '100';
end;

procedure TfrmResize.updScaleHChangingEx(Sender: TObject; var AllowChange: Boolean; NewValue: Smallint; Direction: TUpDownDirection);
var
  tmp_value: integer;
begin
  if no_change then
    Exit;

  try
    tmp_value := StrToInt(edtScaleH.Text);
  except
    tmp_value := 0;
  end;

  if (tmp_value > 0) then
    begin
    if (Direction = updUp) then
      edtScaleH.Text := IntToStr(tmp_value + 1)
    else if ((Direction = updDown) and (tmp_value <> 1)) then
      edtScaleH.Text := IntToStr(tmp_value - 1);
    end
  else
    edtScaleH.Text := '100';
end;

end.
