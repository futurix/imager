unit pos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls;

type
  TfrmSetPos = class(TForm)
    lblTop: TLabel;
    lblLeft: TLabel;
    edtTop: TEdit;
    edtLeft: TEdit;
    btnOK: TButton;
    btnReset: TButton;
    updTop: TUpDown;
    updLeft: TUpDown;
    pnlPosition: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSetPos: TfrmSetPos;

implementation

uses view;

{$R *.DFM}

procedure TfrmSetPos.FormCreate(Sender: TObject);
begin
updTop.Position:=p_top;
updLeft.Position:=p_left;
end;

procedure TfrmSetPos.btnResetClick(Sender: TObject);
begin
p_top:=0;
p_left:=0;
Close();
frmPrint.tbnDrawClick(frmSetPos);
end;

procedure TfrmSetPos.btnOKClick(Sender: TObject);
var
   t_top, t_left: integer;
begin
t_top:=0;
t_left:=0;
try
   t_top:=StrToInt(edtTop.Text);
   t_left:=StrToInt(edtLeft.Text);
   except
         on EConvertError do begin
                             Application.MessageBox('You need to input valid numerics.','Futuris Imager',MB_OK+MB_ICONERROR);
                             Abort();
                             end;
   else Abort();
   end;
   p_top:=t_top;
   p_left:=t_left;
   Close();
   frmPrint.tbnDrawClick(frmSetPos);
end;

end.
