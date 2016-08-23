unit jexport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Registry, Jpeg;

type
  TfrmJExport = class(TForm)
    btnSave: TButton;
    btnCancel: TButton;
    lblSize: TLabel;
    dlgJSave: TSaveDialog;
    pclJExport: TPageControl;
    shtSettings: TTabSheet;
    shtPreview: TTabSheet;
    cbxGrayScale: TCheckBox;
    gbxQuality: TGroupBox;
    lblQuality: TLabel;
    tbrQuality: TTrackBar;
    sbxPreview: TScrollBox;
    imgPreview: TImage;
    procedure tbrQualityChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure cbxGrayScaleClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
     sReg = '\Software\Futuris\ImagerC';
     sFIPIS = '\Software\Futuris\FIPIS';
     sName = 'Futuris Imager';

var
  frmJExport: TfrmJExport;
  reg: TRegistry;
  gbmp: TBitmap;
  tmp: string;

function FIPISexport(info: PChar; app: THandle; img: hBitmap):integer; stdcall;

implementation

{$R *.DFM}

function FIPISexport(info: PChar; app: THandle; img: hBitmap):integer;
var
   val: string;
   vl: integer;
begin
Application.Handle:=app;
// setting all
reg:=TRegistry.Create();
reg.RootKey:=HKEY_CURRENT_USER;
reg.OpenKey(sReg + '\Paths',true);
tmp:=reg.ReadString('Directory');
tmp:=tmp + 'temp\jpeg.tmp';
reg.CloseKey();
reg.OpenKey(sReg + '\Plug-ins\0FF6F740-2F20-11D5-B653-8D6A009BCE3A',true);
val:=reg.ReadString('Quality');
if val='' then val:='80';
vl:=StrToInt(val);
reg.CloseKey();
reg.Free();
gbmp:=TBitmap.Create();
gbmp.Handle:=img;
// form
frmJExport:=TfrmJExport.Create(Application);
frmJExport.tbrQuality.Position:=vl;
frmJExport.lblQuality.Caption:=val;
frmJExport.tbrQualityChange(Application);
frmJExport.ShowModal();
// cleaning
frmJExport.Free();
DeleteFile(tmp);
gbmp.Free();
Result:=1;
end;

procedure TfrmJExport.tbrQualityChange(Sender: TObject);
var
   jpg: TJpegImage;
   fl: HWND;
   size: Longword;
begin
jpg:=TJpegImage.Create();
jpg.CompressionQuality:=tbrQuality.Position;
lblQuality.Caption:=IntToStr(tbrQuality.Position);
jpg.Grayscale:=cbxGrayScale.Checked;
// compressing
jpg.Assign(gbmp);
jpg.SaveToFile(tmp);
jpg.LoadFromFile(tmp);
// displaying
imgPreview.Picture.Bitmap.Width:=jpg.Width;
imgPreview.Picture.Bitmap.Height:=jpg.Height;
imgPreview.Picture.Bitmap.Canvas.Draw(0,0,jpg);
// getting size
fl:=CreateFile(PChar(tmp),GENERIC_READ,FILE_SHARE_READ + FILE_SHARE_WRITE,nil,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
size:=GetFileSize(fl,@size);
CloseHandle(fl);
lblSize.Caption:='File size: ' + IntToStr(size) + ' bytes';
// freeing
jpg.Free();
end;

procedure TfrmJExport.btnCancelClick(Sender: TObject);
begin
Close();
end;

procedure TfrmJExport.btnSaveClick(Sender: TObject);
var
   jpg: TJpegImage;
begin
if dlgJSave.Execute then begin
                         if not FileExists(dlgJSave.FileName) then begin
                                                                   jpg:=TJpegImage.Create();
                                                                   jpg.CompressionQuality:=tbrQuality.Position;
                                                                   jpg.Grayscale:=cbxGrayScale.Checked;
                                                                   jpg.Assign(gbmp);
                                                                   jpg.SaveToFile(dlgJSave.FileName);
                                                                   jpg.Free();
                                                                   end;
                         end;
Close();
end;

procedure TfrmJExport.cbxGrayScaleClick(Sender: TObject);
begin
tbrQualityChange(Application);
end;

end.
