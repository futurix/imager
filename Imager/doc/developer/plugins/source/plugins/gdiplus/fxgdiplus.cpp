
// fxgdiplus.cpp - initialization routines for the DLL.
//

#include "stdafx.h"
#include "fxgdiplus.h"

BEGIN_MESSAGE_MAP(CFxGDIplusApp, CWinApp)
END_MESSAGE_MAP()

CFxGDIplusApp theApp;

ULONG_PTR gdiplusToken;
Bitmap* pBitmap = NULL;
ULONG nFrame = 0;


CFxGDIplusApp::CFxGDIplusApp()
{
}

BOOL CFxGDIplusApp::InitInstance()
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
	
	// setting up result structure
	FXIMGRESULT result;
	::ZeroMemory(&result, sizeof(FXIMGRESULT));
	result.result_type = RT_BOOL;
	result.result_value = FX_TRUE;
	
	info_call(PT_FNAME, "GDI+ integration", "");
	info_call(PT_FOPENANIM, "gif", "");
	
	return result;
}


extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgAnimStart(
	LPSTR document_path, LPSTR info,
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
	
	// initializing GDI+
	GdiplusStartupInput gdiplusStartupInput;
	GdiplusStartup(&gdiplusToken, &gdiplusStartupInput, NULL);
	
	// loading
	pBitmap = new Bitmap(A2W(document_path));
	
	if (pBitmap->GetFrameCount(&FrameDimensionTime) <= 1)
		result.result_value = FX_FALSE;
	
	return result;
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgAnimRestart(
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
	
	// setting up result structure
	FXIMGRESULT result;
	::ZeroMemory(&result, sizeof(FXIMGRESULT));
	result.result_type = RT_BOOL;
	result.result_value = FX_TRUE;
	
	// setting frame counter to zero
	nFrame = 0;
	
	return result;
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgAnimGetFrame(
	HWND app, HWND wnd,
	APPCALLBACK app_query)
{
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
	
	// setting up result structure
	FXIMGRESULT result;
	::ZeroMemory(&result, sizeof(FXIMGRESULT));
	result.result_type = RT_INT;
	result.result_value = 0;
	
	// frame counter
	nFrame++;
	if (nFrame == pBitmap->GetFrameCount(&FrameDimensionTime))
  		nFrame = 0;
  		
  	pBitmap->SelectActiveFrame(&FrameDimensionTime, nFrame);
	
	HBITMAP hFrame;
	
	if (pBitmap->GetHBITMAP(Color::White, &hFrame) == Ok)
	{
		result.result_value = (ULONG)hFrame;
		
		// getting delay
		UINT uiSize = pBitmap->GetPropertyItemSize(PropertyTagFrameDelay);
		PropertyItem* propertyItem = (PropertyItem*)malloc(uiSize);
		
		pBitmap->GetPropertyItem(PropertyTagFrameDelay, uiSize, propertyItem); 
		
		result.result_xtra = ((long*)propertyItem->value)[nFrame] * 10;
		free(propertyItem);
	}
	else
	{
		result.result_value = 0;
		result.result_xtra = 0;
	}

	return result;
}

extern "C" __declspec(dllexport) FXIMGRESULT __cdecl FxImgAnimStop(
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
	delete pBitmap;
	nFrame = 0;
	
	// unloading GDI+
	GdiplusShutdown(gdiplusToken);
	
	return result;
}

