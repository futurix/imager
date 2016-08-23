object frmRotate: TfrmRotate
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Rotate Image'
  ClientHeight = 122
  ClientWidth = 197
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblAngle: TLabel
    Left = 10
    Top = 13
    Width = 31
    Height = 13
    Caption = 'Angle:'
    Transparent = True
  end
  object lblQuality: TLabel
    Left = 10
    Top = 43
    Width = 38
    Height = 13
    Caption = 'Quality:'
    Transparent = True
  end
  object btnOK: TButton
    Left = 33
    Top = 88
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 113
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = btnCancelClick
  end
  object updAngle: TUpDown
    Left = 170
    Top = 10
    Width = 16
    Height = 21
    Associate = edtAngle
    Max = 360
    Increment = 30
    Position = 90
    TabOrder = 1
    Thousands = False
    Wrap = True
  end
  object edtAngle: TEdit
    Left = 49
    Top = 10
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '90'
    OnChange = edtAngleChange
  end
  object cmbQuality: TComboBox
    Left = 10
    Top = 59
    Width = 178
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 3
    TabOrder = 2
    Text = 'Rough (fast)'
    OnChange = cmbQualityChange
    Items.Strings = (
      'Highest (very slow)'
      'High (slow)'
      'Mediocre'
      'Rough (fast)')
  end
end
