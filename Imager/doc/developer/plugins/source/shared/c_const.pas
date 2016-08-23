unit c_const;

interface

uses
  Windows, Messages;

const
  sAppName 				= 'FuturixImager';
  sVersion				= '5.8.8';
  sVersionEx			= '5.8.8.0';
  sAuthor				= 'Alexander Tereshchenko';
  sRights 				= '© 1999-2008 Alexander Tereshchenko';
  sRegAssociation		= 'FuturixImager';
  sRegAssociationOld	= 'FuturixImager.old';

  FXVER_MAJOR			= 5;
  FXVER_MINOR			= 8;
  FXVER_REVISION		= 8;
  FXVER_BUILD			= 0;

  sReg 					= '\Software\alex_t\FuturixImager';
  sSettings				= '\Software\alex_t\FuturixImager\Settings';
  sModules 				= '\Software\alex_t\FuturixImager\Plug-ins';

  sInternalFormat		= 'fx_internal';

  // URLs
  sURL					= 'http://www.fximage.com/';

  // signatures
  sLocaleID 			= 'FxImgLocaleR2';
  sThemeID 				= 'FxImgThemeR1';

  // registry value names
  sLocaleName			= 'CurrentLocaleName';
  sLocaleLib			= 'CurrentLocaleLib';
  sThemeName			= 'CurrentThemeName';
  sThemeLib				= 'CurrentThemeLib';

  // application filenames
  FN_APP				= 'fximager.exe';
  FN_FORMATS			= 'fxformats.exe';
  FN_ADDRAW				= 'fxraw.dll';
  FN_ADDJBIG			= 'fxjbig.dll';
  FN_ADDMAGICK			= 'fxmagick.dll';

  // registry access
  RA_FULL				= KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS or
  							KEY_CREATE_SUB_KEY or KEY_SET_VALUE;
  RA_READONLY			= KEY_QUERY_VALUE or KEY_ENUMERATE_SUB_KEYS;

  // plug-in types
  PT_FNAME 				= 1;
  PT_FROLE 				= 2;
  PT_FCONFIG			= 3;
  PT_FDESCR 			= 5;
  PT_FNOTREC 			= 6;
  PT_FOPEN 				= 10;
  PT_FOPENMULTI 		= 11;
  PT_FOPENANIM 			= 19;
  PT_FSAVE 				= 20;
  PT_FIMPORT 			= 30;
  PT_FEXPORT 			= 40;
  PT_FFILTER 			= 50;
  PT_FINFO 				= 60;
  PT_FTOOL 				= 80;

  // plug-in type strings
  PS_FNAME 				= 'Plug-ins';
  PS_FROLE 				= 'Roles';
  PS_FCONFIG			= 'Settings';
  PS_FDESCR 			= 'Descriptions';
  PS_FNOTREC			= 'NotRecommended';
  PS_FLOCALE 			= 'Locales';
  PS_FTHEME 			= 'Themes';
  PS_FOPEN 				= 'OpenBitmap';
  PS_FOPENMULTI 		= 'OpenPages';
  PS_FOPENANIM 			= 'OpenAnimation';
  PS_FSAVE 				= 'Save';
  PS_FIMPORT 			= 'Import';
  PS_FEXPORT 			= 'Export';
  PS_FFILTER 			= 'Filter';
  PS_FINFO 				= 'Information';
  PS_FTOOL 				= 'SimpleTool';
  
  // exported function names
  EX_QUERY				= 'FxImgQuery';
  EX_CFG				= 'FxImgCfg';
  EX_OPENPLAIN			= 'FxImgOpen';
  EX_SAVE				= 'FxImgSave';
  EX_IMPORT				= 'FxImgImport';                                 
  EX_EXPORT				= 'FxImgExport';
  EX_FILTER				= 'FxImgFilter';
  EX_SIMPLETOOL			= 'FxImgTool';
  EX_INFO				= 'FxImgInfo';
  EX_ANIMSTART			= 'FxImgAnimStart';
  EX_ANIMRESTART		= 'FxImgAnimRestart';
  EX_ANIMFRAME			= 'FxImgAnimGetFrame';
  EX_ANIMSTOP			= 'FxImgAnimStop';
  EX_MULTISTART			= 'FxImgMultiStart';
  EX_MULTIPAGE			= 'FxImgMultiGetPage';
  EX_MULTISTOP			= 'FxImgMultiStop';

  // TFxImgResult result types
  RT_BOOL				= 0;
  RT_HBITMAP			= 1;
  RT_HIMAGE				= 2;
  RT_INT				= 3;
  RT_HWND				= 4;
  RT_PCHAR				= 5;
  RT_PWCHAR				= 6;
  RT_PTR				= 7;
  RT_HANDLE				= 8;

  // TFxImgResult string result types
  ST_PCHAR				= 0;
  ST_PWCHAR				= 1;
  ST_PTR				= 2;

  // TAppCallBack queries
  CQ_GETLANGLIBS		= 7;
  CQ_GETIMGBITMAP		= 100;
  CQ_GETIMGPATH			= 120;

  // predefined plug-in roles
  PR_PRINT				= 'ROLE::PRINT';
  PR_PRINTPREVIEW		= 'ROLE::PRINTPREVIEW';
  PR_SCAN				= 'ROLE::SCAN';
  PR_EMAIL				= 'ROLE::EMAIL';
  PR_CAPTURE			= 'ROLE::CAPTURE';
  PR_JPEGLL				= 'ROLE::JPEGLL';
  PR_HEX				= 'ROLE::HEX';
  
  // boolean values
  FX_FALSE				= 0;
  FX_TRUE				= 1;


