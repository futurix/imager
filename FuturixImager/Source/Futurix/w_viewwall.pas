unit w_viewwall;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  ieview, imageenview, hyieutils,
  c_const, c_utils, c_str;

type
  TfrmWallpaper = class(TForm)
    pnlButtons: TPanel;
    sbxWall: TScrollBox;
    btnOK: TButton;
    btn800x600: TButton;
    btn1024x768: TButton;
    btn1280x1024: TButton;
    btn1600x1200: TButton;
    btn640x480: TButton;
    btn3000x2250: TButton;
    edtCustWidth: TEdit;
    edtCustHeight: TEdit;
    btnSetCustom: TButton;
    lblCustom: TLabel;
    lblX: TLabel;
    pnlClose: TPanel;
    btn1920x1200: TButton;
    btn3200x1200: TButton;
    btn2560x1024: TButton;
    imgWallpaper: TImageEnView;
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btn640x480Click(Sender: TObject);
    procedure btn800x600Click(Sender: TObject);
    procedure btn1024x768Click(Sender: TObject);
    procedure btn1280x1024Click(Sender: TObject);
    procedure btn1600x1200Click(Sender: TObject);
    procedure btn3000x2250Click(Sender: TObject);
    procedure btnSetCustomClick(Sender: TObject);
    procedure btn1920x1200Click(Sender: TObject);
    procedure btn3200x1200Click(Sender: TObject);
    procedure btn2560x1024Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure SetWallpaper(w, h: integer);
  public
  end;

var
  frmWallpaper: TfrmWallpaper;


implementation

uses fx_internalp;

{$R *.DFM}

procedure TfrmWallpaper.btnOKClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmWallpaper.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmWallpaper.FormDestroy(Sender: TObject);
begin
  frmWallpaper := nil;
end;

procedure TfrmWallpaper.SetWallpaper(w, h: integer);
begin
  imgWallpaper.Width := w;
  imgWallpaper.Height := h;

  edtCustWidth.Text := IntToStr(w);
  edtCustHeight.Text := IntToStr(h);
end;

procedure TfrmWallpaper.btn640x480Click(Sender: TObject);
begin
  SetWallpaper(640, 480);
end;

procedure TfrmWallpaper.btn800x600Click(Sender: TObject);
begin
  SetWallpaper(800, 600);
end;

procedure TfrmWallpaper.btn1024x768Click(Sender: TObject);
begin
  SetWallpaper(1024, 768);
end;

procedure TfrmWallpaper.btn1280x1024Click(Sender: TObject);
begin
  SetWallpaper(1280, 1024);
end;

procedure TfrmWallpaper.btn1600x1200Click(Sender: TObject);
begin
  SetWallpaper(1600, 1200);
end;

procedure TfrmWallpaper.btn3000x2250Click(Sender: TObject);
begin
  SetWallpaper(3000, 2250);
end;

procedure TfrmWallpaper.btnSetCustomClick(Sender: TObject);
var
  tmp_w, tmp_h: integer;
begin
  tmp_w := 768;
  tmp_h := 576;

  try
    tmp_w := StrToInt(edtCustWidth.Text);
    tmp_h := StrToint(edtCustHeight.Text);
    except
      on EConvertError do
        Abort();
      else
        Abort();
    end;

  SetWallpaper(tmp_w, tmp_h);
end;

procedure TfrmWallpaper.btn1920x1200Click(Sender: TObject);
begin
  SetWallpaper(1920, 1200);
end;

procedure TfrmWallpaper.btn3200x1200Click(Sender: TObject);
begin
  SetWallpaper(3200, 1200);
end;

procedure TfrmWallpaper.btn2560x1024Click(Sender: TObject);
begin
  SetWallpaper(2560, 1024);
end;

procedure TfrmWallpaper.FormCreate(Sender: TObject);
begin
  if IsThemed() then
    sbxWall.BorderStyle := bsNone;

  btn640x480.Caption    := Format(FXL_T_DIMENSIONS, [IntToStr(640), IntToStr(480)]);
  btn800x600.Caption    := Format(FXL_T_DIMENSIONS, [IntToStr(800), IntToStr(600)]);
  btn1024x768.Caption   := Format(FXL_T_DIMENSIONS, [IntToStr(1024), IntToStr(768)]);
  btn1280x1024.Caption  := Format(FXL_T_DIMENSIONS, [IntToStr(1280), IntToStr(1024)]);
  btn1600x1200.Caption  := Format(FXL_T_DIMENSIONS, [IntToStr(1600), IntToStr(1200)]);
  btn3000x2250.Caption  := Format(FXL_T_DIMENSIONS, [IntToStr(3000), IntToStr(2250)]);
  btn1920x1200.Caption  := Format(FXL_T_DIMENSIONS, [IntToStr(1920), IntToStr(1200)]);
  btn3200x1200.Caption  := Format(FXL_T_DIMENSIONS, [IntToStr(3200), IntToStr(1200)]);
  btn2560x1024.Caption  := Format(FXL_T_DIMENSIONS, [IntToStr(2560), IntToStr(1024)]);
end;

end.
