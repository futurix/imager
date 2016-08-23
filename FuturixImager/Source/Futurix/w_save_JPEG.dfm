object frmJPEGsave: TfrmJPEGsave
  Left = 190
  Top = 79
  ActiveControl = btnSave
  BorderStyle = bsDialog
  Caption = 'Save As JPEG'
  ClientHeight = 148
  ClientWidth = 254
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
  object bvlSep: TBevel
    Left = 7
    Top = 110
    Width = 241
    Height = 2
  end
  object btnSave: TButton
    Left = 94
    Top = 117
    Width = 75
    Height = 25
    Caption = 'Save'
    Default = True
    TabOrder = 0
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 173
    Top = 117
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object cbxProgressive: TCheckBox
    Left = 7
    Top = 70
    Width = 240
    Height = 17
    Caption = 'Progressive'
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
      Caption = '85'
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
      Position = 85
      TabOrder = 0
      ThumbLength = 11
      OnChange = tbrQualityChange
    end
  end
  object cbxOptimized: TCheckBox
    Left = 7
    Top = 88
    Width = 241
    Height = 17
    Caption = 'Optimized (takes longer to save)'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
end
