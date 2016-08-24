unit o_plugins;

interface

uses
  Windows, Messages, SysUtils, Generics.Collections, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls,
  c_const, c_reg;

type
  TfraOptPlugins = class(TFrame)
    btnScanPlugins: TButton;
    sbxCommands: TScrollBox;
    lvwPlugins: TListView;
    procedure btnScanPluginsClick(Sender: TObject);
  private
    scanned: boolean;
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
  id, i: integer;
  item: TListItem;
  temp: string;
  reg: TFRegistry;
  data: TStringList;
begin
  // initializing
  reg := TFRegistry.Create();
  data := TStringList.Create();

  // plug-ins
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

  // localizations
  if reg.OpenKeyUserRO(sModules + '\' + PS_FLOCALE) then
    begin
    reg.ReadKeysAndValues(data);

    for i := 0 to data.Count - 1 do
      begin
      if Trim(data.Names[i]) <> '' then
        begin
        item := lvwPlugins.Items.Add();
        item.Data := nil;

        temp := data.Values[data.Names[i]];
        if (temp <> '') then
          temp := ExtractFileName(temp)
        else
          temp := '?';

        item.Caption := temp;
        item.SubItems.Add(Format('%s (localization)', [data.Names[i]]));
        end;
      end;

    reg.CloseKey();
    end;

  // themes
  if reg.OpenKeyUserRO(sModules + '\' + PS_FTHEME) then
    begin
    reg.ReadKeysAndValues(data);

    for i := 0 to data.Count - 1 do
      begin
      if Trim(data.Names[i]) <> '' then
        begin
        item := lvwPlugins.Items.Add();
        item.Data := nil;

        temp := data.Values[data.Names[i]];
        if (temp <> '') then
          temp := ExtractFileName(temp)
        else
          temp := '?';

        item.Caption := temp;
        item.SubItems.Add(Format('%s (theme)', [data.Names[i]]));
        end;
      end;

    reg.CloseKey();
    end;

  // icon libraries
  if reg.OpenKeyUserRO(sModules + '\' + PS_FICONLIB) then
    begin
    reg.ReadKeysAndValues(data);

    for i := 0 to data.Count - 1 do
      begin
      if Trim(data.Names[i]) <> '' then
        begin
        item := lvwPlugins.Items.Add();
        item.Data := nil;

        temp := data.Values[data.Names[i]];
        if (temp <> '') then
          temp := ExtractFileName(temp)
        else
          temp := '?';

        item.Caption := temp;
        item.SubItems.Add(Format('%s (icon library)', [data.Names[i]]));
        end;
      end;

    reg.CloseKey();
    end;

  // column sizes
  lvwPlugins.Column[0].Width := -1;
  if (lvwPlugins.Column[0].Width < 100) then
    lvwPlugins.Column[0].Width := 100;
  lvwPlugins.Column[1].Width :=
    lvwPlugins.Width - lvwPlugins.Column[0].Width -
    GetSystemMetrics(SM_CXVSCROLL) - GetSystemMetrics(SM_CXEDGE) * 4;

  lvwPlugins.Items.EndUpdate();

  // clean-up
  FreeAndNil(ids);
  FreeAndNil(data);
  FreeAndNil(reg);
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
  if Assigned(frmOptions) then
    frmOptions.actionReinstallPlugins := scanned;
end;

procedure TfraOptPlugins.Cancelled();
begin
  if Assigned(frmOptions) then
    frmOptions.actionReinstallPlugins := scanned;
end;

end.
