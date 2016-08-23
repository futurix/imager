object frmColor: TfrmColor
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Change image colors'
  ClientHeight = 317
  ClientWidth = 492
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
    Left = 304
    Top = 9
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblRed: TLabel
    Left = 6
    Top = 12
    Width = 23
    Height = 13
    Caption = 'Red:'
  end
  object lblGreen: TLabel
    Left = 6
    Top = 42
    Width = 33
    Height = 13
    Caption = 'Green:'
  end
  object lblBlue: TLabel
    Left = 6
    Top = 72
    Width = 24
    Height = 13
    Caption = 'Blue:'
  end
  object lblValGreen: TLabel
    Left = 304
    Top = 39
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lblValBlue: TLabel
    Left = 304
    Top = 69
    Width = 6
    Height = 13
    Caption = '0'
  end
  object btnOK: TButton
    Left = 413
    Top = 6
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 413
    Top = 33
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object sbxPreview: TScrollBox
    Left = 2
    Top = 101
    Width = 487
    Height = 214
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Color = clAppWorkSpace
    ParentColor = False
    TabOrder = 2
    object imgPreview: TImage
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      AutoSize = True
    end
  end
  object trbRed: TTrackBar
    Left = 39
    Top = 6
    Width = 263
    Height = 30
    Max = 255
    Min = -255
    PageSize = 5
    Frequency = 30
    TabOrder = 3
    OnChange = TrackBarChange
  end
  object trbGreen: TTrackBar
    Left = 39
    Top = 36
    Width = 263
    Height = 32
    Max = 255
    Min = -255
    PageSize = 5
    Frequency = 30
    TabOrder = 4
    OnChange = TrackBarChange
  end
  object trbBlue: TTrackBar
    Left = 39
    Top = 66
    Width = 263
    Height = 31
    Max = 255
    Min = -255
    PageSize = 5
    Frequency = 30
    TabOrder = 5
    OnChange = TrackBarChange
  end
end
