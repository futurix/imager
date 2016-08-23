unit w_about;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, c_ver;

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
    { Public declarations }
  end;

var
	frmAbout: TfrmAbout;


implementation

uses main, globals;

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
	frmAbout.Close();
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
var
	major, minor, release, build: integer;
	ver: TVInfo;
begin
	imgAbout.Picture.Icon.Handle := LoadImage(HInstance, 'MAINICON', IMAGE_ICON, 48, 48, LR_DEFAULTCOLOR);

    lblCopy.Caption := '© 1999-2005 Alexander Tereshchenko';

	// getting version info
	ver := TVInfo.Create();
	ver.Filename := Application.ExeName;

	major := ver.FileVersion.Major;
	minor := ver.FileVersion.Minor;
	release := ver.FileVersion.Release;
	build := ver.FileVersion.Build;

	FreeAndNil(ver);

	// displaying version info
    if release = 0 then
  		lblProgram.Caption := 'Futuris Imager ' + IntToStr(major) + '.' + IntToStr(minor)
	else
  		lblProgram.Caption := 'Futuris Imager ' + IntToStr(major) + '.' + IntToStr(minor) + '.' + IntToStr(release);

    if is_beta then
    	lblProgram.Caption := lblProgram.Caption + ' BETA';

    lblProgram.Caption := lblProgram.Caption + ' (' + 'build' + ' ' + IntToStr(build) + ')';
end;

procedure TfrmAbout.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

procedure TfrmAbout.lblWebClick(Sender: TObject);
begin
	frmMain.miFuturisWebSiteClick(Self);
end;

end.
