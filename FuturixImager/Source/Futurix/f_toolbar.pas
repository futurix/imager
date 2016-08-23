unit f_toolbar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ComCtrls, Dialogs,
  c_utils, c_const, c_reg;

const
  sAllButtons: string =
    'open,save,back,forward,loadlast,close,print,copy,paste,editor,prevpage,nextpage,' +
    'zoomin,zoomout,rotate90,rotateccw,zoom,z100,zwidth,zheight,dispopt,fs,info,random,' +
    'undo,fit,fdelete,fcopy,fmove,frename,first,last,show,opt,help,www,about,rscan,rcapt,' +
    'rjpeg,gopage';
  sDefaultToolbar: string =
    'open,loadlast,save,close,sep,print,sep,copy,paste,sep,editor,undo,' +
    'sep,zoomin,zoomout,sep,zoom,dispopt,fs,sep,info,sep,random,sep,back,forward';

procedure ApplyCustomToolbar(again: boolean = false);
procedure AddButton(code: string);
procedure AddButtonA(btn: TToolButton);
procedure HideButton(code: string);
procedure HideButtonA(btn: TToolButton);
procedure AddSeparator();
function ExpandSynName(code: string): string;
function CollapseSynName(code: string): string;


implementation

uses f_tools, w_main;

// applies custom toolbar
procedure ApplyCustomToolbar(again: boolean = false);
var
  tmp: string;
  tbr,total: TStringList;
  i, j: integer;
  btn: TToolButton;
begin
  // removing separators if needed
  if again then
    begin
    for i := (frmMain.itbMain.ButtonCount - 1) downto 0 do
      begin
      if (frmMain.itbMain.Buttons[i].Style = tbsSeparator) then
        begin
        btn := frmMain.itbMain.Buttons[i];
        frmMain.itbMain.RemoveControl(btn);
        FreeAndNil(btn);
        end;
      end;
    end;

  // getting current settings
  tmp := FxRegRStr('UI_ToolbarButtons', sDefaultToolbar);

  // setting total buttons list
  total := TStringList.Create();
  StrSplit(sAllButtons, ',', total);

  // string -> strings
  tbr := TStringList.Create();
  tbr.Sorted := false;
  StrSplit(tmp, ',', tbr);

  // applying
  for i := (tbr.Count-1) downto 0 do
    begin
    if (tbr[i] = 'sep') then
      AddSeparator()
    else
      begin
      AddButton(tbr[i]);
      j := total.IndexOf(tbr[i]);

      if (j <> -1) then
        total.Delete(j);
      end;
    end;

  // removing unused buttons
  for i := 0 to (total.Count-1) do
    HideButton(total[i]);

  // freeing
  FreeAndNil(tbr);
  FreeAndNil(total);

  // refresh
  frmMain.itbMain.Flat := false;
  frmMain.itbMain.Flat := true;
end;

