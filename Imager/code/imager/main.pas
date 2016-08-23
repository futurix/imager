unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ToolWin, ImgList, ExtCtrls, ShellAPI, Registry, UxTheme,
  MRUfiles, futuris_dlgopen, c_const, c_pos, c_reg, AgOpenDialog, c_utils,
  ieview, imageenview, hyieutils, c_toolbar, ImageEnIO;

type
  TfrmMain = class(TForm)
    mnuMain: TMainMenu;
    popMain: TPopupMenu;
    popZoom: TPopupMenu;
    popBars: TPopupMenu;
    mFile: TMenuItem;
    mEdit: TMenuItem;
    mView: TMenuItem;
    mGo: TMenuItem;
    mTools: TMenuItem;
    mHelp: TMenuItem;
    miOpen: TMenuItem;
    miSaveAs: TMenuItem;
    miClose: TMenuItem;
    N1: TMenuItem;
    miReopen: TMenuItem;
    mImport: TMenuItem;
    mExport: TMenuItem;
    miPrint: TMenuItem;
    miExit: TMenuItem;
    miCopy: TMenuItem;
    miPaste: TMenuItem;
    N6: TMenuItem;
    miStatusBar: TMenuItem;
    N7: TMenuItem;
    mZoom: TMenuItem;
    miZoomIn: TMenuItem;
    miZoomOut: TMenuItem;
    miToolbar: TMenuItem;
    miZM100: TMenuItem;
    N10: TMenuItem;
    miZMCustom: TMenuItem;
    miZM6: TMenuItem;
    miZM12: TMenuItem;
    miZM25: TMenuItem;
    miZM50: TMenuItem;
    miZM200: TMenuItem;
    miZM400: TMenuItem;
    miFullScreen: TMenuItem;
    miGoBack: TMenuItem;
    miGoForward: TMenuItem;
    N12: TMenuItem;
    N14: TMenuItem;
    miInfo: TMenuItem;
    miSettings: TMenuItem;
    miHelpContents: TMenuItem;
    miAbout: TMenuItem;
    imlMain: TImageList;
    itbMain: TToolBar;
    tbnOpen: TToolButton;
    sbxMain: TScrollBox;
    N22: TMenuItem;
    piBack: TMenuItem;
    piForward: TMenuItem;
    piOpen: TMenuItem;
    piFullScreen: TMenuItem;
    piMinimize: TMenuItem;
    piZM6: TMenuItem;
    piZM12: TMenuItem;
    piZM25: TMenuItem;
    piZM50: TMenuItem;
    piZM100: TMenuItem;
    piZM200: TMenuItem;
    piZM400: TMenuItem;
    N25: TMenuItem;
    Sep_1: TToolButton;
    tbnZoomMisc: TToolButton;
    piTBMain: TMenuItem;
    tbnSave: TToolButton;
    tbnClose: TToolButton;
    tbnPrint: TToolButton;
    Sep_2: TToolButton;
    tbnCopy: TToolButton;
    tbnPaste: TToolButton;
    Sep_3: TToolButton;
    tbnFullScreen: TToolButton;
    tbnInfo: TToolButton;
    tbnGoBack: TToolButton;
    tbnGoForward: TToolButton;
    piStatusBar: TMenuItem;
    mRecent: TMenuItem;
    NRecent: TMenuItem;
    MRU: TMRUFiles;
    dlgOpen: TFuturisOpenDialog;
    N2: TMenuItem;
    mToolbars: TMenuItem;
    N11: TMenuItem;
    Sep_7: TToolButton;
    dlgInstPlug: TOpenDialog;
    tbnFilters: TToolButton;
    miFiltersDialog: TMenuItem;
    piClose: TMenuItem;
    pAnim: TMenuItem;
    pMulti: TMenuItem;
    piAnimPlay: TMenuItem;
    piAnimPause: TMenuItem;
    piAnimStop: TMenuItem;
    piMultiFirst: TMenuItem;
    piMultiPrevious: TMenuItem;
    piMultiNext: TMenuItem;
    piMultiLast: TMenuItem;
    N26: TMenuItem;
    piMultiGoTo: TMenuItem;
    piMultiExtract: TMenuItem;
    Sep_9: TToolButton;
    miPrintPreview: TMenuItem;
    Sep_8: TToolButton;
    N29: TMenuItem;
    miShow: TMenuItem;
    miStartSlideShow: TMenuItem;
    tbnLast: TToolButton;
    miNew: TMenuItem;
    piZM75: TMenuItem;
    piZM150: TMenuItem;
    miZM75: TMenuItem;
    miZM150: TMenuItem;
    sbrMain: TStatusBar;
    miFuturisWebSite: TMenuItem;
    N16: TMenuItem;
    miFDelete: TMenuItem;
    miFCopy: TMenuItem;
    miFRename: TMenuItem;
    miFMove: TMenuItem;
    N34: TMenuItem;
    N13: TMenuItem;
    Sep_12: TToolButton;
    N20: TMenuItem;
    imlDisabled: TImageList;
    piZoomCustom: TMenuItem;
    N4: TMenuItem;
    tbrMain: TCoolBar;
    N15: TMenuItem;
    N17: TMenuItem;
    miGoFirst: TMenuItem;
    miGoLast: TMenuItem;
    miGoRandom: TMenuItem;
    tbnZoomIn: TToolButton;
    tbnZoomOut: TToolButton;
    tbnGoRandom: TToolButton;
    miUndo: TMenuItem;
    tbnUndo: TToolButton;
    img: TImageEnView;
    N8: TMenuItem;
    miZmFit: TMenuItem;
    miZmWidth: TMenuItem;
    miZmHeight: TMenuItem;
    N9: TMenuItem;
    piZmFit: TMenuItem;
    piZmWidth: TMenuItem;
    piZmHeight: TMenuItem;
    mDisplayStyle: TMenuItem;
    miDSNormal: TMenuItem;
    miDSFit: TMenuItem;
    N18: TMenuItem;
    miDSCenterImage: TMenuItem;
    miDSScrollbars: TMenuItem;
    N21: TMenuItem;
    popDisp: TPopupMenu;
    tbnDisp: TToolButton;
    tbnMultiPrev: TToolButton;
    tbnMultiNext: TToolButton;
    piDSNormal: TMenuItem;
    piDSFit: TMenuItem;
    N23: TMenuItem;
    piDSCenterImage: TMenuItem;
    piDSScrollbars: TMenuItem;
    mMulti: TMenuItem;
    mAnim: TMenuItem;
    miMultiFirst: TMenuItem;
    miMultiPrevious: TMenuItem;
    miMultiNext: TMenuItem;
    miMultiLast: TMenuItem;
    N24: TMenuItem;
    miMultiGoTo: TMenuItem;
    miMultiExtract: TMenuItem;
    miAnimPlay: TMenuItem;
    miAnimPause: TMenuItem;
    miAnimStop: TMenuItem;
    dlgSave: TSaveDialog;
    Sep_14: TToolButton;
	popMRU: TPopupMenu;
    piMRU: TMenuItem;
    MRUpop: TMRUFiles;
    N3: TMenuItem;
    Sep_16: TToolButton;
    Sep_17: TToolButton;
    tbnRotate: TToolButton;
    miRotateView: TMenuItem;
    miRotateViewCCW: TMenuItem;
    popNoMRU: TPopupMenu;
    piMyOpen: TMenuItem;

    procedure Initialize();
    procedure ShutDown();
    procedure HandleFIPISimport(Sender: TObject);
    procedure HandleFIPISexport(Sender: TObject);
    procedure HandleFIPISfilter(Sender: TObject);
    procedure HandleFIPIStool(Sender: TObject);
    procedure DragNDrop(var msg: TWMDropFiles); message WM_DropFiles;
    procedure miAboutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miOpenClick(Sender: TObject);
    procedure miReopenClick(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure miSaveAsClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure miCopyClick(Sender: TObject);
    procedure miPasteClick(Sender: TObject);
    procedure miFullScreenClick(Sender: TObject);
    procedure miGoBackClick(Sender: TObject);
    procedure miGoForwardClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure miPrintClick(Sender: TObject);
    procedure miZM12Click(Sender: TObject);
    procedure miZM25Click(Sender: TObject);
    procedure miZM50Click(Sender: TObject);
    procedure miZM75Click(Sender: TObject);
    procedure miZM100Click(Sender: TObject);
    procedure miZM150Click(Sender: TObject);
    procedure miZM200Click(Sender: TObject);
    procedure miZM400Click(Sender: TObject);
    procedure miZoomInClick(Sender: TObject);
    procedure miZoomOutClick(Sender: TObject);
    procedure miZMCustomClick(Sender: TObject);
    procedure MRUClick(Sender: TObject; FileName: String);
    procedure miSettingsClick(Sender: TObject);
    procedure miToolbarClick(Sender: TObject);
    procedure miStatusBarClick(Sender: TObject);
    procedure dlgOpenPreview(Sender: TFuturisOpenDialog; Ext: String);
    procedure dlgOpenFolderChange(Sender: TObject);
    procedure piMinimizeClick(Sender: TObject);
    procedure miInfoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure appHint(Sender: TObject);
    procedure appIdle(Sender: TObject; var Done: Boolean);
    procedure miZM6Click(Sender: TObject);
    procedure miFiltersDialogClick(Sender: TObject);
    procedure tbnPlayClick(Sender: TObject);
    procedure tbnPauseClick(Sender: TObject);
    procedure tbnStopClick(Sender: TObject);
    procedure tbnMultiFirstClick(Sender: TObject);
    procedure tbnMultiPrevClick(Sender: TObject);
    procedure tbnMultiNextClick(Sender: TObject);
    procedure tbnMultiLastClick(Sender: TObject);
    procedure tbnExtractPageClick(Sender: TObject);
    procedure tbnGoToPageClick(Sender: TObject);
    procedure miPrintPreviewClick(Sender: TObject);
    procedure miShowClick(Sender: TObject);
    procedure miStartSlideShowClick(Sender: TObject);
    procedure tbnLastClick(Sender: TObject);
    procedure miNewClick(Sender: TObject);
    procedure tbnPrintClick(Sender: TObject);
    procedure miFuturisWebSiteClick(Sender: TObject);
    procedure miFCopyClick(Sender: TObject);
    procedure miFDeleteClick(Sender: TObject);
    procedure miFMoveClick(Sender: TObject);
    procedure miFRenameClick(Sender: TObject);
    procedure miGoFirstClick(Sender: TObject);
    procedure miGoLastClick(Sender: TObject);
    procedure miGoRandomClick(Sender: TObject);
    procedure miUndoClick(Sender: TObject);
    procedure miZmFitClick(Sender: TObject);
    procedure miZmWidthClick(Sender: TObject);
    procedure miZmHeightClick(Sender: TObject);
    procedure miDSNormalClick(Sender: TObject);
    procedure miDSFitClick(Sender: TObject);
    procedure miDSCenterImageClick(Sender: TObject);
    procedure miDSScrollbarsClick(Sender: TObject);
    procedure tbnDispClick(Sender: TObject);
    procedure miHelpContentsClick(Sender: TObject);
    procedure popMRUPopup(Sender: TObject);
    procedure MRUpopClick(Sender: TObject; const FileName: String);
    procedure tbnRotateClick(Sender: TObject);
    procedure miRotateViewClick(Sender: TObject);
    procedure miRotateViewCCWClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

resourcestring
	rsSuppExtStatusYes = 'Supported';
	rsSuppExtStatusNo = 'Not supported';
	rsFileTypeUnknown = 'Unknown image type';
	rsNoSizeAvailable = 'No size information available';

var
	frmMain: TfrmMain;


implementation

uses w_about, w_custzoom, w_setup, w_info,
     globals, f_global, f_ui, f_clipboard, f_nav, f_images, f_plugins, f_tools,
     f_graphics, f_filectrl, f_frmman, f_anim, f_multi, w_show, f_reg;

{$R *.DFM}

// program start-up
procedure TfrmMain.Initialize();
begin
	// initializing randomizer
	Randomize();

	// setting image view
	frmMain.img.Blank();
	frmMain.img.Proc.UndoLimit := 32;
	frmMain.img.Proc.ClearAllUndo();
    frmMain.img.MouseWheelParams.Action := iemwVScroll;

	// XP tweak
	if (IsXP() and UseThemes()) then
  		begin
  		frmMain.tbrMain.EdgeBorders:= [];
        frmMain.sbxMain.BorderStyle := bsNone;
  		end;

	// setting app events
	Application.OnHint := appHint;
	Application.OnIdle := appIdle;

	// setting common variables
	files := TStringList.Create();

	// setting registry
	reg := TFuturisRegistry.Create();
	reg.RootKey := HKEY_CURRENT_USER;

	// main stuff
	DragAcceptFiles(frmMain.Handle, true);
	StartUpChecks();

	// setting toolbar
	tbnZoomMisc.WholeDropDown := true;

    // setting image view
    img.VScrollBarParams.LineStep := 10;
    img.HScrollBarParams.LineStep := 10;
    
	// more
	c_pos.RestoreWindowState(frmMain, reg, sReg + '\Position\Main', 25, 750, 25, 550, 2, 3);
	ReadSettings();
	CheckLibrariesDependancies();
	InstallPlugIns();

	// final
	Able(false);
	CommandLine();
end;

// program shut down
procedure TfrmMain.ShutDown();
begin
	// working
	c_pos.SaveWindowState(frmMain, reg, sReg + '\Position\Main');
	SaveSettings();

	// shutting down registry
	FreeAndNil(reg);
end;

// FIPISimport handler
procedure TfrmMain.HandleFIPISimport(Sender: TObject);
var
	FIPISimport: TFIPISimport;
	lib: THandle;
	func_result: hBitmap;
begin
	try
  		reg.OpenKey(sModules + '\Import', true);
  		lib := LoadLibrary(PChar(GetAppFolder() + reg.RStr(StripHotKey(TMenuItem(Sender).Caption), '')));
  		reg.CloseKey();

  		if (lib = 0) then
    		Report('Cannot load import DLL!', 2)
  		else
    		begin
    		@FIPISimport := GetProcAddress(lib, 'FIPISimport');

    		if not (@FIPISimport = nil) then
      			begin
      			func_result := FIPISimport(PChar(StripHotKey(TMenuItem(Sender).Caption)), Application.Handle, frmMain.Handle);
      			if (func_result <> 0) then
        			OpenUntitled(nil, func_result);
      			end;

    		FreeLibrary(lib);
    		end;
	finally
	end;
end;

// FIPISexport handler
procedure TfrmMain.HandleFIPISexport(Sender: TObject);
var
	FIPISexport: TFIPISexport;
	lib: THandle;
	img: TBitmap;
begin
	try
  		reg.OpenKey(sModules + '\Export', true);
  		lib := LoadLibrary(PChar(GetAppFolder() + reg.RStr(StripHotKey(TMenuItem(Sender).Caption), '')));
  		reg.CloseKey();

  		if (lib = 0) then
    		Report('Cannot load export DLL!', 2)
  		else
   			begin
    		img := TBitmap.Create();
    		img.Assign(frmMain.img.IEBitmap.VclBitmap);
    		img.PixelFormat := pf24bit;

    		@FIPISexport := GetProcAddress(lib, 'FIPISexport');

    		if not (@FIPISexport = nil) then
      			FIPISexport(PChar(StripHotKey(TMenuItem(Sender).Caption)), Application.Handle, frmMain.Handle, img.ReleaseHandle());

    		FreeLibrary(lib);
    		FreeAndNil(img);
    		end;
	finally
	end;
end;

// FIPISfilter handler
procedure TfrmMain.HandleFIPISfilter(Sender: TObject);
begin
	HandleFilter(StripHotKey(TMenuItem(Sender).Caption));
end;

// FIPIStool handler
procedure TfrmMain.HandleFIPIStool(Sender: TObject);
var
	FIPIStool: TFIPIStool;
	lib: THandle;
	func_result: hBitmap;
	img: TBitmap;
begin
	try
		reg.OpenKey(sModules + '\Tools', true);
		lib := LoadLibrary(PChar(GetAppFolder() + reg.RStr(StripHotKey(TMenuItem(Sender).Caption), '')));
		reg.CloseKey();

		if (lib = 0) then
  			Report('Cannot load tool DLL!', 2)
		else
  			begin
  			@FIPIStool := GetProcAddress(lib, 'FIPIStool');

  			if not (@FIPIStool = nil) then
    			begin
    			img := TBitmap.Create();
    			img.Assign(frmMain.img.IEBitmap.VclBitmap);
    			img.PixelFormat := pf24bit;

    			try
      				func_result := FIPIStool(PChar(StripHotKey(TMenuItem(Sender).Caption)), PChar(infImage.path), Application.Handle, frmMain.Handle, img.ReleaseHandle());
      				if (func_result <> 0) then
        				OpenUntitled(nil, func_result);
    			except
    			end;

    			FreeAndNil(img);
   				end;

  			FreeLibrary(lib);
  			end;
	finally
	end;
end;

// drag-n-drop support
procedure TfrmMain.DragNDrop(var msg: TWMDropFiles);
var
	fName: array[0..255] of char;
	i,n: integer;
begin
	n := DragQueryFile(msg.Drop, $FFFFFFFF, nil, 0);

	for i := 0 to (n - 1) do
  		begin
        if (i = 0) then
        	begin
    		DragQueryFile(msg.Drop, i, fName, 256);
    		Load(fName);
    		end;
  		end;

	DragFinish(msg.Drop);
end;

procedure TfrmMain.miAboutClick(Sender: TObject);
begin
	ShowAbout();
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
	Initialize();
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	ShutDown();
end;

procedure TfrmMain.miOpenClick(Sender: TObject);
begin
	OpenImage();
end;

procedure TfrmMain.miReopenClick(Sender: TObject);
begin
	Reopen();
end;

procedure TfrmMain.miCloseClick(Sender: TObject);
begin
	CloseImage();
end;

procedure TfrmMain.miSaveAsClick(Sender: TObject);
begin
	Save();
end;

procedure TfrmMain.miExitClick(Sender: TObject);
begin
	frmMain.Close();
end;

procedure TfrmMain.miCopyClick(Sender: TObject);
begin
	CBCopy();
end;

procedure TfrmMain.miPasteClick(Sender: TObject);
begin
	CBPaste();
end;

procedure TfrmMain.miFullScreenClick(Sender: TObject);
begin
	ToggleFS();
end;

procedure TfrmMain.miGoBackClick(Sender: TObject);
begin
	if (HiWord(GetKeyState(VK_SHIFT)) <> 0) then
  		GoFirst()
	else
  		GoPrev();
end;

procedure TfrmMain.miGoForwardClick(Sender: TObject);
begin
	if (HiWord(GetKeyState(VK_SHIFT)) <> 0) then
  		GoLast()
	else
  		GoNext();
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
	msg: TWMKey;
begin
	msg.CharCode := Key;

	if not mnuMain.IsShortCut(msg) then
  		begin
  		// keys manager
  		case Key of
    		VK_ADD:
            	ZoomIn();
    		VK_SUBTRACT:
            	ZoomOut();
            187:
            	ZoomIn();
            189:
            	ZoomOut();

			// directory navigation
			VK_INSERT:
				if (ssShift in Shift) then GoFirst() else GoPrev();
    		VK_HOME:
				if (ssShift in Shift) then GoLast() else GoNext();
			VK_PRIOR:
				if (ssShift in Shift) then GoFirst() else GoPrev();
			VK_NEXT:
				if (ssShift in Shift) then GoLast() else GoNext();
    		VK_SPACE:
            	if (ssShift in Shift) then GoLast() else GoNext();
    		VK_BACK:
            	if (ssShift in Shift) then GoFirst() else GoPrev();

            5:
            	GoPrev();  // VK_XBUTTON1
			6:
            	GoNext();  // VK_XBUTTON2

    		// slide show toolbar
    		VK_F3:
            	if (Assigned(frmShow)) then
                	frmShow.Visible := (not frmShow.Visible);

    		// fit/normal toggle
    		VK_RETURN:
                tbnDispClick(Self);

            // scrolling and paging
            VK_UP:
                if (ssShift in Shift) then
            		img.Perform(WM_VSCROLL, MakeWParam(SB_PAGEUP, 0), 0)
                else
                	img.Perform(WM_VSCROLL, MakeWParam(SB_LINEUP, 0), 0);
            VK_DOWN:
                if (ssShift in Shift) then
            		img.Perform(WM_VSCROLL, MakeWParam(SB_PAGEDOWN, 0), 0)
                else
                	img.Perform(WM_VSCROLL, MakeWParam(SB_LINEDOWN, 0), 0);
            VK_RIGHT:
                if (ssShift in Shift) then
            		img.Perform(WM_HSCROLL, MakeWParam(SB_PAGERIGHT, 0), 0)
                else
                	img.Perform(WM_HSCROLL, MakeWParam(SB_LINERIGHT, 0), 0);
            VK_LEFT:
                if (ssShift in Shift) then
            		img.Perform(WM_HSCROLL, MakeWParam(SB_PAGELEFT, 0), 0)
                else
                	img.Perform(WM_HSCROLL, MakeWParam(SB_LINELEFT, 0), 0);
    	end;
  		end;
end;

procedure TfrmMain.miPrintClick(Sender: TObject);
begin
	PrintImage(true);
end;

procedure TfrmMain.miZM12Click(Sender: TObject);
begin
	Zoom(12, true);
end;

procedure TfrmMain.miZM25Click(Sender: TObject);
begin
	Zoom(25, true);
end;

procedure TfrmMain.miZM50Click(Sender: TObject);
begin
	Zoom(50, true);
end;

procedure TfrmMain.miZM75Click(Sender: TObject);
begin
	Zoom(75, true);
end;

procedure TfrmMain.miZM100Click(Sender: TObject);
begin
	Zoom(100, true);
end;

procedure TfrmMain.miZM150Click(Sender: TObject);
begin
	Zoom(150, true);
end;

procedure TfrmMain.miZM200Click(Sender: TObject);
begin
	Zoom(200, true);
end;

procedure TfrmMain.miZM400Click(Sender: TObject);
begin
	Zoom(400, true);
end;

procedure TfrmMain.miZoomInClick(Sender: TObject);
begin
	ZoomIn();
end;

procedure TfrmMain.miZoomOutClick(Sender: TObject);
begin
	ZoomOut();
end;

procedure TfrmMain.miZMCustomClick(Sender: TObject);
begin
	CustomZoom();
end;

procedure TfrmMain.MRUClick(Sender: TObject; FileName: String);
begin
	if FileExists(FileName) then
    	Load(FileName);
end;

procedure TfrmMain.miSettingsClick(Sender: TObject);
begin
	ShowSettings();
end;

procedure TfrmMain.miToolbarClick(Sender: TObject);
begin
	ToggleMainToolbar();
end;

procedure TfrmMain.miStatusBarClick(Sender: TObject);
begin
	ToggleStatusBar();
end;

procedure TfrmMain.dlgOpenPreview(Sender: TFuturisOpenDialog; Ext: String);
var
	bmp: hBitmap;
	img, thumb: TBitmap;
    fast_io: TImageEnIO;
    use_thumb: boolean;
begin
    bmp := 0;
    use_thumb := false;

    // trying to get faster previews for JPEGs
    if ((Ext = 'jpg') or (Ext = 'jpeg') or (Ext = 'jfif')) then
    	begin
    	fast_io := TImageEnIO.Create(nil);
		fast_io.Params.Width:=100;
		fast_io.Params.Height:=100;
        fast_io.Params.JPEG_Scale:=ioJPEG_AUTOCALC;
        fast_io.LoadFromFileJpeg(Sender.FileName);

        if not fast_io.Aborting then
        	begin
          	thumb := TBitmap.Create();
            thumb.Assign(fast_io.IEBitmap.VclBitmap);

            bmp := thumb.ReleaseHandle();

            FreeAndNil(thumb);

            use_thumb := true;
            end;

        FreeAndNil(fast_io);
        end;

	// preview event for Adv.Open
    if (use_thumb = false) then
		bmp := DoImageLoad(Sender.FileName);

	if (bmp <> 0) then
  		begin
  		img := TBitmap.Create();
  		img.Handle := bmp;

  		// end counting best fit
        Sender.PreviewImage.Picture.Bitmap.Assign(img);
        Sender.PreviewImage.Visible := true;

  		// filling information
  		Sender.Size.Caption := 'Size: ' + IntToStr(img.Width) + ' x ' + IntToStr(img.Height);
  		FreeAndNil(img);
  		end
	else
  		begin
        Sender.PreviewImage.Visible := false;
  		Sender.Size.Caption := rsNoSizeAvailable;
  		end;

	// support info
	Sender.Name.Caption := 'File: ' + ExtractFileName(Sender.FileName);

	// getting file type
	Sender.FileType.Caption := ('Type: ' + GetTypeString(Ext, rsFileTypeUnknown));

	// is supported ?
	if SupportedExt(Ext) then
    	Sender.Support.Caption := rsSuppExtStatusYes
    else
    	Sender.Support.Caption := rsSuppExtStatusNo;
end;

procedure TfrmMain.dlgOpenFolderChange(Sender: TObject);
begin
	TFuturisOpenDialog(Sender).PreviewImage.Canvas.Brush.Color := clWhite;
	TFuturisOpenDialog(Sender).PreviewImage.Canvas.FillRect(TFuturisOpenDialog(Sender).PreviewImage.Canvas.ClipRect);
	TFuturisOpenDialog(Sender).Size.Caption := '';
	TFuturisOpenDialog(Sender).FileType.Caption := '';
	TFuturisOpenDialog(Sender).Support.Caption := '';
	TFuturisOpenDialog(Sender).Name.Caption := '';
end;

procedure TfrmMain.piMinimizeClick(Sender: TObject);
begin
	Application.Minimize();
end;

procedure TfrmMain.miInfoClick(Sender: TObject);
begin
	ShowInfo();
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
	FreeGlobals();
end;

procedure TfrmMain.appHint(Sender: TObject);
begin
	MirrorHint();
end;

procedure TfrmMain.appIdle(Sender: TObject; var Done: Boolean);
begin
	IdleUI();
end;

procedure TfrmMain.miZM6Click(Sender: TObject);
begin
	Zoom(6, true);
end;

procedure TfrmMain.miFiltersDialogClick(Sender: TObject);
begin
	ShowFilters();
end;

procedure TfrmMain.tbnPlayClick(Sender: TObject);
begin
	APlay();
end;

procedure TfrmMain.tbnPauseClick(Sender: TObject);
begin
	APause();
end;

procedure TfrmMain.tbnStopClick(Sender: TObject);
begin
	AStop();
end;

procedure TfrmMain.tbnMultiFirstClick(Sender: TObject);
begin
	MGoFirst();
end;

procedure TfrmMain.tbnMultiPrevClick(Sender: TObject);
begin
	MGoPrev();
end;

procedure TfrmMain.tbnMultiNextClick(Sender: TObject);
begin
	MGoNext();
end;

procedure TfrmMain.tbnMultiLastClick(Sender: TObject);
begin
	MGoLast();
end;

procedure TfrmMain.tbnExtractPageClick(Sender: TObject);
begin
	MExtract();
end;

procedure TfrmMain.tbnGoToPageClick(Sender: TObject);
begin
	MPage();
end;

procedure TfrmMain.miPrintPreviewClick(Sender: TObject);
begin
	PrintImage(false);
end;

procedure TfrmMain.miShowClick(Sender: TObject);
begin
	ShowShow();
end;

procedure TfrmMain.miStartSlideShowClick(Sender: TObject);
begin
	ShowShow();

	if Assigned(frmShow) then
    	frmShow.btnStart.Click();
end;

procedure TfrmMain.tbnLastClick(Sender: TObject);
begin
	if (infImage.path <> '') then
  		begin
  		if (MRU.Files.Count >= 2) then
    		Load(MRU.Files[1]);
  		end
	else
  		begin
  		if (MRU.Files.Count >= 1) then
    		Load(MRU.Files[0]);
  		end;
end;

procedure TfrmMain.miNewClick(Sender: TObject);
begin
	ShowNew();
end;

procedure TfrmMain.tbnPrintClick(Sender: TObject);
begin
	if (HiWord(GetKeyState(VK_SHIFT)) <> 0) then
    	PrintImage(true)
    else
    	PrintImage();
end;

procedure TfrmMain.miFuturisWebSiteClick(Sender: TObject);
begin
	ExecInFolder('manual\website.html');
end;

procedure TfrmMain.miFCopyClick(Sender: TObject);
begin
	FCopy();
end;

procedure TfrmMain.miFDeleteClick(Sender: TObject);
begin
	FDelete();
end;

procedure TfrmMain.miFMoveClick(Sender: TObject);
begin
	FMove();
end;

procedure TfrmMain.miFRenameClick(Sender: TObject);
begin
	FRename();
end;

procedure TfrmMain.miGoFirstClick(Sender: TObject);
begin
	GoFirst();
end;

procedure TfrmMain.miGoLastClick(Sender: TObject);
begin
	GoLast();
end;

procedure TfrmMain.miGoRandomClick(Sender: TObject);
begin
	GoRandom();
end;

procedure TfrmMain.miUndoClick(Sender: TObject);
begin
	frmMain.img.Proc.Undo();
    frmMain.img.Proc.ClearUndo();
end;

procedure TfrmMain.miZmFitClick(Sender: TObject);
begin
    SetDisplayStyle(dsNormal, true);
	frmMain.img.Fit();
end;

procedure TfrmMain.miZmWidthClick(Sender: TObject);
begin
    SetDisplayStyle(dsNormal, true);
	frmMain.img.FitToWidth();
end;

procedure TfrmMain.miZmHeightClick(Sender: TObject);
begin
    SetDisplayStyle(dsNormal, true);
	frmMain.img.FitToHeight();
end;

procedure TfrmMain.miDSNormalClick(Sender: TObject);
begin
    SetDisplayStyle(dsNormal);
end;

procedure TfrmMain.miDSFitClick(Sender: TObject);
begin
    SetDisplayStyle(dsFit);
end;

procedure TfrmMain.miDSCenterImageClick(Sender: TObject);
begin
    SetCenter(not GetCenter());
end;

procedure TfrmMain.miDSScrollbarsClick(Sender: TObject);
begin
    SetScrollbars(not GetScrollbars());
end;

procedure TfrmMain.tbnDispClick(Sender: TObject);
begin
	if (GetDisplayStyle() = dsFit) then
    	SetDisplayStyle(dsNormal)
    else
        SetDisplayStyle(dsFit);
end;

procedure TfrmMain.miHelpContentsClick(Sender: TObject);
begin
    ExecInFolder('manual\index.html');
end;

procedure TfrmMain.popMRUPopup(Sender: TObject);
begin
	// gettings MRU list
	MRUpop.Files.Clear();
	MRUpop.Files.AddStrings(MRU.Files);
end;

procedure TfrmMain.MRUpopClick(Sender: TObject; const FileName: String);
begin
	if FileExists(FileName) then
    	Load(FileName);
end;

procedure TfrmMain.tbnRotateClick(Sender: TObject);
begin
	if (HiWord(GetKeyState(VK_SHIFT)) <> 0) then
		img.Proc.Rotate(90, false)
    else
		img.Proc.Rotate(270, false);
end;

procedure TfrmMain.miRotateViewClick(Sender: TObject);
begin
	if tbnRotate.Enabled then
		img.Proc.Rotate(270, false);
end;

procedure TfrmMain.miRotateViewCCWClick(Sender: TObject);
begin
	if tbnRotate.Enabled then
		img.Proc.Rotate(90, false);
end;

end.
