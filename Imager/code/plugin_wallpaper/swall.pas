unit swall;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComObj, ShlObj, ActiveX, c_const, c_utils, c_locales;

type
  TfrmWallpaperS = class(TForm)
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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetWinDir(): string;

var
  frmWallpaperS: TfrmWallpaperS;


implementation

uses wall;

{$R *.DFM}

procedure TfrmWallpaperS.btnOKClick(Sender: TObject);
var
	path: WideString;
    ActiveDesktop: IActiveDesktop;
    opt: TWallPaperOpt;
begin
    // getting Windows folder
    path := Slash(GetWinDir()) + sAppName + ' ' + 'Wallpaper.bmp';

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
        	Application.MessageBox('Wallpaper setup failed! Check write permissions in Windows folder.', sAppName);
        end;

	// closing
	frmWallpaperS.Close();
end;

procedure TfrmWallpaperS.btnCancelClick(Sender: TObject);
begin
	// closing
	frmWallpaperS.Close();
end;

procedure TfrmWallpaperS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
end;

procedure TfrmWallpaperS.FormDestroy(Sender: TObject);
begin
	frmWallpaperS := nil;
end;

function GetWinDir(): string;
var
	dir: array [0..MAX_PATH] of char;
begin
	GetWindowsDirectory(dir, MAX_PATH);
	Result := StrPas(dir);
end;

procedure TfrmWallpaperS.FormCreate(Sender: TObject);
begin
	Self.Caption        	:= LoadLStr(3007);

    btnOK.Caption			:= LoadLStr(50);
    btnCancel.Caption		:= LoadLStr(51);

    gbxWallpaper.Caption	:= LoadLStr(3008);

    rbnCenter.Caption		:= LoadLStr(3009);
    rbnTile.Caption			:= LoadLStr(3010);
    rbnStretch.Caption		:= LoadLStr(3011);
end;

end.
