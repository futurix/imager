
// initialization routines for the DLL
//

#include "stdafx.h"
#include "fxfimg.h"

BEGIN_MESSAGE_MAP(CFxApp, CWinApp)
END_MESSAGE_MAP()

CFxApp theApp;
CStringA csFilename = "";


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
	
    info_call(PT_FNAME, "FreeImage integration", "");

	info_call(PT_FOPEN, "koa", "");
	info_call(PT_FOPEN, "iff", "");
	info_call(PT_FOPEN, "ilbm", "");
	info_call(PT_FOPEN, "lbm", "");
	info_call(PT_FOPEN, "dds", "");
	info_call(PT_FOPEN, "ras", "");
	info_call(PT_FOPEN, "xbm", "");
	info_call(PT_FOPEN, "xpm", "");
	info_call(PT_FOPEN, "ico", "");
	info_call(PT_FOPEN, "hdr", "");

	info_call(PT_FOPENMULTI, "ico", "");

    info_call(PT_FNOTREC, "koa", "");
    info_call(PT_FNOTREC, "iff", "");
    info_call(PT_FNOTREC, "ilbm", "");
    info_call(PT_FNOTREC, "lbm", "");
    info_call(PT_FNOTREC, "dds", "");
    info_call(PT_FNOTREC, "ras", "");
	
	// localized plug-in description
	if (hLocInst)
	{
		CString csDescr;
		
		if (csDescr.LoadString(hLocInst, 1023))
			info_call(PT_FDESCR, "koa", W2A(csDescr));
		
		if (csDescr.LoadString(hLocInst, 1024))
			info_call(PT_FDESCR, "iff", W2A(csDescr));
		
		if (csDescr.LoadString(hLocInst, 1024))
			info_call(PT_FDESCR, "ilbm", W2A(csDescr));		
		
		if (csDescr.LoadString(hLocInst, 1024))
			info_call(PT_FDESCR, "lbm", W2A(csDescr));
			
		if (csDescr.LoadString(hLocInst, 1025))
			info_call(PT_FDESCR, "dds", W2A(csDescr));
		
		if (csDescr.LoadString(hLocInst, 1026))
			info_call(PT_FDESCR, "ras", W2A(csDescr));
		
		if (csDescr.LoadString(hLocInst, 1027))
			info_call(PT_FDESCR, "xbm", W2A(csDescr));
			
		if (csDescr.LoadString(hLocInst, 1028))
			info_call(PT_FDESCR, "xpm", W2A(csDescr));
		
		if (csDescr.LoadString(hLocInst, 1029))
			info_call(PT_FDESCR, "ico", W2A(csDescr));
		
		if (csDescr.LoadString(hLocInst, 1030))
			info_call(PT_FDESCR, "hdr", W2A(csDescr));
	}
	
	return result;
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgOpen(
	LPSTR document_path, LPSTR info,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
	
	// setting up result structure
	FXIMGRESULT result;
	::ZeroMemory(&result, sizeof(FXIMGRESULT));
	result.result_type = RT_HBITMAP;
	result.result_value = 0;
	
	// initializing FreeImage
	FreeImage_Initialise(TRUE);
	
	// extension should be lowercase
	CStringA csExt = info;
	csExt = csExt.MakeLower();
		
	// trying to recognize the format
	FREE_IMAGE_FORMAT t = FIF_UNKNOWN;
	
	if (csExt == "koa")
		t = FIF_KOALA;
	else if (csExt == "iff")
		t = FIF_IFF;
	else if (csExt == "ilbm")
		t = FIF_LBM;
	else if (csExt == "lbm")
		t = FIF_LBM;
	else if (csExt == "dds")
		t = FIF_DDS;
	else if (csExt == "ras")
		t = FIF_RAS;
	else if (csExt == "xbm")
		t = FIF_XBM;
	else if (csExt == "xpm")
		t = FIF_XPM;
	else if (csExt == "ico")
		t = FIF_ICO;
	else if (csExt == "hdr")
		t = FIF_HDR;
	else
		t = FreeImage_GetFileType(document_path);
	
	if (t != FIF_UNKNOWN)
	{
		FIBITMAP* dib = FreeImage_Load(t, document_path);
		
		if (dib)
		{
			if (t == FIF_HDR)
				dib = FreeImage_ToneMapping(dib, FITMO_DRAGO03, 1);
			
			// FuturixImager supports only 24-bit images
			if (FreeImage_GetBPP(dib) != 24)
				dib = FreeImage_ConvertTo24Bits(dib);
			
			// creating HBITMAP
			HBITMAP hResBitmap = CreateDIBitmap(::GetDC(0), FreeImage_GetInfoHeader(dib),
				CBM_INIT, FreeImage_GetBits(dib), FreeImage_GetInfo(dib), DIB_RGB_COLORS);
			
			result.result_value = (ULONG)hResBitmap;
			
			FreeImage_Unload(dib);
		}
	}	

	// cleaning
	FreeImage_DeInitialise();
	
	return result;
} 

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgMultiStart(
	LPSTR document_path, LPSTR info,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
	
	// setting up result structure
	FXIMGRESULT result;
	::ZeroMemory(&result, sizeof(FXIMGRESULT));
	result.result_type = RT_INT;
	result.result_value = 0;
	
	// saving filename for future calls
	csFilename = document_path;
	
	// initializing FreeImage
	FreeImage_Initialise(TRUE);
	
	// trying to load multi-page image
	FIMULTIBITMAP* mp = FreeImage_OpenMultiBitmap(FIF_ICO, csFilename, FALSE, TRUE);

	if (mp)
  	{
  		result.result_value = FreeImage_GetPageCount(mp);
        FreeImage_CloseMultiBitmap(mp);
  	}
	
	return result;
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgMultiGetPage(
	ULONG page_index,
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
	
	// setting up result structure
	FXIMGRESULT result;
	::ZeroMemory(&result, sizeof(FXIMGRESULT));
	result.result_type = RT_HBITMAP;
	result.result_value = 0;
	
	// loading multi-page image 
	FIMULTIBITMAP* mp = FreeImage_OpenMultiBitmap(FIF_ICO, csFilename, FALSE, TRUE);
	
	if (mp)
  	{
		FIBITMAP* dib = FreeImage_LockPage(mp, page_index);

		if (dib)
  		{
			// FuturixImager supports only 24-bit images
			if (FreeImage_GetBPP(dib) != 24)
				dib = FreeImage_ConvertTo24Bits(dib);
			
			// creating HBITMAP 			
 			HBITMAP hResBitmap = CreateDIBitmap(::GetDC(0), FreeImage_GetInfoHeader(dib),
 				CBM_INIT, FreeImage_GetBits(dib), FreeImage_GetInfo(dib), DIB_RGB_COLORS);
  			
  			result.result_value = (ULONG)hResBitmap;
  			
  			FreeImage_UnlockPage(mp, dib, FALSE);
  		}

        FreeImage_CloseMultiBitmap(mp);
     }
	
	return result;
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgMultiStop(
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
	
	// setting up result structure
	FXIMGRESULT result;
	::ZeroMemory(&result, sizeof(FXIMGRESULT));
	result.result_type = RT_BOOL;
	result.result_value = FX_TRUE;

	// cleaning
	FreeImage_DeInitialise();
	
	return result;
}

