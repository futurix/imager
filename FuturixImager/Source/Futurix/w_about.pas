unit w_about;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DwmApi,
  c_const, c_utils, c_ui;

type
  TfrmAbout = class(TForm)
    lblProgram: TLabel;
    lblCopy: TLabel;
    lblWeb: TLabel;
    lblUK: TLabel;
    lblSoftware: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblWebClick(Sender: TObject);
  private
  public
  end;

var
  frmAbout: TfrmAbout;


implementation

uses w_main, fx_defs;

{$R *.DFM}

procedure TfrmAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmAbout.FormDestroy(Sender: TObject);
begin
  frmAbout := nil;
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
var
  ver, add: string;
begin
  lblProgram.Caption := sAppName;
  lblCopy.Caption := sRights;
  lblWeb.Caption := Format('Visit %s website', [sAppName]);

  SetStyleAsLink(lblWeb);
  lblWeb.Hint := sURL;

  case ver_status of
    0: add := '';
    1: add := ' Alpha ' + IntToStr(ver_number);
    2: add := ' Beta ' + IntToStr(ver_number);
    3: add := ' Gamma ' + IntToStr(ver_number);
    7: add := ' RC ' + IntToStr(ver_number);
    else
      add := '';
  end;

  if ((ver_status > 0) and (ver_codename <> '')) then
    ver := '"' + ver_codename + '"'
  else
    ver := sVersion;

  lblProgram.Caption := 'Version ' + ver + add;

  // workaround for systems without AERO
  if not IsVista() or not DwmCompositionEnabled() then
    Color := clWindow;
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

end.
