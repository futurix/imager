//////////////////////////////////////////////////
// SAMPLE FUTURIS IMAGER FILTER PLUG-IN
// Visual C++ 6.0
//
// Michael Johannhanwahr <johann@icnet.de>
// http://www.icnet.de
//


#include "StdAfx.h"
#include "SampleDlg.h"


#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif


class CWinDLL : public CWinApp
{
public:
	CWinDLL();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CWinDLL)
	//}}AFX_VIRTUAL

	//{{AFX_MSG(CWinDLL)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////
// CWinDLL

BEGIN_MESSAGE_MAP(CWinDLL,CWinApp)
	//{{AFX_MSG_MAP(CWindllApp)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()


/////////////////////////////////////////////////////////////////////////////
// CWindllApp construction

CWinDLL::CWinDLL()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CWindllApp object

CWinDLL theApp;



// function FIPISfilter(info: PChar; app: THandle; img: hBitmap):hBitmap; stdcall;

extern "C" __declspec (dllexport) HBITMAP FIPISfilter(char* info, HANDLE app, HBITMAP image)
{
	// Do something interesting with HBITMAP image

	CSampleDlg dlg;
	if (dlg.DoModal() == IDOK)
	{
		// return a new HBITMAP:
		return NULL;
	}
	else
	{
		return NULL;
	}
}


