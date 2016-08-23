unit w_editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ieview, imageenview, ComCtrls, ToolWin, StdCtrls,
  imageenproc, AppEvnts, c_const, ToolbarEx, c_wndpos, c_utils, Clipbrd, Menus,
  hyieutils, hyiedefs, c_locales, hsvbox, c_reg;

const
  FM_RECTSELECT 				= 0;
  FM_HAND 						= 1;
  FM_DRAW 						= 2;
  FM_PREVIEW 					= 3;
  FM_PENCIL						= 4;
  FM_FLOODFILL					= 5;

type
  TfrmEditor = class(TForm)
    cbrEditor: TCoolBar;
    tbrEditor: TToolBar;
    sbxBottom: TScrollBox;
    sbxSide: TScrollBox;
    img: TImageEnView;
    btnApply: TButton;
    btnCancel: TButton;
    tbnCut: TToolButton;
    tbnCopy: TToolButton;
    tbnZoom: TToolButton;
    Sep2: TToolButton;
    Sep3: TToolButton;
    tbnPaste: TToolButton;
    tbnRedo: TToolButton;
    tbnUndo: TToolButton;
    proc: TImageEnProc;
    sbxColor: TScrollBox;
    lblColor: TLabel;
    pnlColor: TPanel;
    lvwFilters: TListView;
    appEvents: TApplicationEvents;
    Sep5: TToolButton;
    Sep6: TToolButton;
    tbnResize: TToolButton;
    tbnRotate: TToolButton;
    imgPreview: TImageEnView;
    tbnSelection: TToolButton;
    popSelection: TPopupMenu;
    popZoom: TPopupMenu;
    piSelectAll: TMenuItem;
    piRemoveSelection: TMenuItem;
    piInvertSelection: TMenuItem;
    N1: TMenuItem;
    tbnCrop: TToolButton;
    tbnSetFit: TToolButton;
    tbnEraseSelection: TToolButton;
    tbnPasteSel: TToolButton;
    piZm6: TMenuItem;
    piZm12: TMenuItem;
    piZm25: TMenuItem;
    piZm50: TMenuItem;
    piZm75: TMenuItem;
    piZm100: TMenuItem;
    piZm150: TMenuItem;
    piZm200: TMenuItem;
    piZm400: TMenuItem;
    tbnModSel: TToolButton;
    tbnModDraw: TToolButton;
    tbnModHand: TToolButton;
    Sep1: TToolButton;
    pnlColorSelector: TPanel;
    boxColorSelector: THSVBox;
    pnlSep1: TPanel;
    pnlSep2: TPanel;
    tbnModPencil: TToolButton;
    tbnModFlood: TToolButton;
    pnlFlood: TPanel;
    lblTolerance: TLabel;
    pnlTolerance: TPanel;
    edtTolerance: TEdit;
    updTolerance: TUpDown;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnApplyClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tbnCutClick(Sender: TObject);
    procedure tbnCopyClick(Sender: TObject);
    procedure tbnPasteClick(Sender: TObject);
    procedure tbnUndoClick(Sender: TObject);
    procedure tbnRedoClick(Sender: TObject);
    procedure appEventsIdle(Sender: TObject; var Done: Boolean);
    procedure tbnResizeClick(Sender: TObject);
    procedure tbnRotateClick(Sender: TObject);
    procedure lvwFiltersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure piSelectAllClick(Sender: TObject);
    procedure piInvertSelectionClick(Sender: TObject);
    procedure piRemoveSelectionClick(Sender: TObject);
    procedure tbnCropClick(Sender: TObject);
    procedure tbnSetFitClick(Sender: TObject);
    procedure lvwFiltersDblClick(Sender: TObject);
    procedure tbnEraseSelectionClick(Sender: TObject);
    procedure tbnPasteSelClick(Sender: TObject);
    procedure piZm6Click(Sender: TObject);
    procedure piZm12Click(Sender: TObject);
    procedure piZm25Click(Sender: TObject);
    procedure piZm50Click(Sender: TObject);
    procedure piZm75Click(Sender: TObject);
    procedure piZm100Click(Sender: TObject);
    procedure piZm150Click(Sender: TObject);
    procedure piZm200Click(Sender: TObject);
    procedure piZm400Click(Sender: TObject);
    procedure tbnModSelClick(Sender: TObject);
    procedure tbnModHandClick(Sender: TObject);
    procedure tbnModDrawClick(Sender: TObject);
    procedure boxColorSelectorChange(Sender: TObject);
    procedure tbnModPencilClick(Sender: TObject);
    procedure tbnModFloodClick(Sender: TObject);
    procedure imgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure imgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    procedure HandleFilter(name: string);
    procedure SetCurrentMode(mode: integer);
  public
    nCurrentMode, nPreviousMode: integer;
    procedure Localize();
  end;

