object frmSetPos: TfrmSetPos
  Left = 190
  Top = 105
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Set Position'
  ClientHeight = 114
  ClientWidth = 230
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 147
    Top = 80
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnReset: TButton
    Left = 7
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 1
    OnClick = btnResetClick
  end
  object pnlPosition: TPanel
    Left = 7
    Top = 7
    Width = 215
    Height = 69
    TabOrder = 2
    object lblLeft: TLabel
      Left = 11
      Top = 37
      Width = 21
      Height = 13
      Caption = 'Left:'
    end
    object lblTop: TLabel
      Left = 10
      Top = 14
      Width = 22
      Height = 13
      Caption = 'Top:'
    end
    object edtTop: TEdit
      Left = 39
      Top = 10
      Width = 149
      Height = 21
      TabOrder = 0
      Text = '0'
    end
    object edtLeft: TEdit
      Left = 39
      Top = 34
      Width = 149
      Height = 21
      TabOrder = 1
      Text = '0'
    end
    object updTop: TUpDown
      Left = 188
      Top = 10
      Width = 15
      Height = 21
      Associate = edtTop
      Max = 10000
      Increment = 10
      TabOrder = 2
    end
    object updLeft: TUpDown
      Left = 188
      Top = 34
      Width = 15
      Height = 21
      Associate = edtLeft
      Max = 10000
      Increment = 10
      TabOrder = 3
    end
  end
end
