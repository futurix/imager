unit w_setup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, Dialogs, ColorPickerButton,
  CheckLst, c_const, c_utils;

type
  TfrmSetup = class(TForm)
    cbxOpenAfterSave: TCheckBox;
    lblSWinColor: TLabel;
    lblSFSColor: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    cbxAllFiles: TCheckBox;
    cbxFullPath: TCheckBox;
    pkrColor: TColorPickerButton;
    pkrFSColor: TColorPickerButton;
    gbxColors: TGroupBox;
    cbxUseLargeToolbarButtons: TCheckBox;
    cbxNoMRU: TCheckBox;
    pclSetup: TPageControl;
    shtGeneral: TTabSheet;
    shtCosmetic: TTabSheet;
	shtFormats: TTabSheet;
	lblExtensions: TLabel;
    gbxIcon: TGroupBox;
    imgIcon1: TImage;
    imgIcon2: TImage;
    imgIcon3: TImage;
    imgIcon4: TImage;
    rbnIcon1: TRadioButton;
    rbnIcon2: TRadioButton;
    rbnIcon3: TRadioButton;
    rbnIcon4: TRadioButton;
    btnRefresh: TButton;
    btnSelectAll: TButton;
    btnSelectNone: TButton;
    cbxFS: TCheckBox;
    clbExt: TCheckListBox;
    shtMisc: TTabSheet;
    lblRestoreWinIconViewer: TLabel;
    lblChangeFormatsDescription: TLabel;
    lblClearMRU: TLabel;
    lblScanForNewPlugins: TLabel;

    procedure LoadSettings();
    procedure SaveSettings();
    procedure UpdateSettings();

	procedure GetExtensions();
	procedure GetSupportInfo();
	procedure SaveSupportInfo();
	procedure ChangeDescription();
	function GetExt(ext: string):boolean;
	procedure SetExt(ext: string);
	procedure UnRegExt(ext: string);

	procedure imgIcon1Click(Sender: TObject);
	procedure imgIcon2Click(Sender: TObject);
	procedure imgIcon3Click(Sender: TObject);
	procedure imgIcon4Click(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnSelectNoneClick(Sender: TObject);
    procedure rbnIcon1Click(Sender: TObject);
    procedure rbnIcon2Click(Sender: TObject);
    procedure rbnIcon3Click(Sender: TObject);
    procedure rbnIcon4Click(Sender: TObject);
    procedure Uninstall();

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblRestoreWinIconViewerClick(Sender: TObject);
    procedure lblChangeFormatsDescriptionClick(Sender: TObject);
    procedure lblScanForNewPluginsClick(Sender: TObject);
    procedure lblClearMRUClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
	frmSetup: TfrmSetup;
	icon_num: integer = 1;
	description: string = 'Futuris Imager Document';


implementation

uses main, globals, f_ui, f_plugins, f_reg, f_scan, f_global, f_tools;

{$R *.DFM}

// loads all settings from INI
procedure TfrmSetup.LoadSettings();
begin
	reg.OpenKey(sReg + '\Main', true);
	if reg.RInt('OpenAfterSave', 1) = 1 then
    	cbxOpenAfterSave.Checked := true
    else
    	cbxOpenAfterSave.Checked := false;
	pkrColor.SelectionColor := StringToColor(reg.RStr('Color', 'clAppWorkSpace'));
	pkrFSColor.SelectionColor := StringToColor(reg.RStr('FSColor', 'clBlack'));
	if reg.RInt('OpenDef', 1) = 1 then
    	cbxAllFiles.Checked := true
    else
    	cbxAllFiles.Checked := false;
	if reg.RBool('NoMRU', false) = true then
    	cbxNoMRU.Checked := true
    else
    	cbxNoMRU.Checked := false;
	reg.CloseKey();

	reg.OpenKey(sReg + '\UI', true);
	if reg.RInt('TBStyle', 0) = 1 then
    	cbxUseLargeToolbarButtons.Checked := true
    else
    	cbxUseLargeToolbarButtons.Checked := false;
	if reg.RInt('FullPathInTitle', 0) = 1 then
    	cbxFullPath.Checked := true
    else
    	cbxFullPath.Checked := false;
	reg.CloseKey();
end;

// saves all settings to INI
procedure TfrmSetup.SaveSettings();
begin
	reg.OpenKey(sReg + '\Main', true);
	if cbxOpenAfterSave.Checked then
    	reg.WriteInteger('OpenAfterSave', 1)
    else
    	reg.WriteInteger('OpenAfterSave', 0);
	reg.WriteString('Color', ColorToString(pkrColor.SelectionColor));
	reg.WriteString('FSColor', ColorToString(pkrFSColor.SelectionColor));
	if cbxAllFiles.Checked then
    	reg.WriteInteger('OpenDef', 1)
    else
    	reg.WriteInteger('OpenDef', 0);
	if cbxNoMRU.Checked then
    	reg.WriteBool('NoMRU', true)
    else
    	reg.WriteBool('NoMRU', false);
	reg.CloseKey();

	reg.OpenKey(sReg + '\UI', true);
	if cbxUseLargeToolbarButtons.Checked then
    	reg.WriteInteger('TBStyle', 1)
    else
    	reg.WriteInteger('TBStyle', 0);
	if cbxFullPath.Checked then
    	reg.WriteInteger('FullPathInTitle', 1)
    else
    	reg.WriteInteger('FullPathInTitle', 0);
	reg.CloseKey();
end;

// updates all settings in real-time
procedure TfrmSetup.UpdateSettings();
begin
	if cbxOpenAfterSave.Checked then
    	Include(infSettings.options, opOpenAfterSave)
    else
    	Exclude(infSettings.options, opOpenAfterSave);

	if infSettings.full_screen then
    	frmMain.sbxMain.Color := pkrFSColor.SelectionColor
    else
    	frmMain.sbxMain.Color := pkrColor.SelectionColor;

	if cbxAllFiles.Checked then
    	Include(infSettings.options, opOpenDef)
    else
    	Exclude(infSettings.options, opOpenDef);

	if cbxNoMRU.Checked then
    	Include(infSettings.options, opNoMRU)
    else
    	Exclude(infSettings.options, opNoMRU);

	SetDialogs();

	if cbxUseLargeToolbarButtons.Checked then
    	ApplyToolbarSkin(true)
    else
    	ApplyToolbarSkin(false);

	if cbxFullPath.Checked then
    	Include(infSettings.options,opFullPathInTitle)
    else
    	Exclude(infSettings.options,opFullPathInTitle);

	Header();
end;

// loads all supported extensions into list
procedure TfrmSetup.GetExtensions();
var
	s: TStringList;
begin
	s := TStringList.Create();

	reg.OpenKey(sModules + '\Open', true);
	reg.GetValueNames(s);
	reg.CloseKey();

	s.Sort();

	clbExt.Items.Clear();
	clbExt.Items.AddStrings(s);

	FreeAndNil(s);
end;

// loads info from registry
procedure TfrmSetup.GetSupportInfo();
var
	i: integer;
begin
	reg.RootKey:=HKEY_CLASSES_ROOT;

	for i:=0 to (clbExt.Items.Count - 1) do
  		begin
  		if GetExt(clbExt.Items.Strings[i]) = true then
    		clbExt.Checked[i] := true else clbExt.Checked[i] := false;
  		end;

	reg.CloseKey();
	reg.RootKey := HKEY_CURRENT_USER;
end;

// saves info to registry
procedure TfrmSetup.SaveSupportInfo();
var
	i: integer;
begin
	reg.RootKey:=HKEY_CLASSES_ROOT;

    for i:=0 to (clbExt.Items.Count - 1) do
  		begin
  		if clbExt.Checked[i] = true then
    		SetExt(clbExt.Items.Strings[i])
  		else
    		begin
    		// removing association (if exist)
    		if GetExt(clbExt.Items.Strings[i]) = true then
      			UnRegExt(clbExt.Items.Strings[i]);
    		end;
  		end;

	reg.CloseKey();
	reg.RootKey := HKEY_CURRENT_USER;
end;

// change description
procedure TfrmSetup.ChangeDescription();
var
	tmp: string;
begin
	tmp := description;

    InputQuery('Description change', 'You can change Imager''s supported formats description, that appears in Windows Explorer...', tmp);

	if (tmp <> '') then
  		begin
  		description := tmp;
  		WriteHandler();
  		end;
end;

// is extension supported ?
function TfrmSetup.GetExt(ext: string):boolean;
begin
	Result := false;

    if reg.OpenKey('\.' + ext, false) then
  		begin
  		if reg.ReadString('') = 'FuturisImager' then
    		Result := true;
  		end;

	reg.CloseKey();

	// XP support
	if (IsXP() and Result) then
  		begin
  		reg.RootKey := HKEY_CURRENT_USER;
  		reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' + ext, true);

  		if reg.RStr('ProgID', '') = 'FuturisImager' then
    		Result := true
  		else
    		Result := false;

  		reg.CloseKey();
  		reg.RootKey := HKEY_CLASSES_ROOT;
  		end;
end;

// add extension support
procedure TfrmSetup.SetExt(ext: string);
var
	tmp: string;
begin
	reg.OpenKey('\.' + ext, true);
	tmp := reg.RStr('', '');

	if ((tmp <> '') and (tmp <> 'FuturisImager')) then
  		reg.WriteString('FuturisImager.bak', tmp);

	reg.WriteString('', 'FuturisImager');
	reg.CloseKey();

	// XP support
	if IsXP() then
  		begin
  		reg.RootKey := HKEY_CURRENT_USER;
  		reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' + ext, true);

  		tmp := reg.RStr('ProgID', '');
  		if ((tmp <> '') and (tmp <> 'FuturisImager')) then
    		reg.WString('FuturisImager.bak', tmp);
  		reg.WString('ProgID', 'FuturisImager');

  		reg.CloseKey();
  		reg.RootKey := HKEY_CLASSES_ROOT;
  		end;
end;

// removing extension support
procedure TfrmSetup.UnRegExt(ext: string);
var
	tmp: string;
begin
	reg.OpenKey('\.' + ext, true);

  	if reg.RStr('', '') = 'FuturisImager' then
    	begin
		if reg.ValueExists('FuturisImager.bak') then
      		begin
      		tmp := reg.RStr('FuturisImager.bak', '');
      		reg.WriteString('', tmp);
      		reg.DeleteValue('FuturisImager.bak');
      		end
    	else
      		reg.WriteString('', '');
    	end
  	else
    	if reg.ValueExists('FuturisImager.bak') then
      		reg.DeleteValue('FuturisImager.bak');

	reg.CloseKey();

	// XP support
	if IsXP() then
  		begin
  		reg.RootKey := HKEY_CURRENT_USER;
  		reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' + ext, true);

  		if reg.RStr('ProgID', '') = 'FuturisImager' then
    		begin
    		if reg.ValueExists('FuturisImager.bak') then
      			begin
      			tmp := reg.RStr('FuturisImager.bak', '');
      			reg.WString('ProgID', tmp);
      			reg.DeleteValue('FuturisImager.bak');
      			end
    		else
      			reg.DeleteValue('ProgID');
    		end
  		else
    		if reg.ValueExists('FuturisImager.bak') then
      			reg.DeleteValue('FuturisImager.bak');

  		reg.CloseKey();
  		reg.RootKey := HKEY_CLASSES_ROOT;
  		end;
end;

procedure TfrmSetup.imgIcon1Click(Sender: TObject);
begin
	rbnIcon1.Checked := true;
	icon_num := 1;
end;

procedure TfrmSetup.imgIcon2Click(Sender: TObject);
begin
	rbnIcon2.Checked := true;
	icon_num := 2;
end;

procedure TfrmSetup.imgIcon3Click(Sender: TObject);
begin
	rbnIcon3.Checked := true;
	icon_num := 3;
end;

procedure TfrmSetup.imgIcon4Click(Sender: TObject);
begin
	rbnIcon4.Checked := true;
	icon_num := 4;
end;

procedure TfrmSetup.btnRefreshClick(Sender: TObject);
begin
	GetExtensions();
	GetSupportInfo();
end;

procedure TfrmSetup.btnSelectAllClick(Sender: TObject);
var
	i: integer;
begin
	for i := 0 to (clbExt.Items.Count - 1) do
    	clbExt.Checked[i] := true;
end;

procedure TfrmSetup.btnSelectNoneClick(Sender: TObject);
var
	i: integer;
begin
	for i := 0 to (clbExt.Items.Count - 1) do
    	clbExt.Checked[i] := false;
end;

procedure TfrmSetup.rbnIcon1Click(Sender: TObject);
begin
	icon_num := 1;
end;

procedure TfrmSetup.rbnIcon2Click(Sender: TObject);
begin
	icon_num := 2;
end;

procedure TfrmSetup.rbnIcon3Click(Sender: TObject);
begin
	icon_num := 3;
end;

procedure TfrmSetup.rbnIcon4Click(Sender: TObject);
begin
	icon_num := 4;
end;

// removes info from registry
procedure TfrmSetup.Uninstall();
var
	i: integer;
begin
	reg.RootKey:=HKEY_CLASSES_ROOT;

	for i := 0 to (clbExt.Items.Count - 1) do
  		UnRegExt(clbExt.Items.Strings[i]);
	reg.CloseKey();

	reg.RootKey:=HKEY_CURRENT_USER;
end;























procedure TfrmSetup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
end;

procedure TfrmSetup.FormDestroy(Sender: TObject);
begin
	frmSetup := nil;
end;

procedure TfrmSetup.btnCancelClick(Sender: TObject);
begin
	frmSetup.Close();
end;

procedure TfrmSetup.FormCreate(Sender: TObject);
begin
	LoadSettings();

	imgIcon1.Picture.Icon.Handle := LoadIcon(HInstance, MAKEINTRESOURCE(1));
	imgIcon2.Picture.Icon.Handle := LoadIcon(HInstance, MAKEINTRESOURCE(2));
	imgIcon3.Picture.Icon.Handle := LoadIcon(HInstance, MAKEINTRESOURCE(3));
	imgIcon4.Picture.Icon.Handle := LoadIcon(HInstance, MAKEINTRESOURCE(4));

	reg.OpenKey(sReg + '\Formats', true);
	icon_num := reg.RInt('Icon', 1);

    case icon_num of
		1: rbnIcon1.Checked := true;
  		2: rbnIcon2.Checked := true;
		3: rbnIcon3.Checked := true;
  		4: rbnIcon4.Checked := true;
	end;

	cbxFS.Checked := reg.RBool('FullScreen', false);

	description := reg.RStr('Description', 'Futuris Imager Document');
	if description = 'Image file' then
		description:='Futuris Imager Document'; // fix for ugly name

	reg.CloseKey();

	GetExtensions();
	GetSupportInfo();
end;

procedure TfrmSetup.btnOKClick(Sender: TObject);
begin
	reg.OpenKey(sReg + '\Formats', true);

	reg.WriteInteger('Icon', icon_num);
	reg.WriteBool('FullScreen', cbxFS.Checked);
	reg.WriteString('Description', description);

	reg.CloseKey();

	SaveSupportInfo();
	WriteHandler();
	UpdateAssociations();

	SaveSettings();
	UpdateSettings();
	frmSetup.Close();
end;

procedure TfrmSetup.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

procedure TfrmSetup.lblRestoreWinIconViewerClick(Sender: TObject);
begin
	reg.RootKey := HKEY_CLASSES_ROOT;

	if reg.OpenKey('\.ico', false) = true then
		begin
		reg.WriteString('', 'icofile');
		reg.CloseKey();

		UpdateAssociations();
        Application.MessageBox('Done!', sAppName, MB_OK + MB_ICONINFORMATION);
		end;

	reg.RootKey := HKEY_CURRENT_USER;
end;

procedure TfrmSetup.lblChangeFormatsDescriptionClick(Sender: TObject);
begin
	ChangeDescription();
end;

procedure TfrmSetup.lblScanForNewPluginsClick(Sender: TObject);
begin
	PlugScan();
	UpdatePlugIns();
	Application.MessageBox('Plug-in search complete!', sAppName, MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmSetup.lblClearMRUClick(Sender: TObject);
begin
    frmMain.MRU.Files.Clear();
end;

end.
