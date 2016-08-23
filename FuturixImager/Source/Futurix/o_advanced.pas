unit o_advanced;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, hyiedefs,
  c_reg, c_const, c_utils, c_ui;

type
  TfraOptAdvanced = class(TFrame)
    lblDisplayQuality: TLabel;
    lblFilter: TLabel;
    cmbFilter: TComboBox;
    cbxDelayFilter: TCheckBox;
    lblControls: TLabel;
    cbxReverseWheel: TCheckBox;
    lblWarning: TLabel;
    lblReset: TLabel;
    procedure lblResetClick(Sender: TObject);
  private
  public
    procedure Load();
    procedure Reload();
    procedure Save();
    procedure Cancelled();
  end;


implementation

uses w_main, fx_defs;

{$R *.dfm}

procedure TfraOptAdvanced.Load();
var
  reg: TFRegistry;
begin
  SetStyleAsLink(lblReset);

  reg := TFRegistry.Create();

  if reg.OpenKeyUserRO(sSettings) then
    begin
    cmbFilter.ItemIndex := reg.RInt('Display_Resampler', 0);
    cbxDelayFilter.Checked := reg.RBool('Display_DelayFilter', false);
    cbxReverseWheel.Checked := reg.RBool('UI_ReverseMouseWheel', false);

    reg.CloseKey();
    end
  else
    begin
    cmbFilter.ItemIndex := 0;
    cbxDelayFilter.Checked := false;
    cbxReverseWheel.Checked := false;
    end;

  FreeAndNil(reg);
end;

procedure TfraOptAdvanced.Reload();
begin
  //
end;

procedure TfraOptAdvanced.Save();
var
  reg: TFRegistry;
  temp: TResampleFilter;
begin
  reg := TFRegistry.Create();

  if reg.OpenKeyUser(sSettings) then
    begin
    // write new values
    reg.WInteger('Display_Resampler', cmbFilter.ItemIndex);
    reg.WBool('Display_DelayFilter', cbxDelayFilter.Checked);
    reg.WBool('UI_ReverseMouseWheel', cbxReverseWheel.Checked);

    reg.CloseKey();

    // update current settings
    if (frmMain.img.ZoomFilter <> rfNone) then
      begin
      case cmbFilter.ItemIndex of
        0: temp := rfFastLinear;
        1: temp := rfLinear;
        2: temp := rfTriangle;
        3: temp := rfBicubic;
        4: temp := rfBilinear;
        5: temp := rfNearest;
        6: temp := rfBSpline;
        7: temp := rfMitchell;
        8: temp := rfBell;
        9: temp := rfHermite;
        10: temp := rfLanczos3;
        11: temp := rfProjectWB;
        12: temp := rfProjectBW;
        else
          temp := rfFastLinear;
      end;

      frmMain.img.ZoomFilter := temp;
      end;

    frmMain.img.DelayZoomFilter := cbxDelayFilter.Checked;
    frmMain.bReverseWheel := cbxReverseWheel.Checked;
    end;

  FreeAndNil(reg);
end;

procedure TfraOptAdvanced.Cancelled();
begin
  //
end;

procedure TfraOptAdvanced.lblResetClick(Sender: TObject);
begin
  cmbFilter.ItemIndex := 0;
  cbxDelayFilter.Checked := false;
  cbxReverseWheel.Checked := false;
end;

end.
