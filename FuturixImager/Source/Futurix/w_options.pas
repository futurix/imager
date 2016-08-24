unit w_options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImgList,
  c_utils,
  o_plugins, o_welcome, o_formats, o_formatsxp, o_advanced, o_iconlib, o_lang,
  o_themes;

type
  TfrmOptions = class(TForm)
    sbxFrameHost: TScrollBox;
    sbxCommands: TScrollBox;
    tvwCategories: TTreeView;
    btnOK: TButton;
    btnCancel: TButton;
    sbxSplitterB: TScrollBox;
    imlOptions: TImageList;
    sbxWrapper: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tvwCategoriesChange(Sender: TObject; Node: TTreeNode);
  private
    optWelcome: TfraOptWelcome;
    optPlugins: TfraOptPlugins;
    optFormats: TfraOptFormats;
    optFormatsXP: TfraOptFormatsXP;
    optLang: TfraOptLang;
    optThemes: TfraOptThemes;
    optIconLib: TfraOptIconLib;
    optAdvanced: TfraOptAdv;

    procedure ProcessActions();
  public
    actionUpdateFileFormatHandlers: boolean;
    actionReinstallPlugins: boolean;

    procedure Localize();
    procedure UpdatePages();
  end;

const
  // pages
  OPAGE_WELCOME       = 0;
  OPAGE_PLUGINS       = 1;
  OPAGE_FORMATS       = 2;
  OPAGE_FORMATSXP     = 3;
  OPAGE_LANG          = 4;
  OPAGE_THEMES        = 5;
  OPAGE_ICONLIB       = 6;
  OPAGE_ADVANCED      = 7;

var
  frmOptions: TfrmOptions;


implementation

uses f_plugins, fx_formats_legacy, f_tools;

{$R *.dfm}

procedure TfrmOptions.FormCreate(Sender: TObject);
var
  temp: TTreeNode;
begin
  // no actions by default
  actionUpdateFileFormatHandlers := false;
  actionReinstallPlugins := false;

  // adding pages to the list
  temp := tvwCategories.Items.Add(nil, 'Welcome');
  temp.ImageIndex := 0;
  temp.Data := Pointer(OPAGE_WELCOME);

  temp := tvwCategories.Items.Add(nil, 'Plug-ins');
  temp.ImageIndex := 0;
  temp.Data := Pointer(OPAGE_PLUGINS);

  if IsVista() then
    begin
    temp := tvwCategories.Items.Add(nil, 'File Formats');
    temp.ImageIndex := 0;
    temp.Data := Pointer(OPAGE_FORMATS);
    end
  else
    begin
    temp := tvwCategories.Items.Add(nil, 'File Formats');
    temp.ImageIndex := 0;
    temp.Data := Pointer(OPAGE_FORMATSXP);
    end;

  temp := tvwCategories.Items.Add(nil, 'Icons');
  temp.ImageIndex := 0;
  temp.Data := Pointer(OPAGE_ICONLIB);

  //temp := tvwCategories.Items.Add(nil, 'Languages');
  //temp.ImageIndex := 0;
  //temp.Data := Pointer(OPAGE_LANG);

  //temp := tvwCategories.Items.Add(nil, 'Themes');
  //temp.ImageIndex := 0;
  //temp.Data := Pointer(OPAGE_THEMES);

  //temp := tvwCategories.Items.Add(nil, 'Advanced');
  //temp.ImageIndex := 0;
  //temp.Data := Pointer(OPAGE_ADVANCED);

  tvwCategories.Select(tvwCategories.Items[0]);

  Localize();
end;

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmOptions.FormDestroy(Sender: TObject);
begin
  frmOptions := nil;
end;

procedure TfrmOptions.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Self.Close();
end;

procedure TfrmOptions.Localize();
begin
  //
end;

procedure TfrmOptions.UpdatePages();
begin
  if (optWelcome <> nil) then
    optWelcome.Reload();

  if (optPlugins <> nil) then
    optPlugins.Reload();

  if (optFormats <> nil) then
    optFormats.Reload();

  if (optFormatsXP <> nil) then
    optFormatsXP.Reload();

  if (optLang <> nil) then
    optLang.Reload();

  if (optThemes <> nil) then
    optThemes.Reload();

  if (optIconLib <> nil) then
    optIconLib.Reload();

  if (optAdvanced <> nil) then
    optAdvanced.Reload();
end;

procedure TfrmOptions.ProcessActions();
begin
  if actionUpdateFileFormatHandlers then
    begin
    if IsVista() then
      DefaultPrograms('/sync')
    else
      begin
      WriteHandlers();
      UpdateAssociations();
      end;
    end;

  if actionReinstallPlugins then
    UpdatePlugIns();
end;

