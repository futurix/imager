unit wall;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComObj, ShlObj, ActiveX, c_const, c_utils;

type
  TfrmWallpaper = class(TForm)
    btnOK: TButton;
    gbxWallpaper: TGroupBox;
    rbnCenter: TRadioButton;
    rbnTile: TRadioButton;
    rbnStretch: TRadioButton;
    btnCancel: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
function FIPIStool(info,path: PChar; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;
function GetWinDir(): string;

var
  frmWallpaper: TfrmWallpaper;
  image: TBitmap;


implementation

{$R *.DFM}

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL;
begin
	func(PT_FTOOL, 'Set as Wallpaper...',' ');

	Result := true;
end;

function FIPIStool(info,path: PChar; app, wnd: THandle; img: hBitmap):hBitmap;
begin
	Application.Handle := app;
	image := TBitmap.Create();
	image.Handle := img;

	frmWallpaper := TfrmWallpaper.Create(Application);
	frmWallpaper.ShowModal();

	image.ReleaseHandle();
	FreeAndNil(image);
	FreeAndNil(frmWallpaper);

	Result := 0;
end;

procedure TfrmWallpaper.btnOKClick(Sender: TObject);
var
	path: WideString;
    ActiveDesktop: IActiveDesktop;
    opt: TWallPaperOpt;
begin
    // getting Windows folder
    path := Slash(GetWinDir()) + 'Futuris Imager Wallpaper.bmp';

    try
    	image.SaveToFile(path);

        // initializing OLE
        CoInitialize(nil);

    	// setting wallpaper
    	ActiveDesktop := CreateComObject(CLSID_ActiveDesktop) as IActiveDesktop;
  		ActiveDesktop.SetWallpaper(PWideChar(path), 0);
        
        opt.dwSize := SizeOf(opt);
    	if rbnCenter.Checked then opt.dwStyle := WPSTYLE_CENTER
        	else if rbnTile.Checked then opt.dwStyle := WPSTYLE_TILE
            	else if rbnStretch.Checked then opt.dwStyle := WPSTYLE_STRETCH
                	else opt.dwStyle := WPSTYLE_CENTER;

        ActiveDesktop.SetWallpaperOptions(opt, 0);
  		ActiveDesktop.ApplyChanges(AD_APPLY_ALL or AD_APPLY_FORCE);
    	except
        	Application.MessageBox('Wallpaper setup failed! Check write permissions in Windows folder.', 'Futuris Imager');
        end;

	// closing
	frmWallpaper.Close();
end;

procedure TfrmWallpaper.btnCancelClick(Sender: TObject);
begin
	// closing
	frmWallpaper.Close();
end;

procedure TfrmWallpaper.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
end;

procedure TfrmWallpaper.FormDestroy(Sender: TObject);
begin
	frmWallpaper := nil;
end;

function GetWinDir(): string;
var
	dir: array [0..MAX_PATH] of char;
begin
	GetWindowsDirectory(dir, MAX_PATH);
	Result := StrPas(dir);
end;

exports
	FIPISquery, FIPIStool;

end.
