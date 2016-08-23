unit selcolor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ColorPickerButton;

type
  TfrmSelectColor = class(TForm)
    cpbMain: TColorPickerButton;
    btnOK: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelectColor: TfrmSelectColor;

function FHelpSelectColor(color: TColor; app, wnd: THandle):TColor; cdecl;

implementation

{$R *.dfm}

function FHelpSelectColor(color: TColor; app, wnd: THandle):TColor;
begin
Application.Handle:=app;
frmSelectColor:=TfrmSelectColor.Create(nil);
frmSelectColor.DoubleBuffered:=true;
frmSelectColor.cpbMain.SelectionColor:=color;
frmSelectColor.ShowModal();
Result:=frmSelectColor.cpbMain.SelectionColor;
FreeAndNil(frmSelectColor);
end;

procedure TfrmSelectColor.btnOKClick(Sender: TObject);
begin
Self.Close();
end;

procedure TfrmSelectColor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=VK_ESCAPE then
  Self.Close();
end;

end.
