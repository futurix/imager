object frmMain: TfrmMain
  Left = 190
  Top = 105
  Width = 834
  Height = 635
  Caption = 'Futuris Imager'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = mnuMain
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  PixelsPerInch = 96
  TextHeight = 13
  object sbxMain: TScrollBox
    Left = 0
    Top = 26
    Width = 826
    Height = 496
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Align = alClient
    Color = clAppWorkSpace
    ParentColor = False
    PopupMenu = popMain
    TabOrder = 0
    OnContextPopup = sbxMainContextPopup
    object imgMain: TImage
      Left = 0
      Top = 0
      Width = 0
      Height = 0
      AutoSize = True
      IncrementalDisplay = True
      PopupMenu = popMain
      OnContextPopup = imgMainContextPopup
      OnMouseDown = imgMainMouseDown
      OnMouseMove = imgMainMouseMove
    end
  end
  object sbrMain: TStatusBar
    Left = 0
    Top = 570
    Width = 826
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Width = 50
      end
      item
        Width = 50
      end>
    PopupMenu = popBars
  end
  object tbrMain: TCoolBar
    Left = 0
    Top = 0
    Width = 826
    Height = 26
    AutoSize = True
    BandBorderStyle = bsNone
    BandMaximize = bmNone
    Bands = <
      item
        Control = itbMain
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 24
        Width = 826
      end>
    EdgeBorders = [ebTop]
    FixedOrder = True
    ShowText = False
    object itbMain: TToolBar
      Left = 0
      Top = 0
      Width = 822
      Height = 24
      AutoSize = True
      ButtonHeight = 24
      ButtonWidth = 26
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
        Caption = 'Open'
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        OnClick = miOpenClick
      end
      object tbnLast: TToolButton
        Left = 26
        Top = 0
        Hint = 'Last Image|Load last image'
        Caption = 'Last'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnLastClick
      end
      object tbnSave: TToolButton
        Left = 52
        Top = 0
        Hint = 'Save as...|Save image in variety of formats'
        Caption = 'Save'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = miSaveAsClick
      end
      object tbnClose: TToolButton
        Left = 78
        Top = 0
        Hint = 'Close|Close image'
        Caption = 'Close'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = miCloseClick
      end
      object Sep_1: TToolButton
        Left = 104
        Top = 0
        Width = 8
        Caption = 'Sep_1'
        ImageIndex = 1
        Style = tbsSeparator
      end
      object tbnPrint: TToolButton
        Left = 112
        Top = 0
        Hint = 'Print|Print image (hold SHIFT to skip preview)'
        Caption = 'Print'
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnPrintClick
      end
      object Sep_2: TToolButton
        Left = 138
        Top = 0
        Width = 8
        Caption = 'Sep_2'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object tbnCopy: TToolButton
        Left = 146
        Top = 0
        Hint = 'Copy|Copy image to clipboard'
        Caption = 'Copy'
        ImageIndex = 5
        ParentShowHint = False
        ShowHint = True
        OnClick = miCopyClick
      end
      object tbnPaste: TToolButton
        Left = 172
        Top = 0
        Hint = 'Paste|Paste from clipboard'
        Caption = 'Paste'
        Enabled = False
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        OnClick = miPasteClick
      end
      object Sep_12: TToolButton
        Left = 198
        Top = 0
        Width = 8
        Caption = 'Sep_12'
        ImageIndex = 24
        Style = tbsSeparator
      end
      object tbnFilters: TToolButton
        Left = 206
        Top = 0
        Hint = 'Filters|Transform image using filters'
        Caption = 'Filters'
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        OnClick = miFiltersDialogClick
      end
      object tbnUndo: TToolButton
        Left = 232
        Top = 0
        Hint = 'Undo|Restores previous image state'
        Caption = 'Undo'
        Enabled = False
        ImageIndex = 29
        ParentShowHint = False
        ShowHint = True
        OnClick = miUndoClick
      end
      object Sep_3: TToolButton
        Left = 258
        Top = 0
        Width = 8
        Caption = 'Sep_3'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object tbnZoomIn: TToolButton
        Left = 266
        Top = 0
        Hint = 'Zoom In|Zoom in by 50%'
        Caption = 'Zoom In'
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        OnClick = miZoomInClick
      end
      object tbnZoomOut: TToolButton
        Left = 292
        Top = 0
        Hint = 'Zoom Out|Zoom out by 50%'
        Caption = 'Zoom Out'
        ImageIndex = 9
        ParentShowHint = False
        ShowHint = True
        OnClick = miZoomOutClick
      end
      object tbnZoomMisc: TToolButton
        Left = 318
        Top = 0
        Hint = 'Zoom|Set image zoom'
        Caption = 'Zoom'
        DropdownMenu = popZoom
        ImageIndex = 10
        ParentShowHint = False
        ShowHint = True
        Style = tbsDropDown
        OnClick = miZoomtoFitClick
      end
      object tbnFullScreen: TToolButton
        Left = 357
        Top = 0
        Hint = 'Full Screen|Switch to full screen mode'
        Caption = 'FullScreen'
        ImageIndex = 11
        ParentShowHint = False
        ShowHint = True
        OnClick = miFullScreenClick
      end
      object Sep_7: TToolButton
        Left = 383
        Top = 0
        Width = 8
        Caption = 'Sep_7'
        ImageIndex = 20
        Style = tbsSeparator
      end
      object tbnInfo: TToolButton
        Left = 391
        Top = 0
        Hint = 'File Info|View file information'
        Caption = 'Info'
        ImageIndex = 12
        ParentShowHint = False
        ShowHint = True
        OnClick = miInfoClick
      end
      object Sep_8: TToolButton
        Left = 417
        Top = 0
        Width = 8
        Caption = 'Sep_8'
        ImageIndex = 24
        Style = tbsSeparator
      end
      object tbnShow: TToolButton
        Left = 425
        Top = 0
        Hint = 'Slide Show|Slide show in current folder'
        Caption = 'Slide Show'
        ImageIndex = 13
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = miShowClick
      end
      object Sep_9: TToolButton
        Left = 451
        Top = 0
        Width = 8
        Caption = 'Sep_9'
        ImageIndex = 26
        Style = tbsSeparator
      end
      object tbnGoBack: TToolButton
        Left = 459
        Top = 0
        Hint = 
          'Back|Go to previous image in current folder (hold SHIFT to jump ' +
          'to first image in folder)'
        Caption = 'Back'
        ImageIndex = 14
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoBackClick
      end
      object tbnGoRandom: TToolButton
        Left = 485
        Top = 0
        Hint = 'Random File|Go to random image in current folder'
        Caption = 'Random File'
        ImageIndex = 15
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoRandomClick
      end
      object tbnGoForward: TToolButton
        Left = 511
        Top = 0
        Hint = 
          'Forward|Go to next image in current folder (hold SHIFT to jump t' +
          'o last image in folder)'
        Caption = 'Forward'
        ImageIndex = 16
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoForwardClick
      end
      object Sep_4: TToolButton
        Left = 537
        Top = 0
        Width = 8
        Caption = 'Sep_4'
        ImageIndex = 20
        Style = tbsSeparator
      end
      object tbnHelp: TToolButton
        Left = 545
        Top = 0
        Hint = 'Help Contents|Help contents'
        Caption = 'Help Contents'
        ImageIndex = 17
        ParentShowHint = False
        ShowHint = True
        OnClick = miHelpContentsClick
      end
      object tbnSite: TToolButton
        Left = 571
        Top = 0
        Hint = 'Futuris Website|Leads you to Futuris website'
        Caption = 'Futuris Website'
        ImageIndex = 18
        ParentShowHint = False
        ShowHint = True
        OnClick = miFuturisWebSiteClick
      end
      object tbnAbout: TToolButton
        Left = 597
        Top = 0
        Hint = 'About Futuris Imager|About Futuris Imager'
        Caption = 'About Futuris Imager'
        ImageIndex = 19
        ParentShowHint = False
        ShowHint = True
        OnClick = miAboutClick
      end
    end
  end
  object tbrAnim: TCoolBar
    Left = 0
    Top = 522
    Width = 826
    Height = 24
    Align = alBottom
    AutoSize = True
    BandBorderStyle = bsNone
    BandMaximize = bmNone
    Bands = <
      item
        Control = itbAnim
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 24
        Width = 826
      end>
    EdgeBorders = []
    FixedOrder = True
    ShowText = False
    Visible = False
    object itbAnim: TToolBar
      Left = 0
      Top = 0
      Width = 822
      Height = 24
      AutoSize = True
      ButtonHeight = 24
      ButtonWidth = 26
      Caption = 'Animation'
      DisabledImages = imlDisabled
      EdgeBorders = []
      Flat = True
      HideClippedButtons = True
      Images = imlMain
      TabOrder = 0
      Transparent = True
      Wrapable = False
      object tbnPlay: TToolButton
        Left = 0
        Top = 0
        Hint = 'Play|Start animation'
        Caption = 'Play'
        ImageIndex = 22
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnPlayClick
      end
      object tbnPause: TToolButton
        Left = 26
        Top = 0
        Hint = 'Pause|Pause animation'
        Caption = 'Pause'
        ImageIndex = 23
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnPauseClick
      end
      object tbnStop: TToolButton
        Left = 52
        Top = 0
        Hint = 'Stop|Stop animation'
        Caption = 'Stop'
        ImageIndex = 24
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnStopClick
      end
    end
  end
  object tbrMulti: TCoolBar
    Left = 0
    Top = 546
    Width = 826
    Height = 24
    Align = alBottom
    AutoSize = True
    BandBorderStyle = bsNone
    BandMaximize = bmNone
    Bands = <
      item
        Control = itbMulti
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 24
        Width = 826
      end>
    EdgeBorders = []
    FixedOrder = True
    ShowText = False
    Visible = False
    object itbMulti: TToolBar
      Left = 0
      Top = 0
      Width = 822
      Height = 24
      AutoSize = True
      ButtonHeight = 24
      ButtonWidth = 26
      Caption = 'MultiPage'
      DisabledImages = imlDisabled
      EdgeBorders = []
      Flat = True
      HideClippedButtons = True
      Images = imlMain
      TabOrder = 0
      Transparent = True
      Wrapable = False
      object tbnMultiFirst: TToolButton
        Left = 0
        Top = 0
        Hint = 'First|Go to first page'
        Caption = 'First'
        ImageIndex = 25
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnMultiFirstClick
      end
      object tbnMultiPrev: TToolButton
        Left = 26
        Top = 0
        Hint = 'Previous|Go to previous page'
        Caption = 'Previous'
        ImageIndex = 20
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnMultiPrevClick
      end
      object tbnMultiNext: TToolButton
        Left = 52
        Top = 0
        Hint = 'Next|Go to next page'
        Caption = 'Next'
        ImageIndex = 21
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnMultiNextClick
      end
      object tbnMultiLast: TToolButton
        Left = 78
        Top = 0
        Hint = 'Last|Go to last page'
        Caption = 'Last'
        ImageIndex = 26
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnMultiLastClick
      end
      object MSep_1: TToolButton
        Left = 104
        Top = 0
        Width = 8
        Caption = 'MSep_1'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object tbnGoToPage: TToolButton
        Left = 112
        Top = 0
        Hint = 'Go To|Go to page'
        Caption = 'Go To'
        ImageIndex = 27
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnGoToPageClick
      end
      object tbnExtractPage: TToolButton
        Left = 138
        Top = 0
        Hint = 'Extract Page|Extract current page as untitled bitmap'
        Caption = 'Extract Page'
        ImageIndex = 28
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnExtractPageClick
      end
    end
  end
  object mnuMain: TMainMenu
    Left = 555
    Top = 157
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
      object miClearClipboard: TMenuItem
        Caption = 'Clear Clipboard'
        Hint = 'Clear Windows Clipboard contents'
        OnClick = miClearClipboardClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object miFiltersDialog: TMenuItem
        Caption = 'Filters...'
        Hint = 'Full list of filters'
        ShortCut = 16454
        OnClick = miFiltersDialogClick
      end
      object miRevert: TMenuItem
        Caption = 'Revert to Original'
        Hint = 'Restore original image'
        Visible = False
        OnClick = miRevertClick
      end
      object miApplyChanges: TMenuItem
        Caption = 'Apply Changes'
        Hint = 'Apply image changes'
        Visible = False
        OnClick = miApplyChangesClick
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
      object mZoom: TMenuItem
        Caption = 'Zoom'
        Hint = 'Select image zoom'
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
        object miZoomtoFit: TMenuItem
          Caption = 'Zoom to Fit'
          OnClick = miZoomtoFitClick
        end
        object N9: TMenuItem
          Caption = '-'
        end
        object miZMCustom: TMenuItem
          Caption = 'Custom...'
          Hint = 'Set custom zoom'
          ShortCut = 16576
          OnClick = miZMCustomClick
        end
      end
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
      object N34: TMenuItem
        Caption = '-'
      end
      object miZoomTFoL: TMenuItem
        Caption = 'Zoom to Fit on Load'
        Hint = 'Makes images automatically zoomed-to-fit in window on image load'
        OnClick = miZoomTFoLClick
      end
      object N8: TMenuItem
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
        ShortCut = 45
        OnClick = miGoBackClick
      end
      object miGoForward: TMenuItem
        Caption = 'Forward'
        Hint = 'Go to next image in current folder'
        ShortCut = 36
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
      object miInfo: TMenuItem
        Caption = 'File Information'
        Hint = 'Show file information panel'
        ShortCut = 16457
        OnClick = miInfoClick
      end
    end
    object mSettings: TMenuItem
      Caption = 'Options'
      object miFileFormats: TMenuItem
        Caption = 'File Formats...'
        Hint = 'File formats registration'
        OnClick = miFileFormatsClick
      end
      object miSettings: TMenuItem
        Caption = 'Preferences...'
        Hint = 'Configure Futuris Imager the way you like'
        OnClick = miSettingsClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object miClearMRU: TMenuItem
        Caption = 'Clear Recent Files List'
        Hint = 'Clears recently opened files list'
        OnClick = miClearMRUClick
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object miScan: TMenuItem
        Caption = 'Search for New Plug-ins'
        Hint = 'Searches for new plug-ins and recreates list of existing ones'
        OnClick = miScanClick
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
    Left = 586
    Top = 157
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
    TrackButton = tbLeftButton
    Left = 617
    Top = 157
    object piZoomFit: TMenuItem
      Caption = 'Zoom to Fit'
      OnClick = miZoomtoFitClick
    end
    object N18: TMenuItem
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
    Left = 648
    Top = 157
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
    Height = 18
    Width = 18
    Left = 555
    Top = 219
  end
  object MRU: TMRUFiles
    MenuItem = NRecent
    MaxEntries = 8
    Numbered = False
    OnClick = MRUClick
    Left = 555
    Top = 250
  end
  object dlgOpen: TFuturisOpenDialog
    Filter = 'All files (*.*)|*.*'
    Title = 'Open image ...'
    OnFolderChange = dlgOpenFolderChange
    ShowPlacesBar = True
    OnPreview = dlgOpenPreview
    Left = 555
    Top = 188
  end
  object dlgInstPlug: TOpenDialog
    DefaultExt = 'fzp'
    Filter = 'Futuris Imager Plug-in Packages (*.fzp)|*.fzp'
    Title = 'Select plug-in package to install ...'
    Left = 617
    Top = 188
  end
  object imlDisabled: TImageList
    Height = 18
    Width = 18
    Left = 586
    Top = 219
  end
  object dlgSave: TFuturisSaveDialog
    Filter = 'All files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save image as...'
    OnFolderChange = dlgOpenFolderChange
    ShowPlacesBar = True
    OnPreview = dlgOpenPreview
    Left = 586
    Top = 188
  end
end
