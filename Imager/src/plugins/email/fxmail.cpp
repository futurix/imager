
// defines the initialization routines for the DLL
//

#include "stdafx.h"
#include "fxmail.h"

BEGIN_MESSAGE_MAP(CFxApp, CWinApp)
END_MESSAGE_MAP()

CFxApp theApp;


CFxApp::CFxApp()
{
}

BOOL CFxApp::InitInstance()
{
	CWinApp::InitInstance();

	return TRUE;
}


extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgQuery(
	LPSTR plugin_path,
	PLUGINCALLBACK info_call,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
	USES_CONVERSION;
	
	// setting up result structure
	FXIMGRESULT result;
	::ZeroMemory(&result, sizeof(FXIMGRESULT));
	result.result_type = RT_BOOL;
	result.result_value = FX_TRUE;
	
	// getting library handle for localized strings
	HINSTANCE hLocInst = NULL;
	
	if (app_query)
	{
		FXIMGRESULT tempRes;
		::ZeroMemory(&tempRes, sizeof(FXIMGRESULT));
		
		tempRes = app_query(CQ_GETLANGLIBS, 0, 0);
		
		if (tempRes.result_type == RT_HANDLE)
		{
			if (tempRes.result_value)
				hLocInst = (HINSTANCE)tempRes.result_value;
			else if (tempRes.result_xtra)
				hLocInst = (HINSTANCE)tempRes.result_xtra;
		}
	}
	
    info_call(PT_FNAME, "Send by e-mail", "");
	info_call(PT_FROLE, PR_EMAIL, "");
	
	// localized plug-in name
	if (hLocInst)
	{
		CString csDescr;
		
		if (csDescr.LoadString(hLocInst, 3600))
			info_call(PT_FTOOL, W2A(csDescr), "");
	}
	
	return result;
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgTool(
	LPSTR document_path, LPSTR info,
	HBITMAP img,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
	USES_CONVERSION;
	
	// setting up result structure
	FXIMGRESULT result;
	::ZeroMemory(&result, sizeof(FXIMGRESULT));
	result.result_type = RT_BOOL;
	result.result_value = FX_TRUE;
	
	// getting library handle for localized strings
	HINSTANCE hLocInst = NULL;
	
	if (app_query)
	{
		FXIMGRESULT tempRes;
		::ZeroMemory(&tempRes, sizeof(FXIMGRESULT));
		
		tempRes = app_query(CQ_GETLANGLIBS, 0, 0);
		
		if (tempRes.result_type == RT_HANDLE)
		{
			if (tempRes.result_value)
				hLocInst = (HINSTANCE)tempRes.result_value;
			else if (tempRes.result_xtra)
				hLocInst = (HINSTANCE)tempRes.result_xtra;
		}
	}
	
	// trying to send file via MAPI
	if (PathFileExists(A2W(document_path)))
	{
		HMODULE hlibMAPI = ::LoadLibrary(_T("MAPI32.dll")); 
		
		if (hlibMAPI)
		{
			LPMAPISENDDOCUMENTS fSendDocs = (LPMAPISENDDOCUMENTS)::GetProcAddress(hlibMAPI, "MAPISendDocuments");
			
			if (fSendDocs)
				fSendDocs(0, ";", document_path, "", 0);
			
			::FreeLibrary(hlibMAPI);		
		} 
	}
	else if (hLocInst)
	{
		CString csErrorMessage;
		csErrorMessage.LoadString(hLocInst, 3085);
		
		MessageBox(wnd, csErrorMessage, A2T(SAPPNAME), MB_OK | MB_ICONWARNING);
	}
	
	return result;
}

