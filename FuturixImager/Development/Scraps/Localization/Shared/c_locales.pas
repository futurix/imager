unit c_locales;

interface

uses
  Windows, SysUtils, Classes,
  c_utils, c_reg, c_const;

procedure InitLocalization(back_up: THandle);
procedure OverrideLocalizationLibraries(main, back_up: THandle);
procedure CleanLocalization();
//!!!
function LoadLStr(id: integer): string;
function LoadLStrExt(id: integer; def: string = ''): string;
//!!!
function GetLString(id: integer): string;
function GetLStringEx(id: integer; def: string = ''): string;

var
  locale_lib: THandle = 0;
  backup_lib: THandle = 0;
  //!!!
  legacy_locale: THandle = 0;
  //!!!


implementation

procedure InitLocalization(back_up: THandle);
var
  locale_reg: TFRegistry;
  locale_str: string;
begin
  //!!!
  legacy_locale := LoadLibraryEx('fxlegacy.dll', 0, LOAD_LIBRARY_AS_DATAFILE);
  //!!!

  backup_lib := back_up;

  locale_reg := TFRegistry.Create(KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS);

  if locale_reg.OpenKey(sSettings, false) then
    begin
    locale_str := locale_reg.RStr(sLocaleFile, '');
    locale_reg.CloseKey();

    if ((locale_str <> '') and FileExists(locale_str)) then
      begin
      locale_lib := LoadLibraryEx(PWideChar(locale_str), 0, LOAD_LIBRARY_AS_DATAFILE);

      if (locale_lib <> 0) then
        if (LoadResString(locale_lib, 1) <> sLocaleID) then
          begin
          FreeLibrary(locale_lib);
          locale_lib := 0;
          end;
        end;
      end;

    FreeAndNil(locale_reg);
end;

procedure OverrideLocalizationLibraries(main, back_up: THandle);
begin
  locale_lib := main;
  backup_lib := back_up;
end;

procedure CleanLocalization();
begin
  //!!!
  if (legacy_locale <> 0) then
    begin
    FreeLibrary(legacy_locale);
    legacy_locale := 0;
    end;
  //!!!

  if (locale_lib <> 0) then
    begin
    FreeLibrary(locale_lib);
    locale_lib := 0;
    end;
end;

//!!!
function LoadLStr(id: integer): string;
begin
  Result := LoadLStrExt(id, ' ');
end;

function LoadLStrExt(id: integer; def: string = ''): string;
var
  tmp: string;
begin
  tmp := LoadResString(legacy_locale, id);

  if (tmp <> '') then
    Result := tmp
  else
    Result := def;
end;
//!!!

function GetLString(id: integer): string;
var
  tmp: string;
begin
  if (locale_lib <> 0) then
    begin
    tmp := LoadResString(locale_lib, id);

    if (tmp <> '') then
      Result := tmp
    else
      Result := LoadResString(backup_lib, id);
    end
  else
    Result := LoadResString(backup_lib, id);
end;

function GetLStringEx(id: integer; def: string = ''): string;
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

end.
