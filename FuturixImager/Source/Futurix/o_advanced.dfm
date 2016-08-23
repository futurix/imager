object fraOptAdvanced: TfraOptAdvanced
  Left = 0
  Top = 0
  Width = 503
  Height = 414
  TabOrder = 0
  object lblDisplayQuality: TLabel
    Left = 0
    Top = 3
    Width = 84
    Height = 13
    Caption = 'Display Quality'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblFilter: TLabel
    Left = 20
    Top = 22
    Width = 121
    Height = 13
    Caption = 'High quality display filter:'
  end
  object lblControls: TLabel
    Left = 0
    Top = 91
    Width = 81
    Height = 13
    Caption = 'Input Controls'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblWarning: TLabel
    AlignWithMargins = True
    Left = 0
    Top = 401
    Width = 503
    Height = 13
    Margins.Left = 0
    Margins.Top = 2
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alBottom
    Caption = 
      'Warning: selection of certain options on this page may lead to d' +
      'ecrease in application performance.'
    WordWrap = True
    ExplicitWidth = 477
  end
  object lblReset: TLabel
    Left = 0
    Top = 133
    Width = 174
    Height = 13
    Caption = 'Reset advanced settings to defaults'
    OnClick = lblResetClick
  end
  object cmbFilter: TComboBox
    Left = 20
    Top = 41
    Width = 200
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    Items.Strings = (
      'Fast linear'
      'Linear'
      'Triangle'
      'Bicubic'
      'Bilinear'
      'Nearest neighbour'
      'B-spline'
      'Mitchell'
      'Bell'
      'Hermite'
      'Lanczos 3'
      'White on black drawing'
      'Black on white drawing')
  end
  object cbxDelayFilter: TCheckBox
    Left = 20
    Top = 68
    Width = 460
    Height = 17
    Caption = 'Delay application of display filter on scrolling'
    TabOrder = 1
  end
  object cbxReverseWheel: TCheckBox
    Left = 20
    Top = 110
    Width = 460
    Height = 17
    Caption = 'Reverse direction of mouse wheel'
    TabOrder = 2
  end
end
