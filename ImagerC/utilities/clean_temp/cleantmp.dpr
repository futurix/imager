program cleantmp;

uses
  SysUtils,
  ShellAPI;

{$R *.RES}

var
   tmp: string;
   info: TSHFileOpStruct;

begin
tmp:=ParamStr(0);
tmp:=IncludeTrailingBackSlash(ExtractFileDir(tmp));
tmp:=tmp+'temp\*.*';
info.Wnd:=0;
info.wFunc:=FO_DELETE;
info.pFrom:=PChar(tmp);
info.pTo:='';
info.fFlags:=FOF_NOCONFIRMATION+FOF_SILENT;

SHFileOperation(info);
end.
