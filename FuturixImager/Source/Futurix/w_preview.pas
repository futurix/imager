unit w_preview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, ToolWin, Printers, Preview, ImgList, Registry, Menus,
  StdCtrls,
  c_const, c_reg, c_wndpos, c_utils, c_tb, c_ie, c_graphics;

type
  TfrmPrintPreview = class(TForm)
    prwPrint: TPrintPreview;
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
    tbnSetup: TToolButton;
    Sep_1: TToolButton;
    N2: TMenuItem;
    tbrPrintMain: TCoolBar;
    pnlBottom: TPanel;
    btnClose: TButton;
    cbxProportional: TCheckBox;
    cbxShrinkOnlyLarge: TCheckBox;
    cbxCenter: TCheckBox;
    cbxAllPages: TCheckBox;
    cbxDPI: TCheckBox;
    dlgPrinterSetup: TPrinterSetupDialog;
    popSetup: TPopupMenu;
    piPrinterSetup: TMenuItem;
    piPageOptions: TMenuItem;
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
    procedure btnCloseClick(Sender: TObject);
    procedure cbxProportionalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure piPrinterSetupClick(Sender: TObject);
    procedure piPageOptionsClick(Sender: TObject);
  private
    bnd: TRect;
  public
  end;

var
  frmPrintPreview: TfrmPrintPreview;

  
implementation

uses w_main, f_ui, w_show, f_tools, f_graphics;

{$R *.DFM}

procedure TfrmPrintPreview.DrawView();
var
  bmp: TBitmap;
  tmp: TRect;
begin
  bmp := TBitmap.Create();
  frmMain.img.IEBitmap.PrepareAlphaForExternalUse();
  frmMain.img.IEBitmap.CopyToTBitmap(bmp);
  bmp.ApplyLimits();

  prwPrint.BeginDoc();

  if cbxDPI.Checked then
    begin
    tmp.Left := 0;
    tmp.Top := 0;
    tmp.Right := prwPrint.ConvertX(Round(frmMain.img.IEBitmap.Width * (Screen.PixelsPerInch / frmMain.img.IO.Params.DpiX)), mmPixel, prwPrint.Units);
    tmp.Bottom := prwPrint.ConvertY(Round(frmMain.img.IEBitmap.Height * (Screen.PixelsPerInch / frmMain.img.IO.Params.DpiY)), mmPixel, prwPrint.Units);

    prwPrint.PaintGraphicEx(tmp, bmp, false, false, false);
    end
  else
    prwPrint.PaintGraphicEx(bnd, bmp, cbxProportional.Checked, cbxShrinkOnlyLarge.Checked, cbxCenter.Checked);

  prwPrint.EndDoc();

  FreeAndNil(bmp);
end;

procedure TfrmPrintPreview.tbnPrintClick(Sender: TObject);
var
  i: integer;
  bmp: TBitmap;
  res: TFxOpenResult;
  tmp: TRect;
  fp: Word;
begin
  // workaround for weird drivers
  fp := Default8087CW;
  Set8087CW($133f);

  if (IsMultipage() and (infImage.pages > 1) and cbxAllPages.Checked) then
    begin
    for i := 0 to (infImage.pages - 1) do
      begin
      res := DoImageLoad(infImage.path, i);

      if (res.bitmap <> 0) then
        begin
        bmp := TBitmap.Create();
        bmp.Handle := res.bitmap;
        bmp.ApplyLimits();

        prwPrint.BeginDoc();

        if cbxDPI.Checked then
          begin
          tmp.Left := 0;
          tmp.Top := 0;
          tmp.Right := prwPrint.ConvertX(bmp.Width, mmPixel, prwPrint.Units);
          tmp.Bottom := prwPrint.ConvertY(bmp.Height, mmPixel, prwPrint.Units);

          prwPrint.PaintGraphicEx(tmp, bmp, false, false, false);
          end
        else
          prwPrint.PaintGraphicEx(prwPrint.PageBounds, bmp, cbxProportional.Checked, cbxShrinkOnlyLarge.Checked, cbxCenter.Checked);

        prwPrint.EndDoc();
                
        prwPrint.Print();

        FreeAndNil(bmp);
        end;
      end;
    end
  else
    prwPrint.Print();

  Set8087CW(fp);
end;

