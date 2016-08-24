unit w_preview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, ToolWin, Printers, Preview, ImgList, Registry, Menus,
  c_const, c_reg, StdCtrls, c_wndpos, c_locales, c_utils, c_tb;

type
  TfrmPrint = class(TForm)
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
    procedure tbnSetupClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cbxProportionalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    procedure Localize();
  end;

var
  frmPrint: TfrmPrint;

  
implementation

uses main, f_ui, w_show, f_multi, f_tools;

{$R *.DFM}

procedure TfrmPrint.DrawView();
var
    bmp: TBitmap;
    tmp: TRect;
begin
    bmp := TBitmap.Create();
    frmMain.img.IEBitmap.CopyToTBitmap(bmp);

    bmp.PixelFormat := pf24bit;

  prwPrint.BeginDoc();

    if cbxDPI.Checked then
        begin
        tmp.Left := 0;
      tmp.Top := 0;
      tmp.Right := prwPrint.ConvertX(Round(frmMain.img.IEBitmap.Width * (Screen.PixelsPerInch / frmMain.img.IO.Params.DpiX)), mmPixel, prwPrint.Units);
      tmp.Bottom := prwPrint.ConvertY(Round(frmMain.img.IEBitmap.Height * (Screen.PixelsPerInch / frmMain.img.IO.Params.DpiY)), mmPixel, prwPrint.Units);

      prwPrint.PaintGraphicEx(tmp, frmMain.img.IEBitmap.VclBitmap, false, false, false);
        end
    else
        prwPrint.PaintGraphicEx(prwPrint.PageBounds, frmMain.img.IEBitmap.VclBitmap, cbxProportional.Checked, cbxShrinkOnlyLarge.Checked, cbxCenter.Checked);

  prwPrint.EndDoc();

    FreeAndNil(bmp);
end;

procedure TfrmPrint.tbnPrintClick(Sender: TObject);
var
  i: integer;
    bmp: TBitmap;
    img: HBITMAP;
    tmp: TRect;
    fp: Word;
begin
    fp := Default8087CW;
    Set8087CW($133f);

    if ((infImage.image_type = itMulti) and (infMulti.pages > 1) and cbxAllPages.Checked) then
        begin
        for i := 0 to (infMulti.pages - 1) do
          begin
            img := MGetPage(i);

            if (img <> 0) then
              begin
                bmp := TBitmap.Create();
                bmp.Handle := img;

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

procedure TfrmPrint.piZMFitClick(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomToFit;
end;

procedure TfrmPrint.piZMWidthClick(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomToWidth;
end;

procedure TfrmPrint.piZMHeightClick(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomToHeight;
end;

procedure TfrmPrint.piZM25Click(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomOther;
  prwPrint.Zoom := 25;
end;

procedure TfrmPrint.piZM50Click(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomOther;
  prwPrint.Zoom := 50;
end;

procedure TfrmPrint.piZM75Click(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomOther;
  prwPrint.Zoom := 75;
end;

procedure TfrmPrint.piZM100Click(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomOther;
  prwPrint.Zoom := 100;
end;

procedure TfrmPrint.piZM150Click(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomOther;
  prwPrint.Zoom := 150;
end;

procedure TfrmPrint.piZM200Click(Sender: TObject);
begin
  prwPrint.ZoomState := zsZoomOther;
  prwPrint.Zoom := 200;
end;

procedure TfrmPrint.tbnSetupClick(Sender: TObject);
begin
  dlgPageSetup.Execute();
  prwPrint.GetPrinterOptions();

  DrawView();
end;

procedure TfrmPrint.btnCloseClick(Sender: TObject);
begin
  Self.Close();
end;

procedure TfrmPrint.cbxProportionalClick(Sender: TObject);
begin
    cbxProportional.Enabled := not cbxDPI.Checked;
    cbxShrinkOnlyLarge.Enabled := not cbxDPI.Checked;
    cbxCenter.Enabled := not cbxDPI.Checked;

  DrawView();
end;

procedure TfrmPrint.Localize();
begin
  Caption           := LoadLStr(3250);
    tbnPrint.Caption       := LoadLStr(3251);
    tbnPrint.Hint         := LoadLStr(3252);
    tbnZoom.Caption       := LoadLStr(3253);
    tbnZoom.Hint         := LoadLStr(3254);
    tbnSetup.Caption       := LoadLStr(3255);
    tbnSetup.Hint         := LoadLStr(3256);
    cbxDPI.Caption        := LoadLStr(3263);
    cbxProportional.Caption    := LoadLStr(3257);
    cbxShrinkOnlyLarge.Caption  := LoadLStr(3258);
    cbxCenter.Caption      := LoadLStr(3259);
    cbxAllPages.Caption      := LoadLStr(3262);
    btnClose.Caption      := LoadLStr(54);
    piZMFit.Caption        := LoadLStr(260);
    piZMFit.Hint        := LoadLStr(261);
    piZMWidth.Caption      := LoadLStr(262);
    piZMWidth.Hint        := LoadLStr(263);
    piZMHeight.Caption      := LoadLStr(264);
    piZMHeight.Hint        := LoadLStr(265);
    piZM25.Caption        := LoadLStr(240);
    piZM25.Hint          := LoadLStr(241);
    piZM50.Caption        := LoadLStr(242);
    piZM50.Hint          := LoadLStr(243);
    piZM75.Caption        := LoadLStr(244);
    piZM75.Hint          := LoadLStr(245);
    piZM100.Caption        := LoadLStr(246);
    piZM100.Hint        := LoadLStr(247);
    piZM150.Caption        := LoadLStr(248);
    piZM150.Hint        := LoadLStr(249);
    piZM200.Caption        := LoadLStr(250);
    piZM200.Hint        := LoadLStr(251);
end;

procedure TfrmPrint.FormCreate(Sender: TObject);
var
  wreg: TFRegistry;
begin
  wreg := TFRegistry.Create(RA_READONLY);
  wreg.RootKey := HKEY_CURRENT_USER;

    // tweaks
    tbnZoom.WholeDropDown := true;
    if IsThemed() then
        prwPrint.BorderStyle := bsNone;

    // reading settings
  if wreg.OpenKey(sSettings, false) then
      begin
      case wreg.RInt('Print_ZoomState', 1) of
        0:  begin
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
        end;

    FreeAndNil(wreg);

    RestoreWindowSize(@Self, sSettings + '\Wnd', 750, 550, 'PrintPreview_');

    // localization
  Localize();
end;

procedure TfrmPrint.FormClose(Sender: TObject; var Action: TCloseAction);
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

      wreg.CloseKey();
      end;

    FreeAndNil(wreg);
    
    SaveWindowSize(@Self, sSettings + '\Wnd', 'PrintPreview_');

    // to be freed
    Action := caFree;
end;

procedure TfrmPrint.FormDestroy(Sender: TObject);
begin
  frmPrint := nil;
end;

procedure TfrmPrint.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
      Self.Close();
end;

end.
