VERSION 4.00
Begin VB.Form MainForm 
   Caption         =   "Visual Basic to VisualWorks OLE Server Demonstartion"
   ClientHeight    =   4800
   ClientLeft      =   2325
   ClientTop       =   2145
   ClientWidth     =   6570
   ForeColor       =   &H00004000&
   Height          =   5490
   Left            =   2265
   LinkTopic       =   "MainForm"
   ScaleHeight     =   4800
   ScaleWidth      =   6570
   Top             =   1515
   Width           =   6690
   Begin ComctlLib.Toolbar Toolbar 
      Align           =   1  'Align Top
      Height          =   630
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   6570
      _ExtentX        =   11589
      _ExtentY        =   1111
      ButtonWidth     =   1852
      ButtonHeight    =   953
      Appearance      =   1
      _Version        =   327680
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   7
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Open"
            Key             =   "OpenWorkspace"
            Description     =   "Open Workspace"
            ToolTipText     =   "Open Workspace"
            Object.Tag             =   ""
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Save"
            Key             =   "SaveWorkspace"
            Description     =   "Save Workspace"
            ToolTipText     =   "Save Workspace"
            Object.Tag             =   ""
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
            MixedState      =   -1  'True
         EndProperty
         BeginProperty Button4 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Evaluate"
            Key             =   "Evaluate"
            Description     =   "Evaluate the Smalltalk expression"
            ToolTipText     =   "Evaluate the Smalltalk expression"
            Object.Tag             =   ""
         EndProperty
         BeginProperty Button5 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Save Answer"
            Key             =   "SaveAnswer"
            Description     =   "Save Answer"
            ToolTipText     =   "Save Answer"
            Object.Tag             =   ""
         EndProperty
         BeginProperty Button6 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Options"
            Key             =   "Options"
            Description     =   "Options"
            ToolTipText     =   "Set Options"
            Object.Tag             =   ""
         EndProperty
         BeginProperty Button7 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Enabled         =   0   'False
            Caption         =   "Error Stack"
            Key             =   "Error Stack"
            Description     =   "Show the error stack"
            ToolTipText     =   "Show the error stack"
            Object.Tag             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.TextBox Answer 
      ForeColor       =   &H00FF0000&
      Height          =   1695
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   3
      Top             =   2760
      Width           =   6375
   End
   Begin VB.TextBox EvalExpr 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   1695
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Text            =   "VbStCom.frx":0000
      Top             =   960
      Width           =   6375
   End
   Begin ComctlLib.ImageList ImageList 
      Left            =   5520
      Top             =   2280
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   13
      ImageHeight     =   13
      MaskColor       =   16777215
      _Version        =   327680
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   6
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbStCom.frx":000E
            Key             =   "SaveWorkspace"
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbStCom.frx":0120
            Key             =   "OpenWorkspace"
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbStCom.frx":021A
            Key             =   "Evaluate"
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbStCom.frx":032C
            Key             =   "SaveAnswer"
         EndProperty
         BeginProperty ListImage5 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbStCom.frx":043E
            Key             =   "Options"
         EndProperty
         BeginProperty ListImage6 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbStCom.frx":0550
            Key             =   "Help"
         EndProperty
      EndProperty
   End
   Begin MSComDlg.CommonDialog CommonDialog 
      Left            =   6120
      Top             =   2400
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   327680
   End
   Begin ComctlLib.StatusBar StatusBar 
      Align           =   2  'Align Bottom
      Height          =   255
      Left            =   0
      TabIndex        =   2
      Top             =   4545
      Width           =   6570
      _ExtentX        =   11589
      _ExtentY        =   450
      Style           =   1
      SimpleText      =   "Ready."
      _Version        =   327680
      BeginProperty Panels {0713E89E-850A-101B-AFC0-4210102A8DA7} 
         NumPanels       =   1
         BeginProperty Panel1 {0713E89F-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label WorkspaceLabel 
      Caption         =   "Smalltalk Workspace:"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   720
      Width           =   2175
   End
   Begin VB.Menu FileMenu 
      Caption         =   "&File"
      Begin VB.Menu FileMenuOpen 
         Caption         =   "&Open Workspace..."
         Shortcut        =   ^O
      End
      Begin VB.Menu FileMenuSave 
         Caption         =   "&Save Workspace..."
         Shortcut        =   ^S
      End
      Begin VB.Menu FileMenuSaveAnswer 
         Caption         =   "Sa&ve Answer..."
         Shortcut        =   ^W
      End
      Begin VB.Menu FileMenuSeparator 
         Caption         =   "-"
      End
      Begin VB.Menu FileMenuExit 
         Caption         =   "E&xit"
         Shortcut        =   +{F4}
      End
   End
   Begin VB.Menu SmalltalkMenu 
      Caption         =   "Smalltalk"
      Begin VB.Menu SmalltalkMenuEvaluate 
         Caption         =   "Evaluate"
         Shortcut        =   ^D
      End
      Begin VB.Menu SmalltalkMenuSeparator 
         Caption         =   "-"
      End
      Begin VB.Menu SmalltalkShowErrorStack 
         Caption         =   "Show Error Stack..."
         Shortcut        =   ^E
      End
      Begin VB.Menu SmalltalkMenuOptions 
         Caption         =   "Options..."
      End
   End
   Begin VB.Menu HelpMenu 
      Caption         =   "&Help"
      Index           =   2
      Begin VB.Menu HelpMenuContents 
         Caption         =   "&Contents"
         Shortcut        =   {F1}
      End
      Begin VB.Menu HelpMenuSeparator 
         Caption         =   "-"
      End
      Begin VB.Menu HelpMenuAbout 
         Caption         =   "&About this application..."
      End
   End
End
Attribute VB_Name = "MainForm"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Rem Access the Smalltalk Commander through the generic IDispatch interface.
Rem This method is the generic Visual Basic access method.
Dim StCommander As Object

Rem Access the Smalltalk Commander through a dual interface
Rem This method allows Visual Basic to call the object through
Rem it's VTABLE, which is much more efficient.
Dim StVTableCommander As ISmalltalkCommanderDisp

Dim UseVTableDispatch As Boolean

Private Sub Picture1_Click()

End Sub

Private Sub DoWork_Click()
If VTableDispatch Then
    Let Answer.Text = StVTableCommander.EvaluateAsString(EvalExpr.Text)
Else
    Let Answer.Text = StCommander.EvaluateAsString(EvalExpr.Text)
End If
End Sub






Private Sub ExitCommand_Click()
ExitApplication
End Sub

Private Sub FileMenuExit_Click()
ExitApplication
End Sub

Private Sub FileMenuOpen_Click()
OpenWorkspace
End Sub

Private Sub FileMenuSave_Click()
SaveWorkspace
End Sub

Private Sub FileMenuSaveAnswer_Click()
SaveAnswer
End Sub


Private Sub Form_Load()
Call StartStServer
VTableDispatch = True
Toolbar.ImageList = ImageList
Toolbar.Buttons("OpenWorkspace").Image = ImageList.ListImages("OpenWorkspace").Index
Toolbar.Buttons("SaveWorkspace").Image = ImageList.ListImages("SaveWorkspace").Index
Toolbar.Buttons("Evaluate").Image = ImageList.ListImages("Evaluate").Index
Toolbar.Buttons("SaveAnswer").Image = ImageList.ListImages("SaveAnswer").Index
Toolbar.Buttons("Options").Image = ImageList.ListImages("Options").Index
Toolbar.Buttons("Error Stack").Image = ImageList.ListImages("Help").Index
End Sub

Private Sub StartStServer()

Let StatusBar.SimpleText = "Starting Smalltalk..."

Rem Get a reference to the server through a standard Automation IDispatch
Set StCommander = CreateObject("VisualWorks.SmalltalkCommander")

Rem Get a reference to the server through an Automation dual interface
Set StVTableCommander = CreateObject("VisualWorks.SmalltalkCommander")

Let StatusBar.SimpleText = "Ready."

End Sub











Private Sub Form_Resize()
Dim minBoxHeight As Integer
Dim horizBorderSize, vertBorderSize, newWidth, formTop, formMiddle As Double
Dim formBottom, boxHeight, boxTop, Consumed As Double

Rem constant values
horizBorderSize = 315
vertBorderSize = 40
minBoxHeight = 300

Rem resize the width of controls
newWidth = MainForm.Width - horizBorderSize
Answer.Width = newWidth
EvalExpr.Width = newWidth

Rem resize the height of the Smalltalk workspace label
formTop = Toolbar.Height + vertBorderSize
minFormHeight = formTop + 2500
WorkspaceLabel.Top = formTop
Consumed = WorkspaceLabel.Top + WorkspaceLabel.Height + (vertBorderSize / 2#)

Rem resize the height of the Smalltalk workspace
EvalExpr.Top = Consumed
formBottom = StatusBar.Top - vertBorderSize
formMiddle = (formBottom - EvalExpr.Top) / 2#
boxHeight = (formMiddle / 2#) - (vertBorderSize / 2#)
If boxHeight < minBoxHeight Then
    boxHeight = minBoxHeight
End If
EvalExpr.Height = boxHeight
Consumed = EvalExpr.Top + boxHeight + vertBorderSize

Rem resize the height of the Answer box
Answer.Top = Consumed
boxHeight = formBottom - Answer.Top
If boxHeight < minBoxHeight Then
    boxHeight = minBoxHeight
End If
Answer.Height = boxHeight
End Sub

Private Sub Form_Unload(Cancel As Integer)
Unload OptionsDialog
Unload AboutDialog
End Sub

Private Sub OpenButton_Click()
CommonDialog.ShowOpen
End Sub

Private Sub HelpMenuAbout_Click()
AboutDialog.Show 1
End Sub

Private Sub HelpMenuContents_Click()
HelpContents
End Sub

Private Sub OptionsButton_Click()
OptionsDialog.VTableDispatch = VTableDispatch
OptionsDialog.Show 1
VTableDispatch = OptionsDialog.VTableDispatch
End Sub



Public Property Get VTableDispatch() As Boolean
VTableDispatch = UseVTableDispatch
End Property

Public Property Let VTableDispatch(vNewValue As Boolean)
UseVTableDispatch = vNewValue
End Property

Public Sub ExitApplication()
Unload MainForm
End Sub

Public Sub FileSaveTextAs(Name As String, someText As String)
Dim FileNum As Integer

If IsEmpty(Name) Or Name = "" Then
    Exit Sub
End If
FileNum = 10
Open Name For Output As FileNum
Print #FileNum, someText
Close FileNum
End Sub


Public Sub SaveWorkspace()
CommonDialog.DialogTitle = "Save Smalltalk Workspace"
CommonDialog.Filter = "Workspace(*.st;*.ws)|*.st;*.ws|Text (*.txt)|*.txt|All Files(*.*)|*.*"
CommonDialog.ShowSave
FileSaveTextAs CommonDialog.FileTitle, EvalExpr.Text
End Sub



Public Function FileOpenFrom(Name As String) As String
Dim FileNum As Integer
Dim LinesFromFile As String

If IsEmpty(Name) Or Name = "" Then
    Exit Function
End If
    
FileNum = 10
Open Name For Input As FileNum
LinesFromFile = Input(LOF(FileNum), FileNum)
Close FileNum
FileOpenFrom = LinesFromFile
End Function

Public Sub OpenWorkspace()
CommonDialog.DialogTitle = "Open Smalltalk Workspace"
CommonDialog.Filter = "Workspace(*.st;*.ws)|*.st;*.ws|Text (*.txt)|*.txt|All Files(*.*)|*.*"
CommonDialog.ShowOpen
EvalExpr.Text = FileOpenFrom(CommonDialog.FileTitle)
End Sub

Public Sub SaveAnswer()
CommonDialog.DialogTitle = "Save Smalltalk Answer"
CommonDialog.Filter = "Workspace(*.st;*.ws)|*.st;*.ws|Text (*.txt)|*.txt|All Files(*.*)|*.*"
CommonDialog.ShowSave
FileSaveTextAs CommonDialog.FileTitle, Answer.Text
End Sub

Public Sub HelpContents()
CommonDialog.HelpFile = "..\Help\VBStCom.hlp"
CommonDialog.HelpCommand = cdlHelpContents
CommonDialog.ShowHelp
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As Button)

End Sub


Private Sub SmalltalkMenuEvaluate_Click()
EvaluateExpression
End Sub

Private Sub SmalltalkMenuOptions_Click()
SetOptions
End Sub


Private Sub SmalltalkShowErrorStack_Click()
ShowErrorStack
End Sub

Private Sub Toolbar_ButtonClick(ByVal Button As Button)
Select Case Button.Key
    Case "OpenWorkspace"
        OpenWorkspace
    Case "SaveWorkspace"
        SaveWorkspace
    Case "Evaluate"
        EvaluateExpression
    Case "SaveAnswer"
        SaveAnswer
    Case "Options"
        SetOptions
    Case "Help"
        HelpContents
    Case "Error Stack"
        ShowErrorStack
    End Select
End Sub



Public Sub EvaluateExpression()
Dim WasError As Boolean
If VTableDispatch Then
    Let Answer.Text = StVTableCommander.EvaluateAsString(EvalExpr.Text)
    WasError = StVTableCommander.GetLastError <> ""
Else
    Let Answer.Text = StCommander.EvaluateAsString(EvalExpr.Text)
End If
    Toolbar.Buttons(7).Enabled = WasError
End Sub

Public Sub SetOptions()
OptionsDialog.VTableDispatch = VTableDispatch
OptionsDialog.Show 1
VTableDispatch = OptionsDialog.VTableDispatch
End Sub

Public Sub ShowErrorStack()
If VTableDispatch Then
    Let ErrorStackForm.ErrorStackText = StVTableCommander.GetLastErrorStack()
Else
    Let ErrorStackForm.ErrorStackText = StCommander.GetLastErrorStack()
End If

ErrorStackForm.Show 1
End Sub