var
	frmEditor: TfrmEditor;

function ProcessPreview(preview: HBITMAP): BOOL; cdecl;


implementation

uses main, w_resize, w_rotate, f_ui, w_show;

{$R *.dfm}

procedure TfrmEditor.FormCreate(Sender: TObject);
var
	filters: TStringList;
    i: integer;
	wreg: TFRegistry;
begin
	wreg := TFRegistry.Create(RA_READONLY);
	wreg.RootKey := HKEY_CURRENT_USER;

    if Assigned(frmShow) then
  		frmShow.Close();

	frmMain.Menu := nil;
    FSSavePos(true);
    frmMain.tbrMain.Hide();
    frmmain.sbrMain.Hide();

    img.Blank();
    img.EnableShiftKey := false;
    tbnSelection.WholeDropDown := true;
    tbnZoom.WholeDropDown := true;

    Localize();

    nPreviousMode := FM_RECTSELECT;
    SetCurrentMode(FM_RECTSELECT);

    // XP or not XP - that is the question
    if IsThemed() then
    	begin
        sbxSide.BevelEdges := [beTop, beLeft, beRight];
        imgPreview.BorderStyle := bsNone;
        img.BorderStyle := bsNone;
        sbxColor.BevelEdges := [];
        end;

    // reading settings
	if wreg.OpenKey(sSettings, false) then
    	begin
    	if wreg.RBool('Editor_ZoomToFit', true) then
        	tbnSetFitClick(Self);

    	updTolerance.Position := wreg.RInt('Editor_Tolerance', 10);
    	sbxColor.Color := StringToColor(wreg.RStr('Editor_Color', 'clWhite'));

		wreg.CloseKey();
    	end
    else
    	begin
        tbnSetFitClick(Self);

        updTolerance.Position := 10;
        sbxColor.Color := clWhite;
        end;

    boxColorSelector.SetColor(sbxColor.Color);

	// getting main image
    img.Background := frmMain.sbxMain.Color;
    img.IEBitmap.AssignImage(frmMain.img.IEBitmap);
    img.Update();

	// getting filter names and creating entries for them
    filters := TStringList.Create();
    filters.Duplicates := dupIgnore;
    filters.Sorted := true;

	if wreg.OpenKey(sModules + '\' + PS_FFILTER, false) then
    	begin
		wreg.GetValueNames(filters);

		wreg.CloseKey();
        end;

    filters.Add(LoadLStr(1750));
    filters.Add(LoadLStr(1751));
    filters.Add(LoadLStr(1752));
    filters.Add(LoadLStr(1753));
    filters.Add(LoadLStr(1754));

    for i := 0 to (filters.Count - 1) do
        begin
        lvwFilters.AddItem(filters[i], nil);
        lvwFilters.Items[i].ImageIndex := 5;
        end;

    FreeAndNil(filters);
    FreeAndNil(wreg);

    lvwFilters.Refresh();
end;

procedure TfrmEditor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    frmMain.Menu := frmMain.mnuMain;
    FSRestorePos(true);

	Action := caFree;
end;

procedure TfrmEditor.FormDestroy(Sender: TObject);
begin
	frmEditor := nil;
end;

procedure TfrmEditor.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if (Key = VK_ESCAPE) then
  		Self.Close();
end;

procedure TfrmEditor.btnApplyClick(Sender: TObject);
begin
    // saving settings
    FxRegWBool('Editor_ZoomToFit', img.AutoShrink);
    FxRegWStr('Editor_Color', ColorToString(boxColorSelector.Color));
	FxRegWInt('Editor_Tolerance', updTolerance.Position);

    // working
	frmMain.img.Proc.SaveUndo();
    frmMain.img.Proc.ClearAllRedo();
    frmMain.img.IEBitmap.AssignImage(img.IEBitmap);
    frmMain.img.Update();

	Self.Close();
end;

procedure TfrmEditor.btnCancelClick(Sender: TObject);
begin
	Self.Close();
end;

procedure TfrmEditor.tbnCutClick(Sender: TObject);
var
	bmp: TBitmap;
begin
	bmp := TBitmap.Create();

    if img.Selected then
		img.CopySelectionToBitmap(bmp)
    else
        img.IEBitmap.CopyToTBitmap(bmp);

    Clipboard.Assign(bmp);
    FreeAndNil(bmp);

    proc.Fill(TColor2TRGB(sbxColor.Color));
    proc.ClearAllRedo();
end;

procedure TfrmEditor.tbnCopyClick(Sender: TObject);
begin
    if img.Selected then
    	proc.SelCopyToClip()
    else
        proc.CopyToClipboard();
    proc.ClearAllRedo();
end;

procedure TfrmEditor.tbnPasteClick(Sender: TObject);
begin
    proc.AutoUndo := false;
    proc.SaveUndo();

	if img.Selected then
        proc.PointPasteFromClip(img.SelX1, img.SelY1)
    else
        proc.PasteFromClipboard();

    proc.ConvertTo24Bit();
    
    proc.ClearAllRedo();
    proc.AutoUndo := true;
end;

procedure TfrmEditor.tbnPasteSelClick(Sender: TObject);
begin
	if img.Selected then
    	begin
    	proc.AutoUndo := false;
    	proc.SaveUndo();

		proc.SelPasteFromClip();
    	proc.ConvertTo24Bit();

        proc.ClearAllRedo();
    	proc.AutoUndo := true;
    	end;
end;

procedure TfrmEditor.tbnUndoClick(Sender: TObject);
begin
	proc.SaveRedo();
	proc.Undo();
    proc.ClearUndo();
end;

procedure TfrmEditor.tbnRedoClick(Sender: TObject);
begin
    proc.SaveUndo();
	proc.Redo();
    proc.ClearRedo();
end;

procedure TfrmEditor.tbnSetFitClick(Sender: TObject);
begin
	img.AutoShrink := not img.AutoShrink;

    tbnSetFit.Down := img.AutoShrink;

    if img.AutoShrink then
    	img.Update()
    else
    	img.Zoom := 100.0;
end;

procedure TfrmEditor.tbnResizeClick(Sender: TObject);
begin
	HandleFilter(LoadLStr(1753));
end;

procedure TfrmEditor.tbnRotateClick(Sender: TObject);
begin
	HandleFilter(LoadLStr(1754));
end;

procedure TfrmEditor.tbnCropClick(Sender: TObject);
begin
	proc.CropSel();
    proc.ClearAllRedo();

    if not img.AutoShrink then
    	img.Fit();
end;

procedure TfrmEditor.tbnEraseSelectionClick(Sender: TObject);
begin
    proc.Fill(TColor2TRGB(sbxColor.Color));
    proc.ClearAllRedo();
end;

procedure TfrmEditor.appEventsIdle(Sender: TObject; var Done: Boolean);
begin
    tbnEraseSelection.Enabled := img.Selected;

    tbnZoom.Enabled := not img.AutoShrink;

    tbnCrop.Enabled := img.Selected;

    piInvertSelection.Enabled := img.Selected;
    piRemoveSelection.Enabled := img.Selected;

    tbnUndo.Enabled := proc.CanUndo;
    tbnRedo.Enabled := proc.CanRedo;

    tbnPaste.Enabled := Clipboard.HasFormat(CF_BITMAP);
    tbnPasteSel.Enabled := (tbnPaste.Enabled and img.Selected);
end;

procedure TfrmEditor.lvwFiltersDblClick(Sender: TObject);
begin
    if Assigned(lvwFilters.Selected) then
        HandleFilter(lvwFilters.Selected.Caption);
end;

procedure TfrmEditor.lvwFiltersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if ((Key = VK_RETURN) or (Key = VK_SPACE)) then
    	Self.lvwFiltersDblClick(Self);
end;

procedure TfrmEditor.piSelectAllClick(Sender: TObject);
begin
	img.Select(0, 0, img.IEBitmap.Width, img.IEBitmap.Height);
end;

procedure TfrmEditor.piInvertSelectionClick(Sender: TObject);
begin
	img.InvertSelection();
end;

procedure TfrmEditor.piRemoveSelectionClick(Sender: TObject);
begin
	img.DeSelect();
end;

procedure TfrmEditor.HandleFilter(name: string);
var
	FxImgFilter: TFxImgFilter;
	lib: THandle;
	func_result: hBitmap;
	local_image, local_result: TBitmap;
    tmp_res: TFxImgResult;
begin
	// starting the stuff
    func_result := 0;
    nPreviousMode := nCurrentMode;

	// trying external filters
    lib := LoadLibrary(PChar(FxRegRStr(name, '', sModules + '\' + PS_FFILTER)));

    if (lib <> 0) then
    	begin
        @FxImgFilter := GetProcAddress(lib, EX_FILTER);

        if (@FxImgFilter <> nil) then
        	begin
            local_image := TBitmap.Create();

            if img.Selected then
            	img.CopySelectionToBitmap(local_image)
            else
                img.IEBitmap.CopyToTBitmap(local_image);

            local_image.PixelFormat := pf24bit;

            tmp_res := FxImgFilter(PChar(name), local_image.ReleaseHandle(), @ProcessPreview, Application.Handle, Self.Handle, FxImgGlobalCallback);

            if (tmp_res.result_type = RT_HBITMAP) then
            	func_result := tmp_res.result_value
            else
            	func_result := 0;

            FreeAndNil(local_image);
            end;

  		FreeLibrary(lib);
        end;

    // well, if there is no externals... (rotate and resize should be last in the list)
    if (func_result = 0) then
    	begin
    	if (name = LoadLStr(1750)) then
            begin
            proc.Negative();
            proc.ClearAllRedo();
            end

    	else if (name = LoadLStr(1751)) then
            begin
            proc.ConvertToGray();
            proc.ClearAllRedo();
            end

        else if (name = LoadLStr(1752)) then
            begin
        	proc.RemoveRedEyes();
            proc.ClearAllRedo();
            end

        else if (name = LoadLStr(1753)) then
        	begin
            if not Assigned(frmResize) then
  				begin
  				Application.CreateForm(TfrmResize, frmResize);
  				frmResize.ShowModal();
  				end;
            end

        else if (name = LoadLStr(1754)) then
        	begin
            if not Assigned(frmRotate) then
  				begin
  				Application.CreateForm(TfrmRotate, frmRotate);
  				frmRotate.ShowModal();
  				end;
            end;
        end;
    
    // end of fun - finalization of process
    if (func_result <> 0) then
    	begin
        local_result := TBitmap.Create();
        local_result.Handle := func_result;
        local_result.PixelFormat := pf24bit;

        proc.AutoUndo := false;
        proc.SaveUndo();

        if img.Selected then
        	begin
            // insert into current selection
            if (HiWord(GetKeyState(VK_SHIFT)) = 0) then
            	img.IEBitmap.Canvas.Draw(img.SelX1, img.SelY1, local_result)
            else
            	img.IEBitmap.Canvas.StretchDraw(Rect(img.SelX1, img.SelY1, img.SelX2, img.SelY2), local_result);
            end
        else
        	img.IEBitmap.Assign(local_result);

        img.Update();

        proc.ClearAllRedo();
        proc.AutoUndo := true;

        FreeAndNil(local_result);
        end;

    if (nPreviousMode = FM_PREVIEW) then
    	nPreviousMode := FM_RECTSELECT;
            
    if (nCurrentMode = FM_PREVIEW) then
    	SetCurrentMode(nPreviousMode);

    imgPreview.Blank();
end;

procedure TfrmEditor.piZm6Click(Sender: TObject);
begin
	img.Zoom := 6.25;
end;

procedure TfrmEditor.piZm12Click(Sender: TObject);
begin
	img.Zoom := 12.5;
end;

procedure TfrmEditor.piZm25Click(Sender: TObject);
begin
	img.Zoom := 25.0;
end;

procedure TfrmEditor.piZm50Click(Sender: TObject);
begin
	img.Zoom := 50.0;
end;

procedure TfrmEditor.piZm75Click(Sender: TObject);
begin
	img.Zoom := 75.0;
end;

procedure TfrmEditor.piZm100Click(Sender: TObject);
begin
	img.Zoom := 100.0;
end;

procedure TfrmEditor.piZm150Click(Sender: TObject);
begin
	img.Zoom := 150.0;
end;

procedure TfrmEditor.piZm200Click(Sender: TObject);
begin
	img.Zoom := 200.0;
end;

procedure TfrmEditor.piZm400Click(Sender: TObject);
begin
	img.Zoom := 400.0;
end;

procedure TfrmEditor.SetCurrentMode(mode: integer);
begin
    nCurrentMode := mode;

	case mode of
    	FM_RECTSELECT:
        	begin
            img.Visible := true;
            imgPreview.Visible := false;

            tbnModSel.Down := true;
            tbnModHand.Down := false;
            tbnModDraw.Down := false;
            tbnModPencil.Down := false;
            tbnModFlood.Down := false;
            tbrEditor.Enabled := true;

            Sep1.Visible := true;
            tbnCut.Visible := true;
            tbnCopy.Visible := true;
            tbnPaste.Visible := true;
            tbnPasteSel.Visible := true;
            Sep2.Visible := true;
            tbnUndo.Visible := true;
            tbnRedo.Visible := true;
            Sep3.Visible := true;
            tbnSetFit.Visible := true;
            tbnZoom.Visible := true;
            Sep5.Visible := true;
            tbnSelection.Visible := true;
            tbnEraseSelection.Visible := true;
            Sep6.Visible := true;
            tbnResize.Visible := true;
            tbnCrop.Visible := true;
            tbnRotate.Visible := true;

            pnlFlood.Visible := false;

            img.MouseInteract := [miSelect];
            end;

  		FM_HAND:
        	begin
            img.Visible := true;
            imgPreview.Visible := false;

            tbnModSel.Down := false;
            tbnModHand.Down := true;
            tbnModDraw.Down := false;
            tbnModPencil.Down := false;
            tbnModFlood.Down := false;
			tbrEditor.Enabled := true;

            Sep1.Visible := true;
            tbnCut.Visible := true;
            tbnCopy.Visible := true;
            tbnPaste.Visible := true;
            tbnPasteSel.Visible := false;
            Sep2.Visible := true;
            tbnUndo.Visible := true;
            tbnRedo.Visible := true;
            Sep3.Visible := true;
            tbnSetFit.Visible := true;
            tbnZoom.Visible := true;
            Sep5.Visible := true;
            tbnSelection.Visible := false;
            tbnEraseSelection.Visible := false;
            Sep6.Visible := false;
            tbnResize.Visible := true;
            tbnCrop.Visible := false;
            tbnRotate.Visible := true;

            pnlFlood.Visible := false;

            img.DeSelect();
            img.MouseInteract := [miScroll];
            end;

  		FM_DRAW:
        	begin
            img.Visible := true;
            imgPreview.Visible := false;

            tbnModSel.Down := false;
            tbnModHand.Down := false;
            tbnModDraw.Down := true;
            tbnModPencil.Down := false;
            tbnModFlood.Down := false;
            tbrEditor.Enabled := true;

            Sep1.Visible := false;
            tbnCut.Visible := false;
            tbnCopy.Visible := false;
            tbnPaste.Visible := false;
            tbnPasteSel.Visible := false;
            Sep2.Visible := true;
            tbnUndo.Visible := true;
            tbnRedo.Visible := true;
            Sep3.Visible := true;
            tbnSetFit.Visible := true;
            tbnZoom.Visible := true;
            Sep5.Visible := false;
            tbnSelection.Visible := false;
            tbnEraseSelection.Visible := false;
            Sep6.Visible := false;
            tbnResize.Visible := false;
            tbnCrop.Visible := false;
            tbnRotate.Visible := false;

            pnlFlood.Visible := false;

            img.DeSelect();
            img.MouseInteract := [];
            end;

  		FM_PREVIEW:
        	begin
            imgPreview.Visible := true;
            img.Visible := false;

            tbnModSel.Down := false;
            tbnModHand.Down := false;
            tbnModDraw.Down := false;
            tbnModPencil.Down := false;
            tbnModFlood.Down := false;
            tbrEditor.Enabled := false;

            Sep1.Visible := true;
            tbnCut.Visible := true;
            tbnCopy.Visible := true;
            tbnPaste.Visible := true;
            tbnPasteSel.Visible := true;
            Sep2.Visible := true;
            tbnUndo.Visible := true;
            tbnRedo.Visible := true;
            Sep3.Visible := true;
            tbnSetFit.Visible := true;
            tbnZoom.Visible := true;
            Sep5.Visible := true;
            tbnSelection.Visible := true;
            tbnEraseSelection.Visible := true;
            Sep6.Visible := true;
            tbnResize.Visible := true;
            tbnCrop.Visible := true;
            tbnRotate.Visible := true;

            pnlFlood.Visible := false;

            img.MouseInteract := [miSelect];
            end;

  		FM_PENCIL:
        	begin
            img.Visible := true;
            imgPreview.Visible := false;

            tbnModSel.Down := false;
            tbnModHand.Down := false;
            tbnModDraw.Down := false;
            tbnModPencil.Down := true;
            tbnModFlood.Down := false;
			tbrEditor.Enabled := true;

            Sep1.Visible := false;
            tbnCut.Visible := false;
            tbnCopy.Visible := false;
            tbnPaste.Visible := false;
            tbnPasteSel.Visible := false;
            Sep2.Visible := true;
            tbnUndo.Visible := true;
            tbnRedo.Visible := true;
            Sep3.Visible := true;
            tbnSetFit.Visible := true;
            tbnZoom.Visible := true;
            Sep5.Visible := false;
            tbnSelection.Visible := false;
            tbnEraseSelection.Visible := false;
            Sep6.Visible := false;
            tbnResize.Visible := false;
            tbnCrop.Visible := false;
            tbnRotate.Visible := false;

            pnlFlood.Visible := false;

            img.DeSelect();
            img.MouseInteract := [];
            end;

  		FM_FLOODFILL:
        	begin
            img.Visible := true;
            imgPreview.Visible := false;

            tbnModSel.Down := false;
            tbnModHand.Down := false;
            tbnModDraw.Down := false;
            tbnModPencil.Down := false;
            tbnModFlood.Down := true;
			tbrEditor.Enabled := true;

            Sep1.Visible := false;
            tbnCut.Visible := false;
            tbnCopy.Visible := false;
            tbnPaste.Visible := false;
            tbnPasteSel.Visible := false;
            Sep2.Visible := true;
            tbnUndo.Visible := true;
            tbnRedo.Visible := true;
            Sep3.Visible := true;
            tbnSetFit.Visible := true;
            tbnZoom.Visible := true;
            Sep5.Visible := false;
            tbnSelection.Visible := false;
            tbnEraseSelection.Visible := false;
            Sep6.Visible := false;
            tbnResize.Visible := false;
            tbnCrop.Visible := false;
            tbnRotate.Visible := false;

            pnlFlood.Visible := true;

            img.DeSelect();
            img.MouseInteract := [];
            end;
    end;
end;

procedure TfrmEditor.tbnModSelClick(Sender: TObject);
begin
	SetCurrentMode(FM_RECTSELECT);
end;

procedure TfrmEditor.tbnModHandClick(Sender: TObject);
begin
	SetCurrentMode(FM_HAND);
end;

procedure TfrmEditor.tbnModDrawClick(Sender: TObject);
begin
	SetCurrentMode(FM_DRAW);
end;

function ProcessPreview(preview: HBITMAP): BOOL;
var
	local_preview: TBitmap;
begin
    Result := false;

    if Assigned(frmEditor) then
    	begin
        Result := true;

    	if (preview = 0) then
            begin
            // reset preview
            if frmEditor.img.Selected then
                frmEditor.img.CopySelectionToIEBitmap(frmEditor.imgPreview.IEBitmap)
            else
            	frmEditor.imgPreview.IEBitmap.AssignImage(frmEditor.img.IEBitmap);
            end
    	else
    		begin
        	// updating preview
            local_preview := TBitmap.Create();
            local_preview.Handle := preview;

            frmEditor.imgPreview.IEBitmap.Assign(local_preview);

            FreeAndNil(local_preview);
        	end;

        frmEditor.imgPreview.Update();
        frmEditor.SetCurrentMode(FM_PREVIEW);
        end;
end;

procedure TfrmEditor.Localize();
begin
    Self.Caption				:= Format(LoadLStr(880), [sAppName]);

    tbrEditor.Caption			:= LoadLStr(881);
    tbnModSel.Caption			:= LoadLStr(882);
    tbnModSel.Hint				:= LoadLStr(883);
    tbnModHand.Caption			:= LoadLStr(884);
    tbnModHand.Hint				:= LoadLStr(885);
    tbnModDraw.Caption			:= LoadLStr(886);
    tbnModDraw.Hint				:= LoadLStr(887);
    tbnModPencil.Caption		:= LoadLStr(922);
    tbnModPencil.Hint			:= LoadLStr(923);
    tbnModFlood.Caption			:= LoadLStr(924);
    tbnModFlood.Hint			:= LoadLStr(925);

    tbnCut.Caption				:= LoadLStr(888);
    tbnCut.Hint					:= LoadLStr(889);
    tbnCopy.Caption				:= LoadLStr(890);
    tbnCopy.Hint				:= LoadLStr(891);
    tbnPaste.Caption			:= LoadLStr(892);
    tbnPaste.Hint				:= LoadLStr(893);
    tbnPasteSel.Caption			:= LoadLStr(894);
    tbnPasteSel.Hint			:= LoadLStr(895);
    tbnUndo.Caption				:= LoadLStr(896);
    tbnUndo.Hint				:= LoadLStr(897);
    tbnRedo.Caption				:= LoadLStr(898);
    tbnRedo.Hint				:= LoadLStr(899);
    tbnSetFit.Caption			:= LoadLStr(900);
    tbnSetFit.Hint				:= LoadLStr(901);
    tbnZoom.Caption				:= LoadLStr(902);
    tbnZoom.Hint				:= LoadLStr(903);
    tbnSelection.Caption		:= LoadLStr(904);
    tbnSelection.Hint			:= LoadLStr(905);
    tbnEraseSelection.Caption	:= LoadLStr(906);
    tbnEraseSelection.Hint		:= LoadLStr(907);
    tbnResize.Caption			:= LoadLStr(908);
    tbnResize.Hint				:= LoadLStr(909);
    tbnCrop.Caption				:= LoadLStr(910);
    tbnCrop.Hint				:= LoadLStr(911);
    tbnRotate.Caption			:= LoadLStr(912);
    tbnRotate.Hint				:= LoadLStr(913);

    piSelectAll.Caption			:= LoadLStr(914);
    piSelectAll.Hint			:= LoadLStr(915);
    piInvertSelection.Caption	:= LoadLStr(916);
    piInvertSelection.Hint		:= LoadLStr(917);
    piRemoveSelection.Caption	:= LoadLStr(918);
    piRemoveSelection.Hint		:= LoadLStr(919);

    piZm6.Caption				:= LoadLStr(236);
    piZm6.Hint					:= LoadLStr(237);
    piZm12.Caption				:= LoadLStr(238);
    piZm12.Hint					:= LoadLStr(239);
    piZm25.Caption				:= LoadLStr(240);
    piZm25.Hint					:= LoadLStr(241);
    piZm50.Caption				:= LoadLStr(242);
    piZm50.Hint					:= LoadLStr(243);
    piZm75.Caption				:= LoadLStr(244);
    piZm75.Hint					:= LoadLStr(245);
    piZm100.Caption				:= LoadLStr(246);
    piZm100.Hint				:= LoadLStr(247);
    piZm150.Caption				:= LoadLStr(248);
    piZm150.Hint				:= LoadLStr(249);
    piZm200.Caption				:= LoadLStr(250);
    piZm200.Hint				:= LoadLStr(251);
    piZm400.Caption				:= LoadLStr(252);
    piZm400.Hint				:= LoadLStr(253);

    lblColor.Caption			:= LoadLStr(921);
    boxColorSelector.Hint		:= LoadLStr(745);

    lblTolerance.Caption		:= LoadLStr(926);
    btnApply.Caption			:= LoadLStr(55);
    btnCancel.Caption			:= LoadLStr(51);
end;

procedure TfrmEditor.boxColorSelectorChange(Sender: TObject);
begin
    sbxColor.Color := boxColorSelector.Color;
end;

procedure TfrmEditor.tbnModPencilClick(Sender: TObject);
begin
	SetCurrentMode(FM_PENCIL);
end;

procedure TfrmEditor.tbnModFloodClick(Sender: TObject);
begin
	SetCurrentMode(FM_FLOODFILL);
end;

procedure TfrmEditor.imgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if (ssLeft in Shift) then
    	begin
    	if (nCurrentMode = FM_PENCIL) then
    		begin
        	// pencil
            proc.AutoUndo := false;
            proc.SaveUndo();
            proc.ClearAllRedo();
            proc.AttachedIEBitmap.Pixels_ie24RGB[img.XScr2Bmp(X), img.Yscr2Bmp(Y)] := CreateRGB(boxColorSelector.Red, boxColorSelector.Green, boxColorSelector.Blue);
            img.Update();
            proc.AutoUndo := true;
        	end
    	else if (nCurrentMode = FM_FLOODFILL) then
    		begin
        	// flood fill
        	proc.CastColor(img.XScr2Bmp(X), img.Yscr2Bmp(Y), CreateRGB(boxColorSelector.Red, boxColorSelector.Green, boxColorSelector.Blue), updTolerance.Position);
        	end;
        end;
end;

procedure TfrmEditor.imgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
	if ((ssLeft in Shift) and (nCurrentMode = FM_PENCIL)) then
    	begin
        // pencil
        proc.AttachedIEBitmap.Pixels_ie24RGB[img.XScr2Bmp(X), img.Yscr2Bmp(Y)] := CreateRGB(boxColorSelector.Red, boxColorSelector.Green, boxColorSelector.Blue);
        img.Update();
        end;
end;

end.
