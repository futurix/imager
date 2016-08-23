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
    object lblGetMore: TLabel
      Left = 0
      Top = 11
      Width = 84
      Height = 13
      Caption = 'Get More Plug-ins'
      ParentShowHint = False
      ShowHint = True
      OnClick = lblGetMoreClick
    end
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
      end>
    ColumnClick = False
    DoubleBuffered = True
    Groups = <
      item
        Header = 'Plug-ins'
        GroupID = 0
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
        ExtendedImage = -1
      end
      item
        Header = 'Themes'
        GroupID = 1
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
        ExtendedImage = -1
      end
      item
        Header = 'Icon Libraries'
        GroupID = 2
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
        ExtendedImage = -1
      end>
    HideSelection = False
    GroupView = True
    ReadOnly = True
    RowSelect = True
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowColumnHeaders = False
    ShowHint = True
    SmallImages = imlIcons
    SortType = stText
    TabOrder = 1
    ViewStyle = vsReport
    OnInfoTip = lvwPluginsInfoTip
  end
  object imlIcons: TImageList
    ColorDepth = cd32Bit
    Left = 452
    Top = 30
  end
end
