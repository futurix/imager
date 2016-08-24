unit fx_types;

interface

uses
  Windows, Classes, SysUtils, Generics.Collections,
  c_const;

type
  FuturixPluginCacheData = record
    lib: THandle;
    func: TFxCore2;
  end;

  FuturixPluginInformation = record
    name: string;
    isConfigurable: boolean;
  end;


implementation

end.
