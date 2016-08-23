unit w_custzoom;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmCustZoom = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    lblCustZoom: TLabel;
    cbxZoom: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCustZoom: TfrmCustZoom;

implementation

uses main, globals, f_images, f_reg;

{$R *.DFM}

procedure TfrmCustZoom.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
reg.OpenKey(sReg + '\CustZoom',true);
reg.WriteString('Value',cbxZoom.Text);
reg.CloseKey();
end;

procedure TfrmCustZoom.FormDestroy(Sender: TObject);
begin
frmCustZoom:=nil;
end;

procedure TfrmCustZoom.btnCancelClick(Sender: TObject);
begin
Close();
end;

procedure TfrmCustZoom.btnOKClick(Sender: TObject);
var
   tmp: double;
begin
tmp:=0;
try
   tmp:=(StrToInt(cbxZoom.Text)/100);
   except
         Application.MessageBox('This is not valid percentage!','Error!',MB_OK+MB_ICONERROR);
         Abort();
                 end;
Zoom(tmp);
Close();
end;

procedure TfrmCustZoom.FormCreate(Sender: TObject);
begin
reg.OpenKey(sReg + '\CustZoom',true);
cbxZoom.Text:=RegReadStr('Value','75');
reg.CloseKey();
end;

end.
