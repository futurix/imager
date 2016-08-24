unit fx_pluginscanner;

interface

uses
  Windows, Classes, SysUtils, Generics.Collections, Menus, Forms,
  fx_defs, c_const, c_utils, c_locales, c_reg;

type
  FuturixScannerEvent = function(module_type: longword; value1, value2: PWideChar): BOOL of object;

  FuturixPluginScanner = class(TObject)
  private
    locations: TStringList;
    current_id: integer;
    IDs: TDictionary<integer, string>;
    PluginInformation: TDictionary<integer, FuturixPluginInformation>;
    NotRec: TList<string>;
    lock: TRTLCriticalSection;
    UIallowed: boolean;
    UIhandle: HWND;

    class var current_reader: FuturixScannerEvent;
    class function SortData(module_type: longword; value1, value2: PWideChar): BOOL; static; cdecl;

    procedure CleanUp();
    procedure ProcessLibrary(dll: string);
    function ReceiveData(module_type: longword; value1, value2: PWideChar): BOOL;
    procedure SavePluginName(id: integer; name: string);
    procedure SavePluginConfiguration(id: integer);
    procedure SaveNotRec(extension: string);
    procedure WriteData(id: integer; key, value1: string);
    procedure WriteDescr(ext, name: string);
    procedure WriteLocale(dll, name: string);
    procedure WriteTheme(dll, name: string);
    procedure WriteIconLib(dll, name: string);
    procedure WriteID(id: integer; dll: string);
  public
    constructor Create(app_path: string; interactive: boolean = true);
    destructor Destroy(); override;

    procedure Scan();
  end;


implementation

uses w_main, fx_internalp, f_tools;

constructor FuturixPluginScanner.Create(app_path: string; interactive: boolean);
var
  temp: TStringList;
  reg: TFRegistry;
begin
  // initializing
  locations := TStringList.Create();
  locations.Add(app_path);   // default plug-in location (always included)

  IDs := TDictionary<integer, string>.Create();
  current_id := PI_CUSTOM;

  UIallowed := interactive;
  if interactive then
    UIhandle := frmMain.Handle
  else
    UIhandle := 0;

  PluginInformation := TDictionary<integer, FuturixPluginInformation>.Create();
  NotRec := TList<string>.Create();

  // reading custom plug-in locations
  reg := TFRegistry.Create();
  temp := TStringList.Create();

  if reg.OpenKeyMachineRO(sModSearch) then
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
  location, suspect, sNotRec: string;
  suspects, nr, temp: TStringList;
  id: TPair<integer, string>;
  info: TPair<integer, FuturixPluginInformation>;
  intres: TFxCore2Result;
  intsupp: TFxImgQuery;
  updateDef: boolean;
