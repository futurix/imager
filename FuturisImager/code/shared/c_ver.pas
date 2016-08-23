// version info
unit c_ver;

interface

uses
  Windows, Classes, SysUtils;

const
  DEFAULT_LANG_ID       = $0409;
  DEFAULT_CHAR_SET_ID   = $04E4;
  DEFAULT_LANG_CHAR_SET = '040904E4';

resourcestring
  SFlagDebug = 'Debug';
  SFlagInfoInferred = 'Info Inferred';
  SFlagPatched = 'Patched';
  SFlagPreRelease = 'Pre-Release';
  SFlagPrivate = 'Private';
  SFlagSpecial = 'Special';
  SHeaderResource = 'Resource';
  SHeaderValue ='Value';

  { Predefined resource item captions. }  
  SResCapCompanyName = 'Company Name';
  SResCapFileDescription = 'File Description';
  SResCapFileVersion = 'File Version';
  SResCapInternalName = 'Internal Name';
  SResCapLegalCopyright = 'Legal Copyright';
  SResCapLegalTrademarks = 'Legal Trademarks';
  SResCapOriginalFilename = 'Original Filename';
  SResCapProductName = 'Product Name';
  SResCapProductVersion = 'Product Version';
  SResCapComments = 'Comments';
  SResCapBuildFlags = 'Build Flags';

{ set values to choose which resources are seen in the grid/listview }
type
  TPreDef = (pdCompanyName, pdFileDescription, pdFileVersion,
    pdInternalName, pdLegalCopyright, pdLegalTrademarks,
    pdOriginalFilename, pdProductName, pdProductVersion,
    pdComments, pdBuildFlags);
  TPreDefs = set of TPreDef;

{ but to index properties we need integers }
const
  IDX_COMPANYNAME           = ord (pdCompanyName);
  IDX_FILEDESCRIPTION       = ord (pdFileDescription);
  IDX_FILEVERSION           = ord (pdFileVersion);
  IDX_INTERNALNAME          = ord (pdInternalName);
  IDX_LEGALCOPYRIGHT        = ord (pdLegalCopyright);
  IDX_LEGALTRADEMARKS       = ord (pdLegalTrademarks);
  IDX_ORIGINALFILENAME      = ord (pdOriginalFilename);
  IDX_PRODUCTNAME           = ord (pdProductName);
  IDX_PRODUCTVERSION        = ord (pdProductVersion);
  IDX_COMMENTS              = ord (pdComments);
  IDX_BUILDFLAGS            = ord (pdBuildFlags);

const
  IDX_VER_MAJOR   = 0;
  IDX_VER_MINOR   = 1;
  IDX_VER_RELEASE = 2;
  IDX_VER_BUILD   = 3;

