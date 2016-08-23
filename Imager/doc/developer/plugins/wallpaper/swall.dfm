object frmWallpaperS: TfrmWallpaperS
  Left = 190
  Top = 79
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Set as Wallpaper'
  ClientHeight = 150
  ClientWidth = 217
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
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 53
    Top = 114
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
    Width = 197
    Height = 94
    Caption = ' Wallpaper position '
    TabOrder = 1
    object rbnCenter: TRadioButton
      Left = 21
      Top = 23
      Width = 165
      Height = 17
      Caption = 'Center'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbnTile: TRadioButton
      Left = 21
      Top = 43
      Width = 165
      Height = 17
      Caption = 'Tile'
      TabOrder = 1
    end
    object rbnStretch: TRadioButton
      Left = 21
      Top = 63
      Width = 165
      Height = 17
      Caption = 'Stretch'
      TabOrder = 2
    end
  end
  object btnCancel: TButton
    Left = 132
    Top = 114
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
end
