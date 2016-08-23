unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ToolWin, ImgList, ExtCtrls, ShellAPI, Registry, FileFind,
  MRUfiles, futuris_dlgopen, c_const, c_pos, c_reg, AgOpenDialog;

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
    mSettings: TMenuItem;
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
    N8: TMenuItem;
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
    miBack: TMenuItem;
    miForward: TMenuItem;
    N12: TMenuItem;
    miFileManager: TMenuItem;
    N14: TMenuItem;
    miRevert: TMenuItem;
    miApplyChanges: TMenuItem;
    miInfo: TMenuItem;
    miSettings: TMenuItem;
    miFileFormats: TMenuItem;
    miHelpContents: TMenuItem;
    N18: TMenuItem;
    miAbout: TMenuItem;
    dlgSave: TSaveDialog;
    imlMain: TImageList;
    tbrMain: TToolBar;
    tbnOpen: TToolButton;
    sbxMain: TScrollBox;
    imgMain: TImage;
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
    tbnZoom: TToolButton;
    piTBMain: TMenuItem;
    tbnSave: TToolButton;
    tbnClose: TToolButton;
    tbnPrint: TToolButton;
    Sep_2: TToolButton;
    tbnCopy: TToolButton;
    tbnPaste: TToolButton;
    Sep_3: TToolButton;
    tbnFullScreen: TToolButton;
    tbnFileBrowser: TToolButton;
    tbnInfo: TToolButton;
    Sep_5: TToolButton;
    tbnBack: TToolButton;
    tbnForward: TToolButton;
    N9: TMenuItem;
    miZoomtoFit: TMenuItem;
    piStatusBar: TMenuItem;
    mRecent: TMenuItem;
    miClearHistory: TMenuItem;
    NRecent: TMenuItem;
    MRU: TMRUFiles;
    miClearClipboard: TMenuItem;
    N5: TMenuItem;
    dlgOpen: TFuturisOpenDialog;
    N2: TMenuItem;
    miScan: TMenuItem;
    mToolbars: TMenuItem;
    N11: TMenuItem;
    Sep_7: TToolButton;
    tbnHelp: TToolButton;
    tbnAbout: TToolButton;
    dlgInstPlug: TOpenDialog;
    tbnFilters: TToolButton;
    miFiltersDialog: TMenuItem;
    tbrMulti: TToolBar;
    tbrAnim: TToolBar;
    tbnPlay: TToolButton;
    tbnMultiFirst: TToolButton;
    tbnPause: TToolButton;
    tbnStop: TToolButton;
    tbnMultiPrev: TToolButton;
    tbnMultiNext: TToolButton;
    tbnMultiLast: TToolButton;
    MSep_1: TToolButton;
    tbnExtractPage: TToolButton;
    tbnGoToPage: TToolButton;
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
    mOpenSpecial: TMenuItem;
    miOpenStill: TMenuItem;
    miOpenAnim: TMenuItem;
    miOpenMulti: TMenuItem;
    N23: TMenuItem;
    Sep_9: TToolButton;
    miPrintPreview: TMenuItem;
    tbnShow: TToolButton;
    Sep_8: TToolButton;
    N29: TMenuItem;
    miShow: TMenuItem;
    miStartSlideShow: TMenuItem;
    tbnLast: TToolButton;
    N30: TMenuItem;
    miNew: TMenuItem;
    tbnHome: TToolButton;
    piZM75: TMenuItem;
    piZM150: TMenuItem;
    miZM75: TMenuItem;
    miZM150: TMenuItem;
    tbnZoomFit: TToolButton;
    tbnZoomOrig: TToolButton;
    sbrMain: TStatusBar;
    miCleanUp: TMenuItem;
    tbnFav: TToolButton;
    miFavorites: TMenuItem;
    Sep_10: TToolButton;
    miFuturisWebSite: TMenuItem;
    N16: TMenuItem;
    N24: TMenuItem;
    miFDelete: TMenuItem;
    miFCopy: TMenuItem;
    miFRename: TMenuItem;
    miFMove: TMenuItem;
    N34: TMenuItem;
    miZoomTFoL: TMenuItem;
    N3: TMenuItem;
    N13: TMenuItem;
    Sep_12: TToolButton;
    N20: TMenuItem;
    imlDisabled: TImageList;
    pnlDock: TPanel;
    splSide: TSplitter;
    piCustomZoom: TMenuItem;
    mTricks: TMenuItem;
    N4: TMenuItem;

