object frmBlur: TfrmBlur
  Left = 190
  Top = 105
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Blur'
  ClientHeight = 92
  ClientWidth = 301
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 141
    Top = 62
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 220
    Top = 62
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object gbxBlur: TGroupBox
    Left = 3
    Top = 3
    Width = 292
    Height = 55
    Caption = ' Amount of blur '
    TabOrder = 2
    object lblValue: TLabel
      Left = 266
      Top = 22
      Width = 6
      Height = 13
      Caption = '1'
      Transparent = True
    end
    object trbAmount: TTrackBar
      Left = 9
      Top = 19
      Width = 255
      Height = 28
      Max = 100
      Min = 10
      Frequency = 10
      Position = 10
      TabOrder = 0
      ThumbLength = 15
      OnChange = trbAmountChange
    end
  end
end
