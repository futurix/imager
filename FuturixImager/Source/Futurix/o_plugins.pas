unit o_plugins;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, StdCtrls;

type
  TfraOptPlugins = class(TFrame)
    btmScanPlugins: TButton;
    btnFormats: TButton;
    procedure btmScanPluginsClick(Sender: TObject);
    procedure btnFormatsClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Load();
    procedure Save();
  end;


implementation

uses fx_core, w_main;

{$R *.dfm}

procedure TfraOptPlugins.btmScanPluginsClick(Sender: TObject);
begin
  fx.PluginScan();
end;

procedure TfraOptPlugins.btnFormatsClick(Sender: TObject);
begin
  //
end;

procedure TfraOptPlugins.Load();
begin
  //
end;

procedure TfraOptPlugins.Save();
begin
  //
end;

end.
