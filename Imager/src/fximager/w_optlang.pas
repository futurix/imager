unit w_optlang;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, Dialogs, CheckLst, ShellAPI,
  c_const, c_utils, c_locales;

type
  TfrmOptLang = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    lblLocale: TLabel;
    cbxLanguages: TComboBox;
    lblGetLocales: TLabel;
    lblLocaleInfo: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblGetLocalesClick(Sender: TObject);
    procedure cbxLanguagesChange(Sender: TObject);
  private
    procedure InitPlugs();
  public
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Localize();
  end;

var
	frmOptLang: TfrmOptLang;

resourcestring
	sBuiltIn = 'Built-in (English)';


implementation

uses main, f_ui, f_plugins, f_scan, f_tools, w_show, w_optgeneral;

{$R *.DFM}

procedure TfrmOptLang.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
end;

procedure TfrmOptLang.FormDestroy(Sender: TObject);
begin
	frmOptLang := nil;
end;

procedure TfrmOptLang.btnCancelClick(Sender: TObject);
begin
	Self.Close();
end;

procedure TfrmOptLang.InitPlugs();
var
	langs: TStringList;
    locale_name: string;
begin
    // loading languages
    langs := TStringList.Create();
    cbxLanguages.Items.Clear();

    reg.OpenKey(sModules + '\' + PS_FLOCALE, true);
    reg.GetValueNames(langs);
    reg.CloseKey();

    langs.Sort();

    cbxLanguages.Items.Add(sBuiltIn);
    cbxLanguages.Items.AddStrings(langs);


    reg.OpenKey(sReg, true);
    locale_name := reg.RStr('CurrentLocale', '');
    reg.CloseKey();

    if (cbxLanguages.Items.IndexOf(locale_name) <> -1) then
    	cbxLanguages.ItemIndex := cbxLanguages.Items.IndexOf(locale_name)
    else
    	cbxLanguages.ItemIndex := 0;

    cbxLanguagesChange(Self);
    FreeAndNil(langs);
end;

procedure TfrmOptLang.FormCreate(Sender: TObject);
begin
    Localize();

	InitPlugs();
end;

procedure TfrmOptLang.btnOKClick(Sender: TObject);
begin
    // saving settings
    if (cbxLanguages.Items[cbxLanguages.ItemIndex] <> sBuiltIn) then
    	begin
    	reg.OpenKey(sReg, true);
    	reg.WString('CurrentLocale', cbxLanguages.Items[cbxLanguages.ItemIndex]);
    	reg.CloseKey();
        end
    else
    	begin
    	reg.OpenKey(sReg, true);
        reg.DeleteValue('CurrentLocale');
    	reg.CloseKey();
        end;

	// updating settings
    CleanLocalization();
    InitLocalization(HInstance);

	DoPluginScan();
	UpdatePlugIns();
    SetDialogs();

    frmOptGeneral.Localize();
    frmMain.Localize();
    if Assigned(frmShow) then
    	frmShow.Localize();

	SetDialogs();
	Header();

	Self.Close();
end;

procedure TfrmOptLang.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

procedure TfrmOptLang.CreateParams(var Params: TCreateParams);
begin
	Params.Style := (Params.Style or WS_POPUP);

	inherited;

	if (Owner is TForm) then
		Params.WndParent := (Owner as TWinControl).Handle
	else if Assigned(Screen.ActiveForm) then
		Params.WndParent := Screen.ActiveForm.Handle;
end;

procedure TfrmOptLang.Localize();
begin
    Self.Caption				:= LoadLStr(844);

    btnOK.Caption				:= LoadLStr(50);
    btnCancel.Caption			:= LoadLStr(51);
end;

procedure TfrmOptLang.lblGetLocalesClick(Sender: TObject);
begin
	OpenURL(sURLlocales);
end;

procedure TfrmOptLang.cbxLanguagesChange(Sender: TObject);
var
    locale_str: string;
    local_lib: THandle;
    show_infobox: boolean;
begin
    show_infobox := false;

	if (cbxLanguages.Items[cbxLanguages.ItemIndex] <> sBuiltIn) then
    	begin
        if (cbxLanguages.Items[cbxLanguages.ItemIndex] <> '') then
        	begin
            if reg.OpenKey(sModules + '\' + PS_FLOCALE, false) then
            	begin
                locale_str := reg.RStr(cbxLanguages.Items[cbxLanguages.ItemIndex], '');
                reg.CloseKey();

                if ((locale_str <> '') and FileExists(locale_str)) then
                	begin
                    local_lib := LoadLibraryEx(PChar(locale_str), 0, LOAD_LIBRARY_AS_DATAFILE);

                    if (local_lib <> 0) then
                    	begin
                        if (LoadResString(local_lib, 1) = sLocaleID) then
                        	begin
                            show_infobox := true;

                            lblLocaleInfo.Caption :=    'Language: ' + LoadResString(local_lib, 2) + #10 +
                            							'Translator: ' + LoadResString(local_lib, 4) + #10 + #10 +
                                                        'Last updated for: ' + sAppName + ' ' + LoadResString(local_lib, 5);
                            end;

                        FreeLibrary(local_lib);
                        end;
                    end;
                end;
            end;
        end;

    lblLocaleInfo.Visible := show_infobox;
end;

end.
