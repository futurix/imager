unit o_plugins;

interface

uses
  Windows, Messages, SysUtils, Generics.Collections, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,
  c_const, ComCtrls;

type
  TfraOptPlugins = class(TFrame)
    btnScanPlugins: TButton;
    sbxCommands: TScrollBox;
    lvwPlugins: TListView;
    procedure btnScanPluginsClick(Sender: TObject);
  private
    scanned: boolean;

    procedure ReloadPluginsAfterScan();
  public
    procedure Init();
    procedure Load();
    procedure Reload();
    procedure Save();
    procedure Cancelled();
  end;


implementation

uses fx_core, w_main, w_options, f_plugins;

{$R *.dfm}

procedure TfraOptPlugins.btnScanPluginsClick(Sender: TObject);
begin
  scanned := true;

  fx.PluginScan();
  frmOptions.UpdatePages();

  MessageBox(Handle, 'Scan for new plug-ins completed successfully.', sAppName, MB_OK or MB_ICONINFORMATION);
end;

procedure TfraOptPlugins.Init();
var
  ids: TList<integer>;
  id: integer;
  item: TListItem;
  temp: string;
begin
  ids := fx.Plugins.ListPluginIDs();

  lvwPlugins.Items.BeginUpdate();
  lvwPlugins.Items.Clear();

  for id in ids do
    begin
    item := lvwPlugins.Items.Add();
    item.Data := Pointer(id);

    temp := fx.Plugins.FindPluginLocation(id);
    if (temp <> '') then
      temp := ExtractFileName(temp)
    else
      temp := '?';

    item.Caption := temp;
    item.SubItems.Add(fx.Plugins.FindPluginName(id));
    end;

  // column sizes
  lvwPlugins.Column[0].Width := -1;
  if (lvwPlugins.Column[0].Width < 100) then
    lvwPlugins.Column[0].Width := 100;
  lvwPlugins.Column[1].Width :=
    lvwPlugins.Width - lvwPlugins.Column[0].Width -
    GetSystemMetrics(SM_CXVSCROLL) - GetSystemMetrics(SM_CXEDGE) * 4;

  lvwPlugins.Items.EndUpdate();

  FreeAndNil(ids);
end;

procedure TfraOptPlugins.Load();
begin
  scanned := false;

  Init();
end;

procedure TfraOptPlugins.Reload();
begin
  Init();
end;

procedure TfraOptPlugins.Save();
begin
  if scanned then
    ReloadPluginsAfterScan();
end;

procedure TfraOptPlugins.Cancelled();
begin
  if scanned then
    ReloadPluginsAfterScan();
end;

procedure TfraOptPlugins.ReloadPluginsAfterScan();
begin
  UpdatePlugIns();
end;

end.
