/////////////////////////////////////////////////////////////////////////////
// 
// CstCom.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"
#include "CstCom.h"
#include "CstComDlg.h"
#include "OptionsDlg.h"
#include "iid_vwstcom.h"
#include <afxpriv.h>

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CCstComApp

BEGIN_MESSAGE_MAP(CCstComApp, CWinApp)
	//{{AFX_MSG_MAP(CCstComApp)
	ON_COMMAND(ID_HELP_ABOUT, OnHelpAbout)
	ON_COMMAND(ID_SMALLTALK_EVALUATE, Evaluate)
	ON_COMMAND(ID_SMALLTALK_OPTIONS, OnSmalltalkOptions)
	ON_COMMAND(ID_FILE_EXIT, OnFileExit)
	ON_COMMAND(ID_FILE_OPENWORKSPACE, OnFileOpenWorkspace)
	ON_COMMAND(ID_FILE_SAVEWORKSPACE, OnFileSaveWorkspace)
	ON_COMMAND(ID_FILE_SAVEANSWER, OnFileSaveAnswer)
	//}}AFX_MSG_MAP
	ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCstComApp construction

CCstComApp::CCstComApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
	m_UseVTable = TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CCstComApp object

CCstComApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CCstComApp initialization

BOOL CCstComApp::InitInstance()
{
	AfxEnableControlContainer();

	// Standard initialization
	// If you are not using these features and wish to reduce the size
	//  of your final executable, you should remove from the following
	//  the specific initialization routines you do not need.

#ifdef _AFXDLL
	Enable3dControls();			// Call this when using MFC in a shared DLL
#else
	Enable3dControlsStatic();	// Call this when linking to MFC statically
#endif

	if (CoInitialize(NULL) != S_OK)
	{
		AfxMessageBox(IDS_UNABLE_TO_INITIALIZE);
	};
	if (!StartSmalltalkCommander())
	{
		return FALSE;
	}

	CCstComDlg dlg;
	m_pMainWnd = &dlg;
	dlg.m_Expression = "100 factorial";
	int nResponse = dlg.DoModal();
	if (nResponse == IDOK)
	{
		// TODO: Place code here to handle when the dialog is
		//  dismissed with OK
	}
	else if (nResponse == IDCANCEL)
	{
		// TODO: Place code here to handle when the dialog is
		//  dismissed with Cancel
	}

	m_StComDispatchDriver.ReleaseDispatch();
	if (m_StComDualInterface)
	{
		m_StComDualInterface->Release();
	}

	CoUninitialize();
	// Since the dialog has been closed, return FALSE so that we exit the
	//  application, rather than start the application's message pump.
	return FALSE;
}

/////////////////////////////////////////////////////////////////////////////
// CCstComApp::StartSmalltalkCommander()

BOOL CCstComApp::StartSmalltalkCommander()
{
	COleException ex;
	if(!m_StComDispatchDriver.CreateDispatch("VisualWorks.SmalltalkCommander", &ex))
	{
		ex.ReportError();
		AfxMessageBox(IDS_UNABLE_TO_CREATE_IDISPATCH);
		return FALSE;
	}
	m_StComDualInterface = NULL;
	m_StComDispatchDriver.m_lpDispatch->
		QueryInterface(IID_ISmalltalkCommanderDisp, (void**)&m_StComDualInterface);
	if (!m_StComDualInterface)
	{
		AfxMessageBox(IDS_UNABLE_TO_CREATE_DUAL);
	}
	return TRUE;
}

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	virtual BOOL OnInitDialog();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

/////////////////////////////////////////////////////////////////////////////
// 

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

/////////////////////////////////////////////////////////////////////////////
// 

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()
/////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////
// 

void CCstComApp::OnHelpAbout() 
{
	CAboutDlg dlgAbout;
	dlgAbout.DoModal();		
}

/////////////////////////////////////////////////////////////////////////////
// 

