object frmInfo: TfrmInfo
  Left = 192
  Top = 107
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'JPEG Information'
  ClientHeight = 72
  ClientWidth = 237
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object bvlFrame: TBevel
    Left = 5
    Top = 4
    Width = 228
    Height = 37
  end
  object lblColor: TLabel
    Left = 18
    Top = 15
    Width = 83
    Height = 13
    Caption = '24-bit Color JPEG'
  end
  object btnOK: TButton
    Left = 158
    Top = 45
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
end
