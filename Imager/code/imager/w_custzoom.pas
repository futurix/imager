unit w_custzoom;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, c_const, ComCtrls, Buttons;

type
  TfrmCustZoom = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    gbxCustomZoom: TGroupBox;
    tbrQuality: TTrackBar;
    lblQualityValue: TLabel;
    gbxQuickSelection: TGroupBox;
    sbnZ6: TSpeedButton;
    sbnZ66: TSpeedButton;
    sbnZ25: TSpeedButton;
    sbnZ100: TSpeedButton;
    sbnZ12: TSpeedButton;
    sbnZ50: TSpeedButton;
    sbnZ10: TSpeedButton;
    sbnZ75: TSpeedButton;
    sbnZ99: TSpeedButton;
    sbnZ33: TSpeedButton;
    sbnZ110: TSpeedButton;
    sbnZ125: TSpeedButton;
    sbnZ150: TSpeedButton;
    sbnZ175: TSpeedButton;
    sbnZ200: TSpeedButton;
    sbnZ300: TSpeedButton;
    sbnZ400: TSpeedButton;
    sbnZ500: TSpeedButton;
    sbnZ800: TSpeedButton;
    sbnZ1000: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbrQualityChange(Sender: TObject);
    procedure QuickZoom(zoom_value: integer);
    procedure sbnZ6Click(Sender: TObject);
    procedure sbnZ10Click(Sender: TObject);
    procedure sbnZ12Click(Sender: TObject);
    procedure sbnZ25Click(Sender: TObject);
    procedure sbnZ33Click(Sender: TObject);
    procedure sbnZ50Click(Sender: TObject);
    procedure sbnZ66Click(Sender: TObject);
    procedure sbnZ75Click(Sender: TObject);
    procedure sbnZ99Click(Sender: TObject);
    procedure sbnZ100Click(Sender: TObject);
    procedure sbnZ110Click(Sender: TObject);
    procedure sbnZ125Click(Sender: TObject);
    procedure sbnZ150Click(Sender: TObject);
    procedure sbnZ175Click(Sender: TObject);
    procedure sbnZ200Click(Sender: TObject);
    procedure sbnZ300Click(Sender: TObject);
    procedure sbnZ400Click(Sender: TObject);
    procedure sbnZ500Click(Sender: TObject);
    procedure sbnZ800Click(Sender: TObject);
    procedure sbnZ1000Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TfrmCustZoom.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;

	reg.OpenKey(sReg + '\CustZoom', true);
	reg.WInteger('Value', tbrQuality.Position);
	reg.CloseKey();
end;

procedure TfrmCustZoom.FormDestroy(Sender: TObject);
begin
	frmCustZoom := nil;
end;

procedure TfrmCustZoom.btnCancelClick(Sender: TObject);
begin
	Close();
end;

procedure TfrmCustZoom.btnOKClick(Sender: TObject);
begin
	Zoom(tbrQuality.Position, true);
	Close();
end;

procedure TfrmCustZoom.FormCreate(Sender: TObject);
begin
	reg.OpenKey(sReg + '\CustZoom', true);
	tbrQuality.Position := reg.RIntC('Value', 100);
	reg.CloseKey();
end;

procedure TfrmCustZoom.tbrQualityChange(Sender: TObject);
begin
	lblQualityValue.Caption := IntToStr(tbrQuality.Position);
end;

procedure TfrmCustZoom.QuickZoom(zoom_value: integer);
begin
	Zoom(zoom_value, true);
	Close();
end;

procedure TfrmCustZoom.sbnZ6Click(Sender: TObject);
begin
	QuickZoom(6);
end;

procedure TfrmCustZoom.sbnZ10Click(Sender: TObject);
begin
	QuickZoom(10);
end;

procedure TfrmCustZoom.sbnZ12Click(Sender: TObject);
begin
	QuickZoom(12);
end;

procedure TfrmCustZoom.sbnZ25Click(Sender: TObject);
begin
	QuickZoom(25);
end;

procedure TfrmCustZoom.sbnZ33Click(Sender: TObject);
begin
	QuickZoom(33);
end;

procedure TfrmCustZoom.sbnZ50Click(Sender: TObject);
begin
	QuickZoom(50);
end;

procedure TfrmCustZoom.sbnZ66Click(Sender: TObject);
begin
	QuickZoom(66);
end;

procedure TfrmCustZoom.sbnZ75Click(Sender: TObject);
begin
	QuickZoom(75);
end;

procedure TfrmCustZoom.sbnZ99Click(Sender: TObject);
begin
	QuickZoom(99);
end;

procedure TfrmCustZoom.sbnZ100Click(Sender: TObject);
begin
	QuickZoom(100);
end;

procedure TfrmCustZoom.sbnZ110Click(Sender: TObject);
begin
	QuickZoom(110);
end;

procedure TfrmCustZoom.sbnZ125Click(Sender: TObject);
begin
	QuickZoom(125);
end;

procedure TfrmCustZoom.sbnZ150Click(Sender: TObject);
begin
	QuickZoom(150);
end;

procedure TfrmCustZoom.sbnZ175Click(Sender: TObject);
begin
	QuickZoom(175);
end;

procedure TfrmCustZoom.sbnZ200Click(Sender: TObject);
begin
	QuickZoom(200);
end;

procedure TfrmCustZoom.sbnZ300Click(Sender: TObject);
begin
	QuickZoom(300);
end;

procedure TfrmCustZoom.sbnZ400Click(Sender: TObject);
begin
	QuickZoom(400);
end;

procedure TfrmCustZoom.sbnZ500Click(Sender: TObject);
begin
	QuickZoom(500);
end;

procedure TfrmCustZoom.sbnZ800Click(Sender: TObject);
begin
	QuickZoom(800);
end;

procedure TfrmCustZoom.sbnZ1000Click(Sender: TObject);
begin
	QuickZoom(1000);
end;

procedure TfrmCustZoom.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

end.
