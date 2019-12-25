VERSION 4.00
Begin VB.Form FindClassForm 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Find Class"
   ClientHeight    =   1395
   ClientLeft      =   2700
   ClientTop       =   3480
   ClientWidth     =   3885
   Height          =   1800
   Left            =   2640
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1395
   ScaleWidth      =   3885
   ShowInTaskbar   =   0   'False
   Top             =   3135
   Width           =   4005
   Begin VB.CommandButton Command2 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   375
      Left            =   1320
      TabIndex        =   2
      Top             =   960
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   960
      Width           =   1095
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Text            =   "AutomationSmalltalkCommander"
      Top             =   480
      Width           =   3615
   End
   Begin VB.Label Label1 
      Caption         =   "Enter a class name or name pattern:"
      Height          =   375
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   3615
   End
End
Attribute VB_Name = "FindClassForm"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Private Sub Command1_Click()
Hide
End Sub



Private Sub Command2_Click()
Hide
Text1.Text = Empty
End Sub


