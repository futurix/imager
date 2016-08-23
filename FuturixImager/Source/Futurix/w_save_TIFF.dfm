object frmTIFFsave: TfrmTIFFsave
  Left = 190
  Top = 79
  ActiveControl = btnSave
  BorderStyle = bsDialog
  Caption = 'Save As TIFF'
  ClientHeight = 238
  ClientWidth = 274
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object gbxCompression: TGroupBox
    Left = 7
    Top = 7
    Width = 259
    Height = 123
    Caption = ' Compression '
    TabOrder = 0
    object rbnCNone: TRadioButton
      Left = 10
      Top = 17
      Width = 120
      Height = 17
      Caption = 'None'
      TabOrder = 0
    end
    object rbnCLZW: TRadioButton
      Left = 135
      Top = 17
      Width = 120
      Height = 17
      Caption = 'LZW'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object rbnCJPEG: TRadioButton
      Left = 10
      Top = 37
      Width = 120
      Height = 17
      Caption = 'JPEG'
      TabOrder = 2
    end
    object rbnCZLib: TRadioButton
      Left = 10
      Top = 57
      Width = 120
      Height = 17
      Caption = 'CCITT (Huffman)'
      TabOrder = 3
    end
    object rbnCPackBits: TRadioButton
      Left = 135
      Top = 37
      Width = 120
      Height = 17
      Caption = 'PackBits'
      TabOrder = 4
    end
    object rbnCG31: TRadioButton
      Left = 135
      Top = 57
      Width = 120
      Height = 17
      Caption = 'CCITT G3, 1D'
      TabOrder = 5
    end
    object rbnCG32: TRadioButton
      Left = 10
      Top = 77
      Width = 120
      Height = 17
      Caption = 'CCITT G3, 2D'
      TabOrder = 6
    end
    object rbnCG4: TRadioButton
      Left = 135
      Top = 77
      Width = 120
      Height = 17
      Caption = 'CCITT G4, 2D'
      TabOrder = 7
    end
    object rbnZIP: TRadioButton
      Left = 10
      Top = 97
      Width = 120
      Height = 17
      Caption = 'ZIP'
      TabOrder = 8
    end
  end
  object gbxJPEG: TGroupBox
    Left = 7
    Top = 140
    Width = 259
    Height = 57
    Caption = ' Compression Level (only for JPEG) '
    TabOrder = 1
    object lblQualityValue: TLabel
      Left = 220
      Top = 18
      Width = 12
      Height = 13
      Caption = '80'
      Transparent = True
    end
    object tbrQuality: TTrackBar
      Left = 7
      Top = 19
      Width = 200
      Height = 21
      Max = 100
      PageSize = 5
      Frequency = 10
      Position = 80
      TabOrder = 0
      ThumbLength = 11
      OnChange = tbrQualityChange
    end
  end
  object btnCancel: TButton
    Left = 191
    Top = 204
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnSave: TButton
    Left = 112
    Top = 204
    Width = 75
    Height = 25
    Caption = 'Save'
    Default = True
    TabOrder = 3
    OnClick = btnSaveClick
  end
end
