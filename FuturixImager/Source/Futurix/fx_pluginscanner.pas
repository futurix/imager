unit fx_pluginscanner;

interface

uses
  Windows, Classes, SysUtils, Generics.Collections, Menus, Forms,
  c_const, c_utils, c_locales, c_reg;

type
  FuturixScannerEvent = function(module_type: longword; value1, value2: PWideChar): BOOL of object;

  FuturixPluginScanner = class(TObject)
  private
    locations: TStringList;
    current_id: integer;
    IDs: TDictionary<integer, string>;
    lock: TRTLCriticalSection;

    class var current_reader: FuturixScannerEvent;
    class function SortData(module_type: longword; value1, value2: PWideChar): BOOL; static; cdecl;

    procedure CleanUp();
    procedure ProcessLibrary(dll: string);
    function ReceiveData(module_type: longword; value1, value2: PWideChar): BOOL;
    procedure WriteData(id: integer; key, value1: string);
    procedure WriteDataInverted(id: integer; key, value1: string);
    procedure WriteInternal(key, value: string);
    procedure WriteDescr(ext, name: string);
    procedure WriteNotRec(ext: string);
    procedure WriteLocale(dll, name: string);
    procedure WriteTheme(dll, name: string);
    procedure WriteID(id: integer; dll: string);
  public
    constructor Create(app_path: string);
    destructor Destroy(); override;

    procedure Scan();
  end;


implementation

uses w_main, fx_consts;

constructor FuturixPluginScanner.Create(app_path: string);
var
  temp: TStringList;
  reg: TFRegistry;
begin
  // initializing
  locations := TStringList.Create();
  locations.Add(app_path);   // default plug-in location (always included)

  IDs := TDictionary<integer, string>.Create();
  current_id := PI_CUSTOM;

  // reading custom plug-in locations
  reg := TFRegistry.Create();
  temp := TStringList.Create();

  if reg.OpenKeyShared(sModSearch) then
    begin
    reg.GetValueNames(temp);
    locations.AddStrings(temp);

    reg.CloseKey();
    end;

  FreeAndNil(temp);
  FreeAndNil(reg);
end;

procedure FuturixPluginScanner.Scan();
var
  location, suspect: string;
  suspects: TStringList;
  id: TPair<integer, string>;