type
  TFxImgResult = record
    result_type, result_value, result_xtra, result_access: ULONG;
    result_string_type, result_string_xtra: ULONG;
    result_string_data: array[0..2047] of char;
  end;

  TStringCallBack 		= procedure(filename: string); cdecl; 	// Pascal-only

  TPreviewCallBack 		= function(	preview: HBITMAP): BOOL; cdecl;
  TPlugInCallBack 		= function(	module_type: ULONG; value1, value2: PChar): BOOL; cdecl;
  TDoubleCallBack 		= function(	name, value: PChar): BOOL; cdecl;
  TAppCallBack 			= function(	query_type, value, xtra: ULONG): TFxImgResult; cdecl;

  
  TFxImgQuery 			= function(	plugin_path: PChar;
  									info_call: TPlugInCallBack;
  									app, wnd: HWND;
                                    app_query: TAppCallBack): TFxImgResult; cdecl;
                                    
  TFxImgCfg				= function(	info: PChar;
  									app, wnd: HWND;
                                    app_query: TAppCallBack): TFxImgResult; cdecl;
                                    

  TFxImgOpen 			= function(	document_path, info: PChar;
  									app, wnd: HWND;
                                    app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgSave 			= function(	document_path, info: PChar;
  									img: HBITMAP;
  									app, wnd: HWND;
                                    app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgImport 			= function(	info: PChar;
  									app, wnd: HWND;
                                    app_query: TAppCallBack): TFxImgResult; cdecl;
                                    
  TFxImgExport 			= function(	info: PChar;
  									img: HBITMAP;
  									app, wnd: HWND;
                                    app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgFilter 			= function(	info: PChar;
  									img: HBITMAP;
  									preview_call: TPreviewCallBack;
  									app, wnd: HWND;
                                    app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgTool 			= function(	document_path, info: PChar;
  									img: HBITMAP;
  									app, wnd: HWND;
                                    app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgInfo 			= function(	document_path, info: PChar;
  									info_call: TDoubleCallBack; 
  									app, wnd: HWND;
                                    app_query: TAppCallBack): TFxImgResult; cdecl;


  // animation (will be deprecated soon)
  TFxImgAnimStart 		= function(	document_path, info: PChar;
  									app, wnd: HWND;
                                    app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgAnimRestart 	= function(	app, wnd: HWND;
  									app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgAnimGetFrame 	= function(	app, wnd: HWND;
                                    app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgAnimStop 		= function(	app, wnd: HWND;
  									app_query: TAppCallBack): TFxImgResult; cdecl;


  // multi-page
  TFxImgMultiStart 		= function(	document_path, info: PChar;
  									app, wnd: HWND;
                                    app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgMultiGetPage 	= function(	page_index: ULONG;
                                    app, wnd: HWND;
  									app_query: TAppCallBack): TFxImgResult; cdecl;

  TFxImgMultiStop 		= function(	app, wnd: HWND;
  									app_query: TAppCallBack): TFxImgResult; cdecl;


implementation
end.
