object frmXRsave: TfrmXRsave
  Left = 190
  Top = 79
  ActiveControl = btnSave
  BorderStyle = bsDialog
  Caption = 'Save As JPEG XR / HD Photo'
  ClientHeight = 133
  ClientWidth = 254
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object bvlSep: TBevel
    Left = 7
    Top = 93
    Width = 241
    Height = 2
  end
  object btnSave: TButton
    Left = 94
    Top = 100
    Width = 75
    Height = 25
    Caption = 'Save'
    Default = True
    TabOrder = 0
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 173
    Top = 100
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object cbxLossless: TCheckBox
    Left = 7
    Top = 70
    Width = 240
    Height = 17
    Caption = 'Lossless'
    TabOrder = 2
  end
  object gbxQuality: TGroupBox
    Left = 7
    Top = 7
    Width = 241
    Height = 57
    Caption = ' Quality '
    TabOrder = 3
    object lblQualityValue: TLabel
      Left = 209
      Top = 18
      Width = 12
      Height = 13
      Caption = '90'
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
      Position = 90
      TabOrder = 0
      ThumbLength = 11
      OnChange = tbrQualityChange
    end
  end
end