// adds button
procedure AddButton(code: string);
begin
  if (code = 'open') then AddButtonA(frmMain.tbnOpen)
  else if (code = 'save') then AddButtonA(frmMain.tbnSave)
  else if (code = 'loadlast') then AddButtonA(frmMain.tbnLast)
  else if (code = 'close') then AddButtonA(frmMain.tbnClose)
  else if (code = 'print') then AddButtonA(frmMain.tbnPrint)
  else if (code = 'copy') then AddButtonA(frmMain.tbnCopy)
  else if (code = 'paste') then AddButtonA(frmMain.tbnPaste)
  else if (code = 'editor') then AddButtonA(frmMain.tbnEditor)
  else if (code = 'undo') then AddButtonA(frmMain.tbnUndo)
  else if (code = 'prevpage') then AddButtonA(frmMain.tbnMultiPrev)
  else if (code = 'nextpage') then AddButtonA(frmMain.tbnMultiNext)
  else if (code = 'zoomin') then AddButtonA(frmMain.tbnZoomIn)
  else if (code = 'zoomout') then AddButtonA(frmMain.tbnZoomOut)
  else if (code = 'rotate90') then AddButtonA(frmMain.tbnRotate)
  else if (code = 'zoom') then AddButtonA(frmMain.tbnZoomMisc)
  else if (code = 'fit') then AddButtonA(frmMain.tbnZoomFit)
  else if (code = 'dispopt') then AddButtonA(frmMain.tbnDisp)
  else if (code = 'fs') then AddButtonA(frmMain.tbnFullScreen)
  else if (code = 'info') then AddButtonA(frmMain.tbnInfo)
  else if (code = 'random') then AddButtonA(frmMain.tbnGoRandom)
  else if (code = 'back') then AddButtonA(frmMain.tbnGoBack)
  else if (code = 'forward') then AddButtonA(frmMain.tbnGoForward)
  else if (code = 'fdelete') then AddButtonA(frmMain.tbnFDelete)
  else if (code = 'fcopy') then AddButtonA(frmMain.tbnFCopy)
  else if (code = 'fmove') then AddButtonA(frmMain.tbnFMove)
  else if (code = 'frename') then AddButtonA(frmMain.tbnFRename)
  else if (code = 'z100') then AddButtonA(frmMain.tbnZoom100)
  else if (code = 'zwidth') then AddButtonA(frmMain.tbnZoomWidth)
  else if (code = 'zheight') then AddButtonA(frmMain.tbnZoomHeight)
  else if (code = 'rotateccw') then AddButtonA(frmMain.tbnRotateCCW)
  else if (code = 'first') then AddButtonA(frmMain.tbnGoFirst)
  else if (code = 'last') then AddButtonA(frmMain.tbnGoLast)
  else if (code = 'show') then AddButtonA(frmMain.tbnShow)
  else if (code = 'opt') then AddButtonA(frmMain.tbnOptions)
  else if (code = 'help') then AddButtonA(frmMain.tbnHelp)
  else if (code = 'www') then AddButtonA(frmMain.tbnOnline)
  else if (code = 'about') then AddButtonA(frmMain.tbnAbout)
  else if (code = 'rscan') then AddButtonA(frmMain.tbnRScan)
  else if (code = 'rcapt') then AddButtonA(frmMain.tbnRCapture)
  else if (code = 'rjpeg') then AddButtonA(frmMain.tbnRJPEG)
  else if (code = 'gopage') then AddButtonA(frmMain.tbnGoToPage);
end;

// actually moves button
procedure AddButtonA(btn: TToolButton);
begin
  btn.Left := 0;
  btn.Show();
end;

