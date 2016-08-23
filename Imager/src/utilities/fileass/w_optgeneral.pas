unit w_optgeneral;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, Dialogs, ShellAPI,
  c_const, c_utils, ToolWin, c_reg, Menus;

type
  TfrmOptions = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    lvwExt: TListView;
    lblAddParams: TLabel;
    popFormats: TPopupMenu;
    piSelectAll: TMenuItem;
    piSelectNone: TMenuItem;
    cbxShowRare: TCheckBox;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblAddParamsClick(Sender: TObject);
    procedure piSelectAllClick(Sender: TObject);
    procedure piSelectNoneClick(Sender: TObject);
    procedure cbxShowRareClick(Sender: TObject);
  private
    procedure InitFormats();
    function  GetExt(ext: string): boolean;
    procedure SetExt(ext: string);
    procedure UnsetExt(ext: string);
    procedure SaveFormats();
  end;

var
	frmOptions: TfrmOptions;


implementation

uses f_tools, w_optformats;

{$R *.DFM}

procedure TfrmOptions.InitFormats();
var
	s, notrec: TStringList;
    i: integer;
    item: TListItem;
	wreg: TFRegistry;
    bDescr: boolean;
begin
    notrec := TStringList.Create();
	s := TStringList.Create();

	wreg := TFRegistry.Create(RA_READONLY);
	wreg.RootKey := HKEY_CURRENT_USER;

	if wreg.OpenKey(sModules + '\' + PS_FOPEN, false) then
    	begin
		wreg.GetValueNames(s);

		wreg.CloseKey();
        end;

	if wreg.OpenKey(sModules + '\' + PS_FNOTREC, false) then
    	begin
		wreg.GetValueNames(notrec);

		wreg.CloseKey();
    	end;

	s.Sort();
    lvwExt.Items.Clear();

    bDescr := wreg.OpenKey(sModules + '\' + PS_FDESCR, false);

    for i := 0 to (s.Count - 1) do
    	begin
        if ((GetExt(s[i])) or (cbxShowRare.Checked) or (notrec.IndexOf(s[i]) = -1)) then
        	begin
        	item := lvwExt.Items.Add();
        	item.Caption := s[i];

            if bDescr then
        		item.SubItems.Add(wreg.RStr(s[i], ''))
            else
            	item.SubItems.Add('');

        	item.Checked := GetExt(s[i]);
            end;
        end;

    if bDescr then
    	wreg.CloseKey();

	FreeAndNil(s);
    FreeAndNil(notrec);
    FreeAndNil(wreg);
end;

function TfrmOptions.GetExt(ext: string): boolean;
var
	freg: TFRegistry;
begin
	Result := false;

    freg := TFRegistry.Create(RA_READONLY);
    freg.RootKey := HKEY_CLASSES_ROOT;

    if freg.OpenKey('\.' + ext, false) then
  		begin
        Result := (freg.ReadString('') = sRegAssociation);
        freg.CloseKey();
  		end;

    FreeAndNil(freg);
end;

procedure TfrmOptions.SetExt(ext: string);
var
	freg: TFRegistry;
	tmp: string;
begin
    freg := TFRegistry.Create(RA_FULL);
    freg.RootKey := HKEY_CLASSES_ROOT;

	if freg.OpenKey('\.' + ext, true) then
    	begin
		tmp := freg.RStr('', '');

		if ((tmp <> '') and (tmp <> sRegAssociation)) then
  			freg.WriteString(sRegAssociationOld, tmp);

		freg.WriteString('', sRegAssociation);
		freg.CloseKey();
    	end;

    FreeAndNil(freg);
end;

procedure TfrmOptions.UnsetExt(ext: string);
var
	freg: TFRegistry;
	tmp: string;
begin
    freg := TFRegistry.Create(RA_FULL);
    freg.RootKey := HKEY_CLASSES_ROOT;

	if freg.OpenKey('\.' + ext, false) then
    	begin
  		if (freg.RStr('', '') = sRegAssociation) then
    		begin
			if freg.ValueExists(sRegAssociationOld) then
      			begin
      			tmp := freg.RStr(sRegAssociationOld, '');
      			freg.WriteString('', tmp);
      			freg.DeleteValue(sRegAssociationOld);
      			end
    		else
      			freg.WriteString('', '');
    		end
  		else
    		if freg.ValueExists(sRegAssociationOld) then
      			freg.DeleteValue(sRegAssociationOld);

		freg.CloseKey();
    	end;

    FreeAndNil(freg);
end;

procedure TfrmOptions.SaveFormats();
var
	i: integer;
begin
    for i := 0 to (lvwExt.Items.Count - 1) do
  		begin
  		if lvwExt.Items[i].Checked then
    		SetExt(lvwExt.Items[i].Caption)
  		else
    		if GetExt(lvwExt.Items[i].Caption) then
      			UnsetExt(lvwExt.Items[i].Caption);
  		end;
end;

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
end;

procedure TfrmOptions.FormDestroy(Sender: TObject);
begin
	frmOptions := nil;
end;

procedure TfrmOptions.btnCancelClick(Sender: TObject);
begin
	Self.Close();
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
var
	wreg: TFRegistry;
begin
	wreg := TFRegistry.Create(RA_READONLY);
	wreg.RootKey := HKEY_CURRENT_USER;

    SetStyleAsLink(lblAddParams);

    InitFormats();

    FreeAndNil(wreg);

    if not IsStrongUser() then
        begin
		MessageBox(Self.Handle, PChar('You are running this application as a user with limited permissions, so file format associations will be unavailable.'), sAppName, MB_OK or MB_ICONERROR);
        Close();
        end;
end;

procedure TfrmOptions.btnOKClick(Sender: TObject);
var
    wreg: TFRegistry;
begin
	wreg := TFRegistry.Create(RA_FULL);
	wreg.RootKey := HKEY_CURRENT_USER;

    // file formats
    if IsStrongUser() then
        begin
    	SaveFormats();
		WriteHandler();
        end;

	UpdateAssociations();

    FreeAndNil(wreg);

	Self.Close();
end;

procedure TfrmOptions.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

procedure TfrmOptions.lblAddParamsClick(Sender: TObject);
begin
	if not Assigned(frmOptFormats) then
  		begin
  		Application.CreateForm(TfrmOptFormats, frmOptFormats);
  		frmOptFormats.ShowModal();
  		end;
end;

procedure TfrmOptions.piSelectAllClick(Sender: TObject);
var
	i: integer;
begin
    for i := 0 to (lvwExt.Items.Count - 1) do
  		lvwExt.Items[i].Checked := true;
end;

procedure TfrmOptions.piSelectNoneClick(Sender: TObject);
var
	i: integer;
begin
    for i := 0 to (lvwExt.Items.Count - 1) do
  		lvwExt.Items[i].Checked := false;
end;

procedure TfrmOptions.cbxShowRareClick(Sender: TObject);
begin
	InitFormats();
end;

end.
