VERSION 4.00
Begin VB.Form CHBForm 
   Caption         =   "Class Hierarchy Browser"
   ClientHeight    =   8145
   ClientLeft      =   1425
   ClientTop       =   1590
   ClientWidth     =   10155
   ForeColor       =   &H00000000&
   Height          =   8550
   Left            =   1365
   LinkTopic       =   "Form1"
   ScaleHeight     =   8145
   ScaleWidth      =   10155
   Top             =   1245
   Width           =   10275
   Begin ComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   600
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   10155
      _ExtentX        =   17912
      _ExtentY        =   1058
      ButtonWidth     =   1138
      ButtonHeight    =   953
      ImageList       =   "ToolsImageList"
      _Version        =   327680
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   6
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "File Out"
            Key             =   "FILEOUT"
            Description     =   "File Out"
            ToolTipText     =   "File Out"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "File In"
            Key             =   "FILEIN"
            Description     =   "File In"
            ToolTipText     =   "File In"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.Tag             =   ""
            Style           =   3
         EndProperty
         BeginProperty Button4 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Print"
            Key             =   "PRINT"
            Description     =   "Print"
            ToolTipText     =   "Print"
            Object.Tag             =   ""
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Find"
            Key             =   "FIND"
            Description     =   "Find"
            ToolTipText     =   "Find"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
         BeginProperty Button6 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "Browse"
            Key             =   "BROWSE"
            Description     =   "Browse"
            ToolTipText     =   "Browse Classes"
            Object.Tag             =   ""
            ImageIndex      =   5
         EndProperty
      EndProperty
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   1800
      Top             =   600
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   327680
      DialogTitle     =   "File-out"
      Filter          =   "*.cls; *.mth"
   End
   Begin ComctlLib.ImageList ToolsImageList 
      Left            =   9480
      Top             =   720
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   8421504
      _Version        =   327680
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   5
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbChbVw.frx":0000
            Key             =   "SAVE"
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbChbVw.frx":0112
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbChbVw.frx":020C
            Key             =   "FIND"
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbChbVw.frx":031E
            Key             =   "PRINT"
         EndProperty
         BeginProperty ListImage5 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbChbVw.frx":0430
            Key             =   "BROWSE"
         EndProperty
      EndProperty
   End
   Begin ComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   255
      Left            =   0
      TabIndex        =   6
      Top             =   7890
      Width           =   10155
      _ExtentX        =   17912
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
   Begin RichTextLib.RichTextBox MethodSource 
      Height          =   3015
      Left            =   120
      TabIndex        =   5
      Top             =   4800
      Width           =   9975
      _ExtentX        =   17595
      _ExtentY        =   5318
      _Version        =   327680
      Enabled         =   -1  'True
      ScrollBars      =   3
      TextRTF         =   $"VbChbVw.frx":0542
      MouseIcon       =   "VbChbVw.frx":060B
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin ComctlLib.ImageList MethodImageList 
      Left            =   9480
      Top             =   4320
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      _Version        =   327680
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   7
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbChbVw.frx":0627
            Key             =   "CM"
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbChbVw.frx":0979
            Key             =   "IM"
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbChbVw.frx":0CCB
            Key             =   "SAD"
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbChbVw.frx":101D
            Key             =   "IVAR"
         EndProperty
         BeginProperty ListImage5 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbChbVw.frx":136F
            Key             =   "CVAR"
         EndProperty
         BeginProperty ListImage6 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbChbVw.frx":16C1
            Key             =   "CIVAR"
         EndProperty
         BeginProperty ListImage7 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbChbVw.frx":17D3
            Key             =   "POOL"
         EndProperty
      EndProperty
   End
   Begin ComctlLib.ImageList ClassImageList 
      Left            =   4920
      Top             =   4320
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      _Version        =   327680
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   1
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "VbChbVw.frx":18E5
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label Label2 
      Caption         =   "Method source:"
      Height          =   255
      Index           =   1
      Left            =   120
      TabIndex        =   4
      Top             =   4560
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "Methods:"
      Height          =   255
      Index           =   0
      Left            =   5640
      TabIndex        =   3
      Top             =   720
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Class Hierarchy:"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   720
      Width           =   1575
   End
   Begin ComctlLib.TreeView MethodTreeView 
      Height          =   3375
      Left            =   5640
      TabIndex        =   1
      Top             =   960
      Width           =   4455
      _ExtentX        =   7858
      _ExtentY        =   5953
      _Version        =   327680
      LineStyle       =   1
      Style           =   7
      Appearance      =   1
   End
   Begin ComctlLib.TreeView ClassTreeView 
      Height          =   3375
      Left            =   120
      TabIndex        =   0
      Top             =   960
      Width           =   5415
      _ExtentX        =   9551
      _ExtentY        =   5953
      _Version        =   327680
      LabelEdit       =   1
      LineStyle       =   1
      Sorted          =   -1  'True
      Style           =   7
      Appearance      =   1
   End
