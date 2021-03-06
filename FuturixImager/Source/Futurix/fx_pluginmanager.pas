unit fx_pluginmanager;

interface

uses
  Windows, Classes, SysUtils, Generics.Collections, Menus, Forms,
  fx_defs, c_const, c_utils, c_reg;

type
  FuturixPluginManager = class(TObject)
  private
    fID: TDictionary<integer, string>;
    fName: TDictionary<integer, string>;
    fRole: TDictionary<string, integer>;
    fDescr: TDictionary<string, string>;
    fNotRec: TList<string>;
    fOpen: TDictionary<string, integer>;
    fPreview: TDictionary<string, integer>;
    fSave: TDictionary<string, integer>;
    fImport: TDictionary<string, integer>;
    fExport: TDictionary<string, integer>;
    fFilter: TDictionary<string, integer>;
    fTool: TDictionary<string, integer>;

    fCache: TDictionary<integer, FuturixPluginCacheData>;

    procedure ReadSimpleData(var reg: TFRegistry; path: string; var storage: TDictionary<string, integer>);
    procedure ClearPluginCache();
    function CachePlugin(id: integer): boolean;
  public
    constructor Create();
    destructor Destroy(); override;

    procedure LoadData();
    function GetFunctionFromPlugin(id, p_intf: integer): Pointer;

    function HasOpen(extension: string): boolean;
    function ResolveOpen(extension: string): TFxImgOpen;
    function ListOpen(): TStringList;
    function HasPreview(extension: string): boolean;
    function ResolvePreview(extension: string): TFxImgPreview;
    function ListPreview(): TStringList;
    function HasSave(extension: string): boolean;
    function ResolveSave(extension: string): TFxImgSave;
    function ListSave(): TStringList;
    function HasImport(name: string): boolean;
    function ResolveImport(name: string): TFxImgImport;
    function ListImport(): TStringList;
    function HasExport(name: string): boolean;
    function ResolveExport(name: string): TFxImgExport;
    function ListExport(): TStringList;
    function HasFilter(name: string): boolean;
    function ResolveFilter(name: string): TFxImgFilter;
    function ListFilter(): TStringList;
    function HasTool(name: string): boolean;
    function ResolveTool(name: string): TFxImgTool;
    function ListTool(): TStringList;

    function ListPluginIDs(): TList<integer>;
    function FindPluginName(id: integer): string;
    function FindPluginLocation(id: integer): string;
    function FindFormatDescription(extension: string): string;
    function IsRareFormat(extension: string): boolean;
    function ListRare(): TStringList;
    function HasRole(name: string): boolean;
    function FindRoleHandler(name: string): integer;
  end;


implementation

uses w_main, fx_internalp;

constructor FuturixPluginManager.Create();
begin
  fID := TDictionary<integer, string>.Create();
  fName := TDictionary<integer, string>.Create();
  fRole := TDictionary<string, integer>.Create();
  fDescr := TDictionary<string, string>.Create();
  fNotRec := TList<string>.Create();
  fOpen := TDictionary<string, integer>.Create();
  fPreview := TDictionary<string, integer>.Create();
  fSave := TDictionary<string, integer>.Create();
  fImport := TDictionary<string, integer>.Create();
  fExport := TDictionary<string, integer>.Create();
  fFilter := TDictionary<string, integer>.Create();
  fTool := TDictionary<string, integer>.Create();
  fCache := TDictionary<integer, FuturixPluginCacheData>.Create();

  LoadData();
end;

procedure FuturixPluginManager.LoadData();
var
  reg: TFRegistry;
  temp: TStringList;
  item, lc: string;
