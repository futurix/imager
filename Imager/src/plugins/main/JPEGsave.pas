unit JPEGsave;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, c_locales, c_const, c_reg;

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
    procedure FormCreate(Sender: TObject);
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
var
	reg: TFRegistry;
begin
    reg := TFRegistry.Create();

    reg.OpenKey(sSettings, true);
    reg.WInteger('SaverJPEG_Quality', tbrQuality.Position);
    reg.WBool('SaverJPEG_Progressive', cbxProgressive.Checked);
    reg.WBool('SaverJPEG_Optimized', cbxOptimized.Checked);
    reg.CloseKey();

    FreeAndNil(reg);


	jpeg_confirm := true;
	Self.Close();
end;

procedure TfrmJPEGsave.btnCancelClick(Sender: TObject);
begin
	Self.Close();
end;

procedure TfrmJPEGsave.tbrQualityChange(Sender: TObject);
begin
	lblQualityValue.Caption := IntToStr(tbrQuality.Position);
end;

procedure TfrmJPEGsave.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

procedure TfrmJPEGsave.FormCreate(Sender: TObject);
var
	reg: TFRegistry;
begin
    reg := TFRegistry.Create();

    reg.OpenKey(sSettings, true);
    tbrQuality.Position := reg.RInt('SaverJPEG_Quality', 85);
    cbxProgressive.Checked := reg.RBool('SaverJPEG_Progressive', false);
    cbxOptimized.Checked := reg.RBool('SaverJPEG_Optimized', true);
    reg.CloseKey();

    FreeAndNil(reg);


	Self.Caption				:= LoadLStr(3086);

    gbxQuality.Caption			:= LoadLStr(3087);

    cbxProgressive.Caption		:= LoadLStr(3088);
    cbxOptimized.Caption		:= LoadLStr(3089);

    btnSave.Caption				:= LoadLStr(56);
    btnCancel.Caption			:= LoadLStr(51);
end;

end.
