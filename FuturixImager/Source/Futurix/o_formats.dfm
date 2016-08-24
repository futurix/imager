object fraOptFormats: TfraOptFormats
  Left = 0
  Top = 0
  Width = 503
  Height = 414
  TabOrder = 0
  DesignSize = (
    503
    414)
  object cbxRare: TCheckBox
    Left = 0
    Top = 0
    Width = 500
    Height = 17
    Caption = 
      'Allow registration of rare or incompletely supported file format' +
      's'
    TabOrder = 0
  end
  object cbxUpdateOnScan: TCheckBox
    Left = 0
    Top = 23
    Width = 500
    Height = 17
    Caption = 'Automatically update system information on every plug-in scan'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object btnFormats: TButton
    Left = 304
    Top = 46
    Width = 200
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Set file format associations'
    ElevationRequired = True
    TabOrder = 2
    OnClick = btnFormatsClick
  end
end
