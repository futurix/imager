library f_gif;

uses
  SysUtils,
  Classes,
  Windows,
  Graphics,
  gifimage,
  c_const,
  gifexp in 'gifexp.pas' {frmGIFExport};

{$R *.RES}

function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; cdecl;
begin
	if (Win32Platform = VER_PLATFORM_WIN32_NT) then
  		func(PT_FEXPORT, 'Advanced GIF Export...', ' ');

	Result := true;
end;

exports
  FQuery, FExport;

begin
end.
 