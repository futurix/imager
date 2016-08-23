// fail-safe registry object 
unit c_reg;

interface

uses
  Windows, SysUtils, Registry;

type
  TFuturisRegistry = class(TRegistry)
  private
    // nothing here
  protected
    // nothing here
  public
    function RBool(name: string; default: boolean):boolean;
    function RBoolC(name: string; default: boolean):boolean;
    function RInt(name: string; default: integer):integer;
    function RIntC(name: string; default: integer):integer;
    function RStr(name, default: string):string;
    function RStrC(name, default: string):string;
    procedure WBool(name: string; value: boolean);
    procedure WInteger(name: string; value: integer);
    procedure WString(name, value: string);
  end;

function RegDeleteKeyIncludingSubkeys(const Key: HKEY; const Name: PChar): Longint;


implementation

function TFuturisRegistry.RBool(name: string; default: boolean):boolean;
begin
try
  Result:=ReadBool(name);
  except
    Result:=default;
  end;
end;

function TFuturisRegistry.RBoolC(name: string; default: boolean):boolean;
begin
try
  Result:=ReadBool(name);
  except
    Result:=default;
    WBool(name,default);
  end;
end;

function TFuturisRegistry.RInt(name: string; default: integer):integer;
begin
try
  Result:=ReadInteger(name);
  except
    Result:=default;
  end;
end;

function TFuturisRegistry.RIntC(name: string; default: integer):integer;
begin
try
  Result:=ReadInteger(name);
  except
    Result:=default;
    WInteger(name,default);
  end;
end;

function TFuturisRegistry.RStr(name, default: string):string;
begin
try
  Result:=ReadString(name);
  if Result='' then Result:=default;
  except
    Result:=default;
  end;
end;

function TFuturisRegistry.RStrC(name, default: string):string;
begin
try
  Result:=ReadString(name);
  if Result='' then
    begin
    Result:=default;
    WString(name,default);
    end;
  except
    Result:=default;
    WString(name,default);
  end;
end;

procedure TFuturisRegistry.WBool(name: string; value: boolean);
begin
try
  WriteBool(name,value);
  except end;
end;

procedure TFuturisRegistry.WInteger(name: string; value: integer);
begin
try
  WriteInteger(name,value);
  except end;
end;

procedure TFuturisRegistry.WString(name, value: string);
begin
try
  WriteString(name,value);
  except end;
end;

function RegDeleteKeyIncludingSubkeys(const Key: HKEY; const Name: PChar): Longint;
var
  H: HKEY;
  KeyName: String;
  KeyNameCount, MaxCount: DWORD;
  FT: TFileTime;
  I: Integer;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then begin
    if RegOpenKeyEx(Key, Name, 0, KEY_ENUMERATE_SUB_KEYS or KEY_QUERY_VALUE, H) = ERROR_SUCCESS then begin
      if RegQueryInfoKey(H, nil, nil, nil, nil, @MaxCount, nil, nil, nil, nil,
         nil, nil) = ERROR_SUCCESS then begin
        if MaxCount < 1 then MaxCount := 1;
        SetLength(KeyName, MaxCount);
        I := 0;
        while True do begin
          KeyNameCount := MaxCount+1;
          if RegEnumKeyEx(H, I, PChar(KeyName), KeyNameCount, nil, nil, nil, @FT) <> ERROR_SUCCESS then
            Break;
          if RegDeleteKeyIncludingSubkeys(H, PChar(KeyName)) <> ERROR_SUCCESS then
            Inc(I);
        end;
      end;
      RegCloseKey(H);
    end;
  end;
  Result := RegDeleteKey(Key, Name);
end;

end.
