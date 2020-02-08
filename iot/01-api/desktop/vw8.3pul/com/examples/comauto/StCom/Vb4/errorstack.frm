VERSION 4.00
Begin VB.Form ErrorStackForm 
   Caption         =   "Error Stack"
   ClientHeight    =   3750
   ClientLeft      =   3780
   ClientTop       =   4215
   ClientWidth     =   6735
   Height          =   4155
   Left            =   3720
   LinkTopic       =   "Form1"
   ScaleHeight     =   3750
   ScaleWidth      =   6735
   Top             =   3870
   Width           =   6855
   Begin VB.TextBox ErrorStackText 
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   3735
      Left            =   0
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      Top             =   0
      Width           =   6735
   End
End
Attribute VB_Name = "ErrorStackForm"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Private Sub EvalExpr_Change()

End Sub


Private Sub Form_Resize()
Dim horizBorderSize, vertBorderSize As Double

Rem constant values
horizBorderSize = 140
vertBorderSize = 400

Rem resize the width of controls
ErrorStackText.Width = ErrorStackForm.Width - horizBorderSize
ErrorStackText.Height = ErrorStackForm.Height - vertBorderSize

End Sub


