unit twainwnd;

{$WARNINGS OFF}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, c_const, StdCtrls, DelphiTwain, ExtCtrls;

type
  TfrmAcquire = class(TForm)
    btnOpen: TButton;
    btnCancel: TButton;
    cmpTwain: TDelphiTwain;
    btnGetImage: TButton;
    imgPreview: TImage;
    pnlPreview: TPanel;
    procedure btnOpenClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnGetImageClick(Sender: TObject);
    procedure cmpTwainTwainAcquire(Sender: TObject; const Index: Integer; Image: TBitmap; var Cancel: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAcquire: TfrmAcquire;
  image: TBitmap;

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
function FIPISimport(info: PChar; app, wnd: THandle):hBitmap; stdcall;


implementation

{$R *.dfm}

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL;
begin
	func(PT_FIMPORT, 'Get Image from Digital Camera or Scanner...',' ');

	Result := true;
end;

function FIPISimport(info: PChar; app, wnd: THandle):hBitmap;
begin
	Application.Handle := app;

	image := TBitmap.Create();

	frmAcquire := TfrmAcquire.Create(Application);
	frmAcquire.ShowModal();

	FreeAndNil(frmAcquire);

	if not image.Empty then
  		Result := image.ReleaseHandle()
	else
  		Result := 0;
  
	FreeAndNil(image);
end;

procedure TfrmAcquire.btnOpenClick(Sender: TObject);
begin
	if not imgPreview.Picture.Bitmap.Empty then
		image.Assign(imgPreview.Picture.Bitmap);
	Self.Close();
end;

procedure TfrmAcquire.btnCancelClick(Sender: TObject);
begin
	Self.Close();
end;

procedure TfrmAcquire.btnGetImageClick(Sender: TObject);
var
  SelectedSource: integer;
begin
  	if cmpTwain.LoadLibrary then
  		begin
    	cmpTwain.SourceManagerLoaded := TRUE;

    	SelectedSource := cmpTwain.SelectSource;
    	if SelectedSource <> -1 then
    		begin
      			cmpTwain.Source[SelectedSource].Loaded := TRUE;
      			cmpTwain.Source[SelectedSource].Enabled := TRUE;
    		end;

  		end
  	else
    	ShowMessage('TWAIN libraries are not installed or corrupted! Please, reinstall your scanner driver (if applicable).');
end;

procedure TfrmAcquire.cmpTwainTwainAcquire(Sender: TObject; const Index: Integer; Image: TBitmap; var Cancel: Boolean);
begin
    pnlPreview.Caption := '';
    btnOpen.Show();
	imgPreview.Picture.Assign(Image);
	Cancel := TRUE;
end;

exports
  FIPISquery, FIPISimport;

end.
