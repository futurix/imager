object frmCrop: TfrmCrop
  Left = 192
  Top = 107
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Crop Image'
  ClientHeight = 322
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblTop: TLabel
    Left = 8
    Top = 3
    Width = 19
    Height = 13
    Caption = 'Top'
  end
  object lblLeft: TLabel
    Left = 80
    Top = 3
    Width = 18
    Height = 13
    Caption = 'Left'
  end
  object lblRight: TLabel
    Left = 152
    Top = 3
    Width = 25
    Height = 13
    Caption = 'Right'
  end
  object lblBottom: TLabel
    Left = 224
    Top = 3
    Width = 33
    Height = 13
    Caption = 'Bottom'
  end
  object btnOK: TButton
    Left = 281
    Top = 291
    Width = 72
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 360
    Top = 291
    Width = 73
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object edtTop: TEdit
    Left = 7
    Top = 16
    Width = 50
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object edtBottom: TEdit
    Left = 225
    Top = 16
    Width = 50
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object edtRight: TEdit
    Left = 152
    Top = 16
    Width = 50
    Height = 21
    TabOrder = 4
    Text = '0'
  end
  object edtLeft: TEdit
    Left = 81
    Top = 16
    Width = 50
    Height = 21
    TabOrder = 5
    Text = '0'
  end
  object udTop: TUpDown
    Left = 57
    Top = 16
    Width = 15
    Height = 21
    Associate = edtTop
    Min = 0
    Increment = 10
    Position = 0
    TabOrder = 6
    Wrap = False
    OnClick = udTopClick
  end
  object udBottom: TUpDown
    Left = 275
    Top = 16
    Width = 15
    Height = 21
    Associate = edtBottom
    Min = 0
    Increment = 10
    Position = 0
    TabOrder = 7
    Wrap = False
    OnClick = udBottomClick
  end
  object udRight: TUpDown
    Left = 202
    Top = 16
    Width = 15
    Height = 21
    Associate = edtRight
    Min = 0
    Increment = 10
    Position = 0
    TabOrder = 8
    Wrap = False
    OnClick = udRightClick
  end
  object udLeft: TUpDown
    Left = 131
    Top = 16
    Width = 15
    Height = 21
    Associate = edtLeft
    Min = 0
    Increment = 10
    Position = 0
    TabOrder = 9
    Wrap = False
    OnClick = udLeftClick
  end
  object sbxPreview: TScrollBox
    Left = 7
    Top = 43
    Width = 426
    Height = 241
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Color = clAppWorkSpace
    ParentColor = False
    TabOrder = 10
    object imgPreview: TImage
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      AutoSize = True
      OnMouseDown = imgPreviewMouseDown
    end
  end
  object btnPreview: TButton
    Left = 7
    Top = 291
    Width = 71
    Height = 25
    Caption = 'Preview'
    TabOrder = 11
    OnClick = btnPreviewClick
  end
  object btnReset: TButton
    Left = 85
    Top = 291
    Width = 73
    Height = 25
    Caption = 'Reset'
    TabOrder = 12
    OnClick = btnResetClick
  end
end
