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
    Top = 96
    Width = 826
    Height = 474
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
    Height = 32
    AutoSize = True
    BandBorderStyle = bsNone
    BandMaximize = bmNone
    Bands = <
      item
        Control = itbMain
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 30
        Width = 826
      end>
    EdgeBorders = [ebTop]
    FixedOrder = True
    ShowText = False
    object itbMain: TToolBar
      Left = 0
      Top = 0
      Width = 822
      Height = 30
      AutoSize = True
      ButtonHeight = 30
      ButtonWidth = 31
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
        Left = 31
        Top = 0
        Hint = 'Last Image|Load last image'
        Caption = 'Last'
        ImageIndex = 14
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnLastClick
      end
      object tbnSave: TToolButton
        Left = 62
        Top = 0
        Hint = 'Save as...|Save image in variety of formats'
        Caption = 'Save'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        OnClick = miSaveAsClick
      end
      object tbnClose: TToolButton
        Left = 93
        Top = 0
        Hint = 'Close|Close image'
        Caption = 'Close'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = miCloseClick
      end
      object Sep_1: TToolButton
        Left = 124
        Top = 0
        Width = 8
        Caption = 'Sep_1'
        ImageIndex = 1
        Style = tbsSeparator
      end
      object tbnPrint: TToolButton
        Left = 132
        Top = 0
        Hint = 'Print|Print image (hold SHIFT to skip preview)'
        Caption = 'Print'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnPrintClick
      end
      object Sep_2: TToolButton
        Left = 163
        Top = 0
        Width = 8
        Caption = 'Sep_2'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object tbnCopy: TToolButton
        Left = 171
        Top = 0
        Hint = 'Copy|Copy image to clipboard'
        Caption = 'Copy'
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        OnClick = miCopyClick
      end
      object tbnPaste: TToolButton
        Left = 202
        Top = 0
        Hint = 'Paste|Paste from clipboard'
        Caption = 'Paste'
        ImageIndex = 5
        ParentShowHint = False
        ShowHint = True
        OnClick = miPasteClick
      end
      object Sep_12: TToolButton
        Left = 233
        Top = 0
        Width = 8
        Caption = 'Sep_12'
        ImageIndex = 24
        Style = tbsSeparator
      end
      object tbnFilters: TToolButton
        Left = 241
        Top = 0
        Hint = 'Filters|Transform image using filters'
        Caption = 'Filters'
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        OnClick = miFiltersDialogClick
      end
      object Sep_3: TToolButton
        Left = 272
        Top = 0
        Width = 8
        Caption = 'Sep_3'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object tbnZoom: TToolButton
        Left = 280
        Top = 0
        Hint = 'Zoom|Set image zoom'
        Caption = 'Zoom'
        DropdownMenu = popZoom
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        Style = tbsDropDown
        OnClick = miZMCustomClick
      end
      object tbnZoomFit: TToolButton
        Left = 324
        Top = 0
        Hint = 'Fit|Zoom to fit'
        Caption = 'Fit'
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        OnClick = miZoomtoFitClick
      end
      object tbnZoomOrig: TToolButton
        Left = 355
        Top = 0
        Hint = '1:1|Zoom to 100%'
        Caption = '1:1'
        ImageIndex = 9
        ParentShowHint = False
        ShowHint = True
        OnClick = miZM100Click
      end
      object tbnFullScreen: TToolButton
        Left = 386
        Top = 0
        Hint = 'Full Screen|Switch to full screen mode'
        Caption = 'FullScreen'
        ImageIndex = 10
        ParentShowHint = False
        ShowHint = True
        OnClick = miFullScreenClick
      end
      object Sep_7: TToolButton
        Left = 417
        Top = 0
        Width = 8
        Caption = 'Sep_7'
        ImageIndex = 20
        Style = tbsSeparator
      end
      object tbnInfo: TToolButton
        Left = 425
        Top = 0
        Hint = 'File Info|View file information'
        Caption = 'Info'
        ImageIndex = 11
        ParentShowHint = False
        ShowHint = True
        OnClick = miInfoClick
      end
      object Sep_8: TToolButton
        Left = 456
        Top = 0
        Width = 8
        Caption = 'Sep_8'
        ImageIndex = 24
        Style = tbsSeparator
      end
      object tbnShow: TToolButton
        Left = 464
        Top = 0
        Hint = 'Slide Show|Slide show in current folder'
        Caption = 'Slide Show'
        ImageIndex = 23
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = miShowClick
      end
      object Sep_9: TToolButton
        Left = 495
        Top = 0
        Width = 8
        Caption = 'Sep_9'
        ImageIndex = 26
        Style = tbsSeparator
      end
      object tbnBack: TToolButton
        Left = 503
        Top = 0
        Hint = 
          'Back|Go to previous image in current folder (hold SHIFT to jump ' +
          'to first image in folder)'
        Caption = 'Back'
        ImageIndex = 12
        ParentShowHint = False
        ShowHint = True
        OnClick = miBackClick
      end
      object tbnForward: TToolButton
        Left = 534
        Top = 0
        Hint = 
          'Forward|Go to next image in current folder (hold SHIFT to jump t' +
          'o last image in folder)'
        Caption = 'Forward'
        ImageIndex = 13
        ParentShowHint = False
        ShowHint = True
        OnClick = miForwardClick
      end
    end
  end
  object tbrAnim: TCoolBar
    Left = 0
    Top = 32
    Width = 826
    Height = 32
    AutoSize = True
    BandBorderStyle = bsNone
    BandMaximize = bmNone
    Bands = <
      item
        Control = itbAnim
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 30
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
      Height = 30
      AutoSize = True
      ButtonHeight = 30
      ButtonWidth = 31
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
        ImageIndex = 15
        ParentShowHint = False
        ShowHint = False
        OnClick = tbnPlayClick
      end
      object tbnPause: TToolButton
        Left = 31
        Top = 0
        Hint = 'Pause|Pause animation'
        Caption = 'Pause'
        ImageIndex = 16
        ParentShowHint = False
        ShowHint = False
        OnClick = tbnPauseClick
      end
      object tbnStop: TToolButton
        Left = 62
        Top = 0
        Hint = 'Stop|Stop animation'
        Caption = 'Stop'
        ImageIndex = 17
        ParentShowHint = False
        ShowHint = False
        OnClick = tbnStopClick
      end
    end
  end
  object tbrMulti: TCoolBar
    Left = 0
    Top = 64
    Width = 826
    Height = 32
    AutoSize = True
    BandBorderStyle = bsNone
    BandMaximize = bmNone
    Bands = <
      item
        Control = itbMulti
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 30
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
      Height = 30
      AutoSize = True
      ButtonHeight = 30
      ButtonWidth = 31
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
        ImageIndex = 18
        ParentShowHint = False
        ShowHint = False
        OnClick = tbnMultiFirstClick
      end
      object tbnMultiPrev: TToolButton
        Left = 31
        Top = 0
        Hint = 'Previous|Go to previous page'
        Caption = 'Previous'
        ImageIndex = 19
        ParentShowHint = False
        ShowHint = False
        OnClick = tbnMultiPrevClick
      end
      object tbnMultiNext: TToolButton
        Left = 62
        Top = 0
        Hint = 'Next|Go to next page'
        Caption = 'Next'
        ImageIndex = 20
        ParentShowHint = False
        ShowHint = False
        OnClick = tbnMultiNextClick
      end
      object tbnMultiLast: TToolButton
        Left = 93
        Top = 0
        Hint = 'Last|Go to last page'
        Caption = 'Last'
        ImageIndex = 21
        ParentShowHint = False
        ShowHint = False
        OnClick = tbnMultiLastClick
      end
      object MSep_1: TToolButton
        Left = 124
        Top = 0
        Width = 8
        Caption = 'MSep_1'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object tbnGoToPage: TToolButton
        Left = 132
        Top = 0
        Hint = 'Go To|Go to page'
        Caption = 'Go To'
        ImageIndex = 14
        ParentShowHint = False
        ShowHint = False
        OnClick = tbnGoToPageClick
      end
      object tbnExtractPage: TToolButton
        Left = 163
        Top = 0
        Hint = 'Extract Page|Extract current page as untitled bitmap'
        Caption = 'Extract Page'
        ImageIndex = 22
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
        OnClick = miRevertClick
      end
      object miApplyChanges: TMenuItem
        Caption = 'Apply Changes'
        Hint = 'Apply image changes'
        ShortCut = 16449
        OnClick = miApplyChangesClick
      end
      object N11: TMenuItem
        Caption = '-'
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
      object miBack: TMenuItem
        Caption = 'Back'
        Hint = 'Go to previous image in current folder'
        ShortCut = 45
        OnClick = miBackClick
      end
      object miForward: TMenuItem
        Caption = 'Forward'
        Hint = 'Go to next image in current folder'
        ShortCut = 36
        OnClick = miForwardClick
      end
      object N12: TMenuItem
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
        Caption = 'Futuris Imager on the Web'
        Hint = 'Leads you to Futuris web site'
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
      OnClick = miBackClick
    end
    object piForward: TMenuItem
      Caption = 'Forward'
      OnClick = miForwardClick
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
    object piCustomZoom: TMenuItem
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
  object dlgSave: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save image as...'
    Left = 586
    Top = 188
  end
  object imlMain: TImageList
    Height = 24
    Width = 24
    Left = 555
    Top = 219
    Bitmap = {
      494C01011C001D00040018001800FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000060000000C000000001002000000000000020
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008C8F
      9100818486008184870082868700828687008286870082868800828688008287
      88008387890083878900838789008388890083888A0084888A0084888A008489
      8B0084898B0084898B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A4676900A66A6B00A6696B00A6696A00A6696A00A5696A00A569
      6A00A5696A00A6696A00A6696A00A46769000000000000000000000000008C8F
      9100818486008184870082868700828687008286870082868800828688008287
      88008387890083878900838789008388890083888A0084888A0084888A008489
      8B0084898B0084898B0000000000000000000000000000000000000000008C90
      9100F3F3F300F0F0F000EFEFEF00EEEEEE00EBEBEB00EAEAEA00E7E7E700E6E6
      E600E3E3E300E2E2E200E0E0E000DCDCDC00D8D8D800D5D5D500D1D1D100CECE
      CE00CBCBCB0084898B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AA707000FFFED700FAE2B700FBE0AD00F8D9A000F6D19100F4CC
      8600F3CA8200F8D48400FCD48400A5696A000000000000000000000000008C90
      9100F3F3F300F0F0F000EFEFEF00EEEEEE00EBEBEB00EAEAEA00E7E7E700E6E6
      E600E3E3E300E2E2E200E0E0E000DCDCDC00D8D8D800D5D5D500D1D1D100CECE
      CE00CBCBCB0084898B0000000000000000000000000000000000000000008E90
      9100F6F6F600F3F3F300F0F0F000EFEFEF00EEEEEE00EBEBEB00EAEAEA00E7E7
      E700E6E6E600E3E3E300E2E2E200E0E0E000DCDCDC00D8D8D800D5D5D500D1D1
      D100CECECE0084888A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AA6F7000FFF6D800F2D9BB008087CF002C46E6000323FB002B44
      DE007B79AF00EEC28000F4CB8200A5696A000000000000000000000000008E90
      9100F6F6F600F3F3F300F0F0F000EFEFEF00EEEEEE00EBEBEB00EAEAEA00E7E7
      E700E6E6E600E3E3E300E2E2E200E0E0E000DCDCDC00D8D8D800D5D5D500D1D1
      D100CECECE0084888A0000000000000000000000000000000000000000008E91
      9200F7F7F700F6F6F600F3F3F300F0F0F000EFEFEF00EEEEEE00EBEBEB00EAEA
      EA00E7E7E700E6E6E600E3E3E300E2E2E200E0E0E000DCDCDC00D8D8D800D5D5
      D500D1D1D10083888A0000000000000000000000000000000000105B8700105B
      8700105B8700105B8700105B8700105B8700105B8700105B8700105B8700105B
      8700105B8700105B8700105B8700105B8700105B8700105B8700105B8700105B
      8700105B8700105B870000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AB757200FFFCE600828CDC000222FE00001EFF00001EFF00001E
      FF000221FC007F7EB000F4CB8200A5696A000000000000000000000000008E91
      9200F7F7F700F6F6F600F3F3F300F0F0F0000B841F00EEEEEE00EBEBEB00B8EB
      CE000B841F000B841F00B8EBCE00E2E2E200E0E0E000DCDCDC00D8D8D800D5D5
      D500D1D1D10083888A0000000000000000000000000000000000000000008F91
      9200FAFAFA00F7F7F700F6F6F600F3F3F300F0F0F000EFEFEF00EEEEEE00EBEB
      EB00EAEAEA00E7E7E700E6E6E600E3E3E300E2E2E200E0E0E000DCDCDC00D8D8
      D800D5D5D50083878900000000000000000000000000137BB100137BB1001389
      C0001389C000138AC000138AC000138AC000138AC100138AC100138AC100138B
      C100138BC100138BC200138BC200138BC200138BC200138CC400138CC400138E
      C500138EC600137BB100105B8700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AC7F7500FFFFF6002D4BF200001EFF00001EFF00001EFF00001E
      FF00001EFF002C46DE00F6CE8900A5696A000000000000000000000000008F91
      9200FAFAFA00F7F7F700F6F6F600F3F3F3000DA624000B841F00EBEBEB000B84
      1F0025B5510023B44C000B841F00B8EBCE00E2E2E200E0E0E000DCDCDC00D8D8
      D800D5D5D5008387890000000000000000000000000000000000000000009092
      9300FBFBFB00FAFAFA00F7F7F700F6F6F600F3F3F300F0F0F000EFEFEF00EEEE
      EE00EBEBEB00EAEAEA00E7E7E700E6E6E600E3E3E300E2E2E200E0E0E000DCDC
      DC00D8D8D800838789000000000000000000000000001489BF00F2F2F20095D5
      ED0090D3EB008CD1EB0088D0EA0084CEE90080CCE9007DCAE70078C9E60075C6
      E60070C5E5006DC4E30069C1E3005FBDE2004EB5DE003DACDA002DA4D7001F9C
      D3001293CF001390CB00105B8700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B5837400FFFFFF000323FE00001EFF00001EFF00001EFF00001E
      FF00001EFF000323FB00F8D39600A5696A000000000000000000000000009092
      9300FBFBFB00FAFAFA00F7F7F700F6F6F6000DA624002AB85B000B841F002AB8
      5B000DA624000DA624000DA624000B841F00B8EBCE00E2E2E200E0E0E000DCDC
      DC00D8D8D8008387890000000000000000000000000000000000000000009092
      9300FBFBFB00FBFBFB00FAFAFA00F7F7F700F6F6F600F3F3F300F0F0F000EFEF
      EF00EEEEEE00EBEBEB00EAEAEA00E7E7E700E6E6E600E3E3E300E2E2E200E0E0
      E000DCDCDC00828788000000000000000000000000001489BF00F2F2F20098D7
      EE0095D5ED0090D3EB008CD1EB0088D0EA0084CEE90080CCE9007DCAE70078C9
      E60075C6E60070C5E5006DC4E30069C1E3005FBDE2004EB5DE003DACDA002DA4
      D7001F9CD3001390CA00105B8700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CE957500FFFFFF002D4EFA00001EFF00001EFF00001EFF00001E
      FF00001EFF002D48E600FFE0A400A6696A000000000000000000000000009092
      9300FBFBFB00FBFBFB00FAFAFA00F7F7F7000DA624002DBA60002EBB63000B84
      1F00EEEEEE00EBEBEB00B8EBCE000DA624000B841F00E3E3E300E2E2E200E0E0
      E000DCDCDC008287880000000000000000000000000000000000000000009092
      9300FBFBFB00FBFBFB00FBFBFB00FAFAFA00F7F7F700F6F6F600F3F3F300F0F0
      F000EFEFEF00EEEEEE00EBEBEB00EAEAEA00E7E7E700E6E6E600E3E3E300E2E2
      E200E0E0E000828688000000000000000000000000001489BF00F2F2F2009DD9
      EE0098D7EE0095D5ED0090D3EB008CD1EB0088D0EA0084CEE90080CCE9007DCA
      E70078C9E60075C6E60070C5E5006DC4E30069C1E3005FBDE2004EB5DE003DAC
      DA002DA4D7001897D000105B8700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D59A7700FFFFFF00889DFC000222FF00001EFF00001EFF00001E
      FF000222FE008692D700E0C2A000A5686A000000000000000000000000009092
      9300FBFBFB00FBFBFB00FBFBFB00FAFAFA000DA624002EBB630033BD6B002EBB
      63000B841F00EEEEEE00EBEBEB00B8EBCE000DA62400B8EBCE00E3E3E300E2E2
      E200E0E0E0008286880000000000000000000000000000000000000000009193
      9300FBFBFB00FBFBFB00FBFBFB00FBFBFB00FAFAFA00F7F7F700F6F6F600F3F3
      F300F0F0F000EFEFEF00EEEEEE00EBEBEB00EAEAEA00E7E7E700E6E6E600E3E3
      E300E2E2E200828687000000000000000000000000001488BD00F2F2F200A0DA
      EF009DD9EE0098D7EE0095D5ED0090D3EB008CD1EB0088D0EA0084CEE90080CC
      E9007DCAE70078C9E60075C6E60070C5E5006DC4E30069C1E3005FBDE2004EB5
      DE003DACDA001897D000105B8700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DCA17D00FFFFFF00FFFFFF00889EFF002E50FC000324FE002D4D
      F4007E84D500CBAF9800AF8B7B00A3676B000000000000000000000000009193
      9300FBFBFB00FBFBFB00FBFBFB00FBFBFB000DA624000DA624000DA624000DA6
      24000DA624000B841F00EEEEEE00EBEBEB00B8EBCE000B841F00E6E6E600E3E3
      E300E2E2E2008286870000000000000000000000000000000000000000009293
      9500FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FAFAFA00F7F7F700F6F6
      F600F3F3F300F0F0F000EFEFEF00EEEEEE00EBEBEB00EAEAEA00E7E7E700E6E6
      E600E3E3E300818487000000000000000000000000001488BD00F2F2F200A5DD
      F000A0DAEF009DD9EE0098D7EE0095D5ED0090D3EB008CD1EB0088D0EA0084CE
      E90080CCE9007DCAE70078C9E60075C6E60070C5E5006DC4E30069C1E3005FBD
      E2004EB5DE001897D000105B8700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DCA37E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFEFC00F8F0
      E700BD908200A36B64009F6B6500AC6959000000000000000000000000009293
      9500FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FAFAFA00F7F7F700F6F6
      F600F3F3F300F0F0F000EFEFEF00EEEEEE00EBEBEB00EAEAEA00E7E7E700E6E6
      E600E3E3E3008184870000000000000000000000000000000000000000009395
      9600FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FAFAFA00F7F7
      F700F6F6F600F3F3F300F0F0F000EFEFEF00EEEEEE00EBEBEB00EAEAEA00E7E7
      E700E6E6E600818486000000000000000000000000001488BD00F2F2F200A9DE
      F000A5DDF000A0DAEF009DD9EE0098D7EE0095D5ED0090D3EB008CD1EB0088D0
      EA0084CEE90080CCE9007DCAE70078C9E60075C6E60070C5E5006DC4E30069C1
      E3005FBDE2001897D000105B870000000000A4676900A4676900A4676900A467
      6900A4676900A4676900A4676900A4676900A4676900A4676900A4676900A467
      690000000000E7B08200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4F6
      FA00AF828200D18A4F00D4894A00000000000000000000000000000000009395
      9600FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FAFAFA00F7F7
      F700F6F6F600F3F3F300F0F0F000EFEFEF00EEEEEE00EBEBEB00EAEAEA00E7E7
      E700E6E6E6008184860000000000000000000000000000000000000000009596
      9600FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FAFA
      FA00F7F7F700F6F6F600F3F3F300F0F0F000EFEFEF00EEEEEE00EBEBEB00EAEA
      EA00E7E7E700818486000000000000000000000000001488BD00F2F2F200ADE0
      F200A9DEF000A5DDF000A0DAEF009DD9EE0098D7EE0095D5ED0090D3EB008CD1
      EB0088D0EA0084CEE90080CCE9007DCAE70078C9E60075C6E60070C5E5006DC4
      E30069C1E3001897D000105B870000000000A4676900FEE9C700F4DAB500F6D9
      AB00F4D4A000F2CE9500F0C78800EFC58100EEC58000F4CC8300EFC48000A467
      690000000000E9B08100FBFAFB00FAF3EF00FAF3EF00FAF3EF00FCF8F400EEE0
      D800B07F7600B676600000000000000000000000000000000000000000009596
      9600FBFBFB00FBFBFB000B841F00B8EBCE00FBFBFB00FBFBFB000DA624000B84
      1F000B841F000B841F000B841F000B841F00EFEFEF00EEEEEE00EBEBEB00EAEA
      EA00E7E7E7008184860000000000000000000000000000000000000000009596
      9700FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FAFAFA00F7F7F700F6F6F600F3F3F300F0F0F000EFEFEF00EEEEEE00EBEB
      EB00EAEAEA00808384000000000000000000000000001488BC00F2F2F200B4E3
      F300B0E1F200ABE0F200A7DDF000A3DCEF009FD9EF009AD8EE0097D7ED0092D4
      ED008FD3EB008AD0EA0087CFEA0082CCE9007FCBE7007ACAE70077C7E60073C6
      E5006FC4E5001897D000105B870000000000A4676900FCEACE00F3DABC00F0D5
      B400F0D0A900EECB9E00EDC69300EAC08800E9BC7F00EFC58100EFC48000A467
      690000000000E6A97800CF906C00D1926D00D1926D00D1926D00D1926D000562
      0A000A6E12000000000000000000000000000000000000000000000000009596
      9700FBFBFB00FBFBFB00B8EBCE000B841F00B8EBCE00FBFBFB00FBFBFB000DA6
      24002EBB630033BD6B002EBB63000B841F00F0F0F000EFEFEF00EEEEEE00EBEB
      EB00EAEAEA008083840000000000000000000000000000000000000000009697
      9700FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FAFAFA00F7F7F700F6F6F600F3F3F300F0F0F000EFEFEF00EEEE
      EE00EBEBEB00808384000000000000000000000000001487BC00F2F2F200B8E5
      F400B4E3F300B0E1F200ABE0F200A7DDF000A3DCEF009FD9EF009AD8EE0097D7
      ED0092D4ED008FD3EB008AD0EA0087CFEA0082CCE9007FCBE7007ACAE70077C7
      E60073C6E5001897D000105B870000000000A4676900E7C6AC00973D1700963D
      1600963C1500963B1300963A13009539110095380F00B4642F00EFC48000A467
      6900000000000000000000000000000000000000000000000000005201001A92
      2F0042E075000155030000000000000000000000000000000000000000009697
      9700FBFBFB00FBFBFB00FBFBFB000DA624000B841F00B8EBCE00FBFBFB00FBFB
      FB000DA624002EBB63002DBA60000B841F00F3F3F300F0F0F000EFEFEF00EEEE
      EE00EBEBEB008083840000000000000000000000000000000000000000009797
      9800FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FAFAFA00F7F7F700F6F6F600F3F3F300F0F0F000EFEF
      EF00DEDEDE00808283000000000000000000000000001487BC00F2F2F200BCE6
      F400B8E5F400B4E3F300B0E1F200ABE0F200A7DDF000A3DCEF009FD9EF009AD8
      EE0097D7ED0092D4ED008FD3EB008AD0EA0087CFEA0082CCE9007FCBE7007ACA
      E70077C7E6001997D000105B870000000000A7756B00FFF4E500A4512C00811E
      0000811E0000811E0000811E0000811E000083200100E0AB6F00EFC58300A467
      69000000000000000000000000000000000000000000004F0000138423003ED9
      6F0045E67A002DC24F0001550300000000000000000000000000000000009797
      9800FBFBFB00FBFBFB00FBFBFB00B8EBCE000DA624000B841F000B841F000B84
      1F002AB85B000DA624002AB85B000B841F00F6F6F600F3F3F300F0F0F000EFEF
      EF00DEDEDE008082830000000000000000000000000000000000000000009898
      9800FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FAFAFA00F7F7F700F6F6F600F3F3F300DEDE
      DE00C1C1C1007F8283000000000000000000000000001487BC00F2F2F200C1E9
      F600BCE6F400B8E5F400B4E3F300B0E1F200ABE0F200A7DDF000A3DCEF009FD9
      EF009AD8EE0097D7ED0092D4ED008FD3EB008AD0EA0087CFEA0082CCE9007FCB
      E7007ACAE7001F9CD300105B870000000000A7756B00FFFFFC00E6C7B2008321
      0100811E0000811E0000811E0000811E0000B0643700F0CE9300F2C98C00A467
      690000000000000000000000000000000000015503000F821C0035C660003FDC
      6F0030C6560018A92D0015A42800015503000000000000000000000000009898
      9800FBFBFB00FBFBFB00FBFBFB00FBFBFB00B8EBCE000DA6240023B44C0025B5
      51000B841F00FBFBFB000DA624000B841F00F7F7F700F6F6F600F3F3F300DEDE
      DE00C1C1C1007F82830000000000000000000000000000000000000000009999
      9900FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FAFAFA00C1C1C100B5B5B500A9A9
      A9009D9D9D007F8182000000000000000000000000001487BC00F2F2F200C5EA
      F700C1E9F600BCE6F400B8E5F400B4E3F300B0E1F200ABE0F200A7DDF000A3DC
      EF009FD9EF009AD8EE0097D7ED0092D4ED008FD3EB008AD0EA0087CFEA0082CC
      E9007FCBE7002DA4D700105B870000000000BC826800FFFFFC00FAF0E600B875
      5500811E0000811E0000811E00008A2B0700EBC59C00F3D3A000F3CE9700A467
      6900000000000000000000000000000000000155030001550300015503001CA0
      350023BC41000155030001550300015503000000000000000000000000009999
      9900FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00B8EBCE000DA624000DA6
      2400B8EBCE00FBFBFB00FBFBFB000DA62400FAFAFA00C1C1C100B5B5B500A9A9
      A9009D9D9D007F81820000000000000000000000000000000000000000009A9A
      9A00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00919393007E7F80007E8081007E80
      81007F8182007F8182000000000000000000000000001487BB00F2F2F200CAED
      F700C5EAF700C1E9F600BCE6F400B8E5F400B4E3F300B0E1F200ABE0F200F2F2
      F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2
      F200F2F2F200F2F2F200105B870000000000D1926D00FFFFFC00FEF7F200F6E9
      E1008E2F0C00811E0000811E0000C4866200F4D7B500FBDCAD00F6D3A000A467
      6900000000000000000000000000000000000000000000000000004C00000B7B
      16001BB733000155030000000000000000000000000000000000000000009A9A
      9A00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00919393007E7F80007E8081007E80
      81007F8182007F81820000000000000000000000000000000000000000009A9A
      9A00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB0092939500FFFFFF00FFFFFF00FFFF
      FF00D1D1D1007F8182000000000000000000000000001487BB00F2F2F200CEEE
      F800CAEDF700C5EAF700C1E9F600BCE6F400B8E5F400B4E3F300F2F2F2001488
      BD00136899001368990013689900136899001368990013689900136899001368
      990013689900136899001368990000000000D1926D00FFFFFC00FFFFFF00FFFE
      FE00CF9D8400811E0000983E1900F8E5CC00F8E3C500EBD9B700C5A48F00A467
      6900000000000000000000000000000000000000000000000000015403000978
      11000EA51D000155030000000000000000000000000000000000000000009A9A
      9A00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB0092939500FFFFFF00FFFFFF00FFFF
      FF00D1D1D1007F81820000000000000000000000000000000000000000009A9A
      9A00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB0093959500FFFFFF00FFFFFF00D1D1
      D10083868700000000000000000000000000000000001486BB00F2F2F200D4F0
      FA00D0EFF800CBEDF800C7EBF700C2EAF600BFE7F600F2F2F2001488BD00105B
      8700105B8700105B8700105B8700105B8700105B8700105B8700105B8700105B
      8700105B8700105B87000000000000000000DA9D7500FFFFFC00FFFFFF00FFFF
      FF00FFFEFE009A442000E0BBA500F4E3D100D5B19F00B7928000A77D7000A467
      6900000000000000000000000000000000000000000000000000035F0600067F
      0D00069810000155030000000000000000000000000000000000000000009A9A
      9A00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB0093959500FFFFFF00FFFFFF00D1D1
      D100838687000000000000000000000000000000000000000000000000009A9A
      9A00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB0095969600FFFFFF00D1D1D1008386
      870000000000000000000000000000000000000000001486BB00CEEEF800F2F2
      F200F2F2F200F2F2F200F2F2F200F2F2F200F2F2F2001488BC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DA9D7500FFFFFC00FFFFFF00FFFF
      FF00FFFFFF00F3E7E000FFFEF800E6D5CC00A56B5F00A56B5F00A56B5F00AF6A
      5600000000000000000000000000000000000000000000000000036907000692
      0E0005840C000155030000000000000000000000000000000000000000009A9A
      9A00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB0095969600FFFFFF00D1D1D1008386
      8700000000000000000000000000000000000000000000000000000000009A9A
      9A00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB0096969700D1D1D100838686000000
      00000000000000000000000000000000000000000000000000001486BB001486
      BB001487BB001487BB001487BB001487BC001487BC0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7AB7900FFFFFC00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E2D9DC00A56B5F00E1974E00D38749000000
      00000000000000000000000000000000000000000000036E0700068F0D000589
      0C00015503000000000000000000000000000000000000000000000000009A9A
      9A00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFBFB00FBFB
      FB00FBFBFB00FBFBFB00FBFBFB00FBFBFB0096969700D1D1D100838686000000
      0000000000000000000000000000000000000000000000000000000000009A9A
      9A00838383008383830083838300838383008383830083838300838383008383
      8300838383008383840083838400838484008384840083848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7AB7900FAF3EF00FAF3EF00FAF3
      EF00FAF3EF00FAF3EF00FAF3EF00DCC2B800A56B5F00BF7D6000000000000155
      03000155030001540300025C0500056F0C00057E0C0004800B00037208000155
      0300000000000000000000000000000000000000000000000000000000009A9A
      9A00838383008383830083838300838383008383830083838300838383008383
      8300838383008383840083838400838484008384840083848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7AB7900D1926D00D1926D00D192
      6D00D1926D00D1926D00D1926D00D1926D00A56B5F0000000000000000000000
      00000155030001550300025C0400025B0500025C040002580300015403000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A1E1E004A1E1E004A1E1E004A1E
      1E004A1E1E004A1E1E004A1E1E004A1E1E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A1E1E004A1E1E004A1E1E004A1E
      1E004A1E1E004A1E1E004A1E1E004A1E1E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009263
      5D00A4676900A4676900A4676900A4676900A4676900A4676900A4676900A467
      6900A4676900A4676900A4676900A4676900A4676900A4676900A4676900A467
      6900A4676900A467690000000000000000000000000000000000000000000000
      000000000000000000000000000000000000004B9800004B9800004B9800004B
      9800004B9800004B9800004B9800004B98000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004A1E1E004A1E1E006027160080340D00953B07009D3E
      05009D3E0500963D070082350C00642815004B1E1E004A1E1E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004A1E1E004A1E1E006027160080340D00953B07009D3E
      05009D3E0500963D070082350C00642815004B1E1E004A1E1E00000000000000
      0000000000000000000000000000000000000000000000000000000000009365
      5F00EFD3B400F6DAB600F3D5AD00F2D1A500F0CE9E00EFCA9700EFC79100EEC5
      8900EBC18200EBC08000EBC08000EBC08000EBC08000EBC08000EBC08000EDC1
      8000EABF7F009F6F600000000000000000000000000000000000000000000000
      00000000000000000000004B9800004B98000051A4000058B200005DBC00005E
      BE00005EBE00005DBC000058B2000051A400004B9800004B9800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006027160051211B006C2B1200A3410400C44E0000C7500000C64F0000C44F
      0000C44E0000C64F0000C7500000C44E0000A9440400742D10004D1F1C004D1F
      1C00000000000000000000000000000000000000000000000000000000000000
      00006027160051211B006C2B1200A3410400C44E0000C7500000C64F0000C44F
      0000C44E0000C64F0000C7500000C44E0000A9440400742D10004D1F1C004D1F
      1C00000000000000000000000000000000000000000000000000000000009365
      5F00EED4B800F4DABB00F2D5B100F0D1AA00EFCFA300EECB9D00EDC79600EDC5
      8F00EBC18900EABF8200E9BD7F00E9BD7F00E9BD7F00E9BD7F00E9BD7F00EABF
      7F00E7BC7E009F6F600000000000000000000000000000000000000000000000
      00000051A400004C9A000053A8000060C2000067D0000069D4000068D2000067
      D0000067D0000068D2000069D4000067D0000062C6000055AC00004B9800004B
      9800000000000000000000000000000000000000000000000000000000006027
      160060271600923C0800C9510000C64F0000BD4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BD4B0000C44F0000CC510000973D07005121
      1B004D1F1C000000000000000000000000000000000000000000000000006027
      160060271600923C0800C9510000C64F0000BC4B0000BB4A0000BA490000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000C44F0000CC510000973D07005121
      1B004D1F1C000000000000000000000000000000000000000000000000009365
      5F00EED7C000F7E1C400F2D9B800F2D5B100F0D1AA00EFCFA400EECB9D00EDC7
      9600EDC58F00EBC18900EABF8200E9BD7F00E9BD7F00E9BD7F00E9BD7F00EABF
      7F00E7BC7E009F6F600000000000000000000000000000000000000000000051
      A4000051A400005CBA000069D4000068D2000065CC000064CA000063C8000065
      CC000065CC000065CC000065CC000064CA000067D000006BD800005DBC00004C
      9A00004B9800000000000000000000000000000000000000000060271600692A
      1300993D0600CA510000BF4D0000BB4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BD4C0000CC510000993D
      060052211C004D1F1C000000000000000000000000000000000060271600692A
      1300993D0600CA510000BF4D0000BB4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4C0000CE520000993D
      060052211C004D1F1C0000000000000000000000000000000000000000009365
      5F00EFDAC500F7E1C400FFB15E00FFAB5100FFA64400FFA13800FF9C2D00FF96
      2100FF911700FF8C0F00FF880900FF840300FF810000FF810000FF810000EABF
      7F00E7BC7E009F6F6000000000000000000000000000000000000051A4000052
      A600005EBE00006AD6000065CC000063C800006FE0000B84FF000074EA000063
      C8000064CA000065CC000065CC000065CC000065CC000065CC00006BD800005E
      BE00004D9C00004B980000000000000000000000000000000000702D11009A3F
      0500C7500000BD4B0000BB490000BB490000BC4B0000BC4B0000BC4B0000BC4B
      0000BD4B0000BB490000BD4B0000BC4B0000BC4B0000BC4B0000BB4B0000CC51
      0000973D07004C1F1D0000000000000000000000000000000000702D11009A3F
      0500C7500000BD4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BB4A0000CE51
      0000973D07004C1F1D0000000000000000000000000000000000000000009365
      6000F0DECC00F8E6CF00FFB66D00FFB46300FFAD5600FFA94A00FFA33E00FF9D
      3100FF982500FF931B00FF8F1200FF8A0B00FF870500FF830100FF810000EABF
      7F00E7BC7E009F6F6000000000000000000000000000000000000054AA00005D
      BC000069D4000065CC000065CC000063C8000078F200ADD6FF00A3D0FF000079
      F4000063C8000064CA000065CC000065CC000065CC000065CC000064CA00006B
      D800005DBC00004B9800000000000000000000000000602716008B370900C44E
      0000BD4B0000BC4C0000BD4F0300BD4B0200BB490000BC4B0000BC4B0000BC4B
      0000BC4D0200BD4E0300BB480000BB490000BC4B0000BC4B0000BC4B0000BC4B
      0000CA500000742D10004C1F1D000000000000000000602716008B370900C44E
      0000BD4C0000BC4B0000BC4B0000BC4C0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000CA500000742D10004C1F1D00000000000000000000000000000000009566
      6000F2E2D300FAEAD700FFBB7800FFB76F00FFB46600FFAF5900FFAA4C00FFA4
      4100FF9F3500FF9A2800FF961D00FF901400FF8A0D00FF870600FF830200EABF
      7F00E7BC7E009F6F60000000000000000000000000000051A400005AB6000067
      D0000065CC000065CC000065CC000063C8000072E600A1CFFF00FFFFFF00BDDE
      FF000B84FF000063C8000064CA000065CC000065CC000065CC000065CC000065
      CC00006AD6000055AC00004B9800000000000000000081340C00AC450300C550
      0000BD4E0100C0520300D3803700D9925300BF4D0500BB490000BD4D0000BA44
      0000C55E1200D8935200C96A2200BA440000BB490000BC4B0000BC4B0000BB4B
      0000C54E0000A74303004C1F1D00000000000000000081340C00AC450300C54F
      0000BF4F0200C0500300C0530400D17F3800E2AB7800BF520400BD4C0000BC4B
      0000BC4B0000BC4B0000FFFFFF00FFFFFF00BC4B0000BC4B0000BC4B0000BB4B
      0000C54E0000A74303004C1F1D00000000000000000000000000000000009869
      6300F2E6DA00FAEEDE00FFBB7B00FFBB7800FFB87300FFB46800FFB05B00FFAB
      5100FFA54400FFA03700FF9D2B00FF962100FF911700FF8C0F00FF880700EABF
      7F00E7BC7E009F6F60000000000000000000000000000058B2000062C6000069
      D4000069D400006AD600006BD8000066CE000075EC00A1CFFF00FFFFFF00FFFF
      FF00C9E4FF00218FFF000067D0000064CA000065CC000065CC000065CC000065
      CC000068D2000060C200004B9800000000009A3F0500913A0900C1530300C457
      0700C6580800C6580800E2A46C00FFFFFF00E2A46C00C55B0D00C04E0000BC46
      0000C55D1100F6E2CF00F4DEC900CC743000BA440000BB480000BC4B0000BC4B
      0000BC4B0000C64F0000652815004A1E1E009A3F0500913A0900C1530300C557
      0600C55B0900C65C0C00C75E0D00D8894300FFFFFF00EBC29900C75C0D00C050
      0300BC4C0100BC4B0000FFFFFF00FFFFFF00BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000C64F0000652815004A1E1E000000000000000000000000009E6E
      6400F5ECE500FBF2E600FFBB7200FFBB7400FFBB7400FFB87000FFB66900FFB1
      5E00FFAB5300FFA64600FFA13A00FF9D2E00FF972300FF921800FF8E0F00EABF
      8200E7BB7E009F6F60000000000000000000005DBC00005CBA00006BD8000070
      E2000072E6000075EC000076EE000070E200007CFA00A7D2FF00FFFFFF00FFFF
      FF00FFFFFF00EFF7FF0057AAFF00006DDC000063C8000064CA000065CC000065
      CC000065CC000068D2000052A600004B98009A3F0500A4440800CC5F0A00C962
      1100CB631100CC651200E2A16700FFFFFF00FFFFFF00EBC09600CF6F2100C14B
      0000C65E0E00EFD0B200FFFFFF00F7EBDD00D5894800BC4B0300BA450000BC4B
      0000BC4B0000C750000082350C004A1E1E009A3F0500A4440800CC5F0A00C962
      1000CB651300CC671600CE691700DC8F4B00FFFFFF00FFFFFF00F3D7BC00CE70
      2200C1530500BD4E0100FFFFFF00FFFFFF00BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000C750000082350C004A1E1E00000000000000000000000000A372
      6600F5ECE500FCF4EB0088BCA900A3BB9E00B8BB9500DABC8700FFBB7400FFB6
      6600FFB25B00FFAD5000FFA94400FFA33800FF9E2D00FF982300FB921C00EBC2
      8800E7BC80009F6F600000000000000000001E7BDA000064CA000076EE000079
      F400007CFA00007EFF000380FF00007AF6000F86FF00ADD6FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0081BFFF000074EA000063C8000064CA000065
      CC000065CC000069D4000059B400004B98009A3F0500B1500B00D46B1600D16C
      1C00D16C1C00D36F1D00E5A76F00FFFFFF00FFFFFF00FFFFFF00F3DAC100D175
      2800C95F0F00EFD0B200FFFFFF00FFFFFF00FFFFFE00DD9F6700BD4D0500BC46
      0000BC4B0000C64F0000953B07004A1E1E009A3F0500B1500B00D46B1600D16C
      1C00D16D1D00D3702000D4732300E1985500FFFFFF00FFFFFF00FFFFFF00FAED
      E000D88E4A00C4550500FFFFFF00FFFFFF00BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000C64F0000953B07004A1E1E00000000000000000000000000A775
      6800F8F3F000FEFBF60003BDF8000DBCEF0017BCE90028BCDC0049BCC70076BB
      B00098B89800BFB58000CCB16E00CFAC6400F2A54300FF9D2B00FF982300EDC5
      8F00E9BF87009F6F620000000000000000001E7BDA00006CDA000782FF000D85
      FF000F86FF001388FF00178AFF000B84FF001F8EFF00B3D9FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009BCCFF00007EFF000065CC000065
      CC000065CC000068D200005DBC00004B98009A3F0500BB5B1200DA7E2D00D881
      3400D7772800D9782800E9B07800FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4DE
      C900DE9A5F00F3D5B700FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6B88F00C45C
      1200BB490000C54E00009D3E05004A1E1E009A3F0500BB5B1200DA7E2D00D881
      3400D8782A00D97A2C00DA7D2E00E6A36600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFEFE00E2A77000FFFFFF00FFFFFF00BC4B0000BC4B0000BC4B0000BC4B
      0000BB4A0000C54E00009D3E05004A1E1E00000000000000000000000000AC79
      6900FAF6F400FFFFFE0000C4FF0000C4FF0000C4FF0000C4FF0000C4FF0004C4
      FF000CC4FE0015C4F20019C4EB001BC2E9003BBDD80083B5A300BBAD7200EFCA
      9700EAC18E00A070630000000000000000001E7BDA000075EC002993FF002F96
      FF002390FF002792FF002B94FF001F8EFF003197FF00B9DCFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C9E4FF000581FF000064
      CA000064CA000068D200005EBE00004B98009F400400C1631B00E2934B00E399
      5700E0873900E0843500EDB78300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00EDC29900F3D9BF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBF0E500C96A
      2000BB480000C54E00009D3E05004A1E1E009F400400C1631B00E2934B00E399
      5700E0883B00E0873900E2893C00EAAC7000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E5AF7D00FFFFFF00FFFFFF00BD4B0000BC4B0000BC4B0000BC4B
      0000BB4A0000C54E00009D3E05004A1E1E00000000000000000000000000B17E
      6B00FAF6F400FFFFFF0003B8B50000B8B10001B6B80001B6B80000B7AF0000B8
      AC0000B8B70000B6C40000B4C10000B4BB0000B8B70005B7AC000FB6A500EECB
      9D00EBC59200A072640000000000000000001E7CDC00007EFF004FA6FF005DAD
      FF003D9DFF003B9CFF003F9EFF003599FF0045A1FF00BFDFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00ADD6FF00007EFF000064
      CA000064CA000068D200005EBE00004B98009A3F0500C1641B00E79F5E00EBB2
      7D00E6985000E68F4100F0BD8C00FFFFFF00FFFFFF00FFFFFF00FEFEFC00EAB2
      8000D9813700F2D5BA00FFFFFF00FFFFFF00FFFFFF00F2D9C100CC702F00BC4B
      0200BC4B0000C64F0000953B07004A1E1E009A3F0500C1641B00E79F5E00EBB2
      7D00E6995200E6914500E7954900EFB47B00FFFFFF00FFFFFF00FFFFFF00FBEE
      E200E29C5C00CF691700FFFFFF00FFFFFF00BD4C0100BC4B0000BC4B0000BC4B
      0000BC4B0000C64F0000953B07004A1E1E00000000000000000000000000B681
      6C00FAF6F400FFFFFF001D70260018771F0025762C0028782D00197A1F00167D
      1C001F782700286D34002B70350021732A0011701C0010761C001A772900F0CF
      A300EDC999009D70650000000000000000001E7BDA00007EFF0067B2FF0085C1
      FF0059ABFF004DA5FF0051A7FF0049A3FF0055A9FF00C5E2FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0073B8FF000071E4000063C8000064
      CA000065CC000068D200005DBC00004B98009A3F0500BC5B1300EAA36300F2C6
      9C00EFB07600ED994F00F4C59600FFFFFF00FFFFFF00FBF0E500EEB88400D979
      2800D7792A00F3D9BF00FFFFFF00FFFFFF00E9C09900C7682100B8430000BB48
      0000BC4B0000C750000080340D004A1E1E009A3F0500BC5B1300EAA36300F2C6
      9C00EFB17700ED9D5400ED9E5600F3BB8700FFFFFF00FFFFFF00F8E3CF00E292
      4A00D7762500D16C1B00FFFFFF00FFFFFF00BD4E0200BC4B0000BC4B0000BC4B
      0000BC4B0000C750000080340D004A1E1E00000000000000000000000000BB84
      6E00FAF6F400FFFFFF0084796F006E686600656063005F5D6000666263006560
      63006560630090817400C2A68700C1A5860091817300746C68006D676700EFD0
      A700CEB49100896A630000000000000000001E7BDA000077F0006DB5FF00A5D1
      FF0083C0FF0061AFFF0065B1FF005BACFF0065B1FF00C9E4FF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00EFF7FF006BB4FF00006AD6000063C8000064CA000065
      CC000065CC000069D4000059B400004B98009A3F0500B44E0900E6995500F4CC
      A600F8D0A700F2AF6F00F8CCA300FFFFFF00FCEAD800EFB07600E5893B00DC7A
      2800DC863900F7E3CE00FFFFFF00E5B07D00C25A0C00B8430000BD4B0000BC4B
      0000BD4B0000C44E0000622816004A1E1E009A3F0500B44E0900E6995500F4CC
      A600F8D0A900F3B07400F3AB6700F8C59300FFFFFF00F8DCC000E6974D00E086
      3700D9792A00D46F1F00FFFFFF00FFFFFF00C0500300BC4C0000BC4B0000BC4B
      0000BD4B0000C44E0000622816004A1E1E00000000000000000000000000C089
      6F00FAF6F400FFFFFF00EAC99C00D7B89500CCB48F00AB9A83006C696A006D6B
      6C00B8A48900F4D19F00FEE0A600FEE0A600F0CE9E00DEBF9600D4B79200C4B0
      9600A1927F008067620000000000000000001E7BDA00006BD8005DADFF00B1D8
      FF00B5DAFF0083C0FF0079BBFF006FB6FF0075B9FF00CFE7FF00FFFFFF00FFFF
      FF00FFFFFF00D7EBFF0053A8FF000070E2000065CC000065CC000065CC000065
      CC000065CC000067D0000051A400004B980000000000B1470200D57D3300F6C4
      9500FAE2CA00F8D0A700FED9B600FFEDDC00F6B47400ED994F00E7924600DE81
      3100E08E4600F3D5B700E5A76F00C75C0B00BD4C0000BC4B0000BC4B0000BB4B
      0000C64F0000A54203004A1E1E000000000000000000B1470200D57D3300F6C4
      9500FAE3CB00F8D0A900FBBD8000FBCA9800FADABB00EE9F5900E7934900E189
      3B00DA7D2D00D4732200FFFFFF00FFFFFF00C0520300BC4C0000BC4B0000BB4B
      0000C64F0000A54203004A1E1E0000000000000000000000000000000000C58C
      7000FAF6F400FFFFFF00FFDDA300FEDDA400FFDEA500FBD9A100E7C79800E9C9
      9900FEDAA300FFDDA300FFD9A100FFD9A100FFDDA300FFDEA500FEDDA400A79C
      8B00A4978600846964000000000000000000000000001E81E6002B94FF00A3D0
      FF00D3E9FF00B5DAFF0095C9FF0083C0FF007FBEFF00CFE7FF00FFFFFF00FFFF
      FF00BBDDFF00379AFF00007AF6000073E800006BD8000065CC000065CC000065
      CC000068D2000060C200004B98000000000000000000963D0700BC590F00EFAF
      7200FBDDBF00FCEAD800FED9B600FBC58F00F3A65F00EE9E5600E7954A00E087
      3700DC863900DA873F00CF6A1900C6590800C0530300BC4C0000BC4B0000BD4B
      0000CA5000006D2C12004A1E1E000000000000000000963D0700BC590F00EFAF
      7200FBDDBF00FCEAD700FED5AC00FBBB7A00F4B06E00EE9F5700E7934900E189
      3C00D97D2D00D4732200CE681700C75D0D00C0520400BC4C0000BC4B0000BD4B
      0000CA5000006D2C12004A1E1E0000000000000000000000000000000000CB91
      7300FAF6F400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFE
      FB00FCF7F000FCF4EB00FBF2E600E9D3C4009F675B0098665B0095655B009665
      5B0096655B00986859000000000000000000000000001E7BDA000074EA007FBE
      FF00C9E4FF00DDEEFF00BDDEFF008FC6FF007FBEFF00D7EBFF00FFFFFF00B9DC
      FF00399BFF000983FF00007EFF000076EE00006BD8000065CC000065CC000065
      CC00006AD6000054AA00004B9800000000000000000000000000B2470100CF74
      2A00F8C59200FCE7D100FFEDDC00FAD4AD00F3B57900EB9E5700E6914500E087
      3900D97A2C00D16C1C00CC651300C65C0C00C0510300BC4C0000BD4C0000CC51
      00008E3809004C1F1D0000000000000000000000000000000000B2470100CF74
      2A00F8C59200FCE7D300FEEEDE00FAD3AC00F6BB8600EB9C5300E6914500E087
      3900D97A2B00D3702000CC671600C65C0C00C0510300BC4B0000BD4C0000CC51
      00008E3809004C1F1D000000000000000000000000000000000000000000CF96
      7400FBF7F600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFCFB00FCF7F000FFFAEF00DAC0B6009F675B00DAA16B00DD984F00E290
      3A00EA892300A5686B00000000000000000000000000000000001E81E6001D8D
      FF00A3D0FF00DBEDFF00E5F2FF00B9DCFF0095C9FF00C9E4FF00ABD5FF00419F
      FF001D8DFF001388FF00007EFF000075EC00006AD6000065CC000065CC00006B
      D800005BB800004B980000000000000000000000000000000000963D0700B449
      0300D37B3300F7C69700FBE5CE00FCEEE000F8DCC000F2BF8E00EAA56500E290
      4900DA803300D4752600CF6F2100CB6A1B00C5621300C4570700CC5100009038
      09004F1F1C006E2D130000000000000000000000000000000000963D0700B449
      0300D37B3300F7C69700FBE5CE00FEEEDE00F8DDC100F3C79C00EBA66900E18E
      4200D9813300D4762700CF6F2000CB6A1B00C5621300C4570700CC5100009038
      09004F1F1C006E2D13000000000000000000000000000000000000000000D498
      7500FCF8F600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFCFB00FFFEF700DDC4BC009F675B00EAB47400EFA95200F6A0
      3600A5686B0000000000000000000000000000000000000000001E7BDA001E83
      EA002993FF00A5D1FF00D5EAFF00E5F2FF00C9E4FF00A7D2FF0073B8FF0045A1
      FF002F96FF001D8DFF001187FF000782FF00007AF6000070E200006BD800005C
      BA00004C9A000055AC000000000000000000000000000000000000000000963D
      0700B2490300CF762D00F2B67F00FAD5B100FAE5D000FAE5D100F6D9BF00EFC7
      A000EAB88800E5AB7500E2A16700DA904D00D4762700CA5B0A00913908005423
      19006E2D1300000000000000000000000000000000000000000000000000963D
      0700B2490300CF762D00F2B67E00FAD5B100FAE5D000FAE5D000F6D9BD00EEC7
      A100EAB88800E5AB7500E1A16800DA904D00D4762700CA5B0A00913908005423
      19006E2D1300000000000000000000000000000000000000000000000000D498
      7500FCF8F600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DDC7C2009F675B00EAB27300EFA75100A568
      6B00000000000000000000000000000000000000000000000000000000001E7B
      DA001E82E800218FFF008BC4FF00BDDEFF00D7EBFF00D7EBFF00C5E2FF00A7D2
      FF008FC6FF0079BBFF006BB4FF004BA4FF001D8DFF000075EC00005CBA00004D
      9C000055AC000000000000000000000000000000000000000000000000000000
      0000963D0700AF460200BA591300D7874200EBAF7500F2C49500F4CCA600F3CC
      A700F2C69C00EAB58100E29D5C00D17B3100AF5313007F3510005C2516006E2D
      1300000000000000000000000000000000000000000000000000000000000000
      0000963D0700AF460200BA591300D7874200EBAF7500F2C49500F4CCA600F3CC
      A700F0C59A00EAB58100E29D5C00D17B3100AF5313007F3510005C2516006E2D
      130000000000000000000000000000000000000000000000000000000000D498
      7500FFFFFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E2D0CE009F675B00EDB57200A5686B000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001E7BDA001E80E4000075EC003D9DFF007FBEFF009FCEFF00B1D8FF00B1D8
      FF00A3D0FF0089C3FF0061AFFF002792FF000071E400005AB600004FA0000055
      AC00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000963D0700A9440400AD521100BA662400C5763700C97D
      3E00C4773900BA682C00A1511C00843B14006E2D13006E2D1300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000963D0700A9440400AD521100BA662400C5763700C97D
      3E00C4773900BA682C00A1511C00843B14006E2D13006E2D1300000000000000
      000000000000000000000000000000000000000000000000000000000000CF8E
      6800CF8E6800CF8E6800CF8E6800CF8E6800CF8E6800CF8E6800CF8E6800CF8E
      6800CF8E6800CF8E6800CF8E6800CF8E68009F675B00A5686B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000001E7BDA000062C600006FE0000581FF002390FF002D95
      FF002591FF000D85FF000072E6000060C2000055AC000055AC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000963D0700963D0700963D07009139
      080088350A00963D0700963D0700963D07000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000963D0700963D0700963D07009139
      080088350A00963D0700963D0700963D07000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001E7BDA001E7BDA001E7BDA001E7A
      D8001E77D2001E7BDA001E7BDA001E7BDA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A1E1E004A1E1E004A1E1E004A1E
      1E004A1E1E004A1E1E004A1E1E004A1E1E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A1E1E004A1E1E004A1E1E004A1E
      1E004A1E1E004A1E1E004A1E1E004A1E1E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A1E1E004A1E1E004A1E1E004A1E
      1E004A1E1E004A1E1E004A1E1E004A1E1E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A1E1E004A1E1E004A1E1E004A1E
      1E004A1E1E004A1E1E004A1E1E004A1E1E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004A1E1E004A1E1E006027160080340D00953B07009D3E
      05009D3E0500963D070082350C00642815004B1E1E004A1E1E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004A1E1E004A1E1E006027160080340D00953B07009D3E
      05009D3E0500963D070082350C00642815004B1E1E004A1E1E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004A1E1E004A1E1E006027160080340D00953B07009D3E
      05009D3E0500963D070082350C00642815004B1E1E004A1E1E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004A1E1E004A1E1E006027160080340D00953B07009D3E
      05009D3E0500963D070082350C00642815004B1E1E004A1E1E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006027160051211B006C2B1200A3410400C44E0000C7500000C64F0000C44F
      0000C44E0000C64F0000C7500000C44E0000A9440400742D10004D1F1C004D1F
      1C00000000000000000000000000000000000000000000000000000000000000
      00006027160051211B006C2B1200A3410400C44E0000C7500000C64F0000C44F
      0000C44E0000C64F0000C7500000C44E0000A9440400742D10004D1F1C004D1F
      1C00000000000000000000000000000000000000000000000000000000000000
      00006027160051211B006C2B1200A3410400C44E0000C7500000C64F0000C44F
      0000C44E0000C64F0000C7500000C44E0000A9440400742D10004D1F1C004D1F
      1C00000000000000000000000000000000000000000000000000000000000000
      00006027160051211B006C2B1200A3410400C44E0000C7500000C64F0000C44F
      0000C44E0000C64F0000C7500000C44E0000A9440400742D10004D1F1C004D1F
      1C00000000000000000000000000000000000000000000000000000000006027
      160060271600923C0800C9510000C64F0000BC4B0000BB4A0000BA490000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000C44F0000CC510000973D07005121
      1B004D1F1C000000000000000000000000000000000000000000000000006027
      160060271600923C0800C9510000C64F0000BC4B0000BB4A0000BA490000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000C44F0000CC510000973D07005121
      1B004D1F1C000000000000000000000000000000000000000000000000006027
      160060271600923C0800C9510000C64F0000BC4B0000BB4A0000BA490000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000C44F0000CC510000973D07005121
      1B004D1F1C000000000000000000000000000000000000000000000000006027
      160060271600923C0800C9510000C64F0000BC4B0000BB4A0000BA490000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000C44F0000CC510000973D07005121
      1B004D1F1C00000000000000000000000000000000000000000060271600692A
      1300993D0600CA510000BF4D0000BB4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4C0000CE520000993D
      060052211C004D1F1C000000000000000000000000000000000060271600692A
      1300993D0600CA510000BF4D0000BB4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4C0000CE520000993D
      060052211C004D1F1C000000000000000000000000000000000060271600692A
      1300993D0600CA510000BF4D0000BB4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4C0000CE520000993D
      060052211C004D1F1C000000000000000000000000000000000060271600692A
      1300993D0600CA510000BF4D0000BB4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4C0000CE520000993D
      060052211C004D1F1C0000000000000000000000000000000000702D11009A3F
      0500C7500000BD4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BB4A0000CE51
      0000973D07004C1F1D0000000000000000000000000000000000702D11009A3F
      0500C7500000BD4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BB4A0000CE51
      0000973D07004C1F1D0000000000000000000000000000000000702D11009A3F
      0500C7500000BD4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BB4A0000CE51
      0000973D07004C1F1D0000000000000000000000000000000000702D11009A3F
      0500C7500000BD4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BB4A0000CE51
      0000973D07004C1F1D00000000000000000000000000602716008B370900C44E
      0000BD4C0000BC4B0000BC4B0000BC4C0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000CA500000742D10004C1F1D000000000000000000602716008B370900C44E
      0000BD4C0000BC4B0000BC4B0000BC4C0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000CA500000742D10004C1F1D000000000000000000602716008B370900C44E
      0000BD4C0000BC4B0000BC4B0000BC4C0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000CA500000742D10004C1F1D000000000000000000602716008B370900C44E
      0000BD4C0000BC4B0000BC4B0000BC4C0000BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B
      0000CA500000742D10004C1F1D00000000000000000081340C00AC450300C54F
      0000BF4F0200C0500300C0530400BD4C0000FFFFFF00FFFFFF00FFFFFF00BC4B
      0000BC4B0000FFFFFF00FFFFFF00FFFFFF00BC4B0000BC4B0000BC4B0000BB4B
      0000C54E0000A74303004C1F1D00000000000000000081340C00AC450300C54F
      0000BF4F0200C0500300C0530400BD4C0000C0500200BD4E0100BD4C0000BC4B
      0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BC4B0000BB4B
      0000C54E0000A74303004C1F1D00000000000000000081340C00AC450300C54F
      0000BF4F0200C0500300C0530400BD4C0000FFFFFF00FFFFFF00BD4C0000BC4B
      0000BC4B0000BC4B0000BD4F0200E1A97500D17F3800BC4B0000BC4B0000BB4B
      0000C54E0000A74303004C1F1D00000000000000000081340C00AC450300C54F
      0000BF4F0200C0500300C0530400BD4C0000C0500200BF520400E1AA7600D17F
      3700BC4B0000BC4B0000BC4B0000BC4B0000BD4F0200E1A97500D17F3800BB4B
      0000C54E0000A74303004C1F1D00000000009A3F0500913A0900C1530300C557
      0600C55B0900C65C0C00C75E0D00C5570600FFFFFF00FFFFFF00FFFFFF00C050
      0300BC4C0100FFFFFF00FFFFFF00FFFFFF00BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000C64F0000652815004A1E1E009A3F0500913A0900C1530300C557
      0600C55B0900C65C0C00C75E0D00C5570600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000C64F0000652815004A1E1E009A3F0500913A0900C1530300C557
      0600C55B0900C65C0C00C75E0D00C5570600FFFFFF00FFFFFF00C4540600C050
      0300BC4C0100C0530600E7BC9200FFFFFF00D1803A00BC4B0000BC4B0000BC4B
      0000BC4B0000C64F0000652815004A1E1E009A3F0500913A0900C1530300C557
      0600C55B0900C65C0C00C75E0D00C5570600CA641300EBC29900FFFFFF00D483
      3E00BC4C0100BC4B0000BC4B0000C0530600E7BC9200FFFFFF00D1803A00BC4B
      0000BC4B0000C64F0000652815004A1E1E009A3F0500A4440800CC5F0A00C962
      1000CB651300CC671600CE691700CB621000FFFFFF00FFFFFF00FFFFFF00C65B
      0A00C1530500FFFFFF00FFFFFF00FFFFFF00BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000C750000082350C004A1E1E009A3F0500A4440800CC5F0A00C962
      1000CB651300CC671600CE691700CB621000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000C750000082350C004A1E1E009A3F0500A4440800CC5F0A00C962
      1000CB651300CC671600CE691700CB621000FFFFFF00FFFFFF00CA5F0E00C65B
      0A00CA691C00EFD1B500FFFFFF00FFFFFF00D07E3700BC4B0000BC4B0000BC4B
      0000BC4B0000C750000082350C004A1E1E009A3F0500A4440800CC5F0A00C962
      1000CB651300CC671600CE691700D3762800F3D9BF00FFFFFF00FFFFFF00D88A
      4400C1530500BD4E0100C6621400EFD1B400FFFFFF00FFFFFF00D07E3700BC4B
      0000BC4B0000C750000082350C004A1E1E009A3F0500B1500B00D46B1600D16C
      1C00D16D1D00D3702000D4732300D36D1A00FFFFFF00FFFFFF00FFFFFF00CB63
      1100C65C0C00FFFFFF00FFFFFF00FFFFFF00BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000C64F0000953B07004A1E1E009A3F0500B1500B00D46B1600D16C
      1C00D16D1D00D3702000D4732300D36D1A00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BC4B0000BC4B0000BC4B0000BC4B
      0000BC4B0000C64F0000953B07004A1E1E009A3F0500B1500B00D46B1600D16C
      1C00D16D1D00D3702000D4732300D36D1A00FFFFFF00FFFFFF00CF691700DC92
      5000F8EBDE00FFFFFF00FFFFFF00FFFFFF00D07E3700BC4B0000BC4B0000BC4B
      0000BC4B0000C64F0000953B07004A1E1E009A3F0500B1500B00D46B1600D16C
      1C00D16D1D00D3702000E29E5F00FAEEE100FFFFFF00FFFFFF00FFFFFF00DC90
      4C00C65C0C00D7884200F7EADC00FFFFFF00FFFFFF00FFFFFF00D07E3700BC4B
      0000BC4B0000C64F0000953B07004A1E1E009A3F0500BB5B1200DA7E2D00D881
      3400D8782A00D97A2C00DA7D2E00DA7D2D00FFFFFF00FFFFFF00FFFFFF00D06B
      1900CB631200FFFFFF00FFFFFF00FFFFFF00BC4B0000BC4B0000BC4B0000BC4B
      0000BB4A0000C54E00009D3E05004A1E1E009A3F0500BB5B1200DA7E2D00D881
      3400D8782A00D97A2C00DA7D2E00DA7D2D00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BC4B0000BC4B0000BC4B0000BC4B
      0000BB4A0000C54E00009D3E05004A1E1E009A3F0500BB5B1200DA7E2D00D881
      3400D8782A00D97A2C00DA7D2E00DA7D2D00FFFFFF00FFFFFF00E9B48000FFFF
      FE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D07E3700BC4B0000BC4B0000BC4B
      0000BB4A0000C54E00009D3E05004A1E1E009A3F0500BB5B1200DA7E2D00D881
      3400D8782A00EBB88900FFFFFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DE96
      5400E5AB7600FFFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D07E3700BC4B
      0000BB4A0000C54E00009D3E05004A1E1E009F400400C1631B00E2934B00E399
      5700E0883B00E0873900E2893C00E1893B00FFFFFF00FFFFFF00FFFFFF00D574
      2300D06B1A00FFFFFF00FFFFFF00FFFFFF00BD4B0000BC4B0000BC4B0000BC4B
      0000BB4A0000C54E00009D3E05004A1E1E009F400400C1631B00E2934B00E399
      5700E0883B00E0873900E2893C00E1893B00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BD4B0000BC4B0000BC4B0000BC4B
      0000BB4A0000C54E00009D3E05004A1E1E009F400400C1631B00E2934B00E399
      5700E0883B00E0873900E2893C00E1893B00FFFFFF00FFFFFF00EDBB8E00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D17E3700BC4B0000BC4B0000BC4B
      0000BB4A0000C54E00009D3E05004A1E1E009F400400C1631B00E2934B00E399
      5700E0883B00EFC29600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E29D
      5C00E7B48100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D07E3700BC4B
      0000BB4A0000C54E00009D3E05004A1E1E009A3F0500C1641B00E79F5E00EBB2
      7D00E6995200E6914500E7954900E7934800FFFFFF00FFFFFF00FFFFFF00D97A
      2B00D4722000FFFFFF00FFFFFF00FFFFFF00BD4C0100BC4B0000BC4B0000BC4B
      0000BC4B0000C64F0000953B07004A1E1E009A3F0500C1641B00E79F5E00EBB2
      7D00E6995200E6914500E7954900E7934800FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BD4C0100BC4B0000BC4B0000BC4B
      0000BC4B0000C64F0000953B07004A1E1E009A3F0500C1641B00E79F5E00EBB2
      7D00E6995200E6914500E7954900E7934800FFFFFF00FFFFFF00DE823500E5A3
      6500FAEDE000FFFFFF00FFFFFF00FFFFFF00D17F3800BC4B0000BC4B0000BC4B
      0000BC4B0000C64F0000953B07004A1E1E009A3F0500C1641B00E79F5E00EBB2
      7D00E6995200E6914500EFB57E00FCF2E700FFFFFF00FFFFFF00FFFFFF00E5A1
      6400D4722000DE965300F8EADC00FFFFFF00FFFFFF00FFFFFF00D07E3700BC4B
      0000BC4B0000C64F0000953B07004A1E1E009A3F0500BC5B1300EAA36300F2C6
      9C00EFB17700ED9D5400ED9E5600EE9E5600FFFFFF00FFFFFF00FFFFFF00DD81
      3200D7762500FFFFFF00FFFFFF00FFFFFF00BD4E0200BC4B0000BC4B0000BC4B
      0000BC4B0000C750000080340D004A1E1E009A3F0500BC5B1300EAA36300F2C6
      9C00EFB17700ED9D5400ED9E5600EE9E5600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BD4E0200BC4B0000BC4B0000BC4B
      0000BC4B0000C750000080340D004A1E1E009A3F0500BC5B1300EAA36300F2C6
      9C00EFB17700ED9D5400ED9E5600EE9E5600FFFFFF00FFFFFF00E2893D00DD81
      3200DC883E00F4DCC400FFFFFF00FFFFFF00D1803A00BC4B0000BC4B0000BC4B
      0000BC4B0000C750000080340D004A1E1E009A3F0500BC5B1300EAA36300F2C6
      9C00EFB17700ED9D5400ED9E5600F0AB6C00FBE7D500FFFFFF00FFFFFF00E7A6
      6900D7762500D16C1B00D3782B00F2D7BC00FFFFFF00FFFFFF00D07E3700BC4B
      0000BC4B0000C750000080340D004A1E1E009A3F0500B44E0900E6995500F4CC
      A600F8D0A900F3B07400F3AB6700F4AA6500FFFFFF00FFFFFF00FFFFFF00E086
      3700D9792A00FFFFFF00FFFFFF00FFFFFF00C0500300BC4C0000BC4B0000BC4B
      0000BD4B0000C44E0000622816004A1E1E009A3F0500B44E0900E6995500F4CC
      A600F8D0A900F3B07400F3AB6700F4AA6500FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0500300BC4C0000BC4B0000BC4B
      0000BD4B0000C44E0000622816004A1E1E009A3F0500B44E0900E6995500F4CC
      A600F8D0A900F3B07400F3AB6700F4AA6500FFFFFF00FFFFFF00E5904300E086
      3700D9792A00D7772A00EEC9A400FFFFFF00D4833E00BC4C0000BC4B0000BC4B
      0000BD4B0000C44E0000622816004A1E1E009A3F0500B44E0900E6995500F4CC
      A600F8D0A900F3B07400F3AB6700F4AA6500F2A76600F8DCC000FFFFFF00EAAB
      7000D9792A00D46F1F00CE661500CB651400EAC09800FFFFFF00D1803A00BC4B
      0000BD4B0000C44E0000622816004A1E1E0000000000B1470200D57D3300F6C4
      9500FAE3CB00F8D0A900FBBD8000FAB26E00FFFFFF00FFFFFF00FFFFFF00E189
      3B00DA7D2D00FFFFFF00FFFFFF00FFFFFF00C0520300BC4C0000BC4B0000BB4B
      0000C64F0000A54203004A1E1E000000000000000000B1470200D57D3300F6C4
      9500FAE3CB00F8D0A900FBBD8000FAB26E00F4AF6D00EE9D5500E7934900E189
      3B00DA7D2D00D4732200CE681700C75D0D00C0520300BC4C0000BC4B0000BB4B
      0000C64F0000A54203004A1E1E000000000000000000B1470200D57D3300F6C4
      9500FAE3CB00F8D0A900FBBD8000FAB26E00FFFFFF00FFFFFF00E7934900E189
      3B00DA7D2D00D4732200CF6B1C00E6B48300D3833D00BC4C0000BC4B0000BB4B
      0000C64F0000A54203004A1E1E000000000000000000B1470200D57D3300F6C4
      9500FAE3CB00F8D0A900FBBD8000FAB26E00F4AF6D00EE9F5900F4CEA900EAAC
      7000DA7D2D00D4732200CE681700C75D0D00C1560700E1AA7700D07E3700BB4B
      0000C64F0000A54203004A1E1E000000000000000000963D0700BC590F00EFAF
      7200FBDDBF00FCEAD700FED5AC00FBBB7A00F4B06E00EE9F5700E7934900E189
      3C00D97D2D00D4732200CE681700C75D0D00C0520400BC4C0000BC4B0000BD4B
      0000CA5000006D2C12004A1E1E000000000000000000963D0700BC590F00EFAF
      7200FBDDBF00FCEAD700FED5AC00FBBB7A00F4B06E00EE9F5700E7934900E189
      3C00D97D2D00D4732200CE681700C75D0D00C0520400BC4C0000BC4B0000BD4B
      0000CA5000006D2C12004A1E1E000000000000000000963D0700BC590F00EFAF
      7200FBDDBF00FCEAD700FED5AC00FBBB7A00F4B06E00EE9F5700E7934900E189
      3C00D97D2D00D4732200CE681700C75D0D00C0520400BC4C0000BC4B0000BD4B
      0000CA5000006D2C12004A1E1E000000000000000000963D0700BC590F00EFAF
      7200FBDDBF00FCEAD700FED5AC00FBBB7A00F4B06E00EE9F5700E7934900E189
      3C00D97D2D00D4732200CE681700C75D0D00C0520400BC4C0000BC4B0000BD4B
      0000CA5000006D2C12004A1E1E00000000000000000000000000B2470100CF74
      2A00F8C59200FCE7D300FEEEDE00FAD3AC00F6BB8600EB9C5300E6914500E087
      3900D97A2B00D3702000CC671600C65C0C00C0510300BC4B0000BD4C0000CC51
      00008E3809004C1F1D0000000000000000000000000000000000B2470100CF74
      2A00F8C59200FCE7D300FEEEDE00FAD3AC00F6BB8600EB9C5300E6914500E087
      3900D97A2B00D3702000CC671600C65C0C00C0510300BC4B0000BD4C0000CC51
      00008E3809004C1F1D0000000000000000000000000000000000B2470100CF74
      2A00F8C59200FCE7D300FEEEDE00FAD3AC00F6BB8600EB9C5300E6914500E087
      3900D97A2B00D3702000CC671600C65C0C00C0510300BC4B0000BD4C0000CC51
      00008E3809004C1F1D0000000000000000000000000000000000B2470100CF74
      2A00F8C59200FCE7D300FEEEDE00FAD3AC00F6BB8600EB9C5300E6914500E087
      3900D97A2B00D3702000CC671600C65C0C00C0510300BC4B0000BD4C0000CC51
      00008E3809004C1F1D0000000000000000000000000000000000963D0700B449
      0300D37B3300F7C69700FBE5CE00FEEEDE00F8DDC100F3C79C00EBA66900E18E
      4200D9813300D4762700CF6F2000CB6A1B00C5621300C4570700CC5100009038
      09004F1F1C006E2D130000000000000000000000000000000000963D0700B449
      0300D37B3300F7C69700FBE5CE00FEEEDE00F8DDC100F3C79C00EBA66900E18E
      4200D9813300D4762700CF6F2000CB6A1B00C5621300C4570700CC5100009038
      09004F1F1C006E2D130000000000000000000000000000000000963D0700B449
      0300D37B3300F7C69700FBE5CE00FEEEDE00F8DDC100F3C79C00EBA66900E18E
      4200D9813300D4762700CF6F2000CB6A1B00C5621300C4570700CC5100009038
      09004F1F1C006E2D130000000000000000000000000000000000963D0700B449
      0300D37B3300F7C69700FBE5CE00FEEEDE00F8DDC100F3C79C00EBA66900E18E
      4200D9813300D4762700CF6F2000CB6A1B00C5621300C4570700CC5100009038
      09004F1F1C006E2D13000000000000000000000000000000000000000000963D
      0700B2490300CF762D00F2B67E00FAD5B100FAE5D000FAE5D000F6D9BD00EEC7
      A100EAB88800E5AB7500E1A16800DA904D00D4762700CA5B0A00913908005423
      19006E2D1300000000000000000000000000000000000000000000000000963D
      0700B2490300CF762D00F2B67E00FAD5B100FAE5D000FAE5D000F6D9BD00EEC7
      A100EAB88800E5AB7500E1A16800DA904D00D4762700CA5B0A00913908005423
      19006E2D1300000000000000000000000000000000000000000000000000963D
      0700B2490300CF762D00F2B67E00FAD5B100FAE5D000FAE5D000F6D9BD00EEC7
      A100EAB88800E5AB7500E1A16800DA904D00D4762700CA5B0A00913908005423
      19006E2D1300000000000000000000000000000000000000000000000000963D
      0700B2490300CF762D00F2B67E00FAD5B100FAE5D000FAE5D000F6D9BD00EEC7
      A100EAB88800E5AB7500E1A16800DA904D00D4762700CA5B0A00913908005423
      19006E2D13000000000000000000000000000000000000000000000000000000
      0000963D0700AF460200BA591300D7874200EBAF7500F2C49500F4CCA600F3CC
      A700F0C59A00EAB58100E29D5C00D17B3100AF5313007F3510005C2516006E2D
      1300000000000000000000000000000000000000000000000000000000000000
      0000963D0700AF460200BA591300D7874200EBAF7500F2C49500F4CCA600F3CC
      A700F0C59A00EAB58100E29D5C00D17B3100AF5313007F3510005C2516006E2D
      1300000000000000000000000000000000000000000000000000000000000000
      0000963D0700AF460200BA591300D7874200EBAF7500F2C49500F4CCA600F3CC
      A700F0C59A00EAB58100E29D5C00D17B3100AF5313007F3510005C2516006E2D
      1300000000000000000000000000000000000000000000000000000000000000
      0000963D0700AF460200BA591300D7874200EBAF7500F2C49500F4CCA600F3CC
      A700F0C59A00EAB58100E29D5C00D17B3100AF5313007F3510005C2516006E2D
      1300000000000000000000000000000000000000000000000000000000000000
      00000000000000000000963D0700A9440400AD521100BA662400C5763700C97D
      3E00C4773900BA682C00A1511C00843B14006E2D13006E2D1300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000963D0700A9440400AD521100BA662400C5763700C97D
      3E00C4773900BA682C00A1511C00843B14006E2D13006E2D1300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000963D0700A9440400AD521100BA662400C5763700C97D
      3E00C4773900BA682C00A1511C00843B14006E2D13006E2D1300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000963D0700A9440400AD521100BA662400C5763700C97D
      3E00C4773900BA682C00A1511C00843B14006E2D13006E2D1300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000963D0700963D0700963D07009139
      080088350A00963D0700963D0700963D07000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000963D0700963D0700963D07009139
      080088350A00963D0700963D0700963D07000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000963D0700963D0700963D07009139
      080088350A00963D0700963D0700963D07000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000963D0700963D0700963D07009139
      080088350A00963D0700963D0700963D07000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006533330065333300653333006533
      3300653333006533330065333300653333000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004C814C00416F4100266928001F62
      20001F581F0026692800416F41004C814C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000065333300653333007B3E2900984D1B00AA551200B158
      0E00B1580E00AB5711009A4E19007E4027006633330065333300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000416F41001F622000346F3400579C580078BF79008CCF
      8E008FD090007EC27F0059A059002D702D0011501100416F4100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B3E29006C372F0086432300B65C0C00D1690000D46B0000D36A0000D16A
      0000D1690000D36A0000D46B0000D1690000BB5F0B008D462000683431006834
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000076624C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000076624C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000001F501F002F672F0058A05A008CE08F0084EE920084EE920084EE
      920084EE920084EE920084EE920084EE92005EAC5F001F622000094909000000
      0000000000000000000000000000000000000000000000000000000000007B3E
      29007B3E2900A8561300D56C0000D36A0000CB660100CA650100C9640000CB66
      0100CB660100CB660100CB660100CB660000D16A0000D86C0000AC5711006C37
      2F00683431000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000785F4800755D4700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000755D4700785F48000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000235323003A783C0060AF63007ACE7D007BD17D0076CF780075CE770075CE
      770074CE760074CC760075CE77007BD37F0084DA87006DC070002D782E00064A
      06000000000000000000000000000000000000000000000000007B3E29008342
      2400AE571000D66C0000CD680000C9630000CE6E1200D5873600CF731B00C960
      0000CB660000CB660100CB660100CB660100CB660100CC670000D86C0000AE57
      10006D3730006834310000000000000000000000000000000000000000000000
      000000000000000000000000000084634600C58C5B007E5C4200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007E5C4200C58C5B008463460000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002655
      260036743800519F540067BB6A006EC7720074D077006EC772006EC772006EC7
      72007AD97E0079D77D0076D3790073CE76006FC772006DC470005BAB5D00246F
      26000449040000000000000000000000000000000000000000008A462100AF59
      0E00D46B0000CC660000CB660100C95E0000D0732200F2D6BA00EFD2B300D076
      2400C9600000CA650100CB660100CB660100CB660100CB660100CA650100D86C
      0000AC5711006734320000000000000000000000000000000000000000000000
      0000000000000000000092684800CF8F5B00D1905C008F654600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008F654600D0905C00CE8F5B0092684800000000000000
      0000000000000000000000000000000000000000000000000000416F41003065
      3100418F440059AD5C006AC46D0075D37800479E4800094C0900094C0900094C
      0900135A13007FE082007BDC7F0078D77B0073CF76006AC56D005FB563004898
      4B0010591100416F41000000000000000000000000007B3E2900A2511500D169
      0000CC670000CB660100CB660100C9600000CE6F1900EFD1B100FFFFFF00F4DE
      C800D4823700C95E0000CA630000CB660100CB660100CB660100CB660100CB66
      0100D66B00008D46200067343200000000000000000000000000000000000000
      000000000000986B4900D3905C00DD955E00E0965F00B67D5300B47A5100AF78
      5000AB754F00A7744E00A5734D00A4724D00A3704C009E6E4B00976948008B63
      44007E5B41007057410000000000000000000000000000000000705741007E5B
      41008B634400976948009E6E4B00A3704C00A4724D00A5734D00A7744E00AB75
      4F00AF785000B47A5100B67D5300E0965F00DD955E00D3905C00986B49000000
      00000000000000000000000000000000000000000000000000002C5B2D003477
      3600499C4D0063BD670073D37700479E4800094C0900135A1300479E480086EB
      8A0086EB890083E9880080E584007DE0800076D77A0070CF740065BF680051A5
      540029762C00054C0500000000000000000000000000994D1900BE600800D26A
      0200CD6A0700CE6B0800CE6E0B00CC670200D1741B00EFD1B100FFFFFF00FFFF
      FF00F6E5D300D98D4800CA610600CA630000CB660100CB660100CB660100CB66
      0100D2690000BA5E090067343200000000000000000000000000000000000000
      000095684700D08E5A00DE955E00E79A6200ED9D6300EE9D6300EB9D6300E99A
      6200E6996000E3986000E3975F00E2975F00E1965E00DD955D00D7915C00CC8B
      5900BF845500795940000000000000000000000000000000000079594000BF84
      5500CC8B5900D7915C00DD955D00E1965E00E2975F00E2975F00E3985F00E699
      6000E99A6200EB9C6300EE9D6300ED9D6300E79A6200DE955E00D08E5A009568
      470000000000000000000000000000000000000000004C814C0031673200337F
      360055AC59006DCC720077DC7D0037753A000A4E0A00479E480089F38E0089F4
      8F0089F38F0088F08C0084ED89007FE684007ADE7F0074D778006BCB6F0059B2
      5D0039893D000F580F00416F410000000000AF590E00A7541400CF6E0900D272
      1000D2761500D3771900D4791B00D2721000D57E2600F2D4B500FFFFFF00FFFF
      FF00FFFFFF00FDF8F100E3AB7400CD691000C9600000CB660000CB660100CB66
      0100CB660100D36A00007F3F270065333300000000000000000000000000875F
      4100C6875600D8905B00E5985F00EE9D6300F29F6400F39F6400F29F6400F09E
      6300EE9D6300ED9C6200EB9C6200EB9A6200E99A6000E5985F00DE955D00D48F
      5A00C5865600815B400000000000000000000000000000000000815B4000C586
      5600D48E5A00DE955D00E5985F00E99A6000EB9A6200EB9C6200ED9C6200EE9D
      6300F09E6300F29F6400F39F6400F29F6400EE9D6300E5985F00D8905B00C687
      5600875F410000000000000000000000000000000000416F41002D6A2E003687
      3B005EBC640072D5760079E07F000A4E0A000A4E0A0073DC78008BFA91008CFB
      92008CFA92008AF7900087F38C006AD06E002E822F006FD475006ED0730060BF
      66004092430018651B002669280000000000AF590E00B75F1300D87A1700D57C
      2000D77F2400D8812800D9832A00D77C2000DA883400F2D6BA00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00EAC09700CF711B00C85D0000CA630000CB66
      0100CB660100D46B00009A4F1A0065333300000000000000000074553D00B57D
      5000C9875600D9905B00E6975F00EE9D6300F29F6500F3A16700F2A06700F09F
      6600EF9F6600EE9E6600ED9E6500ED9D6500EA9C6400E6996000DE935D00D48E
      5900C5845500835C400000000000000000000000000000000000835C4000C484
      5500D48E5900DE935D00E6986000EA9C6400ED9D6500ED9E6500EE9E6600EF9F
      6600F09F6600F2A06700F3A16700F29F6500EE9D6300E6975F00D9905B00C987
      5600B57D500074553D0000000000000000000000000026692800286A2A003D90
      410064C56A0064C6680067CB6B000A4E0A000A4E0A0062C9660076E17B0083F2
      8A008EFE93008BFC91006CD470000A4E0A000A4E0A002E82300069CE6F0064C5
      6A00469D4B001F6C22001F62200000000000AF590E00C26B1800DE852900DC86
      3000DC873200DD8A3600DE8C3900DD872E00DF904000F4D9BF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EECEAD00D27C2F00CA640200CB66
      0100CB660100D36A0000AA55120065333300000000006A544100A3744C00B179
      4E00C5845400D58E5900E1965F00EBA47200F3C09900F6CEAF00F6CEB000F6D1
      B500F6D7BF00F7DCC700F7DECA00F6DCC600F2CCB000E7AF8400DA966400CE8A
      5800BD80520080593E000000000000000000000000000000000080593E00BD80
      5200CE8A5800DA966400E7AF8400F2CCB000F6DCC600F7DECA00F7DCC700F6D7
      BF00F6D1B500F6CEB000F6CEAF00F3C09900EBA47200E1965F00D58E5900C584
      5400B1794E00A3744C006A54410000000000000000001F622000256A28004097
      450065C96C000A4E0A000A4E0A000A4E0A000A4E0A000A4E0A000A4E0A0070DA
      76008CFF950072DE77000A4E0A000A4E0A000A4E0A000A4E0A002A7E2B0065C9
      6B0048A34F0022702600064F060000000000AF590E00CA762300E3964600E199
      4D00E1914200E2934400E3954700E1903D00E3994E00F6DDC300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F6E5D300D4813100CA63
      0000CA650100D2690000B1580E006533330000000000000000008B5D4100A774
      4A00BB7E5000CB885600D8936200E9B58F00F6DDCB00F4D7C100EEC5A600EABB
      9900E7B79500E6B69100E5B48F00E3B28F00E2AF8900DAA37900CF916400C183
      5600B2794E0076533A000000000000000000000000000000000076533A00B279
      4E00C1835600CF916400DAA37900E1AF8900E3B28E00E5B48F00E6B69100E7B7
      9300EABB9900EEC5A600F4D7C100F6DDCB00E9B58F00D8936200CB885600BB7E
      5000A7744A008B5D41000000000000000000000000001F622000266C29003F97
      440064CA6B002E822F000A4E0A000A4E0A000A4E0A000A4E0A0070DE77008BFF
      93008AFF93000A4E0A000A4E0A000A4E0A000A4E0A000A4E0A000A4E0A0048A6
      4D0047A34D0021702500054E050000000000B35A0B00CF7D2F00E9A96600EAAE
      7200E79F5500E79E5300E9A05600E79B4E00E8A35C00F7E0C700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F1D7BC00D47D2D00CA65
      0100CA650100D2690000B1580E00653333000000000000000000000000008B5C
      3F00AC754B00BC7F5100C9895B00D79E7400DDA98100D79D7300D0926500CB8C
      5E00C7895B00C5875900C4865800C2865800C1865800BF835800B8805500AF79
      5000A1724B006C503A00000000000000000000000000000000006C503A00A172
      4B00AF795000B8805500BF835800C1865800C2865800C4865800C5875900C789
      5B00CB8C5E00D0926500D79D7200DDA98100D79E7300C9895B00BC7F5100AC75
      4B008B5C3F000000000000000000000000000000000026692800286F2D003992
      40005EC566006DD975002E822F000A4E0A000A4E0A0069D76F0087FE8F0088FE
      910087FE900084FC8E0081F78A000A4E0A000A4E0A005EC6650069D472005FC5
      6600419D47001E6E22001F62200000000000AF590E00CF7E2F00EDB37900F0C3
      9500ECAE6D00ECA76000EDAA6400ECA55C00ECAB6800F9E2CB00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7BA8C00CD6F1800C9600000CB66
      0000CB660100D36A0000AA551200653333000000000000000000000000000000
      00008E5D4000A9734B00B57B5200BF875C00C2895F00A3725000A9704D00A56D
      4A00A06A48009D6846009C6745009A6645009966450097654600936446008E62
      4600896048009068500000000000000000000000000000000000906850008960
      48008E6246009364460097654600996645009A6645009C6745009D684600A06A
      4800A56D4A00A9704D00A3725000C2895F00BF875C00B57B5200A9734B008E5D
      40000000000000000000000000000000000000000000416F41002E723200328C
      3A0056BC5E0069D5700070E179002E822F0065D36C007FF6880081FA8B0082FC
      8C0082FB8B0080F789007DF386000A4E0A000A4E0A005AC4620066D16D0058BF
      600038954100196A1C002669280000000000AF590E00CB762500EFB67D00F5D3
      B000F3C29000F1B16F00F2B37300F1AE6A00F1B37400FAE5CF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FDF6F100E8B58200CD690900C95E0000CB660000CB66
      0100CB660100D46B0000984D1C00653333000000000000000000000000000000
      000000000000885B4000A0704B00AA785300AC7A55007F5B4200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007E5B4200AC7A5500AA785300A0704B00885B40000000
      000000000000000000000000000000000000000000004C814C00357038002C86
      34004AB0530060CE6A006BDC750070E37A0075EB800078F083007BF486007DF6
      87007BF4870079F28400479E48000A4E0A0037753A0060CC69005FCB68004DB4
      5700308C3800115F1300416F410000000000AF590E00C4691400ECAE7000F7D8
      B900FADBBB00F6C18D00F7BD8100F6B87900F5BA7F00FBE7D300FFFFFF00FFFF
      FF00FFFFFF00FAEBDC00E5A96E00D2711100CC660000CC670000CB660100CB66
      0100CC660000D16900007C3F2800653333000000000000000000000000000000
      00000000000000000000845E4700997455009D775900755A4700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000755A46009D77580099745500845E4700000000000000
      0000000000000000000000000000000000000000000000000000366936002D80
      35003A9F440053C05D0063D36D006ADD74006EE3790072E97B0074ED7F0075ED
      800074ED7F00479E4800135A13000A4E0A00479E480060D06A0055C05F0040A5
      4900237D2A0009540A00000000000000000000000000C2620600DF954C00F8D1
      AA00FBEAD700FADBBB00FCCC9800FBC38800F7C08700FBE7D300FFFFFF00FFFF
      FF00F6DEC500E39D5400D77C1F00D3741500CE6D0B00CB670200CB660100CB66
      0100D36A0000B85D0A0065333300000000000000000000000000000000000000
      0000000000000000000000000000845E47009D775900755D4700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000755A46009D775800845E470000000000000000000000
      00000000000000000000000000000000000000000000000000004C814C003775
      3A002F923A0043AF4F0057C6620062D46C0067DC72006AE075006CE37700135A
      1300094C0900094C0900094C0900479E48005FD16A0057C6620048B453003196
      3C0014641600416F4100000000000000000000000000AB571100CB741F00F3C0
      8B00FCE5CD00FDEFE000FEDFBE00FCCA9300F7C18800FBEBDB00FFFFFF00F6DD
      C300E59E5400DC852C00D9812700D4791B00CE6D0B00CB670200CB660100CC66
      0000D66B00008744230065333300000000000000000000000000000000000000
      000000000000000000000000000000000000845E4700845E4700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000755A4600845E47000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003567
      350034813A00359D41004AB8560058CA65005DD1690062D76D0064D96F0064DA
      70006EC772006EC772006EC772005CD0680058CA65004FBD5B0038A344002078
      26000A520A000000000000000000000000000000000000000000C3620500DA8D
      4200FAD2A800FDEDDD00FEF2E600FBDDBE00F8CA9D00FAE5CF00F6D6B500E8A1
      5800E18F3C00DD8A3500D8812800D3771900CE6C0900CB670200CC670000D86C
      0000A45214006734320000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000845E4700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000845E4700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000366B360034863B0038A5460056C6640065D772005FD46D005CD36A005CD1
      69005BD169005CD169005ED36C0066D8730060CF6D0040AC4D00237E2A000F57
      0F00000000000000000000000000000000000000000000000000AB571100C464
      0800DD944C00F9D3AC00FCEBD900FEF2E600FAE5CF00F6D4B000F0B98300E8A4
      5D00E2994C00DE8F3E00DA893600D7842F00D27C2400D1721100D86C0000A652
      14006A3531008845250000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000032663200357D3900369D42005ACB690084EE920084EE920084EE
      920084EE920084EE920084EE920069D87800379F43001F7023000F550F000000
      000000000000000000000000000000000000000000000000000000000000AB57
      1100C3640800DA8F4600F5C69600FBDFC200FBEBDB00FBEBDB00F8E2CC00F2D4
      B500EFC89F00EBBD8E00E8B58200E3A66800DE8F3E00D6761600A75313006F39
      2D00884525000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004C814C002F6B3000338139003B9C46004DB25A005DC2
      6C005FC46E0050B55D003A9C4400277A2D00185E1800416F4100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000AB571100C0610600C9742400E09E5D00F0C08E00F5D1AA00F7D8B900F6D8
      BA00F4D2AF00EFC59900E9B17700DC944A00C06E2400974E2000773C29008845
      2500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004C814C00416F4100266928001F62
      20001F62200026692800416F41004C814C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000AB571100BB5F0B00BF6D2200C9803B00D28F5100D595
      5800D1905300C9824400B56C31009C5526008845250088452500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AB571100AB571100AB571100A753
      13009F4F1600AB571100AB571100AB5711000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BA5B18008B3511008B35
      11008B3511008B3511008B3511008B3511008B3511008B3511008B3511008B35
      11008B3511008B3511008B3511008B3511008B3511008B3511008B3511008B35
      11008B3511008B3511008B351100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006A7279005E666E005E666E005E666E005E666E005E666E005E66
      6E005E666E005E666E005E666E005E666E005E666E005E666E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006A7279005E666E005E666E005E666E005E666E005E666E005E66
      6E005E666E005E666E005E666E005E666E005E666E005E666E00000000000000
      00000000000000000000000000000000000000000000BA5B1800FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FBFBFA00F7F7F600F4F4F300F2F2
      F000EFEFEE00EBEBEA00E9E9E700E6E6E500E3E3E200E1E1E000D9D9D900D3D3
      D300CBCBCB00C5C5C5008B351100000000008E5D59008E5D59008E5D59008E5D
      59008E5D59008E5D59008E5D59008E5D59008E5D59008E5D59008E5D59008E5D
      59008E5D59008E5D590073424100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006A727900818E9D008F99A6008F99A6008F99A6008F99
      A6008F99A6008F99A6008F99A600818E9D005E666E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006A727900818E9D008F99A6008F99A6008F99A6008F99
      A6008F99A6008F99A6008F99A600818E9D005E666E0000000000000000000000
      00000000000000000000000000000000000000000000BA5B1800FEFEFC00C254
      00008B3511008B3511008B3511008B3511008B3511008B3511008B3511008B35
      11008B3511008B3511008B3511008B351100E6E6E500E3E3E200E1E1E000D9D9
      D900D3D3D300CBCBCB008B351100000000008E5D5900E6D4C400F7EBD700F3E5
      CF00F2E3CE00F2E2CA00F0E1C700F0E1C600F0E1C600F0E1C700F0E1C700F0E1
      C700F3E6CB00E7D5BD0073424100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005E666E005E666E005E666E005E666E005E66
      6E005E666E005E666E005E666E005E666E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000005E666E005E666E005E666E005E666E005E66
      6E005E666E005E666E005E666E005E666E000000000000000000000000000000
      00000000000000000000000000000000000000000000BA5B1800FEFEFC00C254
      0000FEFEFC00FEFEFC00FEFEFC00FEFEFC00FBFBFA00F7F7F600F2F2F000EDED
      EB00E7E7E600E2E2E100D7D7D7008B351100E6E6E500E6E6E500E3E3E200E1E1
      E000D9D9D900D3D3D3008B351100000000008E5D5900E3D0C200F4E7D500EFE0
      CE00EEE0CC00EEDECA00EDDCC700EBDAC400EBDAC400EBD9C200EBDAC200EBD9
      C200EEDEC500E3CFB80073424100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900494949004949490000000000000000000000000000000000494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      49004949490049494900000000000000000000000000BA5B1800FEFEFC00C254
      0000FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FBFBFA00F7F7F600F2F2
      F000EDEDEB00E7E7E600E2E2E1008B351100E6E6E500E9E9E700E6E6E500E3E3
      E200E1E1E000D9D9D9008B351100000000008E5D5900E5D1C600F4EADA00EFE3
      D400EFE2D100EEE1CF00EEDECC00EDDDCA00EBDCC600EADAC400EADAC400EBD9
      C200EEDDC500E3CFB80073424100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000075818F00AFD1DE00ADD1
      DD00ACD0DD00ABCFDC00AACFDC00A9CEDA00A7CCDA00A6CCDA00A4CBD900A3CA
      D900A1CAD800A0C9D8009FC7D7009EC7D7009EC7D70032FF320000AF000092C1
      D1008ABCCE0083B7CB0049494900000000000000000075818F00AFD1DE00ADD1
      DD00ACD0DD00ABCFDC00AACFDC00A9CEDA00A7CCDA00A6CCDA00A4CBD900A3CA
      D900A1CAD800A0C9D8009FC7D7009EC7D7009EC7D70032FF320000AF000092C1
      D1008ABCCE0083B7CB00494949000000000000000000BA5B1800FEFEFC00C254
      0000FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FBFBFA00F7F7
      F600F2F2F000EDEDEB00E7E7E6008B351100E6E6E500EBEBEA00E9E9E700E6E6
      E500E3E3E200E1E1E0008B35110000000000A0675B00E6D4CB00F7EEE100F7D4
      B100F2B87F00F2BA8100F2B88000F2BA8000F2B88000F0B87F00F2B77B00F2CF
      AB00EDE0C700E3CFB80073424100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000075818F00B0D3DE00AFD1
      DE00B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4
      E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4
      E000B4D4E0008ABCCE0049494900000000000000000075818F00B0D3DE00AFD1
      DE00B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4
      E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4
      E000B4D4E0008ABCCE00494949000000000000000000BA5B1800FEFEFC00C254
      0000FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC0073B6
      58000073000058AB4800ABCA8F008B351100EFEFEE00EFEFEE00EBEBEA00E9E9
      E700E6E6E500E3E3E2008B35110000000000A0675B00E6D8CF00F7EFE500F6DC
      C100F8D1AF00F7D3B000F7D1AF00F6D1AC00F6D1AB00F4D0AA00F4CEA500EFD3
      B400EDDDC600E2CEB70073424100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000076828F00B2D4E00083B7
      CB009D5857008A3C3C008A3C3C008A3C3C008A3C3C008A3C3C008A3C3C008A3C
      3C008A3C3C008A3C3C008A3C3C008A3C3C008A3C3C008A3C3C008A3C3C008A3C
      3C00B4D4E00092C1D10049494900000000000000000076828F00B2D4E00083B7
      CB009D5857008A3C3C008A3C3C008A3C3C008A3C3C008A3C3C008A3C3C008A3C
      3C008A3C3C008A3C3C008A3C3C008A3C3C008A3C3C008A3C3C008A3C3C008A3C
      3C00B4D4E00092C1D100494949000000000000000000BA5B1800FEFEFC00C254
      0000FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC001C902F00007300001C981600C2540000F6F6F400F3F3F200EFEFEE00EBEB
      EA00E9E9E700E6E6E5008B35110000000000A0675B00E9DAD100F8F2E900F3E9
      D900F2E2D100F2E2D000F0E0CE00F2E0CC00F2DECA00EFDCC600EAD7C000E5D4
      BD00E7D9C400DECCB7007F4F4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000075818F00B4D4E00083B7
      CB00B2787700A15E5D00A15E5D00A15E5D00FEFEFC00FEFEFC00F8F8F700F2F2
      F000EDEDEB00E6E6E500E1E1E000E1E1E000934A4900914646008F4343008A3C
      3C00B4D4E0009AC5D50049494900000000000000000075818F00B4D4E00083B7
      CB00B2787700A15E5D00FEFEFC00FEFEFC00FEFEFC00FEFEFC00F8F8F700F4F4
      F300EFEFEE00EAEAE900E5E5E300E1E1E000D4D4D400C5C5C5008F4343008A3C
      3C00B4D4E0009AC5D500494949000000000000000000BA5B1800FEFEFC00C254
      0000FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00ABCA8F001C902F00007300001C981600F6F6F400F6F6F400F3F3F200F0F0
      EF00EEEEED00EAEAE9008B35110000000000A7756B00EBDED700FAF4EE00F7D1
      AC00EFB17300EDB17500EFB47600F2B47600F2B47600EDB07400E0A56B00D1B2
      9300CCC2B400CFBDAC007A4D4800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000075818F00B4D4E00083B7
      CB00B2787700A5646300A5646300A5646300FEFEFC00FEFEFC00FEFEFC00F8F8
      F700F2F2F000EDEDEB00E6E6E500E1E1E000964D4D00934A4900904544008A3C
      3C00B4D4E0009CC5D50049494900000000000000000075818F00B4D4E00083B7
      CB00B2787700A5646300FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00F8F8
      F700F4F4F300EFEFEE00EAEAE900E5E5E300E1E1E000D4D4D400904544008A3C
      3C00B4D4E0009CC5D500494949000000000000000000BA5B1800FEFEFC00C254
      0000FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00ABCA8F001C902F00008400001C981600ABCA8F00F6F6F400F3F3
      F200F0F0EF00EEEEED008B35110000000000A7756B00EEE1D900FAF4EE00EDE1
      D300E1D0C000D8C9B800DECEBD00EAD8C400E9D7C100DAC6B400BCAB9900A195
      88009F968A00ADA0920070464100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000075818F00B4D4E00083B7
      CB00B2787700A96A6800A96A6800A96A6800FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00F8F8F700F2F2F000EDEDEB00E6E6E50098515000964D4D00924848008A3C
      3C00B4D4E0009DC6D50049494900000000000000000075818F00B4D4E00083B7
      CB00B2787700A96A6800FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00F8F8F700F4F4F300EFEFEE00EAEAE900E5E5E300E1E1E000924848008A3C
      3C00B4D4E0009DC6D500494949000000000000000000BA5B1800FEFEFC00C254
      0000FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00ABCA8F001C902F00008400000073000058AB4800F6F6
      F40000730000F0F0EF008B35110000000000BC826800EEE3DC00F7F6F000E2D3
      C400C2B09D00B1A08F00BBAA9800D0BCA500D1BCA600B7A49000958373007B70
      66007A746C008980760069454100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000075818F00B4D4E00083B7
      CB00B2787700AB6D6C00AC6F6D00AC6F6D00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00F8F8F700F2F2F000EDEDEB009A545300974F4E00934A49008A3C
      3C00B4D4E0009EC7D70049494900000000000000000075818F00B4D4E00083B7
      CB00B2787700AB6D6C00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00F8F8F700F4F4F300EFEFEE00EAEAE900E5E5E300934A49008A3C
      3C00B4D4E0009EC7D700494949000000000000000000BA5B1800FEFEFC00C254
      0000C2540000C2540000C2540000C2540000C2540000C2540000C2540000C254
      0000C2540000C2540000C2540000C25400001C902F001C902F00008400000073
      000000730000F3F3F2008B35110000000000BC826800F2E7E200F6F7F6005974
      A400AF815400926D4800956F4A00A57B5200A67D52008F6B46003B5781003246
      74003E3D54006F69620051353300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000075818F00B4D4E00083B7
      CB00B2787700AF737200B0757300B0757300FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00F8F8F700F2F2F0009C56550098515000954C4B008A3C
      3C00B4D4E000A0C9D80049494900000000000000000075818F00B4D4E00083B7
      CB00B2787700AF737200FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00F8F8F700F4F4F300EFEFEE00EAEAE900954C4B008A3C
      3C00B4D4E000A0C9D800494949000000000000000000BA5B1800FEFEFC00C048
      0000E77F1E00E77F1E00E77F1E00E77F1E00E77F1E00F3BB8200E77F1E00F3BB
      8200E77F1E001C52F70065596E00CF600500FEFEFC00008400001C902F001C90
      2F0000730000F6F6F4008B35110000000000D1926D00F4EBE600FAFAFA00648B
      BC005974A4008782880086807D00827D7800797573003B5781005EA4CE0058AA
      DA001F255000413F4D00412B2900000000000000000000000000000000000000
      0000413D3D002D2A2A002D2A2A002D2A2A000000000078849200B4D4E00083B7
      CB00B2787700B2787700B47A7800B47A7800FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00F8F8F7009D58570099525200964D4D008A3C
      3C00B4D4E000A1C9D80049494900000000000000000078849200B4D4E00083B7
      CB00B2787700B2787700FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00F8F8F700F4F4F300EFEFEE00964D4D008A3C
      3C00B4D4E000A1C9D800494949000000000000000000BA5B1800FEFEFC00FEFE
      FC00CF600500CF600500CF600500CF600500CF600500CF600500CF600500CF60
      0500CF600500CF600500CF600500FEFEFC00FEFEFC00008400002CAB49002CAB
      490000730000FAFAF8008B35110000000000D1926D00F6EEEA00FCFCFC004452
      8100BCEAF3008298B500828089007D7A79003B5781006FC5E5003B57810059A1
      D300478AC2001E214B00372A38000000000000000000767677003A3A3A003A3A
      3A00413D3D00242325001F1F2100413B3B000000000078849300B4D4E00083B7
      CB00B2787700B57D7A00B7807E00B7807E00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00FEFEFC009E5958009A545300974F4E008A3C
      3C00B4D4E000A3CAD80049494900000000000000000078849300B4D4E00083B7
      CB00B2787700B57D7A00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00F8F8F700F4F4F300974F4E008A3C
      3C00B4D4E000A3CAD800494949000000000000000000BA5B1800FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00FEFEFC000084000000840000008400000084
      000000840000FEFEFC008B35110000000000DA9D7500F7EFEA00FEFEFE009F9F
      B500555E8200BCEAF30088B0C9003B57810077D4EE003B5781006CCEF4003B57
      81005097D0003B73B0001B1C45001B1C45001B1C450076767700ACACAD00ACAC
      AD00413D3D0038343500413B3B00413B3B000000000077839100B4D4E00083B7
      CB00B2787700B7807E00BA848200C6989600FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00FEFEFC009E5958009A545300974F4E008A3C
      3C00B4D4E000A4CBD90049494900000000000000000077839100B4D4E00083B7
      CB00B2787700B7807E00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00C5C5C500C5C5C500D4D4D400974F4E008A3C
      3C00B4D4E000A4CBD900494949000000000000000000BA5B1800FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC008B35110000000000DA9D7500F8EFEA00FFFFFF00FEFE
      FE00A3A3B80058698B00A5E6F2005778A3003B5781006FCBEB003B57810060BF
      EF003B5781004BA1E6004193E1003686DD002D77D80076767700A7A7A700A7A7
      A700413D3D00413D3D0044404000444040000000000076828F00B4D4E00083B7
      CB00B2787700B7807E00C6989600C6989600FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00C5C5C500C5C5C5009E5958009A545300974F4E008A3C
      3C00B4D4E000A5CBD90049494900000000000000000076828F00B4D4E00083B7
      CB00B2787700B7807E00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00C5C5C500D4D4D4009A545300974F4E008A3C
      3C00B4D4E000A5CBD900494949000000000000000000BA5B1800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008B35110000000000E7AB7900FAF2ED00FFFFFF00FFFF
      FF00FEFEFE00A6A6BB0050678A008FE2F0004C6F9F003B57810067C0E9003B57
      810055B0EB004BA1E6004193E1003686DD002D77D80076767700B7B8B800B7B8
      B800413D3D00504C4C00504C4C00504C4C000000000076828F00B4D4E00083B7
      CB00B2787700B7807E00BA848200C6989600FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00C5C5C500A15E5D009E5958009A545300974F4E008A3C
      3C00B4D4E000A6CCDA0049494900000000000000000076828F00B4D4E00083B7
      CB00B2787700B7807E00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00D4D4D4009E5958009A545300974F4E008A3C
      3C00B4D4E000A6CCDA00494949000000000000000000BA5B18008B3511008B35
      11008B3511008B3511008B3511008B3511008B3511008B3511008B3511008B35
      11008B3511008B3511008B3511008B3511008B3511008B3511008B3511008B35
      11008B3511008B3511008B35110000000000E7AB7900FAF3EE00FFFFFF00FFFF
      FF00FFFFFF00FEFEFE00A9A9BC0049668A007BD9ED004A6C9C0067C0E90060BF
      EF0055B0EB004BA1E6004193E1003686DD002D77D80076767700EDEDED00EAEA
      EA00413D3D005B5959005B5959005B5959000000000075818F00B4D4E00083B7
      CB00B2787700B2787700B2787700B2787700B2787700B2787700B2787700B278
      7700B2787700B2787700B2787700B2787700B2787700B2787700B2787700934A
      4900B4D4E000A9CEDA0049494900000000000000000075818F00B4D4E00083B7
      CB00B2787700B2787700B2787700B2787700B2787700B2787700B2787700B278
      7700B2787700B2787700B2787700B2787700B2787700B2787700B2787700934A
      4900B4D4E000A9CEDA00494949000000000000000000BA5B1800C2540000C254
      0000C2540000C2540000C2540000C2540000C2540000C2540000C2540000C254
      0000C2540000C2540000C2540000C2540000C2540000C2540000C2540000C254
      0000C2540000CF6005008B35110000000000E7AB7900D1926D00D1926D00D192
      6D00D1926D00D1926D00D0916C008F6A640043648900B4E5F3006CCEF40060BF
      EF0055B0EB004BA1E6004193E1003686DD002D77D80076767700EDEDED00EDED
      ED00413D3D006766660067666600676666000000000075818F00B4D4E00083B7
      CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7
      CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7
      CB00ABCFDC00AACFDC0049494900000000000000000075818F00B4D4E00083B7
      CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7
      CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7CB0083B7
      CB00ABCFDC00AACFDC00494949000000000000000000C0480000E77F1E00E77F
      1E00E77F1E00E77F1E00E77F1E00E77F1E00E77F1E00E77F1E00E77F1E00E77F
      1E00E77F1E00E77F1E00E77F1E00E77F1E00F3BB8200E77F1E00F3BB8200E77F
      1E001C52F70065596E00CF600500000000000000000000000000000000000000
      000000000000000000000000000000000000000000003B578100B2E6FA00ABDE
      F70055B0EB004BA1E6004193E1003686DD002442830076767700EDEDED00EDED
      ED00413D3D007272720072727200727272000000000075818F00B4D4E000B4D4
      E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4
      E000B4D4E000B4D4E000B4D4E000B4D4E000B2D4E000B0D3DE00AFD1DE00ADD1
      DD00ACD0DD00ABCFDC0049494900000000000000000075818F00B4D4E000B4D4
      E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4E000B4D4
      E000B4D4E000B4D4E000B4D4E000B4D4E000B2D4E000B0D3DE00AFD1DE00ADD1
      DD00ACD0DD00ABCFDC0049494900000000000000000000000000CF600500CF60
      0500CF600500CF600500CF600500CF600500CF600500CF600500CF600500CF60
      0500CF600500CF600500CF600500CF600500CF600500CF600500CF600500CF60
      0500CF600500CF60050000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004F7E
      AF004C82BA00467DBA004074B7003B528E000000000076767700767677007676
      7700413D3D00737373006262620062626200000000000000000075818F007581
      8F0075818F0075818F0075818F0075818F0075818F0075818F0075818F007581
      8F0075818F0075818F0075818F0075818F0075818F0075818F0075818F007581
      8F0075818F0075818F000000000000000000000000000000000075818F007581
      8F0075818F0075818F0075818F0075818F0075818F0075818F0075818F007581
      8F0075818F0075818F0075818F0075818F0075818F0075818F0075818F007581
      8F0075818F0075818F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000413D3D00413D3D00413D3D00413D3D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009A9A9A0082868700828687008286
      8700828687008286870082868700828687008286870082868700828687008286
      8700828687008286870082868700000000000000000000000000000000000000
      00000000000000000000000000009A9A9A008286870082868700828687008286
      8700828687008286870082868700828687008286870082868700828687008286
      8700828687008286870000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CAA5A400CAA5A400CAA5A4000000
      00000000000000000000000000000A68AF000A68AF00034B8A00022543000000
      0000000000000000000000000000000000000000000000000000485058004850
      5800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009A9A9A00FBFBFB00F0F0F000EEEE
      EE00EBEBEB00E9E9E900E6E6E600E3E3E300E1E1E100DCDCDC00D5D5D500D0D0
      D000CACACA00C5C5C500828688000000000000000000000000000364BA000353
      9C0003539C0003539C0003539C009A9A9A00FEFEFC00FCFCFB00FAFAF800F6F6
      F400F2F2F000EEEEED00EBEBEA00E7E7E600E3E3E200E1E1E000D7D7D700CECE
      CE00C5C5C5008286880000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CAA5A400CAA5A400AC8B8A000000
      00000000000000000000000000000F81C9000A68AF00034B8A00022543000000
      0000000000000000000000000000000000000000000023588F001158A1000D40
      7600485058000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009A9A9A00FBFBFB00F3F3F300F0F0
      F000EEEEEE00EBEBEB00E9E9E900E6E6E600E3E3E300E1E1E100DCDCDC00D5D5
      D500D0D0D000CACACA00828688000000000000000000000000000364BB000C75
      BC000C74BB000C70B8000C6FB7009A9A9A00FEFEFC00FEFEFC00FCFCFB00FAFA
      F800F6F6F400F2F2F000EEEEED00EBEBEA00E7E7E600E3E3E200E1E1E000D7D7
      D700CECECE008286880000000000000000000000000000000000BA5B18008B35
      11008B3511008B3511008B35110086341100AC8B8A00CAA5A400926562005521
      0B007E3010008B351100863411000F81C9000A68AF00034B8A00022543005521
      0B007E3010008B351100000000000000000023588F00238FFF001173EA001158
      A1000D4076004850580000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009A9A9A00FBFBFB00F6F6F600F3F3
      F300F0F0F000EEEEEE00EBEBEB00E9E9E900E6E6E600E3E3E300E1E1E100DCDC
      DC00D5D5D500D0D0D000828688000000000000000000000000000365BC000D78
      C0000D76BD000C75BC000C74BB009A9A9A00FEFEFC00FEFEFC00FEFEFC00FCFC
      FB00FAFAF800F6F6F400F2F2F000EEEEED00EBEBEA00E7E7E600E3E3E200E1E1
      E000D7D7D7008286880000000000000000000000000000000000BA5B1800EFEF
      EF00EDEDED00EBEBEB00EAEAEA00E0E0E000AC8B8A00CAA5A400926562008A8A
      8A00CBCBCB00E0E0E000D3D3D3000F81C9000A68AF00034B8A00022543007D7D
      7D00B7B7B7008B351100000000000000000031A1FF0040ABFF002A8FFF001173
      EA001158A1000D40760048505800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009A9A9A00FBFBFB00D1D1D100BABA
      BA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00BABA
      BA00DCDCDC00D5D5D500828688000000000000000000000000000366BD000D7B
      C2000D79C1000D77BF000D76BD009A9A9A00FEFEFC00D1D1D100BABABA00BABA
      BA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00E3E3
      E200E1E1E0008286880000000000000000000000000000000000BA5B1800F0F0
      F000EFEFEF00EDEDED00EBEBEB00E1E1E100AC8B8A00CAA5A400926562008B8B
      8B00CCCCCC00E2E2E200D7D7D7000F81C9000A68AF00034B8A00022543007F7F
      7F00B8B8B8008B35110000000000000000001C8FFF0038ABFF0040ABFF002A8F
      FF001173EA001158A1000D407600485058000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009A9A9A00FBFBFB00FEFEFE00FBFB
      FB00F7F7F700F4F4F400F0F0F000EEEEEE00EBEBEB00E9E9E900E6E6E600E3E3
      E300E1E1E100DCDCDC00828688000000000000000000000000000367BF000E7F
      C6000E7DC4000D7BC2000D79C1009A9A9A00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FCFCFB00FAFAF800F6F6F400F2F2F000EEEEED00EBEBEA00E7E7
      E600E3E3E2008286880000000000000000000000000000000000BA5B1800F2F2
      F200F0F0F000EFEFEF00EDEDED00E2E2E200AC8B8A00CAA5A400926562008B8B
      8B00CECECE00E3E3E300D9D9D9000F81C9000A68AF00034B8A00022543008080
      8000BBBBBB008B3511000000000000000000000000001C8FFF0038ABFF0040AB
      FF002A8FFF001173EA001158A1000D4076004850580000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009A9A9A00828687008286
      870082868700828687008286870075797B009A9A9A00FBFBFB00D1D1D100BABA
      BA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00BABA
      BA00E3E3E300E1E1E100828688000000000000000000000000000368C1000F81
      C9000F80C7000E7FC6000E7DC4009A9A9A00FEFEFC00D1D1D100BABABA00BABA
      BA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00EBEB
      EA00E7E7E6008286880000000000000000000000000000000000BA5B1800F3F3
      F300F2F2F200F0F0F000EFEFEF00E3E3E300AC8B8A00CAA5A400926562008C8C
      8C00CFCFCF00E5E5E500DADADA000F81C9000A68AF00034B8A00022543008282
      8200BDBDBD008B351100000000000000000000000000000000001C8FFF0038AB
      FF0040ABFF002A8FFF001173EA001158A1000D40760048505800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009A9A9A00FBFBFB00E3E3
      E300E1E1E100DEDEDE00DCDCDC00CBCBCB009A9A9A00FBFBFB00FFFFFF00FFFF
      FF00FEFEFE00FBFBFB00F7F7F700F4F4F400F2F2F200EFEFEF00EDEDED00EAEA
      EA00E7E7E700E5E5E500828688000000000000000000000000000368C2000F86
      CE000F84CC000F81C9000F80C7009A9A9A00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FBFBFA00F7F7F600F3F3F200F0F0
      EF00EDEDEB008286880000000000000000000000000000000000BA5B1800F4F4
      F400F3F3F300F2F2F200F0F0F000DEDEDE00AC8B8A00CAA5A400926562008787
      8700C6C6C600E3E3E300DCDCDC000F81C9000A68AF00034B8A00022543008484
      8400C1C1C1008B35110000000000000000000000000000000000000000001C8F
      FF0038ABFF0040ABFF002A8FFF001173EA00312A230048505800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009A9A9A00FBFBFB00E5E5
      E500E3E3E300E1E1E100DEDEDE00CBCBCB009A9A9A00FBFBFB00D1D1D100BABA
      BA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00BABA
      BA00EAEAEA00E7E7E700828688000000000000000000000000000369C4001088
      D0001087CF000F86CE000F83CB009A9A9A00FEFEFC00D1D1D100BABABA00BABA
      BA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00F3F3
      F200F0F0EF008286880000000000000000000000000000000000BA5B1800F6F6
      F600F4F4F400F3F3F300EDEDED00C9C9C900AC8B8A00CAA5A400926562007474
      7400A6A6A600D8D8D800DDDDDD000F81C9000A68AF00034B8A00022543008686
      8600C4C4C4008B35110000000000000000000000000000000000000000000000
      00001C8FFF0038ABFF0040ABFF008F84730073737300312A2300000000000000
      0000B6847B00A1736A00C08F8400CAA18F00CA988F00C0848400B67B7B000000
      000000000000000000000000000000000000000000009A9A9A00FBFBFB00E7E7
      E700E5E5E500E3E3E300E1E1E100CBCBCB009A9A9A00FBFBFB00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE00FBFBFB00F7F7F700F4F4F400F2F2F200EFEF
      EF00EDEDED00EAEAEA0082868800000000000000000000000000036AC500118F
      D700118CD4001088D0001087CF009A9A9A00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FBFBFA00F7F7
      F600F3F3F2008286880000000000000000000000000000000000BA5B1800F7F7
      F700F6F6F600F4F4F400EDEDED00007E7B00007E7B00007E7B00007E7B00007E
      7B009D9D9D00D7D7D700DEDEDE000F81C9000A68AF00034B8A00022543008888
      8800C6C6C6008B35110000000000000000000000000000000000000000000000
      0000000000001C8FFF001C8FFF009A9A9A008F847300505050006A5050009873
      6A00E0CAAB00F0E3A900F8E9AC00FCEDB000FFEFB100FFF0B400EAD4B600C08F
      840000000000000000000000000000000000000000009A9A9A00FBFBFB00D1D1
      D100BABABA00BABABA00BABABA00ACACAC009A9A9A00FBFBFB00D1D1D100BABA
      BA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00BABA
      BA00EFEFEF00DEDEDE0082868800000000000000000000000000036BC6001395
      DD001290D900118FD700118AD3009A9A9A00FEFEFC00D1D1D100BABABA00BABA
      BA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00BABABA00FBFB
      FA00F7F7F6008286880000000000000000000000000000000000BA5B1800F8F8
      F800F7F7F700F6F6F600F0F0F00000D4D00028FFFF0000D4D00000AFAF00007E
      7B00AFAFAF00DEDEDE00E0E0E0000F81C9000A68AF00034B8A00022543008989
      8900C9C9C9008B35110000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B2B2B200312A2300C08F7B00EBDD
      A500F7E6AB00FBF2D500FBF2D500FBF2D500FBF2D500FBF2D500FBF2D500FFF0
      B600CAA18F00CA988F000000000000000000000000009A9A9A00FBFBFB00EBEB
      EB00E9E9E900E7E7E700E5E5E500CBCBCB009A9A9A00FBFBFB00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FBFBFB00F7F7F700F4F4
      F400DEDEDE00D1D1D10082868800000000000000000000000000036BC7001398
      E1001397E0001292DA001290D9009A9A9A00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00EDED
      EA00DEDEDE008286880000000000000000000000000000000000BA5B1800FAFA
      FA00F8F8F800F7F7F700EFEFEF00C9C9C90000AFAF0000AFAF00007E7B007373
      73009E9E9E00D0D0D000DDDDDD000F81C9000A68AF00034B8A00022543008A8A
      8A00CACACA0084331100000000004B4C4B000000000000000000000000000000
      000000000000000000000000000000000000B6989800C08F7B00FFEAAB00F6E6
      AA00FBF2D500FFF3B400FFF4B600FFF6B800FFF7B800FFFBBA00FFF8B800FBF2
      D500FFF0B200B68F8F000000000000000000000000009A9A9A00FBFBFB00D1D1
      D100BABABA00BABABA00BABABA00ACACAC009A9A9A00FBFBFB00D1D1D100BABA
      BA00BABABA00BABABA00BABABA00BABABA00D1D1D100FFFFFF00FCFCFC00DEDE
      DE00D1D1D100C1C1C10082868800000000000000000000000000036CC900159F
      E700149AE3001398E1001395DD009A9A9A00FEFEFC00D1D1D100BABABA00BABA
      BA00BABABA00BABABA00BABABA00D1D1D100FEFEFC00FEFEFC00EDEDEA00DEDE
      DE00C5C5C5008286880000000000000000000000000000000000BA5B1800FBFB
      FB00FAFAFA00F8F8F800EFEFEF0000D4D00000AFAF0000D4D00000AFAF00007E
      7B0079797900A3A3A300C2C2C2000F81C9000A68AF00034B8A00022543008383
      8300B6B6B6006D2A0E004B4C4B007E7E7E000000000000000000000000000000
      000000000000000000000000000000000000AB737300EAD4A100EFE0A500FEEB
      AF00FFEEB100FFEFB200F4CA8F00A1400B00FFF4B500FFF6B600FFFAB800FFFA
      B800FBF2D500F4EAD400CA988F0000000000000000009A9A9A00FBFBFB00F0F0
      F000EDEDED00EBEBEB00E9E9E900CBCBCB009A9A9A00FBFBFB00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009A9A9A008286
      8800828688008286880082868800000000000000000000000000036DCA0016A3
      ED0015A0EA00149DE600149AE3009A9A9A00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC009A9A9A00828688008286
      8800828688008286880000000000000000000000000000000000BA5B1800FBFB
      FB00FBFBFB00FAFAFA00EFEFEF0000D4D00028FFFF0000D4D000525555005759
      5A005D5F5D0075757500878787000A68AF00034B8A0002254300022543006D6D
      6D00818181002F312E0068686A007E7E7E000000000000000000000000000000
      000000000000000000000000000000000000CAA18F00E1D39D00F6E3AA00FCEA
      AF00FFEBB000FFEDB000F4CA8F00A1400B00FFF2B400FFF3B500FFF6B600FFF8
      B700FFFAB800FFF3B600AB8F7B0000000000000000009A9A9A00FBFBFB00D1D1
      D100BABABA00BABABA00BABABA00ACACAC009A9A9A00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009A9A9A00FFFF
      FF00FFFFFF00DEDEDE0082868800000000000000000000000000036ECB0017A9
      F30016A5EE0016A3ED00159FE7009A9A9A00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC009A9A9A00FFFFFF00FFFF
      FF00DEDEDE008286880000000000000000000000000000000000BA5B1800FBFB
      FB00FBFBFB00FBFBFB00F0F0F00000D4D00028FFFF00424341008F8F8F005757
      5700474846003D3E3D00414141003D3F3C002D302D002C302F00282B2D00393B
      3B00545553006E6F72008A8B8F00909090000000000000000000000000000000
      0000000000000000000000000000CA988F00E0C09800E6D7A000F8E6AB00FBE7
      AC00F4CA8F00F4CA8F00F4CA8F00A1400B00E0CAB600E0CAB600E0CAB600FFF4
      B600FFF8B800FFF3B800CAB69800CA988F00000000009A9A9A00FBFBFB00F4F4
      F400F2F2F200F0F0F000EDEDED00CBCBCB009A9A9A00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009A9A9A00FFFF
      FF00DEDEDE008386860000000000000000000000000000000000036ECC0018AD
      F70017ABF40016A7F00016A5EE009A9A9A00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC009A9A9A00FFFFFF00DEDE
      DE00838686000000000000000000000000000000000000000000BA5B1800FBFB
      FB00FBFBFB00FBFBFB00F2F2F20000D4D00028FFFF005D5D5D00D3D3D3008F8F
      8F007E7E7E00636363004E4F4E005E5E5D006F706E0077797A00707679007278
      7A008E929300A6ABAF00BABDC200909090000000000000000000000000000000
      0000000000000000000000000000B77F7D00EACAA100E9D8A100EADAA300F8E6
      AB00A1400B00A1400B00A1400B00A1400B00A1400B00A1400B00A1400B00FFF3
      B400FFF6B600FFF2B600E0CAAB00AB847300000000009A9A9A00FBFBFB00D1D1
      D100BABABA00BABABA00BABABA00ACACAC009A9A9A00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009A9A9A00DEDE
      DE00838686000000000000000000000000000000000000000000036FCE0019B4
      FE0018B0FA0018ADF70017A9F3009A9A9A00FEFEFC00FEFEFC00FEFEFC00FEFE
      FC00FEFEFC00FEFEFC00FEFEFC00FEFEFC00FEFEFC009A9A9A00DEDEDE008386
      8600000000000000000000000000000000000000000000000000BA5B1800FBFB
      FB00FBFBFB00FBFBFB00F2F2F20000D4D00028FFFF0087878700D3D3D300CECE
      CE007D7D7D009E9E9E008787870090909000B4B5B400C0C2C500C1CACF00C1CC
      D100CCD1D400CCD0D30087878700000000000000000000000000000000000000
      0000000000000000000000000000B77F7D00EACAA100E6D59F00EADAA300FBEB
      BF00F4CA8F00F4CA8F00F4CA8F00A1400B00F4CA8F00F4CA8F00F4CA8F00FFF0
      B500FFF3B600FCEDB100E0CAAB00AB847300000000009A9A9A00FBFBFB00F8F8
      F800F7F7F700F4F4F400F2F2F200F0F0F0009A9A9A0083838300838383008383
      8300838383008383830083838300838383008383830083838300838383008383
      83000000000000000000000000000000000000000000000000000470CF0019B6
      FF0019B6FF0018B1FB0018B0FA009A9A9A008383830083838300838383008383
      8300838383008383830083838300838383008383830083838300838383000355
      9D00000000000000000000000000000000000000000000000000BA5B18008B35
      11008B3511008B3511008734110000D4D00028FFFF0089898900EAEAEA00E6E6
      E600A7A7A70087878700A6A6A600C4C6C700D7D9DA00E3E6E700DDE5E900DCE2
      E600D4D1CF008787870000000000000000000000000000000000000000000000
      0000000000000000000000000000CA988F00E0C09800DECF9A00EFDEA500EADA
      A300FBEBBF00FBF2D500FBEBBF00A1400B00F4CA8F00FEEBB100FFEDB100FFEF
      B200FCEBAF00F4E5AC00CAB69800CA988F00000000009A9A9A00FBFBFB00D1D1
      D100BABABA00BABABA00BABABA00BABABA00BABABA00D1D1D100EBEBEB00E9E9
      E900DEDEDE00D1D1D100C5C5C500828688000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000470D00019B6
      FF0019B6FF0019B6FF0019B4FE0018B1FB0018ADF70017ABF40017A9F30016A5
      EE0016A3ED00159FE700149DE6001398E1001397E0001292DA001290D9000355
      9D00000000000000000000000000000000000000000000000000BA5B1800C254
      0000C2540000C2540000C053000000D4D00000AFAF0000AFAF00878787008787
      8700878787009F45000087878700878787008787870087878700878787008787
      870087878700752D0F0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CA988F00D4C79800E3D49F00EFDE
      A600EADAA300FBEBBF00F7E5AD00A1400B00F4CA8F00FBE9AF00FCEAAF00FAE9
      AC00F3E3A900EADCA400AB84730000000000000000009A9A9A00FBFBFB00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE009A9A
      9A00828688008286880082868800828688000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000470D00019B6
      FF0019B6FF0019B6FF009AA1A500868A8C00868A8C00868A8C00868A8C00868A
      8C00868A8C00868A8C00868A8C00868A8C00149AE3001398E1001395DD000355
      9D00000000000000000000000000000000000000000000000000C0480000E77F
      1E00E77F1E00E77F1E00E77F1E00E57E1E00E17B1D00DE7A1D00DE7A1D00DE7A
      1D00DE7A1D00E17B1D00E37D1E00EDB67F00E6924300EAB47E00E69243001B4F
      EE0062566A00CA5E050000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AB737300EAD4A100D9CC9F00E5D5
      A300EFDEA700F2E0A700F3E1A900F4E3A900F7E5AA00F8E6AB00F6E3A900F0E1
      A600EADAA300EAD4B600CA988F0000000000000000009A9A9A00FFFFFF00FFFF
      FF00FEFEFE00FBFBFB00FAFAFA00FEFEFE00FEFEFE00FEFEFE00FEFEFE009A9A
      9A00FFFFFF00FFFFFF00DEDEDE00828688000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000470D00019B6
      FF0019B6FF0019B6FF00A1A4A500CBCCCF00C2C4C600B8BBBD00A9ABAD00A1A4
      A600939799008C909200868A8C00868A8C0015A0EA00149DE600149AE3000355
      9E0000000000000000000000000000000000000000000000000000000000CF60
      0500CF600500CF600500CF600500CF600500CF600500CF600500CF600500CF60
      0500CF600500CF600500CF600500CF600500CF600500CF600500CF600500CF60
      0500CF6005000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B6847300FBEBBF00DACF
      A600E1D3A100E6D7A100E9D9A100EADAA300EAD9A100E9D9A100E6D8A000E3D4
      9E00FFEAB600AB8473000000000000000000000000009A9A9A00FFFFFF00FFFF
      FF00FFFFFF00FEFEFE00FEFEFE00FCFCFC00FEFEFE00FEFEFE00FEFEFE009A9A
      9A00FFFFFF00DEDEDE0083868600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000470
      D00019B6FF0019B6FF00A1A4A500DDDEE000DDDEE000CBCCCF00C2C4C600B0B2
      B500A9ABAD009A9EA00093979900868A8C0016A5EE0016A3ED000360B4000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AB848400FBEB
      BF00D7CEAA00D8CCA000D9CB9A00D9CB9800D7C99600D5C79600D3C69500F4E0
      AB00B6847B00000000000000000000000000000000009A9A9A00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009A9A
      9A00DEDEDE008386860000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000046AC400046AC400046AC400A1A4A500DDDEE000DDDEE000D5D5D800CBCC
      CF00B8BBBD00B0B2B500868A8C000368C1000368C0000368C000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B684
      7B00CAAB8F00F4E0AB00FFEAAB00FFEAAB00FFEAAB00F4E0AB00E0B69800B67B
      7B0000000000000000000000000000000000000000009A9A9A00838383008383
      8300838383008383830083838300838383008383830083838300838383008383
      8300838383000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A1A4A50092969700929697009296
      9700909597008C93970000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CA988F00B6847300C08F8400C08F8400B6847B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002F2F2F002F2F2F00A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A6003F3F3F00464646004B4B
      4B004B4B4B002424240000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009092930083838300838383008383
      8300838383008383830083838300838383008383830000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000119823001480270000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003434
      34004D4D4D003A3A3A00A9A9A90045454500515151005C5C5C0038383800B8B8
      B800C0C0C000C6C6C600CACACA00D1D1D100D1D1D100363636003F3F3F004646
      46004B4B4B002727270024242400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001198230035BB
      5900000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000090929300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008383830000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001373
      A5001373A500105B8700105B8700105B8700105B8700105B8700105B8700105B
      8700105B8700105B87001198230032BF4F001989290010662300105B8700105B
      8700105B87001373A50000000000000000000000000000000000333333005252
      52004F4F4F003A3A3A00A6A6A6003E3E3E00454545005151510038383800B1B1
      B100B5B5B500BCBCBC00C2C2C200CACACA00D1D1D10031313100363636003F3F
      3F00424242002828280027272700000000000000000000000000000000001373
      A5001373A500105B8700105B8700105B8700105B8700105B8700105B8700105B
      8700105B8700105B8700105B8700105B8700105B87001198230035BB59001480
      2700105B87001373A50000000000000000000000000000000000000000000000
      00000000000000000000000000005050480090929300FFFFFF00D9D9D9009A9A
      9A009A9A9A009A9A9A009A9A9A00FFFFFF008383830050504800000000000000
      00000000000000000000000000000000000000000000000000001373A5001373
      A5001293CF001293CF001293CF001293CF001293CF001293CF001293CF001293
      CF001293CF001198230032BF4F001C902F001B8C2D00198929001066230034A7
      D80034A7D80048B2DD001373A500000000000000000000000000343434005656
      5600535353003A3A3A00A4A4A4003A3A3A003E3E3E004545450038383800AFAF
      AF00B1B1B100B5B5B500BCBCBC00C2C2C200CACACA002E2E2E00313131003333
      33003A3A3A002B2B2B00262626000000000000000000000000001373A5001373
      A5001293CF001293CF001293CF001293CF001293CF001293CF001293CF001293
      CF001293CF001293CF001293CF00229DD3001198230032BF4F001480270034A7
      D80034A7D80048B2DD001373A500000000000000000000000000000000000000
      00000000000031313100313131005050480090929300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008383830050504800313131003131
      31000000000000000000000000000000000000000000000000001373A5001586
      BA001293CF00229DD300229DD300229DD3002BA3D50034A7D8003EADDA0048B2
      DD001198230032BF4F00209735001F9333001C902F001C8F2D001A8B2B000F5D
      1C0089D0EA00A3DCEF001373A500000000000000000000000000353535005858
      5800565656003A3A3A00A0A0A000363636003A3A3A003C3C3C0038383800ACAC
      AC00AFAFAF00B1B1B100B5B5B500BCBCBC00C2C2C2002B2B2B002E2E2E002F2F
      2F00333333002D2D2D00272727000000000000000000000000001373A5001586
      BA001293CF00229DD300229DD300229DD3002BA3D50034A7D8003EADDA0048B2
      DD0053B8E0005DBDE10069C2E3001198230032BF4F001480270081CCE90084CF
      E90089D0EA00A3DCEF001373A500000000000000000000000000000000003131
      31003131310048484800545555005050480090929300FFFFFF00D9D9D9009A9A
      9A009A9A9A009A9A9A009A9A9A00FFFFFF008383830050504800313131004848
      4800313131003131310000000000000000000000000000000000116291001586
      BA00229DD3002BA3D50034A7D8003EADDA0048B2DD0053B8E0005DBDE1001198
      230032BF4F00249E3C00229A3900219837001F9534001E9231001C8F2D001B8C
      2D000F5D1C00D9F3FA001373A500000000000000000000000000353535005B5B
      5B00585858003A3A3A009E9E9E0032323200363636003838380038383800AAAA
      AA00ACACAC00AFAFAF00B1B1B100B5B5B500B8B8B800282828002B2B2B002D2D
      2D002F2F2F002F2F2F0028282800000000000000000000000000116291001586
      BA00229DD3002BA3D50034A7D8003EADDA0048B2DD0053B8E0005DBDE10069C2
      E30075C7E60078C9E6001198230032BF4F0026A04000116E1F008ED3EB0091D4
      EB0096D7ED00D9F3FA001373A500000000000000000000000000313131004848
      480057595900777D7D00606464005050480090929300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008383830050504800313131006467
      6700575959004848480031313100000000000000000000000000105B87001586
      BA003EADDA0048B2DD0053B8E0005DBDE10069C2E30075C7E60078C9E6001198
      23001198230011982300259F3E00239C3A002198370011982300119823001198
      230011982300EDFBFE001373A500000000000000000000000000353535005E5E
      5E005B5B5B003A3A3A009C9C9C002E2E2E00323232003434340038383800A7A7
      A700AAAAAA00ABABAB00ADADAD00B0B0B000B2B2B20026262600282828002A2A
      2A002D2D2D003333330028282800000000000000000000000000105B87001586
      BA003EADDA0048B2DD0053B8E0005DBDE10069C2E30075C7E60078C9E6007DCB
      E70081CCE90084CFE9001198230021B241001480270096D7ED009AD8EE009EDA
      EE00A3DCEF00EDFBFE001373A50000000000000000004848480057595900676B
      6B009C9C9C0098A1A100606464005050480084848400C5C5C500C5C5C500C5C5
      C500C5C5C500C5C5C500C5C5C500C5C5C500848484005050480031313100676B
      6B00606464005759590048484800313131000000000000000000105B87001586
      BA003EADDA0053B8E00069C2E30078C9E6007DCBE70081CCE90084CFE90089D0
      EA008ED3EB0091D4EB001198230032BF4F00239C3A00116E1F00A9E2B800ACE0
      F200B0E2F200EDFBFE001373A500000000000000000000000000363636006060
      60005F5F5F003A3A3A00999999009C9C9C009E9E9E00A0A0A000A3A3A300A4A4
      A400A6A6A600A9A9A900ABABAB00ADADAD00B0B0B00023232300242424002828
      28002A2A2A003535350028282800000000000000000000000000105B87001586
      BA003EADDA0053B8E00069C2E30078C9E6007DCBE70081CCE90084CFE90089D0
      EA008ED3EB001198230032BF4F0026A04000116E1F00A3DCEF00A7DEF000ACE0
      F200B0E2F200EDFBFE001373A50000000000000000005858580098A1A100C5C5
      C50098A1A10098A1A1004E4F4F00313131003131310031313100313131003131
      3100313131003131310031313100313131003131310031313100484848006A6E
      6E00646767005A5C5C0051525200313131000000000000000000116291001586
      BA003EADDA0069C2E30081CCE90084CFE90089D0EA008ED3EB0091D4EB0096D7
      ED009AD8EE00B5E3F3001198230032BF4F0026A0400014802700B5E3F300B5E3
      F300BAE6F400F7FFFF001373A500000000000000000000000000373737006565
      6500636363003A3A3A003A3A3A003A3A3A003A3A3A003A3A3A003A3A3A003A3A
      3A003A3A3A003A3A3A003A3A3A003A3A3A003A3A3A003A3A3A003A3A3A003A3A
      3A003A3A3A00373737002A2A2A00000000000000000000000000116291001586
      BA003EADDA0069C2E30081CCE90084CFE90089D0EA008ED3EB0091D4EB0096D7
      ED009AD8EE001198230021B2410026A04000116E1F00ACE0F200B0E2F200B5E3
      F300BAE6F400F7FFFF001373A500000000000000000058585800C5C5C500A0A0
      A00098A1A10098A1A10098A1A10098A1A10098A1A10098A1A10098A1A10098A1
      A10098A1A100959E9E008E96960089919100828989007B8181007B81810003A1
      0B0006731C005D5F5F0054555500313131000000000000000000116291001586
      BA005DBDE10089D0EA008ED3EB0091D4EB0096D7ED009AD8EE009AD8EE009EDA
      EE00A3DCEF00A9E2B8001198230032BF4F00116E1F00A9E2B800BDE7F400C2EA
      F600C7EBF700F7FFFF001373A500000000000000000000000000383838006868
      680065656500636363005F5F5F005C5C5C005A5A5A0057575700545454005353
      5300515151004E4E4E004B4B4B00494949004646460043434300414141003F3F
      3F003D3D3D003A3A3A002A2A2A00000000000000000000000000116291001586
      BA005DBDE10089D0EA008ED3EB0091D4EB0096D7ED009AD8EE00119823001198
      2300119823001198230021983700239C3A00259F3E0011982300119823000F5D
      1C00C7EBF700F7FFFF001373A500000000000000000058585800C5C5C50098A1
      A10098A1A10098A1A1007B8181006A6060006A5058006A5050006A5050006A48
      50006A4850006A4850006A4850006A4850006A4850007B606A007B81810023B6
      500003A10B0060646400575959003131310000000000000000001373A5001586
      BA0081CCE90091D4EB0096D7ED009AD8EE009EDAEE00A3DCEF00A7DEF000ACE0
      F200B0E2F2001198230032BF4F002CAB490014802700B5E3F300CBEEF700D0EF
      F800D5F2FA00F7FFFF001373A500000000000000000000000000393939006A6A
      6A00E0E0DD00F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4
      F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4
      F400E0E0DD003E3E3E002B2B2B000000000000000000000000001373A5001586
      BA0081CCE90091D4EB0096D7ED009AD8EE009EDAEE00A3DCEF001198230032BF
      4F001C8F2D001E9231001F95340021983700229A3900249E3C00209735000F5D
      1C00D5F2FA00F7FFFF001373A500000000000000000058585800C5C5C50098A1
      A1007B81810073505800845058008F6A6A008F606000AB737B00AB737B00AB73
      7B00AB737B00AB737B00B47E8700B47E87008F6060008F6A6A008F5060006048
      48006A6E6E0060646400575959003131310000000000000000001373A5001586
      BA0081CCE900D5F2FA00A3DCEF00A7DEF000ACE0F200B0E2F200B5E3F300BAE6
      F400A9E2B800119823002FB2500014802700A9E2B800D5F2FA00D9F3FA00DEF6
      FB00E3F7FC00F7FFFF001373A5000000000000000000000000003B3B3B006F6F
      6F00F4F4F400F6F6F600F6F6F600F6F6F600F7F7F700F7F7F700F7F7F700F7F7
      F700F8F8F800FAFAFA00FAFAFA00FBFBFB00FCFCFC00FCFCFC00FEFEFE00FFFF
      FF00FFFFFF00414141002C2C2C000000000000000000000000001373A5001586
      BA0081CCE900D5F2FA00A3DCEF00A7DEF000ACE0F200B0E2F200B5E3F3001198
      230032BF4F001C8F2D001C902F001F933300209735001F9136000F5D1C00DEF6
      FB00E3F7FC00F7FFFF001373A500000000000000000058585800C5C5C50098A1
      A10073606A006A3138008F6A6A008F6060008F6060008F6060008F6060008F60
      60008F6060008F606000956968009569680095696800956968008F6A6A007331
      40009860840060646400575959003131310000000000000000001373A5001586
      BA00BDE7F400E3F7FC00DEF6FB00DEF6FB00DEF6FB00DEF6FB00DEF6FB00E1F6
      E7001198230032BF4F0014802700A9E2B800DEF6FB00E3F7FC00E9FAFE00EDFB
      FE00F2FEFF00F7FFFF001373A5000000000000000000000000003D3D3D007878
      7800F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4
      F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400FEFE
      FE00FFFFFF00424242002D2D2D000000000000000000000000001373A5001586
      BA00BDE7F400E3F7FC00DEF6FB00DEF6FB00DEF6FB00DEF6FB00DEF6FB00C7EB
      F7001198230032BF4F001B8C2D001C902F001F9136000F5D1C00E9FAFE00EDFB
      FE00F2FEFF00F7FFFF001373A50000000000000000006A585800C5C5C500ACAC
      AC007B606A00603138006A313800401C1C003838380038383800383838003131
      31003131310031313100313131003131310031313100401C1C006A3138006031
      3800846A730060646400575959004848480000000000000000001373A5001586
      BA001586BA001586BA001586BA001586BA001586BA001698CA00B5E3F3001198
      230035BB590014802700A9E2B800E9FAFE00EDFBFE00F2FEFF00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF001373A5000000000000000000000000003F3F3F007E7E
      7E00F4F4F400F4F4F400CECECC00828282008282820082828200828282008282
      8200828282008282820082828200828282008282820082828200CECECC00FCFC
      FC00FEFEFE00454545002D2D2D000000000000000000000000001373A5001586
      BA001586BA001586BA001586BA001586BA001586BA001698CA00B5E3F300DEF6
      FB00D9F3FA001198230032BF4F001F9136000F5D1C00F2FEFF00F7FFFF00F7FF
      FF00F7FFFF00F7FFFF001373A50000000000000000007373730098A1A100C5C5
      C500987B84002A0B11003131310031161600584848006B5A5A006B5A5A006B5A
      5A006B5A5A006B5A5A006B5A5A006B5A5A006B5A5A00381C1C00232323003111
      11008F84840060646400575959005152520000000000000000001373A5001698
      CA001293CF001293CF00229ED40035A9D90048B4DE0048B4DE001698CA0035BB
      590011982300E1F6E700F2FEFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF00CBEEF7001373A500000000000000000000000000414141008383
      8300F4F4F400F4F4F400F4F4F400F4F4F400F6F6F600F6F6F600F6F6F600F6F6
      F600F7F7F700F7F7F700F7F7F700F8F8F800F8F8F800FAFAFA00FBFBFB00FCFC
      FC00FCFCFC00474747002E2E2E000000000000000000000000001373A5001698
      CA001293CF001293CF00229ED40035A9D90048B4DE0048B4DE001698CA00B5E3
      F300E9FAFE00EDFBFE00148027000F5D1C00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF00CBEEF7001373A5000000000000000000000000006A585800C5C5
      C500AB8F98002A1111003131310090929300EDEDED00EFEFEF00F0F0F000F2F2
      F200F4F4F400F7F7F700FAFAFA00FCFCFC00FFFFFF0083838300545555003111
      1100A18F8F0060646400484848000000000000000000000000001373A5001698
      CA0035A9D90048B4DE005EBFE30075C7E6007BCAE70082CCE90089D0EA001698
      CA001698CA001698CA001698CA001698CA001698CA001698CA001698CA001698
      CA001698CA001698CA0000000000000000000000000000000000414141008989
      8900F4F4F400F3F3F300F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4
      F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400FAFA
      FA00FBFBFB004B4B4B002F2F2F000000000000000000000000001373A5001698
      CA0035A9D90048B4DE005EBFE30075C7E6007BCAE70082CCE90089D0EA001698
      CA001698CA001698CA001698CA001698CA001698CA001698CA001698CA001698
      CA001698CA001698CA00000000000000000000000000000000007373730098A1
      A100A1A1A100847B7B006A58580090929300F3F3F300EDEDED00EEEEEE00EFEF
      EF00F2F2F200F3F3F300F6F6F600F8F8F800FBFBFB008383830060485000847B
      7B0098A1A10098A1A100515252000000000000000000000000001373A5001698
      CA0075C7E6007BCAE70082CCE90089D0EA0090D3EB0097D7ED009ED9EE00A5DC
      EF00ACE0F000B4E2F200ACE0F000ACE0F000ACE0F000ACE0F000ACE0F000ACE0
      F000ACE0F0001586BA0000000000000000000000000000000000434343009090
      9000F4F4F400F3F3F300CECECC00828282008282820082828200828282008282
      8200828282008282820082828200828282008282820082828200CECECC00FAFA
      FA00FAFAFA004E4E4E002F2F2F000000000000000000000000001373A5001698
      CA0075C7E6007BCAE70082CCE90089D0EA0090D3EB0097D7ED009ED9EE00A5DC
      EF00ACE0F000B4E2F200ACE0F000ACE0F000ACE0F000ACE0F000ACE0F000ACE0
      F000ACE0F0001586BA0000000000000000000000000000000000000000007373
      73006A5858006A5858006A58580090929300F8F8F800F3F3F300EDEDED00EEEE
      EE00EFEFEF00F2F2F200F3F3F300F6F6F600E5E5E500838383006A5858006A58
      58006A5858006A585800000000000000000000000000000000001373A5001698
      CA0089D0EA0090D3EB0097D7ED009ED9EE00A5DCEF00ACE0F000B4E2F200BBE6
      F300B5E3F3001586BA001586BA001586BA001586BA001586BA001586BA001586
      BA001586BA000000000000000000000000000000000000000000464646009898
      9800F4F4F400F3F3F300F3F3F300F3F3F300F4F4F400F4F4F400F4F4F400F3F3
      F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3
      F300FAFAFA0051515100313131000000000000000000000000001373A5001698
      CA0089D0EA0090D3EB0097D7ED009ED9EE00A5DCEF00ACE0F000B4E2F200BBE6
      F300B5E3F3001586BA001586BA001586BA001586BA001586BA001586BA001586
      BA001586BA000000000000000000000000000000000000000000000000000000
      000000000000000000000000000090929300FFFFFF00F8F8F800F3F3F300EDED
      ED00EEEEEE00E3E3E300D9D9D900DADADA00D5D5D50083838300000000000000
      0000000000000000000000000000000000000000000000000000000000001586
      BA0078C9E600BAE6F400DEF6FB00DEF6FB00DEF6FB00DEF6FB00DEF6FB00BAE6
      F4001586BA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000474747009F9F
      9F00F4F4F400F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3
      F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3F300F3F3
      F300F8F8F8005353530032323200000000000000000000000000000000001586
      BA0078C9E600BAE6F400DEF6FB00DEF6FB00DEF6FB00DEF6FB00DEF6FB00BAE6
      F4001586BA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000090929300FFFFFF00FCFCFC00F3F3F300F3F3
      F300EDEDED009092930083838300838383008383830083838300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00001586BA001586BA001586BA001586BA001586BA001586BA001586BA001586
      BA00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000049494900A5A5
      A500F4F4F400F2F2F200F2F2F200F3F3F300F3F3F300F3F3F300F4F4F400F4F4
      F400F4F4F400F4F4F400F6F6F600F6F6F600F6F6F600F7F7F700F7F7F700F7F7
      F700F7F7F7005656560032323200000000000000000000000000000000000000
      00001586BA001586BA001586BA001586BA001586BA001586BA001586BA001586
      BA00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000090929300FFFFFF00FEFEFE00F8F8F800F3F3
      F300EAEAEA0090929300FFFFFF00FFFFFF00DEDEDE0083838300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000004B4B4B00ABAB
      AB00E97A1D00E2751A00E0731800D96D1600D3681300CE641000CB620F00C75E
      0D00C55C0C00C1590A00BD560900BB540800B7510700B44E0600B14C0500AD49
      0400AC4803005A5A5A0033333300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000090929300FFFFFF00FFFFFF00FFFFFF00F8F8
      F800F3F3F30090929300FFFFFF00DEDEDE008383830000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004B4B
      4B00F2812100EB7D1F00E5771C00E0731800D96D1600D3681300CE641000CB62
      0F00C75E0D00C55C0C00C1590A00BD560900BB540800B8520700B6500600B24D
      0500AF4A04003535350000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000090929300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F8F8F80090929300DEDEDE00838383000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000909293008383830083838300838383008383
      8300838383008383830083838300000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000060000000C00000000100010000000000000900000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000E00003FFFFFFFFF800E00003E00003FF
      FFFFFFF800E00003E00003FFFFFFFFF800E00003E00003C00003FFF800E00003
      E00003800001FFF800E00003E00003800001FFF800E00003E00003800001FFF8
      00E00003E00003800001FFF800E00003E00003800001FFF800E00003E0000380
      0001FFF800E00003E00003800001000801E00003E00003800001000803E00003
      E00003800001000807E00003E00003800001000FC3E00003E00003800001000F
      81E00003E00003800001000F00E00003E00003800001000F00E00003E0000380
      0001000FC3E00003E00003800001000FC3E00003E00007800003000FC3E00007
      E0000F803FFF000FC3E0000FE0001FC07FFF001F87E0001FE0003FFFFFFF0020
      0FE0003FFFFFFFFFFFFF00701FFFFFFFFF00FFFF00FFE00003FF00FFFC003FFC
      003FE00003FC003FF0000FF0000FE00003F0000FE00007E00007E00003E00007
      C00003C00003E00003C00003C00003C00003E00003C00003800001800001E000
      03800001800001800001E00003800001000000000000E0000300000000000000
      0000E00003000000000000000000E00003000000000000000000E00003000000
      000000000000E00003000000000000000000E00003000000000000000000E000
      03000000000000000000E00003000000800001800001E0000380000180000180
      0001E00003800001C00003C00003E00003C00003C00003C00003E00007C00003
      E00007E00007E0000FE00007F0000FF0000FE0001FF0000FFC003FFC003FE000
      3FFC003FFF00FFFF00FFFFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFC003FFC
      003FFC003FFC003FF0000FF0000FF0000FF0000FE00007E00007E00007E00007
      C00003C00003C00003C00003C00003C00003C00003C000038000018000018000
      0180000180000180000180000180000100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000180000180000180000180000180
      0001800001800001C00003C00003C00003C00003C00003C00003C00003C00003
      E00007E00007E00007E00007F0000FF0000FF0000FF0000FFC003FFC003FFC00
      3FFC003FFF00FFFF00FFFF00FFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF
      FFFFFF00FFFC003FFFFFFFFFFFFFFC003FF0000FFFBFFFFFFDFFF8001FE00007
      FF3FFFFFFCFFF0000FC00003FE3FFFFFFC7FE00007C00003FC3FFFFFFC3FC000
      03800001F80003C0001FC00003800001F00003C0000F800001000000E00003C0
      0007800001000000C00003C00003800001000000800003C00001800001000000
      C00003C00003800001000000E00003C00007800001000000F00003C0000F8000
      01000000F83FFFFFFC1F800001000000FC3FFFFFFC3FC00003800001FE3FFFFF
      FC7FC00003800001FF3FFFFFFCFFE00007C00003FFBFFFFFFDFFF0000FC00003
      FFFFFFFFFFFFF8001FE00007FFFFFFFFFFFFFC003FF0000FFFFFFFFFFFFFFF00
      FFFC003FFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF800001FFFFFFF8003FF8003F8000010001FFFC007FFC007F8000010001FF
      FE00FFFE00FF8000010001FFC00003C000038000010001FF8000018000018000
      010001FF8000018000018000010001FF8000018000018000010001FF80000180
      00018000010001FF8000018000018000010001FF8000018000018000010001FF
      8000018000018000010001FF8000018000018000010001F08000018000018000
      0100018080000180000180000100000080000180000180000100000080000180
      0001800001000000800001800001800001000000800001800001800001000000
      800001800001800001FF8000800001800001C00003FFE080C00003C00003FFFF
      FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFF0001FE0003FF1E1FCFFFFFFF0001C0
      0003FF1E1F87FFFFFF0001C00003C0000303FFFFFF0001C00003C0000301FFFF
      FF0001C00003C0000300FFFFFF0001C00003C00003807FFF800001C00003C000
      03C03FFF800001C00003C00003E03FFF800001C00003C00003F0301F800001C0
      0003C00003F8000F800001C00003C00003FF0003800001C00003C00002FF0003
      800001C00003C00000FF0001800001C00003C00000FF0001800001C00003C000
      00FE0000800003C00007C00000FE0000800007C0000FC00001FE000080000FC0
      000FC00003FE00008000FFC0000FC00003FF00018000FFC0000FC00003FF0001
      8000FFC0000FE00007FF80038001FFE0001FFFFFFFFFC0078003FFF0003FFFFF
      FFFFE00F8007FFFF03FFFFFFFFFFF83FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
      0003FFFFFFFF007FFFFE7FE00001FFFFCFFF007FE00003C00001E00003FE003F
      C00001C00001C00001F8000FC00001C00001C00001E00003C00001C00001C000
      01C00001C00001C00001C00001800000C00001C00001C00001800000C00001C0
      0001C00001800000C00001C00001C00001800000C00001C00001C00001800000
      C00001C00001C00001800000C00001C00001C00001800000C00001C00001C000
      01800000C00001C00001C00001C00001C00003C00001C00003C00001C00003C0
      0001C00003E00003C00007C00001C00007FE003FE007FFC00001E007FFFE003F
      F00FFFC00001F00FFFFE003FFFFFFFC00001FFFFFFFE007FFFFFFFE00003FFFF
      FFFE00FFFFFFFFFFFFFFFFFFFFFE01FF00000000000000000000000000000000
      000000000000}
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
    Height = 24
    Width = 24
    Left = 586
    Top = 219
    Bitmap = {
      494C01011C001D00040018001800FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000060000000C000000001002000000000000020
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A5A5
      A5009B9B9B009B9B9B009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009D9D9D009D9D9D009D9D9D009D9D9D009E9E9E009E9E9E009E9E9E009F9F
      9F009F9F9F009F9F9F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C009E9E9E009E9E9E009E9E9E009E9E9E009D9D9D009D9D
      9D009D9D9D009E9E9E009E9E9E009C9C9C00000000000000000000000000A5A5
      A5009B9B9B009B9B9B009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009D9D9D009D9D9D009D9D9D009D9D9D009E9E9E009E9E9E009E9E9E009F9F
      9F009F9F9F009F9F9F000000000000000000000000000000000000000000A5A5
      A500F6F6F600F4F4F400F3F3F300F2F2F200F0F0F000EFEFEF00EDEDED00ECEC
      EC00EAEAEA00E9E9E900E7E7E700E4E4E400E1E1E100DFDFDF00DCDCDC00D9D9
      D900D7D7D7009F9F9F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A3A3A300EFEFEF00E1E1E100DDDDDD00D7D7D700CFCFCF00CACA
      CA00C8C8C800CBCBCB00CCCCCC009D9D9D00000000000000000000000000A5A5
      A500F6F6F600F4F4F400F3F3F300F2F2F200F0F0F000EFEFEF00EDEDED00ECEC
      EC00EAEAEA00E9E9E900E7E7E700E4E4E400E1E1E100DFDFDF00DCDCDC00D9D9
      D900D7D7D7009F9F9F000000000000000000000000000000000000000000A5A5
      A500F8F8F800F6F6F600F4F4F400F3F3F300F2F2F200F0F0F000EFEFEF00EDED
      ED00ECECEC00EAEAEA00E9E9E900E7E7E700E4E4E400E1E1E100DFDFDF00DCDC
      DC00D9D9D9009E9E9E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A2A2A200F0F0F000DFDFDF00B9B9B90098989800828282009494
      9400A9A9A900C5C5C500C8C8C8009D9D9D00000000000000000000000000A5A5
      A500F8F8F800F6F6F600F4F4F400F3F3F300F2F2F200F0F0F000EFEFEF00EDED
      ED00ECECEC00EAEAEA00E9E9E900E7E7E700E4E4E400E1E1E100DFDFDF00DCDC
      DC00D9D9D9009E9E9E000000000000000000000000000000000000000000A6A6
      A600F9F9F900F8F8F800F6F6F600F4F4F400F3F3F300F2F2F200F0F0F000EFEF
      EF00EDEDED00ECECEC00EAEAEA00E9E9E900E7E7E700E4E4E400E1E1E100DFDF
      DF00DCDCDC009E9E9E00000000000000000000000000000000005F5F5F005F5F
      5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F
      5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F
      5F005F5F5F005F5F5F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A4A4A400F5F5F500BFBFBF00828282007F7F7F007F7F7F007F7F
      7F0082828200ABABAB00C8C8C8009D9D9D00000000000000000000000000A6A6
      A600F9F9F900F8F8F800F6F6F600F4F4F4005A5A5A00F2F2F200F0F0F000DCDC
      DC005A5A5A005A5A5A00DCDCDC00E9E9E900E7E7E700E4E4E400E1E1E100DFDF
      DF00DCDCDC009E9E9E000000000000000000000000000000000000000000A6A6
      A600FBFBFB00F9F9F900F8F8F800F6F6F600F4F4F400F3F3F300F2F2F200F0F0
      F000EFEFEF00EDEDED00ECECEC00EAEAEA00E9E9E900E7E7E700E4E4E400E1E1
      E100DFDFDF009D9D9D0000000000000000000000000073737300737373007979
      7900797979007979790079797900797979007A7A7A007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007B7B7B007B7B7B007B7B
      7B007C7C7C00737373005F5F5F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A6A6A600FBFBFB009D9D9D007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F0095959500CCCCCC009D9D9D00000000000000000000000000A6A6
      A600FBFBFB00F9F9F900F8F8F800F6F6F6006A6A6A005A5A5A00F0F0F0005A5A
      5A00808080007E7E7E005A5A5A00DCDCDC00E9E9E900E7E7E700E4E4E400E1E1
      E100DFDFDF009D9D9D000000000000000000000000000000000000000000A7A7
      A700FCFCFC00FBFBFB00F9F9F900F8F8F800F6F6F600F4F4F400F3F3F300F2F2
      F200F0F0F000EFEFEF00EDEDED00ECECEC00EAEAEA00E9E9E900E7E7E700E4E4
      E400E1E1E1009D9D9D0000000000000000000000000079797900F5F5F500CDCD
      CD00CBCBCB00C9C9C900C7C7C700C5C5C500C3C3C300C1C1C100BEBEBE00BDBD
      BD00BABABA00B8B8B800B6B6B600B1B1B100A7A7A7009D9D9D00939393008888
      88007E7E7E007D7D7D005F5F5F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A9A9A900FFFFFF00848484007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F0083838300D2D2D2009D9D9D00000000000000000000000000A7A7
      A700FCFCFC00FBFBFB00F9F9F900F8F8F8006A6A6A00858585005A5A5A008585
      85006A6A6A006A6A6A006A6A6A005A5A5A00DCDCDC00E9E9E900E7E7E700E4E4
      E400E1E1E1009D9D9D000000000000000000000000000000000000000000A7A7
      A700FCFCFC00FCFCFC00FBFBFB00F9F9F900F8F8F800F6F6F600F4F4F400F3F3
      F300F2F2F200F0F0F000EFEFEF00EDEDED00ECECEC00EAEAEA00E9E9E900E7E7
      E700E4E4E4009C9C9C0000000000000000000000000079797900F5F5F500CFCF
      CF00CDCDCD00CBCBCB00C9C9C900C7C7C700C5C5C500C3C3C300C1C1C100BEBE
      BE00BDBDBD00BABABA00B8B8B800B6B6B600B1B1B100A7A7A7009D9D9D009393
      9300888888007D7D7D005F5F5F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B3B3B300FFFFFF00A0A0A0007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F0099999900DBDBDB009E9E9E00000000000000000000000000A7A7
      A700FCFCFC00FCFCFC00FBFBFB00F9F9F9006A6A6A0087878700888888005A5A
      5A00F2F2F200F0F0F000DCDCDC006A6A6A005A5A5A00EAEAEA00E9E9E900E7E7
      E700E4E4E4009C9C9C000000000000000000000000000000000000000000A7A7
      A700FCFCFC00FCFCFC00FCFCFC00FBFBFB00F9F9F900F8F8F800F6F6F600F4F4
      F400F3F3F300F2F2F200F0F0F000EFEFEF00EDEDED00ECECEC00EAEAEA00E9E9
      E900E7E7E7009C9C9C0000000000000000000000000079797900F5F5F500D1D1
      D100CFCFCF00CDCDCD00CBCBCB00C9C9C900C7C7C700C5C5C500C3C3C300C1C1
      C100BEBEBE00BDBDBD00BABABA00B8B8B800B6B6B600B1B1B100A7A7A7009D9D
      9D0093939300838383005F5F5F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B7B7B700FFFFFF00CECECE00838383007F7F7F007F7F7F007F7F
      7F0082828200BEBEBE00CDCDCD009D9D9D00000000000000000000000000A7A7
      A700FCFCFC00FCFCFC00FCFCFC00FBFBFB006A6A6A00888888008C8C8C008888
      88005A5A5A00F2F2F200F0F0F000DCDCDC006A6A6A00DCDCDC00EAEAEA00E9E9
      E900E7E7E7009C9C9C000000000000000000000000000000000000000000A8A8
      A800FCFCFC00FCFCFC00FCFCFC00FCFCFC00FBFBFB00F9F9F900F8F8F800F6F6
      F600F4F4F400F3F3F300F2F2F200F0F0F000EFEFEF00EDEDED00ECECEC00EAEA
      EA00E9E9E9009C9C9C0000000000000000000000000079797900F5F5F500D3D3
      D300D1D1D100CFCFCF00CDCDCD00CBCBCB00C9C9C900C7C7C700C5C5C500C3C3
      C300C1C1C100BEBEBE00BDBDBD00BABABA00B8B8B800B6B6B600B1B1B100A7A7
      A7009D9D9D00838383005F5F5F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BCBCBC00FFFFFF00FFFFFF00CFCFCF00A2A2A200848484009E9E
      9E00BABABA00C2C2C200AAAAAA009B9B9B00000000000000000000000000A8A8
      A800FCFCFC00FCFCFC00FCFCFC00FCFCFC006A6A6A006A6A6A006A6A6A006A6A
      6A006A6A6A005A5A5A00F2F2F200F0F0F000DCDCDC005A5A5A00ECECEC00EAEA
      EA00E9E9E9009C9C9C000000000000000000000000000000000000000000A9A9
      A900FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FBFBFB00F9F9F900F8F8
      F800F6F6F600F4F4F400F3F3F300F2F2F200F0F0F000EFEFEF00EDEDED00ECEC
      EC00EAEAEA009B9B9B0000000000000000000000000079797900F5F5F500D6D6
      D600D3D3D300D1D1D100CFCFCF00CDCDCD00CBCBCB00C9C9C900C7C7C700C5C5
      C500C3C3C300C1C1C100BEBEBE00BDBDBD00BABABA00B8B8B800B6B6B600B1B1
      B100A7A7A700838383005F5F5F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDBDBD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00F3F3
      F300B3B3B3009A9A9A009999990099999900000000000000000000000000A9A9
      A900FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FBFBFB00F9F9F900F8F8
      F800F6F6F600F4F4F400F3F3F300F2F2F200F0F0F000EFEFEF00EDEDED00ECEC
      EC00EAEAEA009B9B9B000000000000000000000000000000000000000000AAAA
      AA00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FBFBFB00F9F9
      F900F8F8F800F6F6F600F4F4F400F3F3F300F2F2F200F0F0F000EFEFEF00EDED
      ED00ECECEC009B9B9B0000000000000000000000000079797900F5F5F500D7D7
      D700D6D6D600D3D3D300D1D1D100CFCFCF00CDCDCD00CBCBCB00C9C9C900C7C7
      C700C5C5C500C3C3C300C1C1C100BEBEBE00BDBDBD00BABABA00B8B8B800B6B6
      B600B1B1B100838383005F5F5F00000000009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C0000000000C3C3C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F9F9
      F900ADADAD00A3A3A300A1A1A10000000000000000000000000000000000AAAA
      AA00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FBFBFB00F9F9
      F900F8F8F800F6F6F600F4F4F400F3F3F300F2F2F200F0F0F000EFEFEF00EDED
      ED00ECECEC009B9B9B000000000000000000000000000000000000000000AAAA
      AA00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FBFB
      FB00F9F9F900F8F8F800F6F6F600F4F4F400F3F3F300F2F2F200F0F0F000EFEF
      EF00EDEDED009B9B9B0000000000000000000000000079797900F5F5F500DADA
      DA00D7D7D700D6D6D600D3D3D300D1D1D100CFCFCF00CDCDCD00CBCBCB00C9C9
      C900C7C7C700C5C5C500C3C3C300C1C1C100BEBEBE00BDBDBD00BABABA00B8B8
      B800B6B6B600838383005F5F5F00000000009C9C9C00E9E9E900DEDEDE00DADA
      DA00D5D5D500CFCFCF00C9C9C900C6C6C600C5C5C500C9C9C900C5C5C5009C9C
      9C0000000000C3C3C300FBFBFB00F7F7F700F7F7F700F7F7F700FAFAFA00E9E9
      E900A8A8A800A0A0A0000000000000000000000000000000000000000000AAAA
      AA00FCFCFC00FCFCFC005A5A5A00DCDCDC00FCFCFC00FCFCFC006A6A6A005A5A
      5A005A5A5A005A5A5A005A5A5A005A5A5A00F3F3F300F2F2F200F0F0F000EFEF
      EF00EDEDED009B9B9B000000000000000000000000000000000000000000ABAB
      AB00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FBFBFB00F9F9F900F8F8F800F6F6F600F4F4F400F3F3F300F2F2F200F0F0
      F000EFEFEF009A9A9A0000000000000000000000000078787800F5F5F500DDDD
      DD00DBDBDB00D9D9D900D7D7D700D4D4D400D3D3D300D0D0D000CECECE00CCCC
      CC00CACACA00C8C8C800C6C6C600C4C4C400C2C2C200C0C0C000BEBEBE00BBBB
      BB00BABABA00838383005F5F5F00000000009C9C9C00EBEBEB00E0E0E000DCDC
      DC00D7D7D700D2D2D200CDCDCD00C7C7C700C2C2C200C6C6C600C5C5C5009C9C
      9C0000000000BEBEBE00B0B0B000B1B1B100B1B1B100C1C1C100C1C1C1007373
      73007D7D7D00000000000000000000000000000000000000000000000000ABAB
      AB00FCFCFC00FCFCFC00DCDCDC005A5A5A00DCDCDC00FCFCFC00FCFCFC006A6A
      6A00888888008C8C8C00888888005A5A5A00F4F4F400F3F3F300F2F2F200F0F0
      F000EFEFEF009A9A9A000000000000000000000000000000000000000000ABAB
      AB00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00FBFBFB00F9F9F900F8F8F800F6F6F600F4F4F400F3F3F300F2F2
      F200F0F0F0009A9A9A0000000000000000000000000078787800F5F5F500DFDF
      DF00DDDDDD00DBDBDB00D9D9D900D7D7D700D4D4D400D3D3D300D0D0D000CECE
      CE00CCCCCC00CACACA00C8C8C800C6C6C600C4C4C400C2C2C200C0C0C000BEBE
      BE00BBBBBB00838383005F5F5F00000000009C9C9C00D5D5D500929292009191
      910091919100909090008F8F8F008E8E8E008D8D8D0086868600C5C5C5009C9C
      9C00000000000000000000000000000000000000000000000000696969008E8E
      8E00A2A2A2006C6C6C000000000000000000000000000000000000000000ABAB
      AB00FCFCFC00FCFCFC00FCFCFC006A6A6A005A5A5A00DCDCDC00FCFCFC00FCFC
      FC006A6A6A0088888800878787005A5A5A00F6F6F600F4F4F400F3F3F300F2F2
      F200F0F0F0009A9A9A000000000000000000000000000000000000000000ACAC
      AC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FBFBFB00F9F9F900F8F8F800F6F6F600F4F4F400F3F3
      F300E6E6E6009999990000000000000000000000000078787800F5F5F500E1E1
      E100DFDFDF00DDDDDD00DBDBDB00D9D9D900D7D7D700D4D4D400D3D3D300D0D0
      D000CECECE00CCCCCC00CACACA00C8C8C800C6C6C600C4C4C400C2C2C200C0C0
      C000BEBEBE00848484005F5F5F00000000009F9F9F00F5F5F5009D9D9D007E7E
      7E007E7E7E007E7E7E007E7E7E007E7E7E0080808000B8B8B800C7C7C7009C9C
      9C0000000000000000000000000000000000000000006767670087878700B2B2
      B200A6A6A600ABABAB006C6C6C0000000000000000000000000000000000ACAC
      AC00FCFCFC00FCFCFC00FCFCFC00DCDCDC006A6A6A005A5A5A005A5A5A005A5A
      5A00858585006A6A6A00858585005A5A5A00F8F8F800F6F6F600F4F4F400F3F3
      F300E6E6E600999999000000000000000000000000000000000000000000ADAD
      AD00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FBFBFB00F9F9F900F8F8F800F6F6F600E6E6
      E600CFCFCF009999990000000000000000000000000078787800F5F5F500E3E3
      E300E1E1E100DFDFDF00DDDDDD00DBDBDB00D9D9D900D7D7D700D4D4D400D3D3
      D300D0D0D000CECECE00CCCCCC00CACACA00C8C8C800C6C6C600C4C4C400C2C2
      C200C0C0C000888888005F5F5F00000000009F9F9F00FEFEFE00D7D7D7008080
      80007E7E7E007E7E7E007E7E7E007E7E7E00A5A5A500CECECE00CCCCCC009C9C
      9C00000000000000000000000000000000006C6C6C0087878700919191009E9E
      9E008E8E8E009A9A9A00979797006C6C6C00000000000000000000000000ADAD
      AD00FCFCFC00FCFCFC00FCFCFC00FCFCFC00DCDCDC006A6A6A007E7E7E008080
      80005A5A5A00FCFCFC006A6A6A005A5A5A00F9F9F900F8F8F800F6F6F600E6E6
      E600CFCFCF00999999000000000000000000000000000000000000000000AEAE
      AE00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FBFBFB00CFCFCF00C5C5C500BBBB
      BB00B1B1B1009898980000000000000000000000000078787800F5F5F500E5E5
      E500E3E3E300E1E1E100DFDFDF00DDDDDD00DBDBDB00D9D9D900D7D7D700D4D4
      D400D3D3D300D0D0D000CECECE00CCCCCC00CACACA00C8C8C800C6C6C600C4C4
      C400C2C2C200939393005F5F5F0000000000A6A6A600FEFEFE00F3F3F300B0B0
      B0007E7E7E007E7E7E007E7E7E0086868600D1D1D100D5D5D500D1D1D1009C9C
      9C00000000000000000000000000000000006C6C6C006C6C6C006C6C6C009999
      9900A6A6A6006C6C6C006C6C6C006C6C6C00000000000000000000000000AEAE
      AE00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00DCDCDC006A6A6A006A6A
      6A00DCDCDC00FCFCFC00FCFCFC006A6A6A00FBFBFB00CFCFCF00C5C5C500BBBB
      BB00B1B1B100989898000000000000000000000000000000000000000000AFAF
      AF00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00A8A8A80097979700979797009797
      9700989898009898980000000000000000000000000078787800F5F5F500E7E7
      E700E5E5E500E3E3E300E1E1E100DFDFDF00DDDDDD00DBDBDB00D9D9D900F5F5
      F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5
      F500F5F5F500F5F5F5005F5F5F0000000000B1B1B100FEFEFE00F9F9F900F0F0
      F0008A8A8A007E7E7E007E7E7E00B6B6B600DEDEDE00DDDDDD00D6D6D6009C9C
      9C00000000000000000000000000000000000000000000000000656565008787
      8700A0A0A0006C6C6C000000000000000000000000000000000000000000AFAF
      AF00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00A8A8A80097979700979797009797
      970098989800989898000000000000000000000000000000000000000000AFAF
      AF00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00A9A9A900FFFFFF00FFFFFF00FFFF
      FF00DCDCDC009898980000000000000000000000000078787800F5F5F500E9E9
      E900E7E7E700E5E5E500E3E3E300E1E1E100DFDFDF00DDDDDD00F5F5F5007979
      7900696969006969690069696900696969006969690069696900696969006969
      690069696900696969006969690000000000B1B1B100FEFEFE00FFFFFF00FEFE
      FE00C4C4C4007E7E7E0093939300E9E9E900E6E6E600DBDBDB00BBBBBB009C9C
      9C000000000000000000000000000000000000000000000000006C6C6C007E7E
      7E00939393006C6C6C000000000000000000000000000000000000000000AFAF
      AF00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00A9A9A900FFFFFF00FFFFFF00FFFF
      FF00DCDCDC00989898000000000000000000000000000000000000000000AFAF
      AF00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00A9A9A900FFFFFF00FFFFFF00DCDC
      DC009C9C9C000000000000000000000000000000000078787800F5F5F500ECEC
      EC00EAEAEA00E8E8E800E6E6E600E4E4E400E2E2E200F5F5F500797979005F5F
      5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F
      5F005F5F5F005F5F5F000000000000000000B8B8B800FEFEFE00FFFFFF00FFFF
      FF00FEFEFE0096969600D1D1D100E9E9E900C9C9C900AFAFAF00A2A2A2009C9C
      9C00000000000000000000000000000000000000000000000000727272008585
      8500898989006C6C6C000000000000000000000000000000000000000000AFAF
      AF00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00A9A9A900FFFFFF00FFFFFF00DCDC
      DC009C9C9C00000000000000000000000000000000000000000000000000AFAF
      AF00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00AAAAAA00FFFFFF00DCDCDC009C9C
      9C00000000000000000000000000000000000000000078787800E9E9E900F5F5
      F500F5F5F500F5F5F500F5F5F500F5F5F500F5F5F50078787800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B8B8B800FEFEFE00FFFFFF00FFFF
      FF00FFFFFF00EEEEEE00FCFCFC00E2E2E2009999990099999900999999009898
      9800000000000000000000000000000000000000000000000000787878008E8E
      8E00818181006C6C6C000000000000000000000000000000000000000000AFAF
      AF00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00AAAAAA00FFFFFF00DCDCDC009C9C
      9C0000000000000000000000000000000000000000000000000000000000AFAF
      AF00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00ABABAB00DCDCDC009C9C9C000000
      0000000000000000000000000000000000000000000000000000787878007878
      7800787878007878780078787800787878007878780000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BFBFBF00FEFEFE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E5E5E50099999900A8A8A800A0A0A0000000
      000000000000000000000000000000000000000000007B7B7B008C8C8C008888
      88006C6C6C00000000000000000000000000000000000000000000000000AFAF
      AF00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC00FCFCFC00FCFCFC00ABABAB00DCDCDC009C9C9C000000
      000000000000000000000000000000000000000000000000000000000000AFAF
      AF009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BFBFBF00F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700D6D6D60099999900A4A4A400000000006C6C
      6C006C6C6C006C6C6C00717171007A7A7A007E7E7E007F7F7F00787878006C6C
      6C0000000000000000000000000000000000000000000000000000000000AFAF
      AF009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BFBFBF00B1B1B100B1B1B100B1B1
      B100B1B1B100B1B1B100B1B1B100B1B1B1009999990000000000000000000000
      00006C6C6C006C6C6C007070700070707000707070006D6D6D006C6C6C000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009797970097979700979797009797
      9700979797009797970097979700979797000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009595950095959500959595009595
      9500959595009595950095959500959595000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009090
      90009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009898980098989800989898009898
      9800989898009898980098989800989898000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000097979700979797009B9B9B009F9F9F00A2A2A200A3A3
      A300A3A3A300A2A2A2009F9F9F009B9B9B009797970097979700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009595950095959500989898009C9C9C009F9F9F00A0A0
      A000A0A0A0009F9F9F009C9C9C00989898009595950095959500000000000000
      0000000000000000000000000000000000000000000000000000000000009191
      9100DBDBDB00DFDFDF00DADADA00D6D6D600D3D3D300CFCFCF00CDCDCD00C9C9
      C900C5C5C500C4C4C400C4C4C400C4C4C400C4C4C400C4C4C400C4C4C400C4C4
      C400C3C3C3009797970000000000000000000000000000000000000000000000
      0000000000000000000098989800989898009C9C9C00A0A0A000A3A3A300A3A3
      A300A3A3A300A3A3A300A0A0A0009C9C9C009898980098989800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009B9B9B00989898009C9C9C00A4A4A400A8A8A800A9A9A900A9A9A900A8A8
      A800A8A8A800A9A9A900A9A9A900A8A8A800A5A5A5009D9D9D00979797009797
      9700000000000000000000000000000000000000000000000000000000000000
      0000989898009595950099999900A1A1A100A5A5A500A7A7A700A6A6A600A5A5
      A500A5A5A500A6A6A600A7A7A700A5A5A500A2A2A2009B9B9B00959595009595
      9500000000000000000000000000000000000000000000000000000000009191
      9100DDDDDD00E0E0E000DBDBDB00D8D8D800D4D4D400D1D1D100CECECE00CBCB
      CB00C7C7C700C4C4C400C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200C3C3
      C300C1C1C1009797970000000000000000000000000000000000000000000000
      00009C9C9C00999999009D9D9D00A5A5A500A9A9A900AAAAAA00A9A9A900A9A9
      A900A9A9A900A9A9A900AAAAAA00A9A9A900A6A6A6009E9E9E00989898009898
      9800000000000000000000000000000000000000000000000000000000009B9B
      9B009B9B9B00A1A1A100A9A9A900A9A9A900A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700A8A8A800AAAAAA00A2A2A2009898
      9800979797000000000000000000000000000000000000000000000000009898
      9800989898009F9F9F00A7A7A700A6A6A600A4A4A400A4A4A400A3A3A300A4A4
      A400A4A4A400A4A4A400A4A4A400A4A4A400A5A5A500A8A8A8009F9F9F009595
      9500959595000000000000000000000000000000000000000000000000009191
      9100E0E0E000E3E3E300DEDEDE00DBDBDB00D8D8D800D5D5D500D1D1D100CECE
      CE00CBCBCB00C8C8C800C4C4C400C2C2C200C2C2C200C2C2C200C2C2C200C3C3
      C300C1C1C1009797970000000000000000000000000000000000000000009C9C
      9C009C9C9C00A2A2A200AAAAAA00A9A9A900A8A8A800A7A7A700A6A6A600A8A8
      A800A8A8A800A8A8A800A8A8A800A7A7A700A9A9A900ABABAB00A3A3A3009999
      99009898980000000000000000000000000000000000000000009B9B9B009B9B
      9B00A3A3A300AAAAAA00A7A7A700A6A6A600A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700AAAAAA00A3A3
      A300989898009797970000000000000000000000000000000000989898009999
      9900A0A0A000A7A7A700A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A8A8A800A0A0
      A000969696009595950000000000000000000000000000000000000000009191
      9100E2E2E200E6E6E600BCBCBC00B5B5B500AFAFAF00A8A8A800A2A2A2009B9B
      9B00949494008E8E8E008989890084848400808080007F7F7F007F7F7F00C3C3
      C300C1C1C10097979700000000000000000000000000000000009C9C9C009C9C
      9C00A3A3A300ABABAB00A8A8A800A6A6A600AEAEAE00BABABA00B1B1B100A6A6
      A600A7A7A700A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800ABABAB00A3A3
      A3009999990098989800000000000000000000000000000000009D9D9D00A2A2
      A200A9A9A900A7A7A700A6A6A600A6A6A600A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A700A6A6A600A7A7A700A7A7A700A7A7A700A7A7A700A6A6A600AAAA
      AA00A2A2A20097979700000000000000000000000000000000009A9A9A009F9F
      9F00A7A7A700A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A8A8
      A8009F9F9F009595950000000000000000000000000000000000000000009292
      9200E6E6E600EAEAEA00C3C3C300BEBEBE00B8B8B800B2B2B200ABABAB00A4A4
      A4009D9D9D0097979700919191008B8B8B0086868600818181007F7F7F00C3C3
      C300C1C1C10097979700000000000000000000000000000000009D9D9D00A3A3
      A300AAAAAA00A8A8A800A8A8A800A6A6A600B3B3B300EBEBEB00E8E8E800B4B4
      B400A6A6A600A7A7A700A8A8A800A8A8A800A8A8A800A8A8A800A7A7A700ABAB
      AB00A3A3A300989898000000000000000000000000009B9B9B00A0A0A000A8A8
      A800A7A7A700A7A7A700AAAAAA00A9A9A900A6A6A600A7A7A700A7A7A700A7A7
      A700A9A9A900AAAAAA00A6A6A600A6A6A600A7A7A700A7A7A700A7A7A700A7A7
      A700AAAAAA009D9D9D00979797000000000000000000989898009E9E9E00A5A5
      A500A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4A400A4A4
      A400A7A7A7009B9B9B0095959500000000000000000000000000000000009292
      9200E9E9E900EDEDED00C8C8C800C4C4C400BFBFBF00B9B9B900B3B3B300ADAD
      AD00A6A6A6009F9F9F0098989800929292008D8D8D008787870082828200C3C3
      C300C1C1C100979797000000000000000000000000009C9C9C00A1A1A100A9A9
      A900A8A8A800A8A8A800A8A8A800A6A6A600AFAFAF00E7E7E700FFFFFF00F0F0
      F000BABABA00A6A6A600A7A7A700A8A8A800A8A8A800A8A8A800A8A8A800A8A8
      A800ABABAB009E9E9E009898980000000000000000009F9F9F00A5A5A500A9A9
      A900A8A8A800AAAAAA00C4C4C400CECECE00ABABAB00A6A6A600A7A7A700A6A6
      A600B3B3B300CECECE00BABABA00A6A6A600A6A6A600A7A7A700A7A7A700A6A6
      A600A9A9A900A4A4A4009797970000000000000000009C9C9C00A2A2A200A7A7
      A700A7A7A700A7A7A700A8A8A800C2C2C200D8D8D800A8A8A800A5A5A500A4A4
      A400A4A4A400A4A4A400FFFFFF00FFFFFF00A4A4A400A4A4A400A4A4A400A4A4
      A400A6A6A600A1A1A10095959500000000000000000000000000000000009595
      9500ECECEC00F0F0F000C9C9C900C8C8C800C5C5C500C0C0C000BABABA00B5B5
      B500AFAFAF00A8A8A800A1A1A1009A9A9A00949494008E8E8E0088888800C3C3
      C300C1C1C10097979700000000000000000000000000A0A0A000A6A6A600AAAA
      AA00AAAAAA00ABABAB00ABABAB00A8A8A800B1B1B100E7E7E700FFFFFF00FFFF
      FF00F3F3F300C1C1C100A9A9A900A7A7A700A8A8A800A8A8A800A8A8A800A8A8
      A800A9A9A900A5A5A5009898980000000000A2A2A200A1A1A100AAAAAA00ADAD
      AD00AFAFAF00AFAFAF00D7D7D700FFFFFF00D7D7D700B0B0B000A7A7A700A6A6
      A600B2B2B200F5F5F500F4F4F400C0C0C000A6A6A600A6A6A600A7A7A700A7A7
      A700A7A7A700A9A9A9009B9B9B00979797009F9F9F009F9F9F00A8A8A800ABAB
      AB00ACACAC00AEAEAE00AEAEAE00C6C6C600FFFFFF00E3E3E300AFAFAF00A7A7
      A700A5A5A500A4A4A400FFFFFF00FFFFFF00A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A6A6A60099999900959595000000000000000000000000009898
      9800EFEFEF00F4F4F400C5C5C500C6C6C600C6C6C600C4C4C400C1C1C100BCBC
      BC00B6B6B600B0B0B000A9A9A900A3A3A3009C9C9C00959595008F8F8F00C4C4
      C400C1C1C100979797000000000000000000A3A3A300A2A2A200ABABAB00AEAE
      AE00AFAFAF00B1B1B100B2B2B200AEAEAE00B5B5B500E9E9E900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00D1D1D100ACACAC00A6A6A600A7A7A700A8A8A800A8A8
      A800A8A8A800A9A9A9009C9C9C0098989800A2A2A200A6A6A600B1B1B100B3B3
      B300B4B4B400B5B5B500D6D6D600FFFFFF00FFFFFF00E5E5E500BBBBBB00A7A7
      A700B2B2B200EDEDED00FFFFFF00F9F9F900CACACA00A9A9A900A6A6A600A7A7
      A700A7A7A700A9A9A900A0A0A000979797009F9F9F00A4A4A400AEAEAE00B0B0
      B000B2B2B200B4B4B400B4B4B400CACACA00FFFFFF00FFFFFF00EDEDED00B9B9
      B900A9A9A900A5A5A500FFFFFF00FFFFFF00A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A7A7A7009D9D9D00959595000000000000000000000000009B9B
      9B00F3F3F300F7F7F700B5B5B500BEBEBE00BABABA00C0C0C000C6C6C600BFBF
      BF00BABABA00B5B5B500AFAFAF00A8A8A800A2A2A2009C9C9C0096969600C7C7
      C700C2C2C200979797000000000000000000A3A3A300A7A7A700B2B2B200B4B4
      B400B5B5B500B7B7B700B8B8B800B4B4B400BBBBBB00EBEBEB00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DEDEDE00B1B1B100A6A6A600A7A7A700A8A8
      A800A8A8A800AAAAAA00A0A0A00098989800A2A2A200ABABAB00B8B8B800BABA
      BA00BABABA00BBBBBB00D9D9D900FFFFFF00FFFFFF00FFFFFF00F1F1F100BEBE
      BE00B2B2B200EDEDED00FFFFFF00FFFFFF00FFFFFF00D5D5D500ABABAB00A6A6
      A600A7A7A700A9A9A900A2A2A200979797009F9F9F00A8A8A800B6B6B600B7B7
      B700B8B8B800B9B9B900BABABA00CECECE00FFFFFF00FFFFFF00FFFFFF00F8F8
      F800C9C9C900AAAAAA00FFFFFF00FFFFFF00A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A6A6A6009F9F9F00959595000000000000000000000000009E9E
      9E00F7F7F700FBFBFB0082828200878787008C8C8C00929292009C9C9C00ACAC
      AC00BABABA00B2B2B200B0B0B000ACACAC00A9A9A900A0A0A0009C9C9C00CBCB
      CB00C6C6C600979797000000000000000000A3A3A300ACACAC00B9B9B900BBBB
      BB00BBBBBB00BDBDBD00BEBEBE00BABABA00C0C0C000EDEDED00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E5E5E500B7B7B700A8A8A800A8A8
      A800A8A8A800A9A9A900A3A3A30098989800A2A2A200B0B0B000C2C2C200C4C4
      C400BFBFBF00C1C1C100DCDCDC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4F4
      F400D3D3D300EFEFEF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E2E2E200B3B3
      B300A6A6A600A9A9A900A3A3A300979797009F9F9F00AEAEAE00C0C0C000C2C2
      C200BEBEBE00BFBFBF00C0C0C000D4D4D400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D6D6D600FFFFFF00FFFFFF00A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A6A6A600A0A0A00095959500000000000000000000000000A0A0
      A000F9F9F900FEFEFE007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F008585
      85008B8B8B008E8E8E008E8E8E008E8E8E009B9B9B00B0B0B000AAAAAA00CECE
      CE00C9C9C900989898000000000000000000A3A3A300B1B1B100C3C3C300C5C5
      C500C1C1C100C3C3C300C4C4C400C0C0C000C6C6C600EEEEEE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3F3F300B8B8B800A7A7
      A700A7A7A700A9A9A900A3A3A30098989800A3A3A300B6B6B600CECECE00D2D2
      D200C8C8C800C7C7C700E0E0E000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E6E6E600F1F1F100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBFBFB00B9B9
      B900A6A6A600A9A9A900A3A3A30097979700A0A0A000B3B3B300CBCBCB00CFCF
      CF00C6C6C600C5C5C500C6C6C600D8D8D800FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00DADADA00FFFFFF00FFFFFF00A4A4A400A4A4A400A4A4A400A4A4
      A400A4A4A400A6A6A600A0A0A00095959500000000000000000000000000A3A3
      A300F9F9F900FFFFFF0069696900646464006565650066666600636363006464
      640063636300696969006767670065656500646464006A6A6A0072727200D1D1
      D100CCCCCC00999999000000000000000000A3A3A300B7B7B700CFCFCF00D3D3
      D300C9C9C900C9C9C900CACACA00C7C7C700CCCCCC00F0F0F000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EBEBEB00B7B7B700A7A7
      A700A7A7A700A9A9A900A3A3A30098989800A2A2A200B6B6B600D5D5D500DEDE
      DE00D0D0D000CCCCCC00E3E3E300FFFFFF00FFFFFF00FFFFFF00FFFFFF00DFDF
      DF00C5C5C500EFEFEF00FFFFFF00FFFFFF00FFFFFF00F1F1F100C0C0C000A9A9
      A900A7A7A700A9A9A900A2A2A200979797009F9F9F00B3B3B300D2D2D200DBDB
      DB00CECECE00CBCBCB00CCCCCC00DCDCDC00FFFFFF00FFFFFF00FFFFFF00F8F8
      F800D1D1D100B5B5B500FFFFFF00FFFFFF00A5A5A500A4A4A400A4A4A400A4A4
      A400A4A4A400A6A6A6009F9F9F0095959500000000000000000000000000A6A6
      A600F9F9F900FFFFFF005E5E5E005D5D5D006565650068686800606060005E5E
      5E006262620063636300666666006161610055555500575757005F5F5F00D5D5
      D500CFCFCF00989898000000000000000000A3A3A300B7B7B700D6D6D600DFDF
      DF00D2D2D200CECECE00CFCFCF00CDCDCD00D0D0D000F2F2F200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D9D9D900AFAFAF00A6A6A600A7A7
      A700A8A8A800A9A9A900A3A3A30098989800A2A2A200B2B2B200D7D7D700E8E8
      E800DDDDDD00D1D1D100E7E7E700FFFFFF00FFFFFF00FBFBFB00E1E1E100C0C0
      C000C1C1C100F1F1F100FFFFFF00FFFFFF00E5E5E500B9B9B900A6A6A600A6A6
      A600A7A7A700A9A9A900A0A0A000979797009F9F9F00AFAFAF00D4D4D400E5E5
      E500DBDBDB00D1D1D100D1D1D100E0E0E000FFFFFF00FFFFFF00F3F3F300CBCB
      CB00BCBCBC00B7B7B700FFFFFF00FFFFFF00A6A6A600A4A4A400A4A4A400A4A4
      A400A4A4A400A7A7A7009D9D9D0095959500000000000000000000000000A9A9
      A900F9F9F900FFFFFF0092929200848484007D7D7D00797979007E7E7E007D7D
      7D007C7C7C0099999900B7B7B700B6B6B600999999008787870084848400D6D6
      D600C0C0C0008E8E8E000000000000000000A3A3A300B2B2B200D8D8D800E8E8
      E800DEDEDE00D4D4D400D5D5D500D2D2D200D5D5D500F3F3F300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D7D7D700ABABAB00A6A6A600A7A7A700A8A8
      A800A8A8A800AAAAAA00A0A0A00098989800A2A2A200AAAAAA00D2D2D200EBEB
      EB00ECECEC00DCDCDC00EBEBEB00FFFFFF00F9F9F900DDDDDD00CACACA00C1C1
      C100C7C7C700F5F5F500FFFFFF00DDDDDD00B0B0B000A6A6A600A7A7A700A7A7
      A700A7A7A700A8A8A8009B9B9B00979797009F9F9F00A8A8A800CFCFCF00E9E9
      E900EAEAEA00DBDBDB00D7D7D700E4E4E400FFFFFF00F0F0F000CDCDCD00C5C5
      C500BFBFBF00B9B9B900FFFFFF00FFFFFF00A7A7A700A4A4A400A4A4A400A4A4
      A400A4A4A400A5A5A5009898980095959500000000000000000000000000ABAB
      AB00F9F9F900FFFFFF00CFCFCF00C5C5C500BEBEBE00ACACAC00848484008686
      8600B4B4B400D5D5D500DBDBDB00DBDBDB00D3D3D300C8C8C800C3C3C300BEBE
      BE00A6A6A6008A8A8A000000000000000000A3A3A300ABABAB00D3D3D300ECEC
      EC00EDEDED00DEDEDE00DBDBDB00D8D8D800DADADA00F5F5F500FFFFFF00FFFF
      FF00FFFFFF00F7F7F700D0D0D000AEAEAE00A8A8A800A8A8A800A8A8A800A8A8
      A800A8A8A800A9A9A9009C9C9C009898980000000000A6A6A600C3C3C300E7E7
      E700F5F5F500ECECEC00F1F1F100FAFAFA00DEDEDE00D1D1D100CECECE00C5C5
      C500CCCCCC00EFEFEF00D9D9D900B0B0B000A7A7A700A7A7A700A7A7A700A6A6
      A600A9A9A900A4A4A400979797000000000000000000A3A3A300C0C0C000E4E4
      E400F3F3F300EAEAEA00E0E0E000E6E6E600EFEFEF00D2D2D200CCCCCC00C6C6
      C600C0C0C000BABABA00FFFFFF00FFFFFF00A8A8A800A4A4A400A4A4A400A4A4
      A400A6A6A600A1A1A1009595950000000000000000000000000000000000AEAE
      AE00F9F9F900FFFFFF00DADADA00DADADA00DBDBDB00D8D8D800CDCDCD00CECE
      CE00DADADA00DADADA00DADADA00DADADA00DADADA00DBDBDB00DADADA00AEAE
      AE00AAAAAA008D8D8D00000000000000000000000000A6A6A600C4C4C400E8E8
      E800F6F6F600EDEDED00E4E4E400DEDEDE00DDDDDD00F5F5F500FFFFFF00FFFF
      FF00EFEFEF00C7C7C700B4B4B400B0B0B000ABABAB00A8A8A800A8A8A800A8A8
      A800A9A9A900A5A5A500989898000000000000000000A2A2A200B0B0B000DCDC
      DC00F2F2F200F9F9F900F1F1F100E6E6E600D8D8D800D4D4D400CFCFCF00C7C7
      C700C7C7C700C8C8C800B8B8B800AFAFAF00AAAAAA00A7A7A700A7A7A700A7A7
      A700AAAAAA009D9D9D009797970000000000000000009F9F9F00ADADAD00DADA
      DA00F0F0F000F6F6F600ECECEC00DEDEDE00DADADA00D2D2D200CCCCCC00C6C6
      C600C0C0C000BABABA00B4B4B400AEAEAE00A8A8A800A4A4A400A4A4A400A4A4
      A400A7A7A7009A9A9A009595950000000000000000000000000000000000B1B1
      B100F9F9F900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFD
      FD00F8F8F800F5F5F500F3F3F300DFDFDF009494940091919100909090009090
      90009090900090909000000000000000000000000000A3A3A300B1B1B100DDDD
      DD00F3F3F300F9F9F900F0F0F000E2E2E200DDDDDD00F7F7F700FFFFFF00EEEE
      EE00C8C8C800BABABA00B7B7B700B2B2B200ABABAB00A8A8A800A8A8A800A8A8
      A800ABABAB009D9D9D0098989800000000000000000000000000A6A6A600BFBF
      BF00E7E7E700F7F7F700FAFAFA00EEEEEE00DFDFDF00D4D4D400CDCDCD00C8C8
      C800C2C2C200BABABA00B5B5B500B0B0B000AAAAAA00A7A7A700A7A7A700AAAA
      AA00A1A1A1009797970000000000000000000000000000000000A3A3A300BCBC
      BC00E4E4E400F5F5F500F8F8F800EBEBEB00E0E0E000D0D0D000CBCBCB00C5C5
      C500BFBFBF00B9B9B900B4B4B400AEAEAE00A7A7A700A4A4A400A4A4A400A8A8
      A8009E9E9E00959595000000000000000000000000000000000000000000B3B3
      B300FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FDFDFD00F8F8F800F9F9F900D4D4D40094949400B4B4B400A7A7A7009E9E
      9E00949494009D9D9D0000000000000000000000000000000000A6A6A600C0C0
      C000E8E8E800F9F9F900FCFCFC00EEEEEE00E4E4E400F3F3F300EAEAEA00CACA
      CA00C0C0C000BDBDBD00B7B7B700B1B1B100ABABAB00A8A8A800A8A8A800ABAB
      AB00A2A2A2009898980000000000000000000000000000000000A2A2A200A7A7
      A700C2C2C200E8E8E800F6F6F600FBFBFB00F2F2F200E4E4E400D7D7D700CDCD
      CD00C4C4C400BEBEBE00BBBBBB00B8B8B800B3B3B300ADADAD00AAAAAA00A1A1
      A100989898009D9D9D00000000000000000000000000000000009F9F9F00A4A4
      A400C0C0C000E5E5E500F3F3F300F8F8F800F0F0F000E6E6E600D6D6D600C8C8
      C800C2C2C200BCBCBC00B9B9B900B6B6B600B1B1B100ABABAB00A8A8A8009F9F
      9F00959595009B9B9B000000000000000000000000000000000000000000B6B6
      B600FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FDFDFD00FCFCFC00D8D8D80094949400BEBEBE00B0B0B000A4A4
      A4009D9D9D000000000000000000000000000000000000000000A3A3A300A8A8
      A800C3C3C300E8E8E800F7F7F700FCFCFC00F3F3F300E9E9E900D9D9D900CCCC
      CC00C5C5C500C0C0C000BCBCBC00B9B9B900B4B4B400AEAEAE00ABABAB00A2A2
      A200999999009E9E9E000000000000000000000000000000000000000000A2A2
      A200A6A6A600C0C0C000E0E0E000EFEFEF00F7F7F700F7F7F700F1F1F100E8E8
      E800E1E1E100DADADA00D6D6D600CDCDCD00BFBFBF00B0B0B000A1A1A1009898
      98009D9D9D000000000000000000000000000000000000000000000000009F9F
      9F00A4A4A400BDBDBD00DDDDDD00ECECEC00F4F4F400F4F4F400EFEFEF00E6E6
      E600DEDEDE00D8D8D800D4D4D400CACACA00BCBCBC00AEAEAE009F9F9F009696
      96009B9B9B00000000000000000000000000000000000000000000000000B6B6
      B600FAFAFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DADADA0094949400BDBDBD00AFAFAF009D9D
      9D0000000000000000000000000000000000000000000000000000000000A3A3
      A300A7A7A700C1C1C100E1E1E100F0F0F000F7F7F700F7F7F700F2F2F200E9E9
      E900E2E2E200DBDBDB00D7D7D700CDCDCD00C0C0C000B1B1B100A2A2A2009999
      99009E9E9E000000000000000000000000000000000000000000000000000000
      0000A2A2A200A5A5A500B0B0B000C8C8C800DCDCDC00E6E6E600EBEBEB00EBEB
      EB00E8E8E800DFDFDF00D3D3D300C2C2C200AEAEAE00A0A0A0009A9A9A009D9D
      9D00000000000000000000000000000000000000000000000000000000000000
      00009F9F9F00A2A2A200AEAEAE00C6C6C600DADADA00E3E3E300E9E9E900E9E9
      E900E4E4E400DDDDDD00D1D1D100BFBFBF00ABABAB009E9E9E00979797009B9B
      9B0000000000000000000000000000000000000000000000000000000000B6B6
      B600FEFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E1E1E10094949400BEBEBE009D9D9D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A3A3A300A6A6A600B1B1B100C9C9C900DDDDDD00E7E7E700ECECEC00ECEC
      EC00E8E8E800E0E0E000D4D4D400C3C3C300AFAFAF00A1A1A1009A9A9A009E9E
      9E00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A2A2A200A5A5A500ADADAD00B8B8B800C1C1C100C4C4
      C400C1C1C100BABABA00AFAFAF00A4A4A4009D9D9D009D9D9D00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009F9F9F00A2A2A200AAAAAA00B5B5B500BEBEBE00C1C1
      C100BFBFBF00B7B7B700ACACAC00A1A1A1009B9B9B009B9B9B00000000000000
      000000000000000000000000000000000000000000000000000000000000AEAE
      AE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00AEAE
      AE00AEAEAE00AEAEAE00AEAEAE00AEAEAE00949494009D9D9D00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A3A3A300A6A6A600AEAEAE00B8B8B800C1C1C100C4C4
      C400C2C2C200BBBBBB00AFAFAF00A5A5A5009E9E9E009E9E9E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A2A2A200A2A2A200A2A2A200A1A1
      A100A0A0A000A2A2A200A2A2A200A2A2A2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009F9F9F009F9F9F009F9F9F009F9F
      9F009D9D9D009F9F9F009F9F9F009F9F9F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A3A3A300A3A3A300A3A3A300A2A2
      A200A0A0A000A3A3A300A3A3A300A3A3A3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009696960096969600969696009696
      9600969696009696960096969600969696000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009797970097979700979797009797
      9700979797009797970097979700979797000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009696960096969600969696009696
      9600969696009696960096969600969696000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009797970097979700979797009797
      9700979797009797970097979700979797000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000096969600969696009A9A9A009E9E9E00A1A1A100A2A2
      A200A2A2A200A1A1A1009E9E9E009A9A9A009696960096969600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000097979700979797009A9A9A009F9F9F00A2A2A200A2A2
      A200A2A2A200A2A2A2009F9F9F009A9A9A009797970097979700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000096969600969696009A9A9A009E9E9E00A1A1A100A1A1
      A100A1A1A100A1A1A1009E9E9E009A9A9A009696960096969600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000097979700979797009B9B9B009F9F9F00A2A2A200A3A3
      A300A3A3A300A2A2A2009F9F9F009B9B9B009797970097979700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009A9A9A00979797009B9B9B00A3A3A300A7A7A700A8A8A800A8A8A800A7A7
      A700A7A7A700A8A8A800A8A8A800A7A7A700A4A4A4009C9C9C00969696009696
      9600000000000000000000000000000000000000000000000000000000000000
      00009A9A9A00979797009C9C9C00A3A3A300A8A8A800A9A9A900A8A8A800A8A8
      A800A8A8A800A8A8A800A9A9A900A8A8A800A5A5A5009D9D9D00979797009797
      9700000000000000000000000000000000000000000000000000000000000000
      00009A9A9A00979797009B9B9B00A3A3A300A7A7A700A8A8A800A7A7A700A7A7
      A700A7A7A700A7A7A700A8A8A800A7A7A700A4A4A4009C9C9C00969696009696
      9600000000000000000000000000000000000000000000000000000000000000
      00009B9B9B00989898009C9C9C00A4A4A400A8A8A800A9A9A900A9A9A900A8A8
      A800A8A8A800A9A9A900A9A9A900A8A8A800A5A5A5009D9D9D00979797009797
      9700000000000000000000000000000000000000000000000000000000009A9A
      9A009A9A9A00A1A1A100A8A8A800A8A8A800A6A6A600A5A5A500A5A5A500A6A6
      A600A6A6A600A6A6A600A6A6A600A5A5A500A7A7A700AAAAAA00A1A1A1009797
      9700969696000000000000000000000000000000000000000000000000009A9A
      9A009A9A9A00A1A1A100A9A9A900A8A8A800A6A6A600A6A6A600A5A5A500A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A8A8A800AAAAAA00A2A2A2009797
      9700979797000000000000000000000000000000000000000000000000009A9A
      9A009A9A9A00A0A0A000A8A8A800A7A7A700A6A6A600A5A5A500A4A4A400A6A6
      A600A6A6A600A6A6A600A6A6A600A5A5A500A7A7A700A9A9A900A1A1A1009797
      9700969696000000000000000000000000000000000000000000000000009B9B
      9B009B9B9B00A1A1A100A9A9A900A9A9A900A7A7A700A6A6A600A6A6A600A7A7
      A700A7A7A700A7A7A700A7A7A700A6A6A600A8A8A800AAAAAA00A2A2A2009898
      98009797970000000000000000000000000000000000000000009A9A9A009B9B
      9B00A2A2A200A9A9A900A6A6A600A5A5A500A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A5A5A500AAAAAA00A2A2
      A2009898980096969600000000000000000000000000000000009A9A9A009B9B
      9B00A2A2A200A9A9A900A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600AAAAAA00A2A2
      A2009898980097979700000000000000000000000000000000009A9A9A009A9A
      9A00A1A1A100A9A9A900A6A6A600A5A5A500A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A5A5A500A9A9A900A1A1
      A1009797970096969600000000000000000000000000000000009B9B9B009B9B
      9B00A3A3A300AAAAAA00A7A7A700A6A6A600A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A6A6A600AAAAAA00A3A3
      A3009898980097979700000000000000000000000000000000009C9C9C00A1A1
      A100A8A8A800A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A5A5A500AAAA
      AA00A1A1A10096969600000000000000000000000000000000009C9C9C00A2A2
      A200A9A9A900A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600AAAA
      AA00A2A2A20097979700000000000000000000000000000000009B9B9B00A1A1
      A100A8A8A800A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A5A5A500A9A9
      A900A1A1A10096969600000000000000000000000000000000009D9D9D00A2A2
      A200A9A9A900A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A6A6A600AAAA
      AA00A2A2A200979797000000000000000000000000009A9A9A009F9F9F00A7A7
      A700A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A5A5A500A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6
      A600A9A9A9009C9C9C009696960000000000000000009A9A9A00A0A0A000A8A8
      A800A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6
      A600A9A9A9009D9D9D009797970000000000000000009A9A9A009F9F9F00A7A7
      A700A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A5A5A500A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6
      A600A9A9A9009C9C9C009696960000000000000000009B9B9B00A0A0A000A8A8
      A800A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A6A6A600A7A7
      A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7A700A7A7
      A700AAAAAA009D9D9D009797970000000000000000009E9E9E00A4A4A400A8A8
      A800A8A8A800A9A9A900AAAAAA00A7A7A700FFFFFF00FFFFFF00FFFFFF00A5A5
      A500A6A6A600FFFFFF00FFFFFF00FFFFFF00A6A6A600A6A6A600A6A6A600A5A5
      A500A8A8A800A3A3A3009696960000000000000000009F9F9F00A5A5A500A9A9
      A900A9A9A900A9A9A900AAAAAA00A7A7A700A9A9A900A8A8A800A7A7A700A6A6
      A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6A600A6A6
      A600A8A8A800A3A3A3009797970000000000000000009E9E9E00A4A4A400A8A8
      A800A8A8A800A9A9A900A9A9A900A6A6A600FFFFFF00FFFFFF00A6A6A600A5A5
      A500A6A6A600A6A6A600A7A7A700D9D9D900C3C3C300A6A6A600A6A6A600A5A5
      A500A7A7A700A3A3A3009696960000000000000000009F9F9F00A5A5A500A9A9
      A900A9A9A900AAAAAA00AAAAAA00A7A7A700A9A9A900AAAAAA00DADADA00C4C4
      C400A7A7A700A7A7A700A7A7A700A7A7A700A9A9A900DADADA00C4C4C400A6A6
      A600A9A9A900A4A4A4009797970000000000A1A1A100A1A1A100AAAAAA00ADAD
      AD00AEAEAE00B0B0B000B0B0B000ADADAD00FFFFFF00FFFFFF00FFFFFF00A9A9
      A900A7A7A700FFFFFF00FFFFFF00FFFFFF00A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A8A8A8009B9B9B0096969600A2A2A200A1A1A100AAAAAA00ADAD
      AD00AEAEAE00B0B0B000B1B1B100ADADAD00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A8A8A8009B9B9B0097979700A1A1A100A0A0A000A9A9A900ACAC
      AC00ADADAD00AFAFAF00B0B0B000ACACAC00FFFFFF00FFFFFF00ACACAC00A9A9
      A900A6A6A600AAAAAA00E2E2E200FFFFFF00C4C4C400A6A6A600A6A6A600A6A6
      A600A6A6A600A7A7A7009A9A9A0096969600A2A2A200A1A1A100AAAAAA00ADAD
      AD00AFAFAF00B0B0B000B1B1B100ADADAD00B5B5B500E6E6E600FFFFFF00C7C7
      C700A7A7A700A7A7A700A7A7A700ACACAC00E3E3E300FFFFFF00C5C5C500A7A7
      A700A7A7A700A9A9A9009B9B9B0097979700A1A1A100A5A5A500B0B0B000B2B2
      B200B4B4B400B6B6B600B6B6B600B3B3B300FFFFFF00FFFFFF00FFFFFF00AEAE
      AE00ABABAB00FFFFFF00FFFFFF00FFFFFF00A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A8A8A8009F9F9F0096969600A2A2A200A6A6A600B1B1B100B2B2
      B200B4B4B400B6B6B600B7B7B700B3B3B300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A9A9A9009F9F9F0097979700A1A1A100A5A5A500B0B0B000B2B2
      B200B3B3B300B5B5B500B6B6B600B2B2B200FFFFFF00FFFFFF00B1B1B100AEAE
      AE00B7B7B700ECECEC00FFFFFF00FFFFFF00C2C2C200A6A6A600A6A6A600A6A6
      A600A6A6A600A8A8A8009E9E9E0096969600A2A2A200A6A6A600B1B1B100B3B3
      B300B5B5B500B6B6B600B7B7B700BFBFBF00F1F1F100FFFFFF00FFFFFF00CACA
      CA00ACACAC00A8A8A800B4B4B400EDEDED00FFFFFF00FFFFFF00C4C4C400A7A7
      A700A7A7A700A9A9A900A0A0A00097979700A1A1A100AAAAAA00B7B7B700B9B9
      B900BABABA00BBBBBB00BCBCBC00B9B9B900FFFFFF00FFFFFF00FFFFFF00B3B3
      B300B0B0B000FFFFFF00FFFFFF00FFFFFF00A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A8A8A800A1A1A10096969600A2A2A200ABABAB00B8B8B800BABA
      BA00BABABA00BBBBBB00BDBDBD00B9B9B900FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A8A8A800A2A2A20097979700A1A1A100AAAAAA00B7B7B700B9B9
      B900B9B9B900BBBBBB00BCBCBC00B8B8B800FFFFFF00FFFFFF00B6B6B600CDCD
      CD00F8F8F800FFFFFF00FFFFFF00FFFFFF00C2C2C200A6A6A600A6A6A600A6A6
      A600A6A6A600A7A7A700A1A1A10096969600A2A2A200ABABAB00B8B8B800BABA
      BA00BBBBBB00BCBCBC00D4D4D400FAFAFA00FFFFFF00FFFFFF00FFFFFF00CDCD
      CD00B0B0B000C8C8C800F8F8F800FFFFFF00FFFFFF00FFFFFF00C4C4C400A7A7
      A700A7A7A700A9A9A900A2A2A20097979700A1A1A100B0B0B000C2C2C200C3C3
      C300C0C0C000C1C1C100C2C2C200C2C2C200FFFFFF00FFFFFF00FFFFFF00B8B8
      B800B4B4B400FFFFFF00FFFFFF00FFFFFF00A6A6A600A6A6A600A6A6A600A6A6
      A600A5A5A500A8A8A800A2A2A20096969600A2A2A200B0B0B000C2C2C200C4C4
      C400C0C0C000C1C1C100C3C3C300C2C2C200FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A8A8A800A2A2A20097979700A1A1A100AFAFAF00C1C1C100C3C3
      C300BFBFBF00C1C1C100C2C2C200C1C1C100FFFFFF00FFFFFF00DDDDDD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C2C2C200A6A6A600A6A6A600A6A6
      A600A5A5A500A7A7A700A1A1A10096969600A2A2A200B0B0B000C2C2C200C4C4
      C400C1C1C100E2E2E200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D0D0
      D000DBDBDB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C4C4C400A7A7
      A700A6A6A600A9A9A900A3A3A30097979700A2A2A200B5B5B500CDCDCD00D1D1
      D100C8C8C800C7C7C700C8C8C800C8C8C800FFFFFF00FFFFFF00FFFFFF00BDBD
      BD00B8B8B800FFFFFF00FFFFFF00FFFFFF00A6A6A600A6A6A600A6A6A600A6A6
      A600A5A5A500A8A8A800A2A2A20096969600A2A2A200B5B5B500CDCDCD00D2D2
      D200C8C8C800C7C7C700C9C9C900C8C8C800FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A6A6A600A6A6A600A6A6A600A6A6
      A600A6A6A600A8A8A800A2A2A20097979700A1A1A100B5B5B500CDCDCD00D1D1
      D100C7C7C700C7C7C700C8C8C800C7C7C700FFFFFF00FFFFFF00E2E2E200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C2C2C200A6A6A600A6A6A600A6A6
      A600A5A5A500A7A7A700A1A1A10096969600A3A3A300B6B6B600CECECE00D2D2
      D200C8C8C800E6E6E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D3D3
      D300DFDFDF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C4C4C400A7A7
      A700A6A6A600A9A9A900A3A3A30097979700A1A1A100B5B5B500D4D4D400DDDD
      DD00D0D0D000CCCCCC00CECECE00CECECE00FFFFFF00FFFFFF00FFFFFF00C0C0
      C000BCBCBC00FFFFFF00FFFFFF00FFFFFF00A7A7A700A6A6A600A6A6A600A6A6
      A600A6A6A600A8A8A800A1A1A10096969600A2A2A200B5B5B500D5D5D500DEDE
      DE00D0D0D000CDCDCD00CECECE00CECECE00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A7A7A700A6A6A600A6A6A600A6A6
      A600A6A6A600A8A8A800A2A2A20097979700A1A1A100B5B5B500D4D4D400DDDD
      DD00D0D0D000CCCCCC00CDCDCD00CDCDCD00FFFFFF00FFFFFF00C5C5C500D5D5
      D500F9F9F900FFFFFF00FFFFFF00FFFFFF00C3C3C300A6A6A600A6A6A600A6A6
      A600A6A6A600A7A7A700A1A1A10096969600A2A2A200B6B6B600D5D5D500DEDE
      DE00D1D1D100CDCDCD00DFDFDF00FDFDFD00FFFFFF00FFFFFF00FFFFFF00D6D6
      D600BCBCBC00D0D0D000F9F9F900FFFFFF00FFFFFF00FFFFFF00C4C4C400A7A7
      A700A7A7A700A9A9A900A2A2A20097979700A1A1A100B1B1B100D6D6D600E7E7
      E700DDDDDD00D2D2D200D3D3D300D3D3D300FFFFFF00FFFFFF00FFFFFF00C4C4
      C400BEBEBE00FFFFFF00FFFFFF00FFFFFF00A8A8A800A6A6A600A6A6A600A6A6
      A600A6A6A600A8A8A8009F9F9F0096969600A2A2A200B1B1B100D6D6D600E7E7
      E700DDDDDD00D3D3D300D3D3D300D3D3D300FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A8A8A800A6A6A600A6A6A600A6A6
      A600A6A6A600A9A9A9009F9F9F0097979700A1A1A100B0B0B000D6D6D600E6E6
      E600DCDCDC00D2D2D200D3D3D300D3D3D300FFFFFF00FFFFFF00C8C8C800C4C4
      C400C7C7C700F1F1F100FFFFFF00FFFFFF00C4C4C400A6A6A600A6A6A600A6A6
      A600A6A6A600A8A8A8009E9E9E0096969600A2A2A200B2B2B200D7D7D700E8E8
      E800DDDDDD00D3D3D300D4D4D400DBDBDB00F8F8F800FFFFFF00FFFFFF00D8D8
      D800BFBFBF00B9B9B900C0C0C000F0F0F000FFFFFF00FFFFFF00C4C4C400A7A7
      A700A7A7A700A9A9A900A0A0A00097979700A1A1A100AAAAAA00D1D1D100EAEA
      EA00ECECEC00DDDDDD00D9D9D900D9D9D900FFFFFF00FFFFFF00FFFFFF00C6C6
      C600C0C0C000FFFFFF00FFFFFF00FFFFFF00A9A9A900A6A6A600A6A6A600A6A6
      A600A6A6A600A7A7A7009A9A9A0096969600A2A2A200AAAAAA00D2D2D200EBEB
      EB00ECECEC00DDDDDD00D9D9D900D9D9D900FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A9A9A900A6A6A600A6A6A600A6A6
      A600A6A6A600A8A8A8009A9A9A0097979700A1A1A100A9A9A900D1D1D100EAEA
      EA00EBEBEB00DCDCDC00D9D9D900D9D9D900FFFFFF00FFFFFF00CBCBCB00C6C6
      C600C0C0C000BFBFBF00E8E8E800FFFFFF00C5C5C500A6A6A600A6A6A600A6A6
      A600A6A6A600A7A7A7009A9A9A0096969600A2A2A200AAAAAA00D2D2D200EBEB
      EB00ECECEC00DDDDDD00DADADA00DADADA00D9D9D900F2F2F200FFFFFF00DADA
      DA00C1C1C100BCBCBC00B6B6B600B5B5B500E5E5E500FFFFFF00C5C5C500A7A7
      A700A7A7A700A8A8A8009B9B9B009797970000000000A5A5A500C2C2C200E6E6
      E600F5F5F500ECECEC00E2E2E200DDDDDD00FFFFFF00FFFFFF00FFFFFF00C8C8
      C800C2C2C200FFFFFF00FFFFFF00FFFFFF00AAAAAA00A6A6A600A6A6A600A5A5
      A500A8A8A800A3A3A300969696000000000000000000A5A5A500C3C3C300E7E7
      E700F5F5F500ECECEC00E2E2E200DDDDDD00DCDCDC00D3D3D300CECECE00C8C8
      C800C2C2C200BDBDBD00B7B7B700B1B1B100AAAAAA00A6A6A600A6A6A600A6A6
      A600A8A8A800A3A3A300979797000000000000000000A4A4A400C2C2C200E6E6
      E600F4F4F400EBEBEB00E2E2E200DCDCDC00FFFFFF00FFFFFF00CDCDCD00C7C7
      C700C1C1C100BCBCBC00B8B8B800DDDDDD00C5C5C500A6A6A600A6A6A600A5A5
      A500A7A7A700A3A3A300969696000000000000000000A6A6A600C3C3C300E7E7
      E700F5F5F500ECECEC00E3E3E300DDDDDD00DCDCDC00D5D5D500ECECEC00DADA
      DA00C2C2C200BDBDBD00B7B7B700B1B1B100ADADAD00DADADA00C4C4C400A6A6
      A600A9A9A900A4A4A400979797000000000000000000A1A1A100AFAFAF00DBDB
      DB00F2F2F200F8F8F800EEEEEE00E0E0E000DBDBDB00D4D4D400CECECE00C8C8
      C800C2C2C200BCBCBC00B6B6B600B0B0B000AAAAAA00A6A6A600A6A6A600A6A6
      A600A9A9A9009C9C9C00969696000000000000000000A2A2A200AFAFAF00DCDC
      DC00F2F2F200F8F8F800EEEEEE00E1E1E100DCDCDC00D4D4D400CECECE00C9C9
      C900C2C2C200BDBDBD00B7B7B700B1B1B100AAAAAA00A6A6A600A6A6A600A6A6
      A600A9A9A9009C9C9C00979797000000000000000000A1A1A100AFAFAF00DBDB
      DB00F1F1F100F7F7F700EEEEEE00E0E0E000DBDBDB00D3D3D300CDCDCD00C8C8
      C800C1C1C100BCBCBC00B6B6B600B0B0B000A9A9A900A6A6A600A6A6A600A6A6
      A600A9A9A9009B9B9B00969696000000000000000000A2A2A200B0B0B000DCDC
      DC00F2F2F200F8F8F800EFEFEF00E1E1E100DCDCDC00D4D4D400CECECE00C9C9
      C900C2C2C200BDBDBD00B7B7B700B1B1B100AAAAAA00A7A7A700A7A7A700A7A7
      A700AAAAAA009D9D9D0097979700000000000000000000000000A5A5A500BEBE
      BE00E6E6E600F7F7F700FAFAFA00EDEDED00E2E2E200D2D2D200CCCCCC00C7C7
      C700C0C0C000BBBBBB00B6B6B600B0B0B000A9A9A900A6A6A600A6A6A600AAAA
      AA00A0A0A0009696960000000000000000000000000000000000A5A5A500BEBE
      BE00E7E7E700F7F7F700FAFAFA00EDEDED00E2E2E200D2D2D200CDCDCD00C7C7
      C700C1C1C100BBBBBB00B6B6B600B0B0B000A9A9A900A6A6A600A6A6A600AAAA
      AA00A0A0A0009797970000000000000000000000000000000000A4A4A400BEBE
      BE00E6E6E600F7F7F700FAFAFA00ECECEC00E2E2E200D1D1D100CCCCCC00C7C7
      C700C0C0C000BBBBBB00B5B5B500AFAFAF00A9A9A900A6A6A600A6A6A600A9A9
      A900A0A0A0009696960000000000000000000000000000000000A6A6A600BFBF
      BF00E7E7E700F8F8F800FBFBFB00EEEEEE00E3E3E300D3D3D300CDCDCD00C8C8
      C800C1C1C100BCBCBC00B6B6B600B0B0B000AAAAAA00A7A7A700A7A7A700AAAA
      AA00A1A1A1009797970000000000000000000000000000000000A1A1A100A6A6
      A600C2C2C200E7E7E700F5F5F500FAFAFA00F2F2F200E7E7E700D8D8D800CACA
      CA00C3C3C300BEBEBE00BABABA00B7B7B700B3B3B300ADADAD00AAAAAA00A1A1
      A100979797009C9C9C0000000000000000000000000000000000A2A2A200A6A6
      A600C2C2C200E7E7E700F6F6F600FAFAFA00F2F2F200E8E8E800D8D8D800CACA
      CA00C4C4C400BEBEBE00BBBBBB00B8B8B800B3B3B300ADADAD00AAAAAA00A1A1
      A100979797009D9D9D0000000000000000000000000000000000A1A1A100A6A6
      A600C1C1C100E6E6E600F5F5F500FAFAFA00F1F1F100E7E7E700D7D7D700CACA
      CA00C3C3C300BEBEBE00BABABA00B7B7B700B2B2B200ACACAC00A9A9A900A0A0
      A000979797009C9C9C0000000000000000000000000000000000A2A2A200A7A7
      A700C2C2C200E8E8E800F6F6F600FBFBFB00F2F2F200E8E8E800D9D9D900CBCB
      CB00C4C4C400BFBFBF00BBBBBB00B8B8B800B3B3B300ADADAD00AAAAAA00A1A1
      A100989898009D9D9D000000000000000000000000000000000000000000A1A1
      A100A5A5A500BFBFBF00DFDFDF00EEEEEE00F6F6F600F6F6F600F0F0F000E7E7
      E700E0E0E000DADADA00D5D5D500CCCCCC00BEBEBE00B0B0B000A1A1A1009898
      98009C9C9C00000000000000000000000000000000000000000000000000A2A2
      A200A6A6A600C0C0C000DFDFDF00EEEEEE00F6F6F600F6F6F600F1F1F100E8E8
      E800E1E1E100DADADA00D6D6D600CCCCCC00BEBEBE00B0B0B000A1A1A1009898
      98009D9D9D00000000000000000000000000000000000000000000000000A1A1
      A100A5A5A500BFBFBF00DFDFDF00EEEEEE00F5F5F500F5F5F500F0F0F000E7E7
      E700E0E0E000D9D9D900D5D5D500CBCBCB00BEBEBE00AFAFAF00A0A0A0009797
      97009C9C9C00000000000000000000000000000000000000000000000000A2A2
      A200A6A6A600C0C0C000E0E0E000EFEFEF00F7F7F700F7F7F700F1F1F100E8E8
      E800E1E1E100DADADA00D6D6D600CDCDCD00BFBFBF00B0B0B000A1A1A1009898
      98009D9D9D000000000000000000000000000000000000000000000000000000
      0000A1A1A100A4A4A400B0B0B000C8C8C800DBDBDB00E5E5E500EAEAEA00EAEA
      EA00E6E6E600DEDEDE00D2D2D200C1C1C100ADADAD009F9F9F00999999009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000A2A2A200A5A5A500B0B0B000C8C8C800DCDCDC00E5E5E500EBEBEB00EBEB
      EB00E7E7E700DFDFDF00D3D3D300C1C1C100AEAEAE00A0A0A000999999009D9D
      9D00000000000000000000000000000000000000000000000000000000000000
      0000A1A1A100A4A4A400AFAFAF00C7C7C700DBDBDB00E5E5E500EAEAEA00EAEA
      EA00E6E6E600DEDEDE00D2D2D200C1C1C100ADADAD009F9F9F00989898009C9C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000A2A2A200A5A5A500B0B0B000C8C8C800DCDCDC00E6E6E600EBEBEB00EBEB
      EB00E7E7E700DFDFDF00D3D3D300C2C2C200AEAEAE00A0A0A0009A9A9A009D9D
      9D00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A1A1A100A4A4A400ACACAC00B7B7B700C0C0C000C3C3
      C300C0C0C000B9B9B900AEAEAE00A3A3A3009C9C9C009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A2A2A200A5A5A500ACACAC00B7B7B700C0C0C000C3C3
      C300C1C1C100BABABA00AEAEAE00A3A3A3009D9D9D009D9D9D00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A1A1A100A4A4A400ACACAC00B6B6B600BFBFBF00C2C2
      C200C0C0C000B9B9B900ADADAD00A3A3A3009C9C9C009C9C9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A2A2A200A5A5A500ADADAD00B8B8B800C1C1C100C4C4
      C400C1C1C100BABABA00AFAFAF00A4A4A4009D9D9D009D9D9D00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A1A1A100A1A1A100A1A1A100A1A1
      A1009F9F9F00A1A1A100A1A1A100A1A1A1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A2A2A200A2A2A200A2A2A200A1A1
      A1009F9F9F00A2A2A200A2A2A200A2A2A2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A1A1A100A1A1A100A1A1A100A0A0
      A0009E9E9E00A1A1A100A1A1A100A1A1A1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A2A2A200A2A2A200A2A2A200A1A1
      A100A0A0A000A2A2A200A2A2A200A2A2A2000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009898980098989800989898009898
      9800989898009898980098989800989898000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800072727200606060005858
      5800535353006060600072727200808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000098989800989898009C9C9C00A0A0A000A3A3A300A3A3
      A300A3A3A300A3A3A300A0A0A0009C9C9C009898980098989800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000072727200585858006B6B6B0091919100AFAFAF00BEBE
      BE00C0C0C000B3B3B30094949400676767004646460072727200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C00999999009D9D9D00A5A5A500A9A9A900AAAAAA00A9A9A900A9A9
      A900A9A9A900A9A9A900AAAAAA00A9A9A900A6A6A6009E9E9E00989898009898
      9800000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004F4F4F006464640093939300C5C5C500C7C7C700C7C7C700C7C7
      C700C7C7C700C7C7C700C7C7C700C7C7C7009B9B9B00585858003C3C3C000000
      0000000000000000000000000000000000000000000000000000000000009C9C
      9C009C9C9C00A2A2A200AAAAAA00A9A9A900A8A8A800A7A7A700A6A6A600A8A8
      A800A8A8A800A8A8A800A8A8A800A7A7A700A9A9A900ABABAB00A3A3A3009999
      9900989898000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007A7A7A0078787800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000787878007A7A7A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000053535300727272009D9D9D00B6B6B600B8B8B800B4B4B400B3B3B300B3B3
      B300B3B3B300B2B2B200B3B3B300B8B8B800BFBFBF00AAAAAA006B6B6B003A3A
      3A000000000000000000000000000000000000000000000000009C9C9C009C9C
      9C00A3A3A300ABABAB00A8A8A800A6A6A600AEAEAE00BABABA00B1B1B100A6A6
      A600A7A7A700A8A8A800A8A8A800A8A8A800A8A8A800A8A8A800ABABAB00A3A3
      A300999999009898980000000000000000000000000000000000000000000000
      00000000000000000000000000007E7E7E00A4A4A40079797900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000079797900A4A4A4007E7E7E0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005656
      56006E6E6E008F8F8F00A5A5A500AEAEAE00B4B4B400AEAEAE00AEAEAE00AEAE
      AE00BABABA00B9B9B900B6B6B600B2B2B200AEAEAE00ACACAC00999999006262
      62003838380000000000000000000000000000000000000000009D9D9D00A3A3
      A300AAAAAA00A8A8A800A8A8A800A6A6A600B3B3B300EBEBEB00E8E8E800B4B4
      B400A6A6A600A7A7A700A8A8A800A8A8A800A8A8A800A8A8A800A7A7A700ABAB
      AB00A3A3A3009898980000000000000000000000000000000000000000000000
      0000000000000000000085858500A8A8A800A9A9A90083838300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000083838300A9A9A900A7A7A70085858500000000000000
      0000000000000000000000000000000000000000000000000000727272006464
      64008080800099999900AAAAAA00B5B5B5008A8A8A003D3D3D003D3D3D003D3D
      3D004C4C4C00BFBFBF00BCBCBC00B8B8B800B3B3B300ABABAB009F9F9F008888
      88004A4A4A00727272000000000000000000000000009C9C9C00A1A1A100A9A9
      A900A8A8A800A8A8A800A8A8A800A6A6A600AFAFAF00E7E7E700FFFFFF00F0F0
      F000BABABA00A6A6A600A7A7A700A8A8A800A8A8A800A8A8A800A8A8A800A8A8
      A800ABABAB009E9E9E0098989800000000000000000000000000000000000000
      00000000000088888800AAAAAA00AFAFAF00B0B0B0009A9A9A00989898009595
      95009393930091919100909090008F8F8F008E8E8E008C8C8C00878787008080
      8000797979007373730000000000000000000000000000000000737373007979
      790080808000878787008C8C8C008E8E8E008F8F8F0090909000919191009393
      930095959500989898009A9A9A00B0B0B000AFAFAF00AAAAAA00888888000000
      00000000000000000000000000000000000000000000000000005D5D5D006E6E
      6E008A8A8A00A4A4A400B4B4B4008A8A8A003D3D3D004C4C4C008A8A8A00C6C6
      C600C6C6C600C4C4C400C1C1C100BEBEBE00B7B7B700B2B2B200A6A6A6009292
      9200686868003A3A3A00000000000000000000000000A0A0A000A6A6A600AAAA
      AA00AAAAAA00ABABAB00ABABAB00A8A8A800B1B1B100E7E7E700FFFFFF00FFFF
      FF00F3F3F300C1C1C100A9A9A900A7A7A700A8A8A800A8A8A800A8A8A800A8A8
      A800A9A9A900A5A5A50098989800000000000000000000000000000000000000
      000086868600A8A8A800AFAFAF00B4B4B400B7B7B700B7B7B700B6B6B600B5B5
      B500B3B3B300B2B2B200B2B2B200B1B1B100B0B0B000AEAEAE00ABABAB00A6A6
      A6009E9E9E007676760000000000000000000000000000000000767676009E9E
      9E00A6A6A600ABABAB00AEAEAE00B0B0B000B1B1B100B1B1B100B2B2B200B3B3
      B300B5B5B500B6B6B600B7B7B700B7B7B700B4B4B400AFAFAF00A8A8A8008686
      8600000000000000000000000000000000000000000080808000656565007171
      710097979700AFAFAF00BABABA006F6F6F003F3F3F008A8A8A00CBCBCB00CBCB
      CB00CBCBCB00C9C9C900C6C6C600C1C1C100BCBCBC00B6B6B600AEAEAE009B9B
      9B0079797900484848007272720000000000A3A3A300A2A2A200ABABAB00AEAE
      AE00AFAFAF00B1B1B100B2B2B200AEAEAE00B5B5B500E9E9E900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00D1D1D100ACACAC00A6A6A600A7A7A700A8A8A800A8A8
      A800A8A8A800A9A9A9009C9C9C00989898000000000000000000000000007D7D
      7D00A2A2A200ABABAB00B2B2B200B7B7B700B9B9B900BABABA00B9B9B900B8B8
      B800B7B7B700B6B6B600B6B6B600B6B6B600B4B4B400B2B2B200AFAFAF00A9A9
      A900A1A1A100797979000000000000000000000000000000000079797900A1A1
      A100A9A9A900AFAFAF00B2B2B200B4B4B400B6B6B600B6B6B600B6B6B600B7B7
      B700B8B8B800B9B9B900BABABA00B9B9B900B7B7B700B2B2B200ABABAB00A2A2
      A2007D7D7D000000000000000000000000000000000072727200646464007777
      7700A2A2A200B5B5B500BCBCBC003F3F3F003F3F3F00B8B8B800CECECE00CFCF
      CF00CFCFCF00CDCDCD00CACACA00AFAFAF0070707000B3B3B300B1B1B100A4A4
      A40081818100555555006060600000000000A3A3A300A7A7A700B2B2B200B4B4
      B400B5B5B500B7B7B700B8B8B800B4B4B400BBBBBB00EBEBEB00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00DEDEDE00B1B1B100A6A6A600A7A7A700A8A8
      A800A8A8A800AAAAAA00A0A0A000989898000000000000000000727272009898
      9800A3A3A300ACACAC00B3B3B300B7B7B700BABABA00BBBBBB00BBBBBB00BABA
      BA00B9B9B900B9B9B900B8B8B800B8B8B800B6B6B600B3B3B300AFAFAF00A9A9
      A900A1A1A1007A7A7A00000000000000000000000000000000007A7A7A00A0A0
      A000A9A9A900AFAFAF00B3B3B300B6B6B600B8B8B800B8B8B800B9B9B900B9B9
      B900BABABA00BBBBBB00BBBBBB00BABABA00B7B7B700B3B3B300ACACAC00A3A3
      A300989898007272720000000000000000000000000060606000616161007E7E
      7E00A8A8A800A8A8A800ACACAC003F3F3F003F3F3F00A8A8A800BBBBBB00C8C8
      C800D1D1D100CFCFCF00B2B2B2003F3F3F003F3F3F0070707000AEAEAE00A8A8
      A800898989005D5D5D005858580000000000A3A3A300ACACAC00B9B9B900BBBB
      BB00BBBBBB00BDBDBD00BEBEBE00BABABA00C0C0C000EDEDED00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E5E5E500B7B7B700A8A8A800A8A8
      A800A8A8A800A9A9A900A3A3A30098989800000000006F6F6F008E8E8E009595
      9500A0A0A000A9A9A900B1B1B100BDBDBD00D2D2D200DCDCDC00DCDCDC00DEDE
      DE00E2E2E200E6E6E600E7E7E700E5E5E500DBDBDB00C4C4C400B0B0B000A6A6
      A6009C9C9C007878780000000000000000000000000000000000787878009C9C
      9C00A6A6A600B0B0B000C4C4C400DBDBDB00E5E5E500E7E7E700E6E6E600E2E2
      E200DEDEDE00DCDCDC00DCDCDC00D2D2D200BDBDBD00B1B1B100A9A9A900A0A0
      A000959595008E8E8E006F6F6F00000000000000000058585800606060008383
      8300AAAAAA003F3F3F003F3F3F003F3F3F003F3F3F003F3F3F003F3F3F00B6B6
      B600D1D1D100B8B8B8003F3F3F003F3F3F003F3F3F003F3F3F006C6C6C00AAAA
      AA008C8C8C00616161003C3C3C0000000000A3A3A300B1B1B100C3C3C300C5C5
      C500C1C1C100C3C3C300C4C4C400C0C0C000C6C6C600EEEEEE00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3F3F300B8B8B800A7A7
      A700A7A7A700A9A9A900A3A3A3009898980000000000000000007F7F7F008F8F
      8F009A9A9A00A4A4A400AEAEAE00C9C9C900E7E7E700E3E3E300D5D5D500CECE
      CE00CBCBCB00C9C9C900C8C8C800C7C7C700C4C4C400BABABA00ACACAC00A0A0
      A000969696007171710000000000000000000000000000000000717171009696
      9600A0A0A000ACACAC00BABABA00C4C4C400C7C7C700C8C8C800C9C9C900CBCB
      CB00CECECE00D5D5D500E3E3E300E7E7E700C9C9C900AEAEAE00A4A4A4009A9A
      9A008F8F8F007F7F7F0000000000000000000000000058585800616161008282
      8200AAAAAA00707070003F3F3F003F3F3F003F3F3F003F3F3F00B8B8B800D0D0
      D000D0D0D0003F3F3F003F3F3F003F3F3F003F3F3F003F3F3F003F3F3F008E8E
      8E008C8C8C00606060003B3B3B0000000000A3A3A300B7B7B700CFCFCF00D3D3
      D300C9C9C900C9C9C900CACACA00C7C7C700CCCCCC00F0F0F000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EBEBEB00B7B7B700A7A7
      A700A7A7A700A9A9A900A3A3A300989898000000000000000000000000007D7D
      7D00929292009B9B9B00A5A5A500B6B6B600BFBFBF00B6B6B600ADADAD00A8A8
      A800A5A5A500A3A3A300A2A2A200A1A1A100A1A1A100A0A0A0009C9C9C009595
      95008D8D8D006D6D6D00000000000000000000000000000000006D6D6D008D8D
      8D00959595009C9C9C00A0A0A000A1A1A100A1A1A100A2A2A200A3A3A300A5A5
      A500A8A8A800ADADAD00B5B5B500BFBFBF00B6B6B600A5A5A5009B9B9B009292
      92007D7D7D000000000000000000000000000000000060606000646464007D7D
      7D00A5A5A500B4B4B400707070003F3F3F003F3F3F00B1B1B100CECECE00CECE
      CE00CECECE00CCCCCC00C9C9C9003F3F3F003F3F3F00A6A6A600B0B0B000A6A6
      A600868686005D5D5D005858580000000000A3A3A300B7B7B700D6D6D600DFDF
      DF00D2D2D200CECECE00CFCFCF00CDCDCD00D0D0D000F2F2F200FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D9D9D900AFAFAF00A6A6A600A7A7
      A700A8A8A800A9A9A900A3A3A300989898000000000000000000000000000000
      00007F7F7F009090900099999900A2A2A200A5A5A50090909000919191008E8E
      8E008B8B8B008989890088888800878787008787870086868600858585008282
      8200818181008888880000000000000000000000000000000000888888008181
      8100828282008585850086868600878787008787870088888800898989008B8B
      8B008E8E8E009191910090909000A5A5A500A2A2A20099999900909090007F7F
      7F00000000000000000000000000000000000000000072727200696969007777
      77009E9E9E00B1B1B100B9B9B90070707000AEAEAE00C7C7C700CACACA00CBCB
      CB00CBCBCB00C8C8C800C5C5C5003F3F3F003F3F3F00A3A3A300AEAEAE00A0A0
      A0007E7E7E00585858006060600000000000A3A3A300B2B2B200D8D8D800E8E8
      E800DEDEDE00D4D4D400D5D5D500D2D2D200D5D5D500F3F3F300FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00D7D7D700ABABAB00A6A6A600A7A7A700A8A8
      A800A8A8A800AAAAAA00A0A0A000989898000000000000000000000000000000
      0000000000007C7C7C008D8D8D0095959500979797007A7A7A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007979790097979700959595008D8D8D007C7C7C000000
      00000000000000000000000000000000000000000000808080006C6C6C007070
      700093939300AAAAAA00B4B4B400BABABA00BFBFBF00C2C2C200C5C5C500C6C6
      C600C5C5C500C3C3C3008A8A8A003F3F3F006F6F6F00A9A9A900A8A8A8009696
      9600767676004E4E4E007272720000000000A3A3A300ABABAB00D3D3D300ECEC
      EC00EDEDED00DEDEDE00DBDBDB00D8D8D800DADADA00F5F5F500FFFFFF00FFFF
      FF00FFFFFF00F7F7F700D0D0D000AEAEAE00A8A8A800A8A8A800A8A8A800A8A8
      A800A8A8A800A9A9A9009C9C9C00989898000000000000000000000000000000
      000000000000000000007F7F7F008F8F8F009292920078787800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000077777700929292008F8F8F007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000696969006F6F
      6F00838383009E9E9E00ADADAD00B4B4B400B9B9B900BCBCBC00BFBFBF00BFBF
      BF00BFBFBF008A8A8A004C4C4C003F3F3F008A8A8A00ABABAB009F9F9F008989
      89006767670042424200000000000000000000000000A6A6A600C4C4C400E8E8
      E800F6F6F600EDEDED00E4E4E400DEDEDE00DDDDDD00F5F5F500FFFFFF00FFFF
      FF00EFEFEF00C7C7C700B4B4B400B0B0B000ABABAB00A8A8A800A8A8A800A8A8
      A800A9A9A900A5A5A50098989800000000000000000000000000000000000000
      00000000000000000000000000007F7F7F009292920078787800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000077777700929292007F7F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000808080006F6F
      6F00787878008F8F8F00A2A2A200ADADAD00B2B2B200B5B5B500B8B8B8004C4C
      4C003D3D3D003D3D3D003D3D3D008A8A8A00ABABAB00A2A2A200939393007A7A
      7A005252520072727200000000000000000000000000A3A3A300B1B1B100DDDD
      DD00F3F3F300F9F9F900F0F0F000E2E2E200DDDDDD00F7F7F700FFFFFF00EEEE
      EE00C8C8C800BABABA00B7B7B700B2B2B200ABABAB00A8A8A800A8A8A800A8A8
      A800ABABAB009D9D9D0098989800000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000777777007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006868
      6800737373007F7F7F0096969600A4A4A400AAAAAA00AEAEAE00B0B0B000B0B0
      B000AEAEAE00AEAEAE00AEAEAE00A9A9A900A4A4A4009B9B9B00848484006363
      6300414141000000000000000000000000000000000000000000A6A6A600C0C0
      C000E8E8E800F9F9F900FCFCFC00EEEEEE00E4E4E400F3F3F300EAEAEA00CACA
      CA00C0C0C000BDBDBD00B7B7B700B1B1B100ABABAB00A8A8A800A8A8A800ABAB
      AB00A2A2A2009898980000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F7F7F00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007F7F7F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006A6A6A007575750085858500A2A2A200AFAFAF00ACACAC00AAAAAA00A9A9
      A900A9A9A900A9A9A900ABABAB00B0B0B000AAAAAA008C8C8C00686868004848
      4800000000000000000000000000000000000000000000000000A3A3A300A8A8
      A800C3C3C300E8E8E800F7F7F700FCFCFC00F3F3F300E9E9E900D9D9D900CCCC
      CC00C5C5C500C0C0C000BCBCBC00B9B9B900B4B4B400AEAEAE00ABABAB00A2A2
      A200999999009E9E9E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000656565007171710080808000A6A6A600C7C7C700C7C7C700C7C7
      C700C7C7C700C7C7C700C7C7C700B2B2B200828282005F5F5F00474747000000
      000000000000000000000000000000000000000000000000000000000000A3A3
      A300A7A7A700C1C1C100E1E1E100F0F0F000F7F7F700F7F7F700F2F2F200E9E9
      E900E2E2E200DBDBDB00D7D7D700CDCDCD00C0C0C000B1B1B100A2A2A2009999
      99009E9E9E000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800066666600727272008282820095959500A4A4
      A400A5A5A5009898980082828200686868005252520072727200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A3A3A300A6A6A600B1B1B100C9C9C900DDDDDD00E7E7E700ECECEC00ECEC
      EC00E8E8E800E0E0E000D4D4D400C3C3C300AFAFAF00A1A1A1009A9A9A009E9E
      9E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800072727200606060005858
      5800585858006060600072727200808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A3A3A300A6A6A600AEAEAE00B8B8B800C1C1C100C4C4
      C400C2C2C200BBBBBB00AFAFAF00A5A5A5009E9E9E009E9E9E00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A3A3A300A3A3A300A3A3A300A2A2
      A200A0A0A000A3A3A300A3A3A300A3A3A3000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007A7A7A00626262006262
      6200626262006262620062626200626262006262620062626200626262006262
      6200626262006262620062626200626262006262620062626200626262006262
      6200626262006262620062626200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008B8B8B0080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008B8B8B0080808000808080008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000000000000000
      000000000000000000000000000000000000000000007A7A7A00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FBFBFB00F8F8F800F6F6F600F4F4
      F400F2F2F200EFEFEF00EDEDED00EBEBEB00E9E9E900E7E7E700E2E2E200DDDD
      DD00D7D7D700D2D2D20062626200000000008C8C8C008C8C8C008C8C8C008C8C
      8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C8C008C8C
      8C008C8C8C008C8C8C0074747400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008B8B8B00A5A5A500AFAFAF00AFAFAF00AFAFAF00AFAF
      AF00AFAFAF00AFAFAF00AFAFAF00A5A5A5008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008B8B8B00A5A5A500AFAFAF00AFAFAF00AFAFAF00AFAF
      AF00AFAFAF00AFAFAF00AFAFAF00A5A5A5008080800000000000000000000000
      000000000000000000000000000000000000000000007A7A7A00FDFDFD006868
      6800626262006262620062626200626262006262620062626200626262006262
      620062626200626262006262620062626200EBEBEB00E9E9E900E7E7E700E2E2
      E200DDDDDD00D7D7D70062626200000000008C8C8C00DEDEDE00ECECEC00E8E8
      E800E7E7E700E5E5E500E4E4E400E3E3E300E3E3E300E4E4E400E4E4E400E4E4
      E400E6E6E600DCDCDC0074747400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000808080008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      000000000000000000000000000000000000000000007A7A7A00FDFDFD006868
      6800FDFDFD00FDFDFD00FDFDFD00FDFDFD00FBFBFB00F8F8F800F4F4F400F0F0
      F000ECECEC00E8E8E800E0E0E00062626200EBEBEB00EBEBEB00E9E9E900E7E7
      E700E2E2E200DDDDDD0062626200000000008C8C8C00DDDDDD00EBEBEB00E6E6
      E600E5E5E500E4E4E400E2E2E200E0E0E000E0E0E000E0E0E000E0E0E000E0E0
      E000E2E2E200D9D9D90074747400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000646464006464
      6400646464006464640064646400646464006464640064646400646464006464
      6400646464006464640064646400646464006464640064646400646464006464
      6400646464006464640000000000000000000000000000000000646464006464
      6400646464006464640064646400646464006464640064646400646464006464
      6400646464006464640064646400646464006464640064646400646464006464
      640064646400646464000000000000000000000000007A7A7A00FDFDFD006868
      6800FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FBFBFB00F8F8F800F4F4
      F400F0F0F000ECECEC00E8E8E80062626200EBEBEB00EDEDED00EBEBEB00E9E9
      E900E7E7E700E2E2E20062626200000000008C8C8C00DFDFDF00EDEDED00E8E8
      E800E7E7E700E6E6E600E5E5E500E3E3E300E1E1E100E0E0E000E0E0E000E0E0
      E000E2E2E200D9D9D90074747400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900D3D3D300D2D2
      D200D1D1D100D0D0D000D0D0D000CFCFCF00CECECE00CECECE00CCCCCC00CCCC
      CC00CBCBCB00CACACA00C9C9C900C9C9C900C9C9C900A5A5A50060606000C2C2
      C200BDBDBD00B9B9B90064646400000000000000000099999900D3D3D300D2D2
      D200D1D1D100D0D0D000D0D0D000CFCFCF00CECECE00CECECE00CCCCCC00CCCC
      CC00CBCBCB00CACACA00C9C9C900C9C9C900C9C9C900A5A5A50060606000C2C2
      C200BDBDBD00B9B9B9006464640000000000000000007A7A7A00FDFDFD006868
      6800FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FBFBFB00F8F8
      F800F4F4F400F0F0F000ECECEC0062626200EBEBEB00EFEFEF00EDEDED00EBEB
      EB00E9E9E900E7E7E700626262000000000095959500E1E1E100F0F0F000DDDD
      DD00C6C6C600C7C7C700C6C6C600C6C6C600C6C6C600C5C5C500C4C4C400D9D9
      D900E2E2E200D9D9D90074747400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900D3D3D300D3D3
      D300D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500D5D5D500BDBDBD0064646400000000000000000099999900D3D3D300D3D3
      D300D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500D5D5D500BDBDBD006464640000000000000000007A7A7A00FDFDFD006868
      6800FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD009C9C
      9C004646460090909000BDBDBD0062626200F2F2F200F2F2F200EFEFEF00EDED
      ED00EBEBEB00E9E9E900626262000000000095959500E3E3E300F2F2F200E3E3
      E300DDDDDD00DDDDDD00DCDCDC00DBDBDB00DADADA00D9D9D900D7D7D700DBDB
      DB00E2E2E200D8D8D80074747400000000000000000000000000000000000000
      000000000000000000000000000000000000000000009A9A9A00D5D5D500B9B9
      B900919191007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B00D5D5D500C2C2C2006464640000000000000000009A9A9A00D5D5D500B9B9
      B900919191007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B7B007B7B
      7B00D5D5D500C2C2C2006464640000000000000000007A7A7A00FDFDFD006868
      6800FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD006B6B6B00464646006B6B6B0068686800F7F7F700F5F5F500F2F2F200EFEF
      EF00EDEDED00EBEBEB00626262000000000095959500E5E5E500F4F4F400ECEC
      EC00E8E8E800E8E8E800E6E6E600E6E6E600E5E5E500E3E3E300DEDEDE00DBDB
      DB00DFDFDF00D6D6D6007E7E7E00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900D5D5D500B9B9
      B900A9A9A900969696009696960096969600FDFDFD00FDFDFD00F9F9F900F4F4
      F400F0F0F000EBEBEB00E7E7E700E7E7E7008686860084848400818181007B7B
      7B00D5D5D500C7C7C70064646400000000000000000099999900D5D5D500B9B9
      B900A9A9A90096969600FDFDFD00FDFDFD00FDFDFD00FDFDFD00F9F9F900F6F6
      F600F2F2F200EEEEEE00EAEAEA00E7E7E700DEDEDE00D2D2D200818181007B7B
      7B00D5D5D500C7C7C7006464640000000000000000007A7A7A00FDFDFD006868
      6800FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00BDBDBD006B6B6B00464646006B6B6B00F7F7F700F7F7F700F5F5F500F3F3
      F300F1F1F100EEEEEE0062626200000000009F9F9F00E8E8E800F6F6F600DBDB
      DB00BFBFBF00BFBFBF00C1C1C100C2C2C200C2C2C200BFBFBF00B6B6B600C2C2
      C200CECECE00CCCCCC007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900D5D5D500B9B9
      B900A9A9A9009A9A9A009A9A9A009A9A9A00FDFDFD00FDFDFD00FDFDFD00F9F9
      F900F4F4F400F0F0F000EBEBEB00E7E7E7008989890086868600828282007B7B
      7B00D5D5D500C7C7C70064646400000000000000000099999900D5D5D500B9B9
      B900A9A9A9009A9A9A00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00F9F9
      F900F6F6F600F2F2F200EEEEEE00EAEAEA00E7E7E700DEDEDE00828282007B7B
      7B00D5D5D500C7C7C7006464640000000000000000007A7A7A00FDFDFD006868
      6800FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00BDBDBD006B6B6B004E4E4E006B6B6B00BDBDBD00F7F7F700F5F5
      F500F3F3F300F1F1F10062626200000000009F9F9F00EAEAEA00F6F6F600E7E7
      E700DBDBDB00D4D4D400D9D9D900E0E0E000DEDEDE00D3D3D300BCBCBC00AAAA
      AA00AAAAAA00B3B3B30073737300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900D5D5D500B9B9
      B900A9A9A9009E9E9E009E9E9E009E9E9E00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00F9F9F900F4F4F400F0F0F000EBEBEB008C8C8C0089898900858585007B7B
      7B00D5D5D500C8C8C80064646400000000000000000099999900D5D5D500B9B9
      B900A9A9A9009E9E9E00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00F9F9F900F6F6F600F2F2F200EEEEEE00EAEAEA00E7E7E700858585007B7B
      7B00D5D5D500C8C8C8006464640000000000000000007A7A7A00FDFDFD006868
      6800FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00BDBDBD006B6B6B004E4E4E004646460090909000F7F7
      F70046464600F3F3F3006262620000000000A6A6A600EBEBEB00F6F6F600DDDD
      DD00C0C0C000B3B3B300BBBBBB00C9C9C900CACACA00B6B6B6009B9B9B008A8A
      8A008C8C8C00979797006F6F6F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900D5D5D500B9B9
      B900A9A9A900A1A1A100A2A2A200A2A2A200FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00F9F9F900F4F4F400F0F0F0008E8E8E008A8A8A00868686007B7B
      7B00D5D5D500C9C9C90064646400000000000000000099999900D5D5D500B9B9
      B900A9A9A900A1A1A100FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00F9F9F900F6F6F600F2F2F200EEEEEE00EAEAEA00868686007B7B
      7B00D5D5D500C9C9C9006464640000000000000000007A7A7A00FDFDFD006868
      6800686868006868680068686800686868006868680068686800686868006868
      6800686868006868680068686800686868006B6B6B006B6B6B004E4E4E004646
      460046464600F5F5F5006262620000000000A6A6A600EFEFEF00F8F8F8009595
      9500979797008585850087878700929292009393930083838300777777006C6C
      6C0063636300828282005C5C5C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900D5D5D500B9B9
      B900A9A9A900A5A5A500A6A6A600A6A6A600FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00F9F9F900F4F4F400909090008C8C8C00888888007B7B
      7B00D5D5D500CACACA0064646400000000000000000099999900D5D5D500B9B9
      B900A9A9A900A5A5A500FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00F9F9F900F6F6F600F2F2F200EEEEEE00888888007B7B
      7B00D5D5D500CACACA006464640000000000000000007A7A7A00FDFDFD006767
      67009090900090909000909090009090900090909000C8C8C80090909000C8C8
      C80090909000949494007E7D7F0073737300FDFDFD004E4E4E006B6B6B006B6B
      6B0046464600F7F7F7006262620000000000B1B1B100F1F1F100FBFBFB00A4A4
      A400959595009C9C9C0099999900959595008F8F8F008B8B8B00BDBDBD00BFBF
      BF0064646400606060004E4E4E00000000000000000000000000000000000000
      000077777700626262006262620062626200000000009C9C9C00D5D5D500B9B9
      B900A9A9A900A9A9A900AAAAAA00AAAAAA00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00F9F9F900919191008D8D8D00898989007B7B
      7B00D5D5D500CBCBCB006464640000000000000000009C9C9C00D5D5D500B9B9
      B900A9A9A900A9A9A900FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00F9F9F900F6F6F600F2F2F200898989007B7B
      7B00D5D5D500CBCBCB006464640000000000000000007A7A7A00FDFDFD00FDFD
      FD00737373007373730073737300737373007373730073737300737373007373
      7300737373007373730073737300FDFDFD00FDFDFD004E4E4E00808080008080
      800046464600FAFAFA006262620000000000B1B1B100F3F3F300FDFDFD009090
      9000F4F4F400AFAFAF009C9C9C00939393008B8B8B00CECECE008B8B8B00BCBC
      BC00ADADAD00606060004A4A4A0000000000000000008F8F8F00727272007272
      720077777700595959005454540076767600000000009D9D9D00D5D5D500B9B9
      B900A9A9A900ACACAC00AEAEAE00AEAEAE00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00929292008E8E8E008A8A8A007B7B
      7B00D5D5D500CBCBCB006464640000000000000000009D9D9D00D5D5D500B9B9
      B900A9A9A900ACACAC00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00F9F9F900F6F6F6008A8A8A007B7B
      7B00D5D5D500CBCBCB006464640000000000000000007A7A7A00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD004E4E4E004E4E4E004E4E4E004E4E
      4E004E4E4E00FDFDFD006262620000000000B8B8B800F4F4F400FEFEFE00BCBC
      BC0099999900F4F4F400CECECE008B8B8B00D5D5D5008B8B8B00D2D2D2008B8B
      8B00B7B7B7009F9F9F005B5B5B005B5B5B005B5B5B008F8F8F00BEBEBE00BEBE
      BE00777777006D6D6D007676760076767600000000009B9B9B00D5D5D500B9B9
      B900A9A9A900AEAEAE00B1B1B100BFBFBF00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00929292008E8E8E008A8A8A007B7B
      7B00D5D5D500CCCCCC006464640000000000000000009B9B9B00D5D5D500B9B9
      B900A9A9A900AEAEAE00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00D2D2D200D2D2D200DEDEDE008A8A8A007B7B
      7B00D5D5D500CCCCCC006464640000000000000000007A7A7A00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD006262620000000000B8B8B800F4F4F400FFFFFF00FEFE
      FE00D3D3D3009E9E9E00EAEAEA00A8A8A8008B8B8B00D0D0D0008B8B8B00CBCB
      CB008B8B8B00BDBDBD00B5B5B500AEAEAE00A7A7A7008F8F8F00BABABA00BABA
      BA0077777700777777007A7A7A007A7A7A00000000009A9A9A00D5D5D500B9B9
      B900A9A9A900AEAEAE00BFBFBF00BFBFBF00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00D2D2D200D2D2D200929292008E8E8E008A8A8A007B7B
      7B00D5D5D500CDCDCD006464640000000000000000009A9A9A00D5D5D500B9B9
      B900A9A9A900AEAEAE00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00D2D2D200DEDEDE008E8E8E008A8A8A007B7B
      7B00D5D5D500CDCDCD006464640000000000000000007A7A7A00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF006262620000000000BFBFBF00F6F6F600FFFFFF00FFFF
      FF00FEFEFE00C1C1C1009A9A9A00E0E0E000A1A1A1008B8B8B00CBCBCB008B8B
      8B00C4C4C400BDBDBD00B5B5B500AEAEAE00A7A7A7008F8F8F00C7C7C700C7C7
      C70077777700878787008787870087878700000000009A9A9A00D5D5D500B9B9
      B900A9A9A900AEAEAE00B1B1B100BFBFBF00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00D2D2D20096969600929292008E8E8E008A8A8A007B7B
      7B00D5D5D500CECECE006464640000000000000000009A9A9A00D5D5D500B9B9
      B900A9A9A900AEAEAE00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00DEDEDE00929292008E8E8E008A8A8A007B7B
      7B00D5D5D500CECECE006464640000000000000000007A7A7A00626262006262
      6200626262006262620062626200626262006262620062626200626262006262
      6200626262006262620062626200626262006262620062626200626262006262
      620062626200626262006262620000000000BFBFBF00F6F6F600FFFFFF00FFFF
      FF00FFFFFF00FEFEFE00C3C3C30096969600D6D6D6009E9E9E00CBCBCB00CBCB
      CB00C4C4C400BDBDBD00B5B5B500AEAEAE00A7A7A7008F8F8F00F1F1F100EFEF
      EF00777777009393930093939300939393000000000099999900D5D5D500B9B9
      B900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9
      A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A9008686
      8600D5D5D500CFCFCF0064646400000000000000000099999900D5D5D500B9B9
      B900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9
      A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A900A9A9A9008686
      8600D5D5D500CFCFCF006464640000000000000000007A7A7A00686868006868
      6800686868006868680068686800686868006868680068686800686868006868
      6800686868006868680068686800686868006868680068686800686868006868
      680068686800737373006262620000000000BFBFBF00B1B1B100B1B1B100B1B1
      B100B1B1B100B1B1B100B0B0B000A5A5A50093939300F1F1F100D2D2D200CBCB
      CB00C4C4C400BDBDBD00B5B5B500AEAEAE00A7A7A7008F8F8F00F1F1F100F1F1
      F100777777009E9E9E009E9E9E009E9E9E000000000099999900D5D5D500B9B9
      B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9
      B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9
      B900D0D0D000D0D0D00064646400000000000000000099999900D5D5D500B9B9
      B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9
      B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9
      B900D0D0D000D0D0D00064646400000000000000000067676700909090009090
      9000909090009090900090909000909090009090900090909000909090009090
      900090909000909090009090900090909000C8C8C80090909000C8C8C8009090
      9000949494007E7D7F0073737300000000000000000000000000000000000000
      000000000000000000000000000000000000000000008B8B8B00F3F3F300EFEF
      EF00C4C4C400BDBDBD00B5B5B500AEAEAE007F7F7F008F8F8F00F1F1F100F1F1
      F10077777700A9A9A900A9A9A900A9A9A9000000000099999900D5D5D500D5D5
      D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D3D3D300D3D3D300D2D2
      D200D1D1D100D0D0D00064646400000000000000000099999900D5D5D500D5D5
      D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5
      D500D5D5D500D5D5D500D5D5D500D5D5D500D5D5D500D3D3D300D3D3D300D2D2
      D200D1D1D100D0D0D00064646400000000000000000000000000737373007373
      7300737373007373730073737300737373007373730073737300737373007373
      7300737373007373730073737300737373007373730073737300737373007373
      7300737373007373730000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A9A9
      A900ACACAC00A9A9A900A4A4A40090909000000000008F8F8F008F8F8F008F8F
      8F0077777700AAAAAA009A9A9A009A9A9A000000000000000000999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990000000000000000000000000000000000999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990099999900999999009999990099999900999999009999
      9900999999009999990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000777777007777770077777700777777000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AFAFAF009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C00000000000000000000000000000000000000
      0000000000000000000000000000AFAFAF009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C6000000
      00000000000000000000000000006B6B6B006B6B6B0055555500323232000000
      00000000000000000000000000000000000000000000000000006B6B6B006B6B
      6B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AFAFAF00FCFCFC00F4F4F400F2F2
      F200F0F0F000EEEEEE00ECECEC00EAEAEA00E8E8E800E4E4E400DFDFDF00DBDB
      DB00D6D6D600D2D2D2009C9C9C00000000000000000000000000696969005C5C
      5C005C5C5C005C5C5C005C5C5C00AFAFAF00FDFDFD00FCFCFC00FAFAFA00F7F7
      F700F4F4F400F1F1F100EFEFEF00ECECEC00E9E9E900E7E7E700E0E0E000D9D9
      D900D2D2D2009C9C9C0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600AFAFAF000000
      0000000000000000000000000000797979006B6B6B0055555500323232000000
      000000000000000000000000000000000000000000006F6F6F006B6B6B005555
      55006B6B6B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AFAFAF00FCFCFC00F6F6F600F4F4
      F400F2F2F200F0F0F000EEEEEE00ECECEC00EAEAEA00E8E8E800E4E4E400DFDF
      DF00DBDBDB00D6D6D6009C9C9C00000000000000000000000000696969007272
      7200727272007070700070707000AFAFAF00FDFDFD00FDFDFD00FCFCFC00FAFA
      FA00F7F7F700F4F4F400F1F1F100EFEFEF00ECECEC00E9E9E900E7E7E700E0E0
      E000D9D9D9009C9C9C00000000000000000000000000000000007A7A7A006262
      62006262620062626200626262005F5F5F00AFAFAF00C6C6C600929292004444
      44005B5B5B00626262005F5F5F00797979006B6B6B0055555500323232004444
      44005B5B5B006262620000000000000000006F6F6F009C9C9C00888888006B6B
      6B00555555006B6B6B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AFAFAF00FCFCFC00F8F8F800F6F6
      F600F4F4F400F2F2F200F0F0F000EEEEEE00ECECEC00EAEAEA00E8E8E800E4E4
      E400DFDFDF00DBDBDB009C9C9C000000000000000000000000006A6A6A007575
      7500737373007272720072727200AFAFAF00FDFDFD00FDFDFD00FDFDFD00FCFC
      FC00FAFAFA00F7F7F700F4F4F400F1F1F100EFEFEF00ECECEC00E9E9E900E7E7
      E700E0E0E0009C9C9C00000000000000000000000000000000007A7A7A00F3F3
      F300F1F1F100F0F0F000EFEFEF00E7E7E700AFAFAF00C6C6C60092929200A1A1
      A100D7D7D700E7E7E700DDDDDD00797979006B6B6B0055555500323232009595
      9500C7C7C700626262000000000000000000A4A4A400ACACAC00A0A0A0008888
      88006B6B6B00555555006B6B6B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AFAFAF00FCFCFC00DCDCDC00C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9
      C900E4E4E400DFDFDF009C9C9C000000000000000000000000006A6A6A007676
      7600757575007474740073737300AFAFAF00FDFDFD00DCDCDC00C9C9C900C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900E9E9
      E900E7E7E7009C9C9C00000000000000000000000000000000007A7A7A00F4F4
      F400F3F3F300F1F1F100F0F0F000E8E8E800AFAFAF00C6C6C60092929200A2A2
      A200D8D8D800E9E9E900E0E0E000797979006B6B6B0055555500323232009797
      9700C8C8C80062626200000000000000000098989800A8A8A800ACACAC00A0A0
      A000888888006B6B6B00555555006B6B6B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AFAFAF00FCFCFC00FEFEFE00FCFC
      FC00F9F9F900F7F7F700F4F4F400F2F2F200F0F0F000EEEEEE00ECECEC00EAEA
      EA00E8E8E800E4E4E4009C9C9C000000000000000000000000006B6B6B007878
      7800777777007676760075757500AFAFAF00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FCFCFC00FAFAFA00F7F7F700F4F4F400F1F1F100EFEFEF00ECEC
      EC00E9E9E9009C9C9C00000000000000000000000000000000007A7A7A00F5F5
      F500F4F4F400F3F3F300F1F1F100E9E9E900AFAFAF00C6C6C60092929200A2A2
      A200D9D9D900EAEAEA00E2E2E200797979006B6B6B0055555500323232009898
      9800CACACA006262620000000000000000000000000098989800A8A8A800ACAC
      AC00A0A0A000888888006B6B6B00555555006B6B6B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AFAFAF009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C0091919100AFAFAF00FCFCFC00DCDCDC00C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9
      C900EAEAEA00E8E8E8009C9C9C000000000000000000000000006C6C6C007979
      7900797979007878780077777700AFAFAF00FDFDFD00DCDCDC00C9C9C900C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900EFEF
      EF00ECECEC009C9C9C00000000000000000000000000000000007A7A7A00F6F6
      F600F5F5F500F4F4F400F3F3F300EAEAEA00AFAFAF00C6C6C60092929200A3A3
      A300DADADA00EBEBEB00E3E3E300797979006B6B6B0055555500323232009A9A
      9A00CCCCCC00626262000000000000000000000000000000000098989800A8A8
      A800ACACAC00A0A0A000888888006B6B6B00555555006B6B6B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AFAFAF00FCFCFC00EAEA
      EA00E8E8E800E6E6E600E4E4E400D7D7D700AFAFAF00FCFCFC00FFFFFF00FFFF
      FF00FEFEFE00FCFCFC00F9F9F900F7F7F700F5F5F500F3F3F300F1F1F100EFEF
      EF00EDEDED00EBEBEB009C9C9C000000000000000000000000006D6D6D007C7C
      7C007B7B7B007979790079797900AFAFAF00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FBFBFB00F8F8F800F5F5F500F3F3
      F300F0F0F0009C9C9C00000000000000000000000000000000007A7A7A00F7F7
      F700F6F6F600F5F5F500F4F4F400E6E6E600AFAFAF00C6C6C600929292009E9E
      9E00D3D3D300EAEAEA00E4E4E400797979006B6B6B0055555500323232009C9C
      9C00CFCFCF006262620000000000000000000000000000000000000000009898
      9800A8A8A800ACACAC00A0A0A00088888800414141006B6B6B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AFAFAF00FCFCFC00EBEB
      EB00EAEAEA00E8E8E800E6E6E600D7D7D700AFAFAF00FCFCFC00DCDCDC00C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9
      C900EFEFEF00EDEDED009C9C9C000000000000000000000000006D6D6D007D7D
      7D007D7D7D007C7C7C007B7B7B00AFAFAF00FDFDFD00DCDCDC00C9C9C900C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900F5F5
      F500F3F3F3009C9C9C00000000000000000000000000000000007A7A7A00F8F8
      F800F7F7F700F6F6F600F1F1F100D5D5D500AFAFAF00C6C6C600929292008D8D
      8D00B9B9B900E1E1E100E5E5E500797979006B6B6B0055555500323232009D9D
      9D00D1D1D1006262620000000000000000000000000000000000000000000000
      000098989800A8A8A800ACACAC00989898008C8C8C0041414100000000000000
      0000ADADAD009C9C9C00B5B5B500BDBDBD00BDBDBD00B5B5B500ADADAD000000
      00000000000000000000000000000000000000000000AFAFAF00FCFCFC00EDED
      ED00EBEBEB00EAEAEA00E8E8E800D7D7D700AFAFAF00FCFCFC00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FEFEFE00FCFCFC00F9F9F900F7F7F700F5F5F500F3F3
      F300F1F1F100EFEFEF009C9C9C000000000000000000000000006E6E6E008181
      81007F7F7F007D7D7D007D7D7D00AFAFAF00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FBFBFB00F8F8
      F800F5F5F5009C9C9C00000000000000000000000000000000007A7A7A00F9F9
      F900F8F8F800F7F7F700F1F1F1004B4B4B004B4B4B004B4B4B004B4B4B004B4B
      4B00B1B1B100E0E0E000E6E6E600797979006B6B6B0055555500323232009F9F
      9F00D3D3D3006262620000000000000000000000000000000000000000000000
      0000000000009898980098989800AFAFAF00989898006B6B6B00777777009898
      9800D2D2D200D7D7D700DCDCDC00DFDFDF00E0E0E000E1E1E100DADADA00B5B5
      B5000000000000000000000000000000000000000000AFAFAF00FCFCFC00DCDC
      DC00C9C9C900C9C9C900C9C9C900BEBEBE00AFAFAF00FCFCFC00DCDCDC00C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9
      C900F3F3F300E6E6E6009C9C9C000000000000000000000000006E6E6E008484
      840082828200818181007F7F7F00AFAFAF00FDFDFD00DCDCDC00C9C9C900C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900FBFB
      FB00F8F8F8009C9C9C00000000000000000000000000000000007A7A7A00FAFA
      FA00F9F9F900F8F8F800F4F4F4006F6F6F009F9F9F006F6F6F00606060004B4B
      4B00C0C0C000E6E6E600E7E7E700797979006B6B6B005555550032323200A0A0
      A000D5D5D5006262620000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C3C3C30041414100B1B1B100D4D4
      D400DBDBDB00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00EDEDED00E2E2
      E200BDBDBD00BDBDBD00000000000000000000000000AFAFAF00FCFCFC00F0F0
      F000EEEEEE00EDEDED00EBEBEB00D7D7D700AFAFAF00FCFCFC00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00FCFCFC00F9F9F900F7F7
      F700E6E6E600DCDCDC009C9C9C000000000000000000000000006F6F6F008686
      8600858585008383830082828200AFAFAF00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00F0F0
      F000E6E6E6009C9C9C00000000000000000000000000000000007A7A7A00FBFB
      FB00FAFAFA00F9F9F900F3F3F300D5D5D50060606000606060004B4B4B008C8C
      8C00B2B2B200DBDBDB00E5E5E500797979006B6B6B005555550032323200A1A1
      A100D6D6D6005E5E5E0000000000666666000000000000000000000000000000
      000000000000000000000000000000000000B9B9B900B1B1B100DEDEDE00DADA
      DA00EDEDED00E1E1E100E2E2E200E3E3E300E3E3E300E4E4E400E3E3E300EDED
      ED00E1E1E100B5B5B500000000000000000000000000AFAFAF00FCFCFC00DCDC
      DC00C9C9C900C9C9C900C9C9C900BEBEBE00AFAFAF00FCFCFC00DCDCDC00C9C9
      C900C9C9C900C9C9C900C9C9C900C9C9C900DCDCDC00FFFFFF00FDFDFD00E6E6
      E600DCDCDC00CFCFCF009C9C9C000000000000000000000000006F6F6F008A8A
      8A00888888008686860084848400AFAFAF00FDFDFD00DCDCDC00C9C9C900C9C9
      C900C9C9C900C9C9C900C9C9C900DCDCDC00FDFDFD00FDFDFD00F0F0F000E6E6
      E600D2D2D2009C9C9C00000000000000000000000000000000007A7A7A00FCFC
      FC00FBFBFB00FAFAFA00F3F3F3006F6F6F00606060006F6F6F00606060004B4B
      4B0092929200B6B6B600D0D0D000797979006B6B6B0055555500323232009B9B
      9B00C6C6C6005252520066666600969696000000000000000000000000000000
      000000000000000000000000000000000000A4A4A400D2D2D200D5D5D500DFDF
      DF00E0E0E000E1E1E100CECECE0066666600E2E2E200E2E2E200E3E3E300E3E3
      E300EDEDED00EAEAEA00BDBDBD000000000000000000AFAFAF00FCFCFC00F4F4
      F400F1F1F100F0F0F000EEEEEE00D7D7D700AFAFAF00FCFCFC00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AFAFAF009C9C
      9C009C9C9C009C9C9C009C9C9C00000000000000000000000000707070008C8C
      8C008B8B8B008989890088888800AFAFAF00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00AFAFAF009C9C9C009C9C
      9C009C9C9C009C9C9C00000000000000000000000000000000007A7A7A00FCFC
      FC00FCFCFC00FBFBFB00F3F3F3006F6F6F009F9F9F006F6F6F006E6E6E007373
      7300797979008E8E8E009E9E9E006B6B6B005555550032323200323232008787
      8700999999004848480083838300969696000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD00CCCCCC00DADADA00DEDE
      DE00E0E0E000E0E0E000CECECE0066666600E1E1E100E2E2E200E2E2E200E3E3
      E300E3E3E300E2E2E200A8A8A8000000000000000000AFAFAF00FCFCFC00DCDC
      DC00C9C9C900C9C9C900C9C9C900BEBEBE00AFAFAF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AFAFAF00FFFF
      FF00FFFFFF00E6E6E6009C9C9C00000000000000000000000000707070009090
      90008D8D8D008C8C8C008A8A8A00AFAFAF00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00AFAFAF00FFFFFF00FFFF
      FF00E6E6E6009C9C9C00000000000000000000000000000000007A7A7A00FCFC
      FC00FCFCFC00FCFCFC00F4F4F4006F6F6F009F9F9F005D5D5D00A5A5A5007272
      720062626200575757005B5B5B00575757004747470046464600424242005454
      54006F6F6F0089898900A3A3A300A6A6A6000000000000000000000000000000
      0000000000000000000000000000BDBDBD00CACACA00D0D0D000DBDBDB00DDDD
      DD00CECECE00CECECE00CECECE0066666600D6D6D600D6D6D600D6D6D600E2E2
      E200E3E3E300E3E3E300C1C1C100BDBDBD0000000000AFAFAF00FCFCFC00F7F7
      F700F5F5F500F4F4F400F1F1F100D7D7D700AFAFAF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AFAFAF00FFFF
      FF00E6E6E6009C9C9C0000000000000000000000000000000000717171009292
      9200909090008E8E8E008D8D8D00AFAFAF00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00AFAFAF00FFFFFF00E6E6
      E6009C9C9C0000000000000000000000000000000000000000007A7A7A00FCFC
      FC00FCFCFC00FCFCFC00F5F5F5006F6F6F009F9F9F0078787800DDDDDD00A5A5
      A500969696007D7D7D00696969007878780089898900919191008E8E8E008F8F
      8F00A6A6A600BCBCBC00CCCCCC00A6A6A6000000000000000000000000000000
      0000000000000000000000000000AEAEAE00D2D2D200D1D1D100D2D2D200DBDB
      DB0066666600666666006666660066666600666666006666660066666600E1E1
      E100E2E2E200E2E2E200D2D2D200A4A4A40000000000AFAFAF00FCFCFC00DCDC
      DC00C9C9C900C9C9C900C9C9C900BEBEBE00AFAFAF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AFAFAF00E6E6
      E6009C9C9C000000000000000000000000000000000000000000717171009595
      9500939393009292920090909000AFAFAF00FDFDFD00FDFDFD00FDFDFD00FDFD
      FD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00FDFDFD00AFAFAF00E6E6E6009C9C
      9C000000000000000000000000000000000000000000000000007A7A7A00FCFC
      FC00FCFCFC00FCFCFC00F5F5F5006F6F6F009F9F9F009E9E9E00DDDDDD00D9D9
      D90095959500B2B2B2009E9E9E00A6A6A600C4C4C400D0D0D000D4D4D400D5D5
      D500DBDBDB00DADADA009E9E9E00000000000000000000000000000000000000
      0000000000000000000000000000AEAEAE00D2D2D200CFCFCF00D2D2D200E4E4
      E400CECECE00CECECE00CECECE0066666600CECECE00CECECE00CECECE00E2E2
      E200E2E2E200DFDFDF00D2D2D200A4A4A40000000000AFAFAF00FCFCFC00FAFA
      FA00F9F9F900F7F7F700F5F5F500F4F4F400AFAFAF009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
      9B00000000000000000000000000000000000000000000000000727272009696
      9600969696009494940093939300AFAFAF009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B005D5D
      5D000000000000000000000000000000000000000000000000007A7A7A006262
      62006262620062626200606060006F6F6F009F9F9F00A0A0A000EFEFEF00ECEC
      EC00BABABA009E9E9E00B9B9B900D2D2D200E1E1E100EBEBEB00E9E9E900E8E8
      E800DCDCDC009E9E9E0000000000000000000000000000000000000000000000
      0000000000000000000000000000BDBDBD00CACACA00CACACA00D5D5D500D2D2
      D200E4E4E400EDEDED00E4E4E40066666600CECECE00E0E0E000E0E0E000E1E1
      E100DEDEDE00DADADA00C1C1C100BDBDBD0000000000AFAFAF00FCFCFC00DCDC
      DC00C9C9C900C9C9C900C9C9C900C9C9C900C9C9C900DCDCDC00F0F0F000EEEE
      EE00E6E6E600DCDCDC00D2D2D2009C9C9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000737373009696
      9600969696009696960095959500949494009292920090909000909090008D8D
      8D008C8C8C008A8A8A0089898900868686008585850083838300828282005D5D
      5D000000000000000000000000000000000000000000000000007A7A7A006868
      68006868680068686800676767006F6F6F0060606000606060009E9E9E009E9E
      9E009E9E9E005A5A5A009E9E9E009E9E9E009E9E9E009E9E9E009E9E9E009E9E
      9E009E9E9E005656560000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD00C5C5C500CECECE00D6D6
      D600D2D2D200E4E4E400DCDCDC0066666600CECECE00DEDEDE00DEDEDE00DCDC
      DC00D8D8D800D3D3D300A4A4A4000000000000000000AFAFAF00FCFCFC00FEFE
      FE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00FEFEFE00AFAF
      AF009C9C9C009C9C9C009C9C9C009C9C9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000737373009696
      96009696960096969600B3B3B300A0A0A000A0A0A000A0A0A000A0A0A000A0A0
      A000A0A0A000A0A0A000A0A0A000A0A0A0008888880086868600848484005D5D
      5D00000000000000000000000000000000000000000000000000676767009090
      90009090900090909000909090008F8F8F008D8D8D008C8C8C008C8C8C008C8C
      8C008C8C8C008D8D8D008E8E8E00C4C4C400A5A5A500C2C2C200A5A5A5009090
      90007A797B007171710000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A4A4A400D2D2D200CACACA00D0D0
      D000D6D6D600D7D7D700D8D8D800D9D9D900DADADA00DBDBDB00D9D9D900D6D6
      D600D2D2D200DADADA00BDBDBD000000000000000000AFAFAF00FFFFFF00FFFF
      FF00FEFEFE00FCFCFC00FBFBFB00FEFEFE00FEFEFE00FEFEFE00FEFEFE00AFAF
      AF00FFFFFF00FFFFFF00E6E6E6009C9C9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000737373009696
      96009696960096969600B6B6B600D8D8D800D1D1D100CACACA00BDBDBD00B7B7
      B700ABABAB00A5A5A500A0A0A000A0A0A0008B8B8B0089898900888888005E5E
      5E00000000000000000000000000000000000000000000000000000000007373
      7300737373007373730073737300737373007373730073737300737373007373
      7300737373007373730073737300737373007373730073737300737373007373
      7300737373000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A9A9A900E4E4E400CECE
      CE00CECECE00D0D0D000D1D1D100D2D2D200D2D2D200D1D1D100D0D0D000CECE
      CE00E2E2E200A4A4A400000000000000000000000000AFAFAF00FFFFFF00FFFF
      FF00FFFFFF00FEFEFE00FEFEFE00FDFDFD00FEFEFE00FEFEFE00FEFEFE00AFAF
      AF00FFFFFF00E6E6E6009C9C9C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007373
      73009696960096969600B6B6B600E6E6E600E6E6E600D8D8D800D1D1D100C3C3
      C300BDBDBD00B1B1B100ABABAB00A0A0A0008D8D8D008C8C8C00676767000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000ACACAC00E4E4
      E400CECECE00CACACA00C8C8C800C7C7C700C5C5C500C5C5C500C3C3C300DADA
      DA00ADADAD0000000000000000000000000000000000AFAFAF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AFAF
      AF00E6E6E6009C9C9C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006E6E6E006E6E6E006E6E6E00B6B6B600E6E6E600E6E6E600E0E0E000D8D8
      D800CACACA00C3C3C300A0A0A0006C6C6C006C6C6C006C6C6C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ADAD
      AD00BDBDBD00DADADA00DEDEDE00DEDEDE00DEDEDE00DADADA00CACACA00ADAD
      AD000000000000000000000000000000000000000000AFAFAF009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B6B6B600AAAAAA00AAAAAA00AAAA
      AA00A9A9A900A7A7A70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BDBDBD00A9A9A900B5B5B500B5B5B500ADADAD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004848480048484800B9B9B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9
      B900B9B9B900B9B9B900B9B9B900B9B9B900B9B9B90059595900616161006666
      6600666666003B3B3B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A7A7A7009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B009B9B9B009B9B9B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000676767005F5F5F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004D4D
      4D006868680054545400BBBBBB00606060006C6C6C007777770052525200C8C8
      C800CECECE00D3D3D300D6D6D600DCDCDC00DCDCDC0050505000595959006161
      6100666666003E3E3E003B3B3B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000676767008C8C
      8C00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A7A7A700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006E6E
      6E006E6E6E005F5F5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F
      5F005F5F5F005F5F5F00676767008C8C8C0066666600505050005F5F5F005F5F
      5F005F5F5F006E6E6E00000000000000000000000000000000004C4C4C006D6D
      6D006A6A6A0054545400B9B9B90058585800606060006C6C6C0052525200C2C2
      C200C5C5C500CBCBCB00D0D0D000D6D6D600DCDCDC004A4A4A00505050005959
      59005D5D5D00404040003E3E3E00000000000000000000000000000000006E6E
      6E006E6E6E005F5F5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F
      5F005F5F5F005F5F5F005F5F5F005F5F5F005F5F5F00676767008C8C8C005F5F
      5F005F5F5F006E6E6E0000000000000000000000000000000000000000000000
      000000000000000000000000000067676700A7A7A700FFFFFF00E2E2E200AFAF
      AF00AFAFAF00AFAFAF00AFAFAF00FFFFFF009B9B9B0067676700000000000000
      00000000000000000000000000000000000000000000000000006E6E6E006E6E
      6E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E
      7E007E7E7E00676767008C8C8C006B6B6B006969690066666600505050009797
      970097979700A4A4A4006E6E6E000000000000000000000000004D4D4D007171
      71006E6E6E0054545400B7B7B70054545400585858006060600052525200C0C0
      C000C2C2C200C5C5C500CBCBCB00D0D0D000D6D6D600474747004A4A4A004C4C
      4C0054545400434343003D3D3D000000000000000000000000006E6E6E006E6E
      6E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E7E007E7E
      7E007E7E7E007E7E7E007E7E7E008A8A8A00676767008C8C8C005F5F5F009797
      970097979700A4A4A4006E6E6E00000000000000000000000000000000000000
      0000000000004A4A4A004A4A4A0067676700A7A7A700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B00676767004A4A4A004A4A
      4A000000000000000000000000000000000000000000000000006E6E6E007878
      78007E7E7E008A8A8A008A8A8A008A8A8A0091919100979797009D9D9D00A4A4
      A400676767008C8C8C00717171006E6E6E006B6B6B006A6A6A00686868004B4B
      4B00C7C7C700D4D4D4006E6E6E000000000000000000000000004E4E4E007373
      73007171710054545400B4B4B40050505000545454005656560052525200BEBE
      BE00C0C0C000C2C2C200C5C5C500CBCBCB00D0D0D00043434300474747004848
      48004C4C4C00464646003E3E3E000000000000000000000000006E6E6E007878
      78007E7E7E008A8A8A008A8A8A008A8A8A0091919100979797009D9D9D00A4A4
      A400AAAAAA00B0B0B000B6B6B600676767008C8C8C005F5F5F00C3C3C300C5C5
      C500C7C7C700D4D4D4006E6E6E00000000000000000000000000000000004A4A
      4A004A4A4A00636363006F6F6F0067676700A7A7A700FFFFFF00E2E2E200AFAF
      AF00AFAFAF00AFAFAF00AFAFAF00FFFFFF009B9B9B00676767004A4A4A006363
      63004A4A4A004A4A4A0000000000000000000000000000000000646464007878
      78008A8A8A0091919100979797009D9D9D00A4A4A400AAAAAA00B0B0B0006767
      67008C8C8C007676760073737300727272006F6F6F006D6D6D006A6A6A006969
      69004B4B4B00EEEEEE006E6E6E000000000000000000000000004F4F4F007676
      76007373730054545400B2B2B2004B4B4B00505050005252520052525200BCBC
      BC00BEBEBE00C0C0C000C2C2C200C5C5C500C8C8C80040404000434343004545
      450048484800484848003F3F3F00000000000000000000000000646464007878
      78008A8A8A0091919100979797009D9D9D00A4A4A400AAAAAA00B0B0B000B6B6
      B600BDBDBD00BEBEBE00676767008C8C8C007878780055555500CACACA00CBCB
      CB00CECECE00EEEEEE006E6E6E000000000000000000000000004A4A4A006363
      630073737300929292007C7C7C0067676700A7A7A700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009B9B9B00676767004A4A4A007F7F
      7F0073737300636363004A4A4A000000000000000000000000005F5F5F007878
      78009D9D9D00A4A4A400AAAAAA00B0B0B000B6B6B600BDBDBD00BEBEBE006767
      6700676767006767670077777700747474007272720067676700676767006767
      670067676700F7F7F7006E6E6E000000000000000000000000004F4F4F007979
      79007676760054545400B0B0B000474747004B4B4B004D4D4D0052525200BABA
      BA00BCBCBC00BDBDBD00BFBFBF00C1C1C100C3C3C3003D3D3D003F3F3F004242
      4200454545004C4C4C003F3F3F000000000000000000000000005F5F5F007878
      78009D9D9D00A4A4A400AAAAAA00B0B0B000B6B6B600BDBDBD00BEBEBE00C1C1
      C100C3C3C300C5C5C500676767007D7D7D005F5F5F00CECECE00D0D0D000D2D2
      D200D4D4D400F7F7F7006E6E6E00000000000000000063636300737373008383
      8300B0B0B000B1B1B1007C7C7C00676767009C9C9C00D2D2D200D2D2D200D2D2
      D200D2D2D200D2D2D200D2D2D200D2D2D2009C9C9C00676767004A4A4A008383
      83007C7C7C0073737300636363004A4A4A0000000000000000005F5F5F007878
      78009D9D9D00AAAAAA00B6B6B600BEBEBE00C1C1C100C3C3C300C5C5C500C7C7
      C700CACACA00CBCBCB00676767008C8C8C007474740055555500D2D2D200D9D9
      D900DBDBDB00F7F7F7006E6E6E00000000000000000000000000505050007B7B
      7B007A7A7A0054545400AEAEAE00B0B0B000B2B2B200B4B4B400B6B6B600B7B7
      B700B9B9B900BBBBBB00BDBDBD00BFBFBF00C1C1C1003A3A3A003B3B3B003F3F
      3F00424242004F4F4F00404040000000000000000000000000005F5F5F007878
      78009D9D9D00AAAAAA00B6B6B600BEBEBE00C1C1C100C3C3C300C5C5C500C7C7
      C700CACACA00676767008C8C8C007878780055555500D4D4D400D7D7D700D9D9
      D900DBDBDB00F7F7F7006E6E6E00000000000000000073737300B1B1B100D2D2
      D200B1B1B100B1B1B100696969004A4A4A004A4A4A004A4A4A004A4A4A004A4A
      4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A00636363008686
      86007F7F7F00767676006C6C6C004A4A4A000000000000000000646464007878
      78009D9D9D00B6B6B600C3C3C300C5C5C500C7C7C700CACACA00CBCBCB00CECE
      CE00D0D0D000DDDDDD00676767008C8C8C00787878005F5F5F00DDDDDD00DDDD
      DD00E0E0E000FCFCFC006E6E6E00000000000000000000000000515151007F7F
      7F007D7D7D005454540054545400545454005454540054545400545454005454
      5400545454005454540054545400545454005454540054545400545454005454
      5400545454005151510042424200000000000000000000000000646464007878
      78009D9D9D00B6B6B600C3C3C300C5C5C500C7C7C700CACACA00CBCBCB00CECE
      CE00D0D0D000676767007D7D7D007878780055555500D9D9D900DBDBDB00DDDD
      DD00E0E0E000FCFCFC006E6E6E00000000000000000073737300D2D2D200B4B4
      B400B1B1B100B1B1B100B1B1B100B1B1B100B1B1B100B1B1B100B1B1B100B1B1
      B100B1B1B100AEAEAE00A7A7A700A3A3A3009D9D9D0096969600969696005E5E
      5E004E4E4E00797979006F6F6F004A4A4A000000000000000000646464007878
      7800B0B0B000C7C7C700CACACA00CBCBCB00CECECE00D0D0D000D0D0D000D2D2
      D200D4D4D400D2D2D200676767008C8C8C0055555500D2D2D200E1E1E100E4E4
      E400E6E6E600FCFCFC006E6E6E00000000000000000000000000525252008282
      82007F7F7F007D7D7D007A7A7A007777770075757500727272006F6F6F006E6E
      6E006C6C6C00696969006666660064646400616161005E5E5E005C5C5C005959
      5900575757005454540042424200000000000000000000000000646464007878
      7800B0B0B000C7C7C700CACACA00CBCBCB00CECECE00D0D0D000676767006767
      6700676767006767670072727200747474007777770067676700676767004B4B
      4B00E6E6E600FCFCFC006E6E6E00000000000000000073737300D2D2D200B1B1
      B100B1B1B100B1B1B100969696007F7F7F007876770077777700777777007472
      7300747273007472730074727300747273007472730088868700969696007F7F
      7F005E5E5E007C7C7C00737373004A4A4A0000000000000000006E6E6E007878
      7800C3C3C300CBCBCB00CECECE00D0D0D000D2D2D200D4D4D400D7D7D700D9D9
      D900DBDBDB00676767008C8C8C00808080005F5F5F00DDDDDD00E8E8E800EAEA
      EA00EDEDED00FCFCFC006E6E6E00000000000000000000000000535353008484
      8400E6E6E600F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700E6E6E60058585800434343000000000000000000000000006E6E6E007878
      7800C3C3C300CBCBCB00CECECE00D0D0D000D2D2D200D4D4D400676767008C8C
      8C006A6A6A006D6D6D006F6F6F00727272007373730076767600717171004B4B
      4B00EDEDED00FCFCFC006E6E6E00000000000000000073737300D2D2D200B1B1
      B100969696007C7A7B00848282009494940090909000A5A3A300A5A3A300A5A3
      A300A5A3A300A5A3A300AEACAC00AEACAC0090909000949494008B8587006F6F
      6F00868686007C7C7C00737373004A4A4A0000000000000000006E6E6E007878
      7800C3C3C300EDEDED00D4D4D400D7D7D700D9D9D900DBDBDB00DDDDDD00E0E0
      E000D2D2D20067676700858585005F5F5F00D2D2D200EDEDED00EEEEEE00F1F1
      F100F3F3F300FCFCFC006E6E6E00000000000000000000000000555555008989
      8900F7F7F700F8F8F800F8F8F800F8F8F800F9F9F900F9F9F900F9F9F900F9F9
      F900FAFAFA00FBFBFB00FBFBFB00FCFCFC00FDFDFD00FDFDFD00FEFEFE00FFFF
      FF00FFFFFF005B5B5B00444444000000000000000000000000006E6E6E007878
      7800C3C3C300EDEDED00D4D4D400D7D7D700D9D9D900DBDBDB00DDDDDD006767
      67008C8C8C006A6A6A006B6B6B006E6E6E00717171006E6E6E004B4B4B00F1F1
      F100F3F3F300FCFCFC006E6E6E00000000000000000073737300D2D2D200B1B1
      B100838383006866660094949400909090009090900090909000909090009090
      9000909090009090900096969600969696009696960096969600949494006E68
      6900989095007C7C7C00737373004A4A4A0000000000000000006E6E6E007878
      7800E1E1E100F3F3F300F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100F0F0
      F000676767008C8C8C005F5F5F00D2D2D200F1F1F100F3F3F300F6F6F600F7F7
      F700FAFAFA00FCFCFC006E6E6E00000000000000000000000000575757009191
      9100F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700FEFE
      FE00FFFFFF005D5D5D00454545000000000000000000000000006E6E6E007878
      7800E1E1E100F3F3F300F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100E6E6
      E600676767008C8C8C00696969006B6B6B006E6E6E004B4B4B00F6F6F600F7F7
      F700FAFAFA00FCFCFC006E6E6E0000000000000000007B7B7B00D2D2D200BEBE
      BE00888687006361610068666600454545005252520052525200525252004A4A
      4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A0045454500686666006361
      6100918F90007C7C7C00737373006363630000000000000000006E6E6E007878
      780078787800787878007878780078787800787878007F7F7F00DDDDDD006767
      67008C8C8C005F5F5F00D2D2D200F6F6F600F7F7F700FAFAFA00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC006E6E6E00000000000000000000000000595959009696
      9600F7F7F700F7F7F700D8D8D8009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A00D8D8D800FDFD
      FD00FEFEFE0060606000464646000000000000000000000000006E6E6E007878
      780078787800787878007878780078787800787878007F7F7F00DDDDDD00F1F1
      F100EEEEEE00676767008C8C8C006E6E6E004B4B4B00FAFAFA00FCFCFC00FCFC
      FC00FCFCFC00FCFCFC006E6E6E0000000000000000008C8C8C00B1B1B100D2D2
      D200A19FA0002E2C2C004A4A4A00393939006B6B6B007D7D7D007D7D7D007D7D
      7D007D7D7D007D7D7D007D7D7D007D7D7D007D7D7D0041414100393939003535
      3500A0A0A0007C7C7C00737373006C6C6C0000000000000000006E6E6E007F7F
      7F007E7E7E007E7E7E008B8B8B0098989800A4A4A400A4A4A4007F7F7F008C8C
      8C0067676700F0F0F000FAFAFA00FCFCFC00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00E8E8E8006E6E6E000000000000000000000000005B5B5B009B9B
      9B00F7F7F700F7F7F700F7F7F700F7F7F700F8F8F800F8F8F800F8F8F800F8F8
      F800F9F9F900F9F9F900F9F9F900FAFAFA00FAFAFA00FBFBFB00FCFCFC00FDFD
      FD00FDFDFD0062626200474747000000000000000000000000006E6E6E007F7F
      7F007E7E7E007E7E7E008B8B8B0098989800A4A4A400A4A4A4007F7F7F00DDDD
      DD00F6F6F600F7F7F7005F5F5F004B4B4B00FCFCFC00FCFCFC00FCFCFC00FCFC
      FC00FCFCFC00E8E8E8006E6E6E000000000000000000000000007B7B7B00D2D2
      D200B1B1B100313131004A4A4A00A7A7A700F1F1F100F3F3F300F4F4F400F5F5
      F500F7F7F700F9F9F900FBFBFB00FDFDFD00FFFFFF009B9B9B006F6F6F003535
      3500ADADAD007C7C7C00636363000000000000000000000000006E6E6E007F7F
      7F0098989800A4A4A400B1B1B100BDBDBD00C0C0C000C4C4C400C7C7C7007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F00000000000000000000000000000000005C5C5C00A0A0
      A000F7F7F700F6F6F600F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700FBFB
      FB00FCFCFC0066666600484848000000000000000000000000006E6E6E007F7F
      7F0098989800A4A4A400B1B1B100BDBDBD00C0C0C000C4C4C400C7C7C7007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F
      7F007F7F7F007F7F7F00000000000000000000000000000000008C8C8C00B1B1
      B100B5B5B500989898007B7B7B00A7A7A700F6F6F600F1F1F100F2F2F200F3F3
      F300F5F5F500F6F6F600F8F8F800FAFAFA00FCFCFC009B9B9B00706E6F009898
      9800B1B1B100B1B1B1006C6C6C000000000000000000000000006E6E6E007F7F
      7F00BDBDBD00C0C0C000C4C4C400C7C7C700CBCBCB00CECECE00D2D2D200D5D5
      D500D9D9D900DCDCDC00D9D9D900D9D9D900D9D9D900D9D9D900D9D9D900D9D9
      D900D9D9D90078787800000000000000000000000000000000005E5E5E00A6A6
      A600F7F7F700F6F6F600D8D8D8009A9A9A009A9A9A009A9A9A009A9A9A009A9A
      9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A009A9A9A00D8D8D800FBFB
      FB00FBFBFB0069696900484848000000000000000000000000006E6E6E007F7F
      7F00BDBDBD00C0C0C000C4C4C400C7C7C700CBCBCB00CECECE00D2D2D200D5D5
      D500D9D9D900DCDCDC00D9D9D900D9D9D900D9D9D900D9D9D900D9D9D900D9D9
      D900D9D9D9007878780000000000000000000000000000000000000000008C8C
      8C007B7B7B007B7B7B007B7B7B00A7A7A700FAFAFA00F6F6F600F1F1F100F2F2
      F200F3F3F300F5F5F500F6F6F600F8F8F800EBEBEB009B9B9B007B7B7B007B7B
      7B007B7B7B007B7B7B00000000000000000000000000000000006E6E6E007F7F
      7F00C7C7C700CBCBCB00CECECE00D2D2D200D5D5D500D9D9D900DCDCDC00E0E0
      E000DDDDDD007878780078787800787878007878780078787800787878007878
      780078787800000000000000000000000000000000000000000061616100ADAD
      AD00F7F7F700F6F6F600F6F6F600F6F6F600F7F7F700F7F7F700F7F7F700F6F6
      F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6
      F600FBFBFB006C6C6C004A4A4A000000000000000000000000006E6E6E007F7F
      7F00C7C7C700CBCBCB00CECECE00D2D2D200D5D5D500D9D9D900DCDCDC00E0E0
      E000DDDDDD007878780078787800787878007878780078787800787878007878
      7800787878000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A7A7A700FFFFFF00FAFAFA00F6F6F600F1F1
      F100F2F2F200EAEAEA00E2E2E200E3E3E300DFDFDF009B9B9B00000000000000
      0000000000000000000000000000000000000000000000000000000000007878
      7800BEBEBE00E0E0E000F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100E0E0
      E000787878000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000062626200B3B3
      B300F7F7F700F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6
      F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6F600F6F6
      F600FAFAFA006E6E6E004B4B4B00000000000000000000000000000000007878
      7800BEBEBE00E0E0E000F1F1F100F1F1F100F1F1F100F1F1F100F1F1F100E0E0
      E000787878000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A7A7A700FFFFFF00FDFDFD00F6F6F600F6F6
      F600F1F1F100A7A7A7009B9B9B009B9B9B009B9B9B009B9B9B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000787878007878780078787800787878007878780078787800787878007878
      7800000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000064646400B8B8
      B800F7F7F700F5F5F500F5F5F500F6F6F600F6F6F600F6F6F600F7F7F700F7F7
      F700F7F7F700F7F7F700F8F8F800F8F8F800F8F8F800F9F9F900F9F9F900F9F9
      F900F9F9F900717171004B4B4B00000000000000000000000000000000000000
      0000787878007878780078787800787878007878780078787800787878007878
      7800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A7A7A700FFFFFF00FEFEFE00FAFAFA00F6F6
      F600EFEFEF00A7A7A700FFFFFF00FFFFFF00E6E6E6009B9B9B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000066666600BDBD
      BD00909090008B8B8B008989890085858500808080007C7C7C007A7A7A007777
      77007575750073737300707070006E6E6E006C6C6C0069696900676767006565
      650064646400757575004C4C4C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A7A7A700FFFFFF00FFFFFF00FFFFFF00FAFA
      FA00F6F6F600A7A7A700FFFFFF00E6E6E6009B9B9B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006666
      660096969600929292008D8D8D008989890085858500808080007C7C7C007A7A
      7A00777777007575750073737300707070006E6E6E006D6D6D006B6B6B006868
      6800666666004E4E4E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A7A7A700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FAFAFA00A7A7A700E6E6E6009B9B9B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A7A7A7009B9B9B009B9B9B009B9B9B009B9B
      9B009B9B9B009B9B9B009B9B9B00000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000060000000C00000000100010000000000000900000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000E00003FFFFFFFFF800E00003E00003FF
      FFFFFFF800E00003E00003FFFFFFFFF800E00003E00003C00003FFF800E00003
      E00003800001FFF800E00003E00003800001FFF800E00003E00003800001FFF8
      00E00003E00003800001FFF800E00003E00003800001FFF800E00003E0000380
      0001FFF800E00003E00003800001000801E00003E00003800001000803E00003
      E00003800001000807E00003E00003800001000FC3E00003E00003800001000F
      81E00003E00003800001000F00E00003E00003800001000F00E00003E0000380
      0001000FC3E00003E00003800001000FC3E00003E00007800003000FC3E00007
      E0000F803FFF000FC3E0000FE0001FC07FFF001F87E0001FE0003FFFFFFF0020
      0FE0003FFFFFFFFFFFFF00701FFFFFFFFF00FFFF00FFE00003FF00FFFC003FFC
      003FE00003FC003FF0000FF0000FE00003F0000FE00007E00007E00003E00007
      C00003C00003E00003C00003C00003C00003E00003C00003800001800001E000
      03800001800001800001E00003800001000000000000E0000300000000000000
      0000E00003000000000000000000E00003000000000000000000E00003000000
      000000000000E00003000000000000000000E00003000000000000000000E000
      03000000000000000000E00003000000800001800001E0000380000180000180
      0001E00003800001C00003C00003E00003C00003C00003C00003E00007C00003
      E00007E00007E0000FE00007F0000FF0000FE0001FF0000FFC003FFC003FE000
      3FFC003FFF00FFFF00FFFFFFFFFF00FFFF00FFFF00FFFF00FFFF00FFFC003FFC
      003FFC003FFC003FF0000FF0000FF0000FF0000FE00007E00007E00007E00007
      C00003C00003C00003C00003C00003C00003C00003C000038000018000018000
      0180000180000180000180000180000100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000080000180000180000180000180000180
      0001800001800001C00003C00003C00003C00003C00003C00003C00003C00003
      E00007E00007E00007E00007F0000FF0000FF0000FF0000FFC003FFC003FFC00
      3FFC003FFF00FFFF00FFFF00FFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFF
      FFFFFF00FFFC003FFFFFFFFFFFFFFC003FF0000FFFBFFFFFFDFFF8001FE00007
      FF3FFFFFFCFFF0000FC00003FE3FFFFFFC7FE00007C00003FC3FFFFFFC3FC000
      03800001F80003C0001FC00003800001F00003C0000F800001000000E00003C0
      0007800001000000C00003C00003800001000000800003C00001800001000000
      C00003C00003800001000000E00003C00007800001000000F00003C0000F8000
      01000000F83FFFFFFC1F800001000000FC3FFFFFFC3FC00003800001FE3FFFFF
      FC7FC00003800001FF3FFFFFFCFFE00007C00003FFBFFFFFFDFFF0000FC00003
      FFFFFFFFFFFFF8001FE00007FFFFFFFFFFFFFC003FF0000FFFFFFFFFFFFFFF00
      FFFC003FFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF800001FFFFFFF8003FF8003F8000010001FFFC007FFC007F8000010001FF
      FE00FFFE00FF8000010001FFC00003C000038000010001FF8000018000018000
      010001FF8000018000018000010001FF8000018000018000010001FF80000180
      00018000010001FF8000018000018000010001FF8000018000018000010001FF
      8000018000018000010001FF8000018000018000010001F08000018000018000
      0100018080000180000180000100000080000180000180000100000080000180
      0001800001000000800001800001800001000000800001800001800001000000
      800001800001800001FF8000800001800001C00003FFE080C00003C00003FFFF
      FFFFFFF0FFFFFFFFFFFFFFFFFFFFFFFFFF0001FE0003FF1E1FCFFFFFFF0001C0
      0003FF1E1F87FFFFFF0001C00003C0000303FFFFFF0001C00003C0000301FFFF
      FF0001C00003C0000300FFFFFF0001C00003C00003807FFF800001C00003C000
      03C03FFF800001C00003C00003E03FFF800001C00003C00003F0301F800001C0
      0003C00003F8000F800001C00003C00003FF0003800001C00003C00002FF0003
      800001C00003C00000FF0001800001C00003C00000FF0001800001C00003C000
      00FE0000800003C00007C00000FE0000800007C0000FC00001FE000080000FC0
      000FC00003FE00008000FFC0000FC00003FF00018000FFC0000FC00003FF0001
      8000FFC0000FE00007FF80038001FFE0001FFFFFFFFFC0078003FFF0003FFFFF
      FFFFE00F8007FFFF03FFFFFFFFFFF83FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
      0003FFFFFFFF007FFFFE7FE00001FFFFCFFF007FE00003C00001E00003FE003F
      C00001C00001C00001F8000FC00001C00001C00001E00003C00001C00001C000
      01C00001C00001C00001C00001800000C00001C00001C00001800000C00001C0
      0001C00001800000C00001C00001C00001800000C00001C00001C00001800000
      C00001C00001C00001800000C00001C00001C00001800000C00001C00001C000
      01800000C00001C00001C00001C00001C00003C00001C00003C00001C00003C0
      0001C00003E00003C00007C00001C00007FE003FE007FFC00001E007FFFE003F
      F00FFFC00001F00FFFFE003FFFFFFFC00001FFFFFFFE007FFFFFFFE00003FFFF
      FFFE00FFFFFFFFFFFFFFFFFFFFFE01FF00000000000000000000000000000000
      000000000000}
  end
end
