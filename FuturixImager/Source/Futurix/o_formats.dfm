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
  object btnFormats: TButton
    Left = 304
    Top = 23
    Width = 200
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Set file format associations'
    ElevationRequired = True
    TabOrder = 1
    OnClick = btnFormatsClick
  end
end
