unit TIFFsave;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls;

type
  TfrmTIFFsave = class(TForm)
    gbxCompression: TGroupBox;
    rbnCNone: TRadioButton;
    rbnCLZW: TRadioButton;
    rbnCJPEG: TRadioButton;
    rbnCZLib: TRadioButton;
    rbnCPackBits: TRadioButton;
    rbnCG31: TRadioButton;
    rbnCG32: TRadioButton;
    rbnCG4: TRadioButton;
    gbxJPEG: TGroupBox;
    btnCancel: TButton;
    btnSave: TButton;
    tbrQuality: TTrackBar;
    lblQualityValue: TLabel;
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
  frmTIFFsave: TfrmTIFFsave;
  tiff_confirm: boolean = false;

implementation

{$R *.dfm}

procedure TfrmTIFFsave.btnSaveClick(Sender: TObject);
begin
tiff_confirm:=true;
Self.Close();
end;

procedure TfrmTIFFsave.btnCancelClick(Sender: TObject);
begin
Self.Close();
end;

procedure TfrmTIFFsave.tbrQualityChange(Sender: TObject);
begin
lblQualityValue.Caption:=IntToStr(tbrQuality.Position);
end;

procedure TfrmTIFFsave.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=VK_ESCAPE then
  Self.Close();
end;

end.
