{ Transym OCR library header file for Delphi

  Translated by Michel Brazeau, Mar 18, 2002.

  DLL is loaded dynamically in LoadTOCREngine
}
unit TransOcr;

interface

type

{ in VB Boolean is as signed short True is -1 }
VBBool = SmallInt;

const

OCRTrue  = -1;
OCRFalse = 0;


TOCRJOBMSGLENGTH = 512;        // max length of a job status message

//Setting for JobNo for TOCRSetErrorMode and TOCRGetErrorMode
TOCRDEFERRORMODE = -1;         // set/get the API error mode for all jobs

//Settings for ErrorMode for TOCRSetErrorMode and TOCRGetErrorMode
TOCRERRORMODE_NONE   = 0;        // API errors unseen (use return status of API calls)
TOCRERRORMODE_MSGBOX = 1;      // API errors will bring up a message box

// Setting for TOCRShutdown
TOCRSHUTDOWNALL = -1;          // stop and shutdown processing for all jobs

// Values returnd by TOCRGetJobStatus JobStatus
TOCRJOBSTATUS_ERROR = -1;      // an error ocurred processing the last job
TOCRJOBSTATUS_BUSY = 0;        // the job is still processing
TOCRJOBSTATUS_DONE = 1;        // the job completed successfully
TOCRJOBSTATUS_IDLE = 2;        // no job has been specified yet

// Settings for TOCRJOBINFO.JobType
TOCRJOBTYPE_TIFFFILE = 0;      // TOCRJOBINFO.InputFile specifies a tiff file
TOCRJOBTYPE_DIBFILE = 1;       // TOCRJOBINFO.InputFile specifies a dib (bmp) file
TOCRJOBTYPE_DIBCLIPBOARD = 2;  // clipboard contains a dib (clipboard format CF_DIB)

// Settings for TOCRJOBINFO.Orientation
TOCRJOBORIENT_AUTO = 0;        // detect orientation and rotate automatically
TOCRJOBORIENT_OFF = 255;       // don//t rotate
TOCRJOBORIENT_90 = 1;          // 90 degrees clockwise rotation
TOCRJOBORIENT_180 = 2;         // 180 degrees clockwise rotation
TOCRJOBORIENT_270 = 3;         // 270 degrees clockwise rotation

// Values returned by TOCRGetJobDBInfo
TOCRJOBSLOT_FREE = 0 ;         // job slot is free for use
TOCRJOBSLOT_OWNEDBYYOU = 1;    // job slot is in use by your process
TOCRJOBSLOT_BLOCKEDBYYOU = 2;  // blocked by own process (re-initialise)
TOCRJOBSLOT_OWNEDBYOTHER = -1; // job slot is in use by another process (can//t use)
TOCRJOBSLOT_BLOCKEDBYOTHER = -2;// blocked by another process (can//t use)

// Values returned in WaitAnyStatus by TOCRWaitForAnyJob
TOCRWAIT_OK = 0;               // JobNo is the job that finished (get and check it//s JobStatus)
TOCRWAIT_SERVICEABORT = 1;     // JobNo is the job that failed (re-initialise)
TOCRWAIT_CONNECTIONBROKEN = 2; // JobNo is the job that failed (re-initialise)
TOCRWAIT_FAILED = -1;          // JobNo not set - check manually
TOCRWAIT_NOJOBSFOUND = -2;     // JobNo not set - no running jobs found

// Values returned in ResultsInf by TOCRGetJobResults
TOCRGETRESULTS_NORESULTS = -1; // no results are available

{ status codes }
const

TOCR_OK                              = 0;

TOCRERR_ILLEGALJOBNO                 = 1;
TOCRERR_FAILLOCKDB                   = 2;
TOCRERR_NOFREEJOBSLOTS               = 3;
TOCRERR_FAILSTARTSERVICE             = 4;
TOCRERR_FAILINITSERVICE              = 5;
TOCRERR_JOBSLOTNOTINIT               = 6;
TOCRERR_JOBSLOTINUSE                 = 7;
TOCRERR_SERVICEABORT                 = 8;
TOCRERR_CONNECTIONBROKEN             = 9;
TOCRERR_INVALIDSTRUCTID             = 10;
TOCRERR_FAILGETVERSION              = 11;
TOCRERR_FAILLICENCEINF              = 12;
TOCRERR_LICENCEEXCEEDED             = 13;

