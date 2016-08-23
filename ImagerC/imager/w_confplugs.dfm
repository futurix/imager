object frmConfPlugs: TfrmConfPlugs
  Left = 192
  Top = 107
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Configure Plug-ins'
  ClientHeight = 273
  ClientWidth = 303
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblFollowing: TLabel
    Left = 5
    Top = 6
    Width = 257
    Height = 13
    Caption = 'Following plug-ins have settings, that can be changed:'
    Transparent = True
  end
  object btnOK: TButton
    Left = 223
    Top = 243
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object lbxPlugs: TListBox
    Left = 5
    Top = 20
    Width = 293
    Height = 218
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
    OnDblClick = lbxPlugsDblClick
  end
  object fsrConf: TFileSearch
    OnFileFind = fsrConfFileFind
    Left = 5
    Top = 241
  end
end
