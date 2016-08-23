object frmSelectColor: TfrmSelectColor
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Select Color'
  ClientHeight = 88
  ClientWidth = 185
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object cpbMain: TColorPickerButton
    Left = 7
    Top = 7
    Width = 171
    Height = 42
    CustomText = 'Custom'
    DefaultText = 'Default'
    Flat = True
    PopupSpacing = 8
    ShowSystemColors = False
  end
  object btnOK: TButton
    Left = 103
    Top = 54
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
end
