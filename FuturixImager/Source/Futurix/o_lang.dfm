object fraOptLang: TfraOptLang
  Left = 0
  Top = 0
  Width = 503
  Height = 414
  TabOrder = 0
  object lblSelect: TLabel
    Left = 0
    Top = 0
    Width = 80
    Height = 13
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Select language:'
  end
  object lblPreview: TLabel
    Left = 0
    Top = 38
    Width = 503
    Height = 376
    Align = alClient
    AutoSize = False
    WordWrap = True
    ExplicitLeft = 79
    ExplicitTop = 124
    ExplicitWidth = 48
    ExplicitHeight = 13
  end
  object cbxLangs: TComboBox
    AlignWithMargins = True
    Left = 0
    Top = 15
    Width = 503
    Height = 21
    Margins.Left = 0
    Margins.Top = 2
    Margins.Right = 0
    Margins.Bottom = 2
    Align = alTop
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 0
    OnSelect = cbxLangsSelect
  end
end
