object frmMain: TfrmMain
  Left = 190
  Top = 79
  Width = 750
  Height = 550
  ActiveControl = img
  Caption = 'Futuris Imager'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg'
  Font.Style = []
  KeyPreview = True
  Menu = mnuMain
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object sbxMain: TScrollBox
    Left = 0
    Top = 30
    Width = 742
    Height = 455
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Align = alClient
    Color = clAppWorkSpace
    ParentColor = False
    PopupMenu = popMain
    TabOrder = 0
    object img: TImageEnView
      Left = 0
      Top = 0
      Width = 738
      Height = 451
      Cursor = crDefault
      Background = clAppWorkSpace
      ParentCtl3D = False
      BorderStyle = bsNone
      LegacyBitmap = False
      MouseInteract = [miScroll]
      EnableAlphaChannel = True
      ImageEnVersion = '2.1.9_beta'
      FlatScrollBars = True
      Align = alClient
      PopupMenu = popMain
      TabOrder = 0
    end
  end
  object sbrMain: TStatusBar
    Left = 0
    Top = 485
    Width = 742
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Width = 75
      end
      item
        Width = 50
      end>
    PopupMenu = popBars
  end
  object tbrMain: TCoolBar
    Left = 0
    Top = 0
    Width = 742
    Height = 30
    AutoSize = True
    BandBorderStyle = bsNone
    BandMaximize = bmNone
    Bands = <
      item
        Control = itbMain
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 28
        Width = 742
      end>
    EdgeBorders = [ebTop]
    FixedOrder = True
    ShowText = False
    object itbMain: TToolBar
      Left = 0
      Top = 0
      Width = 738
      Height = 28
      AutoSize = True
      BorderWidth = 1
      ButtonHeight = 24
      Caption = 'Main'
      DisabledImages = imlDisabled
      EdgeBorders = []
      Flat = True
      HideClippedButtons = True
      Images = imlMain
      PopupMenu = popBars
      TabOrder = 0
      Transparent = True
      Wrapable = False
      object tbnOpen: TToolButton
        Left = 0
        Top = 0
        Hint = 'Open|Open new image'
        AutoSize = True
        Caption = 'Open'
        DropdownMenu = popMRU
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        Style = tbsDropDown
        OnClick = miOpenClick
      end
      object tbnLast: TToolButton
        Left = 36
        Top = 0
        Hint = 'Last Image|Load last image'
        AutoSize = True
        Caption = 'Last'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnLastClick
      end
      object tbnSave: TToolButton
        Left = 59
        Top = 0
        Hint = 'Save as...|Save image in variety of formats'
        AutoSize = True
        Caption = 'Save'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = miSaveAsClick
      end
      object tbnClose: TToolButton
        Left = 82
        Top = 0
        Hint = 'Close|Close image'
        AutoSize = True
        Caption = 'Close'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = miCloseClick
      end
      object Sep_1: TToolButton
        Left = 105
        Top = 0
        Width = 8
        Caption = 'Sep_1'
        ImageIndex = 1
        Style = tbsSeparator
      end
      object tbnPrint: TToolButton
        Left = 113
        Top = 0
        Hint = 'Print|Print image (hold SHIFT to skip preview)'
        AutoSize = True
        Caption = 'Print'
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnPrintClick
      end
      object Sep_2: TToolButton
        Left = 136
        Top = 0
        Width = 8
        Caption = 'Sep_2'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object tbnCopy: TToolButton
        Left = 144
        Top = 0
        Hint = 'Copy|Copy image to clipboard'
        AutoSize = True
        Caption = 'Copy'
        ImageIndex = 5
        ParentShowHint = False
        ShowHint = True
        OnClick = miCopyClick
      end
      object tbnPaste: TToolButton
        Left = 167
        Top = 0
        Hint = 'Paste|Paste from clipboard'
        AutoSize = True
        Caption = 'Paste'
        Enabled = False
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        OnClick = miPasteClick
      end
      object Sep_12: TToolButton
        Left = 190
        Top = 0
        Width = 8
        Caption = 'Sep_12'
        ImageIndex = 24
        Style = tbsSeparator
      end
      object tbnFilters: TToolButton
        Left = 198
        Top = 0
        Hint = 'Filters|Transform image using filters'
        Caption = 'Filters'
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        OnClick = miFiltersDialogClick
      end
      object tbnUndo: TToolButton
        Left = 221
        Top = 0
        Hint = 'Undo|Restores previous image state'
        AutoSize = True
        Caption = 'Undo'
        Enabled = False
        ImageIndex = 18
        ParentShowHint = False
        ShowHint = True
        OnClick = miUndoClick
      end
      object Sep_3: TToolButton
        Left = 244
        Top = 0
        Width = 8
        Caption = 'Sep_3'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object tbnZoomIn: TToolButton
        Left = 252
        Top = 0
        Hint = 'Zoom In|Zoom in by 50%'
        AutoSize = True
        Caption = 'Zoom In'
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        OnClick = miZoomInClick
      end
      object tbnZoomOut: TToolButton
        Left = 275
        Top = 0
        Hint = 'Zoom Out|Zoom out by 50%'
        AutoSize = True
        Caption = 'Zoom Out'
        ImageIndex = 9
        ParentShowHint = False
        ShowHint = True
        OnClick = miZoomOutClick
      end
      object tbnZoomMisc: TToolButton
        Left = 298
        Top = 0
        Hint = 'Zoom|Set image zoom'
        AutoSize = True
        Caption = 'Zoom'
        DropdownMenu = popZoom
        ImageIndex = 10
        ParentShowHint = False
        ShowHint = True
        Style = tbsDropDown
      end
      object Sep_16: TToolButton
        Left = 334
        Top = 0
        Width = 8
        ImageIndex = 16
        Style = tbsSeparator
      end
      object tbnRotate: TToolButton
        Left = 342
        Top = 0
        Hint = 'Rotate|Rotate image 90 degrees clockwise'
        AutoSize = True
        Caption = 'Rotate'
        ImageIndex = 20
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnRotateClick
      end
      object Sep_17: TToolButton
        Left = 365
        Top = 0
        Width = 8
        ImageIndex = 16
        Style = tbsSeparator
      end
      object tbnDisp: TToolButton
        Left = 373
        Top = 0
        Hint = 
          'Display Options|Toggles between display modes (click arrow to ge' +
          't the menu with additional options)'
        AutoSize = True
        Caption = 'Display'
        DropdownMenu = popDisp
        ImageIndex = 19
        ParentShowHint = False
        ShowHint = True
        Style = tbsDropDown
        OnClick = tbnDispClick
      end
      object tbnFullScreen: TToolButton
        Left = 409
        Top = 0
        Hint = 'Full Screen|Switch to full screen mode'
        AutoSize = True
        Caption = 'FullScreen'
        ImageIndex = 11
        ParentShowHint = False
        ShowHint = True
        OnClick = miFullScreenClick
      end
      object Sep_7: TToolButton
        Left = 432
        Top = 0
        Width = 8
        Caption = 'Sep_7'
        ImageIndex = 20
        Style = tbsSeparator
      end
      object tbnMultiPrev: TToolButton
        Left = 440
        Top = 0
        Hint = 'Previous Page|Go to previous page'
        AutoSize = True
        Caption = 'Previous'
        Enabled = False
        ImageIndex = 17
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnMultiPrevClick
      end
      object tbnMultiNext: TToolButton
        Left = 463
        Top = 0
        Hint = 'Next Page|Go to next page'
        AutoSize = True
        Caption = 'Next'
        Enabled = False
        ImageIndex = 16
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnMultiNextClick
      end
      object Sep_8: TToolButton
        Left = 486
        Top = 0
        Width = 8
        Caption = 'Sep_8'
        ImageIndex = 24
        Style = tbsSeparator
      end
      object tbnInfo: TToolButton
        Left = 494
        Top = 0
        Hint = 'File Info|View file information'
        AutoSize = True
        Caption = 'Info'
        ImageIndex = 12
        ParentShowHint = False
        ShowHint = True
        OnClick = miInfoClick
      end
      object Sep_9: TToolButton
        Left = 517
        Top = 0
        Width = 8
        Caption = 'Sep_9'
        ImageIndex = 26
        Style = tbsSeparator
      end
      object tbnGoRandom: TToolButton
        Left = 525
        Top = 0
        Hint = 'Random File|Go to random image in current folder'
        AutoSize = True
        Caption = 'Random File'
        ImageIndex = 14
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoRandomClick
      end
      object Sep_14: TToolButton
        Left = 548
        Top = 0
        Width = 8
        ImageIndex = 16
        Style = tbsSeparator
      end
      object tbnGoBack: TToolButton
        Left = 556
        Top = 0
        Hint = 
          'Back|Go to previous image in current folder (hold SHIFT to jump ' +
          'to first image in folder)'
        AutoSize = True
        Caption = 'Back'
        ImageIndex = 13
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoBackClick
      end
      object tbnGoForward: TToolButton
        Left = 579
        Top = 0
        Hint = 
          'Forward|Go to next image in current folder (hold SHIFT to jump t' +
          'o last image in folder)'
        AutoSize = True
        Caption = 'Forward'
        ImageIndex = 15
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoForwardClick
      end
    end
  end
  object mnuMain: TMainMenu
    Left = 444
    Top = 159
    object mFile: TMenuItem
      Caption = 'File'
      object miOpen: TMenuItem
        Caption = 'Open...'
        Hint = 'Open new image...'
        ShortCut = 16463
        OnClick = miOpenClick
      end
      object mRecent: TMenuItem
        Caption = 'Open Recent'
        object NRecent: TMenuItem
          Caption = '-'
        end
      end
      object miReopen: TMenuItem
        Caption = 'Reopen'
        Hint = 'Reload current image'
        ShortCut = 116
        OnClick = miReopenClick
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object miNew: TMenuItem
        Caption = 'New Image...'
        Hint = 'Create new empty image'
        ShortCut = 16462
        OnClick = miNewClick
      end
      object miSaveAs: TMenuItem
        Caption = 'Save As...'
        Hint = 'Save image as...'
        ShortCut = 16467
        OnClick = miSaveAsClick
      end
      object miClose: TMenuItem
        Caption = 'Close'
        Hint = 'Close current image'
        ShortCut = 16472
        OnClick = miCloseClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mImport: TMenuItem
        Caption = 'Import'
        Enabled = False
      end
      object mExport: TMenuItem
        Caption = 'Export'
        Enabled = False
      end
      object N14: TMenuItem
        Caption = '-'
      end
      object miInfo: TMenuItem
        Caption = 'File Information'
        Hint = 'Show file information panel'
        ShortCut = 16457
        OnClick = miInfoClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object miPrint: TMenuItem
        Caption = 'Print'
        Hint = 'Print current image'
        OnClick = miPrintClick
      end
      object miPrintPreview: TMenuItem
        Caption = 'Print Preview...'
        Hint = 'Print image with result preview'
        ShortCut = 16464
        OnClick = miPrintPreviewClick
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object miExit: TMenuItem
        Caption = 'Exit'
        Hint = 'Exit Futuris Imager'
        ShortCut = 27
        OnClick = miExitClick
      end
    end
    object mEdit: TMenuItem
      Caption = 'Edit'
      object miUndo: TMenuItem
        Caption = 'Undo'
        Hint = 'Restores previous image state'
        ShortCut = 16474
        OnClick = miUndoClick
      end
      object N11: TMenuItem
        Caption = '-'
        Visible = False
      end
      object miCopy: TMenuItem
        Caption = 'Copy'
        Hint = 'Copy to ClipBoard'
        ShortCut = 16451
        OnClick = miCopyClick
      end
      object miPaste: TMenuItem
        Caption = 'Paste'
        Hint = 'Paste from ClipBoard'
        ShortCut = 16470
        OnClick = miPasteClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object miFiltersDialog: TMenuItem
        Caption = 'Filters...'
        Hint = 'Full list of filters'
        ShortCut = 16454
        OnClick = miFiltersDialogClick
      end
    end
    object mView: TMenuItem
      Caption = 'View'
      object mToolbars: TMenuItem
        Caption = 'Toolbars'
        object miToolbar: TMenuItem
          Caption = 'Toolbar'
          Hint = 'Toggles Imager'#39's toolbar'
          OnClick = miToolbarClick
        end
        object miStatusBar: TMenuItem
          Caption = 'Status Bar'
          Hint = 'Toggles status bar'
          OnClick = miStatusBarClick
        end
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object mDisplayStyle: TMenuItem
        Caption = 'Display Style'
        object miDSNormal: TMenuItem
          Caption = 'Normal'
          RadioItem = True
          OnClick = miDSNormalClick
        end
        object miDSFit: TMenuItem
          Caption = 'Fit'
          RadioItem = True
          OnClick = miDSFitClick
        end
        object N18: TMenuItem
          Caption = '-'
        end
        object miDSCenterImage: TMenuItem
          Caption = 'Center Image'
          OnClick = miDSCenterImageClick
        end
        object miDSScrollbars: TMenuItem
          Caption = 'Show Scrollbars'
          OnClick = miDSScrollbarsClick
        end
      end
      object mZoom: TMenuItem
        Caption = 'Zoom'
        Hint = 'Select image zoom'
        object miZoomIn: TMenuItem
          Caption = 'Zoom In'
          Hint = 'Zoom in by 50%'
          OnClick = miZoomInClick
        end
        object miZoomOut: TMenuItem
          Caption = 'Zoom Out'
          Hint = 'Zoom out by 50%'
          OnClick = miZoomOutClick
        end
        object N21: TMenuItem
          Caption = '-'
        end
        object miZM6: TMenuItem
          Caption = '6%'
          OnClick = miZM6Click
        end
        object miZM12: TMenuItem
          Caption = '12%'
          OnClick = miZM12Click
        end
        object miZM25: TMenuItem
          Caption = '25%'
          OnClick = miZM25Click
        end
        object miZM50: TMenuItem
          Caption = '50%'
          ShortCut = 16437
          OnClick = miZM50Click
        end
        object miZM75: TMenuItem
          Caption = '75%'
          OnClick = miZM75Click
        end
        object miZM100: TMenuItem
          Caption = '100%'
          Hint = 'Revert to original zoom'
          ShortCut = 16433
          OnClick = miZM100Click
        end
        object miZM150: TMenuItem
          Caption = '150%'
          OnClick = miZM150Click
        end
        object miZM200: TMenuItem
          Caption = '200%'
          ShortCut = 16434
          OnClick = miZM200Click
        end
        object miZM400: TMenuItem
          Caption = '400%'
          OnClick = miZM400Click
        end
        object N10: TMenuItem
          Caption = '-'
        end
        object miZmFit: TMenuItem
          Caption = 'Zoom to Fit'
          OnClick = miZmFitClick
        end
        object miZmWidth: TMenuItem
          Caption = 'Zoom to Width'
          OnClick = miZmWidthClick
        end
        object miZmHeight: TMenuItem
          Caption = 'Zoom to Height'
          OnClick = miZmHeightClick
        end
        object N8: TMenuItem
          Caption = '-'
        end
        object miRotateView: TMenuItem
          Caption = 'Rotate View CW'
          ShortCut = 16466
          Visible = False
          OnClick = miRotateViewClick
        end
        object miRotateViewCCW: TMenuItem
          Caption = 'Rotate View CCW'
          ShortCut = 24658
          Visible = False
          OnClick = miRotateViewCCWClick
        end
        object miZMCustom: TMenuItem
          Caption = 'Custom...'
          Hint = 'Set custom zoom'
          ShortCut = 16576
          OnClick = miZMCustomClick
        end
      end
      object mMulti: TMenuItem
        Caption = 'Multi-page Image'
        Visible = False
        object miMultiFirst: TMenuItem
          Caption = 'First'
          OnClick = tbnMultiFirstClick
        end
        object miMultiPrevious: TMenuItem
          Caption = 'Previous'
          OnClick = tbnMultiPrevClick
        end
        object miMultiNext: TMenuItem
          Caption = 'Next'
          OnClick = tbnMultiNextClick
        end
        object miMultiLast: TMenuItem
          Caption = 'Last'
          OnClick = tbnMultiLastClick
        end
        object N24: TMenuItem
          Caption = '-'
        end
        object miMultiGoTo: TMenuItem
          Caption = 'Go To'
          OnClick = tbnGoToPageClick
        end
        object miMultiExtract: TMenuItem
          Caption = 'Extract Page'
          OnClick = tbnExtractPageClick
        end
      end
      object mAnim: TMenuItem
        Caption = 'Animation'
        Visible = False
        object miAnimPlay: TMenuItem
          Caption = 'Play'
          OnClick = tbnPlayClick
        end
        object miAnimPause: TMenuItem
          Caption = 'Pause'
          OnClick = tbnPauseClick
        end
        object miAnimStop: TMenuItem
          Caption = 'Stop'
          OnClick = tbnStopClick
        end
      end
      object N34: TMenuItem
        Caption = '-'
      end
      object miShow: TMenuItem
        Caption = 'Slide Show'
        Hint = 'Slide Show'
        ShortCut = 117
        OnClick = miShowClick
      end
      object miStartSlideShow: TMenuItem
        Caption = 'Start Slide Show'
        Hint = 'Start slide show immediately'
        ShortCut = 118
        OnClick = miStartSlideShowClick
      end
      object N29: TMenuItem
        Caption = '-'
      end
      object miFullScreen: TMenuItem
        Caption = 'Full Screen'
        Hint = 'Toggle fullscreen mode'
        ShortCut = 122
        OnClick = miFullScreenClick
      end
    end
    object mGo: TMenuItem
      Caption = 'Go'
      object miGoBack: TMenuItem
        Caption = 'Back'
        Hint = 'Go to previous image in current folder'
        OnClick = miGoBackClick
      end
      object miGoForward: TMenuItem
        Caption = 'Forward'
        Hint = 'Go to next image in current folder'
        OnClick = miGoForwardClick
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object miGoFirst: TMenuItem
        Caption = 'First'
        Hint = 'Go to the first image in current folder'
        OnClick = miGoFirstClick
      end
      object miGoLast: TMenuItem
        Caption = 'Last'
        Hint = 'Go to the last image in current folder'
        OnClick = miGoLastClick
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object miGoRandom: TMenuItem
        Caption = 'Random'
        Hint = 'Go to random image in current folder'
        ShortCut = 115
        OnClick = miGoRandomClick
      end
      object N17: TMenuItem
        Caption = '-'
      end
      object miFCopy: TMenuItem
        Caption = 'Copy File'
        Hint = 'Copy current file'
        OnClick = miFCopyClick
      end
      object miFDelete: TMenuItem
        Caption = 'Delete File'
        Hint = 'Delete current file'
        OnClick = miFDeleteClick
      end
      object miFMove: TMenuItem
        Caption = 'Move File'
        Hint = 'Move current file'
        OnClick = miFMoveClick
      end
      object miFRename: TMenuItem
        Caption = 'Rename File'
        Hint = 'Rename current file'
        OnClick = miFRenameClick
      end
    end
    object mTools: TMenuItem
      Caption = 'Tools'
      object miSettings: TMenuItem
        Tag = 7
        Caption = 'Preferences...'
        Hint = 'Configure Futuris Imager the way you like'
        OnClick = miSettingsClick
      end
    end
    object mHelp: TMenuItem
      Caption = 'Help'
      object miHelpContents: TMenuItem
        Caption = 'Help Contents'
        Hint = 'Help contents'
        ShortCut = 112
        OnClick = miHelpContentsClick
      end
      object miFuturisWebSite: TMenuItem
        Caption = 'Futuris Imager Website'
        Hint = 'Leads you to Futuris website'
        OnClick = miFuturisWebSiteClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object miAbout: TMenuItem
        Caption = 'About...'
        Hint = 'About Futuris Imager'
        ShortCut = 16496
        OnClick = miAboutClick
      end
    end
  end
  object popMain: TPopupMenu
    Left = 475
    Top = 159
    object piBack: TMenuItem
      Caption = 'Back'
      OnClick = miGoBackClick
    end
    object piForward: TMenuItem
      Caption = 'Forward'
      OnClick = miGoForwardClick
    end
    object N22: TMenuItem
      Caption = '-'
    end
    object piOpen: TMenuItem
      Caption = 'Open'
      OnClick = miOpenClick
    end
    object piClose: TMenuItem
      Caption = 'Close'
      OnClick = miCloseClick
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object pAnim: TMenuItem
      Caption = 'Animation'
      Visible = False
      object piAnimPlay: TMenuItem
        Caption = 'Play'
        OnClick = tbnPlayClick
      end
      object piAnimPause: TMenuItem
        Caption = 'Pause'
        OnClick = tbnPauseClick
      end
      object piAnimStop: TMenuItem
        Caption = 'Stop'
        OnClick = tbnStopClick
      end
    end
    object pMulti: TMenuItem
      Caption = 'Multi-Page'
      Visible = False
      object piMultiFirst: TMenuItem
        Caption = 'First'
        OnClick = tbnMultiFirstClick
      end
      object piMultiPrevious: TMenuItem
        Caption = 'Previous'
        OnClick = tbnMultiPrevClick
      end
      object piMultiNext: TMenuItem
        Caption = 'Next'
        OnClick = tbnMultiNextClick
      end
      object piMultiLast: TMenuItem
        Caption = 'Last'
        OnClick = tbnMultiLastClick
      end
      object N26: TMenuItem
        Caption = '-'
      end
      object piMultiGoTo: TMenuItem
        Caption = 'Go To'
        OnClick = tbnGoToPageClick
      end
      object piMultiExtract: TMenuItem
        Caption = 'Extract'
        OnClick = tbnExtractPageClick
      end
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object piMinimize: TMenuItem
      Caption = 'Minimize'
      Visible = False
      OnClick = piMinimizeClick
    end
    object piFullScreen: TMenuItem
      Caption = 'Full Screen'
      OnClick = miFullScreenClick
    end
  end
  object popZoom: TPopupMenu
    Left = 506
    Top = 159
    object piZmFit: TMenuItem
      Caption = 'Zoom to Fit'
      OnClick = miZmFitClick
    end
    object piZmWidth: TMenuItem
      Caption = 'Zoom to Width'
      OnClick = miZmWidthClick
    end
    object piZmHeight: TMenuItem
      Caption = 'Zoom to Height'
      OnClick = miZmHeightClick
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object piZM6: TMenuItem
      Caption = '6%'
      OnClick = miZM6Click
    end
    object piZM12: TMenuItem
      Caption = '12%'
      OnClick = miZM12Click
    end
    object piZM25: TMenuItem
      Caption = '25%'
      OnClick = miZM25Click
    end
    object piZM50: TMenuItem
      Caption = '50%'
      OnClick = miZM50Click
    end
    object piZM75: TMenuItem
      Caption = '75%'
      OnClick = miZM75Click
    end
    object piZM100: TMenuItem
      Caption = '100%'
      OnClick = miZM100Click
    end
    object piZM150: TMenuItem
      Caption = '150%'
      OnClick = miZM150Click
    end
    object piZM200: TMenuItem
      Caption = '200%'
      OnClick = miZM200Click
    end
    object piZM400: TMenuItem
      Caption = '400%'
      OnClick = miZM400Click
    end
    object N25: TMenuItem
      Caption = '-'
    end
    object piZoomCustom: TMenuItem
      Caption = 'Custom Zoom'
      OnClick = miZMCustomClick
    end
  end
  object popBars: TPopupMenu
    Left = 537
    Top = 159
    object piTBMain: TMenuItem
      Caption = 'Main'
      OnClick = miToolbarClick
    end
    object piStatusBar: TMenuItem
      Caption = 'Status Bar'
      OnClick = miStatusBarClick
    end
  end
  object imlMain: TImageList
    Left = 444
    Top = 221
  end
  object MRU: TMRUFiles
    MenuItem = NRecent
    MaxEntries = 16
    Numbered = False
    OnClick = MRUClick
    Left = 444
    Top = 252
  end
  object dlgOpen: TFuturisOpenDialog
    Filter = 'All files (*.*)|*.*'
    Title = 'Open image ...'
    OnFolderChange = dlgOpenFolderChange
    ShowPlacesBar = True
    OnPreview = dlgOpenPreview
    Left = 444
    Top = 190
  end
  object dlgInstPlug: TOpenDialog
    DefaultExt = 'fzp'
    Filter = 'Futuris Imager Plug-in Packages (*.fzp)|*.fzp'
    Title = 'Select plug-in package to install ...'
    Left = 506
    Top = 190
  end
  object imlDisabled: TImageList
    Left = 475
    Top = 221
  end
  object popDisp: TPopupMenu
    Left = 569
    Top = 159
    object piDSNormal: TMenuItem
      Caption = 'Normal'
      RadioItem = True
      OnClick = miDSNormalClick
    end
    object piDSFit: TMenuItem
      Caption = 'Fit'
      RadioItem = True
      OnClick = miDSFitClick
    end
    object N23: TMenuItem
      Caption = '-'
    end
    object piDSCenterImage: TMenuItem
      Caption = 'Center Image'
      OnClick = miDSCenterImageClick
    end
    object piDSScrollbars: TMenuItem
      Caption = 'Show Scrollbars'
      OnClick = miDSScrollbarsClick
    end
  end
  object dlgSave: TSaveDialog
    Filter = 'All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save image as...'
    Left = 475
    Top = 190
  end
  object popMRU: TPopupMenu
    OnPopup = popMRUPopup
    Left = 601
    Top = 159
    object piMRU: TMenuItem
      Caption = 'MRU'
      Visible = False
    end
  end
  object MRUpop: TMRUFiles
    MenuItem = piMRU
    MaxEntries = 16
    Numbered = False
    OnClick = MRUpopClick
    Left = 475
    Top = 252
  end
  object popNoMRU: TPopupMenu
    Left = 633
    Top = 159
    object piMyOpen: TMenuItem
      Caption = 'Open...'
      OnClick = miOpenClick
    end
  end
end