End
Attribute VB_Name = "CHBForm"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Dim StCommander As Object
Dim rootClassName As String
Dim currentClassName As String

    

Private Sub ClassTreeView_NodeClick(ByVal Node As Node)
Dim nodX As Node

If currentClassName <> Node.Text Then
    currentClassName = Node.Text
    Call ResetMethodView
End If

If Node.Children > 0 Then
        Exit Sub
End If

For Each Value In StCommander.Evaluate("(" & Node.Key & _
    " subclasses collect: [:e| e printString] ) asSortedCollection")
    Set nodX = ClassTreeView.Nodes.Add(Node.Key, tvwChild, Value, Value, 1)
Next

CHBForm.Caption = "Class Hierarcy Browser - " & Node.Key
Rem Only update if we have added kids.
If Node.Children > 0 Then
    Node.Child.EnsureVisible
End If

End Sub



Public Sub ResetMethodView()

Dim nodX As Node

MethodTreeView.Nodes.Clear
Set nodX = MethodTreeView.Nodes.Add(, , "CM", "Class methods", 1)
Set nodX = MethodTreeView.Nodes.Add(, , "CIVAR", "Class instance variables", "CIVAR")
Set nodX = MethodTreeView.Nodes.Add(, , "CVAR", "Class variables", "CVAR")
Set nodX = MethodTreeView.Nodes.Add(, , "IM", "Instance methods", 2)
Set nodX = MethodTreeView.Nodes.Add(, , "IVAR", "Instance variables", "IVAR")
Set nodX = MethodTreeView.Nodes.Add(, , "POOL", "Pools", "POOL")
nodX.EnsureVisible
MethodSource.Text = ""
         
End Sub



Private Sub Form_Load()
Dim nodX As Node
Dim btnX As Button
    
Set StCommander = CreateObject("VisualWorks.SmalltalkCommander")
rootClassName = "Object"
Set ClassTreeView.ImageList = ClassImageList
Set MethodTreeView.ImageList = MethodImageList
Set nodX = ClassTreeView.Nodes.Add(, , rootClassName, rootClassName, 1)
nodX.EnsureVisible
currentClassName = nodX.Text
Call ResetMethodView

End Sub


Private Sub Form_Unload(Cancel As Integer)
End
End Sub


Private Sub MethodTreeView_NodeClick(ByVal Node As Node)
Dim nodX As Node

If Node.Children > 0 Then
        Exit Sub
End If

Select Case Node.Key
Case "CM"
    For Each Value In StCommander.Evaluate(ClassTreeView.SelectedItem & _
            " class selectors asSortedCollection collect: [:e| e asString]")
        Set nodX = MethodTreeView.Nodes.Add(Node.Key, tvwChild, , Value, "CM")
    Next
