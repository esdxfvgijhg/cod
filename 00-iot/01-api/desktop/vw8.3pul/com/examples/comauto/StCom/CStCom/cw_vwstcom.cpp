// Machine generated IDispatch wrapper class(es) created with ClassWizard

#include "stdafx.h"
#include "cw_vwstcom.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif



/////////////////////////////////////////////////////////////////////////////
// ISmalltalkCommanderDispatchDriver properties

/////////////////////////////////////////////////////////////////////////////
// ISmalltalkCommanderDispatchDriver operations

VARIANT ISmalltalkCommanderDispatchDriver::Evaluate(LPCTSTR Expression)
{
	VARIANT result;
	static BYTE parms[] =
		VTS_BSTR;
	InvokeHelper(0x60020000, DISPATCH_METHOD, VT_VARIANT, (void*)&result, parms,
		Expression);
	return result;
}

CString ISmalltalkCommanderDispatchDriver::EvaluateAsString(LPCTSTR Expression)
{
	CString result;
	static BYTE parms[] =
		VTS_BSTR;
	InvokeHelper(0x60020001, DISPATCH_METHOD, VT_BSTR, (void*)&result, parms,
		Expression);
	return result;
}

void ISmalltalkCommanderDispatchDriver::Quit()
{
	InvokeHelper(0x60020002, DISPATCH_METHOD, VT_EMPTY, NULL, NULL);
}
