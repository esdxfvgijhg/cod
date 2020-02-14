// Machine generated IDispatch wrapper class(es) created with ClassWizard
/////////////////////////////////////////////////////////////////////////////
// ISmalltalkCommanderDispatchDriver wrapper class

class ISmalltalkCommanderDispatchDriver : public COleDispatchDriver
{
public:
	ISmalltalkCommanderDispatchDriver() {}		// Calls COleDispatchDriver default constructor
	ISmalltalkCommanderDispatchDriver(LPDISPATCH pDispatch) : COleDispatchDriver(pDispatch) {}
	ISmalltalkCommanderDispatchDriver(const ISmalltalkCommanderDispatchDriver& dispatchSrc) : COleDispatchDriver(dispatchSrc) {}

// Attributes
public:

// Operations
public:
	VARIANT Evaluate(LPCTSTR Expression);
	CString EvaluateAsString(LPCTSTR Expression);
	void Quit();
};
