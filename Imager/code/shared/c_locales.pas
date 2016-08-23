// localization support
unit c_locales;

interface

uses
  Windows, SysUtils, Classes,
  c_utils, c_reg, c_const;
  
function LoadLStr(id: integer; def: string = ''): string;

var
    locale_reg: TFuturisRegistry;
	locale_lib: THandle = 0;
    locale_str: string = '';


implementation

// loads resource string from current locale or substitutes provided default
function LoadLStr(id: integer; def: string = ''): string;
var
    tmp: string;
begin
    if (locale_lib <> 0) then
    	begin
        tmp := LoadResString(locale_lib, id);

        if (tmp <> '') then
        	Result := tmp
        else
        	Result := def;
        end
    else
    	Result := def;
end;


initialization
	locale_reg := TFuturisRegistry.Create(KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS);

    if locale_reg.OpenKey(sReg, false) then
    	begin
        locale_str := locale_reg.RStr('CurrentLocale', '');

        if ((locale_str <> '') and FileExists(locale_str)) then
        	begin
            locale_lib := LoadLibraryEx(PChar(locale_str), 0, LOAD_LIBRARY_AS_DATAFILE);

            if (locale_lib <> 0) then
            	if (LoadResString(locale_lib, 1) <> sLocaleID) then
                    begin
                    FreeLibrary(locale_lib);
                	locale_lib := 0;
                    end;
            end;

        locale_reg.CloseKey();
        end;

    FreeAndNil(locale_reg);

finalization
	if (locale_lib <> 0) then
        begin
    	FreeLibrary(locale_lib);
        locale_lib := 0;
        end;
end.
