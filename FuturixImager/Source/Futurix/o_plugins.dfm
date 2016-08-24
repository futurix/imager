object fraOptPlugins: TfraOptPlugins
  Left = 0
  Top = 0
  Width = 503
  Height = 414
  TabOrder = 0
  object sbxCommands: TScrollBox
    Left = 0
    Top = 379
    Width = 503
    Height = 35
    Align = alBottom
    AutoScroll = False
    BorderStyle = bsNone
    TabOrder = 0
    DesignSize = (
      503
      35)
    object btnScanPlugins: TButton
      Left = 348
      Top = 6
      Width = 156
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Scan for new plugins'
      TabOrder = 0
      OnClick = btnScanPluginsClick
    end
  end
  object lvwPlugins: TListView
    Left = 0
    Top = 0
    Width = 503
    Height = 379
    Align = alClient
    Columns = <
      item
        Caption = 'File'
        Width = 150
      end
      item
        Caption = 'Name'
        Width = 275
      end>
    ColumnClick = False
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    SortType = stText
    TabOrder = 1
    ViewStyle = vsReport
  end
end
