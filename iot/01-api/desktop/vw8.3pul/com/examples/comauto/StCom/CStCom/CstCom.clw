; CLW file contains information for the MFC ClassWizard

[General Info]
Version=1
LastClass=CCstComDlg
LastTemplate=CDialog
NewFileInclude1=#include "stdafx.h"
NewFileInclude2=#include "CstCom.h"

ClassCount=4
Class1=CCstComApp
Class2=CCstComDlg
Class3=CAboutDlg

ResourceCount=6
Resource1=IDR_FILE_MENU
Resource2=IDR_MAINFRAME
Resource3=IDR_ACCELERATOR
Resource4=IDD_CSTCOM_DIALOG
Class4=COptionsDlg
Resource5=IDD_OPTIONS
Resource6=IDD_ABOUTBOX

[CLS:CCstComApp]
Type=0
HeaderFile=CstCom.h
ImplementationFile=CstCom.cpp
Filter=N
BaseClass=CWinApp
VirtualFilter=AC
LastObject=CCstComApp

[CLS:CCstComDlg]
Type=0
HeaderFile=CstComDlg.h
ImplementationFile=CstComDlg.cpp
Filter=D
LastObject=CCstComDlg
BaseClass=CDialog
VirtualFilter=dWC

[CLS:CAboutDlg]
Type=0
HeaderFile=cstcom.h
ImplementationFile=cstcom.cpp
BaseClass=CDialog
LastObject=CAboutDlg
Filter=D
VirtualFilter=dWC

[DLG:IDD_ABOUTBOX]
Type=1
Class=CAboutDlg
ControlCount=5
Control1=IDC_STATIC,static,1342308481
Control2=IDC_STATIC,static,1342308353
Control3=IDOK,button,1342373889
Control4=IDC_STATIC,static,1342177294
Control5=IDC_STATIC,static,1342308353

[DLG:IDD_CSTCOM_DIALOG]
Type=1
Class=CCstComDlg
ControlCount=3
Control1=IDC_STATIC,static,1342308352
Control2=IDC_EDIT_EXPRESSION,edit,1352732868
Control3=IDC_EDIT_ANSWER,edit,1353781380

[MNU:IDR_FILE_MENU]
Type=1
Class=?
Command1=ID_FILE_OPENWORKSPACE
Command2=ID_FILE_SAVEWORKSPACE
Command3=ID_FILE_SAVEANSWER
Command4=ID_FILE_EXIT
Command5=ID_SMALLTALK_EVALUATE
Command6=ID_SMALLTALK_OPTIONS
Command7=ID_HELP_CONTENTS
Command8=ID_HELP_ABOUT
CommandCount=8

[DLG:IDD_OPTIONS]
Type=1
Class=COptionsDlg
ControlCount=7
Control1=IDOK,button,1342242817
Control2=IDCANCEL,button,1342242816
Control3=IDC_STATIC,button,1342177287
Control4=IDC_RADIO_DUAL_INTERFACE,button,1342373897
Control5=IDC_RADIO_IDISPATCH,button,1342177289
Control6=IDC_STATIC,static,1342177283
Control7=IDC_STATIC,static,1342177283

[CLS:COptionsDlg]
Type=0
HeaderFile=OptionsDlg.h
ImplementationFile=OptionsDlg.cpp
BaseClass=CDialog
Filter=D
LastObject=COptionsDlg
VirtualFilter=dWC

[ACL:IDR_ACCELERATOR]
Type=1
Class=?
Command1=ID_FILE_SAVEANSWER
Command2=ID_SMALLTALK_EVALUATE
Command3=ID_FILE_OPENWORKSPACE
Command4=ID_FILE_SAVEWORKSPACE
Command5=ID_SMALLTALK_OPTIONS
Command6=ID_HELP_CONTENTS
CommandCount=6

