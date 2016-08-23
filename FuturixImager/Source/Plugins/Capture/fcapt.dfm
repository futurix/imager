object frmCapture: TfrmCapture
  Left = 190
  Top = 79
  ActiveControl = btnCapture
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Screen Capture'
  ClientHeight = 226
  ClientWidth = 220
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object btnCapture: TButton
    Left = 55
    Top = 193
    Width = 75
    Height = 25
    Caption = 'Capture'
    Default = True
    TabOrder = 3
    OnClick = btnCaptureClick
  end
  object btnCancel: TButton
    Left = 135
    Top = 193
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = btnCancelClick
  end
  object gbxCaptureType: TGroupBox
    Left = 9
    Top = 9
    Width = 200
    Height = 105
    Caption = ' Capture '
    TabOrder = 0
    object rbnCaptDesktop: TRadioButton
      Left = 15
      Top = 19
      Width = 170
      Height = 17
      Caption = 'Desktop'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbnCaptActWindow: TRadioButton
      Left = 15
      Top = 79
      Width = 170
      Height = 17
      Caption = 'Active window'
      TabOrder = 3
    end
    object rbnCaptSelection: TRadioButton
      Left = 15
      Top = 59
      Width = 170
      Height = 17
      Caption = 'Selection'
      TabOrder = 2
    end
    object rbnCaptPolygon: TRadioButton
      Left = 15
      Top = 39
      Width = 170
      Height = 17
      Caption = 'Polygon'
      TabOrder = 1
    end
  end
  object cbxHideImager: TCheckBox
    Left = 10
    Top = 120
    Width = 200
    Height = 17
    Caption = 'Hide this window'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object cbxCaptureCursor: TCheckBox
    Left = 10
    Top = 140
    Width = 200
    Height = 17
    Caption = 'Capture cursor'
    TabOrder = 2
  end
  object cbxDelay: TCheckBox
    Left = 10
    Top = 160
    Width = 200
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
    Left = 180
    Top = 119
  end
end
