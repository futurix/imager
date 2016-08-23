
// fxgdiplus.h - main header file for the DLL
//

#pragma once

#include "resource.h"


class CFxGDIplusApp: public CWinApp
{
	public:
		CFxGDIplusApp();
		virtual BOOL InitInstance();
	
	DECLARE_MESSAGE_MAP()	
};

