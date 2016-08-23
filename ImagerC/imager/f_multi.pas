// multi-page functions
unit f_multi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Dialogs, Controls, Forms, IniFiles;

function IsMulti(ext: string):boolean;
procedure OpenMulti(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
procedure MGoToPage(index: integer);
procedure MPage();
procedure MGoFirst();
procedure MGoPrev();
procedure MGoNext();
procedure MGoLast();
procedure MExtract();
procedure CloseMulti();

implementation

uses globals, fipis, f_reg, f_debug, f_ui, f_strutils, f_tools,
     f_graphics, f_nav, main;

// is multipage
function IsMulti(ext: string):boolean;
begin
reg.OpenKey(sFIPIS + '\Multi',true);
if RegReadStr(ext,'')<>'' then Result:=true else Result:=false;
reg.CloseKey();
end;

// opens multi-page image
procedure OpenMulti(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
begin
if not FileExists(path) then begin
                             FileNotFound(path);
                             Abort();
                             end;
// loading dll and settings
reg.OpenKey(sFIPIS + '\Multi',true);
infMulti.lib:=LoadLibrary(PChar(GetAppFolder() + 'plugins\' + RegReadStr(GetExt(path),'')));
reg.CloseKey();
if infMulti.lib<>0 then begin
                        @infMulti.FIPISmultiInit:=GetProcAddress(infMulti.lib,'FIPISmultiInit');
                        @infMulti.FIPISmultiGetPages:=GetProcAddress(infMulti.lib,'FIPISmultiGetPages');
                        @infMulti.FIPISmultiGetPage:=GetProcAddress(infMulti.lib,'FIPISmultiGetPage');
                        @infMulti.FIPISmultiDeInit:=GetProcAddress(infMulti.lib,'FIPISmultiDeInit');
                        if ((@infMulti.FIPISmultiInit<>nil) and
                            (@infMulti.FIPISmultiGetPages<>nil) and
                            (@infMulti.FIPISmultiGetPage<>nil) and
                            (@infMulti.FIPISmultiDeInit<>nil)) then begin
                                                                    // settings
                                                                    if infMulti.FIPISmultiInit(PChar(path),PChar(GetExt(path)),Application.Handle)=0
                                                                       then begin
                                                                            CloseMulti();
                                                                            FileNotFound(path);
                                                                            Exit;
                                                                            end;
                                                                    infMulti.pages:=infMulti.FIPISmultiGetPages();
                                                                    if infMulti.pages=1 then begin
                                                                                             CloseMulti();
                                                                                             OpenLocal(path, add_to_mru, same_folder);
                                                                                             Abort();
                                                                                             end;
                                                                    infMulti.page:=0;
                                                                    FillImage(path,'',ftLocal,itMulti);
                                                                    // tuning UI
                                                                    if add_to_mru then frmMain.MRU.Add(path);
                                                                    if same_folder=false then ScanFolder(path) else FindFileNumber();
                                                                    frmMain.tbrMulti.Visible:=true;
                                                                    frmMain.pMulti.Visible:=true;
                                                                    Able(true);
                                                                    Lock(false);
                                                                    MGoToPage(0);
                                                                    end;
                       end;
end;

// goes to page
procedure MGoToPage(index: integer);
var
   bmp: hBitmap;
begin
bmp:=infMulti.FIPISmultiGetPage(index);
if bmp<>0 then begin
               frmMain.imgMain.Picture.Bitmap.Handle:=bmp;
               infMulti.page:=index;
               end;
end;

// opens page
procedure MPage();
var
   tmp: string;
   num: integer;
begin
num:=0;
tmp:=IntToStr(infMulti.pages);
if InputQuery('Go to page','Type page number to go to... (range from 1 to ' + tmp + ')',tmp) then begin
                                                                                                  // browsing
                                                                                                  try
                                                                                                     num:=StrToInt(tmp);
                                                                                                     except
                                                                                                     Report('You need to input valid numeric.',2);
                                                                                                     Abort();
                                                                                                     end;
                                                                                                  Dec(num);
                                                                                                  if ((num>=0) and (num<infMulti.pages)) then MGoToPage(num)
                                                                                                  else Report('Page does not exist.',1);
                                                                                                  end;

end;

procedure MGoFirst();
begin
MGoToPage(0);
end;

procedure MGoPrev();
begin
if infMulti.page>0 then MGoToPage(infMulti.page-1)
else MGoToPage(infMulti.pages-1);
end;

procedure MGoNext();
begin
if infMulti.page<(infMulti.pages-1) then MGoToPage(infMulti.page+1)
else MGoToPage(0);
end;

procedure MGoLast();
begin
MGoToPage(infMulti.pages-1);
end;

// extracts current frame from multi-page to normal
procedure MExtract();
var
   img: hBitmap;
begin
img:=infMulti.FIPISmultiGetPage(infMulti.page);
if img<>0 then OpenUntitled(nil,img);
end;

// closes multi-page image
procedure CloseMulti();
begin
if @infMulti.FIPISmultiDeInit<>nil then infMulti.FIPISmultiDeInit();
if infMulti.lib<>0 then FreeLibrary(infMulti.lib);
frmMain.tbrMulti.Visible:=false;
frmMain.pMulti.Visible:=false;
FillImage('','',ftNone,itNone);
end;

end.