procedure TfrmPrintPreview.piZMFitClick(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomToFit;
end;

procedure TfrmPrintPreview.piZMWidthClick(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomToWidth;
end;

procedure TfrmPrintPreview.piZMHeightClick(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomToHeight;
end;

procedure TfrmPrintPreview.piZM25Click(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomOther;
  prwPrint.Zoom := 25;
end;

procedure TfrmPrintPreview.piZM50Click(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomOther;
  prwPrint.Zoom := 50;
end;

procedure TfrmPrintPreview.piZM75Click(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomOther;
  prwPrint.Zoom := 75;
end;

procedure TfrmPrintPreview.piZM100Click(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomOther;
  prwPrint.Zoom := 100;
end;

procedure TfrmPrintPreview.piZM150Click(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomOther;
  prwPrint.Zoom := 150;
end;

procedure TfrmPrintPreview.piZM200Click(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomOther;
  prwPrint.Zoom := 200;
end;

procedure TfrmPrintPreview.piPageOptionsClick(Sender: TObject);
begin
  prwPrint.SetPageSetupParameters(dlgPageSetup);

  if dlgPageSetup.Execute() then
    begin
    bnd := prwPrint.GetPageSetupParameters(dlgPageSetup);

    DrawView();
    end;
end;

procedure TfrmPrintPreview.piPrinterSetupClick(Sender: TObject);
begin
  prwPrint.SetPrinterOptions();

  if dlgPrinterSetup.Execute() then
    begin
    prwPrint.GetPrinterOptions();

    prwPrint.SetPageSetupParameters(dlgPageSetup);
    bnd := prwPrint.GetPageSetupParameters(dlgPageSetup);

    DrawView();
    end;
end;

procedure TfrmPrintPreview.btnCloseClick(Sender: TObject);
begin
  Self.Close();
end;

procedure TfrmPrintPreview.cbxProportionalClick(Sender: TObject);
begin
  cbxProportional.Enabled := not cbxDPI.Checked;
  cbxShrinkOnlyLarge.Enabled := not cbxDPI.Checked;
  cbxCenter.Enabled := not cbxDPI.Checked;

  DrawView();
end;

procedure TfrmPrintPreview.FormCreate(Sender: TObject);
var
  wreg: TFRegistry;
  tmp: string;
begin
  wreg := TFRegistry.Create(RA_READONLY);
  wreg.RootKey := HKEY_CURRENT_USER;

  // tweaks
  tbnZoom.WholeDropDown := true;
  tbnSetup.WholeDropDown := true;
  if IsThemed() then
    prwPrint.BorderStyle := bsNone;

  // reading settings
  if wreg.OpenKey(sSettings, false) then
    begin
    case wreg.RInt('Print_ZoomState', 1) of
      0:
        begin
        prwPrint.ZoomState := zsZoomOther;
        prwPrint.Zoom := wreg.RInt('Print_Zoom', 50);
        end;

      1: prwPrint.ZoomState := zsZoomToFit;

      2: prwPrint.ZoomState := zsZoomToHeight;

      3: prwPrint.ZoomState := zsZoomToWidth;
    end;

    cbxDPI.Checked := wreg.RBool('Print_DPI', false);
    cbxProportional.Checked := wreg.RBool('Print_Proportional', true);
    cbxShrinkOnlyLarge.Checked := wreg.RBool('Print_ShrinkOnlyLarge', true);
    cbxCenter.Checked := wreg.RBool('Print_Center', true);
    cbxAllPages.Checked := wreg.RBool('Print_AllPages', false);

    tmp := wreg.RStr('Print_SelectedPrinter', '');
    if (tmp <> '') then
      Printer.PrinterIndex := Printer.Printers.IndexOf(tmp);

    wreg.CloseKey();
    end
  else
    begin
    prwPrint.ZoomState := zsZoomToFit;
    cbxDPI.Checked := false;
    cbxProportional.Checked := true;
    cbxShrinkOnlyLarge.Checked := true;
    cbxCenter.Checked := true;
    cbxAllPages.Checked := false;
    Printer.PrinterIndex := -1;
    end;

  FreeAndNil(wreg);

  RestoreWindowSize(@Self, sSettings + '\Wnd', 750, 550, 'PrintPreview_');

  prwPrint.GetPrinterOptions();
  prwPrint.SetPageSetupParameters(dlgPageSetup);
  bnd := prwPrint.GetPageSetupParameters(dlgPageSetup);
end;

procedure TfrmPrintPreview.FormClose(Sender: TObject; var Action: TCloseAction);
var
  wreg: TFRegistry;
begin
  wreg := TFRegistry.Create(RA_FULL);
  wreg.RootKey := HKEY_CURRENT_USER;

  // saving settings
  if wreg.OpenKey(sSettings, true) then
    begin
    case prwPrint.ZoomState of
      zsZoomOther:
        begin
        wreg.WInteger('Print_ZoomState', 0);
        wreg.WInteger('Print_Zoom', prwPrint.Zoom);
        end;

      zsZoomToFit:
        wreg.WInteger('Print_ZoomState', 1);

      zsZoomToHeight:
        wreg.WInteger('Print_ZoomState', 2);

      zsZoomToWidth:
        wreg.WInteger('Print_ZoomState',3);
    end;

    wreg.WBool('Print_DPI', cbxDPI.Checked);
    wreg.WBool('Print_Proportional', cbxProportional.Checked);
    wreg.WBool('Print_ShrinkOnlyLarge', cbxShrinkOnlyLarge.Checked);
    wreg.WBool('Print_Center', cbxCenter.Checked);
    wreg.WBool('Print_AllPages', cbxAllPages.Checked);

    if (Printer.PrinterIndex <> -1) then
      wreg.WString('Print_SelectedPrinter', Printer.Printers[Printer.PrinterIndex]);

    wreg.CloseKey();
    end;

  FreeAndNil(wreg);
    
  SaveWindowSize(@Self, sSettings + '\Wnd', 'PrintPreview_');

  // to be freed
  Action := caFree;
end;

procedure TfrmPrintPreview.FormDestroy(Sender: TObject);
begin
  frmPrintPreview := nil;
end;

procedure TfrmPrintPreview.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Self.Close();
end;

end.
