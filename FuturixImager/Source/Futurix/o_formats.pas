unit o_formats;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ShellAPI,
  c_const, c_reg;

type
  TfraOptFormats = class(TFrame)
    btnFormats: TButton;
    cbxRare: TCheckBox;
    cbxUpdateOnScan: TCheckBox;
    procedure btnFormatsClick(Sender: TObject);
  private
  public
    procedure Load();
    procedure Reload();
    procedure Save();
    procedure Cancelled();
  end;


implementation

uses w_main, w_options, f_tools;

{$R *.dfm}

procedure TfraOptFormats.btnFormatsClick(Sender: TObject);
begin
  FxRegWBool('Formats_IncludeRareFormats', cbxRare.Checked);

  DefaultPrograms();
end;

procedure TfraOptFormats.Load();
begin
  cbxRare.Checked := FxRegRBool('Formats_IncludeRareFormats', false);
  cbxUpdateOnScan.Checked := FxRegRBool('Formats_UpdateSystemOnPluginScan', true);
end;

procedure TfraOptFormats.Reload();
begin
  //
end;

procedure TfraOptFormats.Save();
begin
  FxRegWBool('Formats_IncludeRareFormats', cbxRare.Checked);
  FxRegWBool('Formats_UpdateSystemOnPluginScan', cbxUpdateOnScan.Checked);
end;

procedure TfraOptFormats.Cancelled();
begin
  //
end;

end.
