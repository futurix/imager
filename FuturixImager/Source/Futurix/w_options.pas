unit w_options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImgList,
  o_plugins, o_welcome;

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
  public
    procedure Localize();
  end;

const
  // pages
  OPAGE_WELCOME       = 0;
  OPAGE_PLUGINS       = 1;

var
  frmOptions: TfrmOptions;


implementation

{$R *.dfm}

procedure TfrmOptions.FormCreate(Sender: TObject);
var
  temp: TTreeNode;
begin
  temp := tvwCategories.Items.Add(nil, 'Welcome');
  temp.ImageIndex := 0;
  temp.Data := Pointer(OPAGE_WELCOME);

  temp := tvwCategories.Items.Add(nil, 'Plug-ins');
  temp.ImageIndex := 0;
  temp.Data := Pointer(OPAGE_PLUGINS);

  tvwCategories.Select(tvwCategories.Items[0]);

  Localize();
end;

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //

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
          optWelcome.Parent := sbxFrameHost;
          optWelcome.Align := alClient;
          optWelcome.Load();
          optWelcome.BringToFront();
          end;
        end;

      OPAGE_PLUGINS:
        begin
        if (optPlugins <> nil) then
          optPlugins.BringToFront()
        else
          begin
          optPlugins := TfraOptPlugins.Create(sbxFrameHost);
          optPlugins.Parent := sbxFrameHost;
          optPlugins.Align := alClient;
          optPlugins.Load();
          optPlugins.BringToFront();
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

  Close();
end;

procedure TfrmOptions.btnCancelClick(Sender: TObject);
begin
  Close();
end;

end.
