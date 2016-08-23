object frmColor: TfrmColor
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Change image colors'
  ClientHeight = 142
  ClientWidth = 377
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
  object lblValRed: TLabel
    Left = 344
    Top = 9
    Width = 6
    Height = 13
    Caption = '0'
    Transparent = True
  end
  object lblRed: TLabel
    Left = 6
    Top = 12
    Width = 23
    Height = 13
    Caption = 'Red:'
    Transparent = True
  end
  object lblGreen: TLabel
    Left = 6
    Top = 42
    Width = 33
    Height = 13
    Caption = 'Green:'
    Transparent = True
  end
  object lblBlue: TLabel
    Left = 6
    Top = 72
    Width = 24
    Height = 13
    Caption = 'Blue:'
    Transparent = True
  end
  object lblValGreen: TLabel
    Left = 344
    Top = 39
    Width = 6
    Height = 13
    Caption = '0'
    Transparent = True
  end
  object lblValBlue: TLabel
    Left = 344
    Top = 69
    Width = 6
    Height = 13
    Caption = '0'
    Transparent = True
  end
  object btnOK: TButton
    Left = 215
    Top = 110
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 295
    Top = 110
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object trbRed: TTrackBar
    Left = 79
    Top = 6
    Width = 263
    Height = 30
    Max = 255
    Min = -255
    PageSize = 5
    Frequency = 30
    TabOrder = 2
    OnChange = TrackBarChange
  end
  object trbGreen: TTrackBar
    Left = 79
    Top = 36
    Width = 263
    Height = 32
    Max = 255
    Min = -255
    PageSize = 5
    Frequency = 30
    TabOrder = 3
    OnChange = TrackBarChange
  end
  object trbBlue: TTrackBar
    Left = 79
    Top = 66
    Width = 263
    Height = 31
    Max = 255
    Min = -255
    PageSize = 5
    Frequency = 30
    TabOrder = 4
    OnChange = TrackBarChange
  end
end
