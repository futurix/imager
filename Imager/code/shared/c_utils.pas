// various utility functions 
unit c_utils;

interface

uses
  Windows, SysUtils, Classes, UxTheme, ShlObj, ActiveX,
  c_const;
  
// search functions
procedure ScanFolderRecL(path, mask: string; var list: TStringList);
procedure ScanFolderRecLF(path, mask: string; var list: TStringList; func: TStringCallBack);
procedure ScanFolderRecF(path, mask: string; func: TStringCallBack);
procedure ScanFolderL(path, mask: string; var list: TStringList);
procedure ScanFolderLF(path, mask: string; var list: TStringList; func: TStringCallBack);
procedure ScanFolderF(path, mask: string; func: TStringCallBack);

// user notifications
procedure Notify(wnd: HWND; msg: string);
procedure Warn(wnd: HWND; msg: string);
procedure Die(wnd: HWND; msg: string);

// file-related functions 
function  DirExists(name: string): boolean;
function  DirCreate(name: string): boolean;
function  FileSize(path: string): integer;
function  ExtractExt(filename: string): string;
procedure ExecAndWait(path, param: string);

// string functions
function  Slash(what: string): string;
function  NoSlash(what: string): string;
function  StrLeft(const s: string; count: integer): string;
procedure StrSplit(s: string; sep: string; const list: TStrings);
procedure StrSplitI(s: string; sep: string; const list: TStrings);

// system functions
function  IsXP(): boolean;
function  IsThemed(): boolean;
function  GetShellFolderPath(const FolderID: Integer): string;

// resource functions
function  LoadResString(inst: cardinal; id: integer): string;


implementation

procedure ScanFolderRecL(path, mask: string; var list: TStringList);
var
  res: TSearchRec;
  tpath: string;
begin
tpath:=Slash(path);
// scan in folder itself
ScanFolderL(tpath,mask,list);
// subfolders
if FindFirst(tpath + '*.*',faDirectory,res)=0 then
  begin
  repeat
    if (((res.Attr and faDirectory)<>0) and (res.Name<>'.')and (res.Name<>'..'))
      then ScanFolderL(Slash(tpath + res.Name),mask,list);
    until FindNext(res)<>0;
  end;
FindClose(res);
end;

procedure ScanFolderRecLF(path, mask: string; var list: TStringList; func: TStringCallBack);
var
  res: TSearchRec;
  tpath: string;
begin
tpath:=Slash(path);
// scan in folder itself
ScanFolderLF(tpath,mask,list,func);
// subfolders
if FindFirst(tpath + '*.*',faDirectory,res)=0 then
  begin
  repeat
    if (((res.Attr and faDirectory)<>0) and (res.Name<>'.')and (res.Name<>'..'))
      then ScanFolderLF(Slash(tpath + res.Name),mask,list,func);
    until FindNext(res)<>0;
  end;
FindClose(res);
end;

procedure ScanFolderRecF(path, mask: string; func: TStringCallBack);
var
  res: TSearchRec;
  tpath: string;
begin
tpath:=Slash(path);
// scan in folder itself
ScanFolderF(tpath,mask,func);
// subfolders
if FindFirst(tpath + '*.*',faDirectory,res)=0 then
  begin
  repeat
    if (((res.Attr and faDirectory)<>0) and (res.Name<>'.')and (res.Name<>'..'))
      then ScanFolderF(Slash(tpath + res.Name),mask,func);
    until FindNext(res)<>0;
  end;
FindClose(res);
end;

procedure ScanFolderL(path, mask: string; var list: TStringList);
var
  res: TSearchRec;
  tpath: string;
begin
tpath:=Slash(path);
if FindFirst(tpath + mask,faReadOnly+faHidden+faSysFile+faArchive,res)=0 then
  begin
  repeat
    if list<>nil then list.Add(tpath + res.Name);
    until FindNext(res)<>0;
  end;
FindClose(res);
end;

procedure ScanFolderLF(path, mask: string; var list: TStringList; func: TStringCallBack);
var
  res: TSearchRec;
  tpath: string;
begin
tpath:=Slash(path);
if FindFirst(tpath + mask,faReadOnly+faHidden+faSysFile+faArchive,res)=0 then
  begin
  repeat
    if list<>nil then list.Add(tpath + res.Name);
    if @func<>nil then func(tpath + res.Name);
    until FindNext(res)<>0;
  end;
FindClose(res);
end;

procedure ScanFolderF(path, mask: string; func: TStringCallBack);
var
  res: TSearchRec;
  tpath: string;
begin
tpath:=Slash(path);
if FindFirst(tpath + mask,faReadOnly+faHidden+faSysFile+faArchive,res)=0 then
  begin
  repeat
    if @func<>nil then func(tpath + res.Name);
    until FindNext(res)<>0;
  end;
