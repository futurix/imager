unit w_about;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, VersInfo;

type
  TfrmAbout = class(TForm)
    btnOK: TButton;
    lblProgram: TLabel;
    lblCopy: TLabel;
    imgAbout: TImage;
    verAbout: TdfsVersionInfoResource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
Action:=caFree;
end;

procedure TfrmAbout.FormDestroy(Sender: TObject);
begin
frmAbout:=nil;
end;

procedure TfrmAbout.btnOKClick(Sender: TObject);
begin
frmAbout.Close();
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
var
   tmp: string;
begin
imgAbout.Picture.Icon.Handle:=LoadIcon(HInstance,'MAINICON');
verAbout.Filename:=Application.ExeName;
tmp:='Futuris Imager ' + IntToStr(verAbout.FileVersion.Major) + '.' + IntToStr(verAbout.FileVersion.Minor);
if verAbout.FileVersion.Release<>0 then tmp:= tmp + IntToStr(verAbout.FileVersion.Release);
tmp:= tmp + ' (build ' + IntToStr(verAbout.FileVersion.Build) + ')';
lblProgram.Caption:=tmp;
end;

end.
