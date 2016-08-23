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
if not DirExists(GetAppFolder() + 'plugins') then DirCreate(GetAppFolder() + 'plugins');
end;

// checks for libraries existance (and warns about missing ones)
procedure CheckLibrariesDependancies();
begin
if not FileExists(GetAppFolder() + 'print.dll') then
  begin
  frmMain.tbnPrint.Visible:=false;
  frmMain.miPrint.Visible:=false;
  frmMain.miPrintPreview.Visible:=false;
  frmMain.Sep_1.Free();
  end;
end;

end.
