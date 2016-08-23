object frmInstPlugs: TfrmInstPlugs
  Left = 192
  Top = 107
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Installed Plug-ins'
  ClientHeight = 235
  ClientWidth = 440
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
  object lblSelect: TLabel
    Left = 4
    Top = 4
    Width = 67
    Height = 13
    Caption = 'Select plug-in:'
    Transparent = True
  end
  object btnOK: TButton
    Left = 358
    Top = 205
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object lbxPlugs: TListBox
    Left = 4
    Top = 18
    Width = 134
    Height = 183
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
    OnClick = lbxPlugsClick
    OnKeyUp = lbxPlugsKeyUp
  end
  object gbxAbout: TGroupBox
    Left = 145
    Top = 13
    Width = 288
    Height = 188
    Caption = ' About plug-in '
    TabOrder = 2
    object lblNameVer: TLabel
      Left = 10
      Top = 18
      Width = 87
      Height = 13
      Caption = 'Name and Version'
      Transparent = True
    end
    object lblAuthor: TLabel
      Left = 10
      Top = 33
      Width = 31
      Height = 13
      Caption = 'Author'
      Transparent = True
    end
    object lblComments: TLabel
      Left = 10
      Top = 48
      Width = 52
      Height = 13
      Caption = 'Comments:'
      Transparent = True
    end
    object lblDLLnVer: TLabel
      Left = 10
      Top = 138
      Width = 20
      Height = 13
      Caption = 'DLL'
      Transparent = True
    end
    object lblTM: TLabel
      Left = 10
      Top = 168
      Width = 56
      Height = 13
      Caption = 'Trademarks'
      Transparent = True
    end
    object lblCopy: TLabel
      Left = 10
      Top = 153
      Width = 44
      Height = 13
      Caption = 'Copyright'
      Transparent = True
    end
    object memComments: TMemo
      Left = 10
      Top = 63
      Width = 268
      Height = 71
      Color = clBtnFace
      ReadOnly = True
      TabOrder = 0
    end
  end
  object fsrPlugs: TFileSearch
    OnFileFind = fsrPlugsFileFind
    Left = 11
    Top = 24
  end
  object verInfo: TdfsVersionInfoResource
    ShowResource = [pdCompanyName, pdFileDescription, pdFileVersion, pdInternalName, pdLegalCopyright, pdLegalTrademarks, pdOriginalFilename, pdProductName, pdProductVersion, pdComments, pdBuildFlags]
    Left = 42
    Top = 24
  end
end