type
  TFixedFileInfoFlag = (ffDebug, ffInfoInferred, ffPatched, ffPreRelease,
      ffPrivateBuild, ffSpecialBuild);
  TFixedFileInfoFlags = set of TFixedFileInfoFlag;

  TVersionOperatingSystemFlag = (vosUnknown, vosDOS, vosOS2_16, vosOS2_32,
      vosNT, vosWindows16, vosPresentationManager16, vosPresentationManager32, vosWindows32);
  { This is supposed to be one of the first line, and one of the second line. }
  TVersionOperatingSystemFlags = set of TVersionOperatingSystemFlag;

  TVersionFileType = (vftUnknown, vftApplication, vftDLL, vftDriver, vftFont,
      vftVXD, vftStaticLib);

  TVInfo = class; { forward declaration }

  TFixedFileVersionInfo = class
  private
    FParent: TVInfo;
    FData: PVSFixedFileInfo;

    function GetSignature: DWORD;
    function GetStructureVersion: DWORD;
    function GetFileVersionMS: DWORD;
    function GetFileVersionLS: DWORD;
    function GetProductVersionMS: DWORD;
    function GetProductVersionLS: DWORD;
    function GetValidFlags: TFixedFileInfoFlags;
    function GetFlags: TFixedFileInfoFlags;
    function GetFileOperatingSystem: TVersionOperatingSystemFlags;
    function GetFileType: TVersionFileType;
    function GetFileSubType: DWORD;
    function GetCreationDate: TDateTime;
  public
    constructor Create(AParent: TVInfo);

    property Parent: TVInfo
      read FParent write FParent;
    property Data: PVSFixedFileInfo
      read FData write FData;

    property Signature: DWORD
      read GetSignature;
    property StructureVersion: DWORD
      read GetStructureVersion;
    property FileVersionMS: DWORD
      read GetFileVersionMS;
    property FileVersionLS: DWORD
      read GetFileVersionLS;
    property ProductVersionMS: DWORD
      read GetProductVersionMS;
    property ProductVersionLS: DWORD
      read GetProductVersionLS;
    property ValidFlags: TFixedFileInfoFlags
      read GetValidFlags;
    property Flags: TFixedFileInfoFlags
      read GetFlags;
    property FileOperatingSystem: TVersionOperatingSystemFlags
      read GetFileOperatingSystem;
    property FileType: TVersionFileType
      read GetFileType;
    property FileSubType: DWORD
      read GetFileSubType;
    property CreationDate: TDateTime
      read GetCreationDate;
  end;

  TVersionNumberInformation = class
  private
    FValid : boolean;
    FMostSignificant: DWORD;
    FLeastSignificant: DWORD;
    FVersionNumberString: string;

    function GetVersionNumber(Index: integer): word;
    function GetVersionNumberString: string;
  public
    constructor Create(MSVer, LSVer: DWORD);
    property Valid : boolean read FValid write FValid;
    property Major: word
      index IDX_VER_MAJOR
      read GetVersionNumber;
    property Minor: word
      index IDX_VER_MINOR
      read GetVersionNumber;
    property Release: word
      index IDX_VER_RELEASE
      read GetVersionNumber;
    property Build: word
      index IDX_VER_BUILD
      read GetVersionNumber;

    property AsString: string
      read GetVersionNumberString;
  end;

  TVersionFilename = type string;

  TVInfo = class
  private
    FVersionInfo: PChar;
    FVersionInfoSize: DWORD;
    FFilename: TVersionFilename;
    FTranslationIDs: TStringList;
    FTranslationIDIndex: integer;
    FFixedInfo: TFixedFileVersionInfo;
    FForceEXE: boolean;
    FFileVersion: TVersionNumberInformation;
    FProductVersion: TVersionNumberInformation;
  protected
    procedure SetFilename(const Val: TVersionFilename);
    procedure SetTranslationIDIndex(Val: integer);
    function GetTranslationIDs: TStrings;
    procedure SetForceEXE(Val: boolean);

    function GetResourceFilename: string; virtual;
    function BuildFlags : string; virtual;
    procedure ReadVersionInfoData; virtual;

    function GetVersionInfoString(Index: integer): string;
    function GetResourceStr(Index: string): string;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    property TranslationIDIndex: integer
      read FTranslationIDIndex
      write SetTranslationIDIndex;
    property TranslationIDs: TStrings
      read GetTranslationIDs;
    property FixedInfo: TFixedFileVersionInfo
      read FFixedInfo;
    property UserResource[Index: string]: string
      read GetResourceStr;

    property FileVersion: TVersionNumberInformation
      read FFileVersion;
    property ProductVersion: TVersionNumberInformation
      read FProductVersion;
  published
    property Filename: TVersionFilename
      read FFilename
      write SetFilename;
    property ForceEXE: boolean
      read FForceEXE
      write SetForceEXE
      default FALSE;

    property CompanyName: string
      index IDX_COMPANYNAME
      read GetVersionInfoString;
    property FileDescription: string
      index IDX_FILEDESCRIPTION
      read GetVersionInfoString;
    property InternalName: string
      index IDX_INTERNALNAME
      read GetVersionInfoString;
    property LegalCopyright: string
      index IDX_LEGALCOPYRIGHT
      read GetVersionInfoString;
    property LegalTrademarks: string
      index IDX_LEGALTRADEMARKS
      read GetVersionInfoString;
    property OriginalFilename: string
      index IDX_ORIGINALFILENAME
      read GetVersionInfoString;
    property ProductName: string
      index IDX_PRODUCTNAME
      read GetVersionInfoString;
    property Comments: string
      index IDX_COMMENTS
      read GetVersionInfoString;
  end;

implementation

