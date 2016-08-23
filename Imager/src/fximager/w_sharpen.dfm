object frmSharpen: TfrmSharpen
  Left = 190
  Top = 79
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Sharpen'
  ClientHeight = 97
  ClientWidth = 200
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
  object lblAmount: TLabel
    Left = 10
    Top = 10
    Width = 41
    Height = 13
    Caption = 'Amount:'
    Transparent = True
  end
  object btnOK: TButton
    Left = 34
    Top = 65
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 115
    Top = 65
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object trbAmount: TTrackBar
    Left = 3
    Top = 24
    Width = 194
    Height = 36
    Max = 100
    PageSize = 10
    Frequency = 10
    Position = 10
    TabOrder = 2
    OnChange = trbAmountChange
  end
end
