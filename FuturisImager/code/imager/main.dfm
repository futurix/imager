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
    Top = 78
    Width = 826
    Height = 492
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
      object Sep_3: TToolButton
        Left = 232
        Top = 0
        Width = 8
        Caption = 'Sep_3'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object tbnZoomIn: TToolButton
        Left = 240
        Top = 0
        Hint = 'Zoom In|Zoom in by 50%'
        Caption = 'Zoom In'
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        OnClick = miZoomInClick
      end
      object tbnZoomOut: TToolButton
        Left = 266
        Top = 0
        Hint = 'Zoom Out|Zoom out by 50%'
        Caption = 'Zoom Out'
        ImageIndex = 9
        ParentShowHint = False
        ShowHint = True
        OnClick = miZoomOutClick
      end
      object tbnZoomMisc: TToolButton
        Left = 292
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
        Left = 331
        Top = 0
        Hint = 'Full Screen|Switch to full screen mode'
        Caption = 'FullScreen'
        ImageIndex = 11
        ParentShowHint = False
        ShowHint = True
        OnClick = miFullScreenClick
      end
      object Sep_7: TToolButton
        Left = 357
        Top = 0
        Width = 8
        Caption = 'Sep_7'
        ImageIndex = 20
        Style = tbsSeparator
      end
      object tbnInfo: TToolButton
        Left = 365
        Top = 0
        Hint = 'File Info|View file information'
        Caption = 'Info'
        ImageIndex = 12
        ParentShowHint = False
        ShowHint = True
        OnClick = miInfoClick
      end
      object Sep_8: TToolButton
        Left = 391
        Top = 0
        Width = 8
        Caption = 'Sep_8'
        ImageIndex = 24
        Style = tbsSeparator
      end
      object tbnShow: TToolButton
        Left = 399
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
        Left = 425
        Top = 0
        Width = 8
        Caption = 'Sep_9'
        ImageIndex = 26
        Style = tbsSeparator
      end
      object tbnGoBack: TToolButton
        Left = 433
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
        Left = 459
        Top = 0
        Hint = 'Random File|Go to random image in current folder'
        Caption = 'Random File'
        ImageIndex = 15
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoRandomClick
      end
      object tbnGoForward: TToolButton
        Left = 485
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
        Left = 511
        Top = 0
        Width = 8
        Caption = 'Sep_4'
        ImageIndex = 20
        Style = tbsSeparator
      end
      object tbnHelp: TToolButton
        Left = 519
        Top = 0
        Hint = 'Help Contents|Help contents'
        Caption = 'Help Contents'
        ImageIndex = 17
        ParentShowHint = False
        ShowHint = True
        OnClick = miHelpContentsClick
      end
      object tbnSite: TToolButton
        Left = 545
        Top = 0
        Hint = 'Futuris Website|Leads you to Futuris website'
        Caption = 'Futuris Website'
        ImageIndex = 18
        ParentShowHint = False
        ShowHint = True
        OnClick = miFuturisWebSiteClick
      end
      object tbnAbout: TToolButton
        Left = 571
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
    Top = 26
    Width = 826
    Height = 26
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
    EdgeBorders = [ebTop]
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
        ShowHint = False
        OnClick = tbnPlayClick
      end
      object tbnPause: TToolButton
        Left = 26
        Top = 0
        Hint = 'Pause|Pause animation'
        Caption = 'Pause'
        ImageIndex = 23
        ParentShowHint = False
        ShowHint = False
        OnClick = tbnPauseClick
      end
      object tbnStop: TToolButton
        Left = 52
        Top = 0
        Hint = 'Stop|Stop animation'
        Caption = 'Stop'
        ImageIndex = 24
        ParentShowHint = False
        ShowHint = False
        OnClick = tbnStopClick
      end
    end
  end
  object tbrMulti: TCoolBar
    Left = 0
    Top = 52
    Width = 826
    Height = 26
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
    EdgeBorders = [ebTop]
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
        ShowHint = False
        OnClick = tbnMultiFirstClick
      end
      object tbnMultiPrev: TToolButton
        Left = 26
        Top = 0
        Hint = 'Previous|Go to previous page'
        Caption = 'Previous'
        ImageIndex = 20
        ParentShowHint = False
        ShowHint = False
        OnClick = tbnMultiPrevClick
      end
      object tbnMultiNext: TToolButton
        Left = 52
        Top = 0
        Hint = 'Next|Go to next page'
        Caption = 'Next'
        ImageIndex = 21
        ParentShowHint = False
        ShowHint = False
        OnClick = tbnMultiNextClick
      end
      object tbnMultiLast: TToolButton
        Left = 78
        Top = 0
        Hint = 'Last|Go to last page'
        Caption = 'Last'
        ImageIndex = 26
        ParentShowHint = False
        ShowHint = False
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
        ShowHint = False
        OnClick = tbnGoToPageClick
      end
      object tbnExtractPage: TToolButton
        Left = 138
        Top = 0
        Hint = 'Extract Page|Extract current page as untitled bitmap'
        Caption = 'Extract Page'
        ImageIndex = 28
        ParentShowHint = False
        ShowHint = False
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
      object miRevert: TMenuItem
        Caption = 'Revert to Original'
        Hint = 'Restore original image'
        ShortCut = 16474
        Visible = False
        OnClick = miRevertClick
      end
      object miApplyChanges: TMenuItem
        Caption = 'Apply Changes'
        Hint = 'Apply image changes'
        ShortCut = 16449
        Visible = False
        OnClick = miApplyChangesClick
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
      object miSettings: TMenuItem
        Caption = 'Imager Settings...'
        Hint = 'Settings for Futuris Imager User'
        OnClick = miSettingsClick
      end
      object miFileFormats: TMenuItem
        Caption = 'File Formats...'
        Hint = 'File formats registration'
        OnClick = miFileFormatsClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object miScan: TMenuItem
        Caption = 'Scan for Plug-ins'
        Hint = 'Scan for plug-ins'
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
    Bitmap = {
      494C01011D002200040012001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000048000000A2000000010020000000000040B6
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000097635A0097635A009763
      5A0097635A0097635A0097635A0097635A0097635A0097635A0097635A009763
      5A0097635A0097635A0097635A0097635A0097635A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000097635A0037C6640037C6
      640037C6640037C6640037C6640037C6640037C6640037C6640037C6640037C6
      640037C6640037C6640037C6640055C06B0097635A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000097635A0024B2420024B2
      420024B2420024B2420024B2420024B2420024B2420024B2420024B2420024B2
      420024B2420024B2420024B2420037C6640097635A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000097635A00189D2B00189D
      2B00189D2B00189D2B00189D2B00189D2B00189D2B00189D2B00189D2B00189D
      2B00189D2B00189D2B00189D2B0029A343009F64580000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000097635A000B8715000B87
      15000B8715000B8715000B8715000B8715000E8B1D000E8B1D000B8715000B87
      15000B8715000B871500189D2B00CEF0D80097635A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000097635A00047507000475
      070004750700047507000475070004750700CCDDB600CCDDB6000B8715000475
      070004750700599D5100FAFAFA00FFFFFF0097635A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000097635A00407C19000475
      070004750700047507000475070098B87600FFE3AA00FFE2C600FFE2C6001D83
      2800CCDDB600FFF7EF00FFFCF800FFFCF80097635A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000097635A00FFBA5D00407C
      19000458050004580500599D5100F6C07B00FFD79900FFD79900FFDAA100FFE3
      AA00FFDCB600FFE2C600FFE2C600FFEEDA0097635A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000097635A00FFA33500FEA9
      470016630700407C1900FFBA5D00FFBA5D00FFBA5D00F6C07B00F6C07B00FEC8
      8D00FFD79900FFD79900FFDAA100FFDCB60097635A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000097635A00FFA33500FFA3
      3500FFA33500FFA33500FFA33500FEA94700FEA94700FEA94700FFBA5D00FFBA
      5D00FFBA5D00F6C07B00F6C07B00FFD7990097635A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000097635A00FFA33500FFA3
      3500FFA33500FFA33500FFA33500FFA33500FFA33500FFA33500FFA33500FEA9
      4700FEA94700FEA94700FFBA5D00F6C07B0097635A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000097635A0097635A009763
      5A0097635A0097635A0097635A0097635A0097635A0097635A0097635A009763
      5A0097635A0097635A0097635A0097635A0097635A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000243AA400243AA400243AA400243AA400243AA4000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000972D0000972D0000972D0000972D
      0000972D00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000972D0000972D
      0000972D0000972D0000972D0000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008B5B59008B5B59008B5B
      59008B5B59008B5B59008B5B59008B5B59008B5B59008B5B59008B5B59008B5B
      59006D4341000000000000000000000000000000000000000000000000000000
      0000001BE6000018C7000018C7000018C7000018C7000018C7000018C7000116
      A4000116A4000000000000000000000000000000000000000000000000000000
      00000000000000000000972D0000972D0000AA3C0000BD4B0000BD4B0000BD4B
      0000AA3C0000972D0000972D0000000000000000000000000000000000000000
      0000000000000000000000000000000000009F3400009F340000A6390000AF40
      0000AF400000AF400000A336000092351000972D000000000000000000000000
      0000000000000000000000000000000000000000000082524E00FCDCC500FFDC
      B600FFCBBC00FFD4AB00FFD4AB00FACBA600FFCC9F00FFCC9F00FFCC9F00FEC8
      8D006D434100000000000000000000000000000000000000000000000000001B
      E600001BE600001BE6000019D9000019D9000019D9000018C7000018C7000018
      C7000116A4000116A40000000000000000000000000000000000000000000000
      0000000000009A411C00AF400000BD4B0000BD4B0000BD4B0000BD4B0000BD4B
      0000BD4B0000BD4B0000AF400000AA3C00000000000000000000000000000000
      00000000000000000000000000009A411C00AA3C0000BD4B0000BD4B0000BD4B
      0000BD4B0000BD4B0000BD4B0000BD4B00009A3000009A300000000000000000
      0000000000000000000000000000000000000000000082524E00FFE9D100FFE2
      C600FCDCC500FFDCB600FFD4AB00FFD4AB00FFCC9F00FFCC9F00FEC88D00FEC8
      8D006D4341000000000000000000000000000000000000000000001BE600001C
      F0000625E600506CF7000625E600001BE6000019D9000019D9000018C700506C
      F7002D4EF8000018C7000116A400000000000000000000000000000000000000
      0000972D0000AF400000BD4B0000BD4B0000BD4B0000BD4B0000BD4B0000BD4B
      0000BD4B0000CE742B00BD4B0000AF400000AA3C000000000000000000000000
      000000000000000000009F340000AF400000BD4B0000BD4B0000BD4B0000BD4B
      0000BD4B0000BD4B0000BD4B0000BD4B0000BD4B00009F340000972D00000000
      00000000000000000000000000000000000000000000965C5300FFE9D100FFE9
      D100FFDCB600F2D9BD006170EE00E9C1B900FFD4AB00FFCC9F00FFCC9F00FEC8
      8D006D4341000000000000000000000000000000000000000000001EFF00001E
      FF008F8FEE00FEFBFC00BDD1FC000625E600001BE600001BE6008F8FEE00FFFC
      F800A9B4F6000018C7000116A400000000000000000000000000000000000000
      00009F340000BD4B0000BD4B0000EDCEAD00FFFFFF00BD4B0000BD4B0000C155
      0600CF6A1900FFFFFF00BD4B0000BD4B00009F34000000000000000000000000
      000000000000000000009F340000BD4B0000BD4B0000FCFFFF00CF6A1900BD4B
      0000BD4B0000BD4B0000FFFFFF00F3D1AD00BD4B0000BD4B0000933006000000
      000000000000000000000000000000000000000000009F645800FFEEDA00FFE9
      D1009698F0000B2DFC00011EFA006170EE00F3D1AD00FFD4AB00FFCC9F00FFCC
      9F0082524E00000000000000000000000000000000000324FF00001EFF00001E
      FF000728FC00BDD1FC00FFFFFF00BDD1FC000625E6008F8FEE00FFFFFF00EAEE
      FE00183BFA000018C7000018C7000116A400000000000000000000000000972D
      0000BD4B0000BD4B0000BD4B0000EDCEAD00FFFFFF00BD4B0000C1550600CF6A
      1900FFFFFF00FFFFFF00BD4B0000BD4B0000B5440000AA3C0000000000000000
      000000000000C9540000C14E0000C14E0000C14E0000FFFFFF00FEF2E500CF6A
      1900BD4B0000BD4B0000FFFFFF00F3D1AD00BD4B0000BD4B0000A6390000A639
      00000000000000000000000000000000000000000000A76C5C00FEF2E5006170
      EE00011EFA00011EFA000B2DFC00011EFA00D5BBB500FFD4AB00FFD4AB00FFCC
      9F0082524E00000000000000000000000000000000000324FF00001EFF00001E
      FF00001EFF000728FC00BDD1FC00FFFFFF00EAEEFE00FFFFFE00EAEEFE00183B
      FA00001BE6000019D9000019D9000116A400000000000000000000000000972D
      0000D8620000D05A0000C14E0000EDCEAD00FFFFFF00C1550600CF6A1900FCFF
      FF00FCFFFF00FCFFFF00BD4B0000BD4B0000BD4B0000AA3C0000000000000000
      000000000000C9540000D8620000C9540000C14E0000FFFFFF00FFFFFF00FFFF
      FF00D98B4400BB490000FFFFFF00F3D1AD00BD4B0000BD4B0000BD4B0000AA3C
      00000000000000000000000000000000000000000000B6745700FFF7EF009698
      F0006170EE00E9E0D500C2C1C200011EFA00296EE300FFD4AB00FFD4AB00FFD4
      AB0082524E00000000000000000000000000000000000324FF00001EFF00001E
      FF00001EFF00001EFF000728FC00EAEEFE00FFFFFF00FEFBFC002D4EF800001C
      F000001BE600001BE6000019D9000116A400000000000000000000000000AF40
      0000E76D0000E0680000D8620000F3D1AD00FFFFFF00CA600F00FEF2E500FFFF
      FF00FFFFFF00FFFFFF00BD4B0000BD4B0000BD4B0000AA3C0000000000000000
      000000000000C9540000E76D0000D8620000D05A0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CA600F00FFFFFF00F3D1AD00BD4B0000BD4B0000BD4B0000AA3C
      00000000000000000000000000000000000000000000C0856700FFF7EF00FFF7
      EF00FEF2E500FFEEDA00FFE9D1006170EE00011EFA009698F000FFDCB600FFD4
      AB008B5B5900000000000000000000000000000000000324FF00001EFF00001E
      FF00001EFF00001EFF008F8FEE00FCFFFF00FCFFFF00FCFFFF00BDD1FC000728
      FC00001CF000001BE600001BE6000018C700000000000000000000000000BA48
      0000FA7D0000EE730000E76D0000F3D1AD00FEFEFE00C9540000CF6A1900FFFF
      FF00FFFFFF00FFFFFF00BD4B0000BD4B0000BD4B0000AA3C0000000000000000
      000000000000C9540000FA7D0000EE730000E0680000FFFFFF00FFFFFF00FFFF
      FF00D98B4400BD4B0000FFFFFF00F3D1AD00BD4B0000BD4B0000BD4B0000AA3C
      00000000000000000000000000000000000000000000C0856700FFFEFC00FFF7
      EF00FFF7EF00FEF2E500FFEEDA00E9E0D500011EFA00011EFA00E7CFC200FFDC
      B600905F5B00000000000000000000000000000000000324FF000324FF00001E
      FF00001EFF008F8FEE00FCFFFF00EAEEFE002D4EF800BDD1FC00FFFFFF00BDD1
      FC000728FC00001CF000001CF0000018C700000000000000000000000000BA48
      0000FF890900FF820000FA7D0000FFD4AB00FFFFFF00D8620000C9540000D98B
      4400FFFFFF00FFFFFF00BD4B0000BD4B0000BD4B0000AA3C0000000000000000
      000000000000BB4C0200FF840300FA7D0000F3770000FFFFFE00FFFFFE00E5A5
      6D00C9540000C14E0000FFFFFF00F3D1AD00BD4B0000BD4B0000BD4B0000AA3C
      00000000000000000000000000000000000000000000CD8F6800FFFFFF00FFFF
      FF00FFF7EF00FFF7EF00FEF2E500FFEEDA009698F000296EE300D2CFCF00FCDC
      C500905F5B000000000000000000000000000000000000000000183BFA00183B
      FA002D4EF800F6FEFF00EAEEFE00183BFA00001EFF000728FC00BDD1FC00FCFF
      FF00A9B4F600001EFF000018C700000000000000000000000000000000000000
      0000CA600F00FF8E1100FF840300FFDCB600FFFFFF00E76D0000D8620000D05A
      0000D98B4400FFFEFC00BD4B0000BD4B0000AA3C000000000000000000000000
      00000000000000000000CA600F00FF890900FF820000FFFFFF00FEC78E00E068
      0000D8620000D05A0000FFFFFF00F3D1AD00BD4B0000BD4B0000A33600000000
      00000000000000000000000000000000000000000000D1936D00FFFFFF00FFFF
      FF00FFFFFF00FFF7EF00FFF7EF00FEF2E500FFEEDA00FFE9D100FCDCC500FFCB
      BC0097635A000000000000000000000000000000000000000000183BFA00506C
      F7002D4EF8008F8FEE002D4EF800001EFF00001EFF00001EFF000728FC00A9B4
      F600506CF700001EFF000018C700000000000000000000000000000000000000
      0000CA600F00FEA94700FF961F00FF961F00F3770000FA7D0000EE730000E068
      0000D8620000CA600F00C14E0000C14E00009330060000000000000000000000
      00000000000000000000CA600F00FFA33500FF8E1100FEA94700FA7D0000F377
      0000E76D0000E0680000E0680000D8620000C14E0000C14E0000923510000000
      00000000000000000000000000000000000000000000DC9F7600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFF7EF00FFF7EF00FEF2E500FCDCC500DEAB9D00D496
      830097635A00000000000000000000000000000000000000000000000000183B
      FA00506CF7002D4EF800183BFA000728FC00001EFF00001EFF00001EFF00001E
      FF00001EFF000018C70000000000000000000000000000000000000000000000
      000000000000CF6A1900FEA94700FFA33500FF961F00FF890900FF820000F377
      0000E76D0000E0680000D86200009F3400000000000000000000000000000000
      0000000000000000000000000000CF6A1900FEA94700FF961F00FF8E1100FF82
      0000FA7D0000EE730000E76D0000D8620000D05A00009A300000000000000000
      00000000000000000000000000000000000000000000DC9F7600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7EF00FFF7EF009F64580097635A009F64
      58009F6458000000000000000000000000000000000000000000000000000000
      0000183BFA000324FF00506CF7002D4EF800183BFA000324FF00001EFF00001E
      FF00001EFF000000000000000000000000000000000000000000000000000000
      00000000000000000000CF6A1900CF6A1900FEA94700FF961F00FF8E1100FF82
      0000FA7D0000AA3C0000AA3C0000000000000000000000000000000000000000
      000000000000000000000000000000000000CF6A1900CF6A1900FFA33500FF96
      1F00FF890900FF820000F3770000AA3C0000AA3C000000000000000000000000
      00000000000000000000000000000000000000000000E6A66E00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7EF009F645800F6C07B00CF9D
      8800000000000000000000000000000000000000000000000000000000000000
      000000000000000000000324FF000324FF000324FF000324FF000324FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CF6A1900CF6A1900CF6A1900CF6A
      1900CF6A19000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CF6A1900CF6A
      1900CF6A1900CF6A1900CF6A1900000000000000000000000000000000000000
      00000000000000000000000000000000000000000000E6A66E00D1936D00D193
      6D00D1936D00D1936D00D1936D00D1936D00D1936D009F645800D7A48E000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002B632C002B63
      2C002B632C002B632C002B632C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000972D0000972D0000972D0000972D0000972D000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFC0
      C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
      C000FFC0C000FFC0C00000000000000000000000000000000000000000000000
      000080808000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
      C000FFC0C000FFC0C000FFC0C000FFC0C0000000000000000000000000000000
      00000000000000000000000000000000000004580500045805000A861500029A
      0A00029A0A00029A0A00029A0A00045805000458050000000000000000000000
      0000000000000000000000000000000000000000000000000000972D0000972D
      0000AF400000BD4B0000BD4B0000BD4B0000BD4B0000972D0000972D00000000
      000000000000000000000000000000000000000000000000000080808000E8FF
      FF00E8FFFF00E8FFFF00E0FFFF00E0FFFF00E0FFFF00E0FFFF00D6FFFF00D6FF
      FF00D6FFFF00FFC0C00000000000000000000000000000000000000000000000
      000080808000E8FFFF00E8FFFF00E8FFFF00E0FFFF00E0FFFF00E0FFFF00E0FF
      FF00D6FFFF00D6FFFF00D6FFFF00FFC0C0000000000000000000000000000000
      0000000000000000000000000000045805000A8615000DA62C0007A11B0007A1
      1B0007A11B00029A0A00029A0A00029A0A00029A0A00004B0000000000000000
      000000000000000000000000000000000000000000009A411C00AF400000BD4B
      0000BD4B0000BD4B0000BD4B0000BD4B0000BD4B0000BD4B0000BD4B0000972D
      000000000000000000000000000000000000000000000000000080808000EBFF
      FF00EBFFFF00EBFFFF0000580300E0FFFF00E0FFFF00E0FFFF00D8FFFF00D8FF
      FF00D8FFFF00FFC0C00000000000000000000000000000000000000000000000
      000080808000EBFFFF00EBFFFF00EBFFFF00E3FFFF00E3FFFF00E3FFFF000058
      0300D8FFFF00D8FFFF00D8FFFF00FFC0C0000000000000000000000000000000
      00000000000000000000045805000E8B1C0013AB3D000DA62C000DA62C000DA6
      2C0007A11B0007A11B0007A11B00029A0A00029A0A00029A0A00045805000000
      000000000000000000000000000000000000972D0000AF400000BD4B0000BD4B
      0000BD4B0000BD4B0000BD4B0000BD4B0000BD4B0000BD4B0000BD4B0000BD4B
      000097330500000000000000000000000000000000000000000080808000EDFF
      FF00EDFFFF00005803001CB631000684110006731100DDFFFF00DDFFFF00DDFF
      FF00D5FFFF00FFC0C00000000000000000000000000000000000000000000000
      000080808000EDFFFF00EDFFFF00EDFFFF00E5FFFF0006731100068411001CB6
      310000580300D8FFFF00D8FFFF00FFC0C0000000000000000000000000000000
      000000000000000000000A8615001AB14F001AB14F0013AB3D0013AB3D00CEF0
      D80013AB3D0007A11B0007A11B0007A11B00029A0A00029A0A00045805000000
      000000000000000000000000000000000000972D0000BD4B0000BD4B0000BD4B
      0000EDCEAD00FFFFFF00BD4B0000E5A56D00FCFBFC00CE742B00BD4B0000BD4B
      00009F340000000000000000000000000000000000000000000080808000EFFF
      FF000058030040E073002ACA50001CB631000B981600038F0B00036A0600DAFF
      FF00DAFFFF00FFC0C00000000000000000000000000000000000000000000000
      000080808000EFFFFF00EFFFFF00036A0600038F0B000B9816001CB631002ACA
      500040E0730000580300D8FFFF00FFC0C0000000000000000000000000000000
      000000000000029A0A000DA62C001AB14F001AB14F001AB14F0013AB3D00FEFE
      FE00CEF0D80013AB3D000DA62C0007A11B0007A11B0007A11B00029A0A00004B
      0000000000000000000000000000BA480000B5440000C14E0000C14E0000C14E
      0000EDCEAD00FFFFFF00BD4B0000E5A56D00FAFAFA00CE742B00BD4B0000BD4B
      0000BD4B0000AA3C00000000000000000000000000000000000080808000F1FF
      FF00F1FFFF000058030038CA600006731100036A060003730600038F0B000360
      0300DAFFFF00FFC0C00000000000000000000000000000000000000000000000
      000080808000F1FFFF0003600300038F0B0003730600036A06000673110038CA
      600000580300DCFFFF00DCFFFF00FFC0C0000000000000000000000000000000
      000000000000029A0A0013AB3D001AB14F001AB14F001AB14F001AB14F00FFFF
      FF00FFFFFF00EFF6F20013AB3D000DA62C000DA62C0007A11B0007A11B00004B
      0000000000000000000000000000BA480000D05A0000D8620000C9540000C14E
      0000EDCEAD00FFFFFF00BD4B0000E5A56D00FFFEFC00CE742B00BD4B0000BD4B
      0000BD4B0000AA3C00000000000000000000000000000000000080808000F4FF
      FF00F4FFFF00F4FFFF0000580300E9FFFF00E9FFFF00E9FFFF00037306000373
      0600DCFFFF00FFC0C00000000000000000000000000000000000000000000000
      000080808000F4FFFF000373060003730600ECFFFF00ECFFFF00ECFFFF000058
      0300E1FFFF00E1FFFF00E1FFFF00FFC0C0000000000000000000000000000000
      000000000000029A0A001AB14F001AB14F001AB14F001AB14F001AB14F00FFFF
      FE00FFFFFE00FFFFFE00CEF0D80013AB3D000DA62C000DA62C0007A11B00004B
      0000000000000000000000000000BA480000EE730000E76D0000D8620000D05A
      0000F3D1AD00FFFFFF00BA480000E5A56D00FFFFFE00CE742B00BD4B0000BD4B
      0000BD4B0000AA3C00000000000000000000000000000000000080808000F6FF
      FF00F6FFFF00F6FFFF00EEFFFF00EEFFFF00EEFFFF00E6FFFF00E6FFFF000373
      0600DEFFFF00FFC0C00000000000000000000000000000000000000000000000
      000080808000F6FFFF0003730600F1FFFF00F1FFFF00F1FFFF00E9FFFF00E9FF
      FF00E9FFFF00E1FFFF00E1FFFF00FFC0C0000000000000000000000000000000
      000000000000029A0A0024B242001AB14F001AB14F001AB14F001AB14F00FFFF
      FF00FFFFFF00EFF6F2001AB14F0013AB3D0013AB3D000DA62C000DA62C00004B
      0000000000000000000000000000BA480000F3770000F3770000EE730000E068
      0000F3D1AD00FFFFFF00C14E0000E5A56D00FEFBFC00CE742B00BD4B0000BD4B
      0000BD4B0000AA3C00000000000000000000000000000000000080808000F8FF
      FF00F8FFFF00F8FFFF00F0FFFF00F0FFFF00F0FFFF00F0FFFF00E6FFFF000360
      0300E1FFFF00FFC0C00000000000000000000000000000000000000000000000
      000080808000F8FFFF0003600300F3FFFF00F3FFFF00F3FFFF00EBFFFF00EBFF
      FF00EBFFFF00E3FFFF00E3FFFF00FFC0C0000000000000000000000000000000
      000000000000029A0A0013AB3D0021B456001AB14F001AB14F001AB14F00FFFF
      FF00EFF6F2001AB14F001AB14F001AB14F001AB14F0013AB3D0013AB3D00004B
      0000000000000000000000000000BA480000E1700900FF840300FA7D0000EE73
      0000F4DDA900FFFFFF00D05A0000E5A56D00FFFEFC00CE742B00BD4B0000BD4B
      0000BD4B0000AA3C00000000000000000000000000000000000080808000FBFF
      FF00FBFFFF00FBFFFF00F3FFFF00F3FFFF00F3FFFF00EBFFFF00EBFFFF00EBFF
      FF00E3FFFF00FFC0C00000000000000000000000000000000000000000000000
      000080808000FBFFFF00FBFFFF00FBFFFF00F3FFFF00F3FFFF00F3FFFF00EBFF
      FF00EBFFFF00EBFFFF00E3FFFF00FFC0C0000000000000000000000000000000
      00000000000000000000029A0A0055C06B0029BF58001AB14F0021B45600EEFF
      FF001AB14F001AB14F001AB14F001AB14F001AB14F001AB14F00045805000000
      000000000000000000000000000000000000CA600F00FF961F00FF890900FF82
      0000FFD4AB00FFFFFE00E0680000E5A56D00FCFFFF00CE742B00BD4B0000BD4B
      0000AA3C0000000000000000000000000000000000000000000080808000FDFF
      FF00FDFFFF00FDFFFF00F5FFFF00F5FFFF00F5FFFF00EDFFFF00EDFFFF00EDFF
      FF00FFC0C000FFC0C00000000000000000000000000000000000000000000000
      000080808000FDFFFF00FDFFFF00FDFFFF00F5FFFF00F5FFFF00F5FFFF00EDFF
      FF00EDFFFF00EDFFFF00FFC0C000FFC0C0000000000000000000000000000000
      00000000000000000000029A0A0055C06B006CD3840037C6640021B456001AB1
      4F001AB14F001AB14F001AB14F001AB14F001AB14F001AB14F000E8B1C000000
      000000000000000000000000000000000000CA600F00EE813100FFA33500FF8E
      1100FF961F00F3770000F3770000DC741600E1700900DC741600C9540000BD4B
      00009A300000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00F7FFFF00EFFFFF00EFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00F7FFFF00EFFF
      FF00EFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000029A0A006CD384006CD3840055C06B0037C6
      64001AB14F001AB14F001AB14F001AB14F001AB14F000E8B1C00000000000000
      00000000000000000000000000000000000000000000CF6A1900FEA94700FEA9
      4700FF961F00FF8E1100FF820000FA7D0000EE730000E76D0000D86200009F34
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00F7FFFF00EFFFFF008080
      8000FFFFFF000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00F7FF
      FF00EFFFFF0080808000FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000029A0A00029A0A006CD384006CD3
      840055C06B0029BF58001AB14F000E8B1C000E8B1C0000000000000000000000
      0000000000000000000000000000000000000000000000000000CF6A1900CF6A
      1900FFBA5D00FFA33500FF961F00FF890900FF820000AA3C0000BA4800000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      8000000000000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000029A0A00029A
      0A00029A0A00029A0A00029A0A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CF6A1900CF6A1900CF6A1900CF6A1900CF6A190000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000400060000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000040006000400060008000C0008000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000000000000000000000000000000000000000000080C0FF00FFFFFF0000C0
      FF00FFFFFF0000C0FF00FFFFFF0000C0FF00FFFFFF0000C0FF00FFFFFF0000C0
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000040006000400060008000C000FF60C000FFFFFF00FFC0
      C000800080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF0000008080
      8000FFFFFF0040C0FF00FFFFFF00FFFFFF00FFFFFF0040C0FF00FFFFFF008080
      80000000000000000000000000000000000000000000FFFFFF0080C0FF00FFFF
      FF0080C0FF00FFFFFF00FFC0C000FFFFFF0000C0FF00FFFFFF0000C0FF00FFFF
      FF0000C0FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000040006000400060008000C000FF60C000FFFFFF00FFFFFF00FFFFFF00FFC0
      C000FFC0C0008000800000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF200000FF000000FF0000008080
      8000FFFFFF00FFFFFF00FFFFFF0040C0FF00FFFFFF00FFFFFF00FFFFFF008080
      8000000000000000000000000000000000000000000080C0FF00FFFFFF0080C0
      FF00FFFFFF00FFC0C000FF000000FFC0C000FFFFFF0000C0FF00FFFFFF0000C0
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      80008000C000FF60C000FFFFFF00FFFFFF00FFC0C000FFC0C000800080008080
      800080A0A000FFC0C00080008000000000000000000000000000000000000000
      0000000000000000000000000000FF200000FF200000FFA00000FFA000008080
      8000FFFFFF0040C0FF0080000000800000008000000080808000FFFFFF008080
      80000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF00FFFFFF00FFFFFF0080C0FF00FFFFFF0080C0FF00FFFF
      FF0000C0FF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF60
      2000000000000000000000000000000000000000000000000000000000008000
      800080808000FFFFFF00FFC0C00080A0A0008000800080008000800080000000
      00008080800080808000FFC0C000800080000000000000000000000000000000
      0000000000000000000000000000FF200000FFA00000FFA00000FFA000008080
      8000FFFFFF0080800000FF000000FF000000FFA0000080000000FFFFFF008080
      8000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FF00000000FFFF00FFFFFF0080C0FF00FFFFFF0000C0
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF80
      2000FF6020000000000000000000000000000000000000000000000000008000
      800080808000FFC0C0008000800080008000FF00C000FF00C000FF00C0008000
      800000000000406060008080800080A0A0008000800000000000000000000000
      00000000000000000000FF000000FF400000FFA00000FFA00000FFA000008080
      8000FFFFFF00808000008080800000800000FF00000080000000FFFFFF008080
      80000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000FFFF00FFFFFF00FF000000FF00000000FFFF00FFFFFF0080C0FF00FFFF
      FF0000C0FF00000000000000000000000000000000000000000000000000FF60
      2000FF802000FF802000FF802000FF802000FF802000FF802000FF802000FF80
      2000FFC02000FF60200000000000000000000000000000000000000000008000
      80008000800080008000FF00C000FF00C0008000800080008000FF00C000FF00
      C000800080000000000040606000808080008080800080008000000000000000
      00000000000000000000FF000000FF200000FFA0000000800000008000008080
      8000FFFFFF0080800000FFFFFF00808080000080000080000000FFFFFF008080
      80000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000FFFF00FFFFFF00FF000000FF00000000FFFF00FFFFFF0080C0
      FF00FFFFFF00000000000000000000000000000000000000000000000000FF60
      2000FFFFC000FFFFC000FFFFC000FFFFC000FFFFC000FFFFC000FFFFC000FFFF
      C000FFFF8000FFC0200000000000000000000000000000000000000000008000
      8000FF80FF00FF00C000FF00C000FF00C00000FFFF0000C0FF00006080008000
      8000800080008000800000000000406060008080800080008000000000000000
      00000000000000000000FF000000FF0000000080000000800000008000008080
      8000FFFFFF0040C0FF0080800000808000008080000080808000FFFFFF008080
      80000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00FFC0C000FF000000FFFFFF0080C0FF00FFFF
      FF0080C0FF00000000000000000000000000000000000000000000000000FF60
      2000FF602000FF602000FF602000FF602000FF602000FF602000FF602000FFFF
      C000FFC020000000000000000000000000000000000000000000000000000000
      000080008000FF80FF00FF00C000FF00C000FF00C000FF00C00000FFFF0000FF
      FF0000C0FF000060800080008000000000004060600080008000000000000000
      00000000000000000000FF000000FF0000000080000000800000008000008080
      8000FFFFFF00FFFFFF00FFFFFF0040C0FF00FFFFFF0000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FFFFFF00FFFFFF00FFC0C000FF00000000FFFF00FFFFFF0080C0
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF602000FFC0
      2000000000000000000000000000000000000000000000000000000000000000
      00000000000080008000FF80FF00FF00C000FF00C000FF00C000FF00C000FF00
      C00000C0FF0000FFFF0040006000800080000000000080008000000000000000
      00000000000000000000FF000000FF000000FFC0C00000800000008000008080
      8000FFFFFF0040C0FF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF008080
      80000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FF000000FF000000FFC0C000FF000000FF000000FFFFFF0000FFFF00FFFF
      FF0080C0FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF6020000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080008000FF80FF00FF00C000FF00C00000FFFF0000FF
      FF0000FFFF000080C00040006000800080008000800000000000000000000000
      0000000000000000000080808000FF000000FF000000FFFFFF00FFC0C0008080
      8000FFFFFF00FFFFFF00FFFFFF0040C0FF00FFFFFF0080808000808080000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FF000000FF000000FF000000FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF6020000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080008000FF80FF00FF00C000FF00C0000060
      8000006080004000600080008000800080004000600000000000000000000000
      0000000000000000000080808000FF000000FFFFFF00FFC0C000FFFFFF008080
      8000808080008080800080808000808080008080800080808000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080008000FF80FF00FF00C000FF00
      C000FF00C0008000800040006000000000000000000000000000000000000000
      000000000000000000000000000080808000FF000000FF000000FFC0C000FFFF
      FF00FFC0C0000080000000800000008000000080000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080008000FF80FF00FF00
      C000400060000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000FF000000FF00
      0000FFFFFF00FFC0C00000800000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000800080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B6B6B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000060
      8000006080000060800000608000006080000060800000608000006080000060
      8000006080000060800000608000006080000000000000000000000000000000
      0000000000000000000000000000000000007A7777005E5E5E00000000000000
      00007A7777005153540000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008080800000C0FF0000C0
      FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0
      FF00006080000060800000C0FF00006080000000000000000000000000000000
      000000000000000000000000000000000000000000005E5E5E006F6E6E005E5E
      5E00515354000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000060600080FFFF0000C0FF0000C0FF0000C0
      FF000080C0000080C0000080C0000080C00000208000408080000080C0004080
      80000080C0000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0000C0FF0000608000006080000000000000000000000000000000
      0000000000000000000097635A0097635A009C6F690096818000515354005153
      5400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000060600080FFFF0000C0FF0000C0FF0000C0
      FF0000C0FF0000C0FF000080C000002080000000C0000080C000408080000080
      C00040808000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080FFFF00FFFFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0000608000006080000000000000000000000000000000
      0000000000000000000097635A00E9C1B900D09F9C00A47B76009C6F6900905F
      5B009C6F69009C6F690000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000060600080FFFF00FFFFFF0000C0FF0000C0
      FF0000C0FF0000C0FF00002080000000FF000000C00000208000002080004080
      80000080C000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF0000808000006060000060600000606000006060000060600080FF
      FF0080FFFF0080FFFF0000C0FF00006080000000000000000000000000000000
      0000000000000000000097635A00FFD9D900FFD9D900FFC6C600FFC0B700FEAB
      AA00F0949300B08E8A009C6F690097635A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF8020000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000060600080FFFF000000C000FFFFFF0000C0
      FF0000C0FF0000C0FF0000C0FF000000C0000000FF000080C0000080C0000020
      800040808000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FFFF00FFFFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0000C0FF00006080000000000000000000000000000000
      0000000000000000000097635A00FBE8E700FFD9D900FFD9D900FFC6C600FFC0
      B700FEABAA00FEABAA00F094930097635A000000000000000000000000000000
      00000000000000000000000000000000000000000000FF802000FF8020000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000060600080FFFF000000C00080FFFF00FFFF
      FF000020800000C0FF0000C0FF0000C0FF000000C0000080C0000080C0000020
      80000080C000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF000080800000808000008080000060600000606000006060000060
      6000006060000060600000C0FF00006080000000000000000000000000000000
      0000000000000000000097635A00FFFAFA00FBE8E700FFD9D900FFD9D900FFC6
      C600FFC0B700FEABAA00FEABAA0097635A000000000000000000000000000000
      000000000000000000000000000000000000FF802000FFC02000FF802000FF80
      2000FF802000FF802000FF802000FF802000FF802000FF802000000000000000
      00000000000000000000000000000060600080FFFF000000C000FFFFFF0080FF
      FF000000C0000020800000C0FF0000C0FF0000C0FF0000C0FF000080C0000020
      80000080C000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FFFF00FFFFFF0080FF
      FF0080FFFF0080FFFF0000C0FF00006080000000000000000000000000000000
      0000000000000000000097635A00FFFFFF00FFFAFA00FBE8E700FFD9D900FFD9
      D900FFC6C600FFC0B700FEABAA0097635A000000000000000000000000000000
      0000000000000000000000000000FF602000FFFF8000FFFF8000FFFF8000FFFF
      8000FFFF8000FFFF8000FFFF8000FFFF8000FFFF8000FF802000000000000000
      00000000000000000000000000000060600080FFFF0080FFFF000000C0000000
      C0000000FF000000FF000020800000C0FF0000C0FF0000C0FF000080C00000C0
      FF000080C000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF000080800000808000008080000080800000808000006060000060
      6000006060000060600000C0FF00006080000000000000000000000000000000
      0000000000000000000097635A00FEFBFC00FFFFFF00FFFAFA00FBE8E700FFD9
      D900FFD9D900FFC6C600FFC0B70097635A000000000000000000000000000000
      000000000000000000000000000000000000FF602000FFFF8000FFFF80000000
      0000FF602000FF602000FF602000FF602000FF602000FF602000000000000000
      00000000000000000000000000000060600080FFFF0080FFFF0080FFFF0080FF
      FF000000FF000000C00080FFFF0000C0FF0000C0FF0000C0FF0000C0FF0000C0
      FF000080C000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FFFF00FFFF
      FF0080FFFF0080FFFF0000C0FF00006080000000000000000000000000000000
      0000000000000000000097635A00FBE8E700FFFFFE00FFFFFE00FAFAFA00FBE8
      E700FFD9D900FFD9D900FFC6C60097635A000000000000000000000000000000
      00000000000000000000000000000000000000000000FF602000FFFF80000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000060600080FFFF0080FFFF0080FFFF0080FF
      FF000000C00080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF00000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FF
      FF00FFFFFF0080FFFF0000C0FF00006080000000000000000000000000000000
      0000000000005E5E5E006D6C6B006D6C6B00746E6E008B74730096818000B08E
      8A00B08E8A00C5A4A400D5BBB500905F5B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF6020000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000006060000060600000606000006060000060
      6000006060000060600000606000006060000060600000606000006060000060
      600000606000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF0000808000008080000080800000808000FFFFFF00FFFFFF00FFFF
      FF0080FFFF00FFFFFF0000C0FF00006080000000000000000000000000000000
      000098989800DBDBDB00E6E6E800D2CFCF00D2CFCF00B6B6B6009D9D9D008C8B
      8B00888686007A7777007A7777006D6C6B007A77770000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000060600080FFFF0080FFFF0080C0
      C00080FFFF0080C0C00000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000C0FF00006080000000000000000000000000000000
      0000000000009898980098989800989898009898980098989800D2CFCF00B1B1
      B100B1B1B100DBDBDB00E6E6E800E6E6E800A6A6A60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000606000006060000060
      6000006060000060600000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000C0FF00006080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000989898009898
      9800989898009898980098989800989898000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000C0000080FF000000C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000C0000080FF000000C00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000874B3800B34A6500874B
      380000000000000000000000000080808000FFC0C000FFC0C000FFC0C000FFC0
      C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
      C000FFC0C000FFC0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      C0000080FF000000FF000000C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000C0000080FF000000FF000000C00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000874B3800B34A6500B3634A00874B
      380000000000000000000000000080808000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFC0C00000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000C0000080
      FF000000FF000000C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000C0000080FF000000FF000000C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000874B3800B34A6500B3634A00874B38000000
      000000000000000000000000000080808000FFFFFF0080808000FFC0C000FFC0
      C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C00000000000FFFFFF00FFFF
      FF00FFFFFF00FFC0C00000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000080FF000000
      FF000000C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000080FF000000FF000000C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000B34A6500B3634A00874B3800000000000000
      000000000000000000000000000080808000FFFFFF0080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFC0C00000000000FFFFFF00FFFF
      FF00FFFFFF00FFC0C00000000000000000000000000000000000000000008080
      800000000000FF800000FF800000FF8000008060200080602000000000000000
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800000000000FF800000FF800000FF800000806020008060
      2000000000000000C00000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000000000004AB39E004AB3
      9E004AB39E003C6362003C63620000000000874B380000000000000000000000
      000000000000000000000000000080808000FFFFFF0080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFC0C00000000000FFFFFF00FFFF
      FF00FFFFFF00FFC0C000000000000000000000000000000000008080800080A0
      A000FFC02000FFC02000FFC02000FFC02000FF800000FF800000806020000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008080800080A0A000FFC02000FFC02000FFC02000FFC02000FF800000FF80
      0000806020000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080009689930060BCBD0060BCBD0060BC
      BD0060BCBD004AB39E004AB39E003C6362000000000000000000000000000000
      000000000000000000000000000080808000FFFFFF0080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFC0C00000000000FFFFFF00FFFF
      FF00FFFFFF00FFC0C0000000000000000000000000000000000080808000FFFF
      8000FFFF8000FFFF80000000000000000000FFC02000FF800000FF8000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000FFFF8000FFFF8000FFFF8000FFC08000FFC02000FFC02000FF80
      0000FF8000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808000A4C9D900A4C9D900A4C9D900A4D9
      CE0060BCBD0060BCBD004AB39E004AB39E000000000000000000000000000000
      000000000000000000000000000080808000FFFFFF00FF000000FF802000FF60
      2000FF602000FF602000FF602000FF602000FF60200000000000FFFFFF00FFFF
      FF00FFFFFF00FFC0C00000000000000000000000000080808000FFC08000FFFF
      8000FFFF8000FFFF80000000000000000000FFC02000FFC02000FF8000008060
      2000000000000000000000000000000000000000000000000000000000008080
      8000FFC08000FFFF8000FFFF8000FFFF8000FFFF8000FFFF8000FFC02000FFC0
      2000FF8000008060200000000000000000000000000000000000000000000000
      0000000000000000000080808000A4D9CE00A4C9D900A4C9D900A4C9D900A4C9
      D900A4C9D90060BCBD0060BCBD004AB39E003C63620000000000000000000000
      000000000000000000000000000080808000FFFFFF00FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF00000000000000FFC0C000FFFF
      FF00FFFFFF00FFC0C00000000000000000000000000080808000FFC08000FFFF
      C000000000000000000000000000000000000000000000000000FF800000FF80
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFC08000FFFFC00000000000000000000000000000000000000000000000
      0000FF800000FF80000000000000000000000000000000000000000000000000
      0000000000000000000080808000A4D9CE00D1E4EC00D1E4EC00D1E4EC00A4C9
      D900A4C9D900A4C9D90060BCBD004AB39E004AB39E0000000000000000000000
      000000000000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000008000FFC0
      C00000008000FFC0C00000000000000000000000000080808000FFC08000FFFF
      FF00000000000000000000000000000000000000000000000000FFC02000FF80
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFC08000FFFFFF0000000000000000000000000000000000000000000000
      0000FFC02000FF80000000000000000000000000000000000000000000000000
      0000000000000000000080808000A4D9CE00FFFFFF00FFFFFF00D1E4EC00D1E4
      EC00A4C9D900A4C9D900A4D9CE0060BCBD004AB39E0000000000000000000000
      000000000000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      800000008000FFC0C0000000000000000000000000008080800080A0A000FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFF8000FFFF8000FFC02000FF80
      0000000000000000000000000000000000000000000000000000000000008080
      800080A0A000FFFFFF00FFFFFF00FFFFFF00FFFFC000FFFFC000FFFF8000FFFF
      8000FFC02000FF80000000000000000000000000000000000000000000000000
      000000000000000000008080800096899300FFFFFF00FFFFFF00FFFFFF00D1E4
      EC00D1E4EC00A4C9D900A4C9D90060BCBD004AB39E0000000000000000000000
      000000000000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004000FF004000
      FF0000008000FFC0C0000000000000000000000000000000000080808000FFC0
      8000FFFFFF00FFFFFF000000000000000000FFFF8000FFFF8000FFC020000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000FFC08000FFFFFF00FFFFFF00FFFFFF00FFFFC000FFFF8000FFFF
      8000FFC020000000000000000000000000000000000000000000000000000000
      000000000000000000000000000080808000A4D9CE00FFFFFF00FFFFFF00FFFF
      FF00D1E4EC00A4C9D900A4C9D90060BCBD000000000000000000000000000000
      000000000000000000000000000080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFC0C000000000000000000000000000000000008080800080A0
      A000FFC08000FFFFFF00FFFFFF00FFFFC000FFFF8000FFC08000FF8020000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008080800080A0A000FFC08000FFFFFF00FFFFFF00FFFFC000FFFF8000FFC0
      8000FF8020000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008080800096899300A4D9CE00FFFFFF00FFFF
      FF00D1E4EC00A4C9D900A4D9CE0060BDA4000000000000000000000000000000
      0000000000000000000000000000808080004040400040404000404040004040
      4000404040004040400040404000404040004040400040404000404040004040
      4000404040004040400000000000000000000000000000000000000000008080
      80008080800080A0A000FFC08000FFC08000FFC0800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000808080008080800080A0A000FFC08000FFC08000FFC080008080
      8000808080000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000808080008080800096899300A4D9
      CE00A4D9CE00A4D9CE0080808000808080000000000000000000000000000000
      000000000000000000000000000080808000FFC0C00080A0A00080A0A00080A0
      A00080A0A00080A0A00080A0A00080A0A00080A0A00080A0A00080A0A00080A0
      A00080A0A00080A0A00000000000000000000000000000000000000000000000
      0000000000008080800080808000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000404
      0400040404000404040004040400040404000404040004040400040404000404
      0400040404000404040000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000006080000080C0000000
      0000000000000000000000000000000000000000800000008000000000000000
      000000000000000000000000000000000000000000000000000004040400FFFF
      FF00EAEAEA00EAEAEA00DDDDDD00DDDDDD00CCCCCC00CCCCCC00B2B2B200B2B2
      B200040404005F5F5F0004040400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000FFC0C000FFC0
      C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C00000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
      C00000000000000000000000000000000000000000000060800000C0FF000000
      000000000000000000000000000000000000000080004000FF00000000000000
      0000000000000000000000000000000000000000000004040400040404000404
      0400040404000404040004040400040404000404040004040400040404000404
      040004040400040404005F5F5F00040404000000000000000000000000000000
      000000000000000000000000000000000000000000008080800080FFFF00FF00
      0000FF000000FF000000FF000000FF000000FFC0C00000000000000000000000
      0000000000000060600040808000408080004080800040808000408080004080
      800080808000FFFFFF00FF200000FF200000FF200000FF200000FF200000FFC0
      C00000000000000000000000000000000000000000000060800080FFFF000000
      000000000000000000000000000000000000000080004000FF00000000000000
      0000000000000000000000000000000000000000000086868600FFFFFF00EAEA
      EA00DDDDDD00CCCCCC00CCCCCC00CCCCCC0000FF000000FF000000FF0000CCCC
      CC00CCCCCC000404040004040400040404000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000FFFFFF0080FF
      FF00FFFFFF0080FFFF00FFFFFF0080FFFF00FFC0C00000000000000000000000
      0000000000000060600080C0C00080C0C0004080800080C0C000408080004080
      80008080800080FFFF00FFFFFF0080FFFF00FFFFFF0080FFFF00FFC0C000FFC0
      C00000000000000000000000000000000000000000000060800000C0FF000000
      000000000000000000000000000000000000000080004000FF00000000000000
      0000000000000000000000000000000000000000000086868600FFFFFF00FFFF
      FF00EAEAEA00DDDDDD00CCCCCC00CCCCCC00008000000080000000800000CCCC
      CC00CCCCCC000404040086868600040404000000000000000000000000008080
      8000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C0008080800080FFFF00FF00
      0000FF000000FF000000FF000000FF000000FFC0C00000000000000000000000
      00000000000000606000FFFFFF0080C0C00080C0C00080C0C00080C0C0004080
      800080808000FFFFFF00FF000000FF000000FFFFFF0040606000000000000000
      000000000000000000000000000000000000FFC0C0000060800080FFFF000000
      0000FFC0C000FFC0C000FFC0C000FFC0C000000080004000FF0000000000FFC0
      C000FFC0C0000000000000000000000000000000000086868600868686008686
      8600868686008686860086868600868686008686860086868600868686008686
      8600868686000404040086868600868686000404040000000000000000008080
      8000FFFFFF008020000080200000802000008020000080808000FFFFFF0080FF
      FF00FFFFFF0080FFFF00FFFFFF00FFC0C000FFC0C00000000000000000000000
      0000000000000060600080C0C000FFFFFF0080C0C00080C0C0004080800080C0
      C00080808000FFFFFF0080FFFF00FFFFFF0080FFFF0080808000FFFFFF000000
      000000000000000000000000000000000000FFFFFF000060800000C0FF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000080004000FF0000000000FFFF
      FF00FFC0C0000000000000000000000000000000000086868600FFFFFF00FFFF
      FF00FFFFFF00EAEAEA00EAEAEA00DDDDDD00DDDDDD00CCCCCC00CCCCCC00CCCC
      CC00040404008686860004040400868686000404040000000000000000008080
      800080FFFF00FFFFFF0080FFFF00FFFFFF0080FFFF0080808000FFFFFF00FF60
      2000FF602000FFFFFF0000000000000000000000000000000000000000000000
      00000000000000606000FFFFFF0080C0C000FFFFFF0080C0C00080C0C00080C0
      C00080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000000000000000
      000000000000000000000000000000000000FFFFFF000060800080FFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000800040C0FF0000000000FFFF
      FF00FFC0C0000000000000000000000000000000000000000000868686008686
      8600868686008686860086868600868686008686860086868600868686008686
      8600868686000404040086868600040404000404040000000000000000008080
      8000FFFFFF008020000080200000802000008020000080808000FFFFFF00FFFF
      FF00FFFFFF0080FFFF0080808000FFFFFF000000000000000000000000000000
      00000000000000606000FFFFFF00FFFFFF0080C0C000FFFFFF0080C0C00080C0
      C000808080008080800080808000808080008080800080808000000000000000
      000000000000000000000000000000000000FFFFFF000060800000C0FF000000
      0000FFFFFF00FFFFFF0000000000FFFFFF0000000000FFC0C00000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000008686
      8600CCCCCC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00040404008686860004040400868686000404040000000000000000008080
      800080FFFF00FFFFFF0080FFFF00FFFFFF0080FFFF0080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080808000000000000000000000000000000000000000
      00000000000000606000FFFFFF00FFFFFF00FFFFFF0080C0C000FFFFFF0080C0
      C00080C0C0004080800080C0C0004080800080C0C00040808000000000000000
      0000000000000000000000000000000000000060800000C0FF0080FFFF000060
      80000000000000000000FFC0C0000000000080808000FFFFFF00808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000086868600FFFFFF00FF333300FF333300FF333300FF333300FF333300FFFF
      FF00040404000404040004040400040404000000000000000000000000008080
      8000FFFFFF008020000080200000FFFFFF000000000080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      00000000000000606000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000004080800040808000000000000000
      00000000000000000000000000000060800000C0FF0080FFFF000060800080FF
      FF000060800000000000FFFFFF0080808000FFFFFF00FFFFFF00FFC0C0000000
      0000FFC0C0000000000000000000000000000000000000000000000000000000
      000086868600CCCCCC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CCCCCC000404040000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF0080FFFF0080808000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000606000FFFFFF00FFFFFF000080C00080FFFF0000C0FF0000C0
      FF0000C0FF000080C00000608000000000004080800040808000000000000000
      00000000000000000000000000000060800080FFFF0000000000FFFFFF000060
      800080FFFF000000000080808000FFFFFF00808080008080800080808000FFFF
      FF00FFC0C0000000000000000000000000000000000000000000000000000000
      00000000000086868600FFFFFF00FF663300FF663300FF663300FF663300FF66
      3300FFFFFF000404040000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000606000FFFFFF00FFFFFF00FFFFFF000080C00080FFFF000060
      6000006060000080C000000000004080800080C0C00040808000000000000000
      00000000000000000000000000000060800080FFFF0000000000FFFFFF000060
      800000FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFC0C0000000000000000000000000000000000000000000000000000000
      00000000000086868600CCCCCC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CCCCCC0004040400000000000000000000000000000000008080
      8000808080008080800080808000808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000006060000060600000606000006060000080C000FFFF
      FF0080FFFF000000000000606000006060000060600000606000000000000000
      0000000000000000000000000000FF0000000060800080FFFF000000000080FF
      FF00000000008000000080000000800000008000000080000000800000008000
      0000800000000000000000000000000000000000000000000000000000000000
      0000000000000000000086868600868686008686860086868600868686008686
      8600868686008686860086868600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000080C0000080
      C0000080C0000060800000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF80200000608000FF6020000060
      8000FF602000FF602000FF602000FF602000FF602000FF602000FF602000FF60
      2000FF6020000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000666600006666000080
      C0000080C000008080000080C000008080000080C000008080000080C0000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000606000408080004080800000202000002020000020
      200000202000002020000020200080A0A00080A0A00000202000006060000000
      000000000000000000000000000000000000000000000080C0000080C0000080
      C000008080000080C000008080000080C000008080000080C000000000000000
      000000000000000000000000000000000000000000000066660080FFFF000066
      66000080C0000080C0000080C0000080C000008080000080C000008080000080
      C000008080000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000006060004080800080C0C00040404000404040000020
      2000002020000020200000202000FFC0C00080A0A00000202000408080000000
      000000000000000000000000000000000000000000000080C0000080C0000080
      C0000080C000008080000080C000008080000080C00000808000000000000000
      000000000000000000000000000000000000000000000066660080FFFF0000C0
      FF00006666000080C0000080C0000080C0000080C0000080C0000080C0000080
      80000080C0000080800000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000060600080C0C00080C0C00040404000404040004040
      4000404040004040400000202000FFFFFF00FFC0C00000202000408080000000
      000000000000000000000000000000000000000000000080C0000080C0000080
      C0000080C0000080C0000080C0000080C000008080000080C000000000000000
      000000000000000000000000000000000000000000000066660080FFFF00FFFF
      FF0000C0FF00006666000080C0000080C0000080C0000080C0000080C0000080
      C000008080000080C00000808000000000000000000000000000000000000000
      00000000000000000000FF000000FF0000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      000000000000000000000060600080C0C00080C0C00040404000404040004040
      4000404040004040400040404000404040004040400000202000408080000000
      000000000000000000000000000000000000000000000080C0000080C0000080
      C0000080C0000080C0000080C0000080C0000080C00000808000000000000000
      000000000000000000000000000000000000000000000066660080FFFF0000C0
      FF00FFFFFF0000C0FF0000666600006666000066660000666600006666000066
      660000666600006666000066660000666600000000000000000000000000FF00
      0000FF000000FF000000FF800000FF000000FF000000FF000000000000000000
      000000000000FF000000FF000000FF0000000000000000000000000000000000
      0000000000000000000000606000FFFFFF0080C0C00080C0C00080C0C00080C0
      C00080C0C00080C0C00080C0C00080C0C00080C0C00080C0C000408080000000
      000000000000000000000000000000000000000000000080C0000080C0000080
      C0000080C0000080C0000080C0000080C0000080C0000080C000000000000000
      000000000000000000000000000000000000000000000066660080FFFF00FFFF
      FF0000C0FF00FFFFFF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF800000FF800000FF800000FF00000000000000000000000000
      0000FF000000FF800000FF800000FF800000FF00000000000000000000000000
      0000000000000000000000606000FFFFFF0080C0C00000606000006060000060
      6000006060000060600000606000006060000060600080C0C000408080000000
      000000000000000000000000000000000000000000000080C0000080C0000080
      C0000080C0000080C0000080C0000080C0000080C0000080C000000000000000
      000000000000000000000000000000000000000000000066660080FFFF0000C0
      FF00FFFFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000000000000000000000000000FF00
      0000FF000000FF000000FF800000FF000000FF000000FF000000000000000000
      0000000000000000000000606000FFFFFF0040808000FFFFFF00FFFFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF000060600080C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000080C0000080C0000080C0000080C0000080C0000080C000000000000000
      0000000000000000000000000000000000000000000000666600FFFFFF0080FF
      FF0080C0C0000066660000666600006666000066660000666600006666000066
      6600000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000606000FFFFFF0040808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080FFFF0080FFFF000060600080C0C0000000
      0000000000000000000000000000000000000000000000C0FF00FFFFFF0000C0
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000006666000066
      6600006666000000000000000000000000000000000000000000000000000000
      0000000000004020000040200000402000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000606000FFFFFF0040808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FFFF000060600080C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080200000402000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000000000000000000000000000000000000000
      0000000000000000000000606000FFFFFF0040808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FFFF000060600080C0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080200000000000000000
      0000000000008020000000000000402000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000606000FFFFFF0040808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FFFF0000606000006060000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000802000008020
      0000802000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000606000FFFFFF004080800040806000408060004080
      6000408060004080600040806000408060004080600000606000FFC0C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000606000006060004080800040806000408060004080
      6000408060004080600040806000408060004080600000606000006060000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000048000000A20000000100010000000000980700000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFC0000000000000000000FFFFC0000000000000000000
      FFFFC00000000000000000008000400000000000000000008000400000000000
      0000000080004000000000000000000080004000000000000000000080004000
      0000000000000000800040000000000000000000800040000000000000000000
      8000400000000000000000008000400000000000000000008000400000000000
      00000000800040000000000000000000800040000000000000000000FFFFC000
      0000000000000000FFFFC0000000000000000000FFFFC0000000000000000000
      FFFFFFFFFFFFFFFFFF000000FC1FFF07FFC1FF8007000000F007FC01FF007F80
      07000000E003F800FE003F8007000000C001F0007C001F8007000000C001F000
      7C001F80070000008000E00038000F80070000008000E00038000F8007000000
      8000E00038000F80070000008000E00038000F80070000008000E00038000F80
      07000000C001F0007C001F8007000000C001F0007C001F8007000000E003F800
      FE003F8007000000F007FC01FF007F800F000000FC1FFF07FFC1FF801F000000
      FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
      FF000000C001F0007FC1FFF07F000000C001F0007F007FC01F000000C001F000
      7E003F800F000000C001F0007C001F0007000000C001F0007C001F0007000000
      C001F00078000E0003000000C001F00078000E0003000000C001F00078000E00
      03000000C001F00078000E0003000000C001F00078000E0003000000C001F000
      7C001F0007000000C001F0007C001F0007000000C001F0007E003F800F000000
      C003F000FF007FC01F000000C007F001FFC1FFF07F000000C00FF003FFFFFFFF
      FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFCF
      FFE0070003000000FFFFFF07FFC0070003000000FFFFFC03FF00070003000000
      FFDFF001FE00070003000000FFCFE000FC00070003000000FFC7E0007C000700
      03000000E003E0003800070003000000E001E0001800070003000000E001E000
      1800070003000000E003F0003800070003000000FFC7F80038000F0003000000
      FFCFFC001C001F0003000000FFDFFE003C001F0003000000FFFFFF00FE003F00
      07000000FFFFFF83FF007F000F000000FFFFFFCFFFC1FF001F000000FFFFFFFF
      FFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000E0007F7FFFFFFFFFFF000000
      C0007F33FFFFFE000300000080007F87FFFFFE000300000080007C0FFFEFFE00
      03000000C0007C03FFCFFE0003000000C0007C00FF8FFE0003000000C0007C00
      FF001E0003000000C0007C00FE001E0003000000C0007C00FE001E0003000000
      C0007C00FF001E0003000000C0007C00FF8FFE0003000000C0007800FFCFFE00
      03000000C00070007FEFFF01FF000000C00078007FFFFF83FF000000C0007FC0
      FFFFFFFFFF000000C000FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFF000000FFF9FFFE7927CE0001000000FFF0FFFC39278600
      01000000FFE0FFF83FFF060001000000FFC1FFF07FFE0E0001000000F803FE00
      FFC01E0001000000E007F801FF003E0001000000C00FF003FE007E0001000000
      C00FF003FE007E00010000008007E001FC003E00010000008007E001FC003E00
      010000008007E001FC003E00010000008007E001FC003E0001000000C00FF003
      FE007E0001000000C00FF003FE007E0001000000E01FF807FF00FE0001000000
      F87FFE1FFFC3FE0001000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
      FF000000FFFFFFFFFFFFFFDF1F000000E003FF803FF0078F1F000000C001FF80
      3C00078F1F0000008000FF803800078F1F0000008000E0003800060003000000
      8000E00038000600030000008000600038000E00030000008000600038001E00
      03000000C000600078001E0003000000E0006000F8001E0003000000F000E001
      F8001E0003000000F003E01FF8001E0003000000F803E03FF8001E0003000000
      F801E07FFC003E0003000000FC01FFFFFFC3FE0003000000FFFFFFFFFFFFFE00
      03000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF
      FFFFFFFFFF000000800FFF07FE000F001F0000008007FE7BFC000F001F000000
      8003FCFFFC000F001F0000008001FCFFFC000F001F0000008000FCFCFC000F00
      1F000000800060187C000F001F000000800FF0303C000F001F000000800FF860
      1C000F001F000000800FFCFCFC000F001F000000C7F8FFFCFC000F8FFB000000
      FFFCFFFCFC000FFE3B000000FFBAFF79FC000FFE73000000FFC7FF83FC000FFE
      87000000FFFFFFFFFC000FFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF
      FFFFFFFFFF00000000000000000000000000000000000000000000000000}
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
    Bitmap = {
      494C01011D002200040012001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000048000000A2000000010020000000000040B6
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A300A7A7A700A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A700A7A7A700A7A7A700AFAFAF00A3A3A30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A300999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990099999900A7A7A700A3A3A30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A3008E8E8E008E8E
      8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E8E008E8E
      8E008E8E8E008E8E8E008E8E8E0096969600A5A5A50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A300838383008383
      8300838383008383830083838300838383008383830083838300838383008383
      830083838300838383008E8E8E00E9E9E900A3A3A30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A300797979007979
      790079797900797979007979790079797900DADADA00DADADA00838383007979
      790079797900A2A2A200FBFBFB00FFFFFF00A3A3A30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A300838383007979
      7900797979007979790079797900B8B8B800E1E1E100EBEBEB00EBEBEB008888
      8800DADADA00F9F9F900FCFCFC00FCFCFC00A3A3A30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A300C7C7C7008383
      83007070700070707000A2A2A200CECECE00DCDCDC00DCDCDC00DFDFDF00DFDF
      DF00E5E5E500EBEBEB00EBEBEB00F2F2F200A3A3A30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A300BABABA00BFBF
      BF007575750083838300C7C7C700C7C7C700C7C7C700CECECE00CECECE00D7D7
      D700DCDCDC00DCDCDC00DFDFDF00E5E5E500A3A3A30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A300BABABA00BABA
      BA00BABABA00BABABA00BABABA00BFBFBF00BFBFBF00BFBFBF00C7C7C700C7C7
      C700C7C7C700CECECE00CECECE00DCDCDC00A3A3A30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A300BABABA00BABA
      BA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00BFBF
      BF00BFBFBF00BFBFBF00C7C7C700CECECE00A3A3A30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3
      A300A3A3A300A3A3A300A3A3A300A3A3A300A3A3A30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000093939300939393009393930093939300939393000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008383830083838300838383008383
      8300838383000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000838383008383
      8300838383008383830083838300000000000000000000000000000000000000
      000000000000000000000000000000000000000000009E9E9E009E9E9E009E9E
      9E009E9E9E009E9E9E009E9E9E009E9E9E009E9E9E009E9E9E009E9E9E009E9E
      9E008C8C8C000000000000000000000000000000000000000000000000000000
      00009F9F9F009393930093939300939393009393930093939300939393008989
      8900898989000000000000000000000000000000000000000000000000000000
      0000000000000000000083838300838383008B8B8B0091919100919191009191
      91008B8B8B008383830083838300000000000000000000000000000000000000
      00000000000000000000000000000000000087878700878787008A8A8A008C8C
      8C008C8C8C008C8C8C0088888800888888008383830000000000000000000000
      0000000000000000000000000000000000000000000098989800E9E9E900E5E5
      E500E5E5E500E1E1E100E1E1E100E1E1E100DEDEDE00DEDEDE00DEDEDE00D7D7
      D7008C8C8C000000000000000000000000000000000000000000000000009F9F
      9F009F9F9F009F9F9F009B9B9B009B9B9B009B9B9B0093939300939393009393
      9300898989008989890000000000000000000000000000000000000000000000
      0000000000008E8E8E008E8E8E00919191009191910091919100919191009191
      910091919100919191008C8C8C008C8C8C000000000000000000000000000000
      00000000000000000000000000008E8E8E008B8B8B0091919100919191009191
      9100919191009191910091919100919191008585850085858500000000000000
      0000000000000000000000000000000000000000000098989800EFEFEF00EBEB
      EB00EBEBEB00E5E5E500E1E1E100E1E1E100DEDEDE00DEDEDE00D7D7D700D7D7
      D7008C8C8C0000000000000000000000000000000000000000009F9F9F00A3A3
      A300A3A3A300C0C0C000A1A1A100A1A1A1009B9B9B009B9B9B0093939300C0C0
      C000B3B3B3009393930089898900000000000000000000000000000000000000
      0000838383008C8C8C0091919100919191009191910091919100919191009191
      910091919100A5A5A500919191008C8C8C008C8C8C0000000000000000000000
      00000000000000000000878787008C8C8C009191910091919100919191009191
      9100919191009191910091919100919191009191910087878700838383000000
      00000000000000000000000000000000000000000000A0A0A000EFEFEF00EFEF
      EF00E5E5E500E5E5E500C3C3C300DFDFDF00DFDFDF00DFDFDF00DFDFDF00D7D7
      D7008C8C8C000000000000000000000000000000000000000000A7A7A700A7A7
      A700D2D2D200FCFCFC00E7E7E700A1A1A100A1A1A100A1A1A100D2D2D200FCFC
      FC00DEDEDE009393930089898900000000000000000000000000000000000000
      0000878787009191910091919100DDDDDD00FFFFFF0091919100919191009191
      9100A0A0A000FFFFFF0091919100919191008787870000000000000000000000
      00000000000000000000878787009191910091919100FDFDFD00A0A0A0009191
      91009191910091919100FFFFFF00DFDFDF009191910091919100858585000000
      00000000000000000000000000000000000000000000A5A5A500F2F2F200EFEF
      EF00D6D6D600AAAAAA00A6A6A600C3C3C300DFDFDF00DFDFDF00DFDFDF00DFDF
      DF009898980000000000000000000000000000000000A9A9A900A9A9A900A9A9
      A900A9A9A900E7E7E700FFFFFF00E7E7E700A1A1A100D2D2D200FFFFFF00F6F6
      F600AEAEAE009393930093939300898989000000000000000000000000008383
      8300919191009191910091919100DDDDDD00FFFFFF009191910091919100A0A0
      A000FFFFFF00FFFFFF0091919100919191008E8E8E008B8B8B00000000000000
      00000000000095959500929292009292920092929200FFFFFF00F5F5F500A0A0
      A0009191910091919100FFFFFF00DFDFDF0091919100919191008A8A8A008A8A
      8A000000000000000000000000000000000000000000A9A9A900F5F5F500C3C3
      C300A6A6A600A6A6A600AAAAAA00A6A6A600D7D7D700E1E1E100E1E1E100DEDE
      DE009898980000000000000000000000000000000000A9A9A900A7A7A700A7A7
      A700A7A7A700A7A7A700E7E7E700FFFFFF00F6F6F600FEFEFE00F6F6F600AEAE
      AE009F9F9F009B9B9B009B9B9B00898989000000000000000000000000008383
      83009B9B9B009898980092929200DDDDDD00FFFFFF0093939300A0A0A000FDFD
      FD00FDFDFD00FDFDFD009191910091919100919191008B8B8B00000000000000
      000000000000959595009B9B9B009595950092929200FFFFFF00FFFFFF00FFFF
      FF00B2B2B20090909000FFFFFF00DFDFDF009191910091919100919191008B8B
      8B000000000000000000000000000000000000000000ACACAC00F9F9F900D6D6
      D600C3C3C300E9E9E900D3D3D300A6A6A600ACACAC00E1E1E100E1E1E100E1E1
      E1009898980000000000000000000000000000000000A9A9A900A7A7A700A7A7
      A700A7A7A700A7A7A700A7A7A700F6F6F600FFFFFF00FCFCFC00B3B3B300A3A3
      A3009F9F9F009F9F9F009B9B9B00898989000000000000000000000000008C8C
      8C009F9F9F009F9F9F009B9B9B00DFDFDF00FFFFFF009B9B9B00F5F5F500FFFF
      FF00FFFFFF00FFFFFF009191910091919100919191008B8B8B00000000000000
      000000000000959595009F9F9F009B9B9B0098989800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF009B9B9B00FFFFFF00DFDFDF009191910091919100919191008B8B
      8B000000000000000000000000000000000000000000B5B5B500F9F9F900F9F9
      F900F5F5F500F2F2F200EFEFEF00C3C3C300A6A6A600D6D6D600E5E5E500E1E1
      E1009E9E9E0000000000000000000000000000000000A9A9A900A7A7A700A7A7
      A700A7A7A700A7A7A700D2D2D200FDFDFD00FDFDFD00FDFDFD00E7E7E700A9A9
      A900A3A3A3009F9F9F009F9F9F00939393000000000000000000000000009090
      9000A6A6A600A2A2A2009F9F9F00DFDFDF00FEFEFE0095959500A0A0A000FFFF
      FF00FFFFFF00FFFFFF009191910091919100919191008B8B8B00000000000000
      00000000000095959500A6A6A600A2A2A2009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00B2B2B20091919100FFFFFF00DFDFDF009191910091919100919191008B8B
      8B000000000000000000000000000000000000000000B5B5B500FDFDFD00F9F9
      F900F9F9F900F5F5F500F2F2F200E9E9E900A6A6A600A6A6A600E1E1E100E5E5
      E500A1A1A10000000000000000000000000000000000A9A9A900A9A9A900A9A9
      A900A9A9A900D2D2D200FDFDFD00F6F6F600B3B3B300E7E7E700FFFFFF00E7E7
      E700A9A9A900A3A3A300A3A3A300939393000000000000000000000000009090
      9000ABABAB00A7A7A700A7A7A700E1E1E100FFFFFF009B9B9B0095959500B2B2
      B200FFFFFF00FFFFFF009191910091919100919191008B8B8B00000000000000
      00000000000091919100A9A9A900A6A6A600A3A3A300FEFEFE00FEFEFE00C3C3
      C3009595950092929200FFFFFF00DFDFDF009191910091919100919191008B8B
      8B000000000000000000000000000000000000000000BABABA00FFFFFF00FFFF
      FF00F9F9F900F9F9F900F5F5F500F2F2F200D6D6D600ACACAC00DFDFDF00E9E9
      E900A1A1A1000000000000000000000000000000000000000000AEAEAE00AEAE
      AE00B3B3B300FBFBFB00F6F6F600AEAEAE00A7A7A700A7A7A700E7E7E700FDFD
      FD00DEDEDE00A7A7A70093939300000000000000000000000000000000000000
      00009B9B9B00AEAEAE00A9A9A900E5E5E500FFFFFF009F9F9F009B9B9B009898
      9800B2B2B200FDFDFD0091919100919191008B8B8B0000000000000000000000
      000000000000000000009B9B9B00ABABAB00A7A7A700FFFFFF00D8D8D8009D9D
      9D009D9D9D0098989800FFFFFF00DFDFDF009191910091919100888888000000
      00000000000000000000000000000000000000000000BDBDBD00FFFFFF00FFFF
      FF00FFFFFF00F9F9F900F9F9F900F5F5F500F2F2F200EFEFEF00E9E9E900E9E9
      E900A3A3A3000000000000000000000000000000000000000000AEAEAE00C0C0
      C000B3B3B300D2D2D200B3B3B300A7A7A700A7A7A700A7A7A700A7A7A700DEDE
      DE00C0C0C000A7A7A70093939300000000000000000000000000000000000000
      00009B9B9B00BFBFBF00B2B2B200B2B2B200A3A3A300A6A6A600A2A2A2009D9D
      9D009D9D9D009D9D9D0092929200929292008585850000000000000000000000
      000000000000000000009B9B9B00BABABA00AEAEAE00BFBFBF00A6A6A600A3A3
      A3009F9F9F009F9F9F009F9F9F009B9B9B009292920092929200888888000000
      00000000000000000000000000000000000000000000C3C3C300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00F9F9F900F9F9F900F5F5F500E9E9E900D2D2D200C5C5
      C500A3A3A300000000000000000000000000000000000000000000000000AEAE
      AE00C0C0C000B3B3B300AEAEAE00A9A9A900A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A7009393930000000000000000000000000000000000000000000000
      000000000000A0A0A000BFBFBF00BABABA00B2B2B200ABABAB00A7A7A700A3A3
      A3009F9F9F009F9F9F009B9B9B00878787000000000000000000000000000000
      0000000000000000000000000000A0A0A000BFBFBF00B2B2B200AEAEAE00A7A7
      A700A7A7A700A2A2A2009F9F9F009B9B9B009898980085858500000000000000
      00000000000000000000000000000000000000000000C3C3C300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F9F9F900F9F9F900A5A5A500A5A5A500A5A5
      A500A5A5A5000000000000000000000000000000000000000000000000000000
      0000AEAEAE00A9A9A900C0C0C000B3B3B300AEAEAE00A9A9A900A7A7A700A7A7
      A700A7A7A7000000000000000000000000000000000000000000000000000000
      00000000000000000000A0A0A000A0A0A000BFBFBF00B2B2B200AEAEAE00A7A7
      A700A7A7A7008B8B8B008B8B8B00000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A000A0A0A000BABABA00B2B2
      B200ABABAB00A7A7A700A3A3A3008B8B8B008B8B8B0000000000000000000000
      00000000000000000000000000000000000000000000C5C5C500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F9F9F900A5A5A500CECECE00C5C5
      C500000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A9A9A900A9A9A900A9A9A900A9A9A900A9A9A9000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C5C5C500BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00A5A5A500CACACA000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000515151005151
      5100515151005151510051515100515151005151510051515100515151005151
      5100515151005151510051515100000000000000000000000000000000000000
      0000515151005151510051515100515151005151510051515100515151005151
      5100515151005151510051515100515151005151510000000000000000000000
      0000000000000000000000000000000000000000000000000000818181008181
      8100818181008181810081818100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000838383008383830083838300838383008383830000000000000000000000
      0000000000000000000000000000000000000000000000000000A8A8A800E9E9
      E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9
      E900E9E9E900E9E9E90051515100000000000000000000000000000000000000
      0000A8A8A800E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9
      E900E9E9E900E9E9E900E9E9E900E9E9E9005151510000000000000000000000
      0000000000000000000000000000000000007070700070707000828282008585
      8500858585008585850085858500707070007070700000000000000000000000
      0000000000000000000000000000000000000000000000000000838383008383
      83008C8C8C009191910091919100919191009191910083838300838383000000
      0000000000000000000000000000000000000000000000000000A8A8A800F6F6
      F600F6F6F600F6F6F600F3F3F300F3F3F300F3F3F300F3F3F300F0F0F000F0F0
      F000F0F0F000E9E9E90051515100000000000000000000000000000000000000
      0000A8A8A800F6F6F600F6F6F600F6F6F600F3F3F300F3F3F300F3F3F300F3F3
      F300F0F0F000F0F0F000F0F0F000E9E9E9005151510000000000000000000000
      000000000000000000000000000070707000828282008E8E8E008A8A8A008A8A
      8A008A8A8A008585850085858500858585008585850069696900000000000000
      000000000000000000000000000000000000000000008E8E8E008E8E8E009191
      9100919191009191910091919100919191009191910091919100919191008383
      8300000000000000000000000000000000000000000000000000A8A8A800F7F7
      F700F7F7F700F7F7F7006F6F6F00F3F3F300F3F3F300F3F3F300F1F1F100F1F1
      F100F1F1F100E9E9E90051515100000000000000000000000000000000000000
      0000A8A8A800F7F7F700F7F7F700F7F7F700F5F5F500F5F5F500F5F5F5006F6F
      6F00F1F1F100F1F1F100F1F1F100E9E9E9005151510000000000000000000000
      000000000000000000007070700085858500919191008E8E8E008E8E8E008E8E
      8E008A8A8A008A8A8A008A8A8A00858585008585850085858500707070000000
      000000000000000000000000000000000000838383008C8C8C00919191009191
      9100919191009191910091919100919191009191910091919100919191009191
      9100868686000000000000000000000000000000000000000000A8A8A800F8F8
      F800F8F8F8006F6F6F00999999008080800079797900F3F3F300F3F3F300F3F3
      F300F0F0F000E9E9E90051515100000000000000000000000000000000000000
      0000A8A8A800F8F8F800F8F8F800F8F8F800F8F8F80079797900808080009999
      99006F6F6F00F1F1F100F1F1F100E9E9E9005151510000000000000000000000
      000000000000000000008282820096969600969696009191910091919100E9E9
      E900919191008A8A8A008A8A8A008A8A8A008585850085858500707070000000
      0000000000000000000000000000000000008383830091919100919191009191
      9100DDDDDD00FFFFFF0091919100C3C3C300FCFCFC00A5A5A500919191009191
      9100878787000000000000000000000000000000000000000000A8A8A800F9F9
      F9006F6F6F00B3B3B300A3A3A30099999900888888008383830076767600F2F2
      F200F2F2F200E9E9E90051515100000000000000000000000000000000000000
      0000A8A8A800F9F9F900F9F9F90076767600838383008888880099999900A3A3
      A300B3B3B3006F6F6F00F1F1F100E9E9E9005151510000000000000000000000
      000000000000858585008E8E8E0096969600969696009696960091919100FEFE
      FE00E9E9E900919191008E8E8E008A8A8A008A8A8A008A8A8A00858585006969
      6900000000000000000000000000909090009090900092929200929292009292
      9200DDDDDD00FFFFFF0091919100C3C3C300FBFBFB00A5A5A500919191009191
      9100919191008B8B8B0000000000000000000000000000000000A8A8A800FAFA
      FA00FAFAFA006F6F6F00A9A9A900797979007676760079797900838383007171
      7100F2F2F200E9E9E90051515100000000000000000000000000000000000000
      0000A8A8A800FAFAFA007171710083838300797979007676760079797900A9A9
      A9006F6F6F00F2F2F200F2F2F200E9E9E9005151510000000000000000000000
      000000000000858585009191910096969600969696009696960096969600FFFF
      FF00FFFFFF00F6F6F600919191008E8E8E008E8E8E008A8A8A008A8A8A006969
      690000000000000000000000000090909000989898009B9B9B00959595009292
      9200DDDDDD00FFFFFF0091919100C3C3C300FDFDFD00A5A5A500919191009191
      9100919191008B8B8B0000000000000000000000000000000000A8A8A800FAFA
      FA00FAFAFA00FAFAFA006F6F6F00F6F6F600F6F6F600F6F6F600797979007979
      7900F2F2F200E9E9E90051515100000000000000000000000000000000000000
      0000A8A8A800FAFAFA007979790079797900F8F8F800F8F8F800F8F8F8006F6F
      6F00F3F3F300F3F3F300F3F3F300E9E9E9005151510000000000000000000000
      000000000000858585009696960096969600969696009696960096969600FEFE
      FE00FEFEFE00FEFEFE00E9E9E900919191008E8E8E008E8E8E008A8A8A006969
      690000000000000000000000000090909000A2A2A2009F9F9F009B9B9B009898
      9800DFDFDF00FFFFFF0090909000C3C3C300FEFEFE00A5A5A500919191009191
      9100919191008B8B8B0000000000000000000000000000000000A8A8A800FBFB
      FB00FBFBFB00FBFBFB00F8F8F800F8F8F800F8F8F800F8F8F800F8F8F8007979
      7900F3F3F300E9E9E90051515100000000000000000000000000000000000000
      0000A8A8A800FBFBFB0079797900FAFAFA00FAFAFA00FAFAFA00F6F6F600F6F6
      F600F6F6F600F3F3F300F3F3F300E9E9E9005151510000000000000000000000
      000000000000858585009999990096969600969696009696960096969600FFFF
      FF00FFFFFF00F6F6F6009696960091919100919191008E8E8E008E8E8E006969
      690000000000000000000000000090909000A3A3A300A3A3A300A3A3A3009D9D
      9D00DFDFDF00FFFFFF0092929200C3C3C300FCFCFC00A5A5A500919191009191
      9100919191008B8B8B0000000000000000000000000000000000A8A8A800FCFC
      FC00FCFCFC00FCFCFC00F9F9F900F9F9F900F9F9F900F9F9F900F6F6F6007171
      7100F3F3F300E9E9E90051515100000000000000000000000000000000000000
      0000A8A8A800FCFCFC0071717100FAFAFA00FAFAFA00FAFAFA00F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700E9E9E9005151510000000000000000000000
      000000000000858585009191910099999900969696009696960096969600FFFF
      FF00F6F6F6009696960096969600969696009696960091919100919191006969
      690000000000000000000000000090909000A1A1A100A9A9A900A6A6A600A2A2
      A200DDDDDD00FFFFFF0098989800C3C3C300FDFDFD00A5A5A500919191009191
      9100919191008B8B8B0000000000000000000000000000000000A8A8A800FDFD
      FD00FDFDFD00FDFDFD00FAFAFA00FAFAFA00FAFAFA00F7F7F700F7F7F700F7F7
      F700F7F7F700E9E9E90051515100000000000000000000000000000000000000
      0000A8A8A800FDFDFD00FDFDFD00FDFDFD00FAFAFA00FAFAFA00FAFAFA00F7F7
      F700F7F7F700F7F7F700F7F7F700E9E9E9005151510000000000000000000000
      0000000000000000000085858500AFAFAF00A0A0A0009696960099999900F8F8
      F800969696009696960096969600969696009696960096969600707070000000
      0000000000000000000000000000000000009B9B9B00B2B2B200ABABAB00A7A7
      A700E1E1E100FEFEFE009D9D9D00C3C3C300FDFDFD00A5A5A500919191009191
      91008B8B8B000000000000000000000000000000000000000000A8A8A800FEFE
      FE00FEFEFE00FEFEFE00FBFBFB00FBFBFB00FBFBFB00F8F8F800F8F8F800F8F8
      F800E9E9E900E9E9E90051515100000000000000000000000000000000000000
      0000A8A8A800FEFEFE00FEFEFE00FEFEFE00FBFBFB00FBFBFB00FBFBFB00F8F8
      F800F8F8F800F8F8F800E9E9E900E9E9E9005151510000000000000000000000
      0000000000000000000085858500AFAFAF00BDBDBD00A7A7A700999999009696
      9600969696009696960096969600969696009696960096969600858585000000
      0000000000000000000000000000000000009B9B9B00B2B2B200BABABA00AEAE
      AE00B2B2B200A3A3A300A3A3A300A3A3A300A3A3A300A3A3A300959595009191
      9100858585000000000000000000000000000000000000000000A8A8A800FFFF
      FF00FFFFFF00FFFFFF00FCFCFC00FCFCFC00FCFCFC00F9F9F900F9F9F9005151
      5100515151005151510051515100000000000000000000000000000000000000
      0000A8A8A800FFFFFF00FFFFFF00FFFFFF00FCFCFC00FCFCFC00FCFCFC00F9F9
      F900F9F9F9005151510051515100515151005151510000000000000000000000
      000000000000000000000000000085858500BDBDBD00BDBDBD00AFAFAF00A7A7
      A700969696009696960096969600969696009696960085858500000000000000
      00000000000000000000000000000000000000000000A0A0A000BFBFBF00BFBF
      BF00B2B2B200AEAEAE00A7A7A700A7A7A700A2A2A2009F9F9F009B9B9B008787
      8700000000000000000000000000000000000000000000000000A8A8A800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FCFCFC00FCFCFC00FCFCFC00F9F9F900A8A8
      A800FFFFFF005151510000000000000000000000000000000000000000000000
      0000A8A8A800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCFCFC00FCFCFC00FCFC
      FC00F9F9F900A8A8A800FFFFFF00515151000000000000000000000000000000
      0000000000000000000000000000000000008585850085858500BDBDBD00BDBD
      BD00AFAFAF00A0A0A00096969600858585008585850000000000000000000000
      0000000000000000000000000000000000000000000000000000A0A0A000A0A0
      A000C7C7C700BABABA00B2B2B200ABABAB00A7A7A7008B8B8B00909090000000
      0000000000000000000000000000000000000000000000000000A8A8A800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A8A8
      A800515151000000000000000000000000000000000000000000000000000000
      0000A8A8A800FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A8A8A80051515100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000858585008585
      8500858585008585850085858500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A0A0A000A0A0A000A0A0A000A0A0A000A0A0A00000000000000000000000
      0000000000000000000000000000000000000000000000000000A8A8A800A8A8
      A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8
      A800000000000000000000000000000000000000000000000000000000000000
      0000A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8
      A800A8A8A800A8A8A80000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000717171005151
      5100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005151
      5100515151005151510051515100515151005151510051515100515151005151
      5100515151000000000000000000000000005151510051515100515151005151
      5100515151005151510051515100515151005151510051515100515151005151
      5100515151005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007171710071717100929292007D7D
      7D00515151000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000051515100A8A8
      A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8
      A8005151510000000000000000000000000051515100D3D3D300FFFFFF00A7A7
      A700FFFFFF00A7A7A700FFFFFF00A7A7A700FFFFFF00A7A7A700FFFFFF00A7A7
      A700FFFFFF005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000717171007171710092929200C8C8C800FFFFFF00E9E9
      E9007D7D7D005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005151510051515100A7A7A700A7A7
      A700FFFFFF00BDBDBD00FFFFFF00FFFFFF00FFFFFF00BDBDBD00FFFFFF00A8A8
      A8005151510000000000000000000000000051515100FFFFFF00D3D3D300FFFF
      FF00D3D3D300FFFFFF00E9E9E900FFFFFF00A7A7A700FFFFFF00A7A7A700FFFF
      FF00A7A7A7005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000515151000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000717171007171710092929200C8C8C800FFFFFF00FFFFFF00FFFFFF00E9E9
      E900E9E9E9007D7D7D0051515100000000000000000000000000000000000000
      000000000000000000000000000051515100A7A7A700A7A7A700A7A7A700A7A7
      A700FFFFFF00FFFFFF00FFFFFF00BDBDBD00FFFFFF00FFFFFF00FFFFFF00A8A8
      A8005151510000000000000000000000000051515100D3D3D300FFFFFF00D3D3
      D300FFFFFF00E9E9E900A7A7A700E9E9E900FFFFFF00A7A7A700FFFFFF00A7A7
      A700FFFFFF005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000515151005151
      5100000000000000000000000000000000000000000000000000000000007D7D
      7D0092929200C8C8C800FFFFFF00FFFFFF00E9E9E900E9E9E9007D7D7D00A8A8
      A800B3B3B300E9E9E9007D7D7D00515151000000000000000000000000000000
      0000000000000000000051515100A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A700FFFFFF00BDBDBD007D7D7D007D7D7D007D7D7D00A8A8A800FFFFFF00A8A8
      A8005151510000000000000000000000000051515100FFFFFF00A7A7A700FFFF
      FF00A7A7A700FFFFFF00FFFFFF00FFFFFF00D3D3D300FFFFFF00D3D3D300FFFF
      FF00A7A7A7005151510000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000051515100B2B2
      B200515151000000000000000000000000000000000000000000000000007D7D
      7D00A8A8A800FFFFFF00E9E9E900B3B3B3007D7D7D007D7D7D007D7D7D005151
      5100A8A8A800A8A8A800E9E9E9007D7D7D005151510000000000000000000000
      0000000000000000000051515100A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A700FFFFFF007D7D7D00A7A7A700A7A7A700A7A7A7007D7D7D00FFFFFF00A8A8
      A8005151510000000000000000000000000051515100A7A7A700FFFFFF00A7A7
      A700FFFFFF00A7A7A700A7A7A700A7A7A700FFFFFF00D3D3D300FFFFFF00A7A7
      A700FFFFFF005151510000000000000000000000000000000000000000005151
      510051515100515151005151510051515100515151005151510051515100B2B2
      B200B2B2B2005151510000000000000000000000000000000000000000007D7D
      7D00A8A8A800E9E9E9007D7D7D007D7D7D00A7A7A700A7A7A700A7A7A7007D7D
      7D005151510088888800A8A8A800B3B3B3007D7D7D0051515100000000000000
      00000000000051515100A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A700FFFFFF007D7D7D00A8A8A8007D7D7D00A7A7A7007D7D7D00FFFFFF00A8A8
      A8005151510000000000000000000000000051515100FFFFFF00FFFFFF00FFFF
      FF00A7A7A700FFFFFF00A7A7A700A7A7A700A7A7A700FFFFFF00D3D3D300FFFF
      FF00A7A7A700515151000000000000000000000000000000000000000000B2B2
      B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2
      B200B2B2B200B2B2B20051515100000000000000000000000000000000007D7D
      7D007D7D7D007D7D7D00A7A7A700A7A7A7007D7D7D007D7D7D00A7A7A700A7A7
      A7007D7D7D005151510088888800A8A8A800A8A8A8007D7D7D00515151000000
      00000000000051515100A7A7A700A7A7A700A7A7A7007D7D7D007D7D7D00A8A8
      A800FFFFFF007D7D7D00FFFFFF00A8A8A8007D7D7D007D7D7D00FFFFFF00A8A8
      A8005151510000000000000000000000000051515100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A7A7A700FFFFFF00A7A7A700A7A7A700A7A7A700FFFFFF00D3D3
      D300FFFFFF00515151000000000000000000000000000000000000000000B2B2
      B200E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9
      E900D3D3D300B2B2B20051515100000000000000000000000000000000007D7D
      7D00D3D3D300A7A7A700A7A7A700A7A7A700A7A7A700A7A7A7007D7D7D007D7D
      7D007D7D7D007D7D7D005151510088888800A8A8A8007D7D7D00515151000000
      00000000000051515100A7A7A700A7A7A7007D7D7D007D7D7D007D7D7D00A8A8
      A800FFFFFF00BDBDBD007D7D7D007D7D7D007D7D7D00A8A8A800FFFFFF00A8A8
      A8005151510000000000000000000000000051515100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00A7A7A700E9E9E900A7A7A700FFFFFF00D3D3D300FFFF
      FF00D3D3D300515151000000000000000000000000000000000000000000B2B2
      B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200E9E9
      E900B2B2B2005151510000000000000000000000000000000000000000000000
      00007D7D7D00D3D3D300A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A7007D7D7D007D7D7D0051515100888888007D7D7D00000000000000
      00000000000051515100A7A7A700A7A7A7007D7D7D007D7D7D007D7D7D00A8A8
      A800FFFFFF00FFFFFF00FFFFFF00BDBDBD00FFFFFF0051515100515151005151
      51005151510000000000000000000000000051515100FFFFFF00FFFFFF00FFFF
      FF00A7A7A700FFFFFF00FFFFFF00E9E9E900A7A7A700A7A7A700FFFFFF00D3D3
      D300FFFFFF005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B2B2B200B2B2
      B200515151000000000000000000000000000000000000000000000000000000
      0000000000007D7D7D00D3D3D300A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A700A7A7A700717171007D7D7D00515151007D7D7D00000000000000
      00000000000051515100A7A7A700A7A7A700E9E9E9007D7D7D007D7D7D00A8A8
      A800FFFFFF00BDBDBD00FFFFFF00FFFFFF00FFFFFF00A8A8A800FFFFFF00A8A8
      A8000000000000000000000000000000000051515100FFFFFF00FFFFFF00FFFF
      FF00A7A7A700A7A7A700E9E9E900A7A7A700A7A7A700FFFFFF00A7A7A700FFFF
      FF00D3D3D3005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B2B2B2005151
      5100000000000000000000000000000000000000000000000000000000000000
      000000000000000000007D7D7D00D3D3D300A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A70092929200717171007D7D7D007D7D7D0051515100515151000000
      00000000000000000000A8A8A800A8A8A800A8A8A800FFFFFF00E9E9E900A8A8
      A800FFFFFF00FFFFFF00FFFFFF00BDBDBD00FFFFFF00A8A8A800A8A8A8000000
      00000000000000000000000000000000000051515100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00A7A7A700A7A7A700A7A7A700FFFFFF00A7A7A700FFFFFF00A7A7
      A700FFFFFF005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B2B2B2000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007D7D7D00D3D3D300A7A7A700A7A7A7007D7D
      7D007D7D7D00717171007D7D7D007D7D7D007171710051515100000000000000
      00000000000000000000A8A8A800A8A8A800FFFFFF00E9E9E900FFFFFF00A8A8
      A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800515151000000
      00000000000000000000000000000000000051515100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00515151005151
      5100515151005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007D7D7D00D3D3D300A7A7A700A7A7
      A700A7A7A7007D7D7D0071717100515151000000000000000000000000000000
      0000000000000000000000000000A8A8A800A8A8A800A8A8A800E9E9E900FFFF
      FF00E9E9E9007D7D7D007D7D7D007D7D7D007D7D7D0051515100000000000000
      00000000000000000000000000000000000051515100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0051515100FFFF
      FF00515151000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007D7D7D00D3D3D300A7A7
      A700717171005151510000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A8A8A800A8A8A800A8A8A800A8A8
      A800FFFFFF00E9E9E9007D7D7D00515151005151510000000000000000000000
      00000000000000000000000000000000000051515100FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00515151005151
      5100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007D7D7D005151
      5100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A8A8A800A8A8
      A800A8A8A800A8A8A800A8A8A800000000000000000000000000000000000000
      0000000000000000000000000000000000005151510051515100515151005151
      5100515151005151510051515100515151005151510051515100515151000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005151
      5100515151005151510051515100515151005151510051515100515151005151
      5100515151005151510051515100515151005151510000000000000000000000
      0000000000000000000000000000000000009A9A9A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000515151007D7D
      7D007D7D7D007D7D7D007D7D7D007D7D7D007D7D7D007D7D7D007D7D7D007D7D
      7D007D7D7D007D7D7D007D7D7D007D7D7D005151510000000000000000000000
      000000000000000000000000000000000000A3A3A30091919100000000000000
      0000A3A3A3008989890000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000515151005151510051515100515151005151
      5100515151005151510051515100515151005151510051515100515151005151
      51005151510051515100000000000000000000000000A8A8A800A7A7A700A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A7007D7D7D007D7D7D00A7A7A7007D7D7D005151510000000000000000000000
      00000000000000000000000000000000000000000000919191009C9C9C009191
      9100898989000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000071717100D3D3D300A7A7A700A7A7A700A7A7
      A700929292009292920092929200929292007D7D7D0092929200929292009292
      92009292920051515100000000000000000000000000A8A8A800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3D3D300D3D3D300D3D3D300D3D3
      D300D3D3D300A7A7A7007D7D7D007D7D7D005151510000000000000000000000
      00000000000000000000A3A3A300A3A3A300AAAAAA00B0B0B000898989008989
      8900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005151
      5100000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000071717100D3D3D300A7A7A700A7A7A700A7A7
      A700A7A7A700A7A7A700929292007D7D7D009292920092929200929292009292
      9200929292005151510000000000000000000000000000000000A8A8A800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D3D3D300FFFFFF00D3D3D300D3D3D300D3D3
      D300D3D3D300D3D3D3007D7D7D007D7D7D005151510000000000000000000000
      00000000000000000000A3A3A300DFDFDF00CDCDCD00B1B1B100AAAAAA00A1A1
      A100AAAAAA00AAAAAA0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000515151005151
      5100000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000071717100D3D3D300FFFFFF00A7A7A700A7A7
      A700A7A7A700A7A7A7007D7D7D00A7A7A700929292007D7D7D007D7D7D009292
      9200929292005151510000000000000000000000000000000000A8A8A800FFFF
      FF00FFFFFF007D7D7D007171710071717100717171007171710071717100D3D3
      D300D3D3D300D3D3D300A7A7A7007D7D7D005151510000000000000000000000
      00000000000000000000A3A3A300F2F2F200F2F2F200EBEBEB00E6E6E600E1E1
      E100D3D3D300BCBCBC00AAAAAA00A3A3A3000000000000000000000000000000
      0000000000000000000000000000000000000000000051515100B2B2B2005151
      5100000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000071717100D3D3D30092929200FFFFFF00A7A7
      A700A7A7A700A7A7A700A7A7A70092929200A7A7A70092929200929292007D7D
      7D00929292005151510000000000000000000000000000000000A8A8A800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3D3D300FFFFFF00D3D3D300D3D3
      D300D3D3D300D3D3D300A7A7A7007D7D7D005151510000000000000000000000
      00000000000000000000A3A3A300F5F5F500F2F2F200F2F2F200EBEBEB00E6E6
      E600E1E1E100E1E1E100D3D3D300A3A3A3000000000000000000000000000000
      00000000000000000000000000000000000051515100B2B2B200B2B2B2005151
      5100515151005151510051515100515151005151510051515100515151000000
      000000000000000000000000000071717100D3D3D30092929200D3D3D300FFFF
      FF007D7D7D00A7A7A700A7A7A700A7A7A7009292920092929200929292007D7D
      7D00929292005151510000000000000000000000000000000000A8A8A800FFFF
      FF00FFFFFF007D7D7D007D7D7D007D7D7D007171710071717100717171007171
      71007171710071717100A7A7A7007D7D7D005151510000000000000000000000
      00000000000000000000A3A3A300FCFCFC00F5F5F500F2F2F200F2F2F200EBEB
      EB00E6E6E600E1E1E100E1E1E100A3A3A3000000000000000000000000000000
      000000000000000000000000000051515100B2B2B200B2B2B200B2B2B200B2B2
      B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200515151000000
      000000000000000000000000000071717100D3D3D30092929200FFFFFF00D3D3
      D300929292007D7D7D00A7A7A700A7A7A700A7A7A700A7A7A700929292007D7D
      7D00929292005151510000000000000000000000000000000000A8A8A800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3D3D300FFFFFF00D3D3
      D300D3D3D300D3D3D300A7A7A7007D7D7D005151510000000000000000000000
      00000000000000000000A3A3A300FFFFFF00FCFCFC00F5F5F500F2F2F200F2F2
      F200EBEBEB00E6E6E600E1E1E100A3A3A3000000000000000000000000000000
      0000000000000000000000000000B2B2B200D3D3D300D3D3D300D3D3D300D3D3
      D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300B2B2B200515151000000
      000000000000000000000000000071717100D3D3D300D3D3D300929292009292
      9200A7A7A700A7A7A7007D7D7D00A7A7A700A7A7A700A7A7A70092929200A7A7
      A700929292005151510000000000000000000000000000000000A8A8A800FFFF
      FF00FFFFFF007D7D7D007D7D7D007D7D7D007D7D7D007D7D7D00717171007171
      71007171710071717100A7A7A7007D7D7D005151510000000000000000000000
      00000000000000000000A3A3A300FCFCFC00FFFFFF00FCFCFC00F5F5F500F2F2
      F200F2F2F200EBEBEB00E6E6E600A3A3A3000000000000000000000000000000
      000000000000000000000000000000000000B2B2B200D3D3D300D3D3D3005151
      5100B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200515151000000
      000000000000000000000000000071717100D3D3D300D3D3D300D3D3D300D3D3
      D300A7A7A70092929200D3D3D300A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A700929292005151510000000000000000000000000000000000A8A8A800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3D3D300FFFF
      FF00D3D3D300D3D3D300A7A7A7007D7D7D005151510000000000000000000000
      00000000000000000000A3A3A300F5F5F500FEFEFE00FEFEFE00FBFBFB00F5F5
      F500F2F2F200F2F2F200EBEBEB00A3A3A3000000000000000000000000000000
      00000000000000000000000000000000000000000000B2B2B200D3D3D3005151
      5100000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000071717100D3D3D300D3D3D300D3D3D300D3D3
      D30092929200D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3
      D300D3D3D3005151510000000000000000000000000000000000A8A8A800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3D3
      D300FFFFFF00D3D3D300A7A7A7007D7D7D005151510000000000000000000000
      000000000000919191009B9B9B009B9B9B009E9E9E00A7A7A700B0B0B000BCBC
      BC00BCBCBC00CCCCCC00D7D7D700A1A1A1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B2B2B2005151
      5100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000717171007171710071717100717171007171
      7100717171007171710071717100717171007171710071717100717171007171
      7100717171005151510000000000000000000000000000000000A8A8A800FFFF
      FF00FFFFFF007D7D7D007D7D7D007D7D7D007D7D7D00FFFFFF00FFFFFF00FFFF
      FF00D3D3D300FFFFFF00A7A7A7007D7D7D005151510000000000000000000000
      0000B8B8B800E6E6E600EEEEEE00DFDFDF00DFDFDF00CDCDCD00BCBCBC00B0B0
      B000ADADAD00A3A3A300A3A3A3009B9B9B00A3A3A30000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005151
      5100000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000071717100D3D3D300D3D3D300BEBE
      BE00D3D3D300BEBEBE0051515100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A8A8A800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00A7A7A7007D7D7D005151510000000000000000000000
      000000000000B8B8B800B8B8B800B8B8B800B8B8B800B8B8B800DFDFDF00C9C9
      C900C9C9C900E6E6E600EEEEEE00EEEEEE00C2C2C20000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000071717100717171007171
      7100717171007171710000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A8A8A800FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00A7A7A7007D7D7D005151510000000000000000000000
      0000000000000000000000000000000000000000000000000000B8B8B800B8B8
      B800B8B8B800B8B8B800B8B8B800B8B8B8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A8A8A800A8A8
      A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8
      A800A8A8A800A8A8A800A8A8A800A8A8A8000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005151510051515100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000515151005151510000000000000000000000
      0000000000005151510051515100000000005151510051515100000000005151
      5100515151000000000000000000000000000000000000000000515151005151
      5100000000000000000000000000515151005151510051515100515151005151
      5100515151005151510051515100515151005151510051515100515151005151
      5100515151005151510051515100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000092929200A7A7A70092929200515151000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000092929200A7A7A7009292920051515100000000000000
      0000000000005151510051515100000000005151510051515100000000005151
      5100515151000000000000000000000000000000000092929200A7A7A7009292
      9200515151000000000000000000A8A8A800E9E9E900E9E9E900E9E9E900E9E9
      E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9
      E900E9E9E900E9E9E90051515100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009292
      9200A7A7A700A7A7A70092929200515151000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000092929200A7A7A700A7A7A7009292920051515100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000092929200A7A7A700A7A7A7009292
      9200515151000000000000000000A8A8A800FFFFFF0051515100515151005151
      5100515151005151510051515100515151005151510051515100FFFFFF00FFFF
      FF00FFFFFF00E9E9E90051515100000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000092929200A7A7
      A700A7A7A7009292920051515100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000092929200A7A7A700A7A7A700929292005151510000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000092929200A7A7A700A7A7A700929292005151
      5100000000000000000000000000A8A8A800FFFFFF00A8A8A800E9E9E900E9E9
      E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E90051515100FFFFFF00FFFF
      FF00FFFFFF00E9E9E90051515100000000000000000000000000000000000000
      0000000000005151510051515100515151005151510051515100A7A7A700A7A7
      A700929292005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000515151005151510051515100515151005151
      5100A7A7A700A7A7A70092929200515151000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000515151005151
      5100515151005151510051515100A7A7A700A7A7A70092929200515151000000
      0000000000000000000000000000A8A8A800FFFFFF00A8A8A800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E9E9E90051515100FFFFFF00FFFF
      FF00FFFFFF00E9E9E9005151510000000000000000000000000000000000A8A8
      A80051515100A7A7A700A7A7A700A7A7A7008888880088888800515151009292
      9200515151000000000000000000000000000000000000000000000000000000
      000000000000A8A8A80051515100A7A7A700A7A7A700A7A7A700888888008888
      8800515151009292920051515100000000000000000000000000000000000000
      000000000000000000000000000000000000A8A8A80051515100A7A7A700A7A7
      A700A7A7A7008787870087878700515151009292920051515100000000000000
      0000000000000000000000000000A8A8A800FFFFFF00A8A8A800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E9E9E90051515100FFFFFF00FFFF
      FF00FFFFFF00E9E9E90051515100000000000000000000000000A8A8A800B3B3
      B300B2B2B200B2B2B200B2B2B200B2B2B200A7A7A700A7A7A700888888005151
      5100000000000000000000000000000000000000000000000000000000000000
      0000A8A8A800B3B3B300B2B2B200B2B2B200B2B2B200B2B2B200A7A7A700A7A7
      A700888888005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000A8A8A800B2B2B200B2B2B200B2B2B200B2B2
      B200B2B2B200A7A7A700A7A7A700878787005151510000000000000000000000
      0000000000000000000000000000A8A8A800FFFFFF00A8A8A800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E9E9E90051515100FFFFFF00FFFF
      FF00FFFFFF00E9E9E90051515100000000000000000000000000A8A8A800D3D3
      D300D3D3D300D3D3D3005151510051515100B2B2B200A7A7A700A7A7A7005151
      5100000000000000000000000000000000000000000000000000000000000000
      0000A8A8A800D3D3D300D3D3D300D3D3D300D3D3D300B2B2B200B2B2B200A7A7
      A700A7A7A7005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000A8A8A800D2D2D200D2D2D200D2D2D200D2D2
      D200B2B2B200B2B2B200A7A7A700A7A7A7005151510000000000000000000000
      0000000000000000000000000000A8A8A800FFFFFF00A7A7A700B2B2B200B2B2
      B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B20051515100FFFFFF00FFFF
      FF00FFFFFF00E9E9E900515151000000000000000000A8A8A800D3D3D300D3D3
      D300D3D3D300D3D3D3005151510051515100B2B2B200B2B2B200A7A7A7008888
      880051515100000000000000000000000000000000000000000000000000A8A8
      A800D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300B2B2B200B2B2
      B200A7A7A7008888880051515100000000000000000000000000000000000000
      00000000000000000000A8A8A800D2D2D200D2D2D200D2D2D200D2D2D200D2D2
      D200D2D2D200B2B2B200B2B2B200A7A7A7008787870051515100000000000000
      0000000000000000000000000000A8A8A800FFFFFF00A7A7A700A7A7A700A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A70051515100E9E9E900FFFF
      FF00FFFFFF00E9E9E900515151000000000000000000A8A8A800D3D3D300E9E9
      E900515151005151510051515100515151005151510051515100A7A7A700A7A7
      A70051515100000000000000000000000000000000000000000000000000A8A8
      A800D3D3D300E9E9E90051515100515151005151510051515100515151005151
      5100A7A7A700A7A7A70051515100000000000000000000000000000000000000
      00000000000000000000A8A8A800D2D2D200E8E8E800E8E8E800E8E8E800D2D2
      D200D2D2D200D2D2D200B2B2B200A7A7A700A7A7A70051515100000000000000
      0000000000000000000000000000A8A8A800FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007D7D7D00E9E9
      E9007D7D7D00E9E9E900515151000000000000000000A8A8A800D3D3D300FFFF
      FF00515151005151510051515100515151005151510051515100B2B2B200A7A7
      A70051515100000000000000000000000000000000000000000000000000A8A8
      A800D3D3D300FFFFFF0051515100515151005151510051515100515151005151
      5100B2B2B200A7A7A70051515100000000000000000000000000000000000000
      00000000000000000000A8A8A800D2D2D200FFFFFF00FFFFFF00E8E8E800E8E8
      E800D2D2D200D2D2D200D2D2D200B2B2B200A7A7A70051515100000000000000
      0000000000000000000000000000A8A8A800FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007D7D
      7D007D7D7D00E9E9E900515151000000000000000000A8A8A800B3B3B300FFFF
      FF00FFFFFF00FFFFFF005151510051515100D3D3D300D3D3D300B2B2B200A7A7
      A70051515100000000000000000000000000000000000000000000000000A8A8
      A800B3B3B300FFFFFF00FFFFFF00FFFFFF00E9E9E900E9E9E900D3D3D300D3D3
      D300B2B2B200A7A7A70051515100000000000000000000000000000000000000
      00000000000000000000A8A8A800B2B2B200FFFFFF00FFFFFF00FFFFFF00E8E8
      E800E8E8E800D2D2D200D2D2D200B2B2B200A7A7A70051515100000000000000
      0000000000000000000000000000A8A8A800FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A7A7A700A7A7
      A7007D7D7D00E9E9E90051515100000000000000000000000000A8A8A800D3D3
      D300FFFFFF00FFFFFF005151510051515100D3D3D300D3D3D300B2B2B2005151
      5100000000000000000000000000000000000000000000000000000000000000
      0000A8A8A800D3D3D300FFFFFF00FFFFFF00FFFFFF00E9E9E900D3D3D300D3D3
      D300B2B2B2005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000A8A8A800D2D2D200FFFFFF00FFFFFF00FFFF
      FF00E8E8E800D2D2D200D2D2D200B2B2B2005151510000000000000000000000
      0000000000000000000000000000A8A8A800FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E9E9E90051515100000000000000000000000000A8A8A800B3B3
      B300D3D3D300FFFFFF00FFFFFF00E9E9E900D3D3D300D3D3D300B2B2B2005151
      5100000000000000000000000000000000000000000000000000000000000000
      0000A8A8A800B3B3B300D3D3D300FFFFFF00FFFFFF00E9E9E900D3D3D300D3D3
      D300B2B2B2005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000A8A8A800B2B2B200D2D2D200FFFFFF00FFFF
      FF00E8E8E800D2D2D200D2D2D200B2B2B2005151510000000000000000000000
      0000000000000000000000000000A8A8A8007D7D7D007D7D7D007D7D7D007D7D
      7D007D7D7D007D7D7D007D7D7D007D7D7D007D7D7D007D7D7D007D7D7D007D7D
      7D007D7D7D007D7D7D005151510000000000000000000000000000000000A8A8
      A800A8A8A800B3B3B300D3D3D300D3D3D300D3D3D300A8A8A800A8A8A8000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A8A8A800A8A8A800B3B3B300D3D3D300D3D3D300D3D3D300A8A8
      A800A8A8A8000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A8A8A800A8A8A800B2B2B200D2D2
      D200D2D2D200D2D2D200A8A8A800A8A8A8000000000000000000000000000000
      0000000000000000000000000000A8A8A800E9E9E900B3B3B300B3B3B300B3B3
      B300B3B3B300B3B3B300B3B3B300B3B3B300B3B3B300B3B3B300B3B3B300B3B3
      B300B3B3B300B3B3B30051515100000000000000000000000000000000000000
      000000000000A8A8A800A8A8A800A8A8A800A8A8A80000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A8A8A800A8A8A800A8A8A800A8A8A8000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000A8A8A800A8A8
      A800A8A8A800A8A8A80000000000000000000000000000000000000000000000
      0000000000000000000000000000A8A8A800A8A8A800A8A8A800A8A8A800A8A8
      A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8
      A800A8A8A800A8A8A80051515100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000515151000000
      0000000000000000000000000000000000005151510051515100515151000000
      0000000000000000000000000000000000000000000000000000000000005454
      5400545454005454540054545400545454005454540054545400545454005454
      5400545454005454540000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000051515100515151005151
      5100515151005151510051515100515151005151510051515100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000515151005151510051515100515151005151510051515100515151005151
      510051515100000000000000000000000000000000007D7D7D00929292005151
      5100000000000000000000000000000000007D7D7D007D7D7D00515151000000
      000000000000000000000000000000000000000000000000000054545400FFFF
      FF00F0F0F000F0F0F000E7E7E700E7E7E700DCDCDC00DCDCDC00CACACA00CACA
      CA00545454009292920054545400000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A8A8A800E9E9E900E9E9
      E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E90051515100000000000000
      0000000000000000000051515100515151005151510051515100515151005151
      5100A8A8A800E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900E9E9
      E90051515100000000000000000000000000000000007D7D7D00A7A7A7005151
      5100000000000000000000000000000000007D7D7D00A7A7A700515151000000
      0000000000000000000000000000000000000000000054545400545454005454
      5400545454005454540054545400545454005454540054545400545454005454
      5400545454005454540092929200545454000000000000000000000000000000
      00000000000000000000000000000000000000000000A8A8A800D3D3D300A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700E9E9E90051515100000000000000
      0000000000007171710092929200929292009292920092929200929292009292
      9200A8A8A800FFFFFF00A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700E9E9
      E90051515100000000000000000000000000000000007D7D7D00D3D3D3005151
      5100000000000000000000000000000000007D7D7D00A7A7A700515151000000
      00000000000000000000000000000000000000000000ACACAC00FFFFFF00F0F0
      F000E7E7E700DCDCDC00DCDCDC00DCDCDC00A7A7A700A7A7A700A7A7A700DCDC
      DC00DCDCDC005454540054545400545454000000000000000000000000005151
      51005151510051515100515151005151510051515100A8A8A800FFFFFF00D3D3
      D300FFFFFF00D3D3D300FFFFFF00D3D3D300E9E9E90051515100000000000000
      00000000000071717100BEBEBE00BEBEBE0092929200BEBEBE00929292009292
      9200A8A8A800D3D3D300FFFFFF00D3D3D300FFFFFF00D3D3D300E9E9E900E9E9
      E90051515100000000000000000051515100515151007D7D7D00A7A7A7005151
      5100515151005151510051515100515151007D7D7D00A7A7A700515151005151
      51005151510051515100000000000000000000000000ACACAC00FFFFFF00FFFF
      FF00F0F0F000E7E7E700DCDCDC00DCDCDC007D7D7D007D7D7D007D7D7D00DCDC
      DC00DCDCDC0054545400ACACAC0054545400000000000000000000000000A8A8
      A800E9E9E900E9E9E900E9E9E900E9E9E900E9E9E900A8A8A800D3D3D300A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700E9E9E90051515100000000000000
      00000000000071717100FFFFFF00BEBEBE00BEBEBE00BEBEBE00BEBEBE009292
      9200A8A8A800FFFFFF00A7A7A700A7A7A700FFFFFF0088888800515151005151
      510051515100000000000000000051515100E9E9E9007D7D7D00D3D3D3005151
      5100E9E9E900E9E9E900E9E9E900E9E9E9007D7D7D00A7A7A70051515100E9E9
      E900E9E9E90051515100000000000000000000000000ACACAC00ACACAC00ACAC
      AC00ACACAC00ACACAC00ACACAC00ACACAC00ACACAC00ACACAC00ACACAC00ACAC
      AC00ACACAC0054545400ACACAC00ACACAC00545454000000000000000000A8A8
      A800FFFFFF007D7D7D007D7D7D007D7D7D007D7D7D00A8A8A800FFFFFF00D3D3
      D300FFFFFF00D3D3D300FFFFFF00E9E9E900E9E9E90051515100000000000000
      00000000000071717100BEBEBE00FFFFFF00BEBEBE00BEBEBE0092929200BEBE
      BE00A8A8A800FFFFFF00D3D3D300FFFFFF00D3D3D300A8A8A800FFFFFF005151
      510000000000000000000000000051515100FFFFFF007D7D7D00A7A7A7005151
      5100FFFFFF00FFFFFF00FFFFFF00FFFFFF007D7D7D00A7A7A70051515100FFFF
      FF00E9E9E90051515100000000000000000000000000ACACAC00FFFFFF00FFFF
      FF00FFFFFF00F0F0F000F0F0F000E7E7E700E7E7E700DCDCDC00DCDCDC00DCDC
      DC0054545400ACACAC0054545400ACACAC00545454000000000000000000A8A8
      A800D3D3D300FFFFFF00D3D3D300FFFFFF00D3D3D300A8A8A800FFFFFF00B2B2
      B200B2B2B200FFFFFF0051515100515151005151510051515100000000000000
      00000000000071717100FFFFFF00BEBEBE00FFFFFF00BEBEBE00BEBEBE00BEBE
      BE00A8A8A800FFFFFF00FFFFFF00FFFFFF00FFFFFF00A8A8A800515151000000
      000000000000000000000000000051515100FFFFFF007D7D7D00D3D3D3005151
      5100FFFFFF00FFFFFF00FFFFFF00FFFFFF007D7D7D00BDBDBD0051515100FFFF
      FF00E9E9E9005151510000000000000000000000000000000000ACACAC00ACAC
      AC00ACACAC00ACACAC00ACACAC00ACACAC00ACACAC00ACACAC00ACACAC00ACAC
      AC00ACACAC0054545400ACACAC0054545400545454000000000000000000A8A8
      A800FFFFFF007D7D7D007D7D7D007D7D7D007D7D7D00A8A8A800FFFFFF00FFFF
      FF00FFFFFF00D3D3D300A8A8A800FFFFFF005151510000000000000000000000
      00000000000071717100FFFFFF00FFFFFF00BEBEBE00FFFFFF00BEBEBE00BEBE
      BE00A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800515151000000
      000000000000000000000000000051515100FFFFFF007D7D7D00A7A7A7005151
      5100FFFFFF00FFFFFF0051515100FFFFFF0051515100E9E9E90051515100FFFF
      FF0051515100515151000000000000000000000000000000000000000000ACAC
      AC00DCDCDC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0054545400ACACAC0054545400ACACAC00545454000000000000000000A8A8
      A800D3D3D300FFFFFF00D3D3D300FFFFFF00D3D3D300A8A8A800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00A8A8A800515151000000000000000000000000000000
      00000000000071717100FFFFFF00FFFFFF00FFFFFF00BEBEBE00FFFFFF00BEBE
      BE00BEBEBE0092929200BEBEBE0092929200BEBEBE0092929200515151000000
      0000000000000000000000000000515151007D7D7D00A7A7A700D3D3D3007D7D
      7D005151510051515100E9E9E90051515100A8A8A800FFFFFF00A8A8A8005151
      5100515151005151510000000000000000000000000000000000000000000000
      0000ACACAC00FFFFFF00B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900FFFF
      FF0054545400545454005454540054545400000000000000000000000000A8A8
      A800FFFFFF007D7D7D007D7D7D00FFFFFF0051515100A8A8A800A8A8A800A8A8
      A800A8A8A800A8A8A800A8A8A800000000000000000000000000000000000000
      00000000000071717100FFFFFF00FFFFFF005151510051515100515151005151
      5100515151005151510051515100515151009292920092929200515151000000
      00000000000000000000000000007D7D7D00A7A7A700D3D3D3007D7D7D00D3D3
      D3007D7D7D0051515100FFFFFF00A8A8A800FFFFFF00FFFFFF00E9E9E9005151
      5100E9E9E9005151510000000000000000000000000000000000000000000000
      0000ACACAC00DCDCDC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00DCDCDC00545454000000000000000000000000000000000000000000A8A8
      A800FFFFFF00FFFFFF00FFFFFF00D3D3D300A8A8A800FFFFFF00515151000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000071717100FFFFFF00FFFFFF0092929200D3D3D300A7A7A700A7A7
      A700A7A7A700929292007D7D7D00515151009292920092929200515151000000
      00000000000000000000000000007D7D7D00D3D3D30051515100FFFFFF007D7D
      7D00D3D3D30051515100A8A8A800FFFFFF00A8A8A800A8A8A800A8A8A800FFFF
      FF00E9E9E9005151510000000000000000000000000000000000000000000000
      000000000000ACACAC00FFFFFF00B9B9B900B9B9B900B9B9B900B9B9B900B9B9
      B900FFFFFF00545454000000000000000000000000000000000000000000A8A8
      A800FFFFFF00FFFFFF00FFFFFF00FFFFFF00A8A8A80051515100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000071717100FFFFFF00FFFFFF00FFFFFF0092929200D3D3D3007171
      710071717100929292005151510092929200BEBEBE0092929200515151000000
      00000000000000000000000000007D7D7D00D3D3D30051515100FFFFFF007D7D
      7D00A7A7A70051515100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E9E9E9005151510000000000000000000000000000000000000000000000
      000000000000ACACAC00DCDCDC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00DCDCDC005454540000000000000000000000000000000000A8A8
      A800A8A8A800A8A8A800A8A8A800A8A8A800A8A8A80000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007171710071717100717171007171710092929200FFFF
      FF00D3D3D3005151510071717100717171007171710071717100000000000000
      0000000000000000000000000000A7A7A7007D7D7D00D3D3D30051515100D3D3
      D300515151007D7D7D007D7D7D007D7D7D007D7D7D007D7D7D007D7D7D007D7D
      7D007D7D7D005151510000000000000000000000000000000000000000000000
      00000000000000000000ACACAC00ACACAC00ACACAC00ACACAC00ACACAC00ACAC
      AC00ACACAC00ACACAC00ACACAC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000929292009292
      9200929292007D7D7D0000000000000000000000000000000000000000000000
      0000000000000000000000000000A7A7A700B2B2B2007D7D7D00B2B2B2007D7D
      7D00B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2B200B2B2
      B200B2B2B2005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A7005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000051515100515151005151
      5100515151005151510051515100515151005151510051515100515151005151
      5100000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A7A7A70051515100515151005151
      5100515151000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000515151005151510051515100515151005151
      5100515151005151510051515100515151005151510051515100515151005151
      5100000000000000000000000000000000005151510051515100515151005151
      5100515151005151510051515100515151005151510051515100515151000000
      0000000000000000000000000000000000000000000074747400747474009292
      9200929292007D7D7D00929292007D7D7D00929292007D7D7D00929292007D7D
      7D00515151000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A7A7A7005151510000000000000000000000
      0000000000005151510000000000000000000000000000000000000000000000
      000000000000000000007171710092929200929292005C5C5C005C5C5C005C5C
      5C005C5C5C005C5C5C005C5C5C00B3B3B300B3B3B3005C5C5C00717171005151
      5100000000000000000000000000000000005151510092929200929292009292
      92007D7D7D00929292007D7D7D00929292007D7D7D0092929200515151000000
      0000000000000000000000000000000000000000000074747400D3D3D3007474
      7400929292009292920092929200929292007D7D7D00929292007D7D7D009292
      92007D7D7D005151510000000000000000000000000000000000000000000000
      00000000000000000000A7A7A700A7A7A7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007171710092929200BEBEBE007D7D7D007D7D7D005C5C
      5C005C5C5C005C5C5C005C5C5C00E9E9E900B3B3B3005C5C5C00929292005151
      5100000000000000000000000000000000005151510092929200929292009292
      9200929292007D7D7D00929292007D7D7D00929292007D7D7D00515151000000
      0000000000000000000000000000000000000000000074747400D3D3D300A7A7
      A700747474009292920092929200929292009292920092929200929292007D7D
      7D00929292007D7D7D0051515100000000000000000000000000000000000000
      00000000000000000000A7A7A700A7A7A7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000071717100BEBEBE00BEBEBE007D7D7D007D7D7D007D7D
      7D007D7D7D007D7D7D005C5C5C00FFFFFF00E9E9E9005C5C5C00929292005151
      5100000000000000000000000000000000005151510092929200929292009292
      9200929292009292920092929200929292007D7D7D0092929200515151000000
      0000000000000000000000000000000000000000000074747400D3D3D300FFFF
      FF00A7A7A7007474740092929200929292009292920092929200929292009292
      92007D7D7D00929292007D7D7D00515151000000000000000000000000000000
      00000000000000000000A7A7A700A7A7A7000000000000000000000000000000
      00000000000000000000A7A7A700515151000000000000000000000000000000
      0000000000000000000071717100BEBEBE00BEBEBE007D7D7D007D7D7D007D7D
      7D007D7D7D007D7D7D007D7D7D007D7D7D007D7D7D005C5C5C00929292005151
      5100000000000000000000000000000000005151510092929200929292009292
      920092929200929292009292920092929200929292007D7D7D00515151000000
      0000000000000000000000000000000000000000000074747400D3D3D300A7A7
      A700FFFFFF00A7A7A70074747400747474007474740074747400747474007474
      740074747400747474007474740074747400515151000000000000000000A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700515151000000
      000000000000A7A7A700A7A7A700A7A7A7005151510000000000000000000000
      0000000000000000000071717100FFFFFF00BEBEBE00BEBEBE00BEBEBE00BEBE
      BE00BEBEBE00BEBEBE00BEBEBE00BEBEBE00BEBEBE00BEBEBE00929292005151
      5100000000000000000000000000000000005151510092929200929292009292
      9200929292009292920092929200929292009292920092929200515151000000
      0000000000000000000000000000000000000000000074747400D3D3D300FFFF
      FF00A7A7A700FFFFFF00A7A7A700A7A7A700A7A7A700A7A7A700A7A7A7005151
      5100000000000000000000000000000000000000000000000000000000000000
      0000A7A7A700A7A7A700A7A7A700A7A7A700A7A7A70051515100000000000000
      0000A7A7A700A7A7A700A7A7A700A7A7A700A7A7A70051515100000000000000
      0000000000000000000071717100FFFFFF00BEBEBE0071717100717171007171
      71007171710071717100717171007171710071717100BEBEBE00929292005151
      5100000000000000000000000000000000005151510092929200929292009292
      9200929292009292920092929200929292009292920092929200515151000000
      0000000000000000000000000000000000000000000074747400D3D3D300A7A7
      A700FFFFFF00D3D3D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D3005151
      5100000000000000000000000000000000000000000000000000000000000000
      000000000000A7A7A700A7A7A700A7A7A700515151000000000000000000A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700515151000000
      0000000000000000000071717100FFFFFF0092929200FFFFFF00FFFFFF00D3D3
      D300D3D3D300D3D3D300D3D3D300D3D3D300D3D3D30071717100BEBEBE005151
      5100000000000000000000000000000000005151510051515100515151005151
      5100929292009292920092929200929292009292920092929200515151000000
      0000000000000000000000000000000000000000000074747400FFFFFF00D3D3
      D300BEBEBE007474740074747400747474007474740074747400747474007474
      7400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A7A7A700515151000000000000000000000000000000
      00000000000000000000A7A7A700515151000000000000000000000000000000
      0000000000000000000071717100FFFFFF0092929200FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D3D3D300D3D3D30071717100BEBEBE005151
      51000000000000000000000000000000000051515100A7A7A700FFFFFF00A7A7
      A700515151005151510051515100515151005151510051515100515151000000
      0000000000000000000000000000000000000000000000000000747474007474
      7400747474000000000000000000000000000000000000000000000000000000
      0000000000006767670067676700676767000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A7A7A700515151000000000000000000000000000000
      0000000000000000000071717100FFFFFF0092929200FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3D3D30071717100BEBEBE005151
      5100000000000000000000000000000000000000000051515100515151005151
      5100000000000000000000000000000000000000000000000000000000000000
      0000000000005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007D7D7D00676767000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A7A7A700515151000000000000000000000000000000
      0000000000000000000071717100FFFFFF0092929200FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3D3D30071717100BEBEBE005151
      5100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000515151005151510051515100000000000000
      0000000000005151510000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007D7D7D00000000000000
      0000000000007D7D7D0000000000676767000000000000000000000000000000
      000000000000000000000000000000000000A7A7A70000000000000000000000
      000000000000A7A7A70051515100000000000000000000000000000000000000
      0000000000000000000071717100FFFFFF0092929200FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3D3D30071717100717171005151
      5100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000515151005151510000000000000000000000
      0000515151005151510000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007D7D7D007D7D
      7D007D7D7D000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A7A7A700A7A7A700A7A7
      A700A7A7A700A7A7A70000000000000000000000000000000000000000000000
      0000000000000000000071717100FFFFFF009292920092929200929292009292
      9200929292009292920092929200929292009292920071717100E9E9E9005151
      5100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000515151000000000051515100515151005151
      5100515151000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000071717100717171009292920092929200929292009292
      9200929292009292920092929200929292009292920071717100717171005151
      5100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000048000000A20000000100010000000000980700000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFC0000000000000000000FFFFC0000000000000000000
      FFFFC00000000000000000008000400000000000000000008000400000000000
      0000000080004000000000000000000080004000000000000000000080004000
      0000000000000000800040000000000000000000800040000000000000000000
      8000400000000000000000008000400000000000000000008000400000000000
      00000000800040000000000000000000800040000000000000000000FFFFC000
      0000000000000000FFFFC0000000000000000000FFFFC0000000000000000000
      FFFFFFFFFFFFFFFFFF000000FC1FFF07FFC1FF8007000000F007FC01FF007F80
      07000000E003F800FE003F8007000000C001F0007C001F8007000000C001F000
      7C001F80070000008000E00038000F80070000008000E00038000F8007000000
      8000E00038000F80070000008000E00038000F80070000008000E00038000F80
      07000000C001F0007C001F8007000000C001F0007C001F8007000000E003F800
      FE003F8007000000F007FC01FF007F800F000000FC1FFF07FFC1FF801F000000
      FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
      FF000000C001F0007FC1FFF07F000000C001F0007F007FC01F000000C001F000
      7E003F800F000000C001F0007C001F0007000000C001F0007C001F0007000000
      C001F00078000E0003000000C001F00078000E0003000000C001F00078000E00
      03000000C001F00078000E0003000000C001F00078000E0003000000C001F000
      7C001F0007000000C001F0007C001F0007000000C001F0007E003F800F000000
      C003F000FF007FC01F000000C007F001FFC1FFF07F000000C00FF003FFFFFFFF
      FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFCF
      FFE0070003000000FFFFFF07FFC0070003000000FFFFFC03FF00070003000000
      FFDFF001FE00070003000000FFCFE000FC00070003000000FFC7E0007C000700
      03000000E003E0003800070003000000E001E0001800070003000000E001E000
      1800070003000000E003F0003800070003000000FFC7F80038000F0003000000
      FFCFFC001C001F0003000000FFDFFE003C001F0003000000FFFFFF00FE003F00
      07000000FFFFFF83FF007F000F000000FFFFFFCFFFC1FF001F000000FFFFFFFF
      FFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000E0007F7FFFFFFFFFFF000000
      C0007F33FFFFFE000300000080007F87FFFFFE000300000080007C0FFFEFFE00
      03000000C0007C03FFCFFE0003000000C0007C00FF8FFE0003000000C0007C00
      FF001E0003000000C0007C00FE001E0003000000C0007C00FE001E0003000000
      C0007C00FF001E0003000000C0007C00FF8FFE0003000000C0007800FFCFFE00
      03000000C00070007FEFFF01FF000000C00078007FFFFF83FF000000C0007FC0
      FFFFFFFFFF000000C000FFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
      FFFFFFFFFFFFFFFFFF000000FFF9FFFE7927CE0001000000FFF0FFFC39278600
      01000000FFE0FFF83FFF060001000000FFC1FFF07FFE0E0001000000F803FE00
      FFC01E0001000000E007F801FF003E0001000000C00FF003FE007E0001000000
      C00FF003FE007E00010000008007E001FC003E00010000008007E001FC003E00
      010000008007E001FC003E00010000008007E001FC003E0001000000C00FF003
      FE007E0001000000C00FF003FE007E0001000000E01FF807FF00FE0001000000
      F87FFE1FFFC3FE0001000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
      FF000000FFFFFFFFFFFFFFDF1F000000E003FF803FF0078F1F000000C001FF80
      3C00078F1F0000008000FF803800078F1F0000008000E0003800060003000000
      8000E00038000600030000008000600038000E00030000008000600038001E00
      03000000C000600078001E0003000000E0006000F8001E0003000000F000E001
      F8001E0003000000F003E01FF8001E0003000000F803E03FF8001E0003000000
      F801E07FFC003E0003000000FC01FFFFFFC3FE0003000000FFFFFFFFFFFFFE00
      03000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF
      FFFFFFFFFF000000800FFF07FE000F001F0000008007FE7BFC000F001F000000
      8003FCFFFC000F001F0000008001FCFFFC000F001F0000008000FCFCFC000F00
      1F000000800060187C000F001F000000800FF0303C000F001F000000800FF860
      1C000F001F000000800FFCFCFC000F001F000000C7F8FFFCFC000F8FFB000000
      FFFCFFFCFC000FFE3B000000FFBAFF79FC000FFE73000000FFC7FF83FC000FFE
      87000000FFFFFFFFFC000FFFFF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFF
      FFFFFFFFFF00000000000000000000000000000000000000000000000000}
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
