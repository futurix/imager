unit w_optformats;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, Dialogs, ShellAPI,
  c_const, c_utils, c_reg;

type
  TfrmOptFormats = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    gbxIcon: TGroupBox;
    imgIcon1: TImage;
    imgIcon2: TImage;
    imgIcon3: TImage;
    imgIcon4: TImage;
    rbnIcon1: TRadioButton;
    rbnIcon2: TRadioButton;
    rbnIcon3: TRadioButton;
    rbnIcon4: TRadioButton;
    cbxFS: TCheckBox;
    lblRestoreIcon: TLabel;
    lblChangeDescr: TLabel;

	procedure ChangeDescription();

	procedure imgIcon1Click(Sender: TObject);
	procedure imgIcon2Click(Sender: TObject);
	procedure imgIcon3Click(Sender: TObject);
	procedure imgIcon4Click(Sender: TObject);
    procedure rbnIcon1Click(Sender: TObject);
    procedure rbnIcon2Click(Sender: TObject);
    procedure rbnIcon3Click(Sender: TObject);
    procedure rbnIcon4Click(Sender: TObject);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblRestoreIconClick(Sender: TObject);
    procedure lblChangeDescrClick(Sender: TObject);
  private
  public
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
	frmOptFormats: TfrmOptFormats;
	icon_num: integer = 1;
	description: string = '';


implementation

uses f_tools;

{$R *.DFM}

// change description
procedure TfrmOptFormats.ChangeDescription();
var
	tmp: string;
begin
	tmp := description;

    InputQuery('Description change', 'You can change supported formats description, that appears in Windows Explorer...', tmp);

	if (tmp <> '') then
  		begin
  		description := tmp;
  		WriteHandler();
  		end;
end;

procedure TfrmOptFormats.imgIcon1Click(Sender: TObject);
begin
	rbnIcon1.Checked := true;
	icon_num := 1;
end;

procedure TfrmOptFormats.imgIcon2Click(Sender: TObject);
begin
	rbnIcon2.Checked := true;
	icon_num := 2;
end;

procedure TfrmOptFormats.imgIcon3Click(Sender: TObject);
begin
	rbnIcon3.Checked := true;
	icon_num := 3;
end;

procedure TfrmOptFormats.imgIcon4Click(Sender: TObject);
begin
	rbnIcon4.Checked := true;
	icon_num := 4;
end;

procedure TfrmOptFormats.rbnIcon1Click(Sender: TObject);
begin
	icon_num := 1;
end;

procedure TfrmOptFormats.rbnIcon2Click(Sender: TObject);
begin
	icon_num := 2;
end;

procedure TfrmOptFormats.rbnIcon3Click(Sender: TObject);
begin
	icon_num := 3;
end;

procedure TfrmOptFormats.rbnIcon4Click(Sender: TObject);
begin
	icon_num := 4;
end;

procedure TfrmOptFormats.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
end;

procedure TfrmOptFormats.FormDestroy(Sender: TObject);
begin
	frmOptFormats := nil;
end;

procedure TfrmOptFormats.btnCancelClick(Sender: TObject);
begin
	Self.Close();
end;

procedure TfrmOptFormats.FormCreate(Sender: TObject);
begin
	imgIcon1.Picture.Icon.Handle := LoadIcon(HInstance, MAKEINTRESOURCE(1));
	imgIcon2.Picture.Icon.Handle := LoadIcon(HInstance, MAKEINTRESOURCE(2));
	imgIcon3.Picture.Icon.Handle := LoadIcon(HInstance, MAKEINTRESOURCE(3));
	imgIcon4.Picture.Icon.Handle := LoadIcon(HInstance, MAKEINTRESOURCE(4));

	icon_num := FxRegRInt('Formats_Icon', 1);
	
    case icon_num of
		1: rbnIcon1.Checked := true;
  		2: rbnIcon2.Checked := true;
		3: rbnIcon3.Checked := true;
  		4: rbnIcon4.Checked := true;
	end;

	cbxFS.Checked := FxRegRBool('Formats_FullScreen', false);
	description := FxRegRStr('Formats_Description', Format('%s Document', [sAppName]));
end;

procedure TfrmOptFormats.btnOKClick(Sender: TObject);
begin
	FxRegWInt('Formats_Icon', icon_num);
	FxRegWBool('Formats_FullScreen', cbxFS.Checked);
	FxRegWStr('Formats_Description', description);

	Self.Close();
end;

procedure TfrmOptFormats.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

procedure TfrmOptFormats.lblRestoreIconClick(Sender: TObject);
var
	wreg: TFRegistry;
begin
	wreg := TFRegistry.Create(RA_FULL);
	wreg.RootKey := HKEY_CLASSES_ROOT;

	if wreg.OpenKey('\.ico', false) then
		begin
		wreg.WString('', 'icofile');
		wreg.CloseKey();

		UpdateAssociations();
        Application.MessageBox(PChar('Done.'), sAppName, MB_OK + MB_ICONINFORMATION);
		end;

	FreeAndNil(wreg);
end;

procedure TfrmOptFormats.lblChangeDescrClick(Sender: TObject);
begin
	ChangeDescription();
end;

procedure TfrmOptFormats.CreateParams(var Params: TCreateParams);
begin
	Params.Style := (Params.Style or WS_POPUP);

	inherited;

	if (Owner is TForm) then
		Params.WndParent := (Owner as TWinControl).Handle
	else if Assigned(Screen.ActiveForm) then
		Params.WndParent := Screen.ActiveForm.Handle;
end;

end.
