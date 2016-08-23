object frmAbout: TfrmAbout
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 116
  ClientWidth = 366
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
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblProgram: TLabel
    Left = 76
    Top = 15
    Width = 40
    Height = 13
    Caption = 'Program'
    Transparent = True
  end
  object lblCopy: TLabel
    Left = 76
    Top = 30
    Width = 25
    Height = 13
    Caption = 'Copy'
    Transparent = True
  end
  object imgAbout: TImage
    Left = 15
    Top = 15
    Width = 48
    Height = 48
  end
  object lblWeb: TLabel
    Left = 15
    Top = 70
    Width = 39
    Height = 13
    Cursor = crHandPoint
    Caption = 'Website'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = [fsUnderline]
    ParentFont = False
    Transparent = True
    OnClick = lblWebClick
  end
  object btnOK: TButton
    Left = 277
    Top = 77
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
end
