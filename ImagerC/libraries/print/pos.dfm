object frmSetPos: TfrmSetPos
  Left = 192
  Top = 107
  ActiveControl = btnReset
  BorderStyle = bsDialog
  Caption = 'Set Position'
  ClientHeight = 95
  ClientWidth = 215
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
  object lblTop: TLabel
    Left = 10
    Top = 14
    Width = 22
    Height = 13
    Caption = 'Top:'
  end
  object lblLeft: TLabel
    Left = 11
    Top = 37
    Width = 21
    Height = 13
    Caption = 'Left:'
  end
  object edtTop: TEdit
    Left = 38
    Top = 10
    Width = 149
    Height = 21
    TabOrder = 0
    Text = '0'
  end
  object edtLeft: TEdit
    Left = 38
    Top = 34
    Width = 149
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object btnOK: TButton
    Left = 129
    Top = 62
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnReset: TButton
    Left = 11
    Top = 62
    Width = 75
    Height = 25
    Caption = 'Reset'
    Default = True
    TabOrder = 3
    OnClick = btnResetClick
  end
  object updTop: TUpDown
    Left = 187
    Top = 10
    Width = 15
    Height = 21
    Associate = edtTop
    Min = 0
    Max = 10000
    Increment = 10
    Position = 0
    TabOrder = 4
    Wrap = False
  end
  object updLeft: TUpDown
    Left = 187
    Top = 34
    Width = 15
    Height = 21
    Associate = edtLeft
    Min = 0
    Max = 10000
    Increment = 10
    Position = 0
    TabOrder = 5
    Wrap = False
  end
end
