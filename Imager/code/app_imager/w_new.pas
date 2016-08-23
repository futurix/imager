unit w_new;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, c_const, c_locales;

type
  TfrmNew = class(TForm)
    gbxSize: TGroupBox;
    gbxColor: TGroupBox;
    edtWidth: TEdit;
    edtHeight: TEdit;
    lblWidth: TLabel;
    lblHeight: TLabel;
    btnCancel: TButton;
    btnOK: TButton;
    sbxColor: TScrollBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sbxColorClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Localize();
  end;

var
	frmNew: TfrmNew;


implementation

uses f_graphics, main;

{$R *.DFM}

procedure TfrmNew.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	reg.OpenKey(sSettings, true);
	reg.WriteString('New_Width', edtWidth.Text);
	reg.WriteString('New_Height', edtHeight.Text);
	reg.WriteString('New_Color', ColorToString(sbxColor.Color));
	reg.CloseKey();

	Action := caFree;
end;

procedure TfrmNew.FormDestroy(Sender: TObject);
begin
	frmNew := nil;
end;

procedure TfrmNew.btnCancelClick(Sender: TObject);
begin
	Close();
end;

procedure TfrmNew.btnOKClick(Sender: TObject);
var
	w, h: integer;
	bmp: TBitmap;
begin
	w := 500;
	h := 350;

	try
  		w := StrToInt(edtWidth.Text);
  		h := StrToInt(edtHeight.Text);
  	except
        ShowMessage(LoadLStr(621));
    	Abort();
  	end;

    bmp := TBitmap.Create();
	bmp.Canvas.Brush.Color := sbxColor.Color;

	bmp.Width := w;
	bmp.Height := h;

	CloseImage();
	OpenUntitled(bmp);
	FreeAndNil(bmp);

	Close();
end;

procedure TfrmNew.FormCreate(Sender: TObject);
begin
    Localize();

	reg.OpenKey(sSettings, true);

	edtWidth.Text := reg.RStr('New_Width', '500');
	edtHeight.Text := reg.RStr('New_Height', '350');
	sbxColor.Color := StringToColor(reg.RStr('New_Color', 'clWhite'));

	reg.CloseKey();
end;

procedure TfrmNew.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

procedure TfrmNew.Localize();
begin
    Self.Caption				:= LoadLStr(740);

    gbxSize.Caption				:= LoadLStr(741);
    gbxColor.Caption			:= LoadLStr(742);
    lblWidth.Caption			:= LoadLStr(743);
    lblHeight.Caption			:= LoadLStr(744);
    sbxColor.Hint				:= LoadLStr(745);

    btnOK.Caption				:= LoadLStr(50);
    btnCancel.Caption			:= LoadLStr(51);
end;

procedure TfrmNew.sbxColorClick(Sender: TObject);
var
	dlg: TColorDialog;
begin
	dlg := TColorDialog.Create(Self);

    dlg.Color := sbxColor.Color;
    dlg.Options := [cdFullOpen, cdAnyColor];

    if dlg.Execute then
        sbxColor.Color := dlg.Color;

    FreeAndNil(dlg);
end;

end.
