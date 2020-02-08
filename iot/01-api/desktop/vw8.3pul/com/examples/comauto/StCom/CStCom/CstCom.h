// CstCom.h : main header file for the CSTCOM application
//

#if !defined(AFX_CSTCOM_H__4AD416B4_A4E9_11D0_A760_00A024CD45B2__INCLUDED_)
#define AFX_CSTCOM_H__4AD416B4_A4E9_11D0_A760_00A024CD45B2__INCLUDED_

#if _MSC_VER >= 1000
#pragma once
#endif // _MSC_VER >= 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols
#include "cw_vwstcom.h"	// Added by ClassView
#include "midl_vwstcom.h"	// Added by GG
#include "CstComDlg.h"

/////////////////////////////////////////////////////////////////////////////
// CCstComApp:
// See CstCom.cpp for the implementation of this class
//

class CCstComApp : public CWinApp
{
public:
	ISmalltalkCommanderDisp* m_StComDualInterface;
	ISmalltalkCommanderDispatchDriver m_StComDispatchDriver;
	BOOL m_UseVTable;

	CCstComApp();
	BOOL StartSmalltalkCommander();
	void FileSaveUserText(CString& cstring, LPCTSTR lpstrTitle);

// inline fellow
	CCstComDlg* StComDialog() 
	{ 
		return (CCstComDlg*)m_pMainWnd; 
	}

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CCstComApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CCstComApp)
	afx_msg void OnHelpAbout();
	afx_msg void Evaluate();
	afx_msg void OnSmalltalkOptions();
	afx_msg void OnFileExit();
	afx_msg void OnFileOpenWorkspace();
	afx_msg void OnFileSaveWorkspace();
	afx_msg void OnFileSaveAnswer();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Developer Studio will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_CSTCOM_H__4AD416B4_A4E9_11D0_A760_00A024CD45B2__INCLUDED_)
