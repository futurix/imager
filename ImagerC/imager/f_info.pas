// informational plug-ins support
unit f_info;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, IniFiles;

function IsInformed(ext: string):boolean;
procedure ShowAdditionalInformation(display, path, ext: string);

implementation

uses main, fipis, f_strutils, f_debug, f_reg, globals;

function IsInformed(ext: string):boolean;
begin
reg.OpenKey(sFIPIS + '\Info',true);
if RegReadStr(ext,'')<>'' then Result:=true else Result:=false;
reg.CloseKey();
end;

procedure ShowAdditionalInformation(display, path, ext: string);
var
   FIPISinfo: TFIPISinfo;
   lib: THandle;
begin
try
reg.OpenKey(sFIPIS + '\Info',true);
lib:=LoadLibrary(PChar(GetAppFolder() + 'plugins\' + RegReadStr(ext,'')));
reg.CloseKey();
if lib=0 then Report('Cannot load information DLL!',2)
else begin
     @FIPISinfo:=GetProcAddress(lib,'FIPISinfo');
     if not (@FIPISinfo=nil) then FIPISinfo(PChar(display), PChar(path),PChar(ext),Application.Handle);
     FreeLibrary(lib);
     end;
finally
end;
end;

end.
