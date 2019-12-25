VERSION 4.00
Begin VB.Form AboutDialog 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "About this Application"
   ClientHeight    =   3195
   ClientLeft      =   3450
   ClientTop       =   3120
   ClientWidth     =   6765
   Height          =   3600
   Left            =   3390
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3195
   ScaleWidth      =   6765
   Top             =   2775
   Width           =   6885
   Begin VB.PictureBox Picture1 
      BorderStyle     =   0  'None
      Height          =   495
      Left            =   6000
      Picture         =   "About.frx":0000
      ScaleHeight     =   495
      ScaleWidth      =   615
      TabIndex        =   5
      Top             =   1200
      Width           =   615
   End
   Begin VB.PictureBox Picture2 
      BorderStyle     =   0  'None
      Height          =   495
      Left            =   6000
      Picture         =   "About.frx":0442
      ScaleHeight     =   495
      ScaleWidth      =   615
      TabIndex        =   4
      Top             =   480
      Width           =   615
   End
   Begin VB.CommandButton OKButton 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   495
      Left            =   360
      TabIndex        =   0
      Top             =   2160
      Width           =   1215
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      Caption         =   "Created by Gary Gregory"
      Height          =   255
      Left            =   2040
      TabIndex        =   3
      Top             =   1320
      Width           =   3735
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Copyright (C) 1997 ParcPlace-Digitalk"
      Height          =   375
      Left            =   2040
      TabIndex        =   2
      Top             =   840
      Width           =   3735
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      Caption         =   "Visual Basic to VisualWorks OLE Server Demonstartion"
      Height          =   495
      Left            =   2040
      TabIndex        =   1
      Top             =   240
      Width           =   3735
   End
   Begin VB.Image Image1 
      BorderStyle     =   1  'Fixed Single
      Height          =   1110
      Left            =   2040
      Picture         =   "About.frx":0884
      Top             =   1920
      Width           =   3810
   End
   Begin VB.Image Image2 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Left            =   120
      Picture         =   "About.frx":51AE
      Top             =   120
      Width           =   1620
   End
End
Attribute VB_Name = "AboutDialog"
Attribute VB_Creatable = False
Attribute VB_Exposed = False
Private Sub OKButton_Click()
Hide
End Sub


