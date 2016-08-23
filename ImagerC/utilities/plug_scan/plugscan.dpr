program plugscan;

uses
  Windows,
  SysUtils;

{$R *.RES}

type
    TDoScan = function(app: THandle; imager_dir: PChar):integer; stdcall;

var
   lib: THandle;
   DoScan: TDoScan;

begin
lib:=LoadLibrary('PLUGSCAN.DLL');
if lib<>0 then begin
               try
                  @DoScan:=GetProcAddress(lib,'DoScan');
                  if not (@DoScan=nil) then DoScan(0,PChar(IncludeTrailingBackSlash(ExtractFileDir(ParamStr(0)))))
                  else MessageBox(0,'Required DLL "PLUGSCAN.DLL" corrupted. Plug-ins cannot be scanned.','Error!',MB_OK+MB_ICONERROR);
                  finally
                         FreeLibrary(lib);
                  end;
               end
else MessageBox(0,'Required DLL "PLUGSCAN.DLL" not found. Plug-ins cannot be scanned.','Error!',MB_OK+MB_ICONERROR);
end.