TOCRERR_FAILGETJOBSTATUS1           = 20;
TOCRERR_FAILGETJOBSTATUS2           = 21;
TOCRERR_FAILGETJOBSTATUS3           = 22;

TOCRERR_FAILDOJOB1                  = 30;
TOCRERR_FAILDOJOB2                  = 31;
TOCRERR_FAILDOJOB3                  = 32;
TOCRERR_FAILDOJOB4                  = 33;
TOCRERR_FAILDOJOB5                  = 34;
TOCRERR_FAILDOJOB6                  = 35;
TOCRERR_FAILDOJOB7                  = 36;
TOCRERR_UNKNOWNJOBTYPE1             = 40;
TOCRERR_JOBNOTSTARTED1              = 41;

TOCRERR_FAILGETJOBSTATUSMSG1        = 45;
TOCRERR_FAILGETJOBSTATUSMSG2        = 46;

TOCRERR_FAILGETNUMPAGES1            = 50;
TOCRERR_FAILGETNUMPAGES2            = 51;
TOCRERR_FAILGETNUMPAGES3            = 52;
TOCRERR_FAILGETNUMPAGES4            = 53;
TOCRERR_FAILGETNUMPAGES5            = 54;

TOCRERR_FAILGETRESULTS1             = 60;
TOCRERR_FAILGETRESULTS2             = 61;
TOCRERR_FAILGETRESULTS3             = 62;
TOCRERR_FAILGETRESULTS4             = 63;
TOCRERR_FAILALLOCMEM100             = 64;
TOCRERR_FAILALLOCMEM101             = 65;
TOCRERR_FILENOTSPECIFIED            = 66;

TOCRERR_FAILROTATEBITMAP            = 70;

{ Error codes which may be seen in a msgbox or console but will
  not be returned by an API function }
TOCRERR_INVALIDSERVICESTART         = 1000;
TOCRERR_FAILSERVICEINIT             = 1001;
TOCRERR_FAILLICENCE1                = 1002;
TOCRERR_FAILSERVICESTART            = 1003;
TOCRERR_UNKNOWNCMD                  = 1004;
TOCRERR_FAILREADCOMMAND             = 1005;
TOCRERR_FAILREADOPTIONS             = 1006;
TOCRERR_FAILWRITEJOBSTATUS1         = 1007;
TOCRERR_FAILWRITEJOBSTATUS2         = 1008;
TOCRERR_FAILWRITETHREADH            = 1009;
TOCRERR_FAILREADJOBINFO1            = 1010;
TOCRERR_FAILREADJOBINFO2            = 1011;
TOCRERR_FAILREADJOBINFO3            = 1012;
TOCRERR_FAILWRITEPROGRESS           = 1013;
TOCRERR_FAILWRITEJOBSTATUSMSG       = 1014;
TOCRERR_FAILWRITERESULTSSIZE        = 1015;
TOCRERR_FAILWRITERESULTS            = 1016;
TOCRERR_FAILWRITEAUTOORIENT         = 1017;
TOCRERR_FAILLICENCE2                = 1018;
TOCRERR_FAILLICENCE3                = 1019;

