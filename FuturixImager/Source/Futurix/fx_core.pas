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

    procedure PluginScan(interactive: boolean = true);

    property ApplicationPath: string read fApplicationPath;
    property Plugins: FuturixPluginManager read fPluginManager;
  end;


implementation

uses w_main, fx_defs, fx_pluginscanner;

constructor FuturixCore.Create();
begin
  // application path
  fApplicationPath := Slash(ExtractFilePath(Application.ExeName));

  // initializing plug-in manager
  fPluginManager := FuturixPluginManager.Create();
end;

procedure FuturixCore.PluginScan(interactive: boolean);
var
  scanner: FuturixPluginScanner;
begin
  scanner := FuturixPluginScanner.Create(ApplicationPath, interactive);
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