procedure TfrmOptions.tvwCategoriesChange(Sender: TObject; Node: TTreeNode);
begin
  if (Node <> nil) then
    begin
    case Integer(Node.Data) of
      OPAGE_WELCOME:
        begin
        if (optWelcome <> nil) then
          optWelcome.BringToFront()
        else
          begin
          optWelcome := TfraOptWelcome.Create(sbxFrameHost);
          optWelcome.Visible := false;
          optWelcome.Parent := sbxFrameHost;
          optWelcome.Align := alClient;
          optWelcome.Load();
          optWelcome.BringToFront();
          optWelcome.Show();
          end;
        end;

      OPAGE_PLUGINS:
        begin
        if (optPlugins <> nil) then
          optPlugins.BringToFront()
        else
          begin
          optPlugins := TfraOptPlugins.Create(sbxFrameHost);
          optPlugins.Visible := false;
          optPlugins.Parent := sbxFrameHost;
          optPlugins.Align := alClient;
          optPlugins.Load();
          optPlugins.BringToFront();
          optPlugins.Show();
          end;
        end;

      OPAGE_FORMATS:
        begin
        if (optFormats <> nil) then
          optFormats.BringToFront()
        else
          begin
          optFormats := TfraOptFormats.Create(sbxFrameHost);
          optFormats.Visible := false;
          optFormats.Parent := sbxFrameHost;
          optFormats.Align := alClient;
          optFormats.Load();
          optFormats.BringToFront();
          optFormats.Show();
          end;
        end;

      OPAGE_FORMATSXP:
        begin
        if (optFormatsXP <> nil) then
          optFormatsXP.BringToFront()
        else
          begin
          optFormatsXP := TfraOptFormatsXP.Create(sbxFrameHost);
          optFormatsXP.Visible := false;
          optFormatsXP.Parent := sbxFrameHost;
          optFormatsXP.Align := alClient;
          optFormatsXP.Load();
          optFormatsXP.BringToFront();
          optFormatsXP.Show();
          end;
        end;

      OPAGE_LANG:
        begin
        if (optLang <> nil) then
          optLang.BringToFront()
        else
          begin
          optLang := TfraOptLang.Create(sbxFrameHost);
          optLang.Visible := false;
          optLang.Parent := sbxFrameHost;
          optLang.Align := alClient;
          optLang.Load();
          optLang.BringToFront();
          optLang.Show();
          end;
        end;

      OPAGE_THEMES:
        begin
        if (optThemes <> nil) then
          optThemes.BringToFront()
        else
          begin
          optThemes := TfraOptThemes.Create(sbxFrameHost);
          optThemes.Visible := false;
          optThemes.Parent := sbxFrameHost;
          optThemes.Align := alClient;
          optThemes.Load();
          optThemes.BringToFront();
          optThemes.Show();
          end;
        end;

      OPAGE_ICONLIB:
        begin
        if (optIconLib <> nil) then
          optIconLib.BringToFront()
        else
          begin
          optIconLib := TfraOptIconLib.Create(sbxFrameHost);
          optIconLib.Visible := false;
          optIconLib.Parent := sbxFrameHost;
          optIconLib.Align := alClient;
          optIconLib.Load();
          optIconLib.BringToFront();
          optIconLib.Show();
          end;
        end;

      OPAGE_ADVANCED:
        begin
        if (optAdvanced <> nil) then
          optAdvanced.BringToFront()
        else
          begin
          optAdvanced := TfraOptAdv.Create(sbxFrameHost);
          optAdvanced.Visible := false;
          optAdvanced.Parent := sbxFrameHost;
          optAdvanced.Align := alClient;
          optAdvanced.Load();
          optAdvanced.BringToFront();
          optAdvanced.Show();
          end;
        end;
    end;
    end;
end;

procedure TfrmOptions.btnOKClick(Sender: TObject);
begin
  if (optWelcome <> nil) then
    optWelcome.Save();

  if (optPlugins <> nil) then
    optPlugins.Save();

  if (optFormats <> nil) then
    optFormats.Save();

  if (optFormatsXP <> nil) then
    optFormatsXP.Save();

  if (optLang <> nil) then
    optLang.Save();

  if (optThemes <> nil) then
    optThemes.Save();

  if (optIconLib <> nil) then
    optIconLib.Save();

  if (optAdvanced <> nil) then
    optAdvanced.Save();

  ProcessActions();
  Close();
end;

procedure TfrmOptions.btnCancelClick(Sender: TObject);
begin
  if (optWelcome <> nil) then
    optWelcome.Cancelled();

  if (optPlugins <> nil) then
    optPlugins.Cancelled();

  if (optFormats <> nil) then
    optFormats.Cancelled();

  if (optFormatsXP <> nil) then
    optFormatsXP.Cancelled();

  if (optLang <> nil) then
    optLang.Cancelled();

  if (optThemes <> nil) then
    optThemes.Cancelled();

  if (optIconLib <> nil) then
    optIconLib.Cancelled();

  if (optAdvanced <> nil) then
    optAdvanced.Cancelled();

  ProcessActions();
  Close();
end;

end.
