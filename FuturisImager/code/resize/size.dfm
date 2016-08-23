object frmResize: TfrmResize
  Left = 190
  Top = 105
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Resize image'
  ClientHeight = 129
  ClientWidth = 272
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
  object lblHeight: TLabel
    Left = 142
    Top = 8
    Width = 34
    Height = 13
    Caption = 'Height:'
  end
  object lblMethod: TLabel
    Left = 10
    Top = 46
    Width = 73
    Height = 13
    Caption = 'Resize method:'
  end
  object lblWidth: TLabel
    Left = 10
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Width:'
  end
  object bvlSep: TBevel
    Left = 10
    Top = 90
    Width = 253
    Height = 2
  end
  object btnOK: TButton
    Left = 110
    Top = 96
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 188
    Top = 96
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
  end
  object edtHeight: TEdit
    Left = 142
    Top = 22
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object cbxMethod: TComboBox
    Left = 10
    Top = 60
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
      'Lancroz3'
      'Mitchell')
  end
end
