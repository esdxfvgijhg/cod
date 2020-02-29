// CstComDlg.h : header file
//

#if !defined(AFX_CSTCOMDLG_H__4AD416B6_A4E9_11D0_A760_00A024CD45B2__INCLUDED_)
#define AFX_CSTCOMDLG_H__4AD416B6_A4E9_11D0_A760_00A024CD45B2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

/////////////////////////////////////////////////////////////////////////////
// CCstComDlg dialog

class CCstComDlg : public CDialog
{
// Construction
public:
	CCstComDlg(CWnd* pParent = NULL);	// standard constructor
	void CCstComDlg::GetExpression(CString& cstring);
	void CCstComDlg::GetAnswer(CString& cstring);
	void CCstComDlg::SetExpression(CString& cstring);
	void CCstComDlg::SetAnswer(CString& cstring);
	void CCstComDlg::SetStatusBarText(LPCSTR cstring);
	void CCstComDlg::SetEvalOptionText(LPCSTR cstring);

// Dialog Data
	//{{AFX_DATA(CCstComDlg)
	enum { IDD = IDD_CSTCOM_DIALOG };
	CString	m_Expression;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCstComDlg)
	public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	virtual BOOL OnCommand(WPARAM wParam, LPARAM lParam);
	//}}AFX_VIRTUAL

	CEdit* GetControlExpression()
	{
		return (CEdit*)GetDlgItem(IDC_EDIT_EXPRESSION);
	}
	CEdit* GetControlAnswer()
	{
		return (CEdit*)GetDlgItem(IDC_EDIT_ANSWER);
	}
	/*
	CStatusBar* GetControlStatusBar()
	{
		return (CStatusBar*)GetDlgItem(IDC_SBARCTRL);
	}
	*/

// Implementation
protected:
	CStatusBar m_statusBar;
	HICON m_hIcon;
	HACCEL m_hAccel;

	// Generated message map functions
	//{{AFX_MSG(CCstComDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg int OnCreate(LPCREATESTRUCT lpCreateStruct);
	DECLARE_EVENTSINK_MAP()
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CSTCOMDLG_H__4AD416B6_A4E9_11D0_A760_00A024CD45B2__INCLUDED_)
