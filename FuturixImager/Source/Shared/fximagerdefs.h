
// fximagerdefs.h - common definitions for FuturixImager plug-in system
//

#pragma once


// application strings
#define SAPPNAME 			L"FuturixImager"
#define SVERSION			L"6.0"
#define SVERSIONEX			L"6.0.0.0"
#define SAUTHOR 			L"Alexander Tereshchenko"
#define SRIGHTS 			L"© 1999-2009 Alexander Tereshchenko"
#define SREGASSOCIATION		L"FuturixImager_6"
#define SREGASSOCIATIONOLD	L"FuturixImager_6_BAK"

// version info
#define FXVER_MAJOR			6
#define FXVER_MINOR			0
#define FXVER_REVISION		0
#define FXVER_BUILD			0

// registry paths
#define SREG 				L"\\Software\\Futurix\\FuturixImager"
#define SSETTINGS			L"\\Software\\Futurix\\FuturixImager\\Settings"
#define SMODULES 			L"\\Software\\Futurix\\FuturixImager\\Cache"

// internal formats ID
#define SINTERNALFORMAT		L"fx_ip"

// URLs
#define SURL				L"http://fximage.com/"

// plug-in signatures
#define SLOCALEID 			L"FxImgLocaleR3"
#define STHEMEID 			L"FxImgThemeR3"

// registry value names
#define SLOCALENAME			L"CurrentLocaleName"
#define SLOCALELIB			L"CurrentLocaleLib"
#define STHEMENAME			L"CurrentThemeName"
#define STHEMELIB			L"CurrentThemeLib"

// registry access constants
#define RA_FULL				(KEY_QUERY_VALUE | KEY_ENUMERATE_SUB_KEYS | \
  								KEY_CREATE_SUB_KEY | KEY_SET_VALUE)
#define RA_READONLY			(KEY_QUERY_VALUE | KEY_ENUMERATE_SUB_KEYS)

// plug-in types
#define PT_FNAME 			1
#define PT_FROLE 			2
#define PT_FCONFIG			3
#define PT_FDESCR 			5
#define PT_FNOTREC 			6
#define PT_FOPEN 			10
#define PT_FPREVIEW			15
#define PT_FSAVE 			20
#define PT_FIMPORT 			30
#define PT_FEXPORT 			40
#define PT_FFILTER 			50
#define PT_FINFO 			60
#define PT_FTOOL 			80

// plug-in type strings
#define PS_FNAME 			L"Plug-ins"
#define PS_FROLE 			L"Roles"
#define PS_FCONFIG			L"Settings"
#define PS_FDESCR 			L"Descriptions"
#define PS_FNOTREC			L"NotRecommended"
#define PS_FLOCALE 			L"Locales"
#define PS_FTHEME 			L"Themes"
#define PS_FOPEN 			L"Open"
#define PS_FPREVIEW			L"Preview"
#define PS_FSAVE 			L"Save"
#define PS_FIMPORT 			L"Import"
#define PS_FEXPORT 			L"Export"
#define PS_FFILTER 			L"Filter"
#define PS_FINFO 			L"Information"
#define PS_FTOOL 			L"SimpleTool"
  
// exported function names (ANSI only)
#define EX_QUERY			"FxImgQuery"
#define EX_CFG				"FxImgCfg"
#define EX_OPENPLAIN		"FxImgOpen"
#define EX_PREVIEW			"FxImgPreview"
#define EX_SAVE				"FxImgSave"
#define EX_IMPORT			"FxImgImport"                             
#define EX_EXPORT			"FxImgExport"
#define EX_FILTER			"FxImgFilter"
#define EX_SIMPLETOOL		"FxImgTool"
#define EX_INFO				"FxImgInfo"

// FXIMGRESULT result types
#define RT_BOOL				0
#define RT_HBITMAP			1
#define RT_INT				2
#define RT_HWND				3
#define RT_PWCHAR			4
#define RT_PTR				5
#define RT_HANDLE			6
  
// boolean values
#define FX_FALSE			0
#define FX_TRUE				1

// FXIMGRESULT string result types
#define ST_PWCHAR			0
#define ST_PTR				1

// APPCALLBACK queries
#define CQ_GETLANGLIBS		7
#define CQ_GETIMGBITMAP		100
#define CQ_GETIMGPATH		120

// predefined plug-in roles
#define PR_PRINT			"ROLE::PRINT"
#define PR_PRINTPREVIEW		"ROLE::PRINTPREVIEW"
#define PR_SCAN				"ROLE::SCAN"
#define PR_EMAIL			"ROLE::EMAIL"
#define PR_CAPTURE			"ROLE::CAPTURE"
#define PR_JPEGLL			"ROLE::JPEGLL"
#define PR_EDITOR			"ROLE::EDITOR"


// result structure
struct FXIMGRESULT
{
	ULONG result_type, result_value, result_xtra, result_access;
	ULONG result_string_type, result_string_xtra;
	WCHAR result_string_data[2048];
}; 


// callback prototypes
typedef BOOL (__cdecl *PREVIEWCALLBACK)(HBITMAP preview);
typedef BOOL (__cdecl *PLUGINCALLBACK)(ULONG module_type, LPWSTR value1, LPWSTR value2);
typedef BOOL (__cdecl *DOUBLECALLBACK)(LPWSTR name, LPWSTR value);
typedef FXIMGRESULT (__cdecl *APPCALLBACK)(ULONG query_type, ULONG value, ULONG xtra);


//
//	The following are sample function definitions.
//	Copy them to your source and uncomment.
//
//  In the typical function you will need to do following:
//	1. If you are using MFC, call AFX_MANAGE_STATE macro. 
//	2. Define structure of FXIMGRESULT type, zero it and set default result.
//	3. Then do all your code.
//	4. Return result structure with correctly set result_type and result_value (see
//	   sample for info on what exactly to do.
//	

/*

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgQuery(
	LPWSTR plugin_path,
	PLUGINCALLBACK info_call,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgCfg(
	LPWSTR info,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}                                   


extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgOpen(
	LPWSTR document_path, LPWSTR info,
	ULONG page,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
} 

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgSave(
	LPWSTR document_path, LPWSTR info,
	HBITMAP img,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
} 

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgImport(
	LPWSTR info,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
} 

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgExport(
	LPWSTR info,
	HBITMAP img,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgFilter(
	LPWSTR info,
	HBITMAP img,
	PREVIEWCALLBACK preview_call,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgTool(
	LPWSTR document_path, LPWSTR info,
	HBITMAP img,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgInfo(
	LPWSTR document_path, LPWSTR info,
	DOUBLECALLBACK info_call,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgPreview(
	LPWSTR document_path, LPWSTR info,
	ULONG speed,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

*/