void CCstComApp::Evaluate()
{
	USES_CONVERSION;

	CString cstring;
	CString answerString;

	StComDialog()->SetStatusBarText("Evaluating...");
	StComDialog()->GetExpression(cstring);
	if (m_UseVTable)
	{
		BSTR bstrOut;
		BSTR bstrIn = SysAllocString(T2OLE(cstring));
		if (bstrIn == NULL)
		{
			AfxMessageBox(IDS_OUT_OF_MEMORY);
			AfxAbort();
		}
		ASSERT (m_StComDualInterface != NULL);
		m_StComDualInterface->EvaluateAsString(bstrIn, &bstrOut);
		answerString = OLE2T(bstrOut);
	}
	else
	{
		answerString = m_StComDispatchDriver.EvaluateAsString(cstring);
	}
	StComDialog()->SetAnswer(answerString);
	StComDialog()->SetStatusBarText("Ready.");
}

/////////////////////////////////////////////////////////////////////////////
// 

void CCstComApp::OnSmalltalkOptions() 
{
	COptionsDlg dlgOptions;
	dlgOptions.SetUseVTable(m_UseVTable);
	int result = dlgOptions.DoModal();
	if ( ( -1 == result ) || ( IDABORT == result ) )
	{
		AfxMessageBox(IDS_UNABLE_TO_LOAD_DIALOG);
		return;
	}
	m_UseVTable = dlgOptions.GetUseVTable();
;
}


/////////////////////////////////////////////////////////////////////////////
// 

BOOL CAboutDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	CenterWindow(); // Center relative to parent.	
	return TRUE;  // return TRUE unless you set the focus to a control
	              // EXCEPTION: OCX Property Pages should return FALSE
}

/////////////////////////////////////////////////////////////////////////////
// 

void CCstComApp::OnFileExit() 
{
	StComDialog()->EndDialog(IDOK);
}

/////////////////////////////////////////////////////////////////////////////
// 

char szFilters[] =
		"Smalltalk workspace (*.ws;*.st)|*.ws;*.st|Text files(*.txt)|*.txt|All files (*.*)|*.*||";

/////////////////////////////////////////////////////////////////////////////
// 

void CCstComApp::OnFileOpenWorkspace() 
{
	CFileDialog dlg (TRUE, "st", "*.st",
		OFN_FILEMUSTEXIST, szFilters, m_pMainWnd);

	dlg.m_ofn.lpstrTitle = "Open Workspace";
	if (dlg.DoModal() != IDOK)
	{
		return;
	}

	CFile file;
	CFileException ex;

	if (!file.Open (dlg.GetPathName(), CFile::modeRead, &ex) )
	{
		ex.ReportError();
		return;
	}

	CString cstring;
	DWORD dwLength;
	char * lpBuffer;

	try {
		dwLength = file.GetLength();
		lpBuffer = new char[dwLength+1];
		file.Read (lpBuffer, dwLength);
		lpBuffer[dwLength] = 0;
		cstring = lpBuffer;
		delete lpBuffer;
	} 
	catch (CFileException write_ex) {
		write_ex.ReportError();
	}	
	StComDialog()->SetExpression(cstring);
}

/////////////////////////////////////////////////////////////////////////////
// 

void CCstComApp::FileSaveUserText(CString& cstring, LPCTSTR lpstrTitle) 
{
	CFileDialog dlg (FALSE, "st", "*.st",
		OFN_HIDEREADONLY , szFilters, m_pMainWnd);

	dlg.m_ofn.lpstrTitle = lpstrTitle;
	if (dlg.DoModal() != IDOK)
	{
		return;
	}

	CFile file;
	CFileException ex;

	if (!file.Open (dlg.GetPathName(), CFile::modeCreate|CFile::modeWrite, &ex) )
	{
		ex.ReportError();
		return;
	}

	try {
		file.Write (cstring, cstring.GetLength());
	} 
	catch (CFileException write_ex) {
		write_ex.ReportError();
	}
}

/////////////////////////////////////////////////////////////////////////////
// 

void CCstComApp::OnFileSaveWorkspace() 
{
	CString cstring;
	StComDialog()->GetExpression(cstring);

	FileSaveUserText(cstring, "Save Workspace As");
}

/////////////////////////////////////////////////////////////////////////////
// 

void CCstComApp::OnFileSaveAnswer() 
{
	CString cstring;
	StComDialog()->GetAnswer(cstring);

	FileSaveUserText(cstring, "Save Answer As");
}
