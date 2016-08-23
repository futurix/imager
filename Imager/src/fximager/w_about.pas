unit w_about;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, c_const, c_locales;

type
  TfrmAbout = class(TForm)
    btnOK: TButton;
    lblProgram: TLabel;
    lblCopy: TLabel;
    imgAbout: TImage;
    lblWeb: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblWebClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Localize();
  end;

var
	frmAbout: TfrmAbout;


implementation

uses main;

{$R *.DFM}

procedure TfrmAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
end;

procedure TfrmAbout.FormDestroy(Sender: TObject);
begin
	frmAbout := nil;
end;

procedure TfrmAbout.btnOKClick(Sender: TObject);
begin
	Self.Close();
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
    Localize();

	imgAbout.Picture.Icon.Handle := LoadImage(HInstance, 'MAINICON', IMAGE_ICON, 48, 48, LR_DEFAULTCOLOR);

    lblCopy.Caption := sRights;
    lblProgram.Caption := sAppName + ' ' + sVersion;
end;

procedure TfrmAbout.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

procedure TfrmAbout.lblWebClick(Sender: TObject);
begin
	frmMain.miWebSiteClick(Self);
end;

procedure TfrmAbout.Localize();
begin
    Self.Caption 		:= Format(LoadLStr(700), [sAppName]);
    lblWeb.Caption 		:= Format(LoadLStr(701), [sAppName]);
	btnOK.Caption		:= LoadLStr(50);
end;

end.