object frmCapture: TfrmCapture
  Left = 190
  Top = 79
  ActiveControl = btnCapture
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Screen Capture'
  ClientHeight = 152
  ClientWidth = 332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnCapture: TButton
    Left = 172
    Top = 121
    Width = 75
    Height = 25
    Caption = 'Capture'
    Default = True
    TabOrder = 3
    OnClick = btnCaptureClick
  end
  object btnCancel: TButton
    Left = 250
    Top = 121
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = btnCancelClick
  end
  object gbxCaptureType: TGroupBox
    Left = 9
    Top = 9
    Width = 162
    Height = 105
    Caption = ' Capture '
    TabOrder = 0
    object rbnCaptDesktop: TRadioButton
      Left = 15
      Top = 19
      Width = 139
      Height = 17
      Caption = 'Desktop'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbnCaptActWindow: TRadioButton
      Left = 15
      Top = 79
      Width = 138
      Height = 17
      Caption = 'Active window'
      TabOrder = 3
    end
    object rbnCaptSelection: TRadioButton
      Left = 15
      Top = 59
      Width = 139
      Height = 17
      Caption = 'Selection'
      TabOrder = 2
    end
    object rbnCaptPolygon: TRadioButton
      Left = 15
      Top = 39
      Width = 139
      Height = 17
      Caption = 'Polygon'
      TabOrder = 1
    end
  end
  object cbxHideImager: TCheckBox
    Left = 180
    Top = 12
    Width = 143
    Height = 17
    Caption = 'Hide this window'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object cbxCaptureCursor: TCheckBox
    Left = 180
    Top = 32
    Width = 144
    Height = 17
    Caption = 'Capture cursor'
    TabOrder = 2
  end
  object cbxDelay: TCheckBox
    Left = 180
    Top = 52
    Width = 149
    Height = 17
    Caption = 'Enable 5 seconds delay'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object scrCapture: TASGScreenCapture
    Auto = False
    Delay = 5000
    Minimize = False
    ShowCursor = False
    Left = 181
    Top = 83
  end
end
