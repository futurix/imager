unit w_custzoom;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons,
  c_const, c_locales, c_reg, c_lang;

type
  TfrmCustZoom = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    tbrQuality: TTrackBar;
    lblQualityValue: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbrQualityChange(Sender: TObject);
    procedure QuickZoom(zoom_value: integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    procedure Localize();
  end;

var
  frmCustZoom: TfrmCustZoom;


implementation

uses w_main, f_images;

{$R *.DFM}

procedure TfrmCustZoom.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  FxRegWInt('CustZoom', tbrQuality.Position);
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
  Localize();

  tbrQuality.Position := FxRegRInt('CustZoom', 100);
end;

procedure TfrmCustZoom.tbrQualityChange(Sender: TObject);
begin
  lblQualityValue.Caption :=
    Format(GetLString(FXL_T_PERCENT), [IntToStr(tbrQuality.Position)]);
end;

procedure TfrmCustZoom.QuickZoom(zoom_value: integer);
begin
  Zoom(zoom_value, true);
  Close();
end;

procedure TfrmCustZoom.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Self.Close();
end;

procedure TfrmCustZoom.Localize();
begin
  Self.Caption            := LoadLStr(710);
  btnOK.Caption           := LoadLStr(50);
  btnCancel.Caption       := LoadLStr(51);
end;

end.