const
  PREDEF_RESOURCES: array[IDX_COMPANYNAME..IDX_BUILDFLAGS] of string = (
     'CompanyName', 'FileDescription', 'FileVersion', 'InternalName',
     'LegalCopyright', 'LegalTrademarks', 'OriginalFilename', 'ProductName',
     'ProductVersion', 'Comments', 'BuildFlags'
    );

  PREDEF_CAPTIONS: array[IDX_COMPANYNAME..IDX_BUILDFLAGS] of string = (
     SResCapCompanyName, SResCapFileDescription, SResCapFileVersion,
     SResCapInternalName, SResCapLegalCopyright, SResCapLegalTrademarks,
     SResCapOriginalFilename, SResCapProductName, SResCapProductVersion,
     SResCapComments, SResCapBuildFlags
    );

constructor TFixedFileVersionInfo.Create(AParent: TVInfo);
begin
  inherited Create;
  FParent := AParent;
end;

function TFixedFileVersionInfo.GetSignature: DWORD;
begin
  if FData = nil then
    Result := 0
  else
    Result := FData^.dwSignature;
end;

function TFixedFileVersionInfo.GetStructureVersion: DWORD;
begin
  if FData = nil then
    Result := 0
  else
    Result := FData^.dwStrucVersion;
end;

function TFixedFileVersionInfo.GetFileVersionMS: DWORD;
begin
  if FData = nil then
    Result := 0
  else
    Result := FData^.dwFileVersionMS;
end;

function TFixedFileVersionInfo.GetFileVersionLS: DWORD;
begin
  if FData = nil then
    Result := 0
  else
    Result := FData^.dwFileVersionLS;
end;

function TFixedFileVersionInfo.GetProductVersionMS: DWORD;
begin
  if FData = nil then
    Result := 0
  else
    Result := FData^.dwProductVersionMS;
end;

function TFixedFileVersionInfo.GetProductVersionLS: DWORD;
begin
  if FData = nil then
    Result := 0
  else
    Result := FData^.dwProductVersionLS;
end;

function TFixedFileVersionInfo.GetValidFlags: TFixedFileInfoFlags;
begin
  Result := [];
  if FData <> nil then
  begin
    if (FData^.dwFileFlagsMask and VS_FF_DEBUG) <> 0 then
      Include(Result, ffDebug);
    if (FData^.dwFileFlagsMask and VS_FF_PRERELEASE) <> 0 then
      Include(Result, ffPreRelease);
    if (FData^.dwFileFlagsMask and VS_FF_PATCHED) <> 0 then
      Include(Result, ffPatched);
    if (FData^.dwFileFlagsMask and VS_FF_PRIVATEBUILD) <> 0 then
      Include(Result, ffPrivateBuild);
    if (FData^.dwFileFlagsMask and VS_FF_INFOINFERRED ) <> 0 then
      Include(Result, ffInfoInferred );
    if (FData^.dwFileFlagsMask and VS_FF_SPECIALBUILD ) <> 0 then
      Include(Result, ffSpecialBuild );
  end;
end;

function TFixedFileVersionInfo.GetFlags: TFixedFileInfoFlags;
begin
  Result := [];
  if FData <> nil then
  begin
    if (FData^.dwFileFlags and VS_FF_DEBUG) <> 0 then
      Include(Result, ffDebug);
    if (FData^.dwFileFlags and VS_FF_PRERELEASE) <> 0 then
      Include(Result, ffPreRelease);
    if (FData^.dwFileFlags and VS_FF_PATCHED) <> 0 then
      Include(Result, ffPatched);
    if (FData^.dwFileFlags and VS_FF_PRIVATEBUILD) <> 0 then
      Include(Result, ffPrivateBuild);
    if (FData^.dwFileFlags and VS_FF_INFOINFERRED ) <> 0 then
      Include(Result, ffInfoInferred );
    if (FData^.dwFileFlags and VS_FF_SPECIALBUILD ) <> 0 then
      Include(Result, ffSpecialBuild );
  end;
end;

function TFixedFileVersionInfo.GetFileOperatingSystem: TVersionOperatingSystemFlags;
begin
  Result := [];
  if FData <> nil then
  begin
    case HiWord(FData^.dwFileOS) of
      VOS_DOS shr 16:   Include(Result, vosDOS);
      VOS_OS216 shr 16: Include(Result, vosOS2_16);
      VOS_OS232 shr 16: Include(Result, vosOS2_32);
      VOS_NT shr 16:    Include(Result, vosNT);
    else
      Include(Result, vosUnknown);
    end;

    case LoWord(FData^.dwFileOS) of
      LoWord(VOS__WINDOWS16): Include(Result, vosWindows16);
      LoWord(VOS__PM16):      Include(Result, vosPresentationManager16);
      LoWord(VOS__PM32):      Include(Result, vosPresentationManager32);
      LoWord(VOS__WINDOWS32): Include(Result, vosWindows32);
    else
      Include(Result, vosUnknown);
    end;
  end;
