unit view;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, ToolWin, Printers, Preview, ImgList, Registry, Menus,
  c_const, c_reg, StdCtrls, c_toolbar, c_locales;

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
    tbnSetup: TToolButton;
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
    procedure tbnSetupClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cbxProportionalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function FxImgHelpPrint(document_path: PChar; fast_print: BOOL; img: HBITMAP; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;

var
  frmPrint: TfrmPrint;
  image: TBitmap;
  file_name: string;
  fast_print: boolean = false;
  reg: TFRegistry;

  
implementation

{$R *.DFM}

function FxImgHelpPrint(document_path: PChar; fast_print: BOOL; img: HBITMAP; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult;
var
	temp_res: TFxImgResult;
begin
	Application.Handle := app;
    Result.result_type := RT_BOOL;		// result is always boolean
    Result.result_value := FX_FALSE;

    if (@app_query <> nil) then
        begin
    	temp_res := app_query(CQ_GETLANGLIBS, 0, 0);

        if (temp_res.result_type = RT_HANDLE) then
        	begin
            locale_lib := temp_res.result_value;
            backup_lib := temp_res.result_xtra;
            end;
        end;

	reg := TFRegistry.Create();
	reg.RootKey := HKEY_CURRENT_USER;

	if (Printer.Printers.Count > 0) then
		begin
        if (img <> 0) then
        	begin
			image := TBitmap.Create();
			image.Handle := img;
			image.PixelFormat := pf24bit;
			image.HandleType := bmDIB;

            file_name := document_path;

            // starting GUI
			frmPrint := TfrmPrint.Create(Application);
            frmPrint.tbnZoom.WholeDropDown := true;

            // localization
            frmPrint.Caption 					:= LoadLStr(3250);
            frmPrint.tbnPrint.Caption 			:= LoadLStr(3251);
            frmPrint.tbnPrint.Hint 				:= LoadLStr(3252);
            frmPrint.tbnZoom.Caption 			:= LoadLStr(3253);
            frmPrint.tbnZoom.Hint 				:= LoadLStr(3254);
            frmPrint.tbnSetup.Caption 			:= LoadLStr(3255);
            frmPrint.tbnSetup.Hint 				:= LoadLStr(3256);
            frmPrint.cbxProportional.Caption	:= LoadLStr(3257);
            frmPrint.cbxShrinkOnlyLarge.Caption	:= LoadLStr(3258);
            frmPrint.cbxCenter.Caption			:= LoadLStr(3259);
            frmPrint.btnClose.Caption			:= LoadLStr(54);
            frmPrint.piZMFit.Caption			:= LoadLStr(260);
            frmPrint.piZMFit.Hint				:= LoadLStr(261);
            frmPrint.piZMWidth.Caption			:= LoadLStr(262);
            frmPrint.piZMWidth.Hint				:= LoadLStr(263);
            frmPrint.piZMHeight.Caption			:= LoadLStr(264);
            frmPrint.piZMHeight.Hint			:= LoadLStr(265);
            frmPrint.piZM25.Caption				:= LoadLStr(240);
            frmPrint.piZM25.Hint				:= LoadLStr(241);
            frmPrint.piZM50.Caption				:= LoadLStr(242);
            frmPrint.piZM50.Hint				:= LoadLStr(243);
            frmPrint.piZM75.Caption				:= LoadLStr(244);
            frmPrint.piZM75.Hint				:= LoadLStr(245);
            frmPrint.piZM100.Caption			:= LoadLStr(246);
            frmPrint.piZM100.Hint				:= LoadLStr(247);
            frmPrint.piZM150.Caption			:= LoadLStr(248);
            frmPrint.piZM150.Hint				:= LoadLStr(249);
            frmPrint.piZM200.Caption			:= LoadLStr(250);
            frmPrint.piZM200.Hint				:= LoadLStr(251);

            // reading settings
            reg.OpenKey(sSettings, true);

			case reg.RInt('Print_ZoomState', 1) of
  				0:
    				begin
    				frmPrint.prwPrint.ZoomState := zsZoomOther;
    				frmPrint.prwPrint.Zoom := reg.RInt('Print_Zoom', 50);
                    end;

  				1: frmPrint.prwPrint.ZoomState := zsZoomToFit;

  				2: frmPrint.prwPrint.ZoomState := zsZoomToHeight;

  				3: frmPrint.prwPrint.ZoomState := zsZoomToWidth;
            end;

			frmPrint.Width := reg.RInt('Print_WndWidth', 750);
			frmPrint.Height := reg.RInt('Print_WndHeight', 550);

			try
  				frmPrint.Top := reg.ReadInteger('Print_WndTop');
  				frmPrint.Left := reg.ReadInteger('Print_WndLeft');
  				except
  					frmPrint.Position := poScreenCenter;
  				end;

			frmPrint.cbxProportional.Checked := reg.RBool('Print_Proportional', true);
			frmPrint.cbxShrinkOnlyLarge.Checked := reg.RBool('Print_ShrinkOnlyLarge', true);
			frmPrint.cbxCenter.Checked := reg.RBool('Print_Center', true);

            reg.CloseKey();

            // working
            if FileExists(file_name) then
				frmPrint.prwPrint.PrintJobTitle := ExtractFileName(file_name)
            else
            	frmPrint.prwPrint.PrintJobTitle := sAppName;

			frmPrint.DrawView();

			if fast_print then
  				begin
  				if frmPrint.SetupClicked() then
    				frmPrint.prwPrint.Print();
  				end
			else
  				frmPrint.ShowModal();

            Result.result_value := FX_TRUE;

			// saving settings
            reg.OpenKey(sSettings, true);

			case frmPrint.prwPrint.ZoomState of
  				zsZoomOther:
    				begin
    				reg.WInteger('Print_ZoomState', 0);
    				reg.WInteger('Print_Zoom', frmPrint.prwPrint.Zoom);
    				end;

  				zsZoomToFit:
                	reg.WInteger('Print_ZoomState', 1);

  				zsZoomToHeight:
                	reg.WInteger('Print_ZoomState', 2);

  				zsZoomToWidth:
                	reg.WInteger('Print_ZoomState',3);
			end;

			reg.WInteger('Print_WndWidth', frmPrint.Width);
			reg.WInteger('Print_WndHeight', frmPrint.Height);
			reg.WInteger('Print_WndTop', frmPrint.Top);
			reg.WInteger('Print_WndLeft', frmPrint.Left);

			reg.WBool('Print_Proportional', frmPrint.cbxProportional.Checked);
			reg.WBool('Print_ShrinkOnlyLarge', frmPrint.cbxShrinkOnlyLarge.Checked);
			reg.WBool('Print_Center', frmPrint.cbxCenter.Checked);

            reg.CloseKey();

            // closing GUI
			FreeAndNil(frmPrint);
            FreeAndNil(image);
            end
        else
        	ShowMessage(LoadLStr(3260));


        end
	else
  		ShowMessage(LoadLStr(3261));

	FreeAndNil(reg);
end;

procedure TfrmPrint.DrawView();
begin
	prwPrint.BeginDoc();
	prwPrint.PaintGraphicEx(prwPrint.PageBounds, image, frmPrint.cbxProportional.Checked, frmPrint.cbxShrinkOnlyLarge.Checked, frmPrint.cbxCenter.Checked);
	prwPrint.EndDoc();
end;

procedure TfrmPrint.tbnPrintClick(Sender: TObject);
begin
	prwPrint.Print();
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

function TfrmPrint.SetupClicked():boolean;
begin
	Result := dlgPageSetup.Execute();
	prwPrint.GetPrinterOptions();

	DrawView();
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
	DrawView();
end;

end.
