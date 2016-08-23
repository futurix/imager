
// fximagerdefs.h - common definitions for FuturixImager plug-in system
//

#pragma once


// FuturixImager message
#define FI_MESSAGE			(WM_USER + 147)

// application strings (ANSI only)
#define SAPPNAME 			"FuturixImager"
#define SAPPNAMEEX			SAPPNAME
#define SVERSION			"5.8.6"
#define SVERSIONEX			"5.8.6.0"
#define SAUTHOR 			"Alexander Tereshchenko"
#define SRIGHTS 			"© 1999-2007 Alexander Tereshchenko"
#define SREGASSOCIATION		SAPPNAME
#define SREGASSOCIATIONOLD	(SAPPNAME + ".old")

// version info
#define FXVER_MAJOR			5
#define FXVER_MINOR			8
#define FXVER_REVISION		6
#define FXVER_BUILD			0

// registry paths
#define SREG 				"\\Software\\alex_t\\FuturixImager"
#define SSETTINGS			"\\Software\\alex_t\\FuturixImager\\Settings"
#define SMODULES 			"\\Software\\alex_t\\FuturixImager\\Plug-ins"

// internal formats ID
#define SINTERNALFORMAT		"fx_internal"

// URLs
#define SURL				"http://www.fxfp.com/"

// plug-in signatures
#define SLOCALEID 			"FxImgLocaleR2"
#define STHEMEID 			"FxImgThemeR1"

// registry value names
#define SLOCALENAME			"CurrentLocaleName"
#define SLOCALELIB			"CurrentLocaleLib"
#define STHEMENAME			"CurrentThemeName"
#define STHEMELIB			"CurrentThemeLib"

// application filenames
#define FN_APP				"fximager.exe"
#define FN_FORMATS			"fxformats.exe"
#define FN_ADDRAW			"fxraw.dll"
#define FN_ADDJBIG			"fxjbig.dll"

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
#define PT_FOPENMULTI 		11
#define PT_FOPENANIM 		19
#define PT_FSAVE 			20
#define PT_FIMPORT 			30
#define PT_FEXPORT 			40
#define PT_FFILTER 			50
#define PT_FINFO 			60
#define PT_FTOOL 			80

// plug-in type strings
#define PS_FNAME 			"Plug-ins"
#define PS_FROLE 			"Roles"
#define PS_FCONFIG			"Settings"
#define PS_FDESCR 			"Descriptions"
#define PS_FNOTREC			"NotRecommended"
#define PS_FLOCALE 			"Locales"
#define PS_FTHEME 			"Themes"
#define PS_FOPEN 			"OpenBitmap"
#define PS_FOPENMULTI 		"OpenPages"
#define PS_FOPENANIM 		"OpenAnimation"
#define PS_FSAVE 			"Save"
#define PS_FIMPORT 			"Import"
#define PS_FEXPORT 			"Export"
#define PS_FFILTER 			"Filter"
#define PS_FINFO 			"Information"
#define PS_FTOOL 			"SimpleTool"
  
// exported function names
#define EX_QUERY			"FxImgQuery"
#define EX_CFG				"FxImgCfg"
#define EX_OPENPLAIN		"FxImgOpen"
#define EX_SAVE				"FxImgSave"
#define EX_IMPORT			"FxImgImport"                             
#define EX_EXPORT			"FxImgExport"
#define EX_FILTER			"FxImgFilter"
#define EX_SIMPLETOOL		"FxImgTool"
#define EX_INFO				"FxImgInfo"
#define EX_ANIMSTART		"FxImgAnimStart"
#define EX_ANIMRESTART		"FxImgAnimRestart"
#define EX_ANIMFRAME		"FxImgAnimGetFrame"
#define EX_ANIMSTOP			"FxImgAnimStop"
#define EX_MULTISTART		"FxImgMultiStart"
#define EX_MULTIPAGE		"FxImgMultiGetPage"
#define EX_MULTISTOP		"FxImgMultiStop"

// FXIMGRESULT result types
#define RT_BOOL				0
#define RT_HBITMAP			1
#define RT_HIMAGE			2
#define RT_INT				3
#define RT_HWND				4
#define RT_PCHAR			5
#define RT_PWCHAR			6
#define RT_PTR				7
#define RT_HANDLE			8
  
// boolean values
#define FX_FALSE			0
#define FX_TRUE				1

// TFxImgResult string result types
#define ST_PCHAR			0
#define ST_PWCHAR			1
#define ST_PTR				2

// TAppCallBack queries
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
#define PR_HEX				"ROLE::HEX"


// result structure
struct FXIMGRESULT
{
	ULONG result_type, result_value, result_xtra, result_access;
	ULONG result_string_type, result_string_xtra;
	char result_string_data[2048];
}; 


// callback prototypes
typedef BOOL (__cdecl *PREVIEWCALLBACK)(HBITMAP preview);
typedef BOOL (__cdecl *PLUGINCALLBACK)(ULONG module_type, LPSTR value1, LPSTR value2);
typedef BOOL (__cdecl *DOUBLECALLBACK)(LPSTR name, LPSTR value);
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
	LPSTR plugin_path,
	PLUGINCALLBACK info_call,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgCfg(
	LPSTR info,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}                                   


extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgOpen(
	LPSTR document_path, LPSTR info,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
} 

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgSave(
	LPSTR document_path, LPSTR info,
	HBITMAP img,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
} 

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgImport(
	LPSTR info,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
} 

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgExport(
	LPSTR info,
	HBITMAP img,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgFilter(
	LPSTR info,
	HBITMAP img,
	PREVIEWCALLBACK preview_call,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgTool(
	LPSTR document_path, LPSTR info,
	HBITMAP img,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgInfo(
	LPSTR document_path, LPSTR info,
	DOUBLECALLBACK info_call,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}


extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgAnimStart(
	LPSTR document_path, LPSTR info,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgAnimRestart(
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgAnimGetFrame(
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgAnimStop(
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}


extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgMultiStart(
	LPSTR document_path, LPSTR info,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgMultiGetPage(
	ULONG page_index,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgMultiStop(
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}
*/