FindClose(res);
end;

procedure Notify(wnd: HWND; msg: string);
begin
MessageBox(wnd,PChar(msg),PChar(sAppName),MB_OK+MB_ICONINFORMATION);
end;

procedure Warn(wnd: HWND; msg: string);
begin
MessageBox(wnd,PChar(msg),PChar(sAppName),MB_OK+MB_ICONWARNING);
end;

procedure Die(wnd: HWND; msg: string);
begin
MessageBox(wnd,PChar(msg),PChar(sAppName),MB_OK+MB_ICONERROR);
Halt(1);
end;

// returns true if "name" folder exists
function DirExists(name: string):boolean;
var
  code: Integer;
begin
code:=GetFileAttributes(PChar(name));
Result:=(code<>-1) and (FILE_ATTRIBUTE_DIRECTORY and code<>0);
end;

// creates new folder
function DirCreate(name: string):boolean;
begin
Result:=CreateDirectory(PChar(name),nil);
end;

// returns file size (in bytes)
function FileSize(path: string):integer;
var
  tmp: THandle;
begin
tmp:=CreateFile(PChar(path),GENERIC_READ,FILE_SHARE_READ+FILE_SHARE_WRITE,
                nil,OPEN_EXISTING,0,0);
if tmp<>INVALID_HANDLE_VALUE then
  begin
  Result:=GetFileSize(tmp,nil);
  CloseHandle(tmp);
  end
else Result:=-1;
end;

// extracts file extension without dot
function ExtractExt(filename: string):string;
var
  i: Integer;
begin
i:=LastDelimiter('.' + PathDelim + DriveDelim,filename);
if ((i > 0) and (filename[i]='.')) then Result:=Copy(filename,i+1,MaxInt)
  else Result:='';
end;

// runs app and waits for end of it's execution
procedure ExecAndWait(path, param: string);
var
  start: TStartupInfo;
  info: TProcessInformation;
begin
// filling TStartupInfo
start.lpReserved:=nil;
start.lpDesktop:=nil;
start.lpTitle:=nil;
start.dwFlags:=STARTF_USESHOWWINDOW;
start.wShowWindow:=SW_SHOWNORMAL;
start.cbReserved2:=0;
start.lpReserved2:=nil;
start.cb:=SizeOf(start);
// running
CreateProcess(PChar(path),PChar(param),nil,nil,false,0,nil,nil,start,info);
WaitForSingleObject(info.hProcess,INFINITE);
end;

// adds "\" to the end of path and removes spaces (if exist)
function Slash(what: string):string;
begin
Result:=IncludeTrailingBackSlash(Trim(what));
end;

// removes "\" from the end of path and removes spaces (if exist)
function NoSlash(what: string):string;
begin
Result:=ExcludeTrailingBackSlash(Trim(what));
end;

// returns string to the left
function StrLeft(const s: string; count: integer):string;
begin
Result:=Copy(s,1,count);
end;

// splits string into parts ('' NOT ignored)
procedure StrSplit(s: string; sep: string; const list: TStrings);
var
  i,l: integer;
  left: string;
begin
if (list<>nil) then
  begin
  list.Clear();
  l:=Length(sep);
  i:=Pos(sep,s);
  while (i>0) do
    begin
    left:=StrLeft(s,i-1);
    list.Add(left);
    Delete(s,1,i+l-1);
    i:=Pos(sep,s);
    end;
  list.Add(s);
  end
else Abort();
end;

// splits string into parts ('' ignored)
procedure StrSplitI(s: string; sep: string; const list: TStrings);
var
  i,l: integer;
  left: string;
begin
if (list<>nil) then
  begin
  list.Clear();
  l:=Length(sep);
  i:=Pos(sep,s);
  while (i>0) do
    begin
    left:=StrLeft(s,i-1);
    list.Add(left);
    Delete(s,1,i+l-1);
    i:=Pos(sep,s);
    end;
  if s<>'' then list.Add(s);
  end
else Abort();
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

// returns true if WindowsXP (or newer OS) installed
function IsXP():boolean;
begin
	Result := (	(Win32Platform = VER_PLATFORM_WIN32_NT) and
    			((Win32MajorVersion > 5) or ((Win32MajorVersion = 5) and (Win32MinorVersion >= 1))));
end;

// loads resource string from custom library
function LoadResString(inst: cardinal; id: integer): string;
const
	MAX_RES_STRING_SIZE = 4097;
var
    fnc: integer;
    buf: array[0..MAX_RES_STRING_SIZE] of char;
begin
    // default result is empty
    Result := '';

    if (inst <> 0) then
    	begin
    	fnc := LoadString(inst, id, buf, sizeof(buf));

        if (fnc > 0) then
        	Result := buf;
        end;
end;

end.
