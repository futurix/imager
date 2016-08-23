object frmICOExport: TfrmICOExport
  Left = 192
  Top = 107
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Export as Windows Icon'
  ClientHeight = 81
  ClientWidth = 245
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
  object gbxColors: TGroupBox
    Left = 5
    Top = 3
    Width = 154
    Height = 71
    Caption = ' Number of colors '
    TabOrder = 0
    object imgPreview: TImage
      Left = 105
      Top = 23
      Width = 32
      Height = 32
    end
    object rbn16: TRadioButton
      Left = 10
      Top = 20
      Width = 88
      Height = 17
      Caption = '16 colors'
      TabOrder = 0
    end
    object rbn256: TRadioButton
      Left = 10
      Top = 41
      Width = 86
      Height = 17
      Caption = '256 colors'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object btnCancel: TButton
    Left = 165
    Top = 36
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object btnOK: TButton
    Left = 165
    Top = 8
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOKClick
  end
  object dlgICOSave: TSaveDialog
    DefaultExt = 'ico'
    FileName = 'Untitled.ico'
    Filter = 'Windows Icons (*.ico)|*.ico'
    Title = 'Save icon ...'
    Left = 134
    Top = 3
  end
  object icnExport: TjvIcon
    Left = 104
    Top = 3
  end
end
