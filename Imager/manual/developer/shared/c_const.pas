// common constants and function declarations
unit c_const;

interface

uses
  Windows, Messages;

const
  FI_MESSAGE = WM_USER + 147;

  sAppName = 'Futuris Imager';
  sReg = '\Software\alex_t\Futuris Imager';
  sModules = '\Software\alex_t\Futuris Imager\Plug-ins';

  PT_FOPEN = 0;
  PT_FOPENMULTI = 1;
  PT_FOPENANIM = 2;
  PT_FSAVE = 3;
  PT_FIMPORT = 4;
  PT_FEXPORT = 5;
  PT_FFILTER = 6;
  PT_FINFO = 7;
  PT_FTOOL = 8;

type
  TStringCallBack = procedure(filename: string); cdecl; // Pascal-only (should not be used in portable definitions)
  TDoubleCallBack = function(name, value: PChar):BOOL; cdecl;
  TValueCallBack = function(filename: PChar):BOOL; cdecl;
  TPlugInCallBack = function(module_type: integer; value1, value2: PChar):BOOL; cdecl;
  TFQuery = function(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; cdecl;

  // simple
  TFOpen = function(path, ext: PChar; app: THandle):hBitmap; cdecl;
  TFSave = function(path, ext: PChar; app, wnd: THandle; img: hBitmap):integer; cdecl;
  TFImport = function(info: PChar; app, wnd: THandle):hBitmap; cdecl;
  TFExport = function(info: PChar; app, wnd: THandle; img: hBitmap):integer; cdecl;
  TFFilter = function(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap; cdecl;
  TFTool = function(info,path: PChar; app, wnd: THandle; img: hBitmap):hBitmap; cdecl;
  TFInfo = function(path, ext: PChar; func: TDoubleCallBack; app, wnd: THandle):integer; cdecl;

  // animation
  TFAnimStart = function(filename, ext: PChar; app: THandle):integer; cdecl;
  TFAnimRestart = function():integer; cdecl;
  TFAnimGetFrame = function(var img: hBitmap; var delay: integer):integer; cdecl;
  TFAnimStop = function():integer; cdecl;

  // multi-page
  TFMultiStart = function(filename, ext: PChar; app: THandle):integer; cdecl;
  TFMultiGetPage = function(index: integer):hBitmap; cdecl;
  TFMultiStop = function():integer; cdecl;
  
  // helper functions
  TFHelpPrint = function(app: HWND; img: HBITMAP; filename: PChar; fast: BOOL):BOOL; cdecl;


implementation
end.