TOCRERR_TOOMANYCOLUMNS              = 1020;
TOCRERR_TOOMANYROWS                 = 1021;
TOCRERR_EXCEEDEDMAXZONE             = 1022;
TOCRERR_NSTACKTOOSMALL              = 1023;
TOCRERR_ALGOERR1                    = 1024;
TOCRERR_ALGOERR2                    = 1025;
TOCRERR_EXCEEDEDMAXCP               = 1026;
TOCRERR_CANTFINDPAGE                = 1027;
TOCRERR_UNSUPPORTEDIMAGETYPE        = 1028;
TOCRERR_IMAGETOOWIDE                = 1029;
TOCRERR_IMAGETOOLONG                = 1030;
TOCRERR_UNKNOWNJOBTYPE2             = 1031;
TOCRERR_TOOWIDETOROT                = 1032;
TOCRERR_TOOLONGTOROT                = 1033;
TOCRERR_INVALIDPAGENO               = 1034;
TOCRERR_FAILREADJOBTYPENUMBYTES     = 1035;
TOCRERR_FAILREADFILENAME            = 1036;
TOCRERR_FAILSENDNUMPAGES            = 1037;
TOCRERR_FAILOPENCLIP                = 1038;
TOCRERR_NODIBONCLIP                 = 1039;
TOCRERR_FAILREADDIBCLIP             = 1040;
TOCRERR_FAILLOCKDIBCLIP             = 1041;
TOCRERR_UNKOWNDIBFORMAT             = 1042;
TOCRERR_FAILREADDIB                 = 1043;
TOCRERR_NOXYPPM                     = 1044;
TOCRERR_FAILCREATEDIB               = 1045;
TOCRERR_FAILWRITEDIBCLIP            = 1046;
TOCRERR_FAILALLOCMEMDIB             = 1047;
TOCRERR_FAILLOCKMEMDIB              = 1048;
TOCRERR_FAILCREATEFILE              = 1049;
TOCRERR_FAILOPENFILE1               = 1050;
TOCRERR_FAILOPENFILE2               = 1051;
TOCRERR_FAILOPENFILE3               = 1052;
TOCRERR_FAILOPENFILE4               = 1053;
TOCRERR_FAILREADFILE1               = 1054;
TOCRERR_FAILREADFILE2               = 1055;
TOCRERR_FAILFINDDATA1               = 1056;
TOCRERR_TIFFERROR1                  = 1057;
TOCRERR_TIFFERROR2                  = 1058;
TOCRERR_TIFFERROR3                  = 1059;
TOCRERR_TIFFERROR4                  = 1060;

TOCRERR_FAILREADFILENAME1           = 1070;
TOCRERR_FAILREADFILENAME2           = 1071;
TOCRERR_FAILREADFILENAME3           = 1072;
TOCRERR_FAILREADFILENAME4           = 1073;
TOCRERR_FAILREADFILENAME5           = 1074;

TOCRERR_FAILALLOCMEM1               = 1101;
TOCRERR_FAILALLOCMEM2               = 1102;
TOCRERR_FAILALLOCMEM3               = 1103;
TOCRERR_FAILALLOCMEM4               = 1104;
TOCRERR_FAILALLOCMEM5               = 1105;
TOCRERR_FAILALLOCMEM6               = 1106;
TOCRERR_FAILALLOCMEM7               = 1107;
TOCRERR_FAILALLOCMEM8               = 1108;
TOCRERR_FAILALLOCMEM9               = 1109;
TOCRERR_FAILALLOCMEM10              = 1110;

TOCRERR_BUFFEROVERFLOW1             = 2001;

TOCRERR_MAPOVERFLOW                 = 2002;
TOCRERR_REBREAKNEXTCALL             = 2003;
TOCRERR_REBREAKNEXTDATA             = 2004;
TOCRERR_REBREAKEXACTCALL            = 2005;
TOCRERR_MAXZCANOVERFLOW1            = 2006;
TOCRERR_MAXZCANOVERFLOW2            = 2007;
TOCRERR_BUFFEROVERFLOW2             = 2008;
TOCRERR_NUMKCOVERFLOW               = 2009;
TOCRERR_BUFFEROVERFLOW3             = 2010;
TOCRERR_BUFFEROVERFLOW4             = 2011;

TOCRERR_FCZYREF                     = 2020;
TOCRERR_MAXTEXTLINES1               = 2021;
TOCRERR_LINEINDEX                   = 2022;
TOCRERR_MAXFCZSONLINE               = 2023;
TOCRERR_MEMALLOC1                   = 2024;
TOCRERR_MERGEBREAK                  = 2025;

TOCRERR_DKERNPRANGE1                = 2030;
TOCRERR_DKERNPRANGE2                = 2031;
TOCRERR_BUFFEROVERFLOW5             = 2032;
TOCRERR_BUFFEROVERFLOW6             = 2033;

