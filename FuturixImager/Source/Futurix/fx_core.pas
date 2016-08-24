unit fx_core;

interface

uses
  Windows, Classes, SysUtils, Generics.Collections, Menus, Forms,
  fx_pluginmanager,
  c_const, c_utils, c_locales, c_reg;

type
  FuturixCore = class(TObject)
  private
    fApplicationPath: string;
    fPluginManager: FuturixPluginManager;
  public
    constructor Create();
    destructor Destroy(); override;

    procedure PluginScan();

    property ApplicationPath: string read fApplicationPath;
    property Plugins: FuturixPluginManager read fPluginManager;
  end;


implementation

uses w_main, fx_consts, fx_pluginscanner;

constructor FuturixCore.Create();
begin
  // application path
  fApplicationPath := Slash(ExtractFilePath(Application.ExeName));

  // initializing plug-in manager
  fPluginManager := FuturixPluginManager.Create();
end;

procedure FuturixCore.PluginScan();
var
  scanner: FuturixPluginScanner;
begin
  //TODO: clear plug-in cache (if this is needed to unload DLLs)

  scanner := FuturixPluginScanner.Create(ApplicationPath);
  scanner.Scan();
  FreeAndNil(scanner);

  // update plug-in manager
  fPluginManager.LoadData();
end;

destructor FuturixCore.Destroy();
begin
  FreeAndNil(fPluginManager);

  inherited;
end;

end.
