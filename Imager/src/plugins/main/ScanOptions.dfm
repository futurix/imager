object frmScanOpt: TfrmScanOpt
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Scanning Options'
  ClientHeight = 121
  ClientWidth = 336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 172
    Top = 87
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 253
    Top = 87
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object rgpSystem: TRadioGroup
    Left = 8
    Top = 8
    Width = 320
    Height = 73
    Caption = ' Imaging subsystem '
    ItemIndex = 0
    Items.Strings = (
      'WIA (Windows Image Acquisition)'
      'TWAIN')
    TabOrder = 2
  end
end
