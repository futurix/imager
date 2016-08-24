
// main header file for the DLL
//

#pragma once
#include "resource.h"


class CFxApp: public CWinApp
{
	public:
		CFxApp();

		virtual BOOL InitInstance();

	DECLARE_MESSAGE_MAP()
};

