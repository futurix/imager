object frmJPsave: TfrmJPsave
  Left = 190
  Top = 79
  ActiveControl = btnSave
  BorderStyle = bsDialog
  Caption = 'Save As JPEG2000'
  ClientHeight = 126
  ClientWidth = 255
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
  object cbxLossless: TCheckBox
    Left = 7
    Top = 68
    Width = 240
    Height = 17
    Caption = 'Lossless'
    Checked = True
    State = cbChecked
    TabOrder = 0
    OnClick = cbxLosslessClick
    OnKeyDown = cbxLosslessKeyDown
    OnMouseDown = cbxLosslessMouseDown
  end
  object gbxCompression: TGroupBox
    Left = 7
    Top = 7
    Width = 241
    Height = 53
    Caption = ' Compression Level '
    TabOrder = 1
    object lblQualityValue: TLabel
      Left = 209
      Top = 19
      Width = 12
      Height = 13
      Caption = '50'
      Enabled = False
      Transparent = True
    end
    object tbrQuality: TTrackBar
      Left = 7
      Top = 20
      Width = 200
      Height = 21
      Enabled = False
      Max = 100
      PageSize = 5
      Frequency = 10
      Position = 50
      TabOrder = 0
      ThumbLength = 11
      OnChange = tbrQualityChange
    end
  end
  object btnSave: TButton
    Left = 94
    Top = 94
    Width = 75
    Height = 25
    Caption = 'Save'
    Default = True
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 173
    Top = 94
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
