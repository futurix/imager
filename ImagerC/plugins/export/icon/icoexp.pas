unit icoexp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, jvIcon;

type
  TfrmICOExport = class(TForm)
    gbxColors: TGroupBox;
    rbn16: TRadioButton;
    rbn256: TRadioButton;
    btnCancel: TButton;
    btnOK: TButton;
    imgPreview: TImage;
    dlgICOSave: TSaveDialog;
    icnExport: TjvIcon;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmICOExport: TfrmICOExport;

function FIPISexport(info: PChar; app: THandle; img: hBitmap):integer; stdcall;

implementation

{$R *.DFM}

function FIPISexport(info: PChar; app: THandle; img: hBitmap):integer;
begin
Application.Handle:=app;
// form
frmICOExport:=TfrmICOExport.Create(Application);
frmICOExport.imgPreview.Picture.Bitmap.Handle:=img;
frmICOExport.ShowModal();
// cleaning
frmICOExport.Free();
Result:=1;
end;

procedure TfrmICOExport.btnCancelClick(Sender: TObject);
begin
Close();
end;

procedure TfrmICOExport.btnOKClick(Sender: TObject);
begin
if dlgICOSave.Execute then begin
                           if not FileExists(dlgICOSave.FileName) then begin
                                                                       if rbn16.Checked then icnExport.SaveAsIcon16(imgPreview.Picture.Bitmap,dlgICOSave.FileName)
                                                                       else icnExport.SaveAsIcon256(imgPreview.Picture.Bitmap,dlgICOSave.FileName);
                                                                       end;
                           end;
Close();
end;

end.
