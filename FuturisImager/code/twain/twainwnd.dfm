object frmAcquire: TfrmAcquire
  Left = 190
  Top = 105
  ActiveControl = btnGetImage
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'TWAIN Acquire...'
  ClientHeight = 320
  ClientWidth = 413
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnOpen: TButton
    Left = 255
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 0
    Visible = False
    OnClick = btnOpenClick
  end
  object btnCancel: TButton
    Left = 333
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object btnGetImage: TButton
    Left = 6
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Get Image'
    Default = True
    TabOrder = 2
    OnClick = btnGetImageClick
  end
  object pnlPreview: TPanel
    Left = 6
    Top = 6
    Width = 402
    Height = 277
    BevelOuter = bvLowered
    Caption = 'No picture loaded. Click "Get Image" to continue.'
    TabOrder = 3
    object imgPreview: TImage
      Left = 1
      Top = 1
      Width = 400
      Height = 275
      Center = True
      Proportional = True
    end
  end
  object cmpTwain: TDelphiTwain
    OnTwainAcquire = cmpTwainTwainAcquire
    TransferMode = ttmNative
    SourceCount = 0
    Info.MajorVersion = 4
    Info.MinorVersion = 6
    Info.Language = tlUserLocale
    Info.CountryCode = 1
    Info.Groups = [tgControl, tgImage]
    Info.VersionInfo = '4.6'
    Info.Manufacturer = 'Alexander Tereshchenko'
    Info.ProductFamily = 'Futuris'
    Info.ProductName = 'Futuris Imager'
    LibraryLoaded = False
    SourceManagerLoaded = False
    Left = 15
    Top = 14
  end
end
