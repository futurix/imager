object fraOptDisplay: TfraOptDisplay
  Left = 0
  Top = 0
  Width = 503
  Height = 414
  TabOrder = 0
  DesignSize = (
    503
    414)
  object lblDisplay: TLabel
    Left = 0
    Top = 3
    Width = 41
    Height = 13
    Caption = 'Display'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblBgStyle: TLabel
    Left = 20
    Top = 45
    Width = 86
    Height = 13
    Caption = 'Background style:'
  end
  object lblColors: TLabel
    Left = 0
    Top = 91
    Width = 35
    Height = 13
    Caption = 'Colors'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblColorBg: TLabel
    Left = 20
    Top = 110
    Width = 60
    Height = 13
    Caption = 'Background:'
  end
  object lblColorGradient: TLabel
    Left = 151
    Top = 110
    Width = 45
    Height = 13
    Caption = 'Gradient:'
  end
  object lblColorFs: TLabel
    Left = 282
    Top = 110
    Width = 55
    Height = 13
    Caption = 'Full screen:'
  end
  object cbxHQFilter: TCheckBox
    Left = 20
    Top = 22
    Width = 460
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Use high quality slow display filter'
    TabOrder = 0
  end
  object cmbBgStyle: TComboBox
    Left = 20
    Top = 64
    Width = 200
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    Items.Strings = (
      'Gradient'
      'Solid color'
      'System default'
      'Box pattern'
      'Diagonal pattern')
  end
  object sbxColorBg: TScrollBox
    Left = 20
    Top = 129
    Width = 125
    Height = 25
    Cursor = crHandPoint
    Hint = 'Click here to choose color'
    BevelKind = bkFlat
    BorderStyle = bsNone
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = sbxColorBgClick
  end
  object sbxColorFs: TScrollBox
    Left = 282
    Top = 129
    Width = 125
    Height = 25
    Cursor = crHandPoint
    Hint = 'Click here to choose color'
    BevelKind = bkFlat
    BorderStyle = bsNone
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = sbxColorFsClick
  end
  object sbxColorGradient: TScrollBox
    Left = 151
    Top = 129
    Width = 125
    Height = 25
    Cursor = crHandPoint
    Hint = 'Click here to choose color'
    BevelKind = bkFlat
    BorderStyle = bsNone
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = sbxColorGradientClick
  end
end
