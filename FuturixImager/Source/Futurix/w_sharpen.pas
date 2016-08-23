unit w_sharpen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImageEnProc,
  c_const, c_reg;

type
  TfrmSharpen = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    lblAmount: TLabel;
    trbAmount: TTrackBar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure trbAmountChange(Sender: TObject);
  private
    no_change: boolean;
  public
  end;

var
  frmSharpen: TfrmSharpen;


implementation

uses w_main, w_editor;

{$R *.dfm}

procedure TfrmSharpen.FormCreate(Sender: TObject);
begin
  no_change := false;

  // working
  if Assigned(frmEditor) then
    ProcessPreview(0);

  trbAmountChange(Self);
end;

procedure TfrmSharpen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmSharpen.FormDestroy(Sender: TObject);
begin
  frmSharpen := nil;
end;

procedure TfrmSharpen.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
    Self.Close();
end;

procedure TfrmSharpen.btnOKClick(Sender: TObject);
var
  tmp_value: integer;
begin
  tmp_value := trbAmount.Position;

  if (tmp_value < 1) then
    tmp_value := 1;

  if Assigned(frmEditor) then
    begin
    frmEditor.proc.Sharpen(tmp_value);
    frmEditor.proc.ClearAllRedo();
    end;

  Self.Close();
end;

procedure TfrmSharpen.btnCancelClick(Sender: TObject);
begin
  Self.Close();
end;

procedure TfrmSharpen.trbAmountChange(Sender: TObject);
var
  tmp_value: integer;
begin
  if no_change then
    Exit;

  no_change := true;

  tmp_value := trbAmount.Position;

  if (tmp_value < 1) then
    tmp_value := 1;

  if Assigned(frmEditor) then
    begin
    if frmEditor.img.Selected then
      frmEditor.img.CopySelectionToIEBitmap(frmEditor.imgPreview.IEBitmap)
    else
      frmEditor.imgPreview.IEBitmap.Assign(frmEditor.img.IEBitmap);

    frmEditor.imgPreview.Proc.Sharpen(tmp_value);
    end;

  no_change := false;
end;

end.
