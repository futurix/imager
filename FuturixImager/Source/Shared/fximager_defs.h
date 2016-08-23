
// fximagerdefs.h - common definitions for FuturixImager plug-in system

#pragma once


// registry paths
#define SREG					L"SOFTWARE\\Futurix\\FuturixImager"							// HKCU, HKLM
#define SSETTINGS				L"SOFTWARE\\Futurix\\FuturixImager\\Settings"				// HKCU
#define SPERSISTENTSETTINGS		L"SOFTWARE\\Futurix\\FuturixImager\\PersistentStore"		// HKCU, HKLM
#define SMODULES				L"SOFTWARE\\Futurix\\FuturixImager\\Cache"					// HKCU
#define SFORMATICONS			L"SOFTWARE\\Futurix\\FuturixImager\\IconLib"				// HKCU
#define SMODSEARCH				L"SOFTWARE\\Futurix\\FuturixImager\\PluginLocations"		// HKCU, HKLM

// URLs
#define SURL					L"http://dev.fxfp.com/"

// plug-in types
#define PT_FNAME				1
#define PT_FROLE				2
#define PT_FDESCR				5
#define PT_FNOTREC				6
#define PT_FGROUP				7
#define PT_FGROUPDESCR			8
#define PT_FOPEN				10
#define PT_FPREVIEW				15
#define PT_FSAVE				20
#define PT_FIMPORT				30
#define PT_FEXPORT				40
#define PT_FFILTER				50
#define PT_FTOOL				60

// core types for plug-in execution
#define CP_FQUERY				1
#define CP_FOPEN				2
#define CP_FPREVIEW				3
#define CP_FSAVE				4
#define CP_FIMPORT				5
#define CP_FEXPORT				6
#define CP_FFILTER				7
#define CP_FTOOL				8

// exported function name (ANSI only)
#define EX_CORE2				"FxCore2"

// FXIMGRESULT result types
#define RT_BOOL					0
#define RT_HBITMAP				1
#define RT_INT					2
#define RT_HWND					3
#define RT_PWCHAR				4
#define RT_PTR					5
#define RT_HANDLE				6

// FXIMGRESULT string result types
#define ST_PWCHAR				0
#define ST_PTR					1

// APPCALLBACK queries
#define CQ_GETIMGBITMAP			10
#define CQ_GETIMGPATH			11

// predefined plug-in roles
#define PR_PRINT				L"ROLE::PRINT"
#define PR_PRINTPREVIEW			L"ROLE::PRINTPREVIEW"
#define PR_SCAN					L"ROLE::SCAN"
#define PR_CAPTURE				L"ROLE::CAPTURE"
#define PR_JPEGLL				L"ROLE::JPEGLL"

// boolean values
#define FX_FALSE				0
#define FX_TRUE					1


// structures
struct FXIMGRESULT
{
	ULONG result_type, result_value, result_xtra, result_access;
	ULONG result_string_type, result_string_xtra;
	WCHAR result_string_data[2048];
}; 

struct FXCORE2RESULT
{
	ULONG res;
	LPVOID data;
}; 


// callback prototypes
typedef BOOL (__cdecl *PREVIEWCALLBACK)(HBITMAP preview);
typedef BOOL (__cdecl *PLUGINCALLBACK)(ULONG module_type, LPWSTR value1, LPWSTR value2);
typedef BOOL (__cdecl *DOUBLECALLBACK)(LPWSTR name, LPWSTR value);
typedef FXIMGRESULT (__cdecl *APPCALLBACK)(ULONG query_type, ULONG value, ULONG xtra);


//
//	The following are sample function definitions.
//	Copy them to your code and uncomment.
//
//  In the typical function you will need to do following:
//	1. If you are using MFC, call AFX_MANAGE_STATE macro. 
//	2. Define structure of FXIMGRESULT type, zero it and set default result.
//	3. Then do all your code.
//	4. Return result structure with correctly set result_type and result_value (see
//	   sample for info on what exactly to do.
//	

/*

extern "C" __declspec(dllexport) FXCORE2RESULT __cdecl FxCore2(
	ULONG p_intf,
	APPCALLBACK app_query)
{
	//
	//
}

FXIMGRESULT __cdecl FxImgQuery(
	LPWSTR plugin_path,
	PLUGINCALLBACK info_call,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

FXIMGRESULT __cdecl FxImgOpen(
	LPWSTR document_path, LPWSTR info,
	ULONG page,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
} 

FXIMGRESULT __cdecl FxImgPreview(
	LPWSTR document_path, LPWSTR info,
	ULONG speed,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

FXIMGRESULT __cdecl FxImgSave(
	LPWSTR document_path, LPWSTR info,
	HBITMAP img,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
} 

FXIMGRESULT __cdecl FxImgImport(
	LPWSTR info,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
} 

FXIMGRESULT __cdecl FxImgExport(
	LPWSTR info,
	HBITMAP img,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

FXIMGRESULT __cdecl FxImgFilter(
	LPWSTR info,
	HBITMAP img,
	PREVIEWCALLBACK preview_call,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

FXIMGRESULT __cdecl FxImgTool(
	LPWSTR document_path, LPWSTR info,
	HBITMAP img,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	//
	//
}

*/

