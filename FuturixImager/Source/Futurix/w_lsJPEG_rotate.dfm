object frmJPEG: TfrmJPEG
  Left = 190
  Top = 79
  ActiveControl = btnCancel
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'JPEG Lossless Transformations'
  ClientHeight = 366
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object sbnRotate90: TSpeedButton
    Left = 10
    Top = 10
    Width = 325
    Height = 25
    Caption = 'Rotate 90'#176
    Flat = True
    Margin = 5
    OnClick = sbnRotate90Click
  end
  object sbnRotate180: TSpeedButton
    Left = 10
    Top = 40
    Width = 325
    Height = 25
    Caption = 'Rotate 180'#176
    Flat = True
    Margin = 5
    OnClick = sbnRotate180Click
  end
  object sbnRotate270: TSpeedButton
    Left = 10
    Top = 70
    Width = 325
    Height = 25
    Caption = 'Rotate 270'#176
    Flat = True
    Margin = 5
    OnClick = sbnRotate270Click
  end
  object sbnFlipH: TSpeedButton
    Left = 10
    Top = 100
    Width = 325
    Height = 25
    Caption = 'Mirror horizontally'
    Flat = True
    Margin = 5
    OnClick = sbnFlipHClick
  end
  object sbnFlipV: TSpeedButton
    Left = 10
    Top = 130
    Width = 325
    Height = 25
    Caption = 'Mirror vertically'
    Flat = True
    Margin = 5
    OnClick = sbnFlipVClick
  end
  object sbnTranspose: TSpeedButton
    Left = 10
    Top = 160
    Width = 325
    Height = 25
    Caption = 'Transpose'
    Flat = True
    Margin = 5
    OnClick = sbnTransposeClick
  end
  object sbnTransverse: TSpeedButton
    Left = 10
    Top = 190
    Width = 325
    Height = 25
    Caption = 'Transverse'
    Flat = True
    Margin = 5
    OnClick = sbnTransverseClick
  end
  object sbnCut: TSpeedButton
    Left = 10
    Top = 220
    Width = 325
    Height = 25
    Caption = 'Cut'
    Flat = True
    Margin = 5
    OnClick = sbnCutClick
  end
  object sbnNone: TSpeedButton
    Left = 10
    Top = 250
    Width = 325
    Height = 25
    Caption = 'Remove metadata'
    Flat = True
    Margin = 5
    OnClick = sbnNoneClick
  end
  object btnCancel: TButton
    Left = 260
    Top = 331
    Width = 75
    Height = 25
    Caption = 'Cancel'
    Default = True
    TabOrder = 0
    OnClick = btnCancelClick
  end
  object cbxEXIF: TCheckBox
    Left = 10
    Top = 288
    Width = 325
    Height = 17
    Caption = 'Update EXIF thumbnail'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object cbxBackup: TCheckBox
    Left = 10
    Top = 308
    Width = 325
    Height = 17
    Caption = 'Back-up original image'
    TabOrder = 2
  end
end