TOCRERR_FILEOPEN1                   = 2040;
TOCRERR_FILEOPEN2                   = 2041;
TOCRERR_FILEOPEN3                   = 2042;
TOCRERR_FILEREAD1                   = 2043;
TOCRERR_FILEREAD2                   = 2044;
TOCRERR_SPWIDZERO                   = 2045;
TOCRERR_FAILALLOCMEMLEX1            = 2046;
TOCRERR_FAILALLOCMEMLEX2            = 2047;

TOCRERR_BADOBWIDTH                  = 2050;
TOCRERR_BADROTATION                 = 2051;

TOCRERR_MATCHBUFFEROVERFLOW         = 2060;

TOCRERR_UIDA                        = 2070;
TOCRERR_UIDB                        = 2071;
TOCRERR_ZEROUID                     = 2072;
TOCRERR_CERTAINTYDBNOTINIT          = 2073;

TOCRERR_OPENSETTINGS                = 2080;
TOCRERR_READSETTINGS1               = 2081;
TOCRERR_READSETTINGS2               = 2082;
TOCRERR_BADSETTINGS                 = 2083;
TOCRERR_WRITESETTINGS               = 2084;
TOCRERR_MAXSCOREDIFF                = 2085;

TOCRERR_YDIMREFZERO1                = 2090;
TOCRERR_YDIMREFZERO2                = 2091;
TOCRERR_YDIMREFZERO3                = 2092;
TOCRERR_ASMFILEOPEN                 = 2093;
TOCRERR_ASMFILEREAD                 = 2094;
TOCRERR_MEMALLOCASM                 = 2095;
TOCRERR_MEMREALLOCASM               = 2096;
TOCRERR_SDBFILEOPEN                 = 2097;
TOCRERR_SDBFILEREAD                 = 2098;
TOCRERR_SDBFILEBAD1                 = 2099;
TOCRERR_SDBFILEBAD2                 = 2100;
TOCRERR_MEMALLOCSDB                 = 2101;
TOCRERR_DEVEL1                      = 2102;
TOCRERR_DEVEL2                      = 2103;
TOCRERR_DEVEL3                      = 2104;
TOCRERR_DEVEL4                      = 2105;
TOCRERR_DEVEL5                      = 2106;
TOCRERR_DEVEL6                      = 2107;
TOCRERR_DEVEL7                      = 2108;
TOCRERR_DEVEL8                      = 2109;
TOCRERR_DEVEL9                      = 2110;
TOCRERR_DEVEL10                     = 2111;
TOCRERR_DEVEL11                     = 2112;
TOCRERR_DEVEL12                     = 2113;
TOCRERR_DEVEL13                     = 2114;
TOCRERR_FILEOPEN4                   = 2115;
TOCRERR_FILEOPEN5                   = 2116;
TOCRERR_FILEOPEN6                   = 2117;
TOCRERR_FILEREAD3                   = 2118;
TOCRERR_FILEREAD4                   = 2119;

TOCRERR_MEMALLOCRESULTS             = 2130;

TOCRERR_MEMALLOCHEAP                = 2140;
TOCRERR_HEAPNOTINITIALISED          = 2141;
TOCRERR_MEMLIMITHEAP                = 2142;
TOCRERR_MEMREALLOCHEAP              = 2143;
TOCRERR_MEMALLOCFCZBM               = 2144;
TOCRERR_FCZBMOVERLAP                = 2145;
TOCRERR_FCZBMLOCATION               = 2146;
TOCRERR_MEMREALLOCFCZBM             = 2147;
TOCRERR_MEMALLOCFCHBM               = 2148;
TOCRERR_MEMREALLOCFCHBM             = 2149;

type

PLongInt = ^LongInt;
PSingle  = ^Single;

TOCRProcessOptions = packed record
    StructId            : LongInt;
    InvertWholePage     : VBBool;
    DeskewOff           : VBBool;
    Orientation         : Byte;
    NoiseRemoveOff      : VBBool;
    LineRemoveOff       : VBBool;
    DeshadeOff          : VBBool;
    InvertOff           : VBBool;
    SectioningOn        : VBBool;
    MergeBreakOff       : VBBool;
    LineRejectOff       : VBBool;
    CharacterRejectOff  : VBBool;
    LexOff              : VBBool;
    DisableCharacter    : array[0..255] of VBBool;
