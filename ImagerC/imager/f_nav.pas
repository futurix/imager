// file navigation routines
unit f_nav;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs;

procedure ScanFolder(path: string);
procedure GoPrev();
procedure GoNext();
procedure GoLast();
procedure GoFirst();
procedure FindFileNumber();

implementation

uses globals, main, f_graphics, f_filectrl, f_strutils;

// scans current folder for file list for all known extensions
procedure ScanFolder(path: string);
var
   dir: string;
begin
files.Clear();
if FileExists(path) then dir:=IncludeTrailingBackSlash(ExtractFileDir(path))
else dir:=IncludeTrailingBackSlash(path);
frmMain.imgSeek.SearchFile:=(dir + infSettings.quick_mask);
// disabling UI navigation controls
frmMain.tbnBack.Enabled:=false;
frmMain.tbnForward.Enabled:=false;
frmMain.miBack.Enabled:=false;
frmMain.miForward.Enabled:=false;
frmMain.piBack.Enabled:=false;
frmMain.piForward.Enabled:=false;
// starting scan
frmMain.imgSeek.Start();
end;

// go to prev file in folder
procedure GoPrev();
var
   num: integer;
begin
if infImage.filenum=-1 then begin
                            // go to beginning
                            if files.Count>0 then begin
                                                  GoFirst();
                                                  Abort();
                                                  end;
                            end;
num:=infImage.filenum;
if files.Count>1 then begin
                      if num=0 then begin
                                    if infImage.path<>files.Strings[(files.Count-1)] then Load(files.Strings[(files.Count-1)],true,true);
                                    end
                      else begin
                           if infImage.path<>files.Strings[num-1] then Load(files.Strings[num-1],true,true);
                           end;
                      end;
end;

// go to next file in folder
procedure GoNext();
var
   num: integer;
begin
if infImage.filenum=-1 then begin
                            // go to beginning
                            if files.Count>0 then begin
                                                  GoLast();
                                                  Abort();
                                                  end;
                            end;
num:=infImage.filenum;
if files.Count>1 then begin
                      if num=(files.Count-1) then begin
                                                  if infImage.path<>files.Strings[0] then Load(files.Strings[0],true,true);
                                                  end
                      else begin
                           if infImage.path<>files.Strings[num+1] then Load(files.Strings[num+1],true,true);
                           end;
                      end;
end;

// go to last file in folder
procedure GoLast();
begin
if ((files.Count>1)and(infImage.path<>files.Strings[files.Count-1])) then Load(files.Strings[files.Count-1],true,true);
end;

// go to first file in folder
procedure GoFirst();
begin
if ((files.Count>1)and(infImage.path<>files.Strings[0])) then Load(files.Strings[0],true,true);
end;

// find and set file number in current dir
procedure FindFileNumber();
begin
infImage.filenum:=files.IndexOf(infImage.path);
end;


end.
