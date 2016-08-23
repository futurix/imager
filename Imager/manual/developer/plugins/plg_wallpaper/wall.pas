unit wall;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TileImage,
  c_const;

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
    pnlClose: TPanel;
    btn1920x1200: TButton;
    btn3200x1200: TButton;
    btn2560x1024: TButton;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
function FTool(info,path: PChar; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;

var
  frmWallpaper: TfrmWallpaper;
  image: TBitmap;


implementation

uses swall;

{$R *.DFM}

function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL;
begin
	func(PT_FTOOL, 'View as Wallpaper...', ' ');
	func(PT_FTOOL, 'Set as Wallpaper...', ' ');
	Result := true;
end;

function FTool(info, path: PChar; app, wnd: THandle; img: hBitmap):hBitmap;
begin
	Application.Handle := app;
	image := TBitmap.Create();
	image.Handle := img;

    if (info = 'View as Wallpaper...') then
    	begin
		frmWallpaper := TfrmWallpaper.Create(Application);
		frmWallpaper.tilWall.Picture.Assign(image);
		frmWallpaper.ShowModal();
    	FreeAndNil(frmWallpaper);
    	end
    else
    	begin
		frmWallpaperS := TfrmWallpaperS.Create(Application);
		frmWallpaperS.ShowModal();
		FreeAndNil(frmWallpaperS);
        end;

	image.ReleaseHandle();
	FreeAndNil(image);

	Result := 0;
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
edtCustWidth.Text:='640';
edtCustHeight.Text:='480';
end;

procedure TfrmWallpaper.btn800x600Click(Sender: TObject);
begin
tilWall.Width:=800;
tilWall.Height:=600;
edtCustWidth.Text:='800';
edtCustHeight.Text:='600';
end;

procedure TfrmWallpaper.btn1024x768Click(Sender: TObject);
begin
tilWall.Width:=1024;
tilWall.Height:=768;
edtCustWidth.Text:='1024';
edtCustHeight.Text:='768';
end;

procedure TfrmWallpaper.btn1280x1024Click(Sender: TObject);
begin
tilWall.Width:=1280;
tilWall.Height:=1024;
edtCustWidth.Text:='1280';
edtCustHeight.Text:='1024';
end;

procedure TfrmWallpaper.btn1600x1200Click(Sender: TObject);
begin
tilWall.Width:=1600;
tilWall.Height:=1200;
edtCustWidth.Text:='1600';
edtCustHeight.Text:='1200';
end;

procedure TfrmWallpaper.btn3000x2250Click(Sender: TObject);
begin
tilWall.Width:=3000;
tilWall.Height:=2250;
edtCustWidth.Text:='3000';
edtCustHeight.Text:='2250';
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
  on EConvertError do
    begin
    //frmMain.R('Not valid numerics!');
    Abort();
    end;
  else Abort();
  end;
tilWall.Width:=tmp_w;
tilWall.Height:=tmp_h;
end;

procedure TfrmWallpaper.btn1920x1200Click(Sender: TObject);
begin
tilWall.Width:=1920;
tilWall.Height:=1200;
edtCustWidth.Text:='1920';
edtCustHeight.Text:='1200';
end;

procedure TfrmWallpaper.btn3200x1200Click(Sender: TObject);
begin
tilWall.Width:=3200;
tilWall.Height:=1200;
edtCustWidth.Text:='3200';
edtCustHeight.Text:='1200';
end;

procedure TfrmWallpaper.btn2560x1024Click(Sender: TObject);
begin
tilWall.Width:=2560;
tilWall.Height:=1024;
edtCustWidth.Text:='2560';
edtCustHeight.Text:='1024';
end;

exports
  FQuery, FTool;

end.