// hides button
procedure HideButton(code: string);
begin
  if (code = 'open') then HideButtonA(frmMain.tbnOpen)
  else if (code = 'save') then HideButtonA(frmMain.tbnSave)
  else if (code = 'loadlast') then HideButtonA(frmMain.tbnLast)
  else if (code = 'close') then HideButtonA(frmMain.tbnClose)
  else if (code = 'print') then HideButtonA(frmMain.tbnPrint)
  else if (code = 'copy') then HideButtonA(frmMain.tbnCopy)
  else if (code = 'paste') then HideButtonA(frmMain.tbnPaste)
  else if (code = 'editor') then HideButtonA(frmMain.tbnEditor)
  else if (code = 'undo') then HideButtonA(frmMain.tbnUndo)
  else if (code = 'prevpage') then HideButtonA(frmMain.tbnMultiPrev)
  else if (code = 'nextpage') then HideButtonA(frmMain.tbnMultiNext)
  else if (code = 'zoomin') then HideButtonA(frmMain.tbnZoomIn)
  else if (code = 'zoomout') then HideButtonA(frmMain.tbnZoomOut)
  else if (code = 'rotate90') then HideButtonA(frmMain.tbnRotate)
  else if (code = 'zoom') then HideButtonA(frmMain.tbnZoomMisc)
  else if (code = 'fit') then HideButtonA(frmMain.tbnZoomFit)
  else if (code = 'dispopt') then HideButtonA(frmMain.tbnDisp)
  else if (code = 'fs') then HideButtonA(frmMain.tbnFullScreen)
  else if (code = 'info') then HideButtonA(frmMain.tbnInfo)
  else if (code = 'random') then HideButtonA(frmMain.tbnGoRandom)
  else if (code = 'back') then HideButtonA(frmMain.tbnGoBack)
  else if (code = 'forward') then HideButtonA(frmMain.tbnGoForward)
  else if (code = 'fdelete') then HideButtonA(frmMain.tbnFDelete)
  else if (code = 'fcopy') then HideButtonA(frmMain.tbnFCopy)
  else if (code = 'fmove') then HideButtonA(frmMain.tbnFMove)
  else if (code = 'frename') then HideButtonA(frmMain.tbnFRename)
  else if (code = 'z100') then HideButtonA(frmMain.tbnZoom100)
  else if (code = 'zwidth') then HideButtonA(frmMain.tbnZoomWidth)
  else if (code = 'zheight') then HideButtonA(frmMain.tbnZoomHeight)
  else if (code = 'rotateccw') then HideButtonA(frmMain.tbnRotateCCW)
  else if (code = 'first') then HideButtonA(frmMain.tbnGoFirst)
  else if (code = 'last') then HideButtonA(frmMain.tbnGoLast)
  else if (code = 'show') then HideButtonA(frmMain.tbnShow)
  else if (code = 'opt') then HideButtonA(frmMain.tbnOptions)
  else if (code = 'help') then HideButtonA(frmMain.tbnHelp)
  else if (code = 'www') then HideButtonA(frmMain.tbnOnline)
  else if (code = 'about') then HideButtonA(frmMain.tbnAbout)
  else if (code = 'rscan') then HideButtonA(frmMain.tbnRScan)
  else if (code = 'rcapt') then HideButtonA(frmMain.tbnRCapture)
  else if (code = 'rjpeg') then HideButtonA(frmMain.tbnRJPEG)
  else if (code = 'gopage') then HideButtonA(frmMain.tbnGoToPage);
end;

procedure HideButtonA(btn: TToolButton);
begin
  btn.Hide();
end;

procedure AddSeparator();
var
  tmp: TToolButton;
begin
  tmp := TToolButton.Create(nil);
  tmp.Style := tbsSeparator;
  tmp.Width := 8;
  tmp.Parent := frmMain.itbMain;
  tmp.Left := 1;
end;

