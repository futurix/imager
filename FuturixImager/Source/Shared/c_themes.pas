unit c_themes;

interface

uses
  Windows, SysUtils, Graphics, Classes, c_utils, c_reg, c_const;

procedure LoadTheme(back_up: THandle);
procedure OverrideThemeLibraries(main, back_up: THandle);
procedure UnloadTheme();
function LoadBitmapFromTheme(id: string): TBitmap;
function LoadBitmapFromCustomTheme(lib: THandle; id: string): TBitmap;

var
  theme_lib: THandle = 0;
  theme_backup_lib: THandle = 0;


implementation

procedure LoadTheme(back_up: THandle);
var
  theme_reg: TFRegistry;
  theme_str: string;
begin
  theme_backup_lib := back_up;

  theme_reg := TFRegistry.Create(KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS);

  if theme_reg.OpenKey(sSettings, false) then
    begin
    theme_str := theme_reg.RStr(sThemeFile, '');
    theme_reg.CloseKey();

    if ((theme_str <> '') and FileExists(theme_str)) then
      begin
      theme_lib := LoadLibraryEx(PWideChar(theme_str), 0, LOAD_LIBRARY_AS_DATAFILE);

      if (theme_lib <> 0) then
        if (LoadResString(theme_lib, 1) <> sThemeID) then
          begin
          FreeLibrary(theme_lib);
          theme_lib := 0;
          end;
      end;
    end;

  FreeAndNil(theme_reg);
end;

procedure OverrideThemeLibraries(main, back_up: THandle);
begin
  theme_lib := main;
  theme_backup_lib := back_up;
end;

procedure UnloadTheme();
begin
  if (theme_lib <> 0) then
    begin
    FreeLibrary(theme_lib);
    theme_lib := 0;
    end;
end;

function LoadBitmapFromTheme(id: string): TBitmap;
var
  res: TResourceStream;
begin
  if (theme_lib <> 0) then
    begin
    try
      res := TResourceStream.Create(theme_lib, id, 'RT_BITMAP');

      Result := TBitmap.Create();
      Result.LoadFromStream(res);

      FreeAndNil(res);
    except
      Result := nil;
    end;
    end
  else
    begin
    try
      res := TResourceStream.Create(theme_backup_lib, id, 'RT_BITMAP');

      Result := TBitmap.Create();
      Result.LoadFromStream(res);

      FreeAndNil(res);
    except
      Result := nil;
    end;
    end;
end;

function  LoadBitmapFromCustomTheme(lib: THandle; id: string): TBitmap;
var
  res: TResourceStream;
begin
  Result := nil;

  if (lib <> 0) then
    begin
    try
      res := TResourceStream.Create(lib, id, 'RT_BITMAP');

      Result := TBitmap.Create();
      Result.LoadFromStream(res);

      FreeAndNil(res);
    except
      Result := nil;
    end;
    end;
end;

end.
