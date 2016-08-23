unit w_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ToolWin, ImgList, ExtCtrls, ShellAPI, ShlObj, ClipBrd,
  Printers, FileCtrl, AppEvnts, Registry, UxTheme,
  c_const, c_wndpos, c_reg, c_utils, c_themes, c_ie, c_graphics,
  ieview, imageenview, hyieutils, ImageEnIO, hyiedefs,
  fx_defs, fx_mru, fx_core, c_tb, f_instance;

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
    pMulti: TMenuItem;
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
    miMultiFirst: TMenuItem;
    miMultiPrevious: TMenuItem;
    miMultiNext: TMenuItem;
    miMultiLast: TMenuItem;
    N24: TMenuItem;
    miMultiGoTo: TMenuItem;
    miMultiExtract: TMenuItem;
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
    dlgOpen: TOpenDialog;
    pRecent: TMenuItem;
    N31: TMenuItem;
    miOptions: TMenuItem;
    imlDis: TImageList;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure HandleFImport(Sender: TObject);
    procedure DoHandleFImport(func: TFxImgImport; name: string);
    procedure HandleFExport(Sender: TObject);
    procedure DoHandleFExport(func: TFxImgExport; name: string);
    procedure HandleFTool(Sender: TObject);
    procedure DoHandleFTool(func: TFxImgTool; name: string);
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
    procedure miToolbarClick(Sender: TObject);
    procedure miStatusBarClick(Sender: TObject);
    procedure piMinimizeClick(Sender: TObject);
    procedure miInfoClick(Sender: TObject);
    procedure miZM6Click(Sender: TObject);
    procedure miEditorClick(Sender: TObject);
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
    procedure miDSFitClick(Sender: TObject);
    procedure miDSCenterImageClick(Sender: TObject);
    procedure miDSScrollbarsClick(Sender: TObject);
    procedure tbnDispClick(Sender: TObject);
    procedure MRUpopClick(Sender: TObject; const FileName: String);
    procedure tbnRotateClick(Sender: TObject);
    procedure miRotateViewClick(Sender: TObject);
    procedure miRotateViewCCWClick(Sender: TObject);
    procedure appEventsHint(Sender: TObject);
    procedure appEventsIdle(Sender: TObject; var Done: Boolean);
    procedure SetHintPanelText(new_text: string);
    procedure dlgSaveTypeChange(Sender: TObject);
    procedure imgDblClick(Sender: TObject);
    procedure imgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure imgMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure miCustTBClick(Sender: TObject);
    procedure miLoadLastClick(Sender: TObject);
    procedure tbnRCaptureClick(Sender: TObject);
    procedure tbnRJPEGClick(Sender: TObject);
    procedure tbnRScanClick(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure miOptionsClick(Sender: TObject);
  private
    dispStyle: TDisplayStyles;

    procedure UMAppIDCheck(var Message: TMessage); message UM_APP_ID_CHECK;
    procedure UMRestoreApplication(var Message: TMessage); message UM_RESTORE_APPLICATION;
    procedure UMPreviousInstParams(var Message: TMessage); message UM_PREVIOUS_INST_PARAMS;
    procedure HandleXButtons(var msg: TMessage); message WM_XBUTTONDOWN;
  public
    mru: FuturixMRU;

    bFullPathInTitle: boolean;
    bNoMRU: boolean;
    bReverseWheel: boolean;

    SaveExtensions: TStringList;

    dir: string;
    full_screen: boolean;

    property SelectedDisplayState: TDisplayStyles read dispStyle;

    procedure UpdateThemes();
    procedure NoticeThemeChange(var msg: TMessage); message WM_THEMECHANGED;
    procedure SetDisplayStyleEx(style: TDisplayStyles; careful: boolean = false);
  end;

var
  fx: FuturixCore;
  frmMain: TfrmMain;
  files: TStringList;

  fxSettings: record
    ColorDefault: TColor;
    ColorFullScreen: TColor;
    ColorGradient: TColor;

    BackgroundStyle: integer;
  end;

  infImage: record
    path: string;
    pages, page: integer;
    
    filenum: integer;
  end;

  infRoles: record
    capture, scan, jpegll: boolean;
  end;

function FxImgGlobalCallback(query_type, value, xtra: longword): TFxImgResult; cdecl;
function IsPresent(): boolean;
function IsUnsaved(): boolean;
function IsMultipage(): boolean;
procedure FillImage(path: string; pages: integer = 0; page: integer = 0);
procedure FillBitmap(bmp: TBitmap; img: HBITMAP = 0);


implementation

uses
  w_about, w_custzoom, w_info, f_ui, f_nav, f_images, f_plugins, f_tools, f_graphics,
  w_show, w_editor, f_toolbar, w_custtb, w_preview, w_options;

{$R *.DFM}

function FxImgGlobalCallback(query_type, value, xtra: longword): TFxImgResult;
begin
  Result.result_type := RT_BOOL;
  Result.result_value := FX_FALSE;
end;

function IsPresent(): boolean;
begin
  Result := false;

  if Assigned(frmMain) then
    Result := not frmMain.img.IsEmpty;
end;

function IsUnsaved(): boolean;
begin
  Result := (infImage.path = '');
end;

function IsMultipage(): boolean;
begin
  Result := (infImage.pages > 1);
end;

procedure FillImage(path: string; pages: integer = 0; page: integer = 0);
begin
  infImage.path := path;
  infImage.pages := pages;
  infImage.page := page;

  Header();
end;

procedure FillBitmap(bmp: TBitmap; img: HBITMAP = 0);
var
  bim: TBitmap;
begin
  if (img = 0) then
    begin
    bmp.ApplyLimits();

    frmMain.img.IEBitmap.Assign(bmp);
    frmMain.img.IEBitmap.PrepareAlphaAfterAssignment();
    end
  else
    begin
    bim := TBitmap.Create();
    bim.Handle := img;
    bim.ApplyLimits();

    frmMain.img.IEBitmap.Assign(bim);
    frmMain.img.IEBitmap.PrepareAlphaAfterAssignment();

    FreeAndNil(bim);
    end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  wreg: TFRegistry;
  globalIndex, localIndex: integer;
  pluginScanned: boolean;
begin
  fx := FuturixCore.Create();

  wreg := TFRegistry.Create(RA_READONLY);
  wreg.RootKey := HKEY_CURRENT_USER;

  pluginScanned := false;

  // fix borked cursor
  Screen.Cursors[crHandPoint] := LoadCursor(0, IDC_HAND);

  // setting common variables
  files := TStringList.Create();
  SaveExtensions := TStringList.Create();
  infRoles.capture := false;
  infRoles.scan := false;
  infRoles.jpegll := false;

  // initializing randomizer
  Randomize();

  // initialize themes
  LoadTheme(HInstance);
    
  // setting image view
  img.Blank();
  img.Proc.UndoLimit := 32;
  img.Proc.ClearAllUndo();
  img.MouseWheelParams.Action := iemwNone;

  // theme UI updates
  UpdateThemes();

  DragAcceptFiles(Handle, true);

  // install plug-ins if not done that already
  if not wreg.KeyExists(sModules) then
    begin
    fx.PluginScan();

    pluginScanned := true;
    end;

  globalIndex := FxRegRInt(sPluginCounter, 0, sReg, HKEY_LOCAL_MACHINE);
  localIndex := FxRegRInt('PreviousScanCounter', -1);

  if (globalIndex > localIndex) then
    begin
    if not pluginScanned then
      fx.PluginScan();

    FxRegWInt('PreviousScanCounter', globalIndex);
    end;

  // writing paths
  PutRegDock();

  // setting toolbar and main menu
  tbnZoomMisc.WholeDropDown := true;

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
    fxSettings.ColorDefault := StringToColor(wreg.RStr('Display_ColorBg', 'clAppWorkSpace'));
    fxSettings.ColorFullScreen := StringToColor(wreg.RStr('Display_ColorFs', 'clBlack'));
    fxSettings.ColorGradient := StringToColor(wreg.RStr('Display_ColorGradient', 'clSilver'));
    fxSettings.BackgroundStyle := wreg.RInt('Display_BgStyle', 0);

    bNoMRU := wreg.RBool('Core_DisableMRU', false);
    bAutoRotateEXIF := wreg.RBool('Data_AutoRotateOnEXIF', true);

    img.DelayZoomFilter := wreg.RBool('Display_DelayFilter', false);
    bReverseWheel := wreg.RBool('UI_ReverseMouseWheel', false);

    iegEnableCMS := wreg.RBool('Data_CMS', false);

    if wreg.RBool('Display_HighQuality', true) then
      begin
      case wreg.RInt('Display_Resampler', 0) of
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

    ToggleMainToolbar(true, wreg.RBool('UI_Toolbar', true));
    ToggleStatusbar(true, wreg.RBool('UI_Status', true));

    case wreg.RInt('UI_Style', 1) of
      0: SetDisplayStyleEx(dsNormal);
      1: SetDisplayStyleEx(dsFit);
      else
        SetDisplayStyleEx(dsNormal);
    end;

    SetCenter(wreg.RBool('UI_Center', true));
    SetScrollbars(wreg.RBool('UI_Scroll', true));

    bFullPathInTitle := wreg.RBool('UI_FullPathInTitle', false);

    wreg.CloseKey();
    end
  else
    begin
    fxSettings.ColorDefault := clAppWorkSpace;
    fxSettings.ColorFullScreen := clBlack;
    fxSettings.ColorGradient := clSilver;
    fxSettings.BackgroundStyle := 0;

    bNoMRU := false;
    bAutoRotateEXIF := true;

    img.DelayZoomFilter := false;
    bReverseWheel := false;

    iegEnableCMS := false;

    img.ZoomFilter := rfFastLinear;

    ToggleMainToolbar(true, true);
    ToggleStatusbar(true, true);

    SetDisplayStyleEx(dsFit);
    SetCenter(true);
    SetScrollbars(true);

    bFullPathInTitle := false;
    end;

  ApplyBackground();
  ApplyCustomToolbar();
  ApplyTheme();

  // installing plug-ins
  InstallPlugIns();

  // final
  Able();
  ProcessCommandLine();

  FreeAndNil(wreg);
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
    if ((not full_screen) and (not Assigned(frmEditor)) and (not Assigned(frmPrintPreview))) then
      begin
      wreg.WBool('UI_Toolbar', tbrMain.Visible);
      wreg.WBool('UI_Status', sbrMain.Visible);
      end;

    case dispStyle of
      dsNormal: wreg.WInteger('UI_Style', 0);
      dsFit: wreg.WInteger('UI_Style', 1);
    end;

    wreg.WBool('UI_Center', GetCenter());
    wreg.WBool('UI_Scroll', GetScrollbars());

    wreg.CloseKey();
    end;

  if not bNoMRU then
    mru.Save();

  if Assigned(frmShow) then
    frmShow.Close();

  FreeAndNil(wreg);
  FreeAndNil(fx);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(files);
  FreeAndNil(mru);
  FreeAndNil(SaveExtensions);
end;

procedure TfrmMain.HandleFImport(Sender: TObject);
var
  name: string;
begin
  name := StripHotKey(TMenuItem(Sender).Caption);

  DoHandleFImport(
    fx.Plugins.ResolveImport(name),
    name);
end;

procedure TfrmMain.DoHandleFImport(func: TFxImgImport; name: string);
var
  func_result: HBITMAP;
  tmp_res: TFxImgResult;
begin
  try
    if (@func <> nil) then
      begin
      tmp_res := func(PWideChar(name), Application.Handle, Handle, FxImgGlobalCallback);

      if (tmp_res.result_type = RT_HBITMAP) then
        func_result := tmp_res.result_value
      else
        func_result := 0;

      if (func_result <> 0) then
        OpenUntitled(nil, func_result);
      end;
  finally
  end;
end;

procedure TfrmMain.HandleFExport(Sender: TObject);
var
  name: string;
begin
  name := StripHotKey(TMenuItem(Sender).Caption);

  DoHandleFExport(
    fx.Plugins.ResolveExport(name),
    name);
end;

procedure TfrmMain.DoHandleFExport(func: TFxImgExport; name: string);
var
  bmp: TBitmap;
begin
  try
    if (@func <> nil) then
      begin
      bmp := TBitmap.Create();
      img.IEBitmap.PrepareAlphaForExternalUse();
      img.IEBitmap.CopyToTBitmap(bmp);
      bmp.ApplyLimits();

      func(PWideChar(name), bmp.ReleaseHandle(), Application.Handle, Handle, FxImgGlobalCallback);

      FreeAndNil(bmp);
      end;
  finally
  end;
end;

// FTool handler
procedure TfrmMain.HandleFTool(Sender: TObject);
var
  name: string;
begin
  name := StripHotKey(TMenuItem(Sender).Caption);

  DoHandleFTool(
    fx.Plugins.ResolveTool(name),
    name);
end;

procedure TfrmMain.DoHandleFTool(func: TFxImgTool; name: string);
var
  bmp: TBitmap;
  tmp_res: TFxImgResult;
begin
  try
    if (@func <> nil) then
      begin
      bmp := TBitmap.Create();
      img.IEBitmap.PrepareAlphaForExternalUse();
      img.IEBitmap.CopyToTBitmap(bmp);
      bmp.ApplyLimits();

      try
        tmp_res := func(PWideChar(infImage.path), PWideChar(name), bmp.ReleaseHandle(), Application.Handle, Handle, FxImgGlobalCallback);

        if (tmp_res.result_type = RT_HBITMAP) then
          OpenUntitled(nil, tmp_res.result_value)
        else if ((tmp_res.result_type = RT_INT) and (tmp_res.result_value = 1)) then
          OpenLocal(tmp_res.result_string_data, true, 0, true);
      except
      end;

      FreeAndNil(bmp);
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
      OpenLocal(fName);
      end;
    end;

  DragFinish(msg.Drop);
end;

procedure TfrmMain.SetDisplayStyleEx(style: TDisplayStyles; careful: boolean);
begin
  dispStyle := style;
  SetDisplayStyleIfNeeded(style, careful);
end;

procedure TfrmMain.miOptionsClick(Sender: TObject);
begin
  if not Assigned(frmOptions) then
    begin
    Application.CreateForm(TfrmOptions, frmOptions);
    frmOptions.ShowModal();
    end;
end;

procedure TfrmMain.miAboutClick(Sender: TObject);
begin
  if not Assigned(frmAbout) then
    begin
    Application.CreateForm(TfrmAbout, frmAbout);
    frmAbout.ShowModal();
    end;
end;

// updates application GUI on theme changes
procedure TfrmMain.UpdateThemes();
begin
  if IsThemed() then
    begin
    // themes
    tbrMain.EdgeBorders:= [];
    sbxMain.BorderStyle := bsNone;
    end
  else
    begin
    // no themes, standard Windows GUI
    tbrMain.EdgeBorders:= [ebTop];
    sbxMain.BorderStyle := bsSingle;
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
  if (IsPresent() and not IsUnsaved()) then
    dlgOpen.InitialDir := ExtractFileDir(infImage.path)
  else
    dlgOpen.InitialDir := FxRegRStr('OpenDialog_Path', '');

  if dlgOpen.Execute() then
    begin
    FxRegWStr('OpenDialog_Path', ExtractFileDir(dlgOpen.FileName));

    OpenLocal(dlgOpen.FileName);
    end;
end;

procedure TfrmMain.miCloseClick(Sender: TObject);
begin
  CloseImage();
end;

procedure TfrmMain.miSaveAsClick(Sender: TObject);
var
  tmp: string;
  res: BOOL;
begin
  SetSaveDialog();

  if dlgSave.Execute() then
    begin
    res := Write(dlgSave.FileName);

    FxRegWInt('SaveDialog_FilterSize', Length(dlgSave.Filter));
    FxRegWInt('SaveDialog_FilterIndex', dlgSave.FilterIndex);

    if (res and IsSupported(dlgSave.FileName)) then
      begin
      tmp := dlgSave.FileName;
      CloseImage();
      OpenLocal(tmp);
      end;
    end;
end;

procedure TfrmMain.miExitClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmMain.miCopyClick(Sender: TObject);
var
  bmp: TBitmap;
begin
  bmp := TBitmap.Create();

  img.IEBitmap.PrepareAlphaForExternalUse();
  img.IEBitmap.CopyToTBitmap(bmp);
  bmp.ApplyLimits();

  Clipboard.Assign(bmp);

  FreeAndNil(bmp);
end;

procedure TfrmMain.miPasteClick(Sender: TObject);
var
  tmp: TBitmap;
  wmf: TMetaFile;
begin
  if Clipboard.HasFormat(CF_BITMAP) then
    begin
    tmp := TBitmap.Create();

    tmp.Assign(Clipboard);
    tmp.ApplyLimits();

    OpenUntitled(tmp);

    FreeAndNil(tmp);
    end
  else
    if Clipboard.HasFormat(CF_METAFILEPICT) then
      begin
      tmp := TBitmap.Create();
      wmf := TMetaFile.Create();

      wmf.Assign(Clipboard);
      tmp.Width := wmf.Width;
      tmp.Height := wmf.Height;
      tmp.ApplyLimits();
      tmp.Canvas.Draw(0, 0, wmf);

      OpenUntitled(tmp);

      FreeAndNil(wmf);
      FreeAndNil(tmp);
      end;
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
      OpenLocal(str);
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

procedure TfrmMain.tbnMultiFirstClick(Sender: TObject);
begin
  MGoFirst();
end;

procedure TfrmMain.tbnMultiPrevClick(Sender: TObject);
begin
  if IsMultipage() then
    MGoPrev();
end;

procedure TfrmMain.tbnMultiNextClick(Sender: TObject);
begin
  if IsMultipage() then
    MGoNext();
end;

procedure TfrmMain.tbnMultiLastClick(Sender: TObject);
begin
  if IsMultipage() then
    MGoLast();
end;

procedure TfrmMain.tbnExtractPageClick(Sender: TObject);
var
  bmp: TBitmap;
begin
  bmp := TBitmap.Create();

  img.IEBitmap.PrepareAlphaForExternalUse();
  img.IEBitmap.CopyToTBitmap(bmp);
  bmp.ApplyLimits();

  OpenUntitled(bmp);

  FreeAndNil(bmp);
end;

procedure TfrmMain.tbnGoToPageClick(Sender: TObject);
var
  tmp: string;
  num: integer;
begin
  num := 0;
  tmp := IntToStr(infImage.pages);

  if InputQuery('Go to page', Format('Type a page number to go to (range from 1 to %s)', [tmp]), tmp) then
    begin
    // browsing
    try
      num := StrToInt(tmp);
    except
      ShowMessage('You need to input a valid number.');
      Abort();
    end;

    Dec(num);
    if ((num >= 0) and (num < infImage.pages)) then
      MGoToPage(num)
    else
      ShowMessage('Page does not exist.');
    end;
end;

procedure TfrmMain.miPrintPreviewClick(Sender: TObject);
begin
  if (Printer.Printers.Count > 0) then
    begin
    if not Assigned(frmPrintPreview) then
      begin
      Application.CreateForm(TfrmPrintPreview, frmPrintPreview);

      if FileExists(infImage.path) then
        frmPrintPreview.prwPrint.PrintJobTitle := ExtractFileName(infImage.path)
      else
        frmPrintPreview.prwPrint.PrintJobTitle := sAppName;

      frmPrintPreview.DrawView();
      frmPrintPreview.ShowModal();
      end;
    end
  else
    ShowMessage('No printers found.');
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
var
  tmp, fl: string;
  can_overwrite: boolean;
begin
  can_overwrite := false;

  tmp := FxRegRStr('Files_CopyFolder', '');

  if (IsPresent() and not IsUnsaved()) then
    begin
    if SelectDirectory('Select destination folder', '', tmp, [sdNewUI, sdNewFolder, sdShowEdit], Self) then
      begin
      fl := infImage.path;

      if FileExists(Slash(tmp) + NoSlash(ExtractFileName(fl))) then
        if MessageBox(Handle,
          'The file with the same name already exists in the destination folder. Would you like to overwrite it?', sAppName, MB_YESNO or MB_ICONQUESTION) = ID_YES then
          can_overwrite := true;

      CopyFile(PWideChar(fl), PWideChar(Slash(tmp) + NoSlash(ExtractFileName(fl))), not can_overwrite);

      FxRegWStr('Files_CopyFolder', Slash(tmp));
      end;
    end;
end;

procedure TfrmMain.miFDeleteClick(Sender: TObject);
var
  op: TSHFileOpStruct;
  tmp: string;
  res: integer;
begin
  ZeroMemory(@op, SizeOf(TSHFileOpStruct));

  if (IsPresent() and not IsUnsaved()) then
    begin
    tmp := infImage.path;
    CloseImage();

    // recycle bin
    op.Wnd := Handle;
    op.wFunc := FO_DELETE;
    op.pFrom := PWideChar(tmp);
    op.pTo := nil;
    op.fFlags := (FOF_ALLOWUNDO or FOF_FILESONLY);
    op.hNameMappings := nil;
    op.lpszProgressTitle := sAppName;

    res := SHFileOperation(op);

    if ((res = 0) and (not op.fAnyOperationsAborted)) then
      GoNext()
    else
      OpenLocal(tmp);
    end;
end;

procedure TfrmMain.miFMoveClick(Sender: TObject);
var
  tmp, fl: string;
  res: longbool;
begin
  tmp := FxRegRStr('Files_MoveFolder', '');

  if (IsPresent() and not IsUnsaved()) then
    begin
    if SelectDirectory('Select destination folder', '', tmp, [sdNewUI, sdNewFolder, sdShowEdit], Self) then
      begin
      fl := infImage.path;
      CloseImage();

      res := MoveFile(PWideChar(fl), PWideChar(Slash(tmp) + NoSlash(ExtractFileName(fl))));

      FxRegWStr('Files_MoveFolder', Slash(tmp));

      if res then
        OpenLocal(Slash(tmp) + ExtractFileName(fl))
      else
        OpenLocal(fl);
      end;
    end;
end;

procedure TfrmMain.miFRenameClick(Sender: TObject);
var
  tmp, new, name: string;
begin
  if (IsPresent() and not IsUnsaved()) then
    begin
    tmp := infImage.path;
    name := ExtractFileName(tmp);

    if InputQuery(sAppName, 'Type new file name (including extension)', name) then
      begin
      CloseImage();

      new := Slash(ExtractFileDir(tmp)) + name;

      if RenameFile(tmp, new) then
        OpenLocal(new)
      else
        OpenLocal(tmp);
      end;
    end;
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
  img.Proc.Undo();
  img.Proc.ClearUndo();
end;

procedure TfrmMain.miZmFitClick(Sender: TObject);
begin
  SetDisplayStyleIfNeeded(dsNormal, true);

  img.Fit();
end;

procedure TfrmMain.miZmWidthClick(Sender: TObject);
begin
  SetDisplayStyleIfNeeded(dsNormal, true);

  img.FitToWidth();
end;

procedure TfrmMain.miZmHeightClick(Sender: TObject);
begin
  SetDisplayStyleIfNeeded(dsNormal, true);

  img.FitToHeight();
end;

procedure TfrmMain.miDSNormalClick(Sender: TObject);
begin
  SetDisplayStyleEx(dsNormal);
end;

procedure TfrmMain.miDSFitClick(Sender: TObject);
begin
  SetDisplayStyleEx(dsFit);
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
    SetDisplayStyleEx(dsNormal)
  else if (GetDisplayStyle() = dsNormal) then
    SetDisplayStyleEx(dsFit);
end;

procedure TfrmMain.MRUpopClick(Sender: TObject; const FileName: String);
begin
  if FileExists(FileName) then
    OpenLocal(FileName);
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
  if (img.Proc.CanUndo) then
    begin
    miUndo.Enabled := true;
    tbnUndo.Enabled := true;
    end
  else
    begin
    miUndo.Enabled := false;
    tbnUndo.Enabled := false;
    end;

  // file navigation disabling, if only 1 file
  if ((files.Count < 2) or IsUnsaved() or (not IsPresent())) then
    begin
    tbnGoBack.Enabled := false;
    tbnGoForward.Enabled := false;
    tbnGoRandom.Enabled := false;
    piBack.Enabled := false;
    piForward.Enabled := false;
    miGoBack.Enabled := false;
    miGoForward.Enabled := false;
    miGoFirst.Enabled := false;
    miGoLast.Enabled := false;
    miGoRandom.Enabled := false;
    miShow.Enabled := false;
    miStartShow.Enabled := false;
    if Assigned(frmShow) then
      frmShow.Close();
    end
  else
    begin
    tbnGoBack.Enabled := true;
    tbnGoForward.Enabled := true;
    tbnGoRandom.Enabled := true;
    piBack.Enabled := true;
    piForward.Enabled := true;
    miGoBack.Enabled := true;
    miGoForward.Enabled := true;
    miGoFirst.Enabled := true;
    miGoLast.Enabled := true;
    miGoRandom.Enabled := true;
    miShow.Enabled := true;
    miStartShow.Enabled := true;
    end;

  // zoom status
  if (not IsPresent()) then
    begin
    sbrMain.Panels[0].Width := 0;
    sbrMain.Panels[0].Text := '';
    end
  else
    begin
    sbrMain.Panels[0].Width := 55;
    sbrMain.Panels[0].Text := IntToStr(Round(img.Zoom)) + '%';
    end;

  // image size
  if (not IsPresent()) then
    begin
    sbrMain.Panels[1].Width := 0;
    sbrMain.Panels[1].Text := '';
    end
  else
    begin
    sbrMain.Panels[1].Width := 75;
    sbrMain.Panels[1].Text := Format('%s x %s', [IntToStr(img.IEBitmap.Width), IntToStr(img.IEBitmap.Height)]);
    end;

  // multiple pages
  if IsMultipage() then
    begin
    sbrMain.Panels[2].Width := 50;
    sbrMain.Panels[2].Text := IntToStr(infImage.page + 1) + ' / ' + IntToStr(infImage.pages);
    end
  else
    begin
    sbrMain.Panels[2].Width := 0;
    sbrMain.Panels[2].Text := '';
    end;

  // MRU stuff
  if infImage.path <> '' then
    begin
    tbnLast.Enabled := not (mru.Count < 2);
    miLoadLast.Enabled := not (mru.Count < 2);
    end
  else
    begin
    tbnLast.Enabled := not (mru.Count < 1);
    miLoadLast.Enabled := not (mru.Count < 1);
    end;
end;

procedure TfrmMain.SetHintPanelText(new_text: string);
begin
  sbrMain.Panels[3].Text := new_text;
end;

procedure TfrmMain.dlgSaveTypeChange(Sender: TObject);
begin
  if ((dlgSave.FilterIndex - 1) < SaveExtensions.Count) then
    dlgSave.DefaultExt := SaveExtensions.Strings[dlgSave.FilterIndex - 1];
end;

procedure TfrmMain.imgDblClick(Sender: TObject);
begin
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

  if (ssShift in Shift) then
    begin
    // file navigation
    if up then
      GoPrev()
    else
      GoNext();
    end
  else
    begin
    // zooming
    SetDisplayStyleIfNeeded(dsNormal, true);

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
    OpenLocal(str);
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
      OpenLocal(S);
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

procedure TfrmMain.tbnRScanClick(Sender: TObject);
begin
  ExecuteRole(PR_SCAN);
end;

procedure TfrmMain.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  case Msg.CharCode of
    VK_RETURN, VK_BROWSER_REFRESH:
      begin
      if (GetDisplayStyle() = dsFit) then
        SetDisplayStyleIfNeeded(dsNormal)
      else if (GetDisplayStyle() = dsNormal) then
        SetDisplayStyleIfNeeded(dsFit);

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

    VK_BROWSER_STOP, VK_MEDIA_STOP:
      begin
      miFullScreenClick(Self);

      Handled := true;
      end;

    VK_F2:
      begin
      if (miEditor.Enabled and (not full_screen)) then
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

    VK_F8:
      begin
      if (GetDisplayStyle() = dsNormal) then
        begin
        if miSelectZoom in img.MouseInteract then
          img.MouseInteract := img.MouseInteract - [miSelectZoom]
        else
          img.MouseInteract := img.MouseInteract + [miSelectZoom];
        end;

      Handled := true;
      end;

    VK_F11:
      begin
      miFullScreenClick(Self);

      Handled := true;
      end;

    VK_UP:
      begin
      if (GetDisplayStyle() = dsFit) then
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
      if (GetDisplayStyle() = dsFit) then
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
      if (GetDisplayStyle() = dsFit) then
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
      if (GetDisplayStyle() = dsFit) then
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