begin
  current_id := PI_CUSTOM;            // always start IDs with special value
  suspects := TStringList.Create();
  IDs.Clear();

  InitializeCriticalSection(lock);    // lock around any usage of current_reader
  EnterCriticalSection(lock);
  current_reader := ReceiveData;

  // removing old crap
  CleanUp();

  // internal formats
  WriteInternal(PS_FOPEN, 'jpg');
  WriteInternal(PS_FOPEN, 'jpeg');
  WriteInternal(PS_FOPEN, 'jfif');
  WriteInternal(PS_FOPEN, 'jpe');
  WriteInternal(PS_FOPEN, 'jp2');
  WriteInternal(PS_FOPEN, 'jpc');
  WriteInternal(PS_FOPEN, 'j2k');
  WriteInternal(PS_FOPEN, 'j2c');
  WriteInternal(PS_FOPEN, 'gif');
  WriteInternal(PS_FOPEN, 'pbm');
  WriteInternal(PS_FOPEN, 'pgm');
  WriteInternal(PS_FOPEN, 'ppm');
  WriteInternal(PS_FOPEN, 'bmp');
  WriteInternal(PS_FOPEN, 'dib');
  WriteInternal(PS_FOPEN, 'emf');
  WriteInternal(PS_FOPEN, 'wmf');
  WriteInternal(PS_FOPEN, 'pcx');
  WriteInternal(PS_FOPEN, 'dcx');
  WriteInternal(PS_FOPEN, 'png');
  WriteInternal(PS_FOPEN, 'tga');
  WriteInternal(PS_FOPEN, 'tif');
  WriteInternal(PS_FOPEN, 'tiff');
  WriteInternal(PS_FOPEN, 'wbmp');
  WriteInternal(PS_FOPEN, 'wbm');
  WriteInternal(PS_FOPEN, 'psd');

  WriteNotRec('dcx');
  WriteNotRec('jpe');
  WriteNotRec('jfif');

  WriteDescr('jpg', LoadLStr(1000));
  WriteDescr('jpeg', LoadLStr(1000));
  WriteDescr('jfif', LoadLStr(1000));
  WriteDescr('jpe', LoadLStr(1000));
  WriteDescr('jp2', LoadLStr(1001));
  WriteDescr('jpc', LoadLStr(1001));
  WriteDescr('j2k', LoadLStr(1001));
  WriteDescr('j2c', LoadLStr(1001));
  WriteDescr('gif', LoadLStr(1002));
  WriteDescr('pbm', LoadLStr(1003));
  WriteDescr('pgm', LoadLStr(1004));
  WriteDescr('ppm', LoadLStr(1005));
  WriteDescr('bmp', LoadLStr(1006));
  WriteDescr('dib', LoadLStr(1006));
  WriteDescr('emf', LoadLStr(1007));
  WriteDescr('wmf', LoadLStr(1008));
  WriteDescr('pcx', LoadLStr(1009));
  WriteDescr('dcx', LoadLStr(1010));
  WriteDescr('png', LoadLStr(1011));
  WriteDescr('tga', LoadLStr(1012));
  WriteDescr('tif', LoadLStr(1013));
  WriteDescr('tiff', LoadLStr(1013));
  WriteDescr('wbmp', LoadLStr(1014));
  WriteDescr('wbm', LoadLStr(1014));
  WriteDescr('psd', LoadLStr(1020));

  // creating list of all DLLs
  for location in locations do
    begin
    if DirExists(location) then
      ScanFolderRecL(NoSlash(location), '*.dll', suspects)
    else if FileExists(location) then
      suspects.Add(location);
    end;

  // processing libraries
  for suspect in suspects do
    ProcessLibrary(suspect);

  // saving generated IDs
  for id in IDs do
    WriteID(id.Key, id.Value);

  // clean-up
  current_reader := nil;
  LeaveCriticalSection(lock);
  FreeAndNil(suspects);
end;

procedure FuturixPluginScanner.CleanUp();
var
  reg: TFRegistry;
begin
  reg := TFRegistry.Create();

  // recreating registry keys
  if reg.OpenKeyLocal(sModules, RA_FULL) then
    begin
    reg.DeleteKey(PS_FID);
    reg.DeleteKey(PS_FNAME);
    reg.DeleteKey(PS_FROLE);
    reg.DeleteKey(PS_FCONFIG);
    reg.DeleteKey(PS_FDESCR);
    reg.DeleteKey(PS_FNOTREC);
    reg.DeleteKey(PS_FLOCALE);
    reg.DeleteKey(PS_FTHEME);
    reg.DeleteKey(PS_FOPEN);
    reg.DeleteKey(PS_FPREVIEW);
    reg.DeleteKey(PS_FSAVE);
    reg.DeleteKey(PS_FIMPORT);
    reg.DeleteKey(PS_FEXPORT);
    reg.DeleteKey(PS_FFILTER);
    reg.DeleteKey(PS_FINFO);
    reg.DeleteKey(PS_FTOOL);

    reg.CloseKey();
    end;

  FreeAndNil(reg);
end;

procedure FuturixPluginScanner.ProcessLibrary(dll: string);
var
  lib: THandle;
  id, tmp: string;
  check_for_plugin: boolean;
  query: TFxCore2;
  qres: TFxCore2Result;
  supp: TFxImgQuery;
