object fraOptFormatsXP: TfraOptFormatsXP
  Left = 0
  Top = 0
  Width = 503
  Height = 414
  TabOrder = 0
  object lvwFormats: TListView
    Left = 0
    Top = 0
    Width = 503
    Height = 379
    Align = alClient
    Checkboxes = True
    Columns = <
      item
        Caption = 'Extension'
        Width = 100
      end
      item
        Caption = 'Description'
        Width = 375
      end>
    ColumnClick = False
    ReadOnly = True
    RowSelect = True
    SortType = stText
    TabOrder = 0
    ViewStyle = vsReport
  end
  object sbxCommands: TScrollBox
    Left = 0
    Top = 379
    Width = 503
    Height = 35
    Align = alBottom
    AutoScroll = False
    BorderStyle = bsNone
    TabOrder = 1
    DesignSize = (
      503
      35)
    object btnNone: TButton
      Left = 429
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'None'
      TabOrder = 0
      OnClick = btnNoneClick
    end
    object btnAll: TButton
      Left = 348
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'All'
      TabOrder = 1
      OnClick = btnAllClick
    end
    object cbxRare: TCheckBox
      Left = 0
      Top = 9
      Width = 335
      Height = 17
      Caption = 'Show rare formats'
      TabOrder = 2
      OnClick = cbxRareClick
    end
  end
end
