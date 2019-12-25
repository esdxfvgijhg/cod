VERSION 4.00
Begin VB.Form OptionsDialog 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Options"
   ClientHeight    =   2835
   ClientLeft      =   4110
   ClientTop       =   3525
   ClientWidth     =   6180
   Height          =   3240
   Left            =   4050
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2835
   ScaleWidth      =   6180
   ShowInTaskbar   =   0   'False
   Top             =   3180
   Width           =   6300
   Begin VB.OptionButton IDispatchOption 
      Caption         =   "Use the standard Visual Basic Automation IDispatch interface through the Object data type."
      Height          =   495
      Left            =   1200
      TabIndex        =   6
      Top             =   1440
      Width           =   4695
   End
   Begin VB.OptionButton DualOption 
      Caption         =   "Use the VTable dual interface ISmalltalkCommanderDisp interface through the ISmalltalkCommanderDisp data type."
      Height          =   495
      Left            =   1200
      TabIndex        =   5
      Top             =   600
      Value           =   -1  'True
      Width           =   4695
   End
   Begin VB.CommandButton CancelButton 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   375
      Index           =   1
      Left            =   4800
      TabIndex        =   4
      Top             =   2400
      Width           =   1215
   End
   Begin VB.CommandButton OKButton 
      Caption         =   "OK"
      Height          =   375
      Index           =   0
      Left            =   3480
      TabIndex        =   3
      Top             =   2400
      Width           =   1215
   End
   Begin VB.PictureBox Picture1 
      BorderStyle     =   0  'None
      Height          =   495
      Index           =   1
      Left            =   480
      Picture         =   "OptionsDialog.frx":0000
      ScaleHeight     =   495
      ScaleWidth      =   495
      TabIndex        =   2
      Top             =   1440
      Width           =   495
   End
   Begin VB.PictureBox Picture1 
      BorderStyle     =   0  'None
      Height          =   495
      Index           =   0
      Left            =   480
      Picture         =   "OptionsDialog.frx":0442
      ScaleHeight     =   495
      ScaleWidth      =   495
      TabIndex        =   1
      Top             =   600
      Width           =   495
   End
   Begin VB.Frame Frame1 
      Caption         =   "Interface calling options"
      Height          =   2175
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5895
   End
End
Attribute VB_Name = "OptionsDialog"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Dim UseVTableDispatch As Boolean
Private Sub CancelButton_Click(Index As Integer)
Hide
End Sub

Private Sub Form_Activate()
If VTableDispatch Then
    DualOption.Value = True
Else
    IDispatchOption.Value = True
End If
End Sub

Private Sub OKButton_Click(Index As Integer)
VTableDispatch = DualOption.Value
Hide
End Sub

Public Property Get VTableDispatch()
VTableDispatch = UseVTableDispatch
End Property

Public Property Let VTableDispatch(vNewValue)
UseVTableDispatch = vNewValue
End Property
