unit c_utils;

interface

uses
  Windows, SysUtils, Classes, UxTheme, ShlObj, ActiveX,
  c_const;

// known folders
const
  FOLDERID_Desktop: TGUID = '{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}';
  FOLDERID_LocalAppData: TGUID = '{F1B32785-6FBA-4FCF-9D55-7B8E7F157091}';
  FOLDERID_ProgramData: TGUID = '{62AB5D82-FDC1-4DC3-A9DD-070D1D495D97}';
  FOLDERID_ProgramFiles: TGUID = '{905e63b6-c1bf-494e-b29c-65b732d3d21a}';
  FOLDERID_RoamingAppData: TGUID = '{3EB685DB-65F9-4CF6-A03A-E3EF65729F3D}';
  FOLDERID_System: TGUID = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}';
  FOLDERID_SystemX86: TGUID = '{D65231B0-B2F1-4857-A4CE-A8E7C6EA7D27}';
  FOLDERID_Windows: TGUID = '{F38BF404-1D43-42F2-9305-67DE0B28FC23}';

// search functions
procedure ScanFolderRecL(path, mask: string; var list: TStringList);
procedure ScanFolderRecLF(path, mask: string; var list: TStringList; func: TStringCallBack);
procedure ScanFolderRecF(path, mask: string; func: TStringCallBack);
procedure ScanFolderL(path, mask: string; var list: TStringList);
procedure ScanFolderLF(path, mask: string; var list: TStringList; func: TStringCallBack);
procedure ScanFolderF(path, mask: string; func: TStringCallBack);

// file-related functions
function DirExists(name: string): boolean;
function DirCreate(name: string): boolean;
function FileSize(path: string): integer;
function ExtractExt(filename: string): string;
procedure ExecAndWait(path, param: string);

// string functions
function Slash(what: string): string;
function NoSlash(what: string): string;
function StrLeft(const s: string; count: integer): string;
procedure StrSplit(s: string; sep: string; const list: TStrings);
procedure StrSplitI(s: string; sep: string; const list: TStrings);

// system functions
function IsXP(): boolean;
function IsVista(): boolean;
function IsWin7(): boolean;
function IsWin64(): boolean;
function IsThemed(): boolean;

// information functions
function GetShellFolderPath(const FolderID: Integer): string;
function GetKnownFolderPath(folderID: TGUID): string;
function GetModuleLocation(md: cardinal): string;

// resource functions
function LoadResString(inst: cardinal; id: integer): string;


implementation

procedure ScanFolderRecL(path, mask: string; var list: TStringList);
var
  res: TSearchRec;
  tpath: string;
begin
  tpath := Slash(path);

  // scan in folder itself
  ScanFolderL(tpath, mask, list);

  // subfolders
  if (FindFirst(tpath + '*.*', faDirectory, res) = 0) then
    begin
    repeat
      if (((res.Attr and faDirectory) <> 0) and (res.Name <> '.') and (res.Name <> '..')) then
        ScanFolderL(Slash(tpath + res.Name), mask, list);
    until
      (FindNext(res) <> 0);
    end;
        
  FindClose(res);
end;

procedure ScanFolderRecLF(path, mask: string; var list: TStringList; func: TStringCallBack);
var
  res: TSearchRec;
  tpath: string;
begin
  tpath := Slash(path);

  // scan in folder itself
  ScanFolderLF(tpath, mask, list, func);

  // subfolders
  if (FindFirst(tpath + '*.*', faDirectory, res) = 0) then
    begin
    repeat
      if (((res.Attr and faDirectory) <> 0) and (res.Name <> '.') and (res.Name <> '..')) then
        ScanFolderLF(Slash(tpath + res.Name), mask, list, func);
    until
      (FindNext(res) <> 0);
    end;

  FindClose(res);
end;

procedure ScanFolderRecF(path, mask: string; func: TStringCallBack);
var
  res: TSearchRec;
  tpath: string;
begin
  tpath := Slash(path);

  // scan in folder itself
  ScanFolderF(tpath, mask, func);

  // subfolders
  if (FindFirst(tpath + '*.*', faDirectory, res) = 0) then
    begin
    repeat
      if (((res.Attr and faDirectory) <> 0) and (res.Name <> '.') and (res.Name <> '..')) then
        ScanFolderF(Slash(tpath + res.Name), mask, func);
    until
      (FindNext(res) <> 0);
    end;

  FindClose(res);
