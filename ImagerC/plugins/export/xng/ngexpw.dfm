object frmXNG: TfrmXNG
  Left = 192
  Top = 107
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'PNG/JNG Export'
  ClientHeight = 235
  ClientWidth = 354
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
    Left = 274
    Top = 10
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 274
    Top = 38
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object gbxFormat: TGroupBox
    Left = 5
    Top = 5
    Width = 262
    Height = 61
    Caption = ' Format '
    TabOrder = 2
    object rbnPNG: TRadioButton
      Left = 10
      Top = 16
      Width = 244
      Height = 17
      Caption = 'PNG (Portable Network Graphics))'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbnJNG: TRadioButton
      Left = 10
      Top = 34
      Width = 238
      Height = 17
      Caption = 'JNG (JPEG Network Graphics)'
      TabOrder = 1
    end
  end
  object gbxAdv: TGroupBox
    Left = 5
    Top = 92
    Width = 262
    Height = 136
    Caption = ' Advanced settings '
    Enabled = False
    TabOrder = 3
    object cpbTrans: TColorPickerButton
      Left = 30
      Top = 35
      Width = 100
      Height = 22
      CustomText = 'Custom'
      DefaultText = 'Default'
      PopupSpacing = 8
      ShowSystemColors = False
      OnChange = cpbTransChange
    end
    object rbnTColor: TRadioButton
      Left = 10
      Top = 17
      Width = 241
      Height = 17
      Caption = 'Use transparent color'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbnTMask: TRadioButton
      Left = 10
      Top = 64
      Width = 248
      Height = 17
      Caption = 'Use transparent mask from file:'
      TabOrder = 1
    end
    object edtPath: TEdit
      Left = 30
      Top = 82
      Width = 199
      Height = 21
      TabOrder = 2
      OnChange = edtPathChange
    end
    object btnSelectFile: TButton
      Left = 30
      Top = 106
      Width = 53
      Height = 20
      Caption = 'Select'
      TabOrder = 3
      OnClick = btnSelectFileClick
    end
  end
  object cbxAdvanced: TCheckBox
    Left = 5
    Top = 72
    Width = 262
    Height = 17
    Caption = 'Use advanced settings'
    TabOrder = 4
    OnClick = cbxAdvancedClick
  end
  object dlgSavePNG: TSaveDialog
    DefaultExt = 'png'
    FileName = 'Untitled'
    Filter = 'Portable Network Graphics (*.png)|*.png'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save to PNG ...'
    Left = 321
    Top = 67
  end
  object dlgSaveJNG: TSaveDialog
    DefaultExt = 'jng'
    FileName = 'Untitled'
    Filter = 'JPEG Network Graphics (*.jng)|*.jng'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save to JNG ...'
    Left = 321
    Top = 97
  end
  object dlgSelMask: TOpenDialog
    DefaultExt = 'bmp'
    Filter = 'Windows bitmaps (*.bmp)|*.bmp'
    Title = 'Select transparency mask bitmap ...'
    Left = 321
    Top = 127
  end
end
