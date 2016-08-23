unit o_general;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls,
  imageenio,
  c_reg, c_const, c_utils, c_ui;

type
  TfraOptGeneral = class(TFrame)
    lblFormatOptions: TLabel;
    cbxEnableCMS: TCheckBox;
    cbxAutoRotateEXIF: TCheckBox;
    lblMisc: TLabel;
    cbxDisableMRU: TCheckBox;
    cbxFullPathInTitle: TCheckBox;
    cbxAllowMulti: TCheckBox;
    lblClearMRU: TLabel;
    procedure lblClearMRUClick(Sender: TObject);
  private
  public
    procedure Load();
    procedure Reload();
    procedure Save();
    procedure Cancelled();
  end;


implementation

uses f_ui, f_tools, w_main, fx_defs;

{$R *.dfm}

procedure TfraOptGeneral.Load();
var
  reg: TFRegistry;
begin
  SetStyleAsLink(lblClearMRU);

  reg := TFRegistry.Create();

  if reg.OpenKeyUserRO(sSettings) then
    begin
    cbxEnableCMS.Checked := reg.RBool('Data_CMS', false);
    cbxAutoRotateEXIF.Checked := reg.RBool('Data_AutoRotateOnEXIF', true);
    cbxDisableMRU.Checked := reg.RBool('Core_DisableMRU', false);
    cbxFullPathInTitle.Checked := reg.RBool('UI_FullPathInTitle', false);
    cbxAllowMulti.Checked := reg.RBool('Core_MultipleInstances', true);

    reg.CloseKey();
    end
  else
    begin
    cbxEnableCMS.Checked := false;
    cbxAutoRotateEXIF.Checked := true;
    cbxDisableMRU.Checked := false;
    cbxFullPathInTitle.Checked := false;
    cbxAllowMulti.Checked := true;
    end;

  FreeAndNil(reg);
end;

procedure TfraOptGeneral.Reload();
begin
  //
end;

procedure TfraOptGeneral.Save();
var
  reg: TFRegistry;
begin
  reg := TFRegistry.Create();

  if reg.OpenKeyUser(sSettings) then
    begin
    // write new values
    reg.WBool('Data_CMS', cbxEnableCMS.Checked);
    reg.WBool('Data_AutoRotateOnEXIF', cbxAutoRotateEXIF.Checked);
    reg.WBool('Core_DisableMRU', cbxDisableMRU.Checked);
    reg.WBool('UI_FullPathInTitle', cbxFullPathInTitle.Checked);
    reg.WBool('Core_MultipleInstances', cbxAllowMulti.Checked);

    reg.CloseKey();

    // update current settings
    iegEnableCMS := cbxEnableCMS.Checked;
    bAutoRotateEXIF := cbxAutoRotateEXIF.Checked;
    frmMain.bNoMRU := cbxDisableMRU.Checked;
    frmMain.bFullPathInTitle := cbxFullPathInTitle.Checked;

    frmMain.SetupColour();
    Header();
    end
  else
    MessageBox(Handle, 'Unable to save settings - registry access denied!', sAppName, MB_OK or MB_ICONERROR);

  FreeAndNil(reg);
end;

procedure TfraOptGeneral.Cancelled();
begin
  //
end;

procedure TfraOptGeneral.lblClearMRUClick(Sender: TObject);
begin
  frmMain.mru.ClearItems(true);
end;

end.