function ExpandSynName(code: string):string;
begin
  if (code = 'sep') then Result := 'Separator'
  else if (code = 'open') then Result := 'Open'
  else if (code = 'save') then Result := 'Save As'
  else if (code = 'loadlast') then Result := 'Load Last'
  else if (code = 'close') then Result := 'Close'
  else if (code = 'print') then Result := 'Print'
  else if (code = 'copy') then Result := 'Copy'
  else if (code = 'paste') then Result := 'Paste'
  else if (code = 'editor') then Result := 'Editor'
  else if (code = 'undo') then Result := 'Undo'
  else if (code = 'prevpage') then Result := 'Previous Page'
  else if (code = 'nextpage') then Result := 'Next Page'
  else if (code = 'zoomin') then Result := 'Zoom In'
  else if (code = 'zoomout') then Result := 'Zoom Out'
  else if (code = 'rotate90') then Result := 'Rotate'
  else if (code = 'zoom') then Result := 'Zoom'
  else if (code = 'fit') then Result := 'Zoom To Fit'
  else if (code = 'dispopt') then Result := 'Display Options'
  else if (code = 'fs') then Result := 'Full Screen'
  else if (code = 'info') then Result := 'Info'
  else if (code = 'random') then Result := 'Go Random'
  else if (code = 'back') then Result := 'Go Back'
  else if (code = 'forward') then Result := 'Go Forward'
  else if (code = 'fdelete') then Result := 'Delete File'
  else if (code = 'fcopy') then Result := 'Copy File'
  else if (code = 'fmove') then Result := 'Move File'
  else if (code = 'frename') then Result := 'Rename File'
  else if (code = 'z100') then Result := 'Zoom To 100%'
  else if (code = 'zwidth') then Result := 'Fit To Width'
  else if (code = 'zheight') then Result := 'Fit To Height'
  else if (code = 'rotateccw') then Result := 'Rotate CCW'
  else if (code = 'first') then Result := 'First'
  else if (code = 'last') then Result := 'Last'
  else if (code = 'show') then Result := 'Slide Show'
  else if (code = 'opt') then Result := 'Options'
  else if (code = 'help') then Result := 'Help'
  else if (code = 'www') then Result := 'WWW'
  else if (code = 'about') then Result := 'About'
  else if (code = 'rscan') then Result := 'Scan'
  else if (code = 'rcapt') then Result := 'Capture'
  else if (code = 'rjpeg') then Result := 'JPEG Lossless'
  else if (code = 'gopage') then Result := 'Go To Page'
  else Result := 'Separator';
end;

function CollapseSynName(code: string):string;
begin
  if (code = 'Separator') then Result := 'sep'
  else if (code = 'Open') then Result := 'open'
  else if (code = 'Save As') then Result := 'save'
  else if (code = 'Load Last') then Result := 'loadlast'
  else if (code = 'Close') then Result := 'close'
  else if (code = 'Print') then Result := 'print'
  else if (code = 'Copy') then Result := 'copy'
  else if (code = 'Paste') then Result := 'paste'
  else if (code = 'Editor') then Result := 'editor'
  else if (code = 'Undo') then Result := 'undo'
  else if (code = 'Previous Page') then Result := 'prevpage'
  else if (code = 'Next Page') then Result := 'nextpage'
  else if (code = 'Zoom In') then Result := 'zoomin'
  else if (code = 'Zoom Out') then Result := 'zoomout'
  else if (code = 'Rotate') then Result := 'rotate90'
  else if (code = 'Zoom') then Result := 'zoom'
  else if (code = 'Zoom To Fit') then Result := 'fit'
  else if (code = 'Display Options') then Result := 'dispopt'
  else if (code = 'Full Screen') then Result := 'fs'
  else if (code = 'Info') then Result := 'info'
  else if (code = 'Go Random') then Result := 'random'
  else if (code = 'Go Back') then Result := 'back'
  else if (code = 'Go Forward') then Result := 'forward'
  else if (code = 'Delete File') then Result := 'fdelete'
  else if (code = 'Copy File') then Result := 'fcopy'
  else if (code = 'Move File') then Result := 'fmove'
  else if (code = 'Rename File') then Result := 'frename'
  else if (code = 'Zoom To 100%') then Result := 'z100'
  else if (code = 'Fit To Width') then Result := 'zwidth'
  else if (code = 'Fit To Height') then Result := 'zheight'
  else if (code = 'Rotate CCW') then Result := 'rotateccw'
  else if (code = 'First') then Result := 'first'
  else if (code = 'Last') then Result := 'last'
  else if (code = 'Slide Show') then Result := 'show'
  else if (code = 'Options') then Result := 'opt'
  else if (code = 'Help') then Result := 'help'
  else if (code = 'WWW') then Result := 'www'
  else if (code = 'About') then Result := 'about'
  else if (code = 'Scan') then Result := 'rscan'
  else if (code = 'Capture') then Result := 'rcapt'
  else if (code = 'JPEG Lossless') then Result := 'rjpeg'
  else if (code = 'Go To Page') then Result := 'gopage'
  else Result := 'sep';
end;

end.
