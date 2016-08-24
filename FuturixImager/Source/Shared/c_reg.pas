unit c_reg;

interface

uses
  Windows, SysUtils, Classes, Registry,
  c_const;

type
  TFRegistry = class(TRegistry)
  public
    function RBool(name: string; default: boolean): boolean;
    function RInt(name: string; default: integer): integer;
    function RStr(name, default: string): string;
    function RBin(name: string; var buf; size: integer): boolean;
    procedure RStrings(valueName: string; var strings: TStringList);
    procedure WBool(name: string; value: boolean);
    procedure WInteger(name: string; value: integer);
    procedure WString(name, value: string);
    procedure WBin(name: string; var buf; size: integer);
    procedure WStrings(valueName: string; var strings: TStringList);
  end;

function FxRegRBool(name: string; default: boolean; path: string = sSettings; key: HKEY = HKEY_CURRENT_USER): boolean;
function FxRegRInt(name: string; default: integer; path: string = sSettings; key: HKEY = HKEY_CURRENT_USER): integer;
function FxRegRStr(name, default: string; path: string = sSettings; key: HKEY = HKEY_CURRENT_USER): string;
procedure FxRegWBool(name: string; value: boolean; path: string = sSettings; key: HKEY = HKEY_CURRENT_USER);
procedure FxRegWInt(name: string; value: integer; path: string = sSettings; key: HKEY = HKEY_CURRENT_USER);
procedure FxRegWStr(name, value: string; path: string = sSettings; key: HKEY = HKEY_CURRENT_USER);

function RegDeleteKeyIncludingSubkeys(const Key: HKEY; const Name: PWideChar): Longint;


implementation

function TFRegistry.RBool(name: string; default: boolean): boolean;
begin
  try
    Result := ReadBool(name);
  except
    Result := default;
  end;
end;

function TFRegistry.RInt(name: string; default: integer): integer;
begin
  try
    Result := ReadInteger(name);
  except
    Result := default;
  end;
end;

function TFRegistry.RStr(name, default: string): string;
begin
  try
    Result := ReadString(name);
    if (Result = '') then
      Result := default;
  except
    Result := default;
  end;
end;

function TFRegistry.RBin(name: string; var buf; size: integer): boolean;
begin
  try
    Result := (ReadBinaryData(name, buf, size) > 0);
  except
    Result := false;
  end;
end;

procedure TFRegistry.RStrings(valueName: string; var strings: TStringList);
var
  valueType: DWORD;
  valueLen: DWORD;
  p, buffer: PWideChar;
