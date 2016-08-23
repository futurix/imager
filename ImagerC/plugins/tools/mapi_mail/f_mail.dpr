library f_mail;

uses Windows, SysUtils, Classes, MAPI;

{$R *.RES}
{$R fipis.res}

function FIPIStool(info,path: PChar; app: THandle; img: hBitmap):hBitmap; stdcall;
begin
MAPISendDocuments(app,';',PChar(path),nil,0);
Result:=0;
end;

exports FIPIStool;

begin
end.
 