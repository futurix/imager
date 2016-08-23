object frmOptLang: TfrmOptLang
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Languages'
  ClientHeight = 217
  ClientWidth = 370
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
  object lblLocale: TLabel
    Left = 10
    Top = 10
    Width = 100
    Height = 13
    Caption = 'Selected localization:'
    FocusControl = cbxLanguages
    Transparent = True
  end
  object lblGetLocales: TLabel
    Left = 10
    Top = 185
    Width = 116
    Height = 13
    Cursor = crHandPoint
    Caption = 'Get more localizations...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = [fsUnderline]
    ParentFont = False
    Transparent = True
    OnClick = lblGetLocalesClick
  end
  object lblLocaleInfo: TLabel
    Left = 10
    Top = 60
    Width = 350
    Height = 110
    AutoSize = False
    ShowAccelChar = False
    Transparent = True
    WordWrap = True
  end
  object btnOK: TButton
    Left = 205
    Top = 181
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 285
    Top = 181
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object cbxLanguages: TComboBox
    Left = 10
    Top = 25
    Width = 350
    Height = 21
    AutoComplete = False
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    OnChange = cbxLanguagesChange
  end
end