begin
  current_id := PI_CUSTOM;            // always start IDs with special value
  suspects := TStringList.Create();
  IDs.Clear();

  InitializeCriticalSection(lock);    // lock around any usage of current_reader
  EnterCriticalSection(lock);
  current_reader := ReceiveData;

  // removing old crap
  CleanUp();

  // creating list of all DLLs
  for location in locations do
    begin
    if DirExists(location) then
      ScanFolderRecL(NoSlash(location), '*.dll', suspects)
    else if FileExists(location) then
      suspects.Add(location);
    end;

  // adding internal plug-ins (with normal scan - but in the Imager executable)
  current_id := PI_INTERNAL;
  intres := InternalCore2(CP_FQUERY, FxImgGlobalCallback);

  if (intres.res = FX_TRUE) then
    begin
    intsupp := intres.data;
    intsupp(PWideChar(Application.ExeName), SortData, Application.Handle, UIhandle, FxImgGlobalCallback);
    end;

  current_id := PI_CUSTOM;

  // processing libraries
  for suspect in suspects do
    ProcessLibrary(suspect);

  // saving generated IDs
  for id in IDs do
    WriteID(id.Key, id.Value);

  // saving plug-in information
  temp := TStringList.Create();

  for info in PluginInformation do
    begin
    temp.Clear();
    temp.Add(info.Value.name);

    if info.Value.isConfigurable then
      temp.Add(FX_CFG_TRUE)
    else
      temp.Add(FX_CFG_FALSE);

    FxRegWStrs(IntToStr(info.Key), temp, sModules + '\' + PS_FPLUGINFO);
    end;

  FreeAndNil(temp);

  // saving not recommended extensions
  nr := TStringList.Create();

  for sNotRec in NotRec do
    nr.Add(sNotRec);

  FxRegWStrs(FX_REG_NOTREC, nr, sModules);
  FreeAndNil(nr);

  // clean-up
  current_reader := nil;
  LeaveCriticalSection(lock);
  FreeAndNil(suspects);

  // update default programs
  if IsVista() and UIallowed then
    begin
    updateDef := FxRegRBool('Formats_UpdateSystemOnPluginScan', true);

    if updateDef then
      DefaultPrograms('/sync');
    end;
end;

procedure FuturixPluginScanner.CleanUp();
var
  reg: TFRegistry;
begin
  reg := TFRegistry.Create();

  // recreating registry keys
  if reg.OpenKeyUser(sModules) then
    begin
    reg.DeleteValue(FX_REG_NOTREC);

    reg.DeleteKey(PS_FID);
    reg.DeleteKey(PS_FPLUGINFO);
    reg.DeleteKey(PS_FROLE);
    reg.DeleteKey(PS_FDESCR);
    reg.DeleteKey(PS_FLOCALE);
    reg.DeleteKey(PS_FTHEME);
    reg.DeleteKey(PS_FICONLIB);
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
      // compatible locale
      tmp := LoadResString(lib, 2);

      if (Trim(tmp) <> '') then
        WriteLocale(dll, tmp);
      end
    else if (id = sThemeID) then
      begin
      // compatible theme
      tmp := LoadResString(lib, 2);

      if (Trim(tmp) <> '') then
        WriteTheme(dll, tmp);
      end
    else if (id = sIconLibID) then
      begin
      // compatible icon library
      tmp := LoadResString(lib, 2);

      if (Trim(tmp) <> '') then
        WriteIconLib(dll, tmp);
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
          supp(PWideChar(dll), SortData, Application.Handle, UIhandle, FxImgGlobalCallback);
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
    PT_FNAME:       SavePluginName(current_id, String(value1));
    PT_FCONFIG:     SavePluginConfiguration(current_id);
    PT_FNOTREC:     SaveNotRec(String(value1));

    PT_FROLE:       WriteData(current_id, PS_FROLE,         String(value1));
    PT_FOPEN:       WriteData(current_id, PS_FOPEN,         String(value1));
    PT_FPREVIEW:    WriteData(current_id, PS_FPREVIEW,      String(value1));
    PT_FSAVE:       WriteData(current_id, PS_FSAVE,         String(value1));
    PT_FIMPORT:     WriteData(current_id, PS_FIMPORT,       String(value1));
    PT_FEXPORT:     WriteData(current_id, PS_FEXPORT,       String(value1));
    PT_FFILTER:     WriteData(current_id, PS_FFILTER,       String(value1));
    PT_FINFO:       WriteData(current_id, PS_FINFO,         String(value1));
    PT_FTOOL:       WriteData(current_id, PS_FTOOL,         String(value1));

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

procedure FuturixPluginScanner.SavePluginName(id: integer; name: string);
var
  temp: FuturixPluginInformation;
begin
  if PluginInformation.TryGetValue(id, temp) then
    begin
    temp.name := name;
    PluginInformation[id] := temp;
    end
  else
    begin
    temp.name := name;
    temp.isConfigurable := false;

    PluginInformation.Add(id, temp);
    end;
end;

procedure FuturixPluginScanner.SavePluginConfiguration(id: integer);
var
  temp: FuturixPluginInformation;
begin
  if PluginInformation.TryGetValue(id, temp) then
    begin
    temp.isConfigurable := true;
    PluginInformation[id] := temp;
    end
  else
    begin
    temp.name := '';
    temp.isConfigurable := true;

    PluginInformation.Add(id, temp);
    end;
end;

procedure FuturixPluginScanner.SaveNotRec(extension: string);
begin
  if not NotRec.Contains(extension) then
    NotRec.Add(extension);
end;

procedure FuturixPluginScanner.WriteData(id: integer; key, value1: string);
begin
  FxRegWInt(value1, id, sModules + '\' + key);
end;

procedure FuturixPluginScanner.WriteDescr(ext, name: string);
begin
  FxRegWStr(ext, name, sModules + '\' + PS_FDESCR);
end;

procedure FuturixPluginScanner.WriteLocale(dll, name: string);
begin
  FxRegWStr(name, dll, sModules + '\' + PS_FLOCALE);
end;

procedure FuturixPluginScanner.WriteTheme(dll, name: string);
begin
  FxRegWStr(name, dll, sModules + '\' + PS_FTHEME);
end;

procedure FuturixPluginScanner.WriteIconLib(dll, name: string);
begin
  FxRegWStr(name, dll, sModules + '\' + PS_FICONLIB);
end;

procedure FuturixPluginScanner.WriteID(id: integer; dll: string);
begin
  FxRegWStr(IntToStr(id), dll, sModules + '\' + PS_FID);
end;

destructor FuturixPluginScanner.Destroy();
begin
  FreeAndNil(locations);
  FreeAndNil(IDs);
  FreeAndNil(PluginInformation);
  FreeAndNil(NotRec);

  inherited;
end;

end.