Case "CIVAR"
    For Each Value In StCommander.Evaluate(ClassTreeView.SelectedItem & _
            " class classVarNames asSortedCollection")
        Set nodX = MethodTreeView.Nodes.Add(Node.Key, tvwChild, , Value, "CIVAR")
    Next
Case "CVAR"
    For Each Value In StCommander.Evaluate(ClassTreeView.SelectedItem & _
            " classVarNames asSortedCollection")
        Set nodX = MethodTreeView.Nodes.Add(Node.Key, tvwChild, , Value, "CVAR")
    Next
Case "IM"
    For Each Value In StCommander.Evaluate(ClassTreeView.SelectedItem & _
            " selectors asSortedCollection collect: [:e| e asString]")
        Set nodX = MethodTreeView.Nodes.Add(Node.Key, tvwChild, , Value, "IM")
    Next
Case "IVAR"
    For Each Value In StCommander.Evaluate(ClassTreeView.SelectedItem & _
            " instVarNames asSortedCollection")
        Set nodX = MethodTreeView.Nodes.Add(Node.Key, tvwChild, , Value, "IVAR")
    Next
Case "POOL"
    For Each Value In StCommander.Evaluate("(" & ClassTreeView.SelectedItem & _
            " sharedPools collect: [:x | (" & ClassTreeView.SelectedItem & _
            " environment keyAtValue: x) asString]) asSortedCollection")
        Set nodX = MethodTreeView.Nodes.Add(Node.Key, tvwChild, , Value, "POOL")
    Next
Case Else
    On Error GoTo ErrorNoCode
    If (Node.Parent.Key = "CM") Then
        MethodSource.Text = StCommander.Evaluate("|ar ws| ar := ((" & _
            ClassTreeView.SelectedItem & " class sourceMethodAt: #" & Node.Text & _
            ") asString asArrayOfSubstringsSeparatedBy: Character cr ). " & _
            "ws := WriteStream on: ''. ar do: " & _
            "[:e| ws nextPutAll: e; nextPut: Character cr; nextPut: Character lf]. ws contents")
        Exit Sub
    End If
    If (Node.Parent.Key = "IM") Then
        MethodSource.Text = StCommander.Evaluate("|ar ws| ar := ((" & _
            ClassTreeView.SelectedItem & " sourceMethodAt: #" & Node.Text & _
            ") asString asArrayOfSubstringsSeparatedBy: Character cr ). " & _
            "ws := WriteStream on: ''. ar do: " & _
            "[:e| ws nextPutAll: e; nextPut: Character cr; nextPut: Character lf]. ws contents")
        Exit Sub
    End If
End Select

If Node.Children = 0 Then
        On Error GoTo NoSourceItem
        Set nodX = MethodTreeView.Nodes.Add(Node.Key, tvwChild, , "<no definitions>", "SAD")
End If
Node.Child.EnsureVisible
Exit Sub

ErrorNoCode:
        MethodSource.Text = "<Could not get the source for this method>"
Exit Sub

NoSourceItem:
        MethodSource.Text = Node.Text & ": No extra description for this item."
Exit Sub
End Sub



Private Sub Toolbar1_ButtonClick(ByVal Button As Button)
Dim Name As String

If ClassTreeView.SelectedItem = Empty Then
    Exit Sub
End If
If Button.Key = "FILEOUT" Then
    CommonDialog1.filename = ClassTreeView.SelectedItem & ".cls"
    CommonDialog1.ShowSave
End If
If Button.Key = "PRINT" Then
    CommonDialog1.ShowPrinter
End If
If Button.Key = "FIND" Then
    FindClassForm.Show (1)
    Name = FindClassForm.Controls("text1")
    If Name <> Empty Then
        Call FindClass(Name)
    End If
End If
If Button.Key = "BROWSE" Then
    FindClassForm.Caption = "Browse Classes"
    FindClassForm.Show (1)
End If
End Sub



Public Sub FindClass(ByVal Name As String)
With ClassTreeView.Nodes(Name)
    .EnsureVisible
    .Selected = True
End With
End Sub
