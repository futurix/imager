object frmBrightness: TfrmBrightness
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Brightness'
  ClientHeight = 104
  ClientWidth = 357
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
  object btnOK: TButton
    Left = 193
    Top = 69
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 274
    Top = 69
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object gbxBrightness: TGroupBox
    Left = 6
    Top = 5
    Width = 344
    Height = 58
    Caption = ' Brightness '
    TabOrder = 2
    object lblValue: TLabel
      Left = 316
      Top = 19
      Width = 6
      Height = 13
      Caption = '0'
    end
    object trbBrightness: TTrackBar
      Left = 5
      Top = 17
      Width = 305
      Height = 34
      Max = 255
      Min = -255
      PageSize = 10
      Frequency = 51
      TabOrder = 0
      OnChange = trbBrightnessChange
    end
  end
end
