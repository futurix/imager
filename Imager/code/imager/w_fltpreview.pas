unit w_fltpreview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, c_const, ieview, imageenview, Buttons;

type
  TfrmFltPreview = class(TForm)
    lbxFilters: TListBox;
    lblFilters: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    lblPreview: TLabel;
    pnlPreview: TPanel;
    imgPre: TImageEnView;
    sbnFit: TSpeedButton;
    sbnNormal: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure lbxFiltersClick(Sender: TObject);
    procedure sbnNormalClick(Sender: TObject);
    procedure sbnFitClick(Sender: TObject);
  end;

var
	frmFltPreview: TfrmFltPreview;


implementation

uses main, globals, f_reg, f_plugins, f_images;

{$R *.dfm}

procedure TfrmFltPreview.FormCreate(Sender: TObject);
begin
    // reading filter names
	reg.OpenKey(sModules + '\Filters', true);
	reg.GetValueNames(lbxFilters.Items);
	reg.CloseKey();

    // loading first image
    imgPre.IEBitmap.Assign(frmMain.img.IEBitmap);

    // reading settings
	reg.OpenKey(sReg + '\Filters', true);
    if reg.RBool('ZoomToFit', true) = true then
        begin
        sbnFitClick(Self);
    	sbnFitClick(Self);
        end
    else
        begin
    	sbnNormalClick(Self);
        sbnNormalClick(Self);
        end;
	reg.CloseKey();
end;

procedure TfrmFltPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    // saving settings
	reg.OpenKey(sReg + '\Filters', true);
    if imgPre.AutoFit then
    	reg.WBool('ZoomToFit', true)
    else
    	reg.WBool('ZoomToFit', false);
	reg.CloseKey();

	Action := caFree;
end;

procedure TfrmFltPreview.FormDestroy(Sender: TObject);
begin
	frmFltPreview := nil;
end;

procedure TfrmFltPreview.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if (Key = VK_ESCAPE) then
  		Self.Close();
end;

procedure TfrmFltPreview.btnOKClick(Sender: TObject);
begin
	if ((lbxFilters.ItemIndex <> -1) and (HandleFilter(lbxFilters.Items[lbxFilters.ItemIndex]))) then
  		Self.Close();
end;

procedure TfrmFltPreview.btnCancelClick(Sender: TObject);
begin
	Self.Close();
end;

procedure TfrmFltPreview.lbxFiltersClick(Sender: TObject);
var
	tmp: HBITMAP;
    bmp: TBitmap;
begin
	if (lbxFilters.ItemIndex <> -1) then
  		begin
        Screen.Cursor := crHourGlass;
  		tmp := HandleFilterPreview(lbxFilters.Items[lbxFilters.ItemIndex]);
        Screen.Cursor := crDefault;

  		if (tmp <> 0) then
    		begin
    		pnlPreview.Caption := '';

            bmp := TBitmap.Create();
            bmp.Handle := tmp;

            imgPre.IEBitmap.Assign(bmp);

            imgPre.Refresh();
            imgPre.Visible := true;

            FreeAndNil(bmp);
    		end
  		else
    		begin
    		pnlPreview.Caption := 'No preview available';
            imgPre.Visible := false;
            imgPre.Repaint();
    		end;
  		end;
end;

procedure TfrmFltPreview.sbnNormalClick(Sender: TObject);
begin
	imgPre.AutoFit := false;
    imgPre.Zoom := 100;
    imgPre.CenterImage();
    imgPre.Refresh();
    sbnNormal.Down := true;
    sbnFit.Down := false;
end;

procedure TfrmFltPreview.sbnFitClick(Sender: TObject);
begin
	imgPre.AutoFit := true;
    imgPre.Refresh();
    sbnNormal.Down := false;
    sbnFit.Down := true;
end;

end.
