//---------------------------------------------------------------------------

#ifndef iepluginH
#define iepluginH
//---------------------------------------------------------------------------

// Callbacks types
typedef void (WINAPI *TIEX_Progress)(int, void *);
typedef int (WINAPI *TIEX_Read)(void *, int, void *);
typedef int (WINAPI *TIEX_Write)(const void *, int, void *);
typedef void (WINAPI *TIEX_PositionSet)(int, void *);
typedef int (WINAPI *TIEX_PositionGet)(void *);
typedef int (WINAPI *TIEX_Length)(void *);
typedef void (WINAPI *TIEX_GetParameter)(char *, char *, void *);
typedef void (WINAPI *TIEX_SetParameter)(char *, char *, void *);

// Exported DLL functions
__declspec(dllexport) void* WINAPI IEX_GetInfo(void* handle, int info);
__declspec(dllexport) void WINAPI IEX_SetInfo(void* handle, int info, void* value);
__declspec(dllexport) void WINAPI IEX_SetCallBacks(void* handle, TIEX_Progress progressfun, TIEX_Read readfun, TIEX_Write writefun, TIEX_PositionSet posset, TIEX_PositionGet posget, TIEX_Length lenfun, TIEX_GetParameter, TIEX_SetParameter, void* userData );
__declspec(dllexport) void* WINAPI IEX_Initialize(int format);
__declspec(dllexport) void WINAPI IEX_AddParameter(void* handle, char* param);
__declspec(dllexport) void WINAPI IEX_Finalize(void* handle);
__declspec(dllexport) void WINAPI IEX_ExecuteRead(void* handle, bool parametersOnly);
__declspec(dllexport) void WINAPI IEX_ExecuteWrite(void* handle);
__declspec(dllexport) bool WINAPI IEX_ExecuteTry(void* handle);

struct IEX_Info
{
  // callbacks
  TIEX_Progress IEX_Progress;
  TIEX_Read IEX_Read;
  TIEX_Write IEX_Write;
  TIEX_PositionSet IEX_PositionSet;
  TIEX_PositionGet IEX_PositionGet;
  TIEX_Length IEX_Length;
  TIEX_GetParameter IEX_GetParameter;
  TIEX_SetParameter IEX_SetParameter;
  // image data
  int imWidth;
  int imHeight;
  int imFormat;                   // IEX_1G, IEX_8G etc
  char imFormatDescriptor[128];   // specific file info
  void* imData;                   // RGB data. R,G,B are interlaced and the alignment is 8 bit. First channel is Red.
  void* imPalette;                // an array of 256x8 bit RGB triplets, only when format is IEX_8P
  // external data
  void* userData;
  void* plugInData;
  int plugInData1;
  int selectedFormat; // the format application has choised on IEX_Initialize (only for multiformat plugins)
};

// IEX_GetInfo/IEX_SetInfo: available after IEX_ExecuteRead
#define IEX_IMAGEWIDTH           0x00
#define IEX_IMAGEHEIGHT          0x01
#define IEX_PIXELFORMAT          0x02     // IEX_1G, IEX_8G etc
#define IEX_FORMATDESCRIPTOR     0x03     // could be the same of IEX_PLUGINDESCRIPTOR plus specific file format info
#define IEX_IMAGEDATA            0x04     // RGB data. R,G,B are interlaced and the alignment is 8 bit. First channel is Red.
#define IEX_IMAGEPALETTE         0x05     // an array of 256x8 bit RGB triplets, only when format is IEX_8P

// IEX_GetInfo/IEX_SetInfo: always available after IEX_Initialize
#define IEX_PLUGINCAPABILITY     0x0101     // IEX_FILEREADER and/or IEX_FILEWRITER and/or IEX_MULTITHREAD
#define IEX_PLUGINDESCRIPTOR     0x0102     // ex. "Camera RAW"
#define IEX_FILEEXTENSIONS       0x0103     // ex. "CRW;CR2;NEF;RAW;PEF;RAF;X3F;BAY;ORF;SRF;MRW;DCR"
#define IEX_AUTOSEARCHEXIF       0x0104     // plugin provides this value. You should use only with IEX_GetInfo. If true ImageEn will search automatically for EXIF in file
#define IEX_FORMATSCOUNT         0x0105     // >1 if the plugin supports multiple formats

// IEX_GetInfo/IEX_SetInfo: values for IEX_CAPABILITY
#define IEX_FILEREADER           0x0001
#define IEX_FILEWRITER           0x0010
#define IEX_MULTITHREAD          0x0100

// IEX_GetInfo/IEX_SetInfo: values for IEX_PIXELFORMAT
#define IEX_INVALID  0
#define IEX_1G       1
#define IEX_8P       2
#define IEX_8G       3
#define IEX_16G      4
#define IEX_24RGB    5
#define IEX_32F      6
#define IEX_CMYK     7
#define IEX_48RGB    8

#endif
