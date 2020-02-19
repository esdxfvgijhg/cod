// CstComDlg.cpp : implementation file
//

#include "stdafx.h"
#include "CstCom.h"
#include "CstComDlg.h"
#include "resource.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern CCstComApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CCstComDlg dialog

CCstComDlg::CCstComDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CCstComDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCstComDlg)
	m_Expression = _T("");
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_hAccel = ::LoadAccelerators (AfxGetInstanceHandle(),
		MAKEINTRESOURCE (IDR_ACCELERATOR) );
}

void CCstComDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCstComDlg)
	DDX_Text(pDX, IDC_EDIT_EXPRESSION, m_Expression);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CCstComDlg, CDialog)
	//{{AFX_MSG_MAP(CCstComDlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_WM_CREATE()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCstComDlg message handlers

BOOL CCstComDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CCstComDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CCstComDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}

BEGIN_EVENTSINK_MAP(CCstComDlg, CDialog)
    //{{AFX_EVENTSINK_MAP(CCstComDlg)
	//}}AFX_EVENTSINK_MAP
END_EVENTSINK_MAP()

BOOL CCstComDlg::OnCommand(WPARAM wParam, LPARAM lParam) 
{	
	return CDialog::OnCommand(wParam, lParam);
}

void CCstComDlg::GetExpression(CString& cstring)
{
	GetControlExpression()->GetWindowText(cstring);
}

void CCstComDlg::GetAnswer(CString& cstring)
{
	GetControlAnswer()->GetWindowText(cstring);
}

void CCstComDlg::SetExpression(CString& cstring)
{
	GetControlExpression()->SetWindowText(cstring);
}

void CCstComDlg::SetAnswer(CString& cstring)
{
	GetControlAnswer()->SetWindowText(cstring);
}

void CCstComDlg::SetStatusBarText(LPCSTR cstring)
{
}

BOOL CCstComDlg::PreTranslateMessage(MSG* pMsg) 
{
	if (m_hAccel != NULL)
	{
		if (::TranslateAccelerator (m_hWnd, m_hAccel, pMsg))
		{
			return TRUE;
		}
	}

	return CDialog::PreTranslateMessage(pMsg);
}

int CCstComDlg::OnCreate(LPCREATESTRUCT lpCreateStruct) 
{
	if (CDialog::OnCreate(lpCreateStruct) == -1)
		return -1;
	
	return 0;
}
