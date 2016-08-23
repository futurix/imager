// fail-safe registry object 
unit c_reg;

interface

uses
  Windows, SysUtils, Classes, Registry;

type
  TFRegistry = class(TRegistry)
  public
  	procedure RStrings(valueName: string; var strings : TStringList);
  	procedure WStrings(valueName: string; var strings : TStringList);
    function RBool(name: string; default: boolean):boolean;
    function RInt(name: string; default: integer):integer;
    function RStr(name, default: string):string;
    procedure WBool(name: string; value: boolean);
    procedure WInteger(name: string; value: integer);
    procedure WString(name, value: string);
  end;

function RegDeleteKeyIncludingSubkeys(const Key: HKEY; const Name: PChar): Longint;


implementation

procedure TFRegistry.RStrings(valueName: string; var strings: TStringList);
var
	valueType: DWORD;
	valueLen: DWORD;
	p, buffer: PChar;
begin
	strings.Clear();
	SetLastError(RegQueryValueEx(CurrentKey, PChar(valueName), Nil, @valueType, Nil, @valueLen));

	if (GetLastError() = ERROR_SUCCESS) then
    	if (valueType = REG_MULTI_SZ) then
    		begin
      		GetMem(buffer, valueLen);
      		try
        		RegQueryValueEx(CurrentKey, PChar(valueName), Nil, Nil, PBYTE(buffer), @valueLen);
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

procedure TFRegistry.WStrings(valueName: string; var strings: TStringList);
var
	p, buffer: PChar;
	i: Integer;
	size: DWORD;
begin
	size := 0;

	for i := 0 to (strings.Count - 1) do
    	Inc(size, Length(strings[i]) + 1);

  	Inc(size);
  	GetMem(buffer, size);

  	try
    	p := buffer;

    	for i := 0 to (strings.Count - 1) do
    		begin
      		lstrcpy(p, PChar(strings[i]));
      		Inc(p, lstrlen(p) + 1);
    		end;

    	p^ := #0;
    	SetLastError(RegSetValueEx(CurrentKey, PChar(valueName), 0, REG_MULTI_SZ, buffer, size));

  	finally
    	FreeMem(buffer);
  	end;
end;

function TFRegistry.RBool(name: string; default: boolean):boolean;
begin
	try
  		Result := ReadBool(name);
    except
    	Result := default;
    end;
end;

function TFRegistry.RInt(name: string; default: integer):integer;
begin
	try
  		Result := ReadInteger(name);
  	except
    	Result := default;
  	end;
end;

function TFRegistry.RStr(name, default: string):string;
begin
	try
  		Result := ReadString(name);
  		if (Result = '') then
    		Result := default;
  	except
    	Result := default;
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
  		WriteString(name,value);
  	except
    end;
end;

function RegDeleteKeyIncludingSubkeys(const Key: HKEY; const Name: PChar): Longint;
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
      		if RegQueryInfoKey(	H, nil, nil, nil, nil, @MaxCount, nil, nil, nil, nil,
         						nil, nil) = ERROR_SUCCESS then
            	begin
        		if MaxCount < 1 then
                	MaxCount := 1;
        		SetLength(KeyName, MaxCount);
                I := 0;

        		while True do
                	begin
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