end;

TpOCRJobInfo = ^TOCRJobInfo;
TOCRJobInfo = packed record
    StructId       : LongInt;
    JobType        : LongInt;
    {$Warnings Off}
    InputFile      : PChar;
    {$Warnings On}
    PageNo         : LongInt;
    ProcessOptions : TOCRProcessOptions;
end;

TOCRResultsHeader = packed record
    StructId          : LongInt;
    XPixelsPerInch    : LongInt;
    YPixelsPerInch    : LongInt;
    NumItems          : LongInt;
    MeanConfidence    : Single;
end;

TOCRResultsItem = packed record
    StructId      : Word;
    OCRCha        : Word;
    Confidence    : Single;
    XPos          : Word;
    YPos          : Word;
    XDim          : Word;
    YDim          : Word;
end;


{ An instance of TOCRResult should not be used, as the Items record
  is huge. A TpOCRResults pointer is used to retrieve the results
  of an OCR process }
TpOCRResults = ^TOCRResults;
TOCRResults = packed record
    Header           : TOCRResultsHeader;
    Items            : array[0..((MaxLongInt-32) div SizeOf(TOCRResultsItem))] of TOCRResultsItem;
end;

TOCRInitialise = function( JobNo : PLongInt) : LongInt; stdcall;

TOCRShutdown = function( JobNo : LongInt) : LongInt; stdcall;

TOCRGetErrorMode = function(JobNo : LongInt; ErrorMode : PLongInt) : LongInt; stdcall;

TOCRSetErrorMode = function(JobNo : LongInt; ErrorMode : LongInt) : LongInt; stdcall;

TOCRDoJob = function(JobNo : LongInt; JobInfo : TpOCRJobInfo) : LongInt; stdcall;

TOCRWaitForJob = function(JobNo : LongInt; JobStatus : PLongInt) : LongInt; stdcall;

TOCRWaitForAnyJob = function(WaitAnyStatus : PLongInt; JobNo : PLongInt) : LongInt; stdcall;

TOCRGetJobDBInfo = function(JobSlotInf : PLongInt) : LongInt; stdcall;

TOCRGetJobStatus = function(JobNo : LongInt; JobStatus : PLongInt) : LongInt; stdcall;

TOCRGetJobStatusEx = function(JobNo : LongInt; JobStatus : PLongInt; Progress : PSingle; AutoOrientation : PLongInt) : LongInt; stdcall;

{$Warnings Off}
TOCRGetJobStatusMsg = function(JobNo : LongInt; Msg : PChar) : LongInt; stdcall;
{$Warnings On}

{$Warnings Off}
TOCRGetNumPages = function(JobNo : LongInt; Filename : PChar; JobType : LongInt; NumPages : PLongInt) : LongInt; stdcall;
{$Warnings On}

TOCRGetJobResults = function(JobNo : LongInt; ResultsInf : PLongInt; Results : TpOCRResults) : LongInt; stdcall;

TOCRGetLicenceInfo = function(NumberOfJobSlots : PLongInt; Volume : PLongInt; Time : PLongInt; Remaining : PLongInt) : LongInt; stdcall;

{$Warnings Off}
TOCRConvertTIFFtoDIB = function(JobNo : LongInt; InputFilename : PChar; OutputFilename : PChar; PageNo : LongInt) : LongInt; stdcall;
{$Warnings On}

TOCRRotateMonoBitmap = function( hBmp : PLongInt; Width : LongInt; Height : LongInt; Orientation : LongInt) : LongInt; stdcall;

{ entry points, only valid after LoadTOCREngine is called }

var

