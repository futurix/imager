// external dependancies and applications
unit f_external;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, ShellAPI;

procedure CheckFolderDependancies();
procedure CheckLibrariesDependancies();

implementation

uses globals, f_filectrl, f_strutils, f_debug, f_reg, main;

// checks for folders existance (and creates missing ones)
procedure CheckFolderDependancies();
begin
if not DirExists(GetAppFolder() + 'help') then DirCreate(GetAppFolder() + 'help');
if not DirExists(GetAppFolder() + 'plugins') then DirCreate(GetAppFolder() + 'plugins');
if not DirExists(GetAppFolder() + 'temp') then DirCreate(GetAppFolder() + 'temp');
end;

// checks for libraries existance (and warns about missing ones)
procedure CheckLibrariesDependancies();
begin
if not FileExists(GetAppFolder() + 'print.dll')
       then begin
            frmMain.tbnPrint.Visible:=false;
            frmMain.miPrint.Visible:=false;
            frmMain.miPrintPreview.Visible:=false;
            frmMain.Sep_1.Free();
            end;
if not FileExists(GetAppFolder() + 'webload.dll')
       then begin
            frmMain.tbnWeb.Visible:=false;
            frmMain.miWeb.Visible:=false;
            frmMain.piWeb.Visible:=false;
            end;
if not FileExists(GetAppFolder() + 'browser.exe')
       then begin
            frmMain.tbnThumb.Visible:=false;
            frmMain.miThumb.Visible:=false;
            end;
end;

end.
