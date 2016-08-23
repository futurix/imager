unit w_optplugins;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, Dialogs, CheckLst, ShellAPI,
  c_const, c_utils, c_locales;

type
  TfrmOptPlugins = class(TForm)
    btnClose: TButton;
    sbnPlugScan: TSpeedButton;
    sbnOpenPlugFolder: TSpeedButton;
    lblGetPlugins: TLabel;
    lblInstPlugins: TLabel;
    lbxInstPlugins: TListBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbnPlugScanClick(Sender: TObject);
    procedure sbnOpenPlugFolderClick(Sender: TObject);
    procedure lblGetPluginsClick(Sender: TObject);
  private
    procedure GetInstalledPluginsList();
  public
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Localize();
  end;

var
	frmOptPlugins: TfrmOptPlugins;


implementation

uses main, f_ui, f_plugins, f_scan, f_tools, w_show;

{$R *.DFM}

procedure TfrmOptPlugins.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
end;

procedure TfrmOptPlugins.FormDestroy(Sender: TObject);
begin
	frmOptPlugins := nil;
end;

procedure TfrmOptPlugins.btnCloseClick(Sender: TObject);
begin
	Self.Close();
end;

procedure TfrmOptPlugins.FormCreate(Sender: TObject);
begin
    Localize();
    GetInstalledPluginsList();
end;

procedure TfrmOptPlugins.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

procedure TfrmOptPlugins.CreateParams(var Params: TCreateParams);
begin
	Params.Style := (Params.Style or WS_POPUP);

	inherited;

	if (Owner is TForm) then
		Params.WndParent := (Owner as TWinControl).Handle
	else if Assigned(Screen.ActiveForm) then
		Params.WndParent := Screen.ActiveForm.Handle;
end;

procedure TfrmOptPlugins.Localize();
begin
    Self.Caption				:= LoadLStr(862);

    sbnPlugScan.Caption			:= LoadLStr(863);
    sbnOpenPlugFolder.Caption	:= LoadLStr(864);
    lblGetPlugins.Caption		:= LoadLStr(865);
    lblInstPlugins.Caption		:= LoadLStr(867);

    btnClose.Caption			:= LoadLStr(54);
end;

procedure TfrmOptPlugins.GetInstalledPluginsList();
var
	list: TStringList;
begin
    list := TStringList.Create();

    lbxInstPlugins.Items.Clear();

    if reg.OpenKey(sModules + '\' + PS_FNAME, false) then
    	begin
    	reg.GetValueNames(list);
    	reg.CloseKey();
        end;

    list.Sort();
    lbxInstPlugins.Items.AddStrings(list);

    FreeAndNil(list);
end;

procedure TfrmOptPlugins.sbnPlugScanClick(Sender: TObject);
begin
	DoPluginScan();
	UpdatePlugIns();
    SetDialogs();
    GetInstalledPluginsList();
	Application.MessageBox(PChar(LoadLStr(604)), sAppName, MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmOptPlugins.sbnOpenPlugFolderClick(Sender: TObject);
begin
	ShellExecute(Application.Handle, 'open', PChar(path_app), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmOptPlugins.lblGetPluginsClick(Sender: TObject);
begin
	OpenURL(sURLplugins);
end;

end.
