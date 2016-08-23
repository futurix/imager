object frmAbout: TfrmAbout
  Left = 190
  Top = 79
  BorderStyle = bsDialog
  ClientHeight = 239
  ClientWidth = 511
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  GlassFrame.Enabled = True
  GlassFrame.SheetOfGlass = True
  KeyPreview = True
  OldCreateOrder = False
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  DesignSize = (
    511
    239)
  PixelsPerInch = 96
  TextHeight = 13
  object lblProgram: TLabel
    Left = 8
    Top = 199
    Width = 54
    Height = 27
    Caption = 'Program'
    GlowSize = 7
    Transparent = True
  end
  object lblCopy: TLabel
    Left = 458
    Top = 199
    Width = 45
    Height = 33
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Copy'
    GlowSize = 10
    Transparent = True
  end
  object lblWeb: TLabel
    Left = 444
    Top = 218
    Width = 59
    Height = 33
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    Caption = 'Website'
    GlowSize = 10
    ParentShowHint = False
    ShowHint = True
    Transparent = True
    OnClick = lblWebClick
  end
  object lblUK: TLabel
    Left = 8
    Top = 218
    Width = 73
    Height = 33
    Caption = 'Made in UK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    GlowSize = 10
    ParentFont = False
  end
  object lblSoftware: TLabel
    Left = 19
    Top = 46
    Width = 472
    Height = 112
    Alignment = taCenter
    Anchors = [akTop]
    AutoSize = False
    Caption = 'FuturixImager'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -48
    Font.Name = 'Arial'
    Font.Style = []
    GlowSize = 10
    ParentFont = False
  end
end
