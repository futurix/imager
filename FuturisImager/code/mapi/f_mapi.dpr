library f_mapi;

uses
  Windows, SysUtils, Classes, MAPI,
  c_const;

{$R *.RES}

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
func(PT_FTOOL,'Send by Mail',' ');
Result:=true;
end;

function FIPIStool(info,path: PChar; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;
begin
MAPISendDocuments(wnd,';',PChar(path),nil,0);
Result:=0;
end;

exports
  FIPISquery, FIPIStool;

begin
end.
 