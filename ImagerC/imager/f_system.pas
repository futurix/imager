// Win32 API wrappers
unit f_system;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, ShellAPI;

procedure ExecInFolder(what: string);
procedure HelpExec(what: string);
function ExecLibrary(which: string):integer;

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

// executes help .html file
procedure HelpExec(what: string);
var
   tmp: string;
begin
tmp:=GetAppFolder() + 'help\' + what;
ShellExecute(Application.Handle,'open',PChar(tmp),nil,nil,SW_SHOWNORMAL);
end;

// executes library in Imager's folder
function ExecLibrary(which: string):integer;
var
   tmp: string;
   lib: THandle;
   Execute: TExecute;
begin
tmp:=GetAppFolder() + which;
lib:=LoadLibrary(PChar(tmp));
if lib<>0 then begin
               @Execute:=GetProcAddress(lib,'Execute');
               if not (@Execute=nil) then begin
                                          Result:=Execute(Application.Handle);
                                          end
               else Result:=-1;
               FreeLibrary(lib);
               end
else Result:=-1;
end;

end.
