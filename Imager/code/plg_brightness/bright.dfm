object frmBrightness: TfrmBrightness
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Brightness'
  ClientHeight = 304
  ClientWidth = 514
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
  object lblOriginal: TLabel
    Left = 5
    Top = 290
    Width = 35
    Height = 13
    Caption = 'Original'
    Transparent = True
  end
  object lblModified: TLabel
    Left = 264
    Top = 290
    Width = 40
    Height = 13
    Caption = 'Modified'
    Transparent = True
  end
  object btnOK: TButton
    Left = 356
    Top = 9
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 434
    Top = 9
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object gbxBrightness: TGroupBox
    Left = 5
    Top = 4
    Width = 344
    Height = 58
    Caption = ' Brightness '
    TabOrder = 2
    object lblValue: TLabel
      Left = 316
      Top = 19
      Width = 6
      Height = 13
      Caption = '0'
    end
    object trbBrightness: TTrackBar
      Left = 5
      Top = 17
      Width = 305
      Height = 34
      Max = 255
      Min = -255
      PageSize = 10
      Frequency = 51
      TabOrder = 0
      OnChange = trbBrightnessChange
    end
  end
  object sbxOrig: TScrollBox
    Left = 5
    Top = 67
    Width = 252
    Height = 221
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Color = clAppWorkSpace
    ParentColor = False
    TabOrder = 3
    object imgOrig: TImage
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      AutoSize = True
    end
  end
  object sbxMod: TScrollBox
    Left = 264
    Top = 67
    Width = 245
    Height = 221
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Color = clAppWorkSpace
    ParentColor = False
    TabOrder = 4
    object imgMod: TImage
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      AutoSize = True
    end
  end
end