begin
  strings.Clear();
  SetLastError(RegQueryValueEx(CurrentKey, PWideChar(valueName), Nil, @valueType, Nil, @valueLen));

  if (GetLastError() = ERROR_SUCCESS) then
    if (valueType = REG_MULTI_SZ) then
      begin
      GetMem(buffer, valueLen);
      try
        RegQueryValueEx(CurrentKey, PWideChar(valueName), Nil, Nil, PBYTE(buffer), @valueLen);
        p := buffer;

        while (p^ <> #0) do
          begin
          strings.Add(p);
          Inc(p, lstrlen(p) + 1);
          end;
      finally
        FreeMem(buffer);
      end;
      end;
end;

procedure TFRegistry.WBool(name: string; value: boolean);
begin
  try
    WriteBool(name, value);
  except
  end;
end;

procedure TFRegistry.WInteger(name: string; value: integer);
begin
  try
    WriteInteger(name, value);
  except
  end;
end;

procedure TFRegistry.WString(name, value: string);
begin
  try
    WriteString(name, value);
  except
  end;
end;

procedure TFRegistry.WBin(name: string; var buf; size: integer);
begin
  try
    WriteBinaryData(name, buf, size);
  except
  end;
end;

procedure TFRegistry.WStrings(valueName: string; var strings: TStringList);
var
  p, buffer: PWideChar;
  i: integer;
  size: DWORD;
begin
  size := 0;

  for i := 0 to (strings.Count - 1) do
    Inc(size, Length(strings[i]) * SizeOf(char) + SizeOf(char));

  Inc(size, SizeOf(char));
  GetMem(buffer, size);

  try
    p := buffer;

    for i := 0 to (strings.Count - 1) do
      begin
      lstrcpy(p, PWideChar(strings[i]));
      Inc(p, lstrlen(p) + 1);
      end;

    p^ := #0;
    SetLastError(RegSetValueEx(CurrentKey, PWideChar(valueName), 0, REG_MULTI_SZ, buffer, size));

  finally
    FreeMem(buffer);
  end;
end;

function FxRegRBool(name: string; default: boolean; path: string = sSettings; key: HKEY = HKEY_CURRENT_USER): boolean;
var
  ireg: TFRegistry;
begin
  ireg := TFRegistry.Create(RA_READONLY);
  ireg.RootKey := key;

  if ireg.OpenKey(path, false) then
    begin
    Result := ireg.RBool(name, default);

    ireg.CloseKey();
    end
  else
    Result := default;

  FreeAndNil(ireg);
end;

function FxRegRInt(name: string; default: integer; path: string = sSettings; key: HKEY = HKEY_CURRENT_USER): integer;
var
  ireg: TFRegistry;
begin
  ireg := TFRegistry.Create(RA_READONLY);
  ireg.RootKey := key;

  if ireg.OpenKey(path, false) then
    begin
    Result := ireg.RInt(name, default);
        
    ireg.CloseKey();
    end
  else
    Result := default;

  FreeAndNil(ireg);
end;

function FxRegRStr(name, default: string; path: string = sSettings; key: HKEY = HKEY_CURRENT_USER): string;
var
  ireg: TFRegistry;
begin
  ireg := TFRegistry.Create(RA_READONLY);
  ireg.RootKey := key;

  if ireg.OpenKey(path, false) then
    begin
    Result := ireg.RStr(name, default);
        
    ireg.CloseKey();
    end
  else
    Result := default;

  FreeAndNil(ireg);
end;

procedure FxRegWBool(name: string; value: boolean; path: string = sSettings; key: HKEY = HKEY_CURRENT_USER);
var
  ireg: TFRegistry;
begin
  ireg := TFRegistry.Create(RA_FULL);
  ireg.RootKey := key;

  if ireg.OpenKey(path, true) then
    begin
    ireg.WBool(name, value);
        
    ireg.CloseKey();
    end;

  FreeAndNil(ireg);
end;

procedure FxRegWInt(name: string; value: integer; path: string = sSettings; key: HKEY = HKEY_CURRENT_USER);
var
  ireg: TFRegistry;
begin
  ireg := TFRegistry.Create(RA_FULL);
  ireg.RootKey := key;

  if ireg.OpenKey(path, true) then
    begin
    ireg.WInteger(name, value);
        
    ireg.CloseKey();
    end;

  FreeAndNil(ireg);
end;

procedure FxRegWStr(name, value: string; path: string = sSettings; key: HKEY = HKEY_CURRENT_USER);
var
  ireg: TFRegistry;
begin
  ireg := TFRegistry.Create(RA_FULL);
  ireg.RootKey := key;

  if ireg.OpenKey(path, true) then
    begin
    ireg.WString(name, value);
        
    ireg.CloseKey();
    end;

  FreeAndNil(ireg);
end;

function RegDeleteKeyIncludingSubkeys(const Key: HKEY; const Name: PWideChar): Longint;
var
  H: HKEY;
  KeyName: String;
  KeyNameCount, MaxCount: DWORD;
  FT: TFileTime;
  I: Integer;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    begin
    if RegOpenKeyEx(Key, Name, 0, KEY_ENUMERATE_SUB_KEYS or KEY_QUERY_VALUE, H) = ERROR_SUCCESS then
      begin
      if RegQueryInfoKey(H, nil, nil, nil, nil, @MaxCount, nil, nil, nil, nil, nil, nil) = ERROR_SUCCESS then
        begin
        if MaxCount < 1 then
          MaxCount := 1;
        SetLength(KeyName, MaxCount);
        I := 0;

        while True do
          begin
          KeyNameCount := MaxCount+1;

          if RegEnumKeyEx(H, I, PWideChar(KeyName), KeyNameCount, nil, nil, nil, @FT) <> ERROR_SUCCESS then
            Break;
          if RegDeleteKeyIncludingSubkeys(H, PWideChar(KeyName)) <> ERROR_SUCCESS then
            Inc(I);
          end;
        end;

      RegCloseKey(H);
      end;
    end;

  Result := RegDeleteKey(Key, Name);
end;

end.
