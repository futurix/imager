unit f_toolbar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ComCtrls, Dialogs, c_utils, c_const, c_reg, c_locales;

const
	sAllButtons: string = 	'open,save,back,forward,loadlast,close,print,copy,paste,editor,prevpage,nextpage,' +
    						'zoomin,zoomout,rotate90,rotateccw,zoom,z100,zwidth,zheight,dispopt,nav,fs,info,random,' +
                            'undo,fit,fdelete,fcopy,fmove,frename,first,last,show,opt,help,www,about,rscan,rmail,rcapt,' +
                            'rjpeg,rhex,gopage';
    sDefaultToolbar: string = 	'open,loadlast,save,close,sep,print,sep,copy,paste,sep,editor,undo,' +
    							'sep,zoomin,zoomout,sep,zoom,dispopt,nav,fs,sep,info,sep,random,sep,back,forward';

procedure ApplyCustomToolbar(again: boolean = false);
procedure AddButton(code: string);
procedure AddButtonA(btn: TToolButton);
procedure HideButton(code: string);
procedure HideButtonA(btn: TToolButton);
procedure AddSeparator();
function  ExpandSynName(code: string):string;
function  CollapseSynName(code: string):string;


implementation

uses f_tools, main;

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
    tmp := FxRegRStr('MainToolbar', sDefaultToolbar);

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
    else if (code = 'rmail') then AddButtonA(frmMain.tbnRMail)
    else if (code = 'rcapt') then AddButtonA(frmMain.tbnRCapture)
    else if (code = 'rjpeg') then AddButtonA(frmMain.tbnRJPEG)
    else if (code = 'rhex') then AddButtonA(frmMain.tbnRHEX)
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
    else if (code = 'rmail') then HideButtonA(frmMain.tbnRMail)
    else if (code = 'rcapt') then HideButtonA(frmMain.tbnRCapture)
    else if (code = 'rjpeg') then HideButtonA(frmMain.tbnRJPEG)
    else if (code = 'rhex') then HideButtonA(frmMain.tbnRHEX)
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
    if (code = 'sep') then Result := LoadLStr(3502)
	else if (code = 'open') then Result := LoadLStr(502)
	else if (code = 'save') then Result := LoadLStr(506)
    else if (code = 'loadlast') then Result := LoadLStr(504)
    else if (code = 'close') then Result := LoadLStr(508)
    else if (code = 'print') then Result := LoadLStr(510)
    else if (code = 'copy') then Result := LoadLStr(512)
    else if (code = 'paste') then Result := LoadLStr(514)
   	else if (code = 'editor') then Result := LoadLStr(534)
    else if (code = 'undo') then Result := LoadLStr(540)
   	else if (code = 'prevpage') then Result := LoadLStr(516)
    else if (code = 'nextpage') then Result := LoadLStr(518)
    else if (code = 'zoomin') then Result := LoadLStr(522)
    else if (code = 'zoomout') then Result := LoadLStr(524)
    else if (code = 'rotate90') then Result := LoadLStr(526)
    else if (code = 'zoom') then Result := LoadLStr(528)
    else if (code = 'fit') then Result := LoadLStr(544)
    else if (code = 'dispopt') then Result := LoadLStr(530)
    else if (code = 'fs') then Result := LoadLStr(532)
    else if (code = 'info') then Result := LoadLStr(520)
    else if (code = 'random') then Result := LoadLStr(542)
    else if (code = 'back') then Result := LoadLStr(536)
    else if (code = 'forward') then Result := LoadLStr(538)
    else if (code = 'fdelete') then Result := LoadLStr(548)
    else if (code = 'fcopy') then Result := LoadLStr(550)
    else if (code = 'fmove') then Result := LoadLStr(552)
    else if (code = 'frename') then Result := LoadLStr(554)
    else if (code = 'z100') then Result := LoadLStr(556)
    else if (code = 'zwidth') then Result := LoadLStr(558)
    else if (code = 'zheight') then Result := LoadLStr(560)
    else if (code = 'rotateccw') then Result := LoadLStr(562)
    else if (code = 'first') then Result := LoadLStr(564)
    else if (code = 'last') then Result := LoadLStr(566)
    else if (code = 'show') then Result := LoadLStr(568)
    else if (code = 'opt') then Result := LoadLStr(570)
    else if (code = 'help') then Result := LoadLStr(572)
    else if (code = 'www') then Result := LoadLStr(574)
    else if (code = 'about') then Result := LoadLStr(576)
    else if (code = 'rscan') then Result := LoadLStr(578)
    else if (code = 'rmail') then Result := LoadLStr(580)
    else if (code = 'rcapt') then Result := LoadLStr(582)
    else if (code = 'rjpeg') then Result := LoadLStr(584)
    else if (code = 'rhex') then Result := LoadLStr(586)
    else if (code = 'gopage') then Result := LoadLStr(590)
    else Result := LoadLStr(3502);
