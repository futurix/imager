object frmAbout: TfrmAbout
  Left = 192
  Top = 107
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'About Futuris Imager'
  ClientHeight = 63
  ClientWidth = 412
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblProgram: TLabel
    Left = 57
    Top = 17
    Width = 66
    Height = 13
    Caption = 'Futuris Imager'
    Transparent = True
  end
  object lblCopy: TLabel
    Left = 57
    Top = 32
    Width = 179
    Height = 13
    Caption = '© 1999-2002 Alexander Tereschenko'
    Transparent = True
  end
  object imgAbout: TImage
    Left = 15
    Top = 15
    Width = 32
    Height = 32
  end
  object btnOK: TButton
    Left = 321
    Top = 15
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object verAbout: TdfsVersionInfoResource
    ShowResource = [pdCompanyName, pdFileDescription, pdFileVersion, pdInternalName, pdLegalCopyright, pdLegalTrademarks, pdOriginalFilename, pdProductName, pdProductVersion, pdComments, pdBuildFlags]
    Left = 241
    Top = 5
  end
end