end;

procedure ScanFolderL(path, mask: string; var list: TStringList);
var
  res: TSearchRec;
  tpath: string;
begin
  tpath := Slash(path);

  if (FindFirst(tpath + mask, faReadOnly + faHidden + faSysFile + faArchive, res) = 0) then
    begin
    repeat
      if (list <> nil) then
        list.Add(tpath + res.Name);
    until
      (FindNext(res) <> 0);
    end;

  FindClose(res);
end;

procedure ScanFolderLF(path, mask: string; var list: TStringList; func: TStringCallBack);
var
  res: TSearchRec;
  tpath: string;
begin
  tpath := Slash(path);

  if (FindFirst(tpath + mask, faReadOnly + faHidden + faSysFile + faArchive, res) = 0) then
    begin
    repeat
      if (list <> nil) then
        list.Add(tpath + res.Name);
      if (@func <> nil) then
        func(tpath + res.Name);
    until
      (FindNext(res) <> 0);
    end;

  FindClose(res);
end;

procedure ScanFolderF(path, mask: string; func: TStringCallBack);
var
  res: TSearchRec;
  tpath: string;
begin
  tpath := Slash(path);

  if (FindFirst(tpath + mask, faReadOnly + faHidden + faSysFile + faArchive, res) = 0) then
    begin
    repeat
      if (@func <> nil) then
        func(tpath + res.Name);
    until
      (FindNext(res) <> 0);
    end;

  FindClose(res);
end;

// returns true if "name" folder exists
function DirExists(name: string): boolean;
var
  code: integer;
begin
  code := GetFileAttributes(PWideChar(name));
  Result := ((code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and code <> 0));
end;

// creates new folder
function DirCreate(name: string): boolean;
begin
  Result := CreateDirectory(PWideChar(name), nil);
end;

// returns file size (in bytes)
function FileSize(path: string): integer;
var
  tmp: THandle;
begin
  tmp := CreateFile(PWideChar(path), GENERIC_READ, FILE_SHARE_READ + FILE_SHARE_WRITE, nil, OPEN_EXISTING, 0, 0);

  if (tmp <> INVALID_HANDLE_VALUE) then
    begin
    Result := GetFileSize(tmp, nil);
    CloseHandle(tmp);
    end
  else
    Result := -1;
end;

// returns lowercase file extension without dot
function ExtractExt(filename: string): string;
begin
  Result := ExtractFileExt(filename);

  if (Result <> '') then
    begin
    Delete(Result, 1, 1);
    Result := LowerCase(Result);
    end;
end;

// runs app and waits for end of it's execution
procedure ExecAndWait(path, param: string);
var
  start: TStartupInfo;
  info: TProcessInformation;
begin
  // filling TStartupInfo
  start.lpReserved := nil;
  start.lpDesktop := nil;
  start.lpTitle := nil;
  start.dwFlags := STARTF_USESHOWWINDOW;
  start.wShowWindow := SW_SHOWNORMAL;
  start.cbReserved2 := 0;
  start.lpReserved2 := nil;
  start.cb := SizeOf(start);

  // running
  CreateProcess(PWideChar(path), PWideChar(param), nil, nil, false, 0, nil, nil, start, info);
  WaitForSingleObject(info.hProcess, INFINITE);
end;

// adds "\" to the end of path and removes spaces (if exist)
function Slash(what: string): string;
begin
  Result := IncludeTrailingBackSlash(Trim(what));
end;

// removes "\" from the end of path and removes spaces (if exist)
function NoSlash(what: string): string;
begin
  Result := ExcludeTrailingBackSlash(Trim(what));
end;

// returns string to the left
function StrLeft(const s: string; count: integer): string;
begin
  Result := Copy(s, 1, count);
end;

// splits string into parts ('' NOT ignored)
procedure StrSplit(s: string; sep: string; const list: TStrings);
var
  i,l: integer;
  left: string;
begin
  if (list <> nil) then
    begin
    list.Clear();
    l := Length(sep);
    i := Pos(sep, s);

    while (i > 0) do
      begin
      left := StrLeft(s, (i - 1));
      list.Add(left);
      Delete(s, 1, (i + l - 1));
      i := Pos(sep, s);
      end;

    list.Add(s);
    end
  else
    Abort();
