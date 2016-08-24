object fraOptPlugins: TfraOptPlugins
  Left = 0
  Top = 0
  Width = 475
  Height = 452
  TabOrder = 0
  object btmScanPlugins: TButton
    Left = 3
    Top = 3
    Width = 156
    Height = 25
    Caption = 'Scan for new plugins'
    TabOrder = 0
    OnClick = btmScanPluginsClick
  end
  object btnFormats: TButton
    Left = 3
    Top = 34
    Width = 156
    Height = 25
    Caption = 'File format associations'
    ElevationRequired = True
    TabOrder = 1
    OnClick = btnFormatsClick
  end
end