end;

function CollapseSynName(code: string):string;
begin
    if (code = LoadLStr(3502)) then Result := 'sep'
	else if (code = LoadLStr(502)) then Result := 'open'
	else if (code = LoadLStr(506)) then Result := 'save'
    else if (code = LoadLStr(504)) then Result := 'loadlast'
    else if (code = LoadLStr(508)) then Result := 'close'
    else if (code = LoadLStr(510)) then Result := 'print'
    else if (code = LoadLStr(512)) then Result := 'copy'
    else if (code = LoadLStr(514)) then Result := 'paste'
   	else if (code = LoadLStr(534)) then Result := 'editor'
    else if (code = LoadLStr(540)) then Result := 'undo'
   	else if (code = LoadLStr(516)) then Result := 'prevpage'
    else if (code = LoadLStr(518)) then Result := 'nextpage'
    else if (code = LoadLStr(522)) then Result := 'zoomin'
    else if (code = LoadLStr(524)) then Result := 'zoomout'
    else if (code = LoadLStr(526)) then Result := 'rotate90'
    else if (code = LoadLStr(528)) then Result := 'zoom'
    else if (code = LoadLStr(544)) then Result := 'fit'
    else if (code = LoadLStr(530)) then Result := 'dispopt'
    else if (code = LoadLStr(532)) then Result := 'fs'
    else if (code = LoadLStr(520)) then Result := 'info'
    else if (code = LoadLStr(542)) then Result := 'random'
    else if (code = LoadLStr(536)) then Result := 'back'
    else if (code = LoadLStr(538)) then Result := 'forward'
    else if (code = LoadLStr(548)) then Result := 'fdelete'
    else if (code = LoadLStr(550)) then Result := 'fcopy'
    else if (code = LoadLStr(552)) then Result := 'fmove'
    else if (code = LoadLStr(554)) then Result := 'frename'
    else if (code = LoadLStr(556)) then Result := 'z100'
    else if (code = LoadLStr(558)) then Result := 'zwidth'
    else if (code = LoadLStr(560)) then Result := 'zheight'
    else if (code = LoadLStr(562)) then Result := 'rotateccw'
    else if (code = LoadLStr(564)) then Result := 'first'
    else if (code = LoadLStr(566)) then Result := 'last'
    else if (code = LoadLStr(568)) then Result := 'show'
    else if (code = LoadLStr(570)) then Result := 'opt'
    else if (code = LoadLStr(572)) then Result := 'help'
    else if (code = LoadLStr(574)) then Result := 'www'
    else if (code = LoadLStr(576)) then Result := 'about'
    else if (code = LoadLStr(578)) then Result := 'rscan'
    else if (code = LoadLStr(580)) then Result := 'rmail'
    else if (code = LoadLStr(582)) then Result := 'rcapt'
    else if (code = LoadLStr(584)) then Result := 'rjpeg'
    else if (code = LoadLStr(586)) then Result := 'rhex'
    else if (code = LoadLStr(590)) then Result := 'gopage'
    else Result := 'sep';
end;

end.
