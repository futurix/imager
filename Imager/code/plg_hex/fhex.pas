unit fhex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, MPHexEditor, c_const, StdCtrls;

type
  TfrmHex = class(TForm)
    hexEditor: TMPHexEditor;
    pnlBottom: TPanel;
    btnClose: TButton;
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHex: TfrmHex;

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
function FIPIStool(info,path: PChar; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;

implementation

{$R *.dfm}

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL;
begin
func(PT_FTOOL,'View as HEX...',' ');
Result:=true;
end;

function FIPIStool(info,path: PChar; app, wnd: THandle; img: hBitmap):hBitmap;
begin
Application.Handle:=app;

if ((String(path)<>'') and (FileExists(String(path)))) then
	begin
	frmHex:=TfrmHex.Create(Application);
	frmHex.hexEditor.LoadFromFile(String(path));
	frmHex.ShowModal();
	FreeAndNil(frmHex);
	end
else
	Application.MessageBox('This tool can view only saved (and existing) files.', sAppName, MB_OK + MB_ICONINFORMATION);

Result:=0;
end;

procedure TfrmHex.btnCloseClick(Sender: TObject);
begin
Self.Close();
end;

exports
  FIPISquery, FIPIStool;

end.
