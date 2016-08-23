unit size;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  c_const, futuris_resample, ExtCtrls;

type
  TfrmResize = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    cbxMethod: TComboBox;
    edtWidth: TEdit;
    edtHeight: TEdit;
    lblHeight: TLabel;
    lblWidth: TLabel;
    lblMethod: TLabel;
    bvlSep: TBevel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
function FIPISfilter(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;

var
  frmResize: TfrmResize;
  bmp: TBitmap;
  canceled: boolean = true;

implementation

{$R *.DFM}

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL;
begin
func(PT_FFILTER,'Resize',' ');
Result:=true;
end;

function FIPISfilter(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap;
begin
if preview then
  Result:=0
else
  begin
  // tuning form
  Application.Handle:=app;

  // tuning bitmap
  bmp:=TBitmap.Create();
  bmp.Handle:=img;

  // starting
  frmResize:=TfrmResize.Create(Application);
  frmResize.ShowModal();
  frmResize.Free();

  // ending
  if canceled then
    Result:=0
  else
    Result:=bmp.ReleaseHandle();
  bmp.Free();
  end;
end;

procedure TfrmResize.btnCancelClick(Sender: TObject);
begin
Close();
end;

procedure TfrmResize.btnOKClick(Sender: TObject);
var
  new_w,new_h: integer;
  flt: TResamplingFilter;
begin
canceled:=false;
new_w:=0;
new_h:=0;
flt:=sfBell;
try
  new_w:=StrToInt(edtWidth.Text);
  new_h:=StrToInt(edtHeight.Text);
  except
  on EConvertError do
    begin
    ShowMessage('You need to input numerics!');
    Abort();
    end;
  else Abort();
  end;
case cbxMethod.ItemIndex of
  0: flt:=sfBox;
  1: flt:=sfTriangle;
  2: flt:=sfHermite;
  3: flt:=sfBell;
  4: flt:=sfSpline;
  5: flt:=sfLanczos3;
  6: flt:=sfMitchell;
end;
Stretch(new_w,new_h,flt,0,bmp);
Close();
end;

procedure TfrmResize.FormCreate(Sender: TObject);
begin
edtWidth.Text:=IntToStr(bmp.Width);
edtHeight.Text:=IntToStr(bmp.Height);
cbxMethod.ItemIndex:=3;
end;

exports
  FIPISquery, FIPISfilter;

end.
