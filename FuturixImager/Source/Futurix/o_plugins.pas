unit o_plugins;

interface

uses
  Windows, Messages, SysUtils, Generics.Collections, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ImgList,
  c_const, c_reg, c_themes, c_ui;

type
  TfraOptPlugins = class(TFrame)
    btnScanPlugins: TButton;
    sbxCommands: TScrollBox;
    lvwPlugins: TListView;
    imlIcons: TImageList;
    lblGetMore: TLabel;
    procedure btnScanPluginsClick(Sender: TObject);
    procedure lvwPluginsInfoTip(Sender: TObject; Item: TListItem;
      var InfoTip: string);
    procedure lblGetMoreClick(Sender: TObject);
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

uses fx_core, w_main, w_options, f_plugins, f_tools;

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
  bmp: TBitmap;
const
  identation: integer = 1;
begin
  // initializing
  reg := TFRegistry.Create();
  data := TStringList.Create();

  // loading icons
  bmp := LoadBitmapFromTheme('IMGFIXED');

  if (bmp <> nil) then
    begin
    imlIcons.Height := bmp.Height;
    imlIcons.Width := bmp.Height;
    imlIcons.Clear();
    imlIcons.Add(bmp, nil);

    FreeAndNil(bmp);
    end
  else
    imlIcons.Clear();

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
    item.GroupID := 0;
    item.ImageIndex := 5;
    item.Indent := identation;
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
        item.SubItems.Add(data.Names[i]);
        item.GroupID := 1;
        item.ImageIndex := 6;
        item.Indent := identation;
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
        item.SubItems.Add(data.Names[i]);
        item.GroupID := 2;
        item.ImageIndex := 7;
        item.Indent := identation;
        end;
      end;

    reg.CloseKey();
    end;

  // column sizes
  lvwPlugins.Column[0].Width := -1;

  lvwPlugins.Items.EndUpdate();

  // set link style
  SetStyleAsLink(lblGetMore);
  lblGetMore.Hint := sURL;

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

procedure TfraOptPlugins.lblGetMoreClick(Sender: TObject);
begin
  OpenURL(sURL);
end;

procedure TfraOptPlugins.lvwPluginsInfoTip(Sender: TObject; Item: TListItem; var InfoTip: string);
begin
  if Item.SubItems.Count > 0 then
    InfoTip := Item.SubItems[0]
  else
    InfoTip := '';
end;

end.