begin
  reg := TFRegistry.Create();
  temp := TStringList.Create();

  // clean-up
  ClearPluginCache();
  fID.Clear();
  fName.Clear();
  fRole.Clear();
  fDescr.Clear();
  fNotRec.Clear();
  fOpen.Clear();
  fPreview.Clear();
  fSave.Clear();
  fImport.Clear();
  fExport.Clear();
  fFilter.Clear();
  fTool.Clear();

  // plug-in IDs
  if reg.OpenKeyUserRO(sModules + '\' + PS_FID) then
    begin
    temp.Clear();
    reg.GetValueNames(temp);

    for item in temp do
      begin
      lc := reg.RStr(item, '');

      if (lc <> '') then
        fID.Add(StrToInt(item), lc);
      end;

    reg.CloseKey();
    end;

  // expanded plug-in data
  if reg.OpenKeyUserRO(sModules + '\' + PS_FNAME) then
    begin
    temp.Clear();
    reg.GetValueNames(temp);

    for item in temp do
      begin
      lc := reg.RStr(item, '');

      if (lc <> '') then
        fName.Add(StrToInt(item), lc);
      end;

    reg.CloseKey();
    end;

  // roles
  ReadSimpleData(reg, sModules + '\' + PS_FROLE, fRole);

  // descriptions
  if reg.OpenKeyUserRO(sModules + '\' + PS_FDESCR) then
    begin
    temp.Clear();
    reg.GetValueNames(temp);

    for item in temp do
      fDescr.Add(item, reg.RStr(item, ''));

    reg.CloseKey();
    end;

  // not recommended
  if reg.OpenKeyUserRO(sModules) then
    begin
    temp.Clear();
    reg.RStrings(sNotRecommended, temp);

    for item in temp do
      fNotRec.Add(item);

    reg.CloseKey();
    end;

  // the rest
  ReadSimpleData(reg, sModules + '\' + PS_FOPEN, fOpen);
  ReadSimpleData(reg, sModules + '\' + PS_FPREVIEW, fPreview);
  ReadSimpleData(reg, sModules + '\' + PS_FSAVE, fSave);
  ReadSimpleData(reg, sModules + '\' + PS_FIMPORT, fImport);
  ReadSimpleData(reg, sModules + '\' + PS_FEXPORT, fExport);
  ReadSimpleData(reg, sModules + '\' + PS_FFILTER, fFilter);
  ReadSimpleData(reg, sModules + '\' + PS_FTOOL, fTool);

  // clean-up
  FreeAndNil(temp);
  FreeAndNil(reg);
end;

procedure FuturixPluginManager.ReadSimpleData(var reg: TFRegistry; path: string; var storage: TDictionary<string, integer>);
var
  temp: TStringList;
  item: string;
begin
  if reg.OpenKeyUserRO(path) then
    begin
    temp := TStringList.Create();
    temp.Clear();

    reg.GetValueNames(temp);

    for item in temp do
      storage.Add(item, reg.RInt(item, 0));

    FreeAndNil(temp);
    reg.CloseKey();
    end;
end;

procedure FuturixPluginManager.ClearPluginCache();
var
  entry: TPair<integer, FuturixPluginCacheData>;
begin
  // unloading plug-ins
  for entry in fCache do
    if (entry.Value.lib <> 0) then
      FreeLibrary(entry.Value.lib);

  // removing all entries
  fCache.Clear();
end;

function FuturixPluginManager.CachePlugin(id: integer): boolean;
var
  path: string;
  lib: THandle;
  func: TFxCore2;
  data: FuturixPluginCacheData;
begin
  Result := false;

  if fID.ContainsKey(id) then
    begin
    path := fID.Items[id];

    if FileExists(path) then
      begin
      lib := LoadLibrary(PWideChar(path));

      if (lib <> 0) then
        begin
        @func := GetProcAddress(lib, EX_CORE2);

        if (@func <> nil) then
          begin
          // valid plug-in
          data.lib := lib;
          data.func := func;

          fCache.Add(id, data);

          Result := true;
          end
        else
          begin
          // unrecognized plug-in
          FreeLibrary(lib);
          end;
        end;
      end;
    end;
end;

function FuturixPluginManager.GetFunctionFromPlugin(id, p_intf: integer): Pointer;
var
  temp: TFxCore2Result;
begin
  Result := nil;

  if (id <> PI_NULL) then
    begin
    temp.res := FX_FALSE;

    if (id = PI_INTERNAL) then
      temp := InternalCore2(p_intf, FxImgGlobalCallback)
    else if (fCache.ContainsKey(id) or CachePlugin(id)) then
      temp := fCache[id].func(p_intf, FxImgGlobalCallback);

    if (temp.res = FX_TRUE) then
      Result := temp.data;
    end;
end;

function FuturixPluginManager.HasOpen(extension: string): boolean;
begin
  Result := ((extension <> '') and (fOpen.ContainsKey(extension)));
end;

function FuturixPluginManager.ResolveOpen(extension: string): TFxImgOpen;
begin
  if ((extension <> '') and (fOpen.ContainsKey(extension))) then
    Result := GetFunctionFromPlugin(fOpen[extension], CP_FOPEN)
  else
    Result := nil;
end;

function FuturixPluginManager.ListOpen(): TStringList;
var
  temp: string;
begin
  Result := TStringList.Create();

  for temp in fOpen.Keys do
    Result.Add(temp);
end;

function FuturixPluginManager.HasPreview(extension: string): boolean;
begin
  Result := ((extension <> '') and (fPreview.ContainsKey(extension)));
end;

function FuturixPluginManager.ResolvePreview(extension: string): TFxImgPreview;
begin
  if ((extension <> '') and (fPreview.ContainsKey(extension))) then
    Result := GetFunctionFromPlugin(fPreview[extension], CP_FPREVIEW)
  else
    Result := nil;
end;

function FuturixPluginManager.ListPreview(): TStringList;
var
  temp: string;
begin
  Result := TStringList.Create();

  for temp in fPreview.Keys do
    Result.Add(temp);
end;

function FuturixPluginManager.HasSave(extension: string): boolean;
begin
  Result := ((extension <> '') and (fSave.ContainsKey(extension)));
end;

function FuturixPluginManager.ResolveSave(extension: string): TFxImgSave;
begin
  if ((extension <> '') and (fSave.ContainsKey(extension))) then
    Result := GetFunctionFromPlugin(fSave[extension], CP_FSAVE)
  else
    Result := nil;
end;

function FuturixPluginManager.ListSave(): TStringList;
var
  temp: string;
begin
  Result := TStringList.Create();

  for temp in fSave.Keys do
    Result.Add(temp);
end;

function FuturixPluginManager.HasImport(name: string): boolean;
begin
  Result := ((name <> '') and (fImport.ContainsKey(name)));
end;

function FuturixPluginManager.ResolveImport(name: string): TFxImgImport;
begin
  if ((name <> '') and (fImport.ContainsKey(name))) then
    Result := GetFunctionFromPlugin(fImport[name], CP_FIMPORT)
  else
    Result := nil;
end;

function FuturixPluginManager.ListImport(): TStringList;
var
  temp: string;
begin
  Result := TStringList.Create();

  for temp in fImport.Keys do
    Result.Add(temp);
end;

function FuturixPluginManager.HasExport(name: string): boolean;
begin
  Result := ((name <> '') and (fExport.ContainsKey(name)));
end;

function FuturixPluginManager.ResolveExport(name: string): TFxImgExport;
begin
  if ((name <> '') and (fExport.ContainsKey(name))) then
    Result := GetFunctionFromPlugin(fExport[name], CP_FEXPORT)
  else
    Result := nil;
end;

function FuturixPluginManager.ListExport(): TStringList;
var
  temp: string;
begin
  Result := TStringList.Create();

  for temp in fExport.Keys do
    Result.Add(temp);
end;

function FuturixPluginManager.HasFilter(name: string): boolean;
begin
  Result := ((name <> '') and (fFilter.ContainsKey(name)));
end;

function FuturixPluginManager.ResolveFilter(name: string): TFxImgFilter;
begin
  if ((name <> '') and (fFilter.ContainsKey(name))) then
    Result := GetFunctionFromPlugin(fFilter[name], CP_FFILTER)
  else
    Result := nil;
end;

function FuturixPluginManager.ListFilter(): TStringList;
var
  temp: string;
begin
  Result := TStringList.Create();

  for temp in fFilter.Keys do
    Result.Add(temp);
end;

function FuturixPluginManager.HasTool(name: string): boolean;
begin
  Result := ((name <> '') and (fTool.ContainsKey(name)));
end;

function FuturixPluginManager.ResolveTool(name: string): TFxImgTool;
begin
  if ((name <> '') and (fTool.ContainsKey(name))) then
    Result := GetFunctionFromPlugin(fTool[name], CP_FTOOL)
  else
    Result := nil;
end;

function FuturixPluginManager.ListTool(): TStringList;
var
  temp: string;
begin
  Result := TStringList.Create();

  for temp in fTool.Keys do
    Result.Add(temp);
end;

function FuturixPluginManager.ListPluginIDs(): TList<integer>;
begin
  Result := TList<integer>.Create();
  Result.AddRange(fID.Keys);
end;

function FuturixPluginManager.FindPluginName(id: integer): string;
begin
  if ((id >= PI_CUSTOM) and fName.ContainsKey(id)) then
    Result := fName[id];
end;

function FuturixPluginManager.FindPluginLocation(id: integer): string;
begin
  if ((id >= PI_CUSTOM) and fID.ContainsKey(id)) then
    Result := fID[id];
end;

function FuturixPluginManager.FindFormatDescription(extension: string): string;
begin
  if ((extension <> '') and (fDescr.ContainsKey(extension))) then
    Result := fDescr[extension];
end;

function FuturixPluginManager.IsRareFormat(extension: string): boolean;
begin
  Result := ((extension <> '') and (fNotRec.Contains(extension)));
end;

function FuturixPluginManager.ListRare(): TStringList;
var
  temp: string;
begin
  Result := TStringList.Create();

  for temp in fNotRec do
    Result.Add(temp);
end;

function FuturixPluginManager.HasRole(name: string): boolean;
begin
  Result := ((name <> '') and (fRole.ContainsKey(name)));
end;

function FuturixPluginManager.FindRoleHandler(name: string): integer;
begin
  if ((name <> '') and (fRole.ContainsKey(name))) then
    Result := fRole[name]
  else
    Result := PI_NULL;
end;

destructor FuturixPluginManager.Destroy();
begin
  ClearPluginCache();

  FreeAndNil(fID);
  FreeAndNil(fName);
  FreeAndNil(fRole);
  FreeAndNil(fDescr);
  FreeAndNil(fNotRec);
  FreeAndNil(fOpen);
  FreeAndNil(fPreview);
  FreeAndNil(fSave);
  FreeAndNil(fImport);
  FreeAndNil(fExport);
  FreeAndNil(fFilter);
  FreeAndNil(fTool);
  FreeAndNil(fCache);

  inherited;
end;

end.
