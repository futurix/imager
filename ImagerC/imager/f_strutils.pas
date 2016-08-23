// string utilities
unit f_strutils;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms;

function Slash(what: string):string;
function NoSlash(what: string):string;
function GetAppFolder(with_slash: boolean = true):string;
function GetExt(this: string):string;

implementation

// adds "\" to the end of path and removes spaces (if exist)
function Slash(what: string):string;
begin
Result:=IncludeTrailingBackSlash(Trim(what));
end;

// removes "\" from the end of path and removes spaces (if exist)
function NoSlash(what: string):string;
begin
Result:=ExcludeTrailingBackSlash(Trim(what));
end;

// returns application folder with/without trailing slash
function GetAppFolder(with_slash: boolean = true):string;
begin
if with_slash then Result:=Slash(ExtractFileDir(Application.ExeName))
else Result:=NoSlash(ExtractFileDir(Application.ExeName))
end;

// returns extension
function GetExt(this: string):string;
var
   tmp: string;
begin
tmp:=ExtractFileExt(this);
Delete(tmp,1,1);
Result:=LowerCase(tmp);
end;

end.
