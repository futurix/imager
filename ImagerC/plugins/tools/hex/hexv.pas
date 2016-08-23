unit hexv;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, futuris_hint, hexeditor, ImgList, ComCtrls, ToolWin;

type
  TfrmHex = class(TForm)
    edtHex: THexEditor;
    tbrHex: TToolBar;
    tbnOpen: TToolButton;
    imlHex: TImageList;
    dlgHexOpen: TOpenDialog;
    tbnClose: TToolButton;
    procedure tbnOpenClick(Sender: TObject);
    procedure tbnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHex: TfrmHex;

function FIPIStool(info,path: PChar; app: THandle; img: hBitmap):hBitmap; stdcall;

implementation

{$R *.DFM}

function FIPIStool(info,path: PChar; app: THandle; img: hBitmap):hBitmap;
begin
Application.Handle:=app;
frmHex:=TfrmHex.Create(Application);
frmHex.edtHex.LoadFromFile(String(path));
frmHex.ShowModal();
frmHex.Free();
Result:=0;
end;

procedure TfrmHex.tbnOpenClick(Sender: TObject);
begin
if dlgHexOpen.Execute then if FileExists(dlgHexOpen.FileName) then edtHex.LoadFromFile(dlgHexOpen.FileName);
end;

procedure TfrmHex.tbnCloseClick(Sender: TObject);
begin
Close();
end;

end.
