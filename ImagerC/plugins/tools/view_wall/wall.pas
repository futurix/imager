unit wall;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TileImage;

type
  TfrmWallpaper = class(TForm)
    pnlButtons: TPanel;
    sbxWall: TScrollBox;
    tilWall: TTileImage;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function FIPIStool(info,path: PChar; app: THandle; img: hBitmap):hBitmap; stdcall;

var
  frmWallpaper: TfrmWallpaper;

implementation

{$R *.DFM}

function FIPIStool(info,path: PChar; app: THandle; img: hBitmap):hBitmap;
var
   image: TBitmap;
begin
Application.Handle:=app;
image:=TBitmap.Create();
image.Handle:=img;
frmWallpaper:=TfrmWallpaper.Create(Application);
frmWallpaper.tilWall.Picture.Assign(image);
frmWallpaper.ShowModal();
image.ReleaseHandle();
image.Free();
frmWallpaper.Free();
Result:=0;
end;

procedure TfrmWallpaper.btnOKClick(Sender: TObject);
begin
frmWallpaper.Close();
end;

procedure TfrmWallpaper.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrmWallpaper.FormDestroy(Sender: TObject);
begin
frmWallpaper:=nil;
end;

procedure TfrmWallpaper.btn640x480Click(Sender: TObject);
begin
tilWall.Width:=640;
tilWall.Height:=480;
end;

procedure TfrmWallpaper.btn800x600Click(Sender: TObject);
begin
tilWall.Width:=800;
tilWall.Height:=600;
end;

procedure TfrmWallpaper.btn1024x768Click(Sender: TObject);
begin
tilWall.Width:=1024;
tilWall.Height:=768;
end;

procedure TfrmWallpaper.btn1280x1024Click(Sender: TObject);
begin
tilWall.Width:=1280;
tilWall.Height:=1024;
end;

procedure TfrmWallpaper.btn1600x1200Click(Sender: TObject);
begin
tilWall.Width:=1600;
tilWall.Height:=1200;
end;

procedure TfrmWallpaper.btn3000x2250Click(Sender: TObject);
begin
tilWall.Width:=3000;
tilWall.Height:=2250;
end;

procedure TfrmWallpaper.btnSetCustomClick(Sender: TObject);
var
   tmp_w, tmp_h: integer;
begin
tmp_w:=768;
tmp_h:=576;
try
   tmp_w:=StrToInt(edtCustWidth.Text);
   tmp_h:=StrToint(edtCustHeight.Text);
   except
         on EConvertError do begin
                             //frmMain.R('Not valid numerics!');
                             Abort();
                             end;
         else Abort();
         end;
tilWall.Width:=tmp_w;
tilWall.Height:=tmp_h;
end;

end.
