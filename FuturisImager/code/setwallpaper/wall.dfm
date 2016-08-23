object frmWallpaper: TfrmWallpaper
  Left = 190
  Top = 105
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Set as Wallpaper'
  ClientHeight = 116
  ClientWidth = 249
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 164
    Top = 15
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object gbxWallpaper: TGroupBox
    Left = 10
    Top = 10
    Width = 146
    Height = 94
    Caption = ' Wallpaper position '
    TabOrder = 1
    object rbnCenter: TRadioButton
      Left = 21
      Top = 23
      Width = 113
      Height = 17
      Caption = 'Center'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbnTile: TRadioButton
      Left = 21
      Top = 43
      Width = 113
      Height = 17
      Caption = 'Tile'
      TabOrder = 1
    end
    object rbnStretch: TRadioButton
      Left = 21
      Top = 63
      Width = 113
      Height = 17
      Caption = 'Stretch'
      TabOrder = 2
    end
  end
  object btnCancel: TButton
    Left = 164
    Top = 45
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