begin
  check_for_plugin := false;

  lib := LoadLibraryEx(PWideChar(dll), 0, LOAD_LIBRARY_AS_DATAFILE);

  if (lib <> 0) then
    begin
    id := LoadResString(lib, 1);

    if (id = sLocaleID) then
      begin
      // library is compatible locale
      tmp := LoadResString(lib, 2);

      if (Trim(tmp) <> '') then
        WriteLocale(dll, tmp);
      end
    else if (id = sThemeID) then
      begin
      // library is compatible theme
      tmp := LoadResString(lib, 2);

      if (Trim(tmp) <> '') then
        WriteTheme(dll, tmp);
      end
    else
      check_for_plugin := true;

    FreeLibrary(lib);
    end;

  if check_for_plugin then
    begin
    lib := LoadLibrary(PWideChar(dll));

    if (lib <> 0) then
      begin
      @query := GetProcAddress(lib, EX_CORE2);

      if (@query <> nil) then
        begin
        // library is a compatible plug-in
        IDs.Add(current_id, dll);

        // get query interface
        qres := query(CP_FQUERY, FxImgGlobalCallback);

        if (qres.res = FX_TRUE) then
          begin
          supp := qres.data;
          supp(PWideChar(dll), SortData, Application.Handle, frmMain.Handle, FxImgGlobalCallback);
          end;

        Inc(current_id);
        end;

      FreeLibrary(lib);
      end;
    end;
end;

function FuturixPluginScanner.ReceiveData(module_type: longword; value1, value2: PWideChar): BOOL;
begin
  Result := true;

  case module_type of
    PT_FNAME:       WriteDataInverted(current_id, PS_FNAME, String(value1));

    PT_FCONFIG:     WriteData(current_id, PS_FCONFIG,       String(value1));
    PT_FROLE:       WriteData(current_id, PS_FROLE,         String(value1));
    PT_FOPEN:       WriteData(current_id, PS_FOPEN,         String(value1));
    PT_FPREVIEW:    WriteData(current_id, PS_FPREVIEW,      String(value1));
    PT_FSAVE:       WriteData(current_id, PS_FSAVE,         String(value1));
    PT_FIMPORT:     WriteData(current_id, PS_FIMPORT,       String(value1));
    PT_FEXPORT:     WriteData(current_id, PS_FEXPORT,       String(value1));
    PT_FFILTER:     WriteData(current_id, PS_FFILTER,       String(value1));
    PT_FINFO:       WriteData(current_id, PS_FINFO,         String(value1));
    PT_FTOOL:       WriteData(current_id, PS_FTOOL,         String(value1));

    PT_FNOTREC:     WriteNotRec(String(value1));

    PT_FDESCR:      WriteDescr(String(value1),  String(value2));
  else
    Result := false;
  end;
end;

class function FuturixPluginScanner.SortData(module_type: longword; value1, value2: PWideChar): BOOL;
begin
  if (@current_reader <> nil) then
    Result := current_reader(module_type, value1, value2)
  else
    Result := true;
end;

procedure FuturixPluginScanner.WriteData(id: integer; key, value1: string);
begin
  FxRegWInt(value1, id, sModules + '\' + key);
end;

procedure FuturixPluginScanner.WriteDataInverted(id: integer; key, value1: string);
begin
  FxRegWStr(IntToStr(id), value1, sModules + '\' + key);
end;

procedure FuturixPluginScanner.WriteInternal(key, value: string);
begin
  FxRegWInt(value, PI_INTERNAL, sModules + '\' + key);
end;

procedure FuturixPluginScanner.WriteDescr(ext, name: string);
begin
  FxRegWStr(ext, name, sModules + '\' + PS_FDESCR);
end;

procedure FuturixPluginScanner.WriteNotRec(ext: string);
begin
  FxRegWStr(ext, '', sModules + '\' + PS_FNOTREC);
end;

procedure FuturixPluginScanner.WriteLocale(dll, name: string);
begin
  FxRegWStr(name, dll, sModules + '\' + PS_FLOCALE);
end;

procedure FuturixPluginScanner.WriteTheme(dll, name: string);
begin
  FxRegWStr(name, dll, sModules + '\' + PS_FTHEME);
end;

procedure FuturixPluginScanner.WriteID(id: integer; dll: string);
begin
  FxRegWStr(IntToStr(id), dll, sModules + '\' + PS_FID);
end;

destructor FuturixPluginScanner.Destroy();
begin
  FreeAndNil(locations);
  FreeAndNil(IDs);

  inherited;
end;

end.