end;

function TFixedFileVersionInfo.GetFileType: TVersionFileType;
begin
  Result := vftUnknown;
  if FData <> nil then
  begin
    case FData^.dwFileType of
      VFT_APP:        Result := vftApplication;
      VFT_DLL:        Result := vftDLL;
      VFT_DRV:        Result := vftDriver;
      VFT_FONT:       Result := vftFont;
      VFT_VXD:        Result := vftVXD;
      VFT_STATIC_LIB: Result := vftStaticLib;
    end;
  end;
end;

function TFixedFileVersionInfo.GetFileSubType: DWORD;
begin
  if FData = nil then
    Result := 0
  else begin
    Result := FData^.dwFileSubtype;
  end;
end;

function TFixedFileVersionInfo.GetCreationDate: TDateTime;
var
  SysTime: TSystemTime;
  FileTime: TFileTime;
begin
  if FData = nil then
    Result := 0
  else begin
    FileTime.dwLowDateTime := FData^.dwFileDateLS;
    FileTime.dwHighDateTime := FData^.dwFileDateMS;
    if FileTimeToSystemTime(FileTime, SysTime) then
    begin
      Result := SystemTimeToDateTime(SysTime);
    end else
      Result := 0;
  end;
end;

constructor TVersionNumberInformation.Create(MSVer, LSVer: DWORD);
begin
  inherited Create;

  FValid := false;
  FMostSignificant := MSVer;
  FLeastSignificant := LSVer;
end;

function TVersionNumberInformation.GetVersionNumber(Index: integer): word;
begin
  Result := 0;
  if FValid then
    case Index of
      IDX_VER_MAJOR:   Result := HiWord(FMostSignificant);
      IDX_VER_MINOR:   Result := LoWord(FMostSignificant);
      IDX_VER_RELEASE: Result := HiWord(FLeastSignificant);
      IDX_VER_BUILD:   Result := LoWord(FLeastSignificant)
    end
end;

function TVersionNumberInformation.GetVersionNumberString: string;
begin
  if FValid then
  begin
    if FVersionNumberString = '' then
      Result := Format('%d.%d.%d.%d', [Major, Minor, Release, Build])
    else
      Result := FVersionNumberString;
  end
  else
    Result := ''
end;

constructor TVInfo.Create;
begin
  inherited Create;
  FVersionInfo := nil;
  FVersionInfoSize := 0;
  FFilename := '';
  FTranslationIDIndex := 0;
  FForceEXE := FALSE;
  FTranslationIDs := TStringList.Create;
  FFileVersion := TVersionNumberInformation.Create(0, 0);
  FProductVersion := TVersionNumberInformation.Create(0, 0);
  FFixedInfo := TFixedFileVersionInfo.Create(Self);
end;

destructor TVInfo.Destroy;
begin
  FFileVersion.Free;
  FProductVersion.Free;
  FFixedInfo.Free;
  FTranslationIDs.Free;
  if FVersionInfo <> nil then
    FreeMem(FVersionInfo, FVersionInfoSize);

  inherited Destroy;
end;

procedure TVInfo.SetFilename(const Val: TVersionFilename);
begin
  FFilename := Val;
  ReadVersionInfoData;
end;

procedure TVInfo.ReadVersionInfoData;
const
  TRANSLATION_INFO = '\VarFileInfo\Translation';
type
  TTranslationPair = packed record
    Lang,
    CharSet: word;
  end;
  PTranslationIDList = ^TTranslationIDList;
  TTranslationIDList = array[0..MAXINT div SizeOf(TTranslationPair)-1] of TTranslationPair;
var
  QueryLen: UINT;
  IDsLen: UINT;
  Dummy: DWORD;
  IDs: PTranslationIDList;
  IDCount: integer;
  FixedInfoData: PVSFixedFileInfo;
  TempFilename: array[0..255] of char;
