// Win32 API wrappers
unit f_system;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, ShellAPI;

procedure ExecInFolder(what: string);

implementation

uses globals, f_strutils;

// executes file in Imager's folder
procedure ExecInFolder(what: string);
var
  tmp: string;
begin
tmp:=GetAppFolder() + what;
ShellExecute(Application.Handle,'open',PChar(tmp),nil,nil,SW_SHOWNORMAL);
end;

end.
