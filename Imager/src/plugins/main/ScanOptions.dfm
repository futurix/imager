object frmScanOpt: TfrmScanOpt
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Scanning Options'
  ClientHeight = 173
  ClientWidth = 351
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
  object lblWIAwarn: TLabel
    Left = 10
    Top = 115
    Width = 212
    Height = 13
    Caption = 'Note: WIA is not available for Windows2000'
    Transparent = True
  end
  object btnOK: TButton
    Left = 183
    Top = 135
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 264
    Top = 135
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object rgpSystem: TRadioGroup
    Left = 10
    Top = 10
    Width = 330
    Height = 100
    Caption = ' Imaging subsystem '
    ItemIndex = 0
    Items.Strings = (
      'System default'
      'WIA (Windows Image Acquisition)'
      'TWAIN')
    TabOrder = 2
  end
end
