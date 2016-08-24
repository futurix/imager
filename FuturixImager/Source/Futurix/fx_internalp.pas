unit fx_internalp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  c_const;

function FxCore2(p_intf: ULONG; app_query: TAppCallBack): TFxCore2Result; cdecl;


implementation

function FxCore2(p_intf: ULONG; app_query: TAppCallBack): TFxCore2Result;
begin
  Result.res := FX_FALSE;
  Result.data := nil;
end;

end.