begin
  FTranslationIDs.Clear;
  FFixedInfo.Data := nil;
  if FVersionInfo <> nil then
    FreeMem(FVersionInfo, FVersionInfoSize);
  StrPCopy(TempFileName, GetResourceFilename);

  try
    FVersionInfoSize := GetFileVersionInfoSize(TempFileName, Dummy);
  except
    FVersionInfoSize := 0;
  end;

  if FVersionInfoSize = 0 then
  begin
    FVersionInfo := nil;
    FFileVersion.Valid := false;
    FProductVersion.Valid := false;
  end else begin
    GetMem(FVersionInfo, FVersionInfoSize);
    GetFileVersionInfo(TempFileName, Dummy, FVersionInfoSize, FVersionInfo);

    VerQueryValue(FVersionInfo, '\', pointer(FixedInfoData), QueryLen);
    FFixedInfo.Data := FixedInfoData;
    if VerQueryValue(FVersionInfo, TRANSLATION_INFO, Pointer(IDs), IDsLen) then
    begin
      IDCount := IDsLen div SizeOf(TTranslationPair);
      if (IDCount > 0) then
      begin
        for Dummy := 0 to IDCount-1 do
        begin
          FTranslationIDs.Add(Format('%.4x%.4x', [IDs^[Dummy].Lang, IDs^[Dummy].CharSet]));
        end;
      end
      else
      if (IDCount = 0) and (IDsLen > 0) then
      begin
        FTranslationIDs.Add(Format('%.4x%.4x', [DEFAULT_LANG_ID, IDs^[Dummy].Lang]));
      end;
    end;

    if FTranslationIDIndex >= FTranslationIDs.Count then
      FTranslationIDIndex := 0;

    FFileVersion.Valid := true;
    FFileVersion.FMostSignificant := FFixedInfo.GetFileVersionMS;
    FFileVersion.FLeastSignificant := FFixedInfo.GetFileVersionLS;
    FFileVersion.FVersionNumberString := GetVersionInfoString(IDX_FILEVERSION);
    FProductVersion.Valid := true;
    FProductVersion.FMostSignificant := FFixedInfo.GetProductVersionMS;
    FProductVersion.FLeastSignificant := FFixedInfo.GetProductVersionLS;
    FProductVersion.FVersionNumberString := GetVersionInfoString(
      IDX_PRODUCTVERSION);
  end;
end;

function TVInfo.GetResourceFilename: string;
begin
    Result := FFilename;
end;

function TVInfo.GetVersionInfoString(Index: integer): string;
begin
  if (Index >= Low(PREDEF_RESOURCES)) and (Index <= High(PREDEF_RESOURCES)) then
    Result := GetResourceStr(PREDEF_RESOURCES[Index])
  else
    Result := ''
end;

function TVInfo.GetResourceStr(Index: string): string;
var
  ResStr: PChar;
  StrLen: UINT;
  SubBlock: array[0..255] of char;
  LangCharSet: string;
begin
  if FTranslationIDIndex < FTranslationIDs.Count then
    LangCharSet := FTranslationIDs[FTranslationIDIndex]
  else
    LangCharSet := DEFAULT_LANG_CHAR_SET;
  StrPCopy(SubBlock, '\StringFileInfo\' + LangCharSet + '\' + Index);
  if (FVersionInfo <> nil) and
     VerQueryValue(FVersionInfo, SubBlock, Pointer(ResStr), StrLen)
  then
    Result := StrPas(ResStr)
  else
    Result := '';
end;

procedure TVInfo.SetTranslationIDIndex(Val: integer);
begin
  if (Val > 0) and (Val < FTranslationIDs.Count) then
    FTranslationIDIndex := Val;
end;

function TVInfo.GetTranslationIDs: TStrings;
begin
  Result := FTranslationIDs;
end;

procedure TVInfo.SetForceEXE(Val: boolean);
begin
  if FForceEXE <> Val then
  begin
    FForceEXE := Val;
    ReadVersionInfoData;
  end;
end;

function TVInfo.BuildFlags : string;
const
  FLAG_STRING: array[TFixedFileInfoFlag] of string = (
      SFlagDebug, SFlagInfoInferred, SFlagPatched, SFlagPreRelease,
      SFlagPrivate, SFlagSpecial
    );
var
  AFlag: TFixedFileInfoFlag;
begin
  Result := '';
  for AFlag := Low(TFixedFileInfoFlag) to High(TFixedFileInfoFlag) do
    if AFlag in FixedInfo.Flags then
      Result := Result + FLAG_STRING[AFlag] + ', ';
  if Length(Result) > 0 then
    Result := Copy(Result, 1, Length(Result)-2);
end;

end.
