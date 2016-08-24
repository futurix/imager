
// stdafx.h - include file for standard system include files,
// or project specific include files that are used frequently
// 

#pragma once

#ifndef VC_EXTRALEAN
	#define VC_EXTRALEAN		
#endif

#ifndef WINVER				
	#define WINVER 0x0501		
#endif

#ifndef _WIN32_WINNT		                   
	#define _WIN32_WINNT 0x0501	
#endif						

#ifndef _WIN32_WINDOWS		
	#define _WIN32_WINDOWS 0x0410
#endif

#ifndef _WIN32_IE			
	#define _WIN32_IE 0x0600	
#endif

#define _ATL_CSTRING_EXPLICIT_CONSTRUCTORS

#include <afxwin.h>         
#include <afxext.h>         

#ifndef _AFX_NO_OLE_SUPPORT
	#include <afxole.h>         
	#include <afxodlgs.h>       
	#include <afxdisp.h>        
#endif // _AFX_NO_OLE_SUPPORT

#ifndef _AFX_NO_DB_SUPPORT
	#include <afxdb.h>
#endif

#ifndef _AFX_NO_DAO_SUPPORT
	#include <afxdao.h>	
#endif

#ifndef _AFX_NO_OLE_SUPPORT
	#include <afxdtctl.h>		
#endif

#ifndef _AFX_NO_AFXCMN_SUPPORT
	#include <afxcmn.h>
#endif

#include <gdiplus.h>
using namespace Gdiplus;

#include "..\\..\\Shared\\fximagerdefs.h"

