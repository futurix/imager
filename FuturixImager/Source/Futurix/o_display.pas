unit o_display;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  c_const, c_reg, c_utils;

type
  TfraOptDisplay = class(TFrame)
    lblDisplay: TLabel;
    cbxHQFilter: TCheckBox;
    lblBgStyle: TLabel;
    cmbBgStyle: TComboBox;
    lblColors: TLabel;
    lblColorBg: TLabel;
    sbxColorBg: TScrollBox;
    sbxColorFs: TScrollBox;
    sbxColorGradient: TScrollBox;
    lblColorGradient: TLabel;
    lblColorFs: TLabel;
    procedure sbxColorBgClick(Sender: TObject);
    procedure sbxColorGradientClick(Sender: TObject);
    procedure sbxColorFsClick(Sender: TObject);
  private
  public
    procedure Load();
    procedure Reload();
    procedure Save();
    procedure Cancelled();
  end;


implementation

uses w_options, w_main, f_images, f_ui;

{$R *.dfm}

procedure TfraOptDisplay.Load();
var
  reg: TFRegistry;
begin
  reg := TFRegistry.Create();

  if reg.OpenKeyUserRO(sSettings) then
    begin
    cbxHQFilter.Checked := reg.RBool('Display_HighQuality', true);

    sbxColorBg.Color := StringToColor(reg.RStr('Display_ColorBg', 'clAppWorkSpace'));
    sbxColorGradient.Color := StringToColor(reg.RStr('Display_ColorGradient', 'clSilver'));
    sbxColorFs.Color := StringToColor(reg.RStr('Display_ColorFs', 'clBlack'));

    cmbBgStyle.ItemIndex := reg.RInt('Display_BgStyle', 0);

    reg.CloseKey();
    end
  else
    begin
    cbxHQFilter.Checked := true;

    sbxColorBg.Color := clAppWorkSpace;
    sbxColorGradient.Color := clSilver;
    sbxColorFs.Color := clBlack;

    cmbBgStyle.ItemIndex := 0;
    end;

  FreeAndNil(reg);
end;

procedure TfraOptDisplay.Reload();
begin
  //
end;

procedure TfraOptDisplay.Save();
var
  reg: TFRegistry;
begin
  reg := TFRegistry.Create();

  if reg.OpenKeyUser(sSettings) then
    begin
    // write new values
    reg.WBool('Display_HighQuality', cbxHQFilter.Checked);

    reg.WString('Display_ColorBg', ColorToString(sbxColorBg.Color));
    reg.WString('Display_ColorGradient', ColorToString(sbxColorGradient.Color));
    reg.WString('Display_ColorFs', ColorToString(sbxColorFs.Color));

    reg.WInteger('Display_BgStyle', cmbBgStyle.ItemIndex);

    reg.CloseKey();

    // update current settings
    fxSettings.ColorDefault := sbxColorBg.Color;
    fxSettings.ColorGradient := sbxColorGradient.Color;
    fxSettings.ColorFullScreen := sbxColorFs.Color;
    fxSettings.BackgroundStyle := cmbBgStyle.ItemIndex;

    ApplyBackground();
    SetDisplayStyle(GetDisplayStyle());
    end;

  FreeAndNil(reg);
end;

procedure TfraOptDisplay.Cancelled();
begin
  //
end;

procedure TfraOptDisplay.sbxColorBgClick(Sender: TObject);
var
  dlg: TColorDialog;
begin
  dlg := TColorDialog.Create(Self);

  dlg.Color := sbxColorBg.Color;
  dlg.Options := [cdFullOpen, cdAnyColor];

  if dlg.Execute then
    sbxColorBg.Color := dlg.Color;

  FreeAndNil(dlg);
end;

procedure TfraOptDisplay.sbxColorGradientClick(Sender: TObject);
var
  dlg: TColorDialog;
begin
  dlg := TColorDialog.Create(Self);

  dlg.Color := sbxColorGradient.Color;
  dlg.Options := [cdFullOpen, cdAnyColor];

  if dlg.Execute then
    sbxColorGradient.Color := dlg.Color;

  FreeAndNil(dlg);
end;

procedure TfraOptDisplay.sbxColorFsClick(Sender: TObject);
var
  dlg: TColorDialog;
begin
  dlg := TColorDialog.Create(Self);

  dlg.Color := sbxColorFs.Color;
  dlg.Options := [cdFullOpen, cdAnyColor];

  if dlg.Execute then
    sbxColorFs.Color := dlg.Color;

  FreeAndNil(dlg);
end;

end.
