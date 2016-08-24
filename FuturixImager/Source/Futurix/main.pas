unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ToolWin, ImgList, ExtCtrls, ShellAPI, ShlObj, ClipBrd,
  Printers, AppEvnts, Registry, UxTheme,
  c_const, c_wndpos, c_reg, c_utils, c_locales, c_themes,
  ieview, imageenview, hyieutils, ImageEnIO, hyiedefs,
  fx_consts, fx_mru, c_tb, f_instance;

type
  TImageTypes = (itNone, itUnsaved, itNormal, itMulti, itAnimated);
  TDisplayStyles = (dsNormal, dsFitBig, dsFitAll);

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
    mImport: TMenuItem;
    mExport: TMenuItem;
    miExit: TMenuItem;
    miCopy: TMenuItem;
    miPaste: TMenuItem;
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
    miOptions: TMenuItem;
    miAbout: TMenuItem;
    imlStd: TImageList;
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
    tbnZoomMisc: TToolButton;
    piTBMain: TMenuItem;
    tbnSave: TToolButton;
    tbnClose: TToolButton;
    tbnPrint: TToolButton;
    tbnCopy: TToolButton;
    tbnPaste: TToolButton;
    tbnFullScreen: TToolButton;
    tbnInfo: TToolButton;
    tbnGoBack: TToolButton;
    tbnGoForward: TToolButton;
    piStatusBar: TMenuItem;
    mRecent: TMenuItem;
    NRecent: TMenuItem;
    N2: TMenuItem;
    mToolbars: TMenuItem;
    N11: TMenuItem;
    tbnEditor: TToolButton;
    miEditor: TMenuItem;
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
    miPrintPreview: TMenuItem;
    N29: TMenuItem;
    miShow: TMenuItem;
    miStartShow: TMenuItem;
    tbnLast: TToolButton;
    piZM75: TMenuItem;
    piZM150: TMenuItem;
    miZM75: TMenuItem;
    miZM150: TMenuItem;
    sbrMain: TStatusBar;
    miWebSite: TMenuItem;
    N16: TMenuItem;
    miFDelete: TMenuItem;
    miFCopy: TMenuItem;
    miFRename: TMenuItem;
    miFMove: TMenuItem;
    N34: TMenuItem;
    N13: TMenuItem;
    N20: TMenuItem;
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
    miUndo: TMenuItem;
    img: TImageEnView;
    N8: TMenuItem;
    miZmFit: TMenuItem;
    miZmWidth: TMenuItem;
    miZmHeight: TMenuItem;
    N9: TMenuItem;
    piZmFit: TMenuItem;
    piZmWidth: TMenuItem;
    piZmHeight: TMenuItem;
    mDisplay: TMenuItem;
    miDSNormal: TMenuItem;
    miDSFitBig: TMenuItem;
    N18: TMenuItem;
    miDSCenterImage: TMenuItem;
    miDSScrollbars: TMenuItem;
    N21: TMenuItem;
    popDisp: TPopupMenu;
    tbnDisp: TToolButton;
    tbnMultiPrev: TToolButton;
    tbnMultiNext: TToolButton;
    piDSNormal: TMenuItem;
    piDSFitBig: TMenuItem;
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
    popMRU: TPopupMenu;
    piMRU: TMenuItem;
    N3: TMenuItem;
    tbnRotate: TToolButton;
    miRotateView: TMenuItem;
    miRotateViewCCW: TMenuItem;
    popNoMRU: TPopupMenu;
    piMyOpen: TMenuItem;
    appEvents: TApplicationEvents;
    mFileMan: TMenuItem;
    N6: TMenuItem;
    N19: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    piRotateView: TMenuItem;
    piRotateViewCCW: TMenuItem;
    miDSFitAll: TMenuItem;
    piDSFitAll: TMenuItem;
    N5: TMenuItem;
    miCustTB: TMenuItem;
    N30: TMenuItem;
    piCustTB: TMenuItem;
    tbnUndo: TToolButton;
    tbnGoRandom: TToolButton;
    tbnZoomFit: TToolButton;
    miLoadLast: TMenuItem;
    tbnShow: TToolButton;
    tbnRScan: TToolButton;
    tbnRMail: TToolButton;
    tbnRCapture: TToolButton;
    tbnRJPEG: TToolButton;
    tbnGoToPage: TToolButton;
    tbnFDelete: TToolButton;
    tbnFCopy: TToolButton;
    tbnFMove: TToolButton;
    tbnFRename: TToolButton;
    tbnZoom100: TToolButton;
    tbnZoomWidth: TToolButton;
    tbnZoomHeight: TToolButton;
    tbnRotateCCW: TToolButton;
    tbnGoFirst: TToolButton;
    tbnGoLast: TToolButton;
    tbnOptions: TToolButton;
    tbnHelp: TToolButton;
    tbnOnline: TToolButton;
    tbnAbout: TToolButton;
    imlFixed: TImageList;
    dlgOpen: TOpenDialog;
    pRecent: TMenuItem;
    N31: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure HandleFImport(Sender: TObject);
    procedure DoHandleFImport(lib_path, name: string);
    procedure HandleFExport(Sender: TObject);
    procedure DoHandleFExport(lib_path, name: string);
    procedure HandleFTool(Sender: TObject);
    procedure DoHandleFTool(lib_path, name: string);
    procedure DragNDrop(var msg: TWMDropFiles); message WM_DROPFILES;
    procedure miAboutClick(Sender: TObject);
    procedure miOpenClick(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure miSaveAsClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure miCopyClick(Sender: TObject);
    procedure miPasteClick(Sender: TObject);
    procedure miFullScreenClick(Sender: TObject);
    procedure miGoBackClick(Sender: TObject);
    procedure miGoForwardClick(Sender: TObject);
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
    procedure mruClick(Sender: TObject);
    procedure miOptionsClick(Sender: TObject);
    procedure miToolbarClick(Sender: TObject);
    procedure miStatusBarClick(Sender: TObject);
    procedure piMinimizeClick(Sender: TObject);
    procedure miInfoClick(Sender: TObject);
    procedure miZM6Click(Sender: TObject);
    procedure miEditorClick(Sender: TObject);
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
    procedure miStartShowClick(Sender: TObject);
    procedure miWebSiteClick(Sender: TObject);
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
    procedure miDSFitBigClick(Sender: TObject);
    procedure miDSCenterImageClick(Sender: TObject);
    procedure miDSScrollbarsClick(Sender: TObject);
    procedure tbnDispClick(Sender: TObject);
    procedure MRUpopClick(Sender: TObject; const FileName: String);
    procedure tbnRotateClick(Sender: TObject);
    procedure miRotateViewClick(Sender: TObject);
    procedure miRotateViewCCWClick(Sender: TObject);
    procedure appEventsHint(Sender: TObject);
    procedure appEventsIdle(Sender: TObject; var Done: Boolean);
    procedure miDSFitAllClick(Sender: TObject);
    procedure SetHintPanelText(new_text: string);
    procedure imgProgress(Sender: TObject; per: Integer);
    procedure dlgSaveTypeChange(Sender: TObject);
    procedure imgDblClick(Sender: TObject);
    procedure imgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure imgMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure miCustTBClick(Sender: TObject);
    procedure miLoadLastClick(Sender: TObject);
    procedure tbnRCaptureClick(Sender: TObject);
    procedure tbnRJPEGClick(Sender: TObject);
    procedure tbnRMailClick(Sender: TObject);
    procedure tbnRScanClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
  private
    prev_progress: integer;

    procedure UMAppIDCheck(var Message: TMessage); message UM_APP_ID_CHECK;
    procedure UMRestoreApplication(var Message: TMessage); message UM_RESTORE_APPLICATION;
    procedure UMPreviousInstParams(var Message: TMessage); message UM_PREVIOUS_INST_PARAMS;
    procedure HandleXButtons(var msg: TMessage); message WM_XBUTTONDOWN;
  public
    mru: FuturixMRU;

    bOpenAfterSave: boolean;
    bFullPathInTitle: boolean;
    bOpenDef: boolean;
    bNoMRU: boolean;
    bProgressiveLoad: boolean;
    bFSonDblClick: boolean;
    nArrows: integer;
    nEnter: integer;
    nMouseDrag: integer;
    nMouseWheel: integer;
    bReverseWheel: boolean;
    nNewBitmap: integer;

    SaveExtensions: TStringList;

    dir: string;
    full_screen: boolean;

    procedure Localize();
    procedure UpdateThemes();
    procedure NoticeThemeChange(var msg: TMessage); message WM_THEMECHANGED;
  end;

var
  frmMain: TfrmMain;
  starting: boolean = true;
  init_raw: boolean = false;
  init_magick: boolean = false;
  init_jbig: boolean = false;
  files: TStringList;
  path_app: string = '';

  fx: record
    ColorDefault: TColor;
    ColorFullScreen: TColor;
    ColorGradient: TColor;

    BackgroundStyle: integer;
  end;

  infImage: record
    path: string;
    image_type: TImageTypes;
    filenum: integer;
  end;

  infMulti: record
    lib: THandle;
    pages, page: integer;

    FxImgMultiStart: TFxImgMultiStart;
    FxImgMultiGetPage: TFxImgMultiGetPage;
    FxImgMultiStop: TFxImgMultiStop;
  end;

  infAnim: record
    lib: THandle;

    FxImgAnimStart: TFxImgAnimStart;
    FxImgAnimRestart: TFxImgAnimRestart;
    FxImgAnimGetFrame: TFxImgAnimGetFrame;
    FxImgAnimStop: TFxImgAnimStop;
  end;

  infRoles: record
    capture, scan, email, jpegll: boolean;
  end;

function FxImgGlobalCallback(query_type, value, xtra: longword): TFxImgResult; cdecl;
procedure FillImage(path: string; image_type: TImageTypes);
procedure FillBitmap(bmp: TBitmap; img: hBitmap = 0);


implementation

uses
  w_about, w_custzoom, w_info, f_ui, f_nav, f_images, f_plugins, f_tools, f_graphics,
  f_filectrl, f_anim, f_multi, w_show, w_editor, f_scan, w_optgeneral,
  f_toolbar, w_custtb, w_preview;

{$R *.DFM}

function FxImgGlobalCallback(query_type, value, xtra: longword): TFxImgResult;
begin
  case query_type of
    CQ_GETLANGLIBS:
      begin
      Result.result_type := RT_HANDLE;
      Result.result_value := locale_lib;
      Result.result_xtra := backup_lib;
      end;
    else
      begin
      Result.result_type := RT_BOOL;
      Result.result_value := FX_FALSE;
      end;
  end;
end;

procedure FillImage(path: string; image_type: TImageTypes);
begin
  infImage.path := path;
  infImage.image_type := image_type;

  Header();
end;

procedure FillBitmap(bmp: TBitmap; img: hBitmap = 0);
var
  bim: TBitmap;
begin
  if (img = 0) then
    begin
    bmp.PixelFormat := DiscoverImage(bmp.Handle);

    frmMain.img.IEBitmap.Assign(bmp);
    if (frmMain.img.IEBitmap.PixelFormat = ie32RGB) then
      frmMain.img.IEBitmap.SynchronizeRGBA(true);
    end
  else
    begin
    bim := TBitmap.Create();
    bim.Handle := img;
    bim.PixelFormat := DiscoverImage(bim.Handle);

    frmMain.img.IEBitmap.Assign(bim);
    if (frmMain.img.IEBitmap.PixelFormat = ie32RGB) then
      frmMain.img.IEBitmap.SynchronizeRGBA(true);

    FreeAndNil(bim);
    end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  wreg: TFRegistry;
begin
  wreg := TFRegistry.Create(RA_READONLY);
  wreg.RootKey := HKEY_CURRENT_USER;

  // setting common variables
  files := TStringList.Create();
  SaveExtensions := TStringList.Create();
  infRoles.capture := false;
  infRoles.scan := false;
  infRoles.email := false;
  infRoles.jpegll := false;

  // initializing randomizer
  Randomize();

  // localization and themes
  InitLocalization(HInstance);
  LoadTheme(HInstance);
    
  // setting folder variables
  path_app := Slash(ExtractFilePath(Application.ExeName));

  // setting image view
  img.Blank();
  img.Proc.UndoLimit := 32;
  img.Proc.ClearAllUndo();
  img.MouseWheelParams.Action := iemwNone;
  prev_progress := 0;

  // localization
  Localize();

  // XP GUI updates
  UpdateThemes();

  DragAcceptFiles(frmMain.Handle, true);

  // plug-ins check
  if not wreg.KeyExists(sModules) then
    DoPluginScan();

  // writing paths
  PutRegDock();

  // setting toolbar and main menu
  tbnZoomMisc.WholeDropDown := true;
  mnuMain.Images := imlFixed;

  // setting image view
  img.VScrollBarParams.LineStep := 10;
  img.HScrollBarParams.LineStep := 10;

  RestoreWindowState(@frmMain, sSettings + '\Wnd', 25, 750, 25, 550, WPF_RESTORETOMAXIMIZED, SW_MAXIMIZE, 'Main_');
    
  // history
  mru := FuturixMRU.Create();
  mru.AddConnection(mRecent, false);
  mru.AddConnection(pRecent, false);
  mru.AddConnection(popMRU, true);

  // reading settings
  if wreg.OpenKey(sSettings, false) then
    begin
    fx.ColorDefault := StringToColor(wreg.RStr('Color', 'clAppWorkSpace'));
    fx.ColorFullScreen := StringToColor(wreg.RStr('FSColor', 'clBlack'));
    fx.ColorGradient := StringToColor(wreg.RStr('Gradient', 'clSilver'));
    fx.BackgroundStyle := wreg.RInt('BgStyle', 0);

    frmMain.bOpenAfterSave := (wreg.RInt('OpenAfterSave', 1) = 1);
    frmMain.bOpenDef := (wreg.RInt('OpenDef', 1) = 1);
    frmMain.bNoMRU := wreg.RBool('NoMRU', false);

    nArrows := wreg.RInt('ArrowKeys', 0);
    nEnter := wreg.RInt('EnterKey', 0);
    nMouseWheel := wreg.RInt('MouseWheel', 1);
    nMouseDrag := wreg.RInt('MouseDrag', 0);
    nNewBitmap := wreg.RInt('OnNewBitmap', 0);
    bProgressiveLoad := wreg.RBool('ProgressiveImageLoad', false);
    bFSonDblClick := wreg.RBool('FSonDblClick', true);
    img.DelayZoomFilter := wreg.RBool('DelayZoomFilter', false);
    bReverseWheel := wreg.RBool('ReverseMouseWheel', false);

    iegEnableCMS := wreg.RBool('UseCMS', false);

    miDSFitAll.Visible := wreg.RBool('EnableFitAll', false);
    piDSFitAll.Visible := miDSFitAll.Visible;

    if wreg.RBool('HighQualityDisplay', true) then
      begin
      case wreg.RInt('Resampler', 0) of
        0: img.ZoomFilter := rfFastLinear;
        1: img.ZoomFilter := rfLinear;
        2: img.ZoomFilter := rfTriangle;
        3: img.ZoomFilter := rfBicubic;
        4: img.ZoomFilter := rfBilinear;
        5: img.ZoomFilter := rfNearest;
        6: img.ZoomFilter := rfBSpline;
        7: img.ZoomFilter := rfMitchell;
        8: img.ZoomFilter := rfBell;
        9: img.ZoomFilter := rfHermite;
        10: img.ZoomFilter := rfLanczos3;
        11: img.ZoomFilter := rfProjectWB;
        12: img.ZoomFilter := rfProjectBW;
        else
          img.ZoomFilter := rfFastLinear;
      end;
      end
    else
      img.ZoomFilter := rfNone;

    if wreg.RInt('TBMain', 1) = 1 then ToggleMainToolbar(true, true)
      else ToggleMainToolbar(true, false);
    if wreg.RInt('TBStatus', 1) = 1 then ToggleStatusbar(true, true)
      else ToggleStatusbar(true, false);

    case wreg.RInt('DispStyle', 1) of
      0: SetDisplayStyle(dsNormal);
      1: SetDisplayStyle(dsFitBig);
      2: SetDisplayStyle(dsFitAll);
      else
        SetDisplayStyle(dsNormal);
    end;

    SetCenter(wreg.RBool('DispCenter', true));
    SetScrollbars(wreg.RBool('Scrollbars', true));

    frmMain.bFullPathInTitle := (wreg.RInt('FullPathInTitle', 0) = 1);

    wreg.CloseKey();
    end
  else
    begin
    fx.ColorDefault := clAppWorkSpace;
    fx.ColorFullScreen := clBlack;
    fx.ColorGradient := clSilver;
    fx.BackgroundStyle := 0;

    frmMain.bOpenAfterSave := true;
    frmMain.bOpenDef := true;
    frmMain.bNoMRU := false;

    nArrows := 0;
    nEnter := 0;
    nMouseWheel := 1;
    nMouseDrag := 0;
    nNewBitmap := 0;
    bProgressiveLoad := false;
    bFSonDblClick := true;
    img.DelayZoomFilter := false;
    bReverseWheel := false;

    iegEnableCMS := false;

    miDSFitAll.Visible := false;
    piDSFitAll.Visible := miDSFitAll.Visible;

    img.ZoomFilter := rfFastLinear;

    ToggleMainToolbar(true, true);
    ToggleStatusbar(true, true);

    SetDisplayStyle(dsFitBig);
    SetCenter(true);
    SetScrollbars(true);

    frmMain.bFullPathInTitle := false;
    end;

  ApplyBackground();
  ApplyCustomToolbar();
  ApplyTheme();

  // installing plug-ins
  InstallPlugIns();

  // final
  Able();
  CommandLine();

  FreeAndNil(wreg);
    
  starting := false;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  wreg: TFRegistry;
begin
  wreg := TFRegistry.Create(RA_FULL);
  wreg.RootKey := HKEY_CURRENT_USER;

  // working
  SaveWindowState(@frmMain, sSettings + '\Wnd', 'Main_');

  // saving settings
  if wreg.OpenKey(sSettings, true) then
    begin
    if ((not frmMain.full_screen) and (not Assigned(frmEditor)) and (not Assigned(frmPrint))) then
      begin
      if frmMain.tbrMain.Visible then wreg.WInteger('TBMain', 1)
        else wreg.WInteger('TBMain', 0);
      if frmMain.sbrMain.Visible then wreg.WInteger('TBStatus', 1)
        else wreg.WInteger('TBStatus', 0);
      end;

    case GetDisplayStyle() of
      dsNormal: wreg.WInteger('DispStyle', 0);
      dsFitBig: wreg.WInteger('DispStyle', 1);
      dsFitAll: wreg.WInteger('DispStyle', 2);
    end;

    wreg.WBool('DispCenter', GetCenter());
    wreg.WBool('Scrollbars', GetScrollbars());

    wreg.CloseKey();
    end;

  if not frmMain.bNoMRU then
    frmMain.mru.Save();

  if Assigned(frmShow) then
    frmShow.Close();

  FreeAndNil(wreg);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  CleanLocalization();
  FreeAndNil(files);
  FreeAndNil(mru);
  FreeAndNil(SaveExtensions);
end;

procedure TfrmMain.HandleFImport(Sender: TObject);
var
  lib_path, name: string;
begin
  name := StripHotKey(TMenuItem(Sender).Caption);
  lib_path := FxRegRStr(name, '', sModules + '\' + PS_FIMPORT);

  DoHandleFImport(lib_path, name);
end;

procedure TfrmMain.DoHandleFImport(lib_path, name: string);
var
  FxImgImport: TFxImgImport;
  lib: THandle;
  func_result: HBITMAP;
  tmp_res: TFxImgResult;
begin
  try
    lib := LoadLibrary(PWideChar(lib_path));

    if (lib = 0) then
      ShowMessage(LoadLStr(601))
    else
      begin
      @FxImgImport := GetProcAddress(lib, EX_IMPORT);

      if (@FxImgImport <> nil) then
        begin
        tmp_res := FxImgImport(PWideChar(name), Application.Handle, frmMain.Handle, FxImgGlobalCallback);

        if (tmp_res.result_type = RT_HBITMAP) then
          func_result := tmp_res.result_value
        else
          func_result := 0;

        if (func_result <> 0) then
          OpenUntitled(nil, func_result);
        end;

      FreeLibrary(lib);
      end;
  finally
  end;
end;

procedure TfrmMain.HandleFExport(Sender: TObject);
var
  lib_path, name: string;
begin
  name := StripHotKey(TMenuItem(Sender).Caption);
  lib_path := FxRegRStr(name, '', sModules + '\' + PS_FEXPORT);

  DoHandleFExport(lib_path, name);
end;

procedure TfrmMain.DoHandleFExport(lib_path, name: string);
var
  FxImgExport: TFxImgExport;
  lib: THandle;
  img: TBitmap;
begin
  try
    lib := LoadLibrary(PWideChar(lib_path));

    if (lib = 0) then
      ShowMessage(LoadLStr(602))
    else
      begin
      img := TBitmap.Create();
      img.Assign(frmMain.img.IEBitmap.VclBitmap);
      img.PixelFormat := pf24bit;

      @FxImgExport := GetProcAddress(lib, EX_EXPORT);

      if (@FxImgExport <> nil) then
        FxImgExport(PWideChar(name), img.ReleaseHandle(), Application.Handle, frmMain.Handle, FxImgGlobalCallback);

      FreeLibrary(lib);
      FreeAndNil(img);
      end;
  finally
  end;
end;

// FTool handler
procedure TfrmMain.HandleFTool(Sender: TObject);
var
  lib_path, name: string;
begin
  name := StripHotKey(TMenuItem(Sender).Caption);
  lib_path := FxRegRStr(name, '', sModules + '\' + PS_FTOOL);

  DoHandleFTool(lib_path, name);
end;

procedure TfrmMain.DoHandleFTool(lib_path, name: string);
var
  FxImgTool: TFxImgTool;
  lib: THandle;
  img: TBitmap;
  tmp_res: TFxImgResult;
begin
  try
    lib := LoadLibrary(PWideChar(lib_path));

    if (lib = 0) then
      ShowMessage(LoadLStr(603))
    else
      begin
      @FxImgTool := GetProcAddress(lib, EX_SIMPLETOOL);

      if (@FxImgTool <> nil) then
        begin
        img := TBitmap.Create();
        img.Assign(frmMain.img.IEBitmap.VclBitmap);
        img.PixelFormat := pf24bit;

        try
          tmp_res := FxImgTool(PWideChar(infImage.path), PWideChar(name), img.ReleaseHandle(), Application.Handle, frmMain.Handle, FxImgGlobalCallback);

          if (tmp_res.result_type = RT_HBITMAP) then
            OpenUntitled(nil, tmp_res.result_value)
          else if ((tmp_res.result_type = RT_INT) and (tmp_res.result_value = 1)) then
            OpenLocal(tmp_res.result_string_data);
        except
        end;

        FreeAndNil(img);
        end;

      FreeLibrary(lib);
      end;
  finally
  end;
end;

procedure TfrmMain.DragNDrop(var msg: TWMDropFiles);
var
  fName: array[0..255] of WideChar;
  i, n: integer;
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
  if not Assigned(frmAbout) then
    begin
    Application.CreateForm(TfrmAbout, frmAbout);
    frmAbout.ShowModal();
    end;
end;

procedure TfrmMain.Localize();
begin
  mFile.Caption       := LoadLStr(100);
  mEdit.Caption       := LoadLStr(101);
  mView.Caption       := LoadLStr(104);
  mTools.Caption      := LoadLStr(108);
  mHelp.Caption       := LoadLStr(110);

  miOpen.Caption          := LoadLStr(120);
  miOpen.Hint             := LoadLStr(121);
  mRecent.Caption         := LoadLStr(122);
  miLoadLast.Caption      := LoadLStr(156);
  miLoadLast.Hint         := LoadLStr(157);
  miSaveAs.Caption        := LoadLStr(128);
  miSaveAs.Hint           := LoadLStr(129);
  miClose.Caption         := LoadLStr(130);
  miClose.Hint            := LoadLStr(131);
  mImport.Caption         := LoadLStr(132);
  mExport.Caption         := LoadLStr(134);
  miInfo.Caption          := LoadLStr(136);
  miInfo.Hint             := LoadLStr(137);
  mFileMan.Caption        := LoadLStr(138);
  miFDelete.Caption       := LoadLStr(140);
  miFDelete.Hint          := LoadLStr(141);
  miFCopy.Caption         := LoadLStr(142);
  miFCopy.Hint            := LoadLStr(143);
  miFMove.Caption         := LoadLStr(144);
  miFMove.Hint            := LoadLStr(145);
  miFRename.Caption       := LoadLStr(146);
  miFRename.Hint          := LoadLStr(147);
  miPrintPreview.Caption  := LoadLStr(152);
  miPrintPreview.Hint     := LoadLStr(153);
  miExit.Caption          := LoadLStr(154);
  miExit.Hint             := Format(LoadLStr(155), [sAppName]);

  piOpen.Caption      := miOpen.Caption;
  piOpen.Hint         := miOpen.Hint;
  pRecent.Caption     := LoadLStr(122);
  piClose.Caption     := miClose.Caption;
  piClose.Hint        := miClose.Hint;

  piMyOpen.Caption    := miOpen.Caption;
  piMyOpen.Hint       := miOpen.Hint;

  miUndo.Caption      := LoadLStr(170);
  miUndo.Hint         := LoadLStr(171);
  miCopy.Caption      := LoadLStr(172);
  miCopy.Hint         := LoadLStr(173);
  miPaste.Caption     := LoadLStr(174);
  miPaste.Hint        := LoadLStr(175);
  miEditor.Caption    := LoadLStr(176);
  miEditor.Hint       := LoadLStr(177);

  mToolbars.Caption     := LoadLStr(190);
  miToolbar.Caption     := LoadLStr(192);
  miToolbar.Hint        := LoadLStr(193);
  miStatusBar.Caption   := LoadLStr(194);
  miStatusBar.Hint      := LoadLStr(195);

  piTBMain.Caption      := miToolbar.Caption;
  piTBMain.Hint         := miToolbar.Hint;
  piStatusBar.Caption   := miStatusBar.Caption;
  piStatusBar.Hint      := miStatusBar.Hint;

  mDisplay.Caption      := LoadLStr(210);
  miDSNormal.Caption    := LoadLStr(212);
  miDSNormal.Hint       := LoadLStr(213);
  miDSFitBig.Caption    := LoadLStr(214);
  miDSFitBig.Hint       := LoadLStr(215);
  miDSFitAll.Caption    := LoadLStr(216);
  miDSFitAll.Hint       := LoadLStr(217);

  miDSCenterImage.Caption   := LoadLStr(220);
  miDSCenterImage.Hint      := LoadLStr(221);
  miDSScrollbars.Caption    := LoadLStr(222);
  miDSScrollbars.Hint       := LoadLStr(223);

  piDSNormal.Caption        := miDSNormal.Caption;
  piDSNormal.Hint           := miDSNormal.Hint;
  piDSFitBig.Caption        := miDSFitBig.Caption;
  piDSFitBig.Hint           := miDSFitBig.Hint;
  piDSFitAll.Caption        := miDSFitAll.Caption;
  piDSFitAll.Hint           := miDSFitAll.Hint;
  piDSCenterImage.Caption   := miDSCenterImage.Caption;
  piDSCenterImage.Hint      := miDSCenterImage.Hint;
  piDSScrollbars.Caption    := miDSScrollbars.Caption;
  piDSScrollbars.Hint       := miDSScrollbars.Hint;

  mZoom.Caption       := LoadLStr(230);
  miZoomIn.Caption    := LoadLStr(232);
  miZoomIn.Hint       := LoadLStr(233);
  miZoomOut.Caption   := LoadLStr(234);
  miZoomOut.Hint      := LoadLStr(235);
  miZM6.Caption       := LoadLStr(236);
  miZM6.Hint          := LoadLStr(237);
  miZM12.Caption      := LoadLStr(238);
  miZM12.Hint         := LoadLStr(239);
  miZM25.Caption      := LoadLStr(240);
  miZM25.Hint         := LoadLStr(241);
  miZM50.Caption      := LoadLStr(242);
  miZM50.Hint         := LoadLStr(243);
  miZM75.Caption      := LoadLStr(244);
  miZM75.Hint         := LoadLStr(245);
  miZM100.Caption     := LoadLStr(246);
  miZM100.Hint        := LoadLStr(247);
  miZM150.Caption     := LoadLStr(248);
  miZM150.Hint        := LoadLStr(249);
  miZM200.Caption     := LoadLStr(250);
  miZM200.Hint        := LoadLStr(251);
  miZM400.Caption     := LoadLStr(252);
  miZM400.Hint        := LoadLStr(253);

  piZM6.Caption       := miZM6.Caption;
  piZM6.Hint          := miZM6.Hint;
  piZM12.Caption      := miZM12.Caption;
  piZM12.Hint         := miZM12.Hint;
  piZM25.Caption      := miZM25.Caption;
  piZM25.Hint         := miZM25.Hint;
  piZM50.Caption      := miZM50.Caption;
  piZM50.Hint         := miZM50.Hint;
  piZM75.Caption      := miZM75.Caption;
  piZM75.Hint         := miZM75.Hint;
  piZM100.Caption     := miZM100.Caption;
  piZM100.Hint        := miZM100.Hint;
  piZM150.Caption     := miZM150.Caption;
  piZM150.Hint        := miZM150.Hint;
  piZM200.Caption     := miZM200.Caption;
  piZM200.Hint        := miZM200.Hint;
  piZM400.Caption     := miZM400.Caption;
  piZM400.Hint        := miZM400.Hint;

  miZmFit.Caption     := LoadLStr(260);
  miZmFit.Hint        := LoadLStr(261);
  miZmWidth.Caption   := LoadLStr(262);
  miZmWidth.Hint      := LoadLStr(263);
  miZmHeight.Caption  := LoadLStr(264);
  miZmHeight.Hint     := LoadLStr(265);

  piZmFit.Caption     := miZmFit.Caption;
  piZmFit.Hint        := miZmFit.Hint;
  piZmWidth.Caption   := miZmWidth.Caption;
  piZmWidth.Hint      := miZmWidth.Hint;
  piZmHeight.Caption  := miZmHeight.Caption;
  piZmHeight.Hint     := miZmHeight.Hint;

  miRotateView.Caption      := LoadLStr(270);
  miRotateView.Hint         := LoadLStr(271);
  miRotateViewCCW.Caption   := LoadLStr(272);
  miRotateViewCCW.Hint      := LoadLStr(273);

  piRotateView.Caption      := miRotateView.Caption;
  piRotateView.Hint         := miRotateView.Hint;
  piRotateViewCCW.Caption   := miRotateViewCCW.Caption;
  piRotateViewCCW.Hint      := miRotateViewCCW.Hint;

  miZMCustom.Caption      := LoadLStr(276);
  miZMCustom.Hint         := LoadLStr(277);

  piZoomCustom.Caption    := miZMCustom.Caption;
  piZoomCustom.Hint       := miZMCustom.Hint;

  mMulti.Caption            := LoadLStr(280);
  miMultiFirst.Caption      := LoadLStr(282);
  miMultiFirst.Hint         := LoadLStr(283);
  miMultiPrevious.Caption   := LoadLStr(284);
  miMultiPrevious.Hint      := LoadLStr(285);
  miMultiNext.Caption       := LoadLStr(286);
  miMultiNext.Hint          := LoadLStr(287);
  miMultiLast.Caption       := LoadLStr(288);
  miMultiLast.Hint          := LoadLStr(289);
  miMultiGoTo.Caption       := LoadLStr(290);
  miMultiGoTo.Hint          := LoadLStr(291);
  miMultiExtract.Caption    := LoadLStr(292);
  miMultiExtract.Hint       := LoadLStr(293);

  pMulti.Caption            := mMulti.Caption;
  piMultiFirst.Caption      := miMultiFirst.Caption;
  piMultiFirst.Hint         := miMultiFirst.Hint;
  piMultiPrevious.Caption   := miMultiPrevious.Caption;
  piMultiPrevious.Hint      := miMultiPrevious.Hint;
  piMultiNext.Caption       := miMultiNext.Caption;
  piMultiNext.Hint          := miMultiNext.Hint;
  piMultiLast.Caption       := miMultiLast.Caption;
  piMultiLast.Hint          := miMultiLast.Hint;
  piMultiGoTo.Caption       := miMultiGoTo.Caption;
  piMultiGoTo.Hint          := miMultiGoTo.Hint;
  piMultiExtract.Caption    := miMultiExtract.Caption;
  piMultiExtract.Hint       := miMultiExtract.Hint;

  mAnim.Caption         := LoadLStr(300);
  miAnimPlay.Caption    := LoadLStr(302);
  miAnimPlay.Hint       := LoadLStr(303);
  miAnimPause.Caption   := LoadLStr(304);
  miAnimPause.Hint      := LoadLStr(305);
  miAnimStop.Caption    := LoadLStr(306);
  miAnimStop.Hint       := LoadLStr(307);

  pAnim.Caption         := mAnim.Caption;
  piAnimPlay.Caption    := miAnimPlay.Caption;
  piAnimPlay.Hint       := miAnimPlay.Hint;
  piAnimPause.Caption   := miAnimPause.Caption;
  piAnimPause.Hint      := miAnimPause.Hint;
  piAnimStop.Caption    := miAnimStop.Caption;
  piAnimStop.Hint       := miAnimStop.Hint;

  mGo.Caption           := LoadLStr(310);
  miGoBack.Caption      := LoadLStr(312);
  miGoBack.Hint         := LoadLStr(313);
  miGoForward.Caption   := LoadLStr(314);
  miGoForward.Hint      := LoadLStr(315);
  miGoFirst.Caption     := LoadLStr(316);
  miGoFirst.Hint        := LoadLStr(317);
  miGoLast.Caption      := LoadLStr(318);
  miGoLast.Hint         := LoadLStr(319);
  miGoRandom.Caption    := LoadLStr(320);
  miGoRandom.Hint       := LoadLStr(321);

  piBack.Caption        := miGoBack.Caption;
  piBack.Hint           := miGoBack.Hint;
  piForward.Caption     := miGoForward.Caption;
  piForward.Hint        := miGoForward.Hint;

  miShow.Caption        := LoadLStr(326);
  miShow.Hint           := LoadLStr(327);
  miStartShow.Caption   := LoadLStr(328);
  miStartShow.Hint      := LoadLStr(329);
  miFullScreen.Caption  := LoadLStr(330);
  miFullScreen.Hint     := LoadLStr(331);

  piFullScreen.Caption  := miFullScreen.Caption;
  piFullScreen.Hint     := miFullScreen.Hint;

  miOptions.Caption     := LoadLStr(350);
  miOptions.Hint        := Format(LoadLStr(351), [sAppName]);

  miWebSite.Caption     := Format(LoadLStr(362), [sAppName]);
  miWebSite.Hint        := Format(LoadLStr(363), [sAppName]);
  miAbout.Caption       := LoadLStr(364);
  miAbout.Hint          := Format(LoadLStr(365), [sAppName]);

  piMinimize.Caption    := LoadLStr(370);
  piMinimize.Hint       := LoadLStr(371);

  dlgOpen.Title         := LoadLStr(400);
  dlgSave.Title         := LoadLStr(405);

  itbMain.Caption         := LoadLStr(500);
  tbnOpen.Caption         := LoadLStr(502);
  tbnOpen.Hint            := LoadLStr(503);
  tbnLast.Caption         := LoadLStr(504);
  tbnLast.Hint            := LoadLStr(505);
  tbnSave.Caption         := LoadLStr(506);
  tbnSave.Hint            := LoadLStr(507);
  tbnClose.Caption        := LoadLStr(508);
  tbnClose.Hint           := LoadLStr(509);
  tbnPrint.Caption        := LoadLStr(510);
  tbnPrint.Hint           := LoadLStr(511);
  tbnCopy.Caption         := LoadLStr(512);
  tbnCopy.Hint            := LoadLStr(513);
  tbnPaste.Caption        := LoadLStr(514);
  tbnPaste.Hint           := LoadLStr(515);
  tbnMultiPrev.Caption    := LoadLStr(516);
  tbnMultiPrev.Hint       := LoadLStr(517);
  tbnMultiNext.Caption    := LoadLStr(518);
  tbnMultiNext.Hint       := LoadLStr(519);
  tbnInfo.Caption         := LoadLStr(520);
  tbnInfo.Hint            := LoadLStr(521);
  tbnZoomIn.Caption       := LoadLStr(522);
  tbnZoomIn.Hint          := LoadLStr(523);
  tbnZoomOut.Caption      := LoadLStr(524);
  tbnZoomOut.Hint         := LoadLStr(525);
  tbnRotate.Caption       := LoadLStr(526);
  tbnRotate.Hint          := LoadLStr(527);
  tbnZoomMisc.Caption     := LoadLStr(528);
  tbnZoomMisc.Hint        := LoadLStr(529);
  tbnDisp.Caption         := LoadLStr(530);
  tbnDisp.Hint            := LoadLStr(531);
  tbnFullScreen.Caption   := LoadLStr(532);
  tbnFullScreen.Hint      := LoadLStr(533);
  tbnEditor.Caption       := LoadLStr(534);
  tbnEditor.Hint          := LoadLStr(535);
  tbnGoBack.Caption       := LoadLStr(536);
  tbnGoBack.Hint          := LoadLStr(537);
  tbnGoForward.Caption    := LoadLStr(538);
  tbnGoForward.Hint       := LoadLStr(539);
  tbnGoRandom.Caption     := LoadLStr(542);
  tbnGoRandom.Hint        := LoadLStr(543);
  tbnUndo.Caption         := LoadLStr(540);
  tbnUndo.Hint            := LoadLStr(541);
  tbnZoomFit.Caption      := LoadLStr(544);
  tbnZoomFit.Hint         := LoadLStr(545);
  tbnFDelete.Caption      := LoadLStr(548);
  tbnFDelete.Hint         := LoadLStr(549);
  tbnFCopy.Caption        := LoadLStr(550);
  tbnFCopy.Hint           := LoadLStr(551);
  tbnFMove.Caption        := LoadLStr(552);
  tbnFMove.Hint           := LoadLStr(553);
  tbnFRename.Caption      := LoadLStr(554);
  tbnFRename.Hint         := LoadLStr(555);
  tbnZoom100.Caption      := LoadLStr(556);
  tbnZoom100.Hint         := LoadLStr(557);
  tbnZoomWidth.Caption    := LoadLStr(558);
  tbnZoomWidth.Hint       := LoadLStr(559);
  tbnZoomHeight.Caption   := LoadLStr(560);
  tbnZoomHeight.Hint      := LoadLStr(561);
  tbnRotateCCW.Caption    := LoadLStr(562);
  tbnRotateCCW.Hint       := LoadLStr(563);
  tbnGoFirst.Caption      := LoadLStr(564);
  tbnGoFirst.Hint         := LoadLStr(565);
  tbnGoLast.Caption       := LoadLStr(566);
  tbnGoLast.Hint          := LoadLStr(567);
  tbnShow.Caption         := LoadLStr(568);
  tbnShow.Hint            := LoadLStr(569);
  tbnOptions.Caption      := LoadLStr(570);
  tbnOptions.Hint         := Format(LoadLStr(571), [sAppName]);
  tbnHelp.Caption         := LoadLStr(572);
  tbnHelp.Hint            := Format(LoadLStr(573), [sAppName]);
  tbnOnline.Caption       := LoadLStr(574);
  tbnOnline.Hint          := Format(LoadLStr(575), [sAppName]);
  tbnAbout.Caption        := LoadLStr(576);
  tbnAbout.Hint           := Format(LoadLStr(577), [sAppName]);
  tbnRScan.Caption        := LoadLStr(578);
  tbnRScan.Hint           := LoadLStr(579);
  tbnRMail.Caption        := LoadLStr(580);
  tbnRMail.Hint           := LoadLStr(581);
  tbnRCapture.Caption     := LoadLStr(582);
  tbnRCapture.Hint        := LoadLStr(583);
  tbnRJPEG.Caption        := LoadLStr(584);
  tbnRJPEG.Hint           := LoadLStr(585);
  tbnGoToPage.Caption     := LoadLStr(590);
  tbnGoToPage.Hint        := LoadLStr(591);

  miCustTB.Caption   := LoadLStr(3500);
  miCustTB.Hint      := LoadLStr(3501);
  piCustTB.Caption   := LoadLStr(3500);
  piCustTB.Hint      := LoadLStr(3501);
end;

// updates application GUI on theme changes
procedure TfrmMain.UpdateThemes();
begin
  if IsThemed() then
    begin
    // themes
    frmMain.tbrMain.EdgeBorders:= [];
    frmMain.sbxMain.BorderStyle := bsNone;
    end
  else
    begin
    // no themes, standard Windows GUI
    frmMain.tbrMain.EdgeBorders:= [ebTop];
    frmMain.sbxMain.BorderStyle := bsSingle;
    end;

  // force status bar repaint
  sbrMain.Repaint();
end;

// allows application to do custom things during system theme changes
procedure TfrmMain.NoticeThemeChange(var msg: TMessage);
begin
  // running our own procedure
  UpdateThemes();

  // result
  msg.Result := 0;
end;

procedure TfrmMain.miOpenClick(Sender: TObject);
begin
  OpenImage();
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
  Clipboard.Assign(frmMain.img.IEBitmap.VclBitmap);
end;

procedure TfrmMain.miPasteClick(Sender: TObject);
var
  tmp: TBitmap;
  wmf: TMetaFile;
begin
  tmp := TBitmap.Create();

  if Clipboard.HasFormat(CF_BITMAP) then
    begin
    tmp.Assign(Clipboard);
    tmp.PixelFormat := pf24bit;
    OpenUntitled(tmp);
    end
  else
    if Clipboard.HasFormat(CF_METAFILEPICT) then
      begin
      wmf := TMetaFile.Create();

      wmf.Assign(Clipboard);
      tmp.Width := wmf.Width;
      tmp.Height := wmf.Height;
      tmp.PixelFormat := pf24bit;
      tmp.Canvas.Draw(0, 0, wmf);
      OpenUntitled(tmp);

      FreeAndNil(wmf);
      end;

  FreeAndNil(tmp);
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

procedure TfrmMain.miZM6Click(Sender: TObject);
begin
  Zoom(6, true);
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

procedure TfrmMain.mruClick(Sender: TObject);
var
  str: string;
begin
  if Sender is TMenuItem then
    begin
    str := (Sender as TMenuItem).Hint;

    if FileExists(str) then
      Load(str);
    end;
end;

procedure TfrmMain.miOptionsClick(Sender: TObject);
begin
  if not Assigned(frmOptions) then
    begin
    Application.CreateForm(TfrmOptions, frmOptions);
    frmOptions.ShowModal();
    end;
end;

procedure TfrmMain.miToolbarClick(Sender: TObject);
begin
  ToggleMainToolbar();
end;

procedure TfrmMain.miStatusBarClick(Sender: TObject);
begin
  ToggleStatusBar();
end;

procedure TfrmMain.piMinimizeClick(Sender: TObject);
begin
  Application.Minimize();
end;

procedure TfrmMain.miInfoClick(Sender: TObject);
begin
  if not Assigned(frmInfo) then
    begin
    Application.CreateForm(TfrmInfo, frmInfo);
    frmInfo.ShowModal();
    end;
end;

procedure TfrmMain.miEditorClick(Sender: TObject);
begin
  if not Assigned(frmEditor) then
    begin
    Application.CreateForm(TfrmEditor, frmEditor);
    frmEditor.ShowModal();
    end;
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
  if (infImage.image_type = itMulti) then
    MGoPrev();
end;

procedure TfrmMain.tbnMultiNextClick(Sender: TObject);
begin
  if (infImage.image_type = itMulti) then
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
  PrintImage();
end;

procedure TfrmMain.miShowClick(Sender: TObject);
begin
  if not Assigned(frmShow) then
    begin
    Application.CreateForm(TfrmShow, frmShow);
    frmShow.Show();
    end
  else
    frmShow.Close();
end;

procedure TfrmMain.miStartShowClick(Sender: TObject);
begin
  miShowClick(Self);

  if Assigned(frmShow) then
    frmShow.btnStart.Click();
end;

procedure TfrmMain.miWebSiteClick(Sender: TObject);
begin
  OpenURL(sURL);
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

procedure TfrmMain.miDSFitBigClick(Sender: TObject);
begin
  SetDisplayStyle(dsFitBig);
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
  if (GetDisplayStyle() = dsFitBig) then
    begin
    if miDSFitAll.Visible then
      SetDisplayStyle(dsFitAll)
    else
      SetDisplayStyle(dsNormal);
    end
  else if (GetDisplayStyle() = dsFitAll) then
    SetDisplayStyle(dsNormal)
  else if (GetDisplayStyle() = dsNormal) then
    SetDisplayStyle(dsFitBig);
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

procedure TfrmMain.appEventsHint(Sender: TObject);
begin
  SetHintPanelText(GetLongHint(Application.Hint));
end;

procedure TfrmMain.appEventsIdle(Sender: TObject; var Done: Boolean);
begin
  // setting header
  Header();

  // setting undo
  if (frmMain.img.Proc.CanUndo) then
    begin
    frmMain.miUndo.Enabled := true;
    frmMain.tbnUndo.Enabled := true;
    end
  else
    begin
    frmMain.miUndo.Enabled := false;
    frmMain.tbnUndo.Enabled := false;
    end;

  // "Paste" button routine
  if ((Clipboard.HasFormat(CF_BITMAP)) or (Clipboard.HasFormat(CF_METAFILEPICT))) then
    begin
    frmMain.tbnPaste.Enabled := true;
    frmMain.miPaste.Enabled := true;
    end
  else
    begin
    frmMain.tbnPaste.Enabled := false;
    frmMain.miPaste.Enabled := false;
    end;

  // file navigation disabling, if only 1 file
  if ((files.Count < 2) or (infImage.image_type = itUnsaved) or (infImage.image_type = itNone)) then
    begin
    frmMain.tbnGoBack.Enabled := false;
    frmMain.tbnGoForward.Enabled := false;
    frmMain.tbnGoRandom.Enabled := false;
    frmMain.piBack.Enabled := false;
    frmMain.piForward.Enabled := false;
    frmMain.miGoBack.Enabled := false;
    frmMain.miGoForward.Enabled := false;
    frmMain.miGoFirst.Enabled := false;
    frmMain.miGoLast.Enabled := false;
    frmMain.miGoRandom.Enabled := false;
    frmMain.miShow.Enabled := false;
    frmMain.miStartShow.Enabled := false;
    if Assigned(frmShow) then
      frmShow.Close();
    end
  else
    begin
    frmMain.tbnGoBack.Enabled := true;
    frmMain.tbnGoForward.Enabled := true;
    frmMain.tbnGoRandom.Enabled := true;
    frmMain.piBack.Enabled := true;
    frmMain.piForward.Enabled := true;
    frmMain.miGoBack.Enabled := true;
    frmMain.miGoForward.Enabled := true;
    frmMain.miGoFirst.Enabled := true;
    frmMain.miGoLast.Enabled := true;
    frmMain.miGoRandom.Enabled := true;
    frmMain.miShow.Enabled := true;
    frmMain.miStartShow.Enabled := true;
    end;

  // zoom status
  if (infImage.image_type = itNone) then
    begin
    frmMain.sbrMain.Panels[0].Width := 0;
    frmMain.sbrMain.Panels[0].Text := '';
    end
  else
    begin
    frmMain.sbrMain.Panels[0].Width := 55;
    frmMain.sbrMain.Panels[0].Text := IntToStr(Round(frmMain.img.Zoom)) + '%';
    end;

  // image size
  if (infImage.image_type = itNone) then
    begin
    frmMain.sbrMain.Panels[1].Width := 0;
    frmMain.sbrMain.Panels[1].Text := '';
    end
  else
    begin
    frmMain.sbrMain.Panels[1].Width := 75;
    frmMain.sbrMain.Panels[1].Text := Format('%s x %s', [IntToStr(img.IEBitmap.Width), IntToStr(img.IEBitmap.Height)]);
    end;

  // multiple pages
  if (infImage.image_type = itMulti) then
    begin
    frmMain.sbrMain.Panels[2].Width := 50;
    frmMain.sbrMain.Panels[2].Text := IntToStr(infMulti.page + 1) + ' / ' + IntToStr(infMulti.pages);
    end
  else
    begin
    frmMain.sbrMain.Panels[2].Width := 0;
    frmMain.sbrMain.Panels[2].Text := '';
    end;

  // MRU stuff
  if infImage.path <> '' then
    begin
    frmMain.tbnLast.Enabled := not (frmMain.mru.Count < 2);
    frmMain.miLoadLast.Enabled := not (frmMain.mru.Count < 2);
    end
  else
    begin
    frmMain.tbnLast.Enabled := not (frmMain.mru.Count < 1);
    frmMain.miLoadLast.Enabled := not (frmMain.mru.Count < 1);
    end;
end;

procedure TfrmMain.miDSFitAllClick(Sender: TObject);
begin
  SetDisplayStyle(dsFitAll);
end;

procedure TfrmMain.SetHintPanelText(new_text: string);
begin
  frmMain.sbrMain.Panels[3].Text := new_text;
end;

procedure TfrmMain.imgProgress(Sender: TObject; per: Integer);
begin
  if frmMain.bProgressiveLoad then
    begin
    if ((prev_progress <> per) and ((per = 33) or (per = 66))) then
      begin
      img.Update();
      img.Paint();
      end;

    prev_progress := per;
    end;
end;

procedure TfrmMain.dlgSaveTypeChange(Sender: TObject);
begin
  if ((dlgSave.FilterIndex - 1) < frmMain.SaveExtensions.Count) then
    dlgSave.DefaultExt := frmMain.SaveExtensions.Strings[dlgSave.FilterIndex - 1];
end;

procedure TfrmMain.imgDblClick(Sender: TObject);
begin
  if bFSonDblClick then
    miFullScreenClick(Self);
end;

procedure TfrmMain.imgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ((Button = mbMiddle) and (ssMiddle in Shift)) then
    miFullScreenClick(Self);
end;

procedure TfrmMain.imgMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  up: boolean;
begin
  Handled := true;

  up := (WheelDelta > 0);

  if bReverseWheel then
    up := not up;

  if ((ssShift in Shift) and (ssCtrl in Shift)) then
    begin
    // scrolling
    if up then
      img.Perform(WM_HSCROLL, MakeWParam(SB_PAGEUP, 0), 0)
    else
      img.Perform(WM_HSCROLL, MakeWParam(SB_PAGEDOWN, 0), 0);
    end
  else if (ssShift in Shift) then
    begin
    // scrolling
    if up then
      img.Perform(WM_VSCROLL, MakeWParam(SB_PAGEUP, 0), 0)
    else
      img.Perform(WM_VSCROLL, MakeWParam(SB_PAGEDOWN, 0), 0);
    end
  else if (ssCtrl in Shift) then
    begin
    if ((nMouseWheel = 0) or (nMouseWheel = 2)) then
      begin
      // zooming
      if up then
        begin
        if (Round(img.Zoom / 1.25) >= 1) then
          img.ZoomAt(MousePos.X, MousePos.Y, img.Zoom / 1.25, true);
        end
      else
        begin
        if (Round(img.Zoom * 1.25) <= 250000) then
          img.ZoomAt(MousePos.X, MousePos.Y, img.Zoom * 1.25, true);
        end;
      end
    else
      begin
      // file navigation
      if up then
        GoPrev()
      else
        GoNext();
      end;
    end
  else if (nMouseWheel = 0) then
    begin
    // file navigation
    if up then
      GoPrev()
    else
      GoNext();
    end
  else if (nMouseWheel = 1) then
    begin
    // zooming
    if (GetDisplayStyle() <> dsNormal) then
      SetDisplayStyle(dsNormal, true);

    if up then
      begin
      if (Round(img.Zoom / 1.25) >= 1) then
        img.ZoomAt(MousePos.X, MousePos.Y, img.Zoom / 1.25, false);
      end
    else
      begin
      if (Round(img.Zoom * 1.25) <= 250000) then
        img.ZoomAt(MousePos.X, MousePos.Y, img.Zoom * 1.25, false);
      end;
    end
  else if (nMouseWheel = 2) then
    begin
    // scrolling
    if up then
      img.Perform(WM_VSCROLL, MakeWParam(SB_PAGEUP, 0), 0)
    else
      img.Perform(WM_VSCROLL, MakeWParam(SB_PAGEDOWN, 0), 0);
    end;
end;

procedure TfrmMain.miCustTBClick(Sender: TObject);
begin
  if not Assigned(frmCustTB) then
    begin
    Application.CreateForm(TfrmCustTB, frmCustTB);
    frmCustTB.ShowModal();
    end;
end;

procedure TfrmMain.miLoadLastClick(Sender: TObject);
var
  str: string;
begin
  mru.CleanUp(false);
  str := mru.GetLastItem();

  if (str <> '') then
    Load(str);
end;

procedure TfrmMain.UMAppIDCheck(var Message: TMessage);
begin
  Message.Result := APP_ID;
end;

procedure TfrmMain.UMRestoreApplication(var Message: TMessage);
begin
  if IsIconic(Application.Handle) then
    Application.Restore()
  else
    Application.BringToFront;
end;

procedure TfrmMain.UMPreviousInstParams(var Message: TMessage);
var
  Len : integer;
  S: string;
begin
  SetLength(S, MAX_PATH);
  Len := GlobalGetAtomName(Message.wParam, PWideChar(S), MAX_PATH);

  if (Len <> 0) then
    begin
    SetLength(S, Len);

    if FileExists(S) then
      Load(S);
    end;
end;

procedure TfrmMain.tbnRCaptureClick(Sender: TObject);
begin
  ExecuteRole(PR_CAPTURE);
end;

procedure TfrmMain.tbnRJPEGClick(Sender: TObject);
begin
  ExecuteRole(PR_JPEGLL);
end;

procedure TfrmMain.tbnRMailClick(Sender: TObject);
begin
  ExecuteRole(PR_EMAIL);
end;

procedure TfrmMain.tbnRScanClick(Sender: TObject);
begin
  ExecuteRole(PR_SCAN);
end;

procedure TfrmMain.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  case Msg.CharCode of
    VK_RETURN:
      begin
      if (frmMain.nEnter = 0) then
        tbnDispClick(Self)
      else
        miFullScreenClick(Self);

      Handled := true;
      end;

    VK_ADD, VK_OEM_PLUS:
      begin
      if tbnZoomIn.Enabled then
        ZoomIn();

      Handled := true;
      end;

    VK_SUBTRACT, VK_OEM_MINUS:
      begin
      if tbnZoomOut.Enabled then
        ZoomOut();

      Handled := true;
      end;

    VK_PRIOR, VK_BACK, VK_BROWSER_BACK, VK_MEDIA_PREV_TRACK:
      begin
      if tbnGoBack.Enabled then
        begin
        if IsShift() then
          GoFirst()
        else
          GoPrev();
        end;

      Handled := true;
      end;

    VK_NEXT, VK_SPACE, VK_BROWSER_FORWARD, VK_MEDIA_NEXT_TRACK:
      begin
      if tbnGoForward.Enabled then
        begin
        if IsShift() then
          GoLast()
        else
          GoNext();
        end;

      Handled := true;
      end;

    VK_BROWSER_REFRESH:
      begin
      tbnDispClick(Self);

      Handled := true;
      end;

    VK_BROWSER_STOP, VK_MEDIA_STOP:
      begin
      miFullScreenClick(Self);

      Handled := true;
      end;

    VK_F2:
      begin
      if (miEditor.Enabled and (not frmMain.full_screen)) then
        miEditorClick(Self);

      Handled := true;
      end;

    VK_F3:
      begin
      if Assigned(frmShow) then
        frmShow.Visible := (not frmShow.Visible);

      Handled := true;
      end;

    VK_F5:
      begin
      if tbnGoRandom.Enabled then
        miGoRandomClick(Self);

      Handled := true;
      end;

    VK_F6, VK_MEDIA_PLAY_PAUSE:
      begin
      if miStartShow.Enabled then
        miStartShowClick(Self);

      Handled := true;
      end;

    VK_F7:
      begin
      if miLoadLast.Enabled then
        miLoadLastClick(Self);

      Handled := true;
      end;

    VK_F11:
      begin
      miFullScreenClick(Self);

      Handled := true;
      end;

    VK_UP:
      begin
      if (frmMain.nArrows = 0) then
        begin
        if tbnGoBack.Enabled then
          GoPrev();
        end
      else
        begin
        if IsShift() then
          img.Perform(WM_VSCROLL, MakeWParam(SB_PAGEUP, 0), 0)
        else
          img.Perform(WM_VSCROLL, MakeWParam(SB_LINEUP, 0), 0);
        end;

      Handled := true;
      end;

    VK_DOWN:
      begin
      if (frmMain.nArrows = 0) then
        begin
        if tbnGoForward.Enabled then
          GoNext();
        end
      else
        begin
        if IsShift() then
          img.Perform(WM_VSCROLL, MakeWParam(SB_PAGEDOWN, 0), 0)
        else
          img.Perform(WM_VSCROLL, MakeWParam(SB_LINEDOWN, 0), 0);
        end;

      Handled := true;
      end;

    VK_RIGHT:
      begin
      if (frmMain.nArrows = 0) then
        begin
        if tbnGoForward.Enabled then
          GoNext();
        end
      else
        begin
        if IsShift() then
          img.Perform(WM_HSCROLL, MakeWParam(SB_PAGERIGHT, 0), 0)
        else
          img.Perform(WM_HSCROLL, MakeWParam(SB_LINERIGHT, 0), 0);
        end;

      Handled := true;
      end;

    VK_LEFT:
      begin
      if (frmMain.nArrows = 0) then
        begin
        if tbnGoBack.Enabled then
          GoPrev();
        end
      else
        begin
        if IsShift() then
          img.Perform(WM_HSCROLL, MakeWParam(SB_PAGELEFT, 0), 0)
        else
          img.Perform(WM_HSCROLL, MakeWParam(SB_LINELEFT, 0), 0);
        end;

      Handled := true;
      end;

    Word('1'):
      if IsCtrl() then
        begin
        if tbnZoomMisc.Enabled then
          miZM100Click(Self);

        Handled := true;
        end;

    Word('2'):
      if IsCtrl() then
        begin
        if tbnZoomMisc.Enabled then
          miZM200Click(Self);

        Handled := true;
        end;

    Word('3'):
      if IsCtrl() then
        begin
        if tbnZoomMisc.Enabled then
          Zoom(300, true);

        Handled := true;
        end;

    Word('4'):
      if IsCtrl() then
        begin
        if tbnZoomMisc.Enabled then
          Zoom(400, true);

        Handled := true;
        end;

    Word('5'):
      if IsCtrl() then
        begin
        if tbnZoomMisc.Enabled then
          miZM50Click(Self);

        Handled := true;
        end;

    Word('6'):
      if IsCtrl() then
        begin
        if tbnZoomMisc.Enabled then
          Zoom(25, true);

        Handled := true;
        end;

    Word('7'):
      if IsCtrl() then
        begin
        if tbnZoomMisc.Enabled then
          Zoom(75, true);

        Handled := true;
        end;

    Word('8'):
      if IsCtrl() then
        begin
        if tbnZoomMisc.Enabled then
          Zoom(125, true);

        Handled := true;
        end;

    Word('9'):
      if IsCtrl() then
        begin
        if tbnZoomMisc.Enabled then
          Zoom(150, true);

        Handled := true;
        end;

    Word('0'):
      if IsCtrl() then
        begin
        if tbnZoomMisc.Enabled then
          miZmFitClick(Self);

        Handled := true;
        end;

    Word('`'), $DF:
      if IsCtrl() then
        begin
        if tbnZoomMisc.Enabled then
          miZMCustomClick(Self);

        Handled := true;
        end;

    Word('C'):
      if IsCtrl() then
        begin
        if miCopy.Enabled then
          miCopyClick(Self);

        Handled := true;
        end;

    Word('I'):
      if IsCtrl() then
        begin
        if miInfo.Enabled then
          miInfoClick(Self);

        Handled := true;
        end;

    Word('K'):
      if IsCtrl() then
        begin
        if tbnMultiPrev.Enabled then
          tbnMultiPrevClick(Self);

        Handled := true;
        end;

    Word('L'):
      if IsCtrl() then
        begin
        if tbnMultiNext.Enabled then
          tbnMultiNextClick(Self);

        Handled := true;
        end;

    Word('M'):
      if IsCtrl() then
        begin
        if miFMove.Enabled then
          miFMoveClick(Self);

        Handled := true;
        end;

    Word('O'):
      if IsCtrl() then
        begin
        if miOpen.Enabled then
          miOpenClick(Self);

        Handled := true;
        end;

    Word('P'):
      if IsCtrl() then
        begin
        if miPrintPreview.Enabled then
          miPrintPreviewClick(Self);

        Handled := true;
        end;

    Word('R'):
      if IsCtrl() then
        begin
        if tbnZoomMisc.Enabled then
          begin
          if IsShift() then
            miRotateViewCCWClick(Self)
          else
            miRotateViewClick(Self);
          end;

        Handled := true;
        end;

    Word('S'):
      if IsCtrl() then
        begin
        if miSaveAs.Enabled then
          miSaveAsClick(Self);

        Handled := true;
        end;

    Word('T'):
      if IsCtrl() then
        begin
        if miFCopy.Enabled then
          miFCopyClick(Self);

        Handled := true;
        end;

    Word('V'):
      if IsCtrl() then
        begin
        if miPaste.Enabled then
          miPasteClick(Self);

        Handled := true;
        end;

    Word('X'):
      if IsCtrl() then
        begin
        if miClose.Enabled then
          miCloseClick(Self);

        Handled := true;
        end;

    Word('Y'):
      if IsCtrl() then
        begin
        if miFRename.Enabled then
          miFRenameClick(Self);

        Handled := true;
        end;

    Word('Z'):
      if IsCtrl() then
        begin
        if miUndo.Enabled then
          miUndoClick(Self);

        Handled := true;
        end;

    VK_DELETE:
      begin
      if miFDelete.Enabled then
        miFDeleteClick(Self);

      Handled := true;
      end;

    VK_ESCAPE:
      begin
      miExitClick(Self);

      Handled := true;
      end;
  end;
end;

procedure TfrmMain.HandleXButtons(var msg: TMessage);
begin
  // default result is false
  msg.Result := 0;

  // handling extra mouse buttons
  case msg.WParamHi of
    MK_XBUTTON1:
      begin
      // forward
      GoNext();

      // changing result
      msg.Result := 1;
      end;

    MK_XBUTTON2:
      begin
      // back
      GoPrev();

      // changing result
      msg.Result := 1;
      end;
  end;
end;

end.
