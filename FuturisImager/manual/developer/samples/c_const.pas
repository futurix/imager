{
	common constants and function declarations
	
	probably you don't need most of the string constants and callbacks
}

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
  PT_FDESCR = 9;

type
  TStringCallBack = procedure(filename: string); stdcall; // Pascal-only (should not be used in portable definitions)
  TDoubleCallBack = function(name, value: PChar):BOOL; stdcall;
  TValueCallBack = function(filename: PChar):BOOL; stdcall;
  TPlugInCallBack = function(module_type: integer; value1, value2: PChar):BOOL; stdcall;
  TFIPISquery = function(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;

  // simple
  TFIPISopen = function(path, ext: PChar; app: THandle):hBitmap; stdcall;
  TFIPISsave = function(path, ext: PChar; app, wnd: THandle; img: hBitmap):integer; stdcall;
  TFIPISimport = function(info: PChar; app, wnd: THandle):hBitmap; stdcall;
  TFIPISexport = function(info: PChar; app, wnd: THandle; img: hBitmap):integer; stdcall;
  TFIPISfilter = function(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;
  TFIPIStool = function(info,path: PChar; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;
  TFIPISinfo = function(path, ext: PChar; func: TDoubleCallBack; app, wnd: THandle):integer; stdcall;

  // animation
  TFIPISanimInit = function(filename, ext: PChar; app: THandle):integer; stdcall;
  TFIPISanimConfirm = function():integer; stdcall;
  TFIPISanimRestart = function():integer; stdcall;
  TFIPISanimGetFrame = function(var img: hBitmap; var delay: integer):integer; stdcall;
  TFIPISanimDeInit = function():integer; stdcall;

  //multi-page
  TFIPISmultiInit = function(filename, ext: PChar; app: THandle):integer; stdcall;
  TFIPISmultiGetPages = function():integer; stdcall;
  TFIPISmultiGetPage = function(index: integer):hBitmap; stdcall;
  TFIPISmultiDeInit = function():integer; stdcall;

implementation
end.

