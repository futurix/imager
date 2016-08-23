object frmRotate: TfrmRotate
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Rotate Image'
  ClientHeight = 423
  ClientWidth = 592
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
  object sbxRotate: TScrollBox
    Left = 5
    Top = 5
    Width = 502
    Height = 340
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Color = clAppWorkSpace
    ParentColor = False
    TabOrder = 0
    object imgRotate: TRotateImage
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      AutoSize = True
      UniqueSize = False
    end
  end
  object btnPreview: TButton
    Left = 512
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Preview'
    TabOrder = 1
    OnClick = btnPreviewClick
  end
  object btnOK: TButton
    Left = 512
    Top = 5
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 512
    Top = 33
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = btnCancelClick
  end
  object gbxAngle: TGroupBox
    Left = 5
    Top = 350
    Width = 292
    Height = 66
    Caption = ' Angle (degr.) '
    TabOrder = 4
    object edtAngle: TEdit
      Left = 241
      Top = 22
      Width = 41
      Height = 21
      TabOrder = 0
      Text = '0'
    end
    object tbrAngle: TTrackBar
      Left = 4
      Top = 19
      Width = 234
      Height = 31
      Max = 360
      PageSize = 30
      Frequency = 30
      TabOrder = 1
      OnChange = tbrAngleChange
    end
  end
  object gbxColor: TGroupBox
    Left = 455
    Top = 350
    Width = 133
    Height = 48
    Caption = ' Fill Color '
    TabOrder = 5
    object pkrColor: TColorPickerButton
      Left = 11
      Top = 17
      Width = 110
      Height = 22
      CustomText = 'Custom'
      DefaultText = 'Default'
      Flat = True
      PopupSpacing = 8
      SelectionColor = clWhite
      ShowSystemColors = False
      OnChange = pkrColorChange
    end
  end
  object cbxAutoSize: TCheckBox
    Left = 455
    Top = 400
    Width = 97
    Height = 17
    Caption = 'Autosize Image'
    Checked = True
    State = cbChecked
    TabOrder = 6
    OnClick = cbxAutoSizeClick
  end
  object btn90Left: TButton
    Left = 512
    Top = 94
    Width = 75
    Height = 25
    Caption = '90 deg. CW'
    TabOrder = 7
    OnClick = btn90LeftClick
  end
  object btn90Right: TButton
    Left = 512
    Top = 122
    Width = 75
    Height = 25
    Caption = '90 deg. CCW'
    TabOrder = 8
    OnClick = btn90RightClick
  end
end