OCRInitialise         : TOCRInitialise;
OCRShutdown           : TOCRShutdown;
OCRGetErrorMode       : TOCRGetErrorMode;
OCRSetErrorMode       : TOCRSetErrorMode;
OCRDoJob              : TOCRDoJob;
OCRWaitForJob         : TOCRWaitForJob;
OCRWaitForAnyJob      : TOCRWaitForAnyJob;
OCRGetJobDBInfo       : TOCRGetJobDBInfo;
OCRGetJobStatus       : TOCRGetJobStatus;
OCRGetJobStatusEx     : TOCRGetJobStatusEx;
OCRGetJobStatusMsg    : TOCRGetJobStatusMsg;
OCRGetNumPages        : TOCRGetNumPages;
OCRGetJobResults      : TOCRGetJobResults;
OCRGetLicenseInfo     : TOCRGetLicenceInfo;
OCRConvertTIFFToDIB   : TOCRConvertTIFFtoDIB;
OCRRotateMonoBitmap   : TOCRRotateMonoBitmap;

procedure LoadTOCREngine;
procedure UnloadTOCREngine;

procedure CheckOCRCall( const ReturnValue : LongInt );

{---------------------------------------------------------------------------}

implementation

uses
     SysUtils, { for Exception }
     Windows;  { for THandle }

const

CTOCRDllFileName = 'TOCRDLL.DLL';

var

DLLHandle : THandle;

{---------------------------------------------------------------------------}

procedure CheckOCRCall( const ReturnValue : LongInt );
begin
    if ReturnValue <> TOCR_OK then
        raise Exception.Create('Error in TOCR engine call');
end;

{---------------------------------------------------------------------------}

{$Warnings Off}
function GetEntryPoint( const Routine : AnsiString ) : Pointer;
begin
    Result := GetProcAddress( DllHandle, PChar( Routine ));

    if Result = nil then
         raise Exception.Create( 'Routine ' + Routine + ' not found in ' + CTOCRDllFileName );
end;
{$Warnings On}

{---------------------------------------------------------------------------}

procedure LoadTOCREngine;
begin
    if DLLHandle <> 0 then
        raise Exception.Create('TOCR DLL already loaded');

    {$Warnings Off}
    DLLHandle := LoadLibrary(PChar(CTOCRDllFileName));
    {$Warnings On}

    if DLLHandle = 0 then
        raise Exception.Create( 'Unable to load ' + CTOCRDllFileName + '.'#13#13 +
                                'Make sure Transym OCR is installed.'#13 +
                                'A trial version may be downloaded from:'#13#13 +
                                'www.sorcery.demon.co.uk'#13 );

    OCRInitialise         :=  GetEntryPoint( 'TOCRInitialise' );
    OCRShutdown           :=  GetEntryPoint( 'TOCRShutdown' );
    OCRGetErrorMode       :=  GetEntryPoint( 'TOCRGetErrorMode' );
    OCRSetErrorMode       :=  GetEntryPoint( 'TOCRSetErrorMode' );
    OCRDoJob              :=  GetEntryPoint( 'TOCRDoJob' );
    OCRWaitForJob         :=  GetEntryPoint( 'TOCRWaitForJob' );
    OCRWaitForAnyJob      :=  GetEntryPoint( 'TOCRWaitForAnyJob' );
    OCRGetJobDBInfo       :=  GetEntryPoint( 'TOCRGetJobDBInfo' );
    OCRGetJobStatus       :=  GetEntryPoint( 'TOCRGetJobStatus' );
    OCRGetJobStatusEx     :=  GetEntryPoint( 'TOCRGetJobStatusEx' );
    OCRGetJobStatusMsg    :=  GetEntryPoint( 'TOCRGetJobStatusMsg' );
    OCRGetNumPages        :=  GetEntryPoint( 'TOCRGetNumPages' );
    OCRGetJobResults      :=  GetEntryPoint( 'TOCRGetJobResults' );
    OCRGetLicenseInfo     :=  GetEntryPoint( 'TOCRGetLicenceInfo' );
    OCRConvertTIFFToDIB   :=  GetEntryPoint( 'TOCRConvertTIFFtoDIB' );
    OCRRotateMonoBitmap   :=  GetEntryPoint( 'TOCRRotateMonoBitmap' );
end;

procedure UnloadTOCREngine;
begin
    if DLLHandle <> 0 then
    begin
        FreeLibrary(DLLHandle);
        DLLHandle := 0;
    end;
end;

end.