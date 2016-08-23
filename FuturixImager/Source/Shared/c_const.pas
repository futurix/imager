unit c_const;

interface

uses
  Windows;

const
  sAppName              = 'FuturixImager';
  sVersion              = '6.0.1';
  sVersionEx            = '6.0.1.0';
  sAuthor               = 'Alexander Frost';
  sRights               = '© 1999-2011 Alexander Frost';
  sRegAssociation       = 'FuturixImager_6';
  sRegAssociationOld    = 'FuturixImager_6_BAK';

  FXVER_MAJOR           = 6;
  FXVER_MINOR           = 0;
  FXVER_REVISION        = 1;
  FXVER_BUILD           = 0;

  // registry paths
  sReg                  = 'SOFTWARE\Futurix\FuturixImager';                   // HKCU, HKLM
  sSettings             = 'SOFTWARE\Futurix\FuturixImager\Settings';          // HKCU
  sPersistentSettings   = 'SOFTWARE\Futurix\FuturixImager\PersistentStore';   // HKCU, HKLM
  sModules              = 'SOFTWARE\Futurix\FuturixImager\Cache';             // HKCU
  sFormatIcons          = 'SOFTWARE\Futurix\FuturixImager\IconLib';           // HKCU
  sModSearch            = 'SOFTWARE\Futurix\FuturixImager\PluginLocations';   // HKCU, HKLM

  // file names //
  FXFILE_APP            = 'fximager.exe';
  FXFILE_FORMATS        = 'fxfreg.exe';
  FXFILE_HELP           = 'fxhelp.exe';

  // URLs
  sURL                  = 'http://dev.fxfp.com/';

  // signatures //
  sThemeID              = 'FxImgThemeR6';
  sIconLibID            = 'FxImgIconLibR6';

  // registry value names //
  sThemeName            = 'CurrentThemeName';
  sThemeFile            = 'CurrentThemeFile';
  sIconLibName          = 'CurrentIconLibName';
  sIconLibFile          = 'CurrentIconLibFile';
  sPluginCounter        = 'UpdateCounter';
  sPersistentExts       = 'PersistentExtensions';
  sNotRecommended       = 'NotRecommended';

  // registry access //
  RA_FULL               = KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS or
                          KEY_CREATE_SUB_KEY or KEY_SET_VALUE;
  RA_READONLY           = KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS;

  // plug-in types for plug-in installation
  PT_FNAME         = 1;
  PT_FROLE         = 2;
  PT_FDESCR        = 5;
  PT_FNOTREC       = 6;
  PT_FGROUP        = 7;
  PT_FGROUPDESCR   = 8;
  PT_FOPEN         = 10;
  PT_FPREVIEW      = 15;
  PT_FSAVE         = 20;
  PT_FIMPORT       = 30;
  PT_FEXPORT       = 40;
  PT_FFILTER       = 50;
  PT_FTOOL         = 60;

  // core types for plug-in execution
  CP_FQUERY        = 1;
  CP_FOPEN         = 2;
  CP_FPREVIEW      = 3;
  CP_FSAVE         = 4;
  CP_FIMPORT       = 5;
  CP_FEXPORT       = 6;
  CP_FFILTER       = 7;
  CP_FTOOL         = 8;

  // plug-in IDs //
  PI_NULL          = 0;
  PI_INTERNAL      = 1;
  PI_CUSTOM        = 2;

  // plug-in registry keys //
  PS_FID           = 'PluginIDs';
  PS_FNAME         = 'PluginNames';
  PS_FROLE         = 'PluginRoles';
  PS_FDESCR        = 'FormatDescriptions';
  PS_FGROUP        = 'GroupFormats';
  PS_FGROUPDESCR   = 'GroupDescriptions';
  PS_FTHEME        = 'Themes';
  PS_FICONLIB      = 'IconLibraries';
  PS_FOPEN         = 'Open';
  PS_FPREVIEW      = 'Preview';
  PS_FSAVE         = 'Save';
  PS_FIMPORT       = 'Import';
  PS_FEXPORT       = 'Export';
  PS_FFILTER       = 'Filter';
  PS_FTOOL         = 'Tool';

  // exported function name
  EX_CORE2         = 'FxCore2';

  // TFxImgResult result types
  RT_BOOL          = 0;
  RT_HBITMAP       = 1;
  RT_INT           = 2;
  RT_HWND          = 3;
  RT_PWCHAR        = 4;
  RT_PTR           = 5;
  RT_HANDLE        = 6;

  // TFxImgResult string result types
  ST_PWCHAR        = 0;
  ST_PTR           = 1;

  // TAppCallBack queries
  CQ_GETIMGBITMAP  = 10;
  CQ_GETIMGPATH    = 11;

  // predefined plug-in roles
  PR_PRINT         = 'ROLE::PRINT';
  PR_PRINTPREVIEW  = 'ROLE::PRINTPREVIEW';
  PR_SCAN          = 'ROLE::SCAN';
  PR_CAPTURE       = 'ROLE::CAPTURE';
  PR_JPEGLL        = 'ROLE::JPEGLL';

  // boolean values
  FX_FALSE         = 0;
  FX_TRUE          = 1;


type
  TFxImgResult = record
    result_type, result_value, result_xtra, result_access: ULONG;
    result_string_type, result_string_xtra: ULONG;
    result_string_data: array[0..2047] of WideChar;
  end;

  TFxCore2Result = record
    res: ULONG;
    data: Pointer;
  end;

  TStringCallBack     = procedure(filename: string); cdecl;   // Pascal-only

  TPreviewCallBack    = function(preview: HBITMAP): BOOL; cdecl;
  TPlugInCallBack     = function(module_type: ULONG; value1, value2: PWideChar): BOOL; cdecl;
  TDoubleCallBack     = function(name, value: PWideChar): BOOL; cdecl;
  TAppCallBack        = function(query_type, value, xtra: ULONG): TFxImgResult; cdecl;


  TFxCore2            = function(
                          p_intf: ULONG;
                          app_query: TAppCallBack): TFxCore2Result; cdecl;

  TFxImgQuery         = function(
                          plugin_path: PWideChar;
                          info_call: TPlugInCallBack;
                          app, wnd: HWND;
                          app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgOpen          = function(
                          document_path, info: PWideChar;
                          page: ULONG;
                          app, wnd: HWND;
                          app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgPreview       = function(
                          document_path, info: PWideChar;
                          speed: ULONG;
                          app, wnd: HWND;
                          app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgSave          = function(
                          document_path, info: PWideChar;
                          img: HBITMAP;
                          app, wnd: HWND;
                          app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgImport        = function(
                          info: PWideChar;
                          app, wnd: HWND;
                          app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgExport        = function(
                          info: PWideChar;
                          img: HBITMAP;
                          app, wnd: HWND;
                          app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgFilter        = function(
                          info: PWideChar;
                          img: HBITMAP;
                          preview_call: TPreviewCallBack;
                          app, wnd: HWND;
                          app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgTool          = function(
                          document_path, info: PWideChar;
                          img: HBITMAP;
                          app, wnd: HWND;
                          app_query: TAppCallBack): TFxImgResult; cdecl;


implementation
end.
