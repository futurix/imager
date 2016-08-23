unit view;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, ToolWin, Printers, Preview, ImgList, Registry, Menus,
  c_const, c_reg, StdCtrls;

type
  TfrmPrint = class(TForm)
    prwPrint: TPrintPreview;
    imlPrint: TImageList;
    itbPrintMain: TToolBar;
    tbnZoom: TToolButton;
    tbnPrint: TToolButton;
    popZoom: TPopupMenu;
    piZMFit: TMenuItem;
    piZMWidth: TMenuItem;
    piZMHeight: TMenuItem;
    N1: TMenuItem;
    piZM25: TMenuItem;
    piZM50: TMenuItem;
    piZM75: TMenuItem;
    piZM100: TMenuItem;
    piZM150: TMenuItem;
    piZM200: TMenuItem;
    dlgPageSetup: TPageSetupDialog;
    Setup: TToolButton;
    Sep_1: TToolButton;
    N2: TMenuItem;
    tbrPrintMain: TCoolBar;
    pnlBottom: TPanel;
    btnClose: TButton;
    cbxProportional: TCheckBox;
    cbxShrinkOnlyLarge: TCheckBox;
    cbxCenter: TCheckBox;
    procedure DrawView();
    procedure tbnPrintClick(Sender: TObject);
    procedure piZMFitClick(Sender: TObject);
    procedure piZMWidthClick(Sender: TObject);
    procedure piZMHeightClick(Sender: TObject);
    procedure piZM25Click(Sender: TObject);
    procedure piZM50Click(Sender: TObject);
    procedure piZM75Click(Sender: TObject);
    procedure piZM100Click(Sender: TObject);
    procedure piZM150Click(Sender: TObject);
    procedure piZM200Click(Sender: TObject);
    function SetupClicked():boolean;
    procedure SetupClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cbxProportionalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function DoPrint(app: THandle; img: hBitmap; filename: PChar; fast: boolean):integer; stdcall;

var
  frmPrint: TfrmPrint;
  image: TBitmap;
  file_name: PChar;
  fast_print: boolean = false;
  reg: TFuturisRegistry;

implementation

{$R *.DFM}

function DoPrint(app: THandle; img: hBitmap; filename: PChar; fast: boolean):integer;
begin
Application.Handle:=app;

reg:=TFuturisRegistry.Create();
reg.RootKey:=HKEY_CURRENT_USER;
reg.OpenKey(sReg + '\PrintPreview',true);

if (Printer.Printers.Count>0) then
begin

image:=TBitmap.Create();
image.Handle:=img;
image.PixelFormat:=pf24bit;
image.HandleType:=bmDIB;

file_name:=filename;
frmPrint:=TfrmPrint.Create(Application);

// reading settings
case reg.RIntC('ZoomState',1) of
  0:
    begin
    frmPrint.prwPrint.ZoomState:=zsZoomOther;
    frmPrint.prwPrint.Zoom:=50;
    end;
  1: frmPrint.prwPrint.ZoomState:=zsZoomToFit;
  2: frmPrint.prwPrint.ZoomState:=zsZoomToHeight;
  3: frmPrint.prwPrint.ZoomState:=zsZoomToWidth;
end;
frmPrint.Width:=reg.RIntC('Width',750);
frmPrint.Height:=reg.RIntC('Height',550);
try
  frmPrint.Top:=reg.ReadInteger('Top');
  frmPrint.Left:=reg.ReadInteger('Left');
  except
  frmPrint.Position:=poScreenCenter;
  end;

frmPrint.cbxProportional.Checked:=reg.RBool('PProportional',true);
frmPrint.cbxShrinkOnlyLarge.Checked:=reg.RBool('PShrinkOnlyLarge',true);
frmPrint.cbxCenter.Checked:=reg.RBool('PCenter',true);

// working
frmPrint.prwPrint.PrintJobTitle:=ExtractFileName(file_name);
frmPrint.DrawView();
if fast then
  begin
  if frmPrint.SetupClicked() then
    frmPrint.prwPrint.Print();
  end
else
  frmPrint.ShowModal();
Result:=1;
// saving settings
case frmPrint.prwPrint.ZoomState of
  zsZoomOther:
    begin
    reg.WInteger('ZoomState',0);
    reg.WInteger('Zoom',frmPrint.prwPrint.Zoom);
    end;
  zsZoomToFit: reg.WInteger('ZoomState',1);
  zsZoomToHeight: reg.WInteger('ZoomState',2);
  zsZoomToWidth: reg.WInteger('ZoomState',3);
end;
reg.WInteger('Width',frmPrint.Width);
reg.WInteger('Height',frmPrint.Height);
reg.WInteger('Top',frmPrint.Top);
reg.WInteger('Left',frmPrint.Left);

reg.WBool('PProportional',frmPrint.cbxProportional.Checked);
reg.WBool('PShrinkOnlyLarge',frmPrint.cbxShrinkOnlyLarge.Checked);
reg.WBool('PCenter',frmPrint.cbxCenter.Checked);

// freeing
FreeAndNil(frmPrint);

end
else
  begin
  ShowMessage('Cannot start printing plug-in - no printers found!');
  Result:=0;
  end;

FreeAndNil(image);
reg.CloseKey();
FreeAndNil(reg);
end;

procedure TfrmPrint.DrawView();
begin
prwPrint.BeginDoc();
prwPrint.PaintGraphicEx(prwPrint.PageBounds,image,frmPrint.cbxProportional.Checked,frmPrint.cbxShrinkOnlyLarge.Checked,frmPrint.cbxCenter.Checked);
prwPrint.EndDoc();
end;

procedure TfrmPrint.tbnPrintClick(Sender: TObject);
begin
prwPrint.Print();
end;

procedure TfrmPrint.piZMFitClick(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomToFit;
end;

procedure TfrmPrint.piZMWidthClick(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomToWidth;
end;

procedure TfrmPrint.piZMHeightClick(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomToHeight;
end;

procedure TfrmPrint.piZM25Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=25;
end;

procedure TfrmPrint.piZM50Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=50;
end;

procedure TfrmPrint.piZM75Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=75;
end;

procedure TfrmPrint.piZM100Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=100;
end;

procedure TfrmPrint.piZM150Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=150;
end;

procedure TfrmPrint.piZM200Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=200;
end;

function TfrmPrint.SetupClicked():boolean;
begin
Result:=dlgPageSetup.Execute();
prwPrint.GetPrinterOptions();
DrawView();
end;

procedure TfrmPrint.SetupClick(Sender: TObject);
begin
dlgPageSetup.Execute();
prwPrint.GetPrinterOptions();
DrawView();
end;

exports
  DoPrint;

procedure TfrmPrint.btnCloseClick(Sender: TObject);
begin
Self.Close();
end;

procedure TfrmPrint.cbxProportionalClick(Sender: TObject);
begin
DrawView();
end;

end.
