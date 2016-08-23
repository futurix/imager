object frmRotate: TfrmRotate
  Left = 192
  Top = 107
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Rotate Image'
  ClientHeight = 317
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
  object sbxRotate: TScrollBox
    Left = 5
    Top = 5
    Width = 350
    Height = 240
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
    Left = 360
    Top = 220
    Width = 75
    Height = 25
    Caption = 'Preview'
    TabOrder = 1
    OnClick = btnPreviewClick
  end
  object btnOK: TButton
    Left = 360
    Top = 5
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 360
    Top = 33
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = btnCancelClick
  end
  object gbxAngle: TGroupBox
    Left = 5
    Top = 248
    Width = 292
    Height = 63
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
      Orientation = trHorizontal
      PageSize = 30
      Frequency = 30
      Position = 0
      SelEnd = 0
      SelStart = 0
      TabOrder = 1
      TickMarks = tmBottomRight
      TickStyle = tsAuto
      OnChange = tbrAngleChange
    end
  end
  object gbxColor: TGroupBox
    Left = 303
    Top = 248
    Width = 133
    Height = 48
    Caption = ' Fill Color '
    TabOrder = 5
    object pkrColor: TColorPickerButton
      Left = 11
      Top = 17
      Width = 108
      Height = 22
      CustomText = 'Custom'
      DefaultText = 'Default'
      PopupSpacing = 8
      SelectionColor = clAppWorkSpace
      ShowSystemColors = False
      OnChange = pkrColorChange
    end
  end
  object cbxAutoSize: TCheckBox
    Left = 303
    Top = 298
    Width = 97
    Height = 17
    Caption = 'Autosize Image'
    Checked = True
    State = cbChecked
    TabOrder = 6
    OnClick = cbxAutoSizeClick
  end
  object btn90Left: TButton
    Left = 360
    Top = 94
    Width = 75
    Height = 25
    Caption = '90 deg. CW'
    TabOrder = 7
    OnClick = btn90LeftClick
  end
  object btn90Right: TButton
    Left = 360
    Top = 122
    Width = 75
    Height = 25
    Caption = '90 deg. CCW'
    TabOrder = 8
    OnClick = btn90RightClick
  end
  object dlgColor: TColorDialog
    Ctl3D = True
    Options = [cdFullOpen, cdAnyColor]
    Left = 319
    Top = 9
  end
end