end;

// splits string into parts ('' ignored)
procedure StrSplitI(s: string; sep: string; const list: TStrings);
var
  i,l: integer;
  left: string;
begin
  if (list <> nil) then
    begin
    list.Clear();
    l := Length(sep);
    i := Pos(sep, s);

    while (i > 0) do
      begin
      left := StrLeft(s, (i - 1));
      list.Add(left);
      Delete(s, 1, (i + l - 1));
      i := Pos(sep, s);
      end;

    if (s <> '') then
      list.Add(s);
    end
  else
    Abort();
end;

// returns true if current OS is WindowsXP (or newer)
function IsXP(): boolean;
begin
  Result := ((Win32MajorVersion > 5) or ((Win32MajorVersion = 5) and (Win32MinorVersion >= 1)));
end;

// returns true if current OS is Windows Vista (or newer)
function IsVista(): boolean;
begin
  Result := (Win32MajorVersion >= 6);
end;

// returns true if current OS is Windows 7 (or newer)
function IsWin7(): boolean;
begin
  Result := ((Win32MajorVersion > 6) or ((Win32MajorVersion = 6) and (Win32MinorVersion >= 1)));
end;

// returns true if application is running on 64-bit Windows as WOW64 process
function IsWin64(): boolean;
type
  TIsWow64Process = function(hProcess: THandle; var Wow64Process: BOOL): BOOL; stdcall;
var
  func: TIsWow64Process;
  lib: THandle;
  temp: BOOL;
  res: boolean;
begin
  res := false;
  lib := LoadLibrary('kernel32.dll');

  if (lib <> 0) then
    begin
    @func := GetProcAddress(lib, 'IsWow64Process');

    if Assigned(func) then
      begin
      if func(GetCurrentProcess(), temp) then
        res := temp;
      end;

    FreeLibrary(lib);
    end;

  Result := res;
end;

// returns true if application is currently themed
function IsThemed(): boolean;
begin
  Result := (IsXP() and UxTheme.UseThemes());
end;

// returns special shell folders paths
function GetShellFolderPath(const FolderID: Integer): string;
var
  pidl: PItemIDList;
  Buffer: array[0..MAX_PATH-1] of Char;
  Malloc: IMalloc;
begin
  Result := '';

  if FAILED(SHGetMalloc(Malloc)) then
    Malloc := nil;

  if SUCCEEDED(SHGetSpecialFolderLocation(0, FolderID, pidl)) then
    begin
    if SHGetPathFromIDList(pidl, Buffer) then
      Result := Buffer;
    if Assigned(Malloc) then
      Malloc.Free(pidl);
    end;
end;

// returns known folders path (Vista+ only)
function GetKnownFolderPath(folderID: TGUID): string;
type
  TSHGetKnownFolderPath = function(
    const rfid: PGUID; dwFlags: DWORD; hToken: THandle; out ppszPath: PWideChar): HRESULT; stdcall;
var
  func: TSHGetKnownFolderPath;
  lib: THandle;
  res: string;
  buf: PWideChar;
begin
  // safety check
  if not IsVista then
    Exit('');

  // initializing
  res := '';

  // trying to get the function
  lib := LoadLibrary('shell32.dll');

  if (lib <> 0) then
    begin
    @func := GetProcAddress(lib, 'SHGetKnownFolderPath');

    if Assigned(func) then
      begin
      if Succeeded(func(@folderID, 0, 0, buf)) then
        begin
        res := buf;
        CoTaskMemFree(buf);
        end;
      end;

    FreeLibrary(lib);
    end;

  Result := res;
end;

// returns module path
function GetModuleLocation(md: cardinal): string;
var
  buf: array[0..MAX_PATH] of WideChar;
begin
  GetModuleFileName(md, buf, MAX_PATH);
  Result := buf;
end;

// loads resource string from custom library
function LoadResString(inst: cardinal; id: integer): string;
const
  MAX_RES_STRING_SIZE = 4097;
var
  buf: array[0..MAX_RES_STRING_SIZE] of WideChar;
begin
  // default result is empty
  Result := '';

  if (inst <> 0) then
    begin
    if (LoadStringW(inst, id, buf, MAX_RES_STRING_SIZE) > 0) then
      Result := buf;
    end;
end;

end.
