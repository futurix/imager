object frmResize: TfrmResize
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Resize image'
  ClientHeight = 155
  ClientWidth = 272
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblHeight: TLabel
    Left = 142
    Top = 8
    Width = 35
    Height = 13
    Caption = 'Height:'
  end
  object lblMethod: TLabel
    Left = 10
    Top = 71
    Width = 74
    Height = 13
    Caption = 'Resize method:'
  end
  object lblWidth: TLabel
    Left = 10
    Top = 8
    Width = 32
    Height = 13
    Caption = 'Width:'
  end
  object bvlSep: TBevel
    Left = 10
    Top = 115
    Width = 253
    Height = 2
  end
  object btnOK: TButton
    Left = 110
    Top = 121
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 188
    Top = 121
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object edtWidth: TEdit
    Left = 10
    Top = 22
    Width = 121
    Height = 21
    TabOrder = 3
    OnChange = edtWidthChange
  end
  object edtHeight: TEdit
    Left = 142
    Top = 22
    Width = 121
    Height = 21
    TabOrder = 4
    OnChange = edtHeightChange
  end
  object cbxMethod: TComboBox
    Left = 10
    Top = 85
    Width = 121
    Height = 22
    Style = csOwnerDrawFixed
    DropDownCount = 7
    ItemHeight = 16
    TabOrder = 2
    Items.Strings = (
      'Box'
      'Triangle'
      'Hermite'
      'Bell'
      'Spline'
      'Lanczos3'
      'Mitchell')
  end
  object cbxProp: TCheckBox
    Left = 10
    Top = 48
    Width = 253
    Height = 17
    Caption = 'Save Image Proportions'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
end
