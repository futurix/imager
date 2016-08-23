///////////////////////////////////////////////////////////////////////////////////////////////
//
// FileUtils.pas
// --------------------------
// Changed:   2003-07-09
// Maintain:  Michael Vinther   |   mv@logicnet.dk
//
// Last change:
//   MaskCompare removed
//   RemoveBackslash does not change root string, e.g. "C:\"
//
unit FileUtils;

interface

uses Windows, SysUtils, Forms, ShellAPI, Classes, MemUtils, Controls, Messages, Registry,
  Shlobj;

var ProgramPath : string; // Path to program executable including '\'

const
  faFile      = faReadOnly or faHidden or faSysFile or faArchive;
  faFileOrDir = faFile or faDirectory;

// Append text line to file
procedure WriteLog(const FileName, LogLine: string);
// Execute file. Failure if Result<=32
function ExecuteFile(const FileName: string; const Params: string=''; const DefaultDir: string=''; ShowCmd: Integer=SW_SHOW): THandle;
// Return file name without extension
function RemoveFileExt(FileName: string): string;
// Extract file extension without .
function ExtractFileExtNoDot(const FileName: string): string;
// Return path name with a \ as the last character
function ForceBackslash(const PathName: string): string;
// Remove \ from end of path if not drive root e.g. "C:\"
function RemoveBackslash(const PathName: string): string;
// Get size of file
function GetFileSize(FileName: string): Int64;
function SearchRecFileSize64(const SearchRec: TSearchRec): Int64;
// If recursive, Search must end with \ and all files will be included
procedure GetDirList(const Search: string; List: TStrings; Recursive: Boolean=False);
// Delete file(s).
// Default is flags will recycle: FOF_ALLOWUNDO|FOF_NOCONFIRMATION|FOF_SILENT|FOF_NOERRORUI
// Multiple files can be seperated by #0, wildcards are allowed, full path must be specified
function DeleteFileEx(FileName: string; Flags: FILEOP_FLAGS=0): Boolean;
// Move file(s).
// Default is flags will overwrite: FOF_NOCONFIRMMKDIR or FOF_NOCONFIRMATION or FOF_SILENT or FOF_NOERRORUI
// Multiple files can be seperated by #0, wildcards are allowed, full path must be specified
function MoveFile(Source,Dest: string; Flags: FILEOP_FLAGS=0): Boolean;
function CopyFile(Source,Dest: string; CanOverwrite: Boolean): Boolean;

function MakeValidFileName(const Str: string): string;

// Show standard Windows dialogs
procedure ShowFileProperties(const FileName: string);
procedure ShowSearchDialog(const Directory: string);

function GetParameterFileName: string;

// Get file dropped by WM_DROPFILES
function GetDroppedFile(const Msg: TWMDropFiles; Index: Integer=0): string;

procedure RegisterFileFormat(Extension,AppID: string; Description: string=''; Executable: string=''; IconIndex: Integer=0);

implementation

function MakeValidFileName(const Str: string): string;
const
  FileNameChars = ['A'..'Z','0'..'9','.','_','~','-','@','='];
  ReplaceChar = '_';
var
  I : Integer;
begin
  Result:=Str;
  for I:=1 to Length(Result) do
    if not (UpCase(Result[I]) in FileNameChars) then Result[I]:=ReplaceChar;
  if Result='' then Result:='-';
  if Result[1]='.' then Result:=ReplaceChar+Result;
  if Length(Result)>255 then SetLength(Result,255);
end;

procedure GetDirList(const Search: string; List: TStrings; Recursive: Boolean);
var
  SRec : TSearchRec;
  E : Integer;
  Path : string;
