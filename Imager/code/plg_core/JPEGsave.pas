unit JPEGsave;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TfrmJPEGsave = class(TForm)
    btnSave: TButton;
    btnCancel: TButton;
    tbrQuality: TTrackBar;
    lblQualityValue: TLabel;
    cbxProgressive: TCheckBox;
    gbxQuality: TGroupBox;
    cbxOptimized: TCheckBox;
    bvlSep: TBevel;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tbrQualityChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmJPEGsave: TfrmJPEGsave;
  jpeg_confirm: boolean = false;


implementation

{$R *.dfm}

procedure TfrmJPEGsave.btnSaveClick(Sender: TObject);
begin
	jpeg_confirm := true;
	Self.Close();
end;

procedure TfrmJPEGsave.btnCancelClick(Sender: TObject);
begin
	Self.Close();
end;

procedure TfrmJPEGsave.tbrQualityChange(Sender: TObject);
begin
	lblQualityValue.Caption:=IntToStr(tbrQuality.Position);
end;

procedure TfrmJPEGsave.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

end.
