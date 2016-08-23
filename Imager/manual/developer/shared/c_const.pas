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
  TStringCallBack = procedure(filename: string); stdcall; // Pascal-only (should not be used in portable definitions)
  TDoubleCallBack = function(name, value: PChar):BOOL; stdcall;
  TValueCallBack = function(filename: PChar):BOOL; stdcall;
  TPlugInCallBack = function(module_type: integer; value1, value2: PChar):BOOL; stdcall;
  TFQuery = function(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;

  // simple
  TFOpen = function(path, ext: PChar; app: THandle):hBitmap; stdcall;
  TFSave = function(path, ext: PChar; app, wnd: THandle; img: hBitmap):integer; stdcall;
  TFImport = function(info: PChar; app, wnd: THandle):hBitmap; stdcall;
  TFExport = function(info: PChar; app, wnd: THandle; img: hBitmap):integer; stdcall;
  TFFilter = function(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;
  TFTool = function(info,path: PChar; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;
  TFInfo = function(path, ext: PChar; func: TDoubleCallBack; app, wnd: THandle):integer; stdcall;

  // animation
  TFAnimStart = function(filename, ext: PChar; app: THandle):integer; stdcall;
  TFAnimRestart = function():integer; stdcall;
  TFAnimGetFrame = function(var img: hBitmap; var delay: integer):integer; stdcall;
  TFAnimStop = function():integer; stdcall;

  // multi-page
  TFMultiStart = function(filename, ext: PChar; app: THandle):integer; stdcall;
  TFMultiGetPage = function(index: integer):hBitmap; stdcall;
  TFMultiStop = function():integer; stdcall;
  
  // helper functions
  TFHelpPrint = function(app: HWND; img: HBITMAP; filename: PChar; fast: BOOL):BOOL; stdcall;


implementation
end.