begin
  List.BeginUpdate;
  if Recursive then
  begin
    Path:=Search;
    E:=FindFirst(Search+'*.*',faFileOrDir,SRec);
  end
  else
  begin
    Path:=ExtractFilePath(Search);
    E:=FindFirst(Search,faFileOrDir,SRec);
  end;
  try
    while E=0 do
    begin
      if SRec.Attr and faDirectory<>0 then
      begin
        if Recursive  and (SRec.Name<>'.') and (SRec.Name<>'..') then GetDirList(Path+SRec.Name+'\',List,True);
      end
      else List.Add(Path+SRec.Name);
      E:=FindNext(SRec);
    end;
  finally
    FindClose(SRec);
    List.EndUpdate;
  end;
end;

procedure WriteLog(const FileName, LogLine: string);
var Log : TextFile;
begin
  try
    Assign(Log,FileName);
    {$I-} Append(Log); {$I+}
    if IOResult<>0 then Rewrite(Log);
    try
      WriteLn(Log,LogLine);
    finally
      CloseFile(Log);
    end;
  except
  end;
end;

// Execute file. ShowCmd is often SW_SHOW
function ExecuteFile(const FileName,Params,DefaultDir: string; ShowCmd: Integer): THandle;
begin
  Result:=ShellExecute(0,nil,
                       PChar(FileName),
                       PChar(Params),
                       PChar(DefaultDir),ShowCmd);
end;

function ExtractFileExtNoDot(const FileName: string): string;
var I : Integer;
begin
  I := LastDelimiter('.\:',FileName);
  if (I>0) and (FileName[I]='.') then Result:=Copy(FileName,I+1,MaxInt)
  else Result:='';
end;

function RemoveFileExt(FileName: string): string;
var P : Integer;
begin
  for P:=Length(FileName) downto 1 do
    if FileName[P]='\' then Break
    else if FileName[P]='.' then
    begin
      Result:=Copy(FileName,1,P-1);
      Exit;
    end;
  Result:=FileName;
end;

function ForceBackslash(const PathName: string): string;
begin
  Result:=PathName;
  if (PathName<>'') and (Result[Length(Result)]<>'\') then Result:=Result+'\';
end;

function RemoveBackslash(const PathName: string): string;
begin
  Result:=PathName;
  if (Length(Result)>1) and
     (Result[Length(Result)]='\') and
     ((Length(Result)<>3) or (Result[2]<>':')) then SetLength(Result,Length(Result)-1);
end;

function GetFileSize(FileName: string): Int64;
var
  Handle: THandle;
  FindData: TWin32FindData;
begin
  Result:=-1;
  Handle:=FindFirstFile(PChar(FileName),FindData);
  if Handle<>INVALID_HANDLE_VALUE then
  begin
    Windows.FindClose(Handle);
    if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY)=0 then
    begin
      Result:=FindData.nFileSizeLow or (Int64(FindData.nFileSizeHigh) shl 32);
    end;
  end;
end;

function DeleteFileEx(FileName: string; Flags: FILEOP_FLAGS): Boolean;
var
  fos : TSHFileOpStruct;
begin
  if FileName='' then
  begin
    Result:=False;
    Exit;
  end;
  if FileName[Length(FileName)]<>#0 then FileName:=FileName+#0;
  ZeroMem(fos,SizeOf(fos));
  with fos do
  begin
    Wnd:=Application.Handle;
    wFunc:=FO_DELETE;
    pFrom:=PChar(FileName);
    if Flags=0 then fFlags:=FOF_ALLOWUNDO or FOF_NOCONFIRMATION or FOF_SILENT or FOF_NOERRORUI
    else fFlags:=Flags;
  end;
  Result:=SHFileOperation(fos)=0;
end;

function MoveFile(Source,Dest: string; Flags: FILEOP_FLAGS=0): Boolean;
var
  fos : TSHFileOpStruct;
begin
  if (Source='') or (Dest='') then
  begin
    Result:=False;
    Exit;
  end;
  if Source[Length(Source)]<>#0 then Source:=Source+#0;
  if Dest[Length(Dest)]<>#0 then Dest:=Dest+#0;
  ZeroMem(fos,SizeOf(fos));
  with fos do
  begin
    Wnd:=Application.Handle;
    wFunc:=FO_MOVE;
    pFrom:=PChar(Source);
    pTo:=PChar(Dest);
    if Flags=0 then fFlags:=FOF_NOCONFIRMMKDIR or FOF_NOCONFIRMATION or FOF_SILENT or FOF_NOERRORUI
    else fFlags:=Flags;
  end;
  Result:=SHFileOperation(fos)=0;
end;

function CopyFile(Source,Dest: string; CanOverwrite: Boolean): Boolean;
begin
  Result:=Windows.CopyFile(PChar(Source),PChar(Dest),not CanOverwrite);
end;

function GetParameterFileName: string;
var
  I : Integer;
begin
  Result:=ParamStr(1);
  for I:=2 to ParamCount do Result:=Result+' '+ParamStr(I);
end;

procedure ShowFileProperties(const FileName: string);
var
  SEI : SHELLEXECUTEINFO;
begin
 ZeroMem(SEI,SizeOf(SEI));
 with SEI do
 begin
   cbSize:=SizeOf(SEI);
   fMask:=SEE_MASK_NOCLOSEPROCESS or SEE_MASK_INVOKEIDLIST or SEE_MASK_FLAG_NO_UI;
   Wnd:=Application.Handle;
   lpVerb:='properties';
   lpFile:=PChar(FileName);
  end;
  if not ShellExecuteEx(@SEI) then RaiseLastWin32Error;
end;

procedure ShowSearchDialog(const Directory: string);
var
  SEI : SHELLEXECUTEINFO;
begin
 ZeroMem(SEI,SizeOf(SEI));
 with SEI do
 begin
   cbSize:=SizeOf(SEI);
   fMask:=SEE_MASK_NOCLOSEPROCESS or SEE_MASK_INVOKEIDLIST or SEE_MASK_FLAG_NO_UI;
   Wnd:=Application.Handle;
   lpVerb:='find';
   lpFile:=PChar(Directory);
  end;
  if not ShellExecuteEx(@SEI) then RaiseLastWin32Error;
end;

function GetDroppedFile(const Msg: TWMDropFiles; Index: Integer): string;
begin
  SetLength(Result,DragQueryFile(Msg.Drop,Index,nil,0));
  DragQueryFile(Msg.Drop,Index,@Result[1],Length(Result)+1);
end;

function SearchRecFileSize64(const SearchRec: TSearchRec): Int64;
begin
  Result:=(Int64(SearchRec.FindData.nFileSizeHigh) shl 32) or SearchRec.FindData.nFileSizeLow
end;

procedure RegisterFileFormat(Extension,AppID,Description,Executable: string; IconIndex: Integer);
var
  Reg: TRegistry;
  P : Integer;
  IsIcon : Boolean;
begin
  Extension:=LowerCase(Extension);
  if Extension[1]<>'.' then Extension:='.'+Extension;
  if Executable='' then Executable:=ParamStr(0);
  IsIcon:=(Extension='.ico') or (Extension='.cur') or (Extension='.ani');
  repeat
    P:=Pos(' ',AppID);
    if P=0 then Break;
    Delete(AppID,P,1);
  until False;

  if (Description='') and not IsIcon then AppID:=AppID+'.'+IntToStr(IconIndex)
  else AppID:=AppID+Extension;

  Reg := TRegistry.Create;
  try
    // Add HKEY_CLASSES_ROOT\.<Extension>\(Default) = <AppID>
    Reg.RootKey:=HKEY_CLASSES_ROOT;
    Reg.OpenKey(Extension,True);
    Reg.WriteString('',AppID);
    Reg.CloseKey;

    // Now create an association for that file type
    // This adds HKEY_CLASSES_ROOT\<AppID>\(Default) = <Description>
    Reg.OpenKey(AppID,True);
    Reg.WriteString('',Description);
    Reg.CloseKey;

    if IconIndex>=0 then
    begin
      // Now write the default icon for my file type
      // This adds HKEY_CLASSES_ROOT\<AppID>\DefaultIcon\(Default) = <Executable>,<IconIndex>
      Reg.OpenKey(AppID+'\DefaultIcon', True);
      if IsIcon then Reg.WriteString('','"%1"')
      else Reg.WriteString('','"'+Executable+'",'+IntToStr(IconIndex));
      Reg.CloseKey;
    end;

    // Now write the open action in explorer
    {Reg.OpenKey(AppID+'\Shell\Open',True);
    Reg.WriteString('', '&Open');
    Reg.CloseKey;}

    // Write what application to open it with
    // This adds HKEY_CLASSES_ROOT\<AppID>\Shell\Open\Command\ (Default) = "<Executable>" "%1"
    Reg.OpenKey(AppID+'\Shell\Open\Command',True);
    Reg.WriteString('', '"'+Executable+'" "%1"');
    Reg.CloseKey;
  finally
    Reg.Free;
  end;
  // Finally, we want the Windows Explorer to realize we added our file type
  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

var P : Integer;
initialization
  ProgramPath:=ParamStr(0); P:=Length(ProgramPath);
  while (P>0) and (ProgramPath[P]<>'\') do Dec(P);
  SetLength(ProgramPath,P);
end.

