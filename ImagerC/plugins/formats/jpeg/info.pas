unit info;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, jpeg;

type
  TfrmInfo = class(TForm)
    btnOK: TButton;
    bvlFrame: TBevel;
    lblColor: TLabel;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function FIPISinfo(display, path, ext: PChar; app: THandle):integer; stdcall;

var
  frmInfo: TfrmInfo;

implementation

{$R *.DFM}

function FIPISinfo(display, path, ext: PChar; app: THandle):integer;
var
   jpg: TJpegImage;
begin
Application.Handle:=app;
try
   jpg:=TJpegImage.Create();
   jpg.LoadFromFile(display);
   frmInfo:=TfrmInfo.Create(Application);
   if jpg.Grayscale then frmInfo.lblColor.Caption:='Grayscale JPEG';
   frmInfo.ShowModal();
   jpg.Free();
   frmInfo.Free();
   Result:=1;
except
      Result:=0;
      end;
end;

procedure TfrmInfo.btnOKClick(Sender: TObject);
begin
Close();
end;

end.
