object frmCustZoom: TfrmCustZoom
  Left = 192
  Top = 107
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Custom Zoom'
  ClientHeight = 52
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblCustZoom: TLabel
    Left = 6
    Top = 6
    Width = 98
    Height = 13
    Caption = 'Select custom zoom:'
  end
  object btnOK: TButton
    Left = 170
    Top = 13
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 248
    Top = 13
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object cbxZoom: TComboBox
    Left = 6
    Top = 22
    Width = 128
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = '75'
    Items.Strings = (
      '10'
      '33'
      '66'
      '75'
      '99'
      '125'
      '150'
      '333'
      '1000')
  end
end
