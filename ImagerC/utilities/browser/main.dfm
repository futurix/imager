object frmMain: TfrmMain
  Left = 192
  Top = 107
  Width = 607
  Height = 461
  Caption = 'Futuris File Browser'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object splMain: TSplitter
    Left = 185
    Top = 0
    Width = 3
    Height = 434
    Cursor = crHSplit
    ResizeStyle = rsUpdate
    OnMoved = splMainMoved
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 434
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object splPreview: TSplitter
      Left = 0
      Top = 246
      Width = 185
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ResizeStyle = rsUpdate
      OnMoved = splPreviewMoved
    end
    object pnlPreview: TPanel
      Left = 0
      Top = 249
      Width = 185
      Height = 185
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'No preview available.'
      TabOrder = 0
      object imgPreview: TImage
        Left = 3
        Top = 0
        Width = 182
        Height = 185
        Align = alClient
      end
      object pnlSpacer: TPanel
        Left = 0
        Top = 0
        Width = 3
        Height = 185
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
    object etvMain: TExplorerTreeview
      Left = 0
      Top = 0
      Width = 185
      Height = 246
      Active = True
      Align = alClient
      BorderStyle = bsSingle
      ColumnDetails = cdUser
      DefaultNodeHeight = 17
      DragHeight = 250
      DragWidth = 150
      FileObjects = [foFolders, foHidden]
      FileSizeFormat = fsfExplorer
      FileSort = fsFileType
      Header.AutoSizeIndex = 0
      Header.Columns = <>
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'MS Sans Serif'
      Header.Font.Style = []
      Header.MainColumn = -1
      Header.Options = [hoColumnResize, hoDrag]
      Header.Style = hsXPStyle
      HintAnimation = hatFade
      IncrementalSearchDirection = sdForward
      ParentColor = False
      ParentShowHint = False
      RootFolder = rfDrives
      ShowHint = True
      TabOrder = 1
      TabStop = True
      TreeOptions.AutoOptions = [toAutoScroll]
      TreeOptions.MiscOptions = [toToggleOnDblClick]
      TreeOptions.PaintOptions = [toShowButtons, toShowTreeLines, toUseBlendedImages]
      TreeOptions.SelectionOptions = [toMultiSelect, toRightClickSelect, toSiblingSelectConstraint]
      TreeOptions.VETShellOptions = [toContextMenus, toShellHints]
      TreeOptions.VETSyncOptions = [toCollapseTargetFirst, toExpandTarget, toSelectTarget]
      TreeOptions.VETMiscOptions = [toChangeNotifierThread]
      TreeOptions.VETImageOptions = [toImages, toThreadedImages]
      VirtualExplorerListview = elwMain
      WideDefaultText = 'Node'
    end
  end
  object elwMain: TExplorerListview
    Left = 188
    Top = 0
    Width = 411
    Height = 434
    Active = True
    Align = alClient
    BorderStyle = bsSingle
    ColumnDetails = cdUser
    ColumnMenuItemCount = 8
    DefaultNodeHeight = 17
    DragHeight = 250
    DragWidth = 150
    FileObjects = [foFolders, foNonFolders, foHidden]
    FileSizeFormat = fsfExplorer
    FileSort = fsFileType
    Header.AutoSizeIndex = 0
    Header.Columns = <>
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'MS Sans Serif'
    Header.Font.Style = []
    Header.MainColumn = -1
    Header.Style = hsXPStyle
    HintAnimation = hatFade
    IncrementalSearchDirection = sdForward
    Indent = 0
    ParentColor = False
    ParentShowHint = False
    RootFolder = rfDrives
    ShowHint = True
    TabOrder = 1
    TabStop = True
    TreeOptions.AutoOptions = [toAutoScroll]
    TreeOptions.MiscOptions = [toToggleOnDblClick]
    TreeOptions.PaintOptions = [toShowButtons, toShowTreeLines, toThemeAware, toUseBlendedImages]
    TreeOptions.SelectionOptions = [toMultiSelect, toRightClickSelect, toSiblingSelectConstraint]
    TreeOptions.StringOptions = [toSaveCaptions]
    TreeOptions.VETFolderOptions = [toHideRootFolder, toForceHideRecycleBin]
    TreeOptions.VETShellOptions = [toShellHints]
    TreeOptions.VETSyncOptions = [toCollapseTargetFirst, toExpandTarget, toSelectTarget]
    TreeOptions.VETMiscOptions = [toChangeNotifierThread]
    TreeOptions.VETImageOptions = [toImages, toThreadedImages]
    VirtualExplorerTreeview = etvMain
    OnClick = elwMainClick
    OnDblClick = elwMainDblClick
    WideDefaultText = 'Node'
  end
end