{>} procedure Initialize();
    procedure ShutDown();
{>} procedure HandleFIPISimport(Sender: TObject);
    procedure HandleFIPISexport(Sender: TObject);
    procedure HandleFIPISfilter(Sender: TObject);
    procedure HandleFIPIStool(Sender: TObject);
{>} procedure DragNDrop(var msg: TWMDropFiles); message WM_DropFiles;
{>} procedure miAboutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miHelpContentsClick(Sender: TObject);
    procedure miOpenClick(Sender: TObject);
    procedure miReopenClick(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure miSaveAsClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure miFileManagerClick(Sender: TObject);
    procedure miCopyClick(Sender: TObject);
    procedure miPasteClick(Sender: TObject);
    procedure miFullScreenClick(Sender: TObject);
    procedure miBackClick(Sender: TObject);
    procedure miForwardClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
    procedure miZoomtoFitClick(Sender: TObject);
    procedure MRUClick(Sender: TObject; FileName: String);
    procedure miClearHistoryClick(Sender: TObject);
    procedure miSettingsClick(Sender: TObject);
    procedure miFileFormatsClick(Sender: TObject);
    procedure miApplyChangesClick(Sender: TObject);
    procedure miRevertClick(Sender: TObject);
    procedure miToolbarClick(Sender: TObject);
    procedure miStatusBarClick(Sender: TObject);
    procedure miClearClipboardClick(Sender: TObject);
    procedure dlgOpenPreview(Sender: TFuturisOpenDialog; Ext: String);
    procedure dlgOpenFolderChange(Sender: TObject);
    procedure piMinimizeClick(Sender: TObject);
    procedure miInfoClick(Sender: TObject);
    procedure miScanClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure appHint(Sender: TObject);
    procedure appIdle(Sender: TObject; var Done: Boolean);
    procedure appIdleFirst(Sender: TObject; var Done: Boolean);
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
    procedure miOpenStillClick(Sender: TObject);
    procedure miOpenAnimClick(Sender: TObject);
    procedure miOpenMultiClick(Sender: TObject);
    procedure miPrintPreviewClick(Sender: TObject);
    procedure miThumbClick(Sender: TObject);
    procedure miShowClick(Sender: TObject);
    procedure miStartSlideShowClick(Sender: TObject);
    procedure tbnLastClick(Sender: TObject);
    procedure miNewClick(Sender: TObject);
    procedure sbxMainContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure imgMainContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure imgMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMainMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure tbnPrintClick(Sender: TObject);
    procedure miCleanUpClick(Sender: TObject);
    procedure miFavoritesClick(Sender: TObject);
    procedure miFuturisWebSiteClick(Sender: TObject);
    procedure miFCopyClick(Sender: TObject);
    procedure miFDeleteClick(Sender: TObject);
    procedure miFMoveClick(Sender: TObject);
    procedure miFRenameClick(Sender: TObject);
    procedure miZoomTFoLClick(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

resourcestring
  rsSuppExtStatusYes = 'Supported: yes';
  rsSuppExtStatusNo = 'Supported: no';
  rsFileTypeUnknown = 'Unknown file type';
  rsNoSizeAvailable = 'No size available';

var
  frmMain: TfrmMain;

implementation

uses w_about, w_custzoom, w_setup, w_formats, w_info,
     f_debug, globals, f_global, f_ui, f_external,
     f_clipboard, f_system, f_nav, f_images, f_plugins, f_tools,
     f_graphics, f_filectrl, f_strutils, f_frmman, f_anim,
     f_multi, w_show, f_reg;

{$R *.DFM}

{*********** generic procedures ************************************}

// program start-up
procedure TfrmMain.Initialize();
begin
// setting app events
Application.OnHint:=appHint;
Application.OnIdle:=appIdleFirst;

// setting common variables
files:=TStringList.Create();

// setting registry
reg:=TFuturisRegistry.Create();
reg.RootKey:=HKEY_CURRENT_USER;

// main stuff
DragAcceptFiles(frmMain.Handle,true);
StartUpChecks();
IMGtune();

// more
RestoreWindowState(frmMain,reg,sReg + '\Position\Main',14,614,11,411,2,3);
ReadSettings();
CheckFolderDependancies();
CheckLibrariesDependancies();
InstallPlugIns();

// final
Able(false);
CommandLine();
end;

// program shut down
procedure TfrmMain.ShutDown();
begin
c_pos.SaveWindowState(frmMain,reg,sReg + '\Position\Main');
SaveSettings();

// shutting down registry
reg.Free();
end;

{*********** FIPIS handlers ***********************************}

// FIPISimport handler
procedure TfrmMain.HandleFIPISimport(Sender: TObject);
var
  FIPISimport: TFIPISimport;
  lib: THandle;
  func_result: hBitmap;
begin
try
  reg.OpenKey(sModules + '\Import',true);
  lib:=LoadLibrary(PChar(GetAppFolder() + 'plugins\' + reg.RStr(StripHotKey(TMenuItem(Sender).Caption),'')));
  reg.CloseKey();
  if lib=0 then
    Report('Cannot load import DLL!',2)
  else
    begin
    @FIPISimport:=GetProcAddress(lib,'FIPISimport');
    if not (@FIPISimport=nil) then
      begin
      func_result:=FIPISimport(PChar(StripHotKey(TMenuItem(Sender).Caption)),Application.Handle,frmMain.Handle);
      if func_result<>0 then
        begin
        // start working with result
        OpenUntitled(nil,func_result);
        end;
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
  reg.OpenKey(sModules + '\Export',true);
  lib:=LoadLibrary(PChar(GetAppFolder() + 'plugins\' + reg.RStr(StripHotKey(TMenuItem(Sender).Caption),'')));
  reg.CloseKey();
  if lib=0 then
    Report('Cannot load export DLL!',2)
  else
    begin
    img:=TBitmap.Create();
    img.Assign(infImage.original);
    img.PixelFormat:=pf24bit;
    @FIPISexport:=GetProcAddress(lib,'FIPISexport');
    if not (@FIPISexport=nil) then
      FIPISexport(PChar(StripHotKey(TMenuItem(Sender).Caption)),Application.Handle,frmMain.Handle,img.Handle);
    FreeLibrary(lib);
    img.Free();
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
reg.OpenKey(sModules + '\Tools',true);
lib:=LoadLibrary(PChar(GetAppFolder() + 'plugins\' + reg.RStr(StripHotKey(TMenuItem(Sender).Caption),'')));
reg.CloseKey();
if lib=0 then
  Report('Cannot load tool DLL!',2)
else
  begin
  @FIPIStool:=GetProcAddress(lib,'FIPIStool');
  if not (@FIPIStool=nil) then
    begin
    img:=TBitmap.Create();
    img.Assign(infImage.original);
    img.PixelFormat:=pf24bit;
    try
      func_result:=FIPIStool(PChar(StripHotKey(TMenuItem(Sender).Caption)),PChar(infImage.path),Application.Handle,frmMain.Handle,img.ReleaseHandle());
      if func_result<>0 then
        begin
        // start working with result
        OpenUntitled(nil,func_result);
        end;
    except
    end;
    img.Free();
    end;
  FreeLibrary(lib);
  end;
finally
end;
end;

{*********** drag-n-drop handler ******************************}

// drag-n-drop support
procedure TfrmMain.DragNDrop(var msg: TWMDropFiles);
var
  fName: array[0..255] of char;
  i,n: integer;
begin
n:=DragQueryFile(msg.Drop,$FFFFFFFF,nil,0);
for i:=0 to (n-1) do
  begin
  if i=0 then
    begin
    DragQueryFile(msg.Drop,i,fName,256);
    Load(fName);
    end
  else
    begin
    DragQueryFile(msg.Drop,i,fName,256);
    ShellExecute(0,'open',fName,nil,nil,SW_SHOWNORMAL);
    end;
  end;
DragFinish(msg.Drop);
end;

{*******************************************************************}

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

procedure TfrmMain.miHelpContentsClick(Sender: TObject);
begin
ExecInFolder('imager.chm');
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

procedure TfrmMain.miFileManagerClick(Sender: TObject);
begin
ShowFiles();
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

procedure TfrmMain.miBackClick(Sender: TObject);
begin
if HiWord(GetKeyState(VK_SHIFT))<>0 then
  GoFirst()
else
  GoPrev();
end;

procedure TfrmMain.miForwardClick(Sender: TObject);
begin
if HiWord(GetKeyState(VK_SHIFT))<>0 then
  GoLast()
else
  GoNext();
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  msg: TWMKey;
begin
msg.CharCode:=Key;
if not mnuMain.IsShortCut(msg) then
  begin
  // keys manager
  case Key of
    VK_ADD: ZoomIn();
    VK_SUBTRACT: ZoomOut();

    // scrolling
    VK_UP: if (ssShift in Shift) then Scroll(0) else Scroll(0,10);
    VK_DOWN: if (ssShift in Shift) then Scroll(1) else Scroll(1,10);
    VK_LEFT: if (ssShift in Shift) then Scroll(2) else Scroll(2,10);
    VK_RIGHT: if (ssShift in Shift) then Scroll(3) else Scroll(3,10);

    // directory navigation
    VK_INSERT: if (ssShift in Shift) then GoFirst() else GoPrev();
    VK_HOME: if (ssShift in Shift) then GoLast() else GoNext();
    VK_SPACE: if (ssShift in Shift) then GoLast() else GoNext();
    VK_BACK: if (ssShift in Shift) then GoFirst() else GoPrev();

    // paging
    VK_PRIOR: Page(0);
    VK_NEXT: Page(1);
    VK_END: Page(2);
    VK_DELETE: Page(3);
    end;
  end;
end;

procedure TfrmMain.miPrintClick(Sender: TObject);
begin
PrintImage(true);
end;

procedure TfrmMain.miZM12Click(Sender: TObject);
begin
Zoom(0.12);
end;

procedure TfrmMain.miZM25Click(Sender: TObject);
begin
Zoom(0.25);
end;

procedure TfrmMain.miZM50Click(Sender: TObject);
begin
Zoom(0.5);
end;

procedure TfrmMain.miZM75Click(Sender: TObject);
begin
Zoom(0.75);
end;

procedure TfrmMain.miZM100Click(Sender: TObject);
begin
Zoom(1);
end;

procedure TfrmMain.miZM150Click(Sender: TObject);
begin
Zoom(1.5);
end;

procedure TfrmMain.miZM200Click(Sender: TObject);
begin
Zoom(2);
end;

procedure TfrmMain.miZM400Click(Sender: TObject);
begin
Zoom(4);
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

procedure TfrmMain.miZoomtoFitClick(Sender: TObject);
begin
ZoomToFit();
end;

procedure TfrmMain.MRUClick(Sender: TObject; FileName: String);
begin
if FileExists(FileName) then Load(FileName);
end;

procedure TfrmMain.miClearHistoryClick(Sender: TObject);
begin
MRU.Files.Clear();
end;

procedure TfrmMain.miSettingsClick(Sender: TObject);
begin
ShowSettings();
end;

procedure TfrmMain.miFileFormatsClick(Sender: TObject);
begin
ShowFormats();
end;

procedure TfrmMain.miApplyChangesClick(Sender: TObject);
begin
ApplyChanges();
end;

procedure TfrmMain.miRevertClick(Sender: TObject);
begin
RestoreOriginal();
end;

procedure TfrmMain.miToolbarClick(Sender: TObject);
begin
ToggleMainToolbar();
end;

procedure TfrmMain.miStatusBarClick(Sender: TObject);
begin
ToggleStatusBar();
end;

procedure TfrmMain.miClearClipboardClick(Sender: TObject);
begin
CBClear();
end;

procedure TfrmMain.dlgOpenPreview(Sender: TFuturisOpenDialog; Ext: String);
var
  bmp: hBitmap;
  img: TBitmap;
  right, bottom, top, left: integer;
  scale: double;
begin
// preview event for Adv.Open
bmp:=DoImageLoad(Sender.FileName);
if bmp<>0 then
  begin
  img:=TBitmap.Create();
  img.Handle:=bmp;
  // starting count best fit
  if img.Width>=img.Height then
    begin
    // width bigger
    right:=150;
    scale:=img.Width/right;
    bottom:=Round(img.Height/scale);
    left:=0;
    top:=Round((150-bottom)/2);
    bottom:=bottom+top;
    end
  else
    begin
    // height bigger
    bottom:=150;
    scale:=img.Height/bottom;
    right:=Round(img.Width/scale);
    top:=0;
    left:=Round((150-right)/2);
    right:=right+left;
    end;
  // end counting best fit
  Sender.PreviewImage.Canvas.Brush.Color:=clWhite;
  Sender.PreviewImage.Canvas.FillRect(Sender.PreviewImage.Canvas.ClipRect);
  Sender.PreviewImage.Canvas.StretchDraw(Rect(left,top,right,bottom),img);
  // filling information
  Sender.Size.Caption:='Size: ' + IntToStr(img.Width) + ' x ' + IntToStr(img.Height);
  img.Free();
  end
else
  begin
  Sender.PreviewImage.Canvas.Brush.Color:=clWhite;
  Sender.PreviewImage.Canvas.FillRect(Sender.PreviewImage.Canvas.ClipRect);
  Sender.Size.Caption:=rsNoSizeAvailable;
  end;

// support info
Sender.Name.Caption:='File: ' + ExtractFileName(Sender.FileName);

// getting file type
Sender.FileType.Caption:=('Type: ' + GetTypeString(Ext,rsFileTypeUnknown));

// is supported ?
if SupportedExt(Ext) then Sender.Support.Caption:=rsSuppExtStatusYes else Sender.Support.Caption:=rsSuppExtStatusNo;
end;

procedure TfrmMain.dlgOpenFolderChange(Sender: TObject);
begin
TFuturisOpenDialog(Sender).PreviewImage.Canvas.Brush.Color:=clWhite;
TFuturisOpenDialog(Sender).PreviewImage.Canvas.FillRect(TFuturisOpenDialog(Sender).PreviewImage.Canvas.ClipRect);
TFuturisOpenDialog(Sender).Size.Caption:='';
TFuturisOpenDialog(Sender).FileType.Caption:='';
TFuturisOpenDialog(Sender).Support.Caption:='';
TFuturisOpenDialog(Sender).Name.Caption:='';
end;

procedure TfrmMain.piMinimizeClick(Sender: TObject);
begin
Application.Minimize();
end;

procedure TfrmMain.miInfoClick(Sender: TObject);
begin
ShowInfo();
end;

procedure TfrmMain.miScanClick(Sender: TObject);
begin
PlugScan();
UpdatePlugIns();
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

procedure TfrmMain.appIdleFirst(Sender: TObject; var Done: Boolean);
begin
// command line handling
if ((soDirAsParam in infSettings.showparams) or (soSlideShow in infSettings.showparams)) then
  ProcessStartUp();

// simple idle
IdleUI();

// switching
Application.OnIdle:=appIdle;
end;

procedure TfrmMain.miZM6Click(Sender: TObject);
begin
Zoom(0.06);
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

procedure TfrmMain.miOpenStillClick(Sender: TObject);
begin
if dlgOpen.Execute then
  begin
  if FileExists(dlgOpen.FileName) then
    OpenLocal(dlgOpen.FileName);
  end;
end;

procedure TfrmMain.miOpenAnimClick(Sender: TObject);
var
  dlg: TFuturisOpenDialog;
  h, d: TStringList;
  i: integer;
  s, t_d: string;
begin
dlg:=TFuturisOpenDialog.Create(frmMain);
dlg.OnPreview:=dlgOpenPreview;
dlg.OnFolderChange:=dlgOpenFolderChange;

// filling filter
h:=TStringList.Create();
d:=TStringList.Create();
s:='';
reg.OpenKey(sModules + '\Anim',true);
reg.GetValueNames(h);
reg.CloseKey();
reg.OpenKey(sModules + '\Descr',true);
reg.GetValueNames(d);
if h.Count>0 then
  begin
  for i:=0 to (h.Count-1) do
    begin
    t_d:=reg.RStr(h.Strings[i],'');
    if t_d='' then
      t_d:=('*.'+h.Strings[i]);
    s:= s + t_d + '|' + '*.' + h.Strings[i];
    if i<>(h.Count-1)
      then s:=s+'|';
    end;
  reg.CloseKey();
  s:=(s + '|All files (*.*)|*.*');
  dlg.Filter:=s;
  dlg.Title:='Open animated image ...';

  // loading
  if dlg.Execute then
    begin
    if FileExists(dlg.FileName) then
      OpenAnim(dlg.FileName);
    end;
  end;
h.Free();
d.Free();
dlg.Free();
end;

procedure TfrmMain.miOpenMultiClick(Sender: TObject);
var
  dlg: TFuturisOpenDialog;
  h, d: TStringList;
  i: integer;
  s, t_d: string;
begin
dlg:=TFuturisOpenDialog.Create(frmMain);
dlg.OnPreview:=dlgOpenPreview;
dlg.OnFolderChange:=dlgOpenFolderChange;
// filling filter
h:=TStringList.Create();
d:=TStringList.Create();
s:='';
reg.OpenKey(sModules + '\Multi',true);
reg.GetValueNames(h);
reg.CloseKey();
reg.OpenKey(sModules + '\Descr',true);
reg.GetValueNames(d);
if h.Count>0 then
  begin
  for i:=0 to (h.Count-1) do
    begin
    t_d:=reg.RStr(h.Strings[i],'');
    if t_d='' then
      t_d:=('*.'+h.Strings[i]);
    s:= s + t_d + '|' + '*.' + h.Strings[i];
    if i<>(h.Count-1) then
      s:=s+'|';
    end;
  reg.CloseKey();
  s:=(s + '|All files (*.*)|*.*');
  dlg.Filter:=s;
  dlg.Title:='Open multi-page image ...';

  // loading
  if dlg.Execute then
    begin
    if FileExists(dlg.FileName) then
      OpenMulti(dlg.FileName);
    end;
  end;
h.Free();
d.Free();
dlg.Free();
end;

procedure TfrmMain.miPrintPreviewClick(Sender: TObject);
begin
PrintImage(false);
end;

procedure TfrmMain.miThumbClick(Sender: TObject);
begin
ShowThumb();
if ((infImage.file_type=ftNone) and (HiWord(GetKeyState(VK_SHIFT))=0)) then
  Close();
end;

procedure TfrmMain.miShowClick(Sender: TObject);
begin
ShowShow();
end;

procedure TfrmMain.miStartSlideShowClick(Sender: TObject);
begin
ShowShow();
if Assigned(frmShow) then frmShow.tbnStart.Click();
end;

procedure TfrmMain.tbnLastClick(Sender: TObject);
begin
if infImage.path<>'' then
  begin
  if MRU.Files.Count>=2 then
    Load(MRU.Files[1]);
  end
else
  begin
  if MRU.Files.Count>=1 then
    Load(MRU.Files[0]);
  end;
end;

procedure TfrmMain.miNewClick(Sender: TObject);
begin
ShowNew();
end;

procedure TfrmMain.sbxMainContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
if HiWord(GetKeyState(VK_SHIFT))<>0 then
  begin
  Handled:=true;
  popZoom.TrackButton:=tbRightButton;
  popZoom.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
  popZoom.TrackButton:=tbLeftButton;
  end;
end;

procedure TfrmMain.imgMainContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
if HiWord(GetKeyState(VK_SHIFT))<>0 then
  begin
  Handled:=true;
  popZoom.TrackButton:=tbRightButton;
  popZoom.Popup(Mouse.CursorPos.x,Mouse.CursorPos.y);
  popZoom.TrackButton:=tbLeftButton;
  end;
end;

procedure TfrmMain.imgMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if infMouse.handy then
  begin
  infMouse.x:=X;
  infMouse.y:=Y;
  end;
end;

procedure TfrmMain.imgMainMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
if infMouse.handy then
  begin
  if ssLeft in Shift then
    sbxMain.HorzScrollBar.Position:=sbxMain.HorzScrollBar.Position-(X-infMouse.x);
  if ssLeft in Shift then
    sbxMain.VertScrollBar.Position:=sbxMain.VertScrollBar.Position-(Y-infMouse.y);
  end;
end;

procedure TfrmMain.tbnPrintClick(Sender: TObject);
begin
if HiWord(GetKeyState(VK_SHIFT))<>0 then PrintImage(true)
  else PrintImage();
end;

procedure TfrmMain.miCleanUpClick(Sender: TObject);
begin
miClearHistoryClick(frmMain);
dlgOpen.InitialDir:='';
reg.OpenKey(sReg + '\Main',true);
reg.WriteString('OpenPath','');
reg.CloseKey();
reg.OpenKey(sReg + '\Browser',true);
reg.WriteString('LastDir','');
reg.CloseKey();
end;

procedure TfrmMain.miFavoritesClick(Sender: TObject);
begin
ShowFavs();
end;

procedure TfrmMain.miFuturisWebSiteClick(Sender: TObject);
begin
ExecInFolder('imager.html');
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

procedure TfrmMain.miZoomTFoLClick(Sender: TObject);
begin
if (opZoomOnLoad in infSettings.options) then
  begin
  Exclude(infSettings.options,opZoomOnLoad);
  miZoomTFoL.Checked:=false;
  end
else
  begin
  Include(infSettings.options,opZoomOnLoad);
  miZoomTFoL.Checked:=true;
  end;
end;

procedure TfrmMain.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
// scrolled by mouse wheel down
Handled:=true;

// starting
if (ssShift in Shift) then
  Scroll(3,40)
else if (ssCtrl in Shift) then
  Scroll(1,80)
else if (ssAlt in Shift) then
  Scroll(3,80)
else
  Scroll(1,40);
end;

procedure TfrmMain.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
// scrolled by mouse wheel up
Handled:=true;

// starting
if (ssShift in Shift) then
  Scroll(2,40)
else if (ssCtrl in Shift) then
  Scroll(0,80)
else if (ssAlt in Shift) then
  Scroll(2,80)
else
  Scroll(0,40);
end;

end.
