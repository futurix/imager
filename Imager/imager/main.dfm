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
  object splSide: TSplitter
    Left = 200
    Top = 84
    Height = 486
    AutoSnap = False
    MinSize = 150
    ResizeStyle = rsUpdate
    Visible = False
  end
  object tbrMain: TToolBar
    Left = 0
    Top = 0
    Width = 826
    Height = 28
    AutoSize = True
    BorderWidth = 1
    Caption = 'Main ToolBar'
    DisabledImages = imlDisabled
    Flat = True
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
      Left = 23
      Top = 0
      Hint = 'Last Image|Load last image'
      Caption = 'Last'
      ImageIndex = 20
      ParentShowHint = False
      ShowHint = True
      OnClick = tbnLastClick
    end
    object tbnSave: TToolButton
      Left = 46
      Top = 0
      Hint = 'Save as...|Save image in variety of formats'
      Caption = 'Save'
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = miSaveAsClick
    end
    object tbnClose: TToolButton
      Left = 69
      Top = 0
      Hint = 'Close|Close image'
      Caption = 'Close'
      ImageIndex = 3
      ParentShowHint = False
      ShowHint = True
      OnClick = miCloseClick
    end
    object Sep_1: TToolButton
      Left = 92
      Top = 0
      Width = 8
      Caption = 'Sep_1'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object tbnPrint: TToolButton
      Left = 100
      Top = 0
      Hint = 'Print|Print image (hold SHIFT to skip preview)'
      Caption = 'Print'
      ImageIndex = 4
      ParentShowHint = False
      ShowHint = True
      OnClick = tbnPrintClick
    end
    object Sep_2: TToolButton
      Left = 123
      Top = 0
      Width = 8
      Caption = 'Sep_2'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object tbnCopy: TToolButton
      Left = 131
      Top = 0
      Hint = 'Copy|Copy image to clipboard'
      Caption = 'Copy'
      ImageIndex = 6
      ParentShowHint = False
      ShowHint = True
      OnClick = miCopyClick
    end
    object tbnPaste: TToolButton
      Left = 154
      Top = 0
      Hint = 'Paste|Paste from clipboard'
      Caption = 'Paste'
      ImageIndex = 7
      ParentShowHint = False
      ShowHint = True
      OnClick = miPasteClick
    end
    object Sep_12: TToolButton
      Left = 177
      Top = 0
      Width = 8
      Caption = 'Sep_12'
      ImageIndex = 24
      Style = tbsSeparator
    end
    object tbnFilters: TToolButton
      Left = 185
      Top = 0
      Hint = 'Filters|Transform image using filters'
      Caption = 'Filters'
      ImageIndex = 8
      ParentShowHint = False
      ShowHint = True
      OnClick = miFiltersDialogClick
    end
    object Sep_3: TToolButton
      Left = 208
      Top = 0
      Width = 8
      Caption = 'Sep_3'
      ImageIndex = 5
      Style = tbsSeparator
    end
    object tbnFileBrowser: TToolButton
      Left = 216
      Top = 0
      Hint = 'File Browser|Open File Browser'
      Caption = 'Files'
      ImageIndex = 9
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = miFileManagerClick
    end
    object tbnFav: TToolButton
      Left = 239
      Top = 0
      Hint = 'Favorites|Open favorite images'
      Caption = 'Favorites'
      ImageIndex = 10
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = miFavoritesClick
    end
    object Sep_5: TToolButton
      Left = 262
      Top = 0
      Width = 8
      Caption = 'Sep_5'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object tbnZoom: TToolButton
      Left = 270
      Top = 0
      Hint = 'Zoom|Set image zoom'
      Caption = 'Zoom'
      DropdownMenu = popZoom
      ImageIndex = 13
      ParentShowHint = False
      ShowHint = True
      Style = tbsDropDown
      OnClick = miZMCustomClick
    end
    object tbnZoomFit: TToolButton
      Left = 306
      Top = 0
      Hint = 'Fit|Zoom to fit'
      Caption = 'Fit'
      ImageIndex = 14
      ParentShowHint = False
      ShowHint = True
      OnClick = miZoomtoFitClick
    end
    object tbnZoomOrig: TToolButton
      Left = 329
      Top = 0
      Hint = '1:1|Zoom to 100%'
      Caption = '1:1'
      ImageIndex = 15
      ParentShowHint = False
      ShowHint = True
      OnClick = miZM100Click
    end
    object tbnFullScreen: TToolButton
      Left = 352
      Top = 0
      Hint = 'Full Screen|Switch to full screen mode'
      Caption = 'FullScreen'
      ImageIndex = 16
      ParentShowHint = False
      ShowHint = True
      OnClick = miFullScreenClick
    end
    object Sep_7: TToolButton
      Left = 375
      Top = 0
      Width = 8
      Caption = 'Sep_7'
      ImageIndex = 20
      Style = tbsSeparator
    end
    object tbnInfo: TToolButton
      Left = 383
      Top = 0
      Hint = 'File Info|View file information'
      Caption = 'Info'
      ImageIndex = 17
      ParentShowHint = False
      ShowHint = True
      OnClick = miInfoClick
    end
    object Sep_8: TToolButton
      Left = 406
      Top = 0
      Width = 8
      Caption = 'Sep_8'
      ImageIndex = 24
      Style = tbsSeparator
    end
    object tbnShow: TToolButton
      Left = 414
      Top = 0
      Hint = 'Slide Show|Slide show in current folder'
      Caption = 'Slide Show'
      ImageIndex = 32
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = miShowClick
    end
    object Sep_9: TToolButton
      Left = 437
      Top = 0
      Width = 8
      Caption = 'Sep_9'
      ImageIndex = 26
      Style = tbsSeparator
    end
    object tbnBack: TToolButton
      Left = 445
      Top = 0
      Hint = 
        'Back|Go to previous image in current folder (hold SHIFT to jump ' +
        'to first image in folder)'
      Caption = 'Back'
      ImageIndex = 18
      ParentShowHint = False
      ShowHint = True
      OnClick = miBackClick
    end
    object tbnForward: TToolButton
      Left = 468
      Top = 0
      Hint = 
        'Forward|Go to next image in current folder (hold SHIFT to jump t' +
        'o last image in folder)'
      Caption = 'Forward'
      ImageIndex = 19
      ParentShowHint = False
      ShowHint = True
      OnClick = miForwardClick
    end
    object Sep_10: TToolButton
      Left = 491
      Top = 0
      Width = 8
      Caption = 'Sep_10'
      ImageIndex = 24
      Style = tbsSeparator
    end
    object tbnHelp: TToolButton
      Left = 499
      Top = 0
      Hint = 'Help|Help contents'
      Caption = 'Help'
      ImageIndex = 21
      ParentShowHint = False
      ShowHint = True
      OnClick = miHelpContentsClick
    end
    object tbnHome: TToolButton
      Left = 522
      Top = 0
      Hint = 'Futuris Web Site|Go to Futuris home page'
      Caption = 'Links'
      ImageIndex = 22
      ParentShowHint = False
      ShowHint = True
      OnClick = miFuturisWebSiteClick
    end
    object tbnAbout: TToolButton
      Left = 545
      Top = 0
      Hint = 'About|About Futuris Imager'
      Caption = 'About'
      ImageIndex = 23
      ParentShowHint = False
      ShowHint = True
      OnClick = miAboutClick
    end
  end
  object sbxMain: TScrollBox
    Left = 203
    Top = 84
    Width = 623
    Height = 486
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Align = alClient
    Color = clAppWorkSpace
    ParentColor = False
    PopupMenu = popMain
    TabOrder = 1
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
  object tbrMulti: TToolBar
    Left = 0
    Top = 56
    Width = 826
    Height = 28
    AutoSize = True
    BorderWidth = 1
    ButtonWidth = 88
    Caption = 'MultiPage Toolbar'
    Flat = True
    Images = imlMain
    List = True
    ShowCaptions = True
    TabOrder = 2
    Transparent = True
    Visible = False
    Wrapable = False
    object tbnMultiFirst: TToolButton
      Left = 0
      Top = 0
      Hint = 'First|Go to first page'
      AutoSize = True
      Caption = 'First'
      ImageIndex = 27
      ParentShowHint = False
      ShowHint = False
      OnClick = tbnMultiFirstClick
    end
    object tbnMultiPrev: TToolButton
      Left = 50
      Top = 0
      Hint = 'Previous|Go to previous page'
      AutoSize = True
      Caption = 'Previous'
      ImageIndex = 28
      ParentShowHint = False
      ShowHint = False
      OnClick = tbnMultiPrevClick
    end
    object tbnMultiNext: TToolButton
      Left = 122
      Top = 0
      Hint = 'Next|Go to next page'
      AutoSize = True
      Caption = 'Next'
      ImageIndex = 29
      ParentShowHint = False
      ShowHint = False
      OnClick = tbnMultiNextClick
    end
    object tbnMultiLast: TToolButton
      Left = 175
      Top = 0
      Hint = 'Last|Go to last page'
      AutoSize = True
      Caption = 'Last'
      ImageIndex = 30
      ParentShowHint = False
      ShowHint = False
      OnClick = tbnMultiLastClick
    end
    object MSep_1: TToolButton
      Left = 226
      Top = 0
      Width = 8
      Caption = 'MSep_1'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object tbnGoToPage: TToolButton
      Left = 234
      Top = 0
      Hint = 'Go To|Go to page'
      AutoSize = True
      Caption = 'Go To'
      ImageIndex = 20
      ParentShowHint = False
      ShowHint = False
      OnClick = tbnGoToPageClick
    end
    object tbnExtractPage: TToolButton
      Left = 295
      Top = 0
      Hint = 'Extract Page|Extract current page as untitled bitmap'
      AutoSize = True
      Caption = 'Extract Page'
      ImageIndex = 31
      ParentShowHint = False
      ShowHint = False
      OnClick = tbnExtractPageClick
    end
  end
  object tbrAnim: TToolBar
    Left = 0
    Top = 28
    Width = 826
    Height = 28
    AutoSize = True
    BorderWidth = 1
    ButtonWidth = 57
    Caption = 'Animation Toolbar'
    Flat = True
    Images = imlMain
    List = True
    ShowCaptions = True
    TabOrder = 3
    Transparent = True
    Visible = False
    Wrapable = False
    object tbnPlay: TToolButton
      Left = 0
      Top = 0
      Hint = 'Play|Start animation'
      AutoSize = True
      Caption = 'Play'
      ImageIndex = 24
      ParentShowHint = False
      ShowHint = False
      OnClick = tbnPlayClick
    end
    object tbnPause: TToolButton
      Left = 51
      Top = 0
      Hint = 'Pause|Pause animation'
      AutoSize = True
      Caption = 'Pause'
      ImageIndex = 25
      ParentShowHint = False
      ShowHint = False
      OnClick = tbnPauseClick
    end
    object tbnStop: TToolButton
      Left = 112
      Top = 0
      Hint = 'Stop|Stop animation'
      AutoSize = True
      Caption = 'Stop'
      ImageIndex = 26
      ParentShowHint = False
      ShowHint = False
      OnClick = tbnStopClick
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
  object pnlDock: TPanel
    Left = 0
    Top = 84
    Width = 200
    Height = 486
    Align = alLeft
    BevelOuter = bvNone
    DockSite = True
    TabOrder = 5
    Visible = False
  end
  object mnuMain: TMainMenu
    Left = 454
    Top = 102
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
      object N24: TMenuItem
        Caption = '-'
      end
      object miFileManager: TMenuItem
        Caption = 'File Manager'
        Hint = 'Toggle file manager'
        ShortCut = 114
        OnClick = miFileManagerClick
      end
      object miFavorites: TMenuItem
        Caption = 'Favorites'
        Hint = 'Open favorite images'
        ShortCut = 115
        OnClick = miFavoritesClick
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
        Caption = 'Imager Web Page'
        Hint = 'Leads you to Futuris web site'
        OnClick = miFuturisWebSiteClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object mTricks: TMenuItem
        Caption = 'Tricks'
        Hint = 'A collection of quick hacks and tools'
        object mOpenSpecial: TMenuItem
          Caption = 'Open Special'
          Hint = 'Open image of specific type'
          object miOpenStill: TMenuItem
            Caption = 'Still Image'
            Hint = 'Open still image'
            OnClick = miOpenStillClick
          end
          object N23: TMenuItem
            Caption = '-'
          end
          object miOpenAnim: TMenuItem
            Caption = 'Animated Image'
            Hint = 'Open animated image'
            OnClick = miOpenAnimClick
          end
          object miOpenMulti: TMenuItem
            Caption = 'Multi-page Image'
            Hint = 'Open multi-page image'
            OnClick = miOpenMultiClick
          end
        end
        object N30: TMenuItem
          Caption = '-'
        end
        object miClearHistory: TMenuItem
          Caption = 'Clear History'
          Hint = 'Clear recent files history'
          OnClick = miClearHistoryClick
        end
        object miCleanUp: TMenuItem
          Caption = 'Clean Up'
          Hint = 'Remove all temporary files and history'
          OnClick = miCleanUpClick
        end
      end
      object N18: TMenuItem
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
    Left = 485
    Top = 102
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
    Left = 516
    Top = 102
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
    Left = 547
    Top = 102
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
    Left = 485
    Top = 133
  end
  object imlMain: TImageList
    Left = 454
    Top = 164
    Bitmap = {
      494C01012A002C00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000B0000000010020000000000000B0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000FFC0C000FFC0
      C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
      C000FFC0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000FFC0C000FFC0
      C000FFC0C000FFC0C000FFC0C000000000000000000080808000FFFFFF00FFFF
      FF0080FFFF00FFFFFF0080FFFF000080200080FFFF00FFFFFF0080FFFF00FFFF
      FF00FFC0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000402000000000
      0000000000000000000000000000000000000000000080808000FFFFFF0080FF
      FF00FFFFFF0080FFFF00FFC0C000000000000000000080808000FFFFFF0080FF
      FF00FFFFFF0080FFFF000080200000802000FFFFFF0080FFFF00FFFFFF0080FF
      FF00FFC0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000802000004020
      0000000000000000000000000000000000000000000080808000FFFFFF00FFFF
      FF0080FFFF00FFFFFF00FFC0C000000000000000000080808000FFFFFF00FFFF
      FF0080FFFF00008020000080200000802000008020000080200080FFFF00FFFF
      FF00FFC0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000040200000FF200000FF20
      0000802000000000000000000000000000000000000080808000FFFFFF0080FF
      FF00FFFFFF0080FFFF00FFC0C000000000000000000080808000FFFFFF0080FF
      FF00FFFFFF0080FFFF000080200000802000FFFFFF00408000004060000080FF
      FF00FFC0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004020000000000000FF2000008020
      0000000000000000000080808000FFC0C000FFC0C00080808000FFFFFF00FFFF
      FF0080FFFF00FFFFFF00FFC0C000000000000000000080808000FFFFFF00FFFF
      FF0080FFFF00FFFFFF0080FFFF000080200080FFFF00FFFFFF0040600000FFFF
      FF00FFC0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008020000000000000802000000000
      0000000000000000000080808000FFFFFF00FFFFFF0080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000080808000FFFFFF0080FF
      FF004060000080FFFF00FFFFFF0080FFFF00FFFFFF0080FFFF004060000080FF
      FF00FFC0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008020000000000000000000000000
      0000000000000000000080808000FFFFFF0080FFFF0080808000808080008080
      8000808080008080800080808000000000000000000080808000FFFFFF00FFFF
      FF0040600000FFFFFF0080FFFF000080200080FFFF00FFFFFF0080FFFF00FFFF
      FF00FFC0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008020000000000000000000000000
      0000000000000000000080808000FFFFFF00FFFFFF0080FFFF00FFFFFF00FFC0
      C000000000000000000000000000000000000000000080808000FFFFFF0080FF
      FF004060000040800000FFFFFF00008020000080200080FFFF00FFFFFF0080FF
      FF00FFC0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080200000000000000000
      00000000C000000000000000C000FFFFFF000000C000FFFFFF0080FFFF00FFC0
      C000000000000000000000000000000000000000000080808000FFFFFF00FFFF
      FF0080FFFF00008020000080200000802000008020000080200080FFFF00FFFF
      FF00FFC0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000C000000080000000C000FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00008020000080200080FFFF00FFFFFF00FFC0
      C000FFC0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000C00000008000FFFFFF00000080000000C00080808000808080000000
      0000000000000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000080200080FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000C000000080000000C0000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080FFFF00FFFFFF0080FFFF0080808000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000C000000000000000C000000000000000C00000000000000000000000
      0000000000000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000FFFFFF00FFC0
      C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
      C000FFC0C000FFC0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000808080008080
      800080808000808080008080800000000000000000000020C0000000FF000000
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFC0C00000000000000000000060600080FFFF0000C0FF0000C0
      FF0000C0FF000080C0000080C0000080C0000080C0000080C000408080000080
      C000408080000080C00000000000000000000000000000000000000000000000
      000000000000FF00000080808000FFFFFF0040C0FF00FFFFFF00FFFFFF00FFFF
      FF0040C0FF00FFFFFF008080800000000000000000000020C0000080FF000000
      FF00000080000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFC0C000FFC0C000FFC0C00080A0A00080A0A00080A0A000FFC0C000FFC0
      C000FFFFFF00FFC0C00000000000000000000060600080FFFF0000C0FF0000C0
      FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF000080C0000080C0004080
      80000080C000408080000000000000000000000000000000000000000000FF20
      0000FF000000FF00000080808000FFFFFF00FFFFFF00FFFFFF0040C0FF00FFFF
      FF00FFFFFF00FFFFFF00808080000000000000000000000000000020C0000060
      FF000000C0000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFC0C00000000000000000000060600080FFFF00FFFFFF0000C0
      FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF000080C0000080C0000080
      C000408080000080C00000000000000000000000000000000000FF200000FF20
      0000FFA00000FFA0000080808000FFFFFF0040C0FF0080000000800000008000
      000080808000FFFFFF0080808000000000000000000000000000000000000000
      C0000000FF0000008000000000000000000000000000000000000000FF000000
      8000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000FF000000C0000000A00000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFC0C00000000000000000000060600080FFFF0000C0FF00FFFF
      FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF000080
      C0000080C0004080800000000000000000000000000000000000FF200000FFA0
      0000FFA00000FFA0000080808000FFFFFF0080800000FF000000FF000000FFA0
      000080000000FFFFFF0080808000000000000000000000000000000000000000
      00000000C0000000FF000000800000000000000000000000FF00000080000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000FF2000FFA0A00000C00000FF606000FF404000FF202000FFFF
      FF00FFFFFF00FFC0C00000000000000000000060600080FFFF00FFFFFF0000C0
      FF00FFFFFF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0
      FF000080C0000080C000000000000000000000000000FF000000FF400000FFA0
      0000FFA00000FFA0000080808000FFFFFF00808000008080800000800000FF00
      000080000000FFFFFF0080808000000000000000000000000000000000000000
      0000000000000000C0000000FF00000080000000FF0000008000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0040FF400000FF200000FF0000FFFFFF00FFFFFF00FF000000FFFF
      FF00FFFFFF00FFC0C00000000000000000000060600080FFFF0000C0FF00FFFF
      FF0000C0FF00FFFFFF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0
      FF000080C0000080C000000000000000000000000000FF000000FF200000FFA0
      0000008000000080000080808000FFFFFF0080800000FFFFFF00808080000080
      000080000000FFFFFF0080808000000000000000000000000000000000000000
      000000000000000000000000C0000000FF000000800000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000020
      FF000000FF000000C000FF6060000000C000FFFFFF00FFFFFF00FF000000FFFF
      FF00FFFFFF00FFC0C00000000000000000000060600080FFFF00FFFFFF0000C0
      FF00FFFFFF0000C0FF00FFFFFF0000C0FF0000C0FF0000C0FF0000C0FF000080
      C00000C0FF000080C000000000000000000000000000FF000000FF0000000080
      0000008000000080000080808000FFFFFF0040C0FF0080800000808000008080
      000080808000FFFFFF0080808000000000000000000000000000000000000000
      0000000000000000C0000000FF00000080000000C00000008000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF004040
      FF00FFFFFF00FFFFFF00FF404000FF202000FF000000FF00000080000000FFFF
      FF00FFFFFF00FFC0C00000000000000000000060600080FFFF0000C0FF00FFFF
      FF0000C0FF00FFFFFF0000C0FF00FFFFFF0000C0FF0000C0FF0000C0FF0000C0
      FF0000C0FF000080C000000000000000000000000000FF000000FF0000000080
      0000008000000080000080808000FFFFFF00FFFFFF00FFFFFF0040C0FF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000C0000000FF000000800000000000000000000000C000000080000000
      0000000000000000000000000000000000000000000000000000FFFFFF004060
      FF00FFFFFF00FFFFFF00FFFFFF000000C000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFC0C00000000000000000000060600080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF00000000000000000000000000FF000000FF000000FFC0
      C000008000000080000080808000FFFFFF0040C0FF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF00808080000000000000000000000000000000C0000000
      FF000000FF0000008000000000000000000000000000000000000000C0000000
      8000000000000000000000000000000000000000000000000000FFFFFF008080
      FF00FFFFFF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF00FFC0C000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000060600000606000006060000060
      6000006060000060600000606000006060000060600000606000006060000060
      6000006060000060600000000000000000000000000080808000FF000000FF00
      0000FFFFFF00FFC0C00080808000FFFFFF00FFFFFF00FFFFFF0040C0FF00FFFF
      FF0080808000808080000000000000000000000000000000C0000080FF000000
      FF00000080000000000000000000000000000000000000000000000000000000
      C000000080000000000000000000000000000000000000000000FFFFFF0080A0
      FF008080FF004060FF004040FF000020FF00FFFFFF00FFFFFF00FFC0C0000000
      000000000000000000000000000000000000000000000060600080FFFF0080FF
      FF0080C0C00080FFFF0080C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000FF000000FFFF
      FF00FFC0C000FFFFFF0080808000808080008080800080808000808080008080
      80008080800000000000000000000000000000000000406080000000C0004060
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000C00000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFC0C0000000
      0000FFFFFF000000000000000000000000000000000000000000006060000060
      6000006060000060600000606000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000FF00
      0000FF000000FFC0C000FFFFFF00FFC0C0000080000000800000008000000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      800080808000FF000000FF000000FFFFFF00FFC0C00000800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000200000002000000020000000200000002000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000606000FFFFFF0000C0FF0000C0FF000080C0000080C0000080C0000080
      80000080C000008080000080C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000020
      0000006000000060000000600000006000000060000000600000002000000020
      000000200000000000000000000000000000000000000000000080808000FFC0
      C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
      C000000000000000000000000000000000000000000000000000000000000000
      000000606000FFFFFF0000C0FF0000C0FF00FF00000000C0FF00FF0000000080
      C000FF0000000080C000008080000000000080808000FFC0C000FFC0C000FFC0
      C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
      C000FFC0C000FFC0C00000000000000000000000000000000000002000000060
      0000408060000080000000800000008000000080000000600000006000000060
      000000200000002000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF0080FFFF00FFFFFF0080FFFF00FFFFFF0080FFFF00FFFFFF00FFC0
      C000000000000000000000000000000000000000000000000000000000000000
      000000606000FFFFFF00FFFFFF0000C0FF0000C0FF00FF000000FF000000FF00
      00000080C000008080000080C0000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFC0C00000000000000000000000000000000000002000004080
      6000408060000080000000800000FFFFFF000080000000800000008000000060
      000000600000002000000000000000000000000000000000000080808000FFFF
      FF0080FFFF00FFFFFF0080FFFF00FFFFFF0080FFFF00FFFFFF0080FFFF00FFC0
      C000000000000000000000000000000000000000000000000000000000000000
      000000606000FFFFFF0000C0FF00FFFFFF00FF000000FF00000000FFFF00FF00
      0000FF0000000080C000008080000000000080808000FFFFFF00FF200000FF20
      0000FF200000FF200000FF200000FF200000FF2000000000000000000000FFFF
      FF00FFFFFF00FFC0C00000000000000000000000000000200000408060004080
      6000008000000080000000800000FFFFFF00FFFFFF0000800000008000000080
      000000600000002000000020000000000000000000000000000080808000FFFF
      FF00FFFFFF0080FFFF00FFFFFF0080FFFF00FFFFFF0080FFFF00FFFFFF00FFC0
      C0000000000000000000000000000000000080808000FFC0C000FFC0C000FFC0
      C00000606000FFFFFF00FFFFFF0000C0FF0000C0FF00FF000000FF000000FF00
      000000C0FF000080C0000080C0000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00FFC0C000000000000000000000000000002000004080600040C0
      8000008000000080000000800000FFFFFF00FFFFFF00FFFFFF00008000000080
      000000600000006000000020000000000000000000000000000080808000FFFF
      FF0080FFFF00FFFFFF0080FFFF00FFFFFF0080FFFF00FFFFFF0080FFFF00FFC0
      C0000000000000000000000000000000000080808000FFFFFF00FF602000FF60
      200000606000FFFFFF0000C0FF00FFFFFF00FF00000000C0FF00FF00000000C0
      FF00FF00000000C0FF000080C0000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FF202000FF202000FF202000FF20200040808000FFFFFF0080C0
      C00000000000FFC0C000000000000000000000000000002000004080600040C0
      8000008000000080000000800000FFFFFF00FFFFFF00FFFFFF00FFFFFF000080
      000000800000006000000020000000000000000000000000000080808000FFFF
      FF00FFFFFF0080FFFF00FFFFFF0080FFFF00FFFFFF0080FFFF00FFFFFF00FFC0
      C000000000000000000000000000000000008080800080FFFF00FFFFFF0080FF
      FF0000606000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004080800080C0C0000060
      800000000000FFC0C000000000000000000000000000002000004080600040C0
      8000408060000080000000800000FFFFFF00FFFFFF00FFFFFF00008000000080
      000000800000006000000020000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF0080FFFF00FFFFFF0080FFFF00FFFFFF0080FFFF00FFC0
      C0000000000000000000000000000000000080808000FFFFFF00FF602000FF60
      20000060600080C0C0000080C00080C0C0000080C00080C0C000006060000060
      60000060600000606000006060000000000080808000FFFFFF00FF602000FF60
      2000FF602000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000060800000C0
      FF000060800000000000000000000000000000000000002000004080600040C0
      8000408060000080000000800000FFFFFF00FFFFFF0000800000008000000080
      000000800000006000000020000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080FFFF00FFFFFF0080FFFF00FFC0C000FFC0
      C000000000000000000000000000000000008080800080FFFF00FFFFFF0080FF
      FF00FFFFFF0000606000FFFFFF0000C0FF0080C0C0000080C000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000060800080FF
      FF0000C0FF000000000000000000000000000000000000000000002000004080
      600040C080004080600000800000FFFFFF000080000000800000008000000080
      000000800000006000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FFFF0000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00406000004060
      000080FFFF00FF60200000606000006060000060600000606000000000000000
      000000000000000000000000000000000000FF00000080000000800000008000
      0000800000008000000080000000800000008000000080000000800000000060
      800000FFFF000060800000000000000000000000000000000000002000004080
      600040C0800040C0800040806000408060000080000000800000008000000080
      000000800000002000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000FFFFFF000000
      00000000000000000000000000000000000080808000FFFFFF00008020004060
      0000FFFFFF00FFFFFF0080FFFF00FFC0C0000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF802000FF602000FF60
      2000FF602000FF602000FF602000FF602000FF602000FF602000FF6020000060
      800080FFFF0000C0FF0000000000000000000000000000000000000000000020
      0000408060004080600040C0800040C080004080600000800000008000000080
      000000600000000000000000000000000000000000000000000080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080808000000000000000
      00000000000000000000000000000000000080808000FFFFFF0000C060004060
      0000FFFFFF00FF602000FF602000FFC0C0000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      00000060800000FF000000800000000000000000000000000000000000000000
      0000002000000020000040806000408060004080600040806000008000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFC0C0000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000080004000FF004000FF00000000000000000000000000000000000000
      0000000000000000000000200000002000000020000000200000002000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000808080008080
      8000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000800000008000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400000000000000000000000000000000000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800040000000000000000000000000000000000080004000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      4000000000000000000000000000000000008000400000000000000000000000
      0000000000000000000000000000000000000000000000000000FF002000FF00
      2000FF802000FFA02000FFC04000FFFFFF00FFFFFF0080FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800040008000400000000000000000000000000080004000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800040008000400000000000000000000000000080004000800040000000
      0000000000000000000000000000000000000000000000000000000000008000
      4000800040000000000000000000000000008000400080004000000000000000
      0000000000000000000000000000000000000000000000000000FF002000FF80
      2000FFA02000FFC04000FFFFFF00FFFFFF0080FF000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400000000000000000000000000000000000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000800040000000000000000000000000000000000080004000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      4000000000000000000000000000000000008000400000000000000000000000
      0000000000000000000000000000000000000000000000000000FF802000FFA0
      2000FFC04000FFFFFF00FFFFFF0080FF000000FF000080C00000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFA02000FFC0
      4000FFFFFF00FFFFFF0080FF000000FF000080C0000040C00000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFC04000FFFF
      FF00FFFFFF0080FF000000FF000080C0000040C0000040A00000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF0080FF000000FF000080C0000040C0000040A0000040800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      4000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      4000800040008000400000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400000000000000000000000000000000000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400080004000800040008000400080004000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      4000800040008000400080004000800040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400000000000000000000000000000000000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400080004000800040008000400080004000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      4000800040008000400080004000800040008000400080004000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400000000000000000000000000000000000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400080004000800040008000400080004000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080004000000000000000000000000000000000008000
      4000000000000000000000000000000000000000000000000000000000008000
      4000800040008000400080004000800040008000400080004000800040008000
      4000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400000000000000000000000000000000000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400080004000800040008000400080004000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400080004000000000000000000000000000800040008000
      4000000000000000000000000000000000000000000000000000000000008000
      4000800040008000400080004000800040008000400080004000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400000000000000000000000000000000000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400080004000800040008000400080004000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080004000000000000000000000000000000000008000
      4000000000000000000000000000000000000000000000000000000000008000
      4000800040008000400080004000800040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400000000000000000000000000000000000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400080004000800040008000400080004000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      4000800040008000400000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400000000000000000000000000000000000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008000400080004000800040008000400080004000800040000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008000
      4000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000400060000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000040006000400060008000C0008000800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080808000808080008080800080808000808080008080
      800080808000808080008080800000000000000000000000000080C0FF00FFFF
      FF0000C0FF00FFFFFF0000C0FF00FFFFFF0000C0FF00FFFFFF0000C0FF00FFFF
      FF0000C0FF00FFFFFF0000000000000000000000000000000000000000000000
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004000
      6000400060008000C000FF60C000FFFFFF00FFC0C00080008000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF00000080808000FFFFFF0040C0FF00FFFFFF00FFFFFF00FFFF
      FF0040C0FF00FFFFFF0080808000000000000000000000000000FFFFFF0080C0
      FF00FFFFFF0080C0FF00FFFFFF00FFC0C000FFFFFF0000C0FF00FFFFFF0000C0
      FF00FFFFFF0000C0FF000000000000000000000000000000000000000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000040006000400060008000
      C000FF60C000FFFFFF00FFFFFF00FFFFFF00FFC0C000FFC0C000800080000000
      000000000000000000000000000000000000000000000000000000000000FF20
      0000FF000000FF00000080808000FFFFFF00FFFFFF00FFFFFF0040C0FF00FFFF
      FF00FFFFFF00FFFFFF008080800000000000000000000000000080C0FF00FFFF
      FF0080C0FF00FFFFFF00FFC0C000FF000000FFC0C000FFFFFF0000C0FF00FFFF
      FF0000C0FF00FFFFFF000000000000000000000000000000000000000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000800080008000C000FF60C000FFFF
      FF00FFFFFF00FFC0C000FFC0C000800080008080800080A0A000FFC0C0008000
      8000000000000000000000000000000000000000000000000000FF200000FF20
      0000FFA00000FFA0000080808000FFFFFF0040C0FF0080000000800000008000
      000080808000FFFFFF0080808000000000000000000000000000FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF0080C0FF00FFFFFF0080C0
      FF00FFFFFF0000C0FF000000000000000000000000000000000000000000FF00
      0000FF000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000008000800080808000FFFFFF00FFC0
      C00080A0A000800080008000800080008000000000008080800080808000FFC0
      C000800080000000000000000000000000000000000000000000FF200000FFA0
      0000FFA00000FFA0000080808000FFFFFF0080800000FF000000FF000000FFA0
      000080000000FFFFFF008080800000000000000000000000000000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FF00000000FFFF00FFFFFF0080C0FF00FFFF
      FF0000C0FF00FFFFFF000000000000000000FF000000FF000000FF000000FF80
      0000FF000000FF000000FF000000000000000000000000000000FF000000FF00
      0000FF0000000000000000000000000000008000800080808000FFC0C0008000
      800080008000FF00C000FF00C000FF00C0008000800000000000406060008080
      800080A0A00080008000000000000000000000000000FF000000FF400000FFA0
      0000FFA00000FFA0000080808000FFFFFF00808000008080800000800000FF00
      000080000000FFFFFF0080808000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000FFFF00FFFFFF00FF000000FF00000000FFFF00FFFFFF0080C0
      FF00FFFFFF0000C0FF00000000000000000000000000FF000000FF800000FF80
      0000FF800000FF000000000000000000000000000000FF000000FF800000FF80
      0000FF800000FF0000000000000000000000800080008000800080008000FF00
      C000FF00C0008000800080008000FF00C000FF00C00080008000000000004060
      60008080800080808000800080000000000000000000FF000000FF200000FFA0
      0000008000000080000080808000FFFFFF0080800000FFFFFF00808080000080
      000080000000FFFFFF0080808000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00FFFFFF00FF000000FF00000000FFFF00FFFF
      FF0080C0FF00FFFFFF0000000000000000000000000000000000FF000000FF00
      0000FF000000000000000000000000000000FF000000FF000000FF000000FF80
      0000FF000000FF000000FF0000000000000080008000FF80FF00FF00C000FF00
      C000FF00C00000FFFF0000C0FF00006080008000800080008000800080000000
      00004060600080808000800080000000000000000000FF000000FF0000000080
      0000008000000080000080808000FFFFFF0040C0FF0080800000808000008080
      000080808000FFFFFF0080808000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000FFFF00FFC0C000FF000000FFFFFF0080C0
      FF00FFFFFF0080C0FF000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000080008000FF80FF00FF00
      C000FF00C000FF00C000FF00C00000FFFF0000FFFF0000C0FF00006080008000
      80000000000040606000800080000000000000000000FF000000FF0000000080
      0000008000000080000080808000FFFFFF00FFFFFF00FFFFFF0040C0FF00FFFF
      FF00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FF000000FFFFFF00FFFFFF00FFC0C000FF00000000FFFF00FFFF
      FF0080C0FF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000000000000000000080008000FF80
      FF00FF00C000FF00C000FF00C000FF00C000FF00C00000C0FF0000FFFF004000
      60008000800000000000800080000000000000000000FF000000FF000000FFC0
      C000008000000080000080808000FFFFFF0040C0FF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF0080808000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FF000000FF000000FFC0C000FF000000FF000000FFFFFF0000FF
      FF00FFFFFF0080C0FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000008000
      8000FF80FF00FF00C000FF00C00000FFFF0000FFFF0000FFFF000080C0004000
      6000800080008000800000000000000000000000000080808000FF000000FF00
      0000FFFFFF00FFC0C00080808000FFFFFF00FFFFFF00FFFFFF0040C0FF00FFFF
      FF00808080008080800000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF000000FF000000FF000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FF00000000000000000000000000000000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080008000FF80FF00FF00C000FF00C0000060800000608000400060008000
      8000800080004000600000000000000000000000000080808000FF000000FFFF
      FF00FFC0C000FFFFFF0080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080008000FF80FF00FF00C000FF00C000FF00C000800080004000
      600000000000000000000000000000000000000000000000000080808000FF00
      0000FF000000FFC0C000FFFFFF00FFC0C0000080000000800000008000000080
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000080008000FF80FF00FF00C00040006000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      800080808000FF000000FF000000FFFFFF00FFC0C00000800000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000800080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFC0C000FFC0C000FFC0
      C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
      C000FFC0C000FFC0C000FFC0C000000000000000000000000000006080000060
      8000006080000060800000608000006080000060800000608000006080000060
      8000006080000060800000608000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFC0C000000000008080800000C0FF0000C0FF0000C0
      FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF000060
      80000060800000C0FF0000608000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF0080808000FFC0
      C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C000FFC0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFC0C0000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0000C0FF000060800000608000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF0080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFC0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFC0C000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0080FFFF00FFFFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF000060800000608000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF0080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFC0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFC0C000000000000000000080808000FFFFFF00FFFF
      FF0000808000006060000060600000606000006060000060600080FFFF0080FF
      FF0080FFFF0000C0FF0000608000000000000000000000000000000000000000
      000000000000FF80200000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF6020000000
      00000000000000000000000000000000000080808000FFFFFF0080808000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFC0C00000000000FFFF
      FF00FFFFFF00FFFFFF00FFC0C000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0080FFFF00FFFFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0000C0FF0000608000000000000000000000000000000000000000
      0000FF802000FF80200000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF802000FF60
      20000000000000000000000000000000000080808000FFFFFF00FF000000FF80
      2000FF602000FF602000FF602000FF602000FF602000FF60200000000000FFFF
      FF00FFFFFF00FFFFFF00FFC0C000000000000000000080808000FFFFFF00FFFF
      FF00008080000080800000808000006060000060600000606000006060000060
      60000060600000C0FF000060800000000000000000000000000000000000FF80
      2000FFC02000FF802000FF802000FF802000FF802000FF802000FF802000FF80
      2000FF8020000000000000000000000000000000000000000000FF602000FF80
      2000FF802000FF802000FF802000FF802000FF802000FF802000FF802000FFC0
      2000FF60200000000000000000000000000080808000FFFFFF00FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF00000000000000FFC0
      C000FFFFFF00FFFFFF00FFC0C000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FFFF00FFFFFF0080FFFF0080FF
      FF0080FFFF0000C0FF0000608000000000000000000000000000FF602000FFFF
      8000FFFF8000FFFF8000FFFF8000FFFF8000FFFF8000FFFF8000FFFF8000FFFF
      8000FF8020000000000000000000000000000000000000000000FF602000FFFF
      C000FFFFC000FFFFC000FFFFC000FFFFC000FFFFC000FFFFC000FFFFC000FFFF
      8000FFC0200000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      8000FFC0C00000008000FFC0C000000000000000000080808000FFFFFF00FFFF
      FF00008080000080800000808000008080000080800000606000006060000060
      60000060600000C0FF000060800000000000000000000000000000000000FF60
      2000FFFF8000FFFF800000000000FF602000FF602000FF602000FF602000FF60
      2000FF6020000000000000000000000000000000000000000000FF602000FF60
      2000FF602000FF602000FF602000FF602000FF602000FF602000FFFFC000FFC0
      20000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000800000008000FFC0C000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FFFF00FFFFFF0080FF
      FF0080FFFF0000C0FF0000608000000000000000000000000000000000000000
      0000FF602000FFFF800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF602000FFC020000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004000
      FF004000FF0000008000FFC0C000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FFFF00FFFF
      FF0080FFFF0000C0FF0000608000000000000000000000000000000000000000
      000000000000FF60200000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF602000000000000000
      00000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFC0C000000000000000000080808000FFFFFF00FFFF
      FF0000808000008080000080800000808000FFFFFF00FFFFFF00FFFFFF0080FF
      FF00FFFFFF0000C0FF0000608000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF602000000000000000
      0000000000000000000000000000000000008080800040404000404040004040
      4000404040004040400040404000404040004040400040404000404040004040
      4000404040004040400040404000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000C0FF0000608000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFC0C00080A0A00080A0
      A00080A0A00080A0A00080A0A00080A0A00080A0A00080A0A00080A0A00080A0
      A00080A0A00080A0A00080A0A000000000000000000080808000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000C0FF0000608000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000020
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      C0000080FF000000C00000000000000000000000000000000000002080000000
      FF000000C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000C0000080FF000000C000000000000000
      0000000000000000000000000000000000000060600080FFFF0000C0FF0000C0
      FF0000C0FF000080C0000080C0000080C0000080C0000080C000408080000080
      C000408080000080C00000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000C0000080
      FF000000FF000000C000000000000000000000000000002080000000C0000000
      FF000000FF000000C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000C0000080FF000000FF000000C000000000000000
      0000000000000000000000000000000000000060600080FFFF0000C0FF0000C0
      FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF000080C0000080C0004080
      80000080C0004080800000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000C0000080FF000000
      FF000000C0000000000000000000000000000000000000000000000000000000
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000080FF000000FF000000C00000000000000000000000
      0000000000000000000000000000000000000060600080FFFF00FFFFFF0000C0
      FF0000C0FF0000606000006060000060600000606000006060000080C0000080
      C000408080000080C00000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000080FF000000FF000000
      C000000000000000000000000000000000000000000000000000000000000000
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000FFC02000FFC0
      2000FF80200080602000000000000000C0000000000000000000000000000000
      0000002080000000000000000000000000000060600080FFFF0000C0FF00FFFF
      FF0000C0FF0000606000FFA0A000FFA0A000FFA0A0000060600000C0FF000080
      C0000080C0004080800000000000000000000000000000000000808080000000
      0000FF800000FF800000FF8000008060200080602000000000000000C0000000
      0000000000000000000000000000000000000000000000000000000000000000
      C000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFC08000FFFF2000FFFF
      2000FFC08000FF80200080602000000000000000000000000000000000000020
      80000000C0000000000000000000000000000060600080FFFF00FFFFFF0000C0
      FF00FFFFFF00006060000040FF00FFA0A000FFA0A0000060600000C0FF0000C0
      FF000080C0000080C0000000000000000000000000008080800080A0A000FFC0
      2000FFC02000FFC02000FFC02000FF800000FF80000080602000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000C0000080FF000000C000000000000000
      00000000000000000000000000000000000080808000FFC08000FFFFC000FFFF
      8000FFFF2000FFC08000FF802000000000000000000000000000002080000000
      FF000000C0000020800000208000000000000060600080FFFF0000C0FF00FFFF
      FF0000C0FF00006060000040FF000040FF00FFA0A0000060600000C0FF0000C0
      FF000080C0000080C00000000000000000000000000080808000FFFF8000FFFF
      8000FFFF8000FFC08000FFC02000FFC02000FF800000FF800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000C0000080FF000000FF000000C000000000000000
      00000000000000000000000000000000000080808000FFC08000FFFFFF00FFFF
      C000FFFF8000FFFF2000FFC02000000000000000000000000000000000000000
      C0000000FF000000000000000000002080000060600080FFFF00FFFFFF0000C0
      FF00FFFFFF00006060000060600000606000006060000060600000C0FF000080
      C00000C0FF000080C000000000000000000080808000FFC08000FFFF8000FFFF
      8000FFFF8000FFFF8000FFFF8000FFC02000FFC02000FF800000806020000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000080FF000000FF000000C00000000000000000000000
      0000000000000000000000000000000000008080800080A0A000FFFFFF00FFFF
      FF00FFFFC000FFFF2000FFC02000000000000000000000000000000000000000
      00000000C0000000000000000000002080000060600080FFFF0000C0FF00FFFF
      FF0000C0FF00FFFFFF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0
      FF0000C0FF000080C000000000000000000080808000FFC08000FFFFC000FFFF
      C000FFFFC000FFFF8000FFFF8000FFFF8000FFC02000FF800000FF8000000000
      0000000000000000000000000000000000000000000080808000FFC02000FFC0
      2000FF80200080602000000000000000C0000000000000000000000000000000
      000000000000000000000000000000000000000000008080800080A0A000FFC0
      8000FFC08000FFC0800080808000000000000000000000000000000000000000
      0000000000000000000000000000002080000060600080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF00000000000000000080808000FFC08000FFFFFF00FFFF
      FF00FFFFC000FFFFC000FFFF8000FFFF8000FFC08000FFC02000FF8000000000
      00000000000000000000000000000000000080808000FFC08000FFFF2000FFFF
      2000FFC08000FF80200080602000000000000000000000000000000000000000
      0000000000000020800000000000000000000000000000000000808080008080
      800080808000808080000000000000000000000000000000C000000000000000
      0000000000000000000000000000000000000060600000606000006060000060
      6000006060000060600000606000006060000060600000606000006060000060
      6000006060000060600000000000000000008080800080A0A000FFFFFF00FFFF
      FF00FFFFFF00FFFFC000FFFFC000FFFF8000FFFF8000FFC02000FF8000000000
      00000000000000000000000000000000000080808000FFC08000FFFFC000FFFF
      8000FFFF2000FFC08000FF802000000000000000000000000000000000000000
      0000000000000000C00000208000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000C000000000000000
      000000208000000000000000000000000000000000000060600080FFFF0080FF
      FF0080C0C00080FFFF0080C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000FFC08000FFFF
      FF00FFFFFF00FFFFFF00FFFFC000FFFF8000FFFF8000FFC02000000000000000
      00000000000000000000000000000000000080808000FFC08000FFFFFF00FFFF
      C000FFFF8000FFFF2000FFC020000000000000000000000000000000C0000000
      C0000000C0000000FF000000FF00002080000000000000000000000000000000
      000000000000000000000000000000000000000000000000C000000000000000
      00000000C0000020800000000000000000000000000000000000006060000060
      6000006060000060600000606000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008080800080A0A000FFC0
      8000FFFFFF00FFFFFF00FFFFC000FFFF8000FFC08000FF802000000000000000
      0000000000000000000000000000000000008080800080A0A000FFFFFF00FFFF
      FF00FFFFC000FFFF2000FFC02000000000000000000000000000000000000000
      0000000000000000FF000000C000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000C0000000
      C0000000FF000000FF0000208000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      800080A0A000FFC08000FFC08000FFC080008080800080808000000000000000
      000000000000000000000000000000000000000000008080800080A0A000FFC0
      8000FFC08000FFC0800080808000000000000000000000000000000000000000
      0000000000000000C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000006080000080
      C000000000000000000000000000000000000000000000008000000080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000060800000C0
      FF000000000000000000000000000000000000000000000080004000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000060600080FFFF0000C0FF0000C0FF0000C0FF0000C0FF000080C00000C0
      FF000080C0000080C00000000000000000000060600080FFFF0000C0FF0000C0
      FF0000C0FF000080C0000080C0000080C0000080C0000080C000408080000080
      C000408080000080C00000000000000000000060600080FFFF0000C0FF0000C0
      FF0000C0FF000080C0000080C0000080C0000080C0000080C000408080000080
      C000408080000080C000000000000000000000000000000000000060800080FF
      FF000000000000000000000000000000000000000000000080004000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000060600080FFFF0080FFFF0000C0FF0000C0FF0000C0FF0000C0FF000080
      C00000C0FF000080C00000000000000000000060600080FFFF0000C0FF0000C0
      FF0000C0FF0000C0FF0000C0FF00FF00000000C0FF000080C0000080C0004080
      80000080C0004080800000000000000000000060600080FFFF0000C0FF0000C0
      FF0000C0FF0000C0FF0000C0FF000060600000C0FF000080C0000080C0004080
      80000080C00040808000000000000000000000000000000000000060800000C0
      FF000000000000000000000000000000000000000000000080004000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000060600080FFFF0000C0FF0080FFFF0000C0FF0000C0FF0000C0FF0000C0
      FF000080C0000080C00000000000000000000060600080FFFF00FFFFFF0000C0
      FF0000C0FF00FF00000000C0FF00FF00000000C0FF00FF0000000080C0000080
      C000408080000080C00000000000000000000060600080FFFF00FFFFFF0000C0
      FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF000080C0000080
      C000408080000080C000000000000000000000000000FFC0C0000060800080FF
      FF0000000000FFC0C000FFC0C000FFC0C000FFC0C000000080004000FF000000
      0000FFC0C000FFC0C00000000000000000000000000000000000000000000000
      00000060600080FFFF00FFFFFF0000C0FF0080FFFF0000C0FF0000C0FF0000C0
      FF0000C0FF000080C00000000000000000000060600080FFFF0000C0FF00FFFF
      FF0000C0FF0000C0FF00FF000000FF000000FF00000000C0FF0000C0FF000080
      C0000080C0004080800000000000000000000060600080FFFF0000C0FF00FFFF
      FF0000C0FF0000C0FF0000C0FF000060600000C0FF0000C0FF0000C0FF000080
      C0000080C00040808000000000000000000000000000FFFFFF000060800000C0
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000080004000FF000000
      0000FFFFFF00FFC0C00000000000000000000000000000000000000000000000
      00000060600080FFFF0000C0FF00FFFFFF0000C0FF0080FFFF0000C0FF0000C0
      FF0000C0FF000080C00000000000000000000060600080FFFF00FFFFFF0000C0
      FF00FF000000FF000000FF00000000FFFF00FF000000FF000000FF00000000C0
      FF000080C0000080C00000000000000000000060600080FFFF00FFFFFF0000C0
      FF00FFFFFF0000C0FF0000C0FF0000C0FF000060600000C0FF0000C0FF0000C0
      FF000080C0000080C000000000000000000000000000FFFFFF000060800080FF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000800040C0FF000000
      0000FFFFFF00FFC0C00000000000000000000060600080FFFF0000C0FF0000C0
      FF000060600080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0000000000000000000060600080FFFF0000C0FF00FFFF
      FF0000C0FF00FFFFFF00FF000000FF000000FF00000000C0FF0000C0FF0000C0
      FF000080C0000080C00000000000000000000060600080FFFF0000C0FF00FFFF
      FF0000C0FF00FFFFFF0000C0FF0000C0FF0000C0FF000060600000C0FF0000C0
      FF000080C0000080C000000000000000000000000000FFFFFF000060800000C0
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF0000000000FFC0C0000000
      0000FFFFFF000000000000000000000000000060600080FFFF0080FFFF0000C0
      FF000060600080FFFF0080FFFF0080FFFF0080C0C00000606000006060000060
      6000006060000060600000000000000000000060600080FFFF00FFFFFF0000C0
      FF00FFFFFF00FF000000FFFFFF00FF00000000C0FF00FF00000000C0FF000080
      C00000C0FF000080C00000000000000000000060600080FFFF00FFFFFF0000C0
      FF00FFFFFF0000606000FFFFFF0000C0FF0000C0FF000060600000C0FF000080
      C00000C0FF000080C0000000000000000000000000000060800000C0FF0080FF
      FF00006080000000000000000000FFC0C0000000000080808000FFFFFF008080
      8000000000000000000000000000000000000060600080FFFF0000C0FF0080FF
      FF0000C0FF00006060000060600000606000006060000080C000000000000000
      0000000000000000000000000000000000000060600080FFFF0000C0FF00FFFF
      FF0000C0FF00FFFFFF0000C0FF00FF00000000C0FF0000C0FF0000C0FF0000C0
      FF0000C0FF000080C00000000000000000000060600080FFFF0000C0FF00FFFF
      FF0000C0FF00FFFFFF0000606000006060000060600000C0FF0000C0FF0000C0
      FF0000C0FF000080C00000000000000000000060800000C0FF0080FFFF000060
      800080FFFF000060800000000000FFFFFF0080808000FFFFFF00FFFFFF00FFC0
      C00000000000FFC0C00000000000000000000060600080FFFF00FFFFFF0000C0
      FF0080FFFF0000C0FF0000C0FF0000C0FF000080C0000080C000000000000000
      0000000000000000000000000000000000000060600080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0000000000000000000060600080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0000000000000000000060800080FFFF0000000000FFFF
      FF000060800080FFFF000000000080808000FFFFFF0080808000808080008080
      8000FFFFFF00FFC0C00000000000000000000060600080FFFF0000C0FF00FFFF
      FF0000C0FF0080FFFF0000C0FF0000C0FF0000C0FF000080C000000000000000
      0000000000000000000000000000000000000060600000606000006060000060
      6000006060000060600000606000006060000060600000606000006060000060
      6000006060000060600000000000000000000060600000606000006060000060
      6000006060000060600000606000006060000060600000606000006060000060
      6000006060000060600000000000000000000060800080FFFF0000000000FFFF
      FF000060800000FFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFC0C00000000000000000000060600080FFFF0080FFFF0080FF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF00000000000000
      000000000000000000000000000000000000000000000060600080FFFF0080FF
      FF0080C0C00080FFFF0080C0C000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000060600080FFFF0080FF
      FF0080C0C00080FFFF0080C0C000000000000000000000000000000000000000
      000000000000000000000000000000000000FF0000000060800080FFFF000000
      000080FFFF000000000080000000800000008000000080000000800000008000
      0000800000008000000000000000000000000060600080FFFF0080FFFF0080FF
      FF0080C0C0000060600000606000006060000060600000606000000000000000
      0000000000000000000000000000000000000000000000000000006060000060
      6000006060000060600000606000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000006060000060
      6000006060000060600000606000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF80200000608000FF60
      200000608000FF602000FF602000FF602000FF602000FF602000FF602000FF60
      2000FF602000FF60200000000000000000000000000000606000006060000060
      6000006060000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000C0000080
      FF000000C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFC0C000FFC0C000FFC0C000FFC0C00080A0A00080A0A0000000
      0000404040000000000000000000000000000000000000000000000000000000
      000080808000FFC0C000FFC0C000FFC0C000FFC0C0000000C0000080FF000000
      FF000000C00000000000FFC0C000000000000000000000000000000000000000
      0000000000000000000080808000FFC0C000FFC0C000FFC0C000FFC0C000FFC0
      C000FFC0C000FFC0C00000000000000000000000000000000000000000000000
      000000000000000000000000000080808000FFC0C000FFC0C000FFC0C000FFC0
      C000FFC0C000FFC0C000FFC0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004040400000000000000000000000000000000000000000000000
      000080808000FFFFFF0080FFFF00FFFFFF000000C0000080FF000000FF000000
      C00000000000FFFFFF00FFC0C000000000000000000000000000000000000000
      000000000000000000008080800080FFFF00FF000000FF000000FF000000FF00
      0000FF000000FFC0C00000000000000000000060600040808000408080004080
      800040808000408080004080800080808000FFFFFF00FF200000FF200000FF20
      0000FF200000FF200000FFC0C0000000000080808000FFFFFF00FFFFFF00FFC0
      C000FFC0C000FFC0C000FFC0C00000FF000000FF000000FF0000FFC0C000FFC0
      C000000000000000000000000000000000000000000000000000000000000000
      00008080800080FFFF00FFFFFF000000C0000080FF000000FF000000C0000000
      0000FFFFFF0080FFFF00FFC0C000000000000000000000000000000000000000
      0000000000000000000080808000FFFFFF0080FFFF00FFFFFF0080FFFF00FFFF
      FF0080FFFF00FFC0C00000000000000000000060600080C0C00080C0C0004080
      800080C0C00040808000408080008080800080FFFF00FFFFFF0080FFFF00FFFF
      FF0080FFFF00FFC0C000FFC0C0000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFC0C000FFC0C000FFC0C000008000000080000000800000FFC0C000FFC0
      C000000000008080800000000000000000000000000000000000000000000000
      00000000000000000000000000000080FF000000C0000000C00000000000FFFF
      FF0080FFFF00FFFFFF00FFC0C0000000000080808000FFC0C000FFC0C000FFC0
      C000FFC0C000FFC0C0008080800080FFFF00FF000000FF000000FF000000FF00
      0000FF000000FFC0C000000000000000000000606000FFFFFF0080C0C00080C0
      C00080C0C00080C0C0004080800080808000FFFFFF00FF000000FF000000FFFF
      FF00406060000000000000000000000000008080800080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000000000008080800080808000000000000000000000202000FF802000FFC0
      800080A0A000FFC08000000000000000C0000000C00000000000FFFFFF0080FF
      FF00FFFFFF0080FFFF00FFC0C0000000000080808000FFFFFF00802000008020
      0000802000008020000080808000FFFFFF0080FFFF00FFFFFF0080FFFF00FFFF
      FF00FFC0C000FFC0C00000000000000000000060600080C0C000FFFFFF0080C0
      C00080C0C0004080800080C0C00080808000FFFFFF0080FFFF00FFFFFF0080FF
      FF0080808000FFFFFF00000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFC0C000FFC0C000FFC0C000FFC0C000FFC0C0000000
      00008080800000000000808080000000000080808000FF802000FFC08000FFC0
      800080A0A000FFFF8000806020000000000000000000FFFFFF0080FFFF00FFFF
      FF0080FFFF00FFFFFF00FFC0C000000000008080800080FFFF00FFFFFF0080FF
      FF00FFFFFF0080FFFF0080808000FFFFFF00FF602000FF602000FFFFFF000000
      00000000000000000000000000000000000000606000FFFFFF0080C0C000FFFF
      FF0080C0C00080C0C00080C0C00080808000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00808080000000000000000000000000000000000080808000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      80000000000080808000000000000000000080808000FFC08000FFC08000FFC0
      800080A0A000FFFFC000FFC080000000000080A0A00080FFFF00FFFFFF0080FF
      FF00FFFFFF0080FFFF00FFC0C0000000000080808000FFFFFF00802000008020
      0000802000008020000080808000FFFFFF00FFFFFF00FFFFFF0080FFFF008080
      8000FFFFFF0000000000000000000000000000606000FFFFFF00FFFFFF0080C0
      C000FFFFFF0080C0C00080C0C000808080008080800080808000808080008080
      800080808000000000000000000000000000000000000000000080808000FFC0
      C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00008080800000000000808080000000000080808000FFC08000FFC08000FFC0
      800080A0A000FFFFFF00FFFF80000000000080A0A000FFFFFF0080FFFF00FFFF
      FF0080FFFF00FFFFFF00FFC0C000000000008080800080FFFF00FFFFFF0080FF
      FF00FFFFFF0080FFFF0080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF008080
      80000000000000000000000000000000000000606000FFFFFF00FFFFFF00FFFF
      FF0080C0C000FFFFFF0080C0C00080C0C0004080800080C0C0004080800080C0
      C000408080000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FF202000FF202000FF202000FF202000FF202000FFFFFF000000
      00000000000000000000000000000000000080808000FFC08000FFC08000FFC0
      800080A0A000FFFFFF00FFFF80000000000080A0A00080FFFF00FFFFFF0080FF
      FF00FFFFFF0080FFFF00FFC0C0000000000080808000FFFFFF00802000008020
      0000FFFFFF000000000080808000808080008080800080808000808080008080
      80000000000000000000000000000000000000606000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000004080
      8000408080000000000000000000000000000000000000000000000000008080
      8000FFC0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFC0
      C0000000000000000000000000000000000080808000FF802000FFC08000FFC0
      800080A0A000FFFF8000FFC0800000000000FFFFFF00FFFFFF0080FFFF00FFFF
      FF0080FFFF00FFC0C000FFC0C0000000000080808000FFFFFF00FFFFFF00FFFF
      FF0080FFFF0080808000FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000606000FFFFFF00FFFFFF000080
      C00080FFFF0000C0FF0000C0FF0000C0FF000080C00000608000000000004080
      8000408080000000000000000000000000000000000000000000000000000000
      000080808000FFFFFF00FF602000FF602000FF602000FF602000FF602000FFFF
      FF00000000000000000000000000000000000000000080808000FF802000FFC0
      800080A0A000FFC0800000000000FFC0C000FFFFFF00FFFFFF00FFFFFF0080FF
      FF000000000000000000000000000000000080808000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008080800000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000606000FFFFFF00FFFFFF00FFFF
      FF000080C00080FFFF0000606000006060000080C000000000004080800080C0
      C000408080000000000000000000000000000000000000000000000000000000
      000080808000FFC0C000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFC0C0000000000000000000000000000000000000000000808080008080
      80008080800080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0080808000FFFFFF0000000000000000008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000606000006060000060
      6000006060000080C000FFFFFF0080FFFF000000000000606000006060000060
      6000006060000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      000080808000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080C0000080C0000080C0000060800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000606000006060000080C0000080
      C000008080000080C000008080000080C000008080000080C000008080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080800000FF00000080800000FF00000080800000000000000000
      C00040C0FF004000FF000000C000000000000000000000606000408080004080
      800000202000002020000020200000202000002020000020200080A0A00080A0
      A0000020200000606000000000000000000000000000000000000080C0000080
      C0000080C000008080000080C000008080000080C000008080000080C0000000
      0000000000000000000000000000000000000060600080FFFF00006060000080
      C0000080C0000080C0000080C000008080000080C000008080000080C0000080
      8000000000000000000000000000000000000000000000000000008020000060
      20000060200000800000808000000000000000000000000000000000000040C0
      FF004000FF000000C000000000000000000000000000006060004080800080C0
      C000404040004040400000202000002020000020200000202000FFC0C00080A0
      A0000020200040808000000000000000000000000000000000000080C0000080
      C0000080C0000080C000008080000080C000008080000080C000008080000000
      0000000000000000000000000000000000000060600080FFFF0000C0FF000060
      60000080C0000080C0000080C0000080C0000080C0000080C000008080000080
      C00000808000000000000000000000000000000000000080200040C0200040C0
      200000802000008020004040400080808000FF802000FF802000806020000000
      00000000C000000000000000000000000000000000000060600080C0C00080C0
      C000404040004040400040404000404040004040400000202000FFFFFF00FFC0
      C0000020200040808000000000000000000000000000000000000080C0000080
      C0000080C0000080C0000080C0000080C0000080C000008080000080C0000000
      0000000000000000000000000000000000000060600080FFFF00FFFFFF0000C0
      FF00006060000080C0000080C0000080C0000080C0000080C0000080C0000080
      80000080C000008080000000000000000000000000000080200040FF200040FF
      200040C020004040400080808000FFC08000FFC02000FFC02000FF8020008060
      200000000000000000000000000000000000000000000060600080C0C00080C0
      C000404040004040400040404000404040004040400040404000404040004040
      40000020200040808000000000000000000000000000000000000080C0000080
      C0000080C0000080C0000080C0000080C0000080C0000080C000008080000000
      0000000000000000000000000000000000000060600080FFFF0000C0FF00FFFF
      FF0000C0FF000060600000606000006060000060600000606000006060000060
      6000006060000060600000606000000000000080200080FFC00040FF200040C0
      20000080000040404000FFC08000FFFFC000FFFF8000FFFF8000FFC02000FF80
      2000000000008000200000000000000000000000000000606000FFFFFF0080C0
      C00080C0C00080C0C00080C0C00080C0C00080C0C00080C0C00080C0C00080C0
      C00080C0C00040808000000000000000000000000000000000000080C0000080
      C0000080C0000080C0000080C0000080C0000080C0000080C0000080C0000000
      0000000000000000000000000000000000000060600080FFFF00FFFFFF0000C0
      FF00FFFFFF0000C0FF0000C0FF0000C0FF0000C0FF0000C0FF00000000000000
      0000000000000000000000000000000000000080200080FFC00040FF20000080
      2000FF80000040404000FFC08000FFFFFF00FFFFC000FFFF8000FFC02000FF80
      200000000000FF00000000000000000000000000000000606000FFFFFF0080C0
      C000006060000060600000606000006060000060600000606000006060000060
      600080C0C00040808000000000000000000000000000000000000080C0000080
      C0000080C0000080C0000080C0000080C0000080C0000080C0000080C0000000
      0000000000000000000000000000000000000060600080FFFF0000C0FF00FFFF
      FF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF00000000000000
      000000000000000000000000000000000000008020000080200000802000FFC0
      2000FFC020004040400080808000FFFFFF00FFFFFF00FFFFC000FFC080008080
      800000000000FF60200000000000000000000000000000606000FFFFFF004080
      8000FFFFFF00FFFFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FFFF0080FF
      FF000060600080C0C00000000000000000000000000000000000000000000000
      0000000000000080C0000080C0000080C0000080C0000080C0000080C0000000
      00000000000000000000000000000000000000606000FFFFFF0080FFFF0080C0
      C000006060000060600000606000006060000060600000606000006060000000
      000000000000000000000000000000000000FF602000FFFFC000FFFF2000FFC0
      2000FFC02000FF8000004040400080808000FFC08000FFC08000808080000000
      0000FF602000FF60200000000000000000000000000000606000FFFFFF004080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FFFF0080FF
      FF000060600080C0C0000000000000000000000000000000000000C0FF00FFFF
      FF0000C0FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000606000006060000060
      6000000000000000000000000000000000000000000000000000000000000000
      000040200000402000004020000000000000FF602000FFFFC000FF8000000080
      000000800000FFC02000FF80000040404000404040004040400040404000FF80
      0000FF6020008000200000000000000000000000000000606000FFFFFF004080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FF
      FF000060600080C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080200000402000000000000000000000FF6020000080000040C0
      200000802000FF602000FF800000FF800000FF800000FF602000FF800000FF60
      2000FF0000000000000000000000000000000000000000606000FFFFFF004080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FF
      FF000060600080C0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008020000000000000000000000000
      000080200000000000004020000000000000000000000060200080FFC00040FF
      200040C0200000800000FF602000FF800000FF800000FF800000FF602000FF80
      0000FF6020000000000000000000000000000000000000606000FFFFFF004080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0080FF
      FF00006060000060600000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080200000802000008020
      00000000000000000000000000000000000000000000000000000060200080FF
      C00040FF200040C02000008020000080000000800000FF60200080800000FF60
      2000000000000000000000000000000000000000000000606000FFFFFF004080
      8000408060004080600040806000408060004080600040806000408060004080
      600000606000FFC0C00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000060
      20000060200040FF200040FF200040C020000080200000800000FF602000FF60
      2000000000000000000000000000000000000000000000606000006060004080
      8000408060004080600040806000408060004080600040806000408060004080
      6000006060000060600000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000602000006020000060200000602000FF602000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000B00000000100010000000000800500000000000000000000
      000000000000000000000000FFFFFF00FFFF800300000000FF80800300000000
      FF80800300000000DF80800300000000CF808003000000008400800300000000
      4C008003000000005C008003000000007C018003000000007C07800300000000
      B407800300000000F807800300000000F00F800300000000F8FF800700000000
      F57F800F00000000FFFF801F00000000FFFF8001FFFFFC00DFFB80010001F800
      8FFF80010001E00087F780010001C000C7EF800100018000E3CF800100018000
      F19F800100010000F83F800100010000FC7F800100010000F83F800100010000
      F19F800100010001C3CF80010001800387E7800180FF80038FFB8003C1FFC007
      FFFF8007FFFFE00FFFFF800FFFFFF83FFC1FFFFFF000FFFFF007C007F0000001
      E003C007F0000001C001C007F0000001C001C007000000018000C00700000001
      8000C007000000018000C007000000018000C007000000018000C007001F0001
      C001C007003B0001C001C00F007B0001E003C01F00600000F007C03F007BFFF0
      FC1FFFFF007BFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFC
      FFFFFFFFFFFFFFFAFFFFFFFFFFFFFFF6FFFFFFFFFFFFFFFFFDEFEF7FDEF7000F
      F9CFE73FCE77000FF18FE31FC637000FE10FE10FC217000FF18FE31FC637000F
      F9CFE73FCE77000FFDEFEF7FDEF7000FFFFFFFFFFFFF000FFFFFFFFFFFFF000F
      FFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFCFFFFFFFFFFFFFFFC3FFF18FF00FFFFFC0FFF18FF00FDEF7
      C03FF18FF00FDCE7C00FF18FF00FD8C7C007F18FF00FD087C00FF18FF00FD8C7
      C03FF18FF00FDCE7C0FFF18FF00FDEF7C3FFF18FF00FFFFFCFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7FFC008001F83FF83FF8008001
      F3DFE01FE0008001E7FF800FC0008001E7FF000780008001E7E7000380008001
      00C30001000080018181000000008001C300000000008001E7E7800100008001
      FFE7C00100018001FFE7E00080038001FBCFF00180038001FC1FF807C0078003
      FFFFFC1FE00F8007FFFFFE7FF83F800F0000C000FFFFFFFF00008000FFFFFFFF
      00000000FFFFFFFF00000000FDFFFFBF00008000F9FFFF9F00008000F1FFFF8F
      00008000E003C00700008000C003C00300008000C003C00300008000E003C007
      00008000F1FFFF8F00008000F9FFFF9F00008000FDFFFFBF00008000FFFFFFFF
      00008000FFFFFFFF00008001FFFFFFFFFFFFFFF3EFFFFF3F0001FFE1C7FFFE1F
      0001FFC183FFFC1F0001FF83EFFFC03F0001F007EFFF80770001C00FEF3F00E7
      0001801FFE1F00C10001801FFC1F00E60001000FC03F00F60001000F807F81FE
      0001000F00FBC3BF0001000F00F9FFB780FF801F00C0FFB3C1FF801F00F9FFC1
      FFFFC03F81FBFFF3FFFFF0FFC3FFFFF7EF8FFFFFFFFFFFFFC78FF00100010001
      C78FF00100010001C78FF001000100010001F001000100010001F00100010001
      0001000100010001000100010001000100010003000100010001001F00010001
      0001001F000100010001001F000100010001001F80FF80FF0001003FC1FFC1FF
      000187FFFFFFFFFF0001FFFFFFFFFFFFFFFFFFE7FFFFFFFFC007F000FC01FE00
      8003F000FC0180000001F000FC0100000001F000000100000001C00000010000
      000080000001000100000000000100038000000000030003C000000000070003
      E0010000000F0003E007000000FF0003F007800001FF0003F003C00103FF8007
      F803F003FFFFF87FFFFFF007FFFFFFFFFFFFFFF9FFFFFFFF001FF830C001800F
      000FE0008001800F0007C0018001800F000380038001800F000180038001800F
      000000018001800F001F00018001800F001F00018001800F001F00018001800F
      8FF100018001C7FDFFF980038001FF1DFF7580038001FF39FF8FC0078001FF43
      FFFFE00F8001FFFFFFFFF83FFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object MRU: TMRUFiles
    MenuItem = NRecent
    MaxEntries = 8
    Numbered = False
    OnClick = MRUClick
    Left = 454
    Top = 195
  end
  object dlgOpen: TFuturisOpenDialog
    Filter = 'All files (*.*)|*.*'
    Title = 'Open image ...'
    OnFolderChange = dlgOpenFolderChange
    ShowPlacesBar = True
    OnPreview = dlgOpenPreview
    Left = 454
    Top = 133
  end
  object dlgInstPlug: TOpenDialog
    DefaultExt = 'fzp'
    Filter = 'Futuris Imager Plug-in Packages (*.fzp)|*.fzp'
    Title = 'Select plug-in package to install ...'
    Left = 516
    Top = 133
  end
  object imlDisabled: TImageList
    Left = 485
    Top = 164
    Bitmap = {
      494C01012A002C00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000B0000000010020000000000000B0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900494949004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000049494900494949004949
      490049494900494949004949490049494900000000009D9D9D00E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E6004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009D9D9D00E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E60049494900000000009D9D9D00FFFFFF00FFFF
      FF00CCCCCC00FFFFFF00CCCCCC006D6D6D00CCCCCC00FFFFFF00CCCCCC00FFFF
      FF00E6E6E6004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000555555000000
      000000000000000000000000000000000000000000009D9D9D00FFFFFF00CCCC
      CC00FFFFFF00CCCCCC00E6E6E60049494900000000009D9D9D00FFFFFF00CCCC
      CC00FFFFFF00CCCCCC006D6D6D006D6D6D00FFFFFF00CCCCCC00FFFFFF00CCCC
      CC00E6E6E6004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006D6D6D005555
      550000000000000000000000000000000000000000009D9D9D00FFFFFF00FFFF
      FF00CCCCCC00FFFFFF00E6E6E60049494900000000009D9D9D00FFFFFF00FFFF
      FF00CCCCCC006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D00CCCCCC00FFFF
      FF00E6E6E6004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000555555009D9D9D009D9D
      9D006D6D6D00000000004949490049494900494949009D9D9D00FFFFFF00CCCC
      CC00FFFFFF00CCCCCC00E6E6E60049494900000000009D9D9D00FFFFFF00CCCC
      CC00FFFFFF00CCCCCC006D6D6D006D6D6D00FFFFFF006D6D6D0061616100CCCC
      CC00E6E6E6004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000055555500000000009D9D9D006D6D
      6D0000000000000000009D9D9D00E6E6E600E6E6E6009D9D9D00FFFFFF00FFFF
      FF00CCCCCC00FFFFFF00E6E6E60049494900000000009D9D9D00FFFFFF00FFFF
      FF00CCCCCC00FFFFFF00CCCCCC006D6D6D00CCCCCC00FFFFFF0061616100FFFF
      FF00E6E6E6004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6D00000000006D6D6D000000
      000000000000000000009D9D9D00FFFFFF00FFFFFF009D9D9D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF004949490049494900000000009D9D9D00FFFFFF00CCCC
      CC0061616100CCCCCC00FFFFFF00CCCCCC00FFFFFF00CCCCCC0061616100CCCC
      CC00E6E6E6004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6D0000000000000000000000
      000000000000000000009D9D9D00FFFFFF00CCCCCC009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D0000000000000000009D9D9D00FFFFFF00FFFF
      FF0061616100FFFFFF00CCCCCC006D6D6D00CCCCCC00FFFFFF00CCCCCC00FFFF
      FF00E6E6E6004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6D0000000000000000000000
      000000000000000000009D9D9D00FFFFFF00FFFFFF00CCCCCC00FFFFFF00E6E6
      E60049494900000000000000000000000000000000009D9D9D00FFFFFF00CCCC
      CC00616161006D6D6D00FFFFFF006D6D6D006D6D6D00CCCCCC00FFFFFF00CCCC
      CC00E6E6E6004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006D6D6D00000000000000
      0000868686000000000086868600FFFFFF0086868600FFFFFF00CCCCCC00E6E6
      E60049494900000000000000000000000000000000009D9D9D00FFFFFF00FFFF
      FF00CCCCCC006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D00CCCCCC00FFFF
      FF00E6E6E6004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000868686006D6D6D0086868600FFFFFF00FFFFFF00FFFFFF004949
      490049494900000000000000000000000000000000009D9D9D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF006D6D6D006D6D6D00CCCCCC00FFFFFF00E6E6
      E600E6E6E6004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000868686006D6D6D00FFFFFF006D6D6D00868686009D9D9D009D9D9D004949
      490000000000000000000000000000000000000000009D9D9D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF006D6D6D00CCCCCC00FFFFFF00494949004949
      4900494949004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000868686006D6D6D00868686000000000000000000000000000000
      000000000000000000000000000000000000000000009D9D9D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CCCCCC00FFFFFF00CCCCCC009D9D9D00FFFF
      FF00494949000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000868686000000000086868600000000008686860000000000000000000000
      000000000000000000000000000000000000000000009D9D9D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009D9D9D004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900494949004949490049494900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000049494900494949004949490049494900494949004949
      49004949490049494900494949004949490000000000000000006D6D6D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009D9D9D0000000000000000000000000049494900FFFFFF00E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E60049494900000000004949490049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900494949004949490049494900000000000000000000000000000000000000
      000000000000494949009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D004949490000000000868686009D9D9D006D6D
      6D00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000049494900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E6E6E600494949000000000061616100CCCCCC009D9D9D009D9D
      9D009D9D9D008686860086868600868686008686860086868600868686008686
      8600868686008686860049494900000000000000000000000000000000004949
      4900494949009D9D9D009D9D9D00FFFFFF00B6B6B600FFFFFF00FFFFFF00FFFF
      FF00B6B6B600FFFFFF009D9D9D004949490000000000868686009D9D9D009D9D
      9D006D6D6D000000000000000000000000000000000000000000000000000000
      00009D9D9D000000000000000000000000000000000049494900FFFFFF00FFFF
      FF00E6E6E600E6E6E600E6E6E600AAAAAA00AAAAAA00AAAAAA00E6E6E600E6E6
      E600FFFFFF00E6E6E600494949000000000061616100CCCCCC009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D0086868600868686008686
      8600868686008686860049494900000000000000000000000000494949009D9D
      9D009D9D9D009D9D9D009D9D9D00FFFFFF00FFFFFF00FFFFFF00B6B6B600FFFF
      FF00FFFFFF00FFFFFF009D9D9D00494949000000000000000000868686009D9D
      9D00868686000000000000000000000000000000000000000000000000009D9D
      9D00000000000000000000000000000000000000000049494900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E6E6E600494949000000000061616100CCCCCC00FFFFFF009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D0086868600868686008686
      86008686860086868600494949000000000000000000494949009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D00FFFFFF00B6B6B6006D6D6D006D6D6D006D6D
      6D009D9D9D00FFFFFF009D9D9D00494949000000000000000000000000008686
      86009D9D9D006D6D6D00000000000000000000000000000000009D9D9D006D6D
      6D00000000000000000000000000000000000000000049494900FFFFFF00FFFF
      FF00FFFFFF009D9D9D008686860079797900FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E6E6E600494949000000000061616100CCCCCC009D9D9D00FFFF
      FF009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D008686
      86008686860086868600494949000000000000000000494949009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D00FFFFFF006D6D6D009D9D9D009D9D9D009D9D
      9D006D6D6D00FFFFFF009D9D9D00494949000000000000000000000000000000
      0000868686009D9D9D006D6D6D0000000000000000009D9D9D006D6D6D000000
      0000000000000000000000000000000000000000000049494900FFFFFF00FFFF
      FF00FFFFFF009D9D9D00DADADA0086868600C2C2C200B6B6B600AAAAAA00FFFF
      FF00FFFFFF00E6E6E600494949000000000061616100CCCCCC00FFFFFF009D9D
      9D00FFFFFF009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D0086868600868686004949490000000000494949009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D00FFFFFF006D6D6D009D9D9D006D6D6D009D9D
      9D006D6D6D00FFFFFF009D9D9D00494949000000000000000000000000000000
      000000000000868686009D9D9D006D6D6D009D9D9D006D6D6D00000000000000
      0000000000000000000000000000000000000000000049494900FFFFFF00FFFF
      FF00FFFFFF00B6B6B6009D9D9D009D9D9D00FFFFFF00FFFFFF009D9D9D00FFFF
      FF00FFFFFF00E6E6E600494949000000000061616100CCCCCC009D9D9D00FFFF
      FF009D9D9D00FFFFFF009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D0086868600868686004949490000000000494949009D9D9D009D9D9D009D9D
      9D006D6D6D006D6D6D009D9D9D00FFFFFF006D6D6D00FFFFFF009D9D9D006D6D
      6D006D6D6D00FFFFFF009D9D9D00494949000000000000000000000000000000
      00000000000000000000868686009D9D9D006D6D6D0000000000000000000000
      0000000000000000000000000000000000000000000049494900FFFFFF009D9D
      9D009D9D9D0086868600C2C2C20086868600FFFFFF00FFFFFF009D9D9D00FFFF
      FF00FFFFFF00E6E6E600494949000000000061616100CCCCCC00FFFFFF009D9D
      9D00FFFFFF009D9D9D00FFFFFF009D9D9D009D9D9D009D9D9D009D9D9D008686
      86009D9D9D00868686004949490000000000494949009D9D9D009D9D9D006D6D
      6D006D6D6D006D6D6D009D9D9D00FFFFFF00B6B6B6006D6D6D006D6D6D006D6D
      6D009D9D9D00FFFFFF009D9D9D00494949000000000000000000000000000000
      000000000000868686009D9D9D006D6D6D00868686006D6D6D00000000000000
      0000000000000000000000000000000000000000000049494900FFFFFF00B6B6
      B600FFFFFF00FFFFFF00B6B6B600AAAAAA009D9D9D009D9D9D006D6D6D00FFFF
      FF00FFFFFF00E6E6E600494949000000000061616100CCCCCC009D9D9D00FFFF
      FF009D9D9D00FFFFFF009D9D9D00FFFFFF009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D00868686004949490000000000494949009D9D9D009D9D9D006D6D
      6D006D6D6D006D6D6D009D9D9D00FFFFFF00FFFFFF00FFFFFF00B6B6B600FFFF
      FF00494949004949490049494900494949000000000000000000000000000000
      0000868686009D9D9D006D6D6D000000000000000000868686006D6D6D000000
      0000000000000000000000000000000000000000000049494900FFFFFF00B6B6
      B600FFFFFF00FFFFFF00FFFFFF0086868600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E6E6E600494949000000000061616100CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC004949490000000000494949009D9D9D009D9D9D00E6E6
      E6006D6D6D006D6D6D009D9D9D00FFFFFF00B6B6B600FFFFFF00FFFFFF00FFFF
      FF009D9D9D00FFFFFF009D9D9D00000000000000000000000000868686009D9D
      9D009D9D9D006D6D6D0000000000000000000000000000000000868686006D6D
      6D00000000000000000000000000000000000000000049494900FFFFFF00CCCC
      CC00FFFFFF00FFFFFF00FFFFFF009D9D9D00FFFFFF00FFFFFF00E6E6E600FFFF
      FF00FFFFFF00FFFFFF0049494900000000006161610061616100616161006161
      6100616161006161610061616100616161006161610061616100616161006161
      610061616100616161004949490000000000000000009D9D9D009D9D9D009D9D
      9D00FFFFFF00E6E6E6009D9D9D00FFFFFF00FFFFFF00FFFFFF00B6B6B600FFFF
      FF009D9D9D009D9D9D00000000000000000000000000868686009D9D9D009D9D
      9D006D6D6D000000000000000000000000000000000000000000000000008686
      86006D6D6D000000000000000000000000000000000049494900FFFFFF00CCCC
      CC00CCCCCC00B6B6B600B6B6B6009D9D9D00FFFFFF00FFFFFF00E6E6E6004949
      4900494949004949490049494900000000000000000061616100CCCCCC00CCCC
      CC00B6B6B600CCCCCC00B6B6B600494949000000000000000000000000000000
      000000000000000000000000000000000000000000009D9D9D009D9D9D00FFFF
      FF00E6E6E600FFFFFF009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D004949490000000000000000000000000086868600868686008686
      8600000000000000000000000000000000000000000000000000000000000000
      0000000000008686860000000000000000000000000049494900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6E6E6004949
      4900FFFFFF004949490000000000000000000000000000000000616161006161
      6100616161006161610061616100000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009D9D9D009D9D
      9D009D9D9D00E6E6E600FFFFFF00E6E6E6006D6D6D006D6D6D006D6D6D006D6D
      6D00494949000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000049494900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004949
      4900494949000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009D9D
      9D009D9D9D009D9D9D009D9D9D00FFFFFF00E6E6E6006D6D6D00494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000049494900494949004949490049494900494949000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000494949004949490049494900494949004949490049494900494949004949
      4900494949004949490049494900494949000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000494949004949490049494900494949004949490049494900494949004949
      4900494949000000000000000000000000000000000000000000494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900494949000000000000000000000000000000000000000000000000000000
      000061616100FFFFFF009D9D9D009D9D9D008686860086868600868686006D6D
      6D00868686006D6D6D0086868600494949004949490049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900494949004949490049494900000000000000000000000000000000004949
      4900616161006161610061616100616161006161610061616100494949004949
      49004949490049494900000000000000000000000000000000009D9D9D00E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600494949000000000000000000000000000000000000000000000000000000
      000061616100FFFFFF009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D008686
      86009D9D9D00868686006D6D6D00494949009D9D9D00E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E60049494900000000000000000000000000494949006161
      6100868686006D6D6D006D6D6D006D6D6D006D6D6D0061616100616161006161
      61004949490049494900494949000000000000000000000000009D9D9D00FFFF
      FF00FFFFFF00CCCCCC00FFFFFF00CCCCCC00FFFFFF00CCCCCC00FFFFFF00E6E6
      E600494949000000000000000000000000000000000000000000000000000000
      000061616100FFFFFF00FFFFFF009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D00868686006D6D6D0086868600494949009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0049494900FFFFFF00FFFF
      FF00FFFFFF00E6E6E60049494900000000000000000000000000494949008686
      8600868686006D6D6D006D6D6D00FFFFFF006D6D6D006D6D6D006D6D6D006161
      61006161610049494900494949000000000000000000000000009D9D9D00FFFF
      FF00CCCCCC00FFFFFF00CCCCCC00FFFFFF00CCCCCC00FFFFFF00CCCCCC00E6E6
      E600494949000000000000000000000000004949490049494900494949004949
      490061616100FFFFFF009D9D9D00FFFFFF009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D00868686006D6D6D00494949009D9D9D00FFFFFF009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D004949490049494900FFFF
      FF00FFFFFF00E6E6E60049494900000000000000000049494900868686008686
      86006D6D6D006D6D6D006D6D6D00FFFFFF00FFFFFF006D6D6D006D6D6D006D6D
      6D006161610049494900494949004949490000000000000000009D9D9D00FFFF
      FF00FFFFFF00CCCCCC00FFFFFF00CCCCCC00FFFFFF00CCCCCC00FFFFFF00E6E6
      E600494949000000000000000000000000009D9D9D00E6E6E600E6E6E600E6E6
      E60061616100FFFFFF00FFFFFF009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D008686860086868600494949009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0049494900494949004949
      4900FFFFFF00E6E6E60049494900000000000000000049494900868686009D9D
      9D006D6D6D006D6D6D006D6D6D00FFFFFF00FFFFFF00FFFFFF006D6D6D006D6D
      6D006161610061616100494949004949490000000000000000009D9D9D00FFFF
      FF00CCCCCC00FFFFFF00CCCCCC00FFFFFF00CCCCCC00FFFFFF00CCCCCC00E6E6
      E600494949000000000000000000000000009D9D9D00FFFFFF00AAAAAA00AAAA
      AA0061616100FFFFFF009D9D9D00FFFFFF009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D0086868600494949009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00AAAAAA00AAAAAA00AAAAAA00AAAAAA0086868600FFFFFF00B6B6
      B60049494900E6E6E60049494900000000000000000049494900868686009D9D
      9D006D6D6D006D6D6D006D6D6D00FFFFFF00FFFFFF00FFFFFF00FFFFFF006D6D
      6D006D6D6D0061616100494949004949490000000000000000009D9D9D00FFFF
      FF00FFFFFF00CCCCCC00FFFFFF00CCCCCC00FFFFFF00CCCCCC00FFFFFF00E6E6
      E600494949000000000000000000000000009D9D9D00CCCCCC00FFFFFF00CCCC
      CC0061616100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00494949009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0086868600B6B6B6006D6D
      6D0049494900E6E6E60049494900000000000000000049494900868686009D9D
      9D00868686006D6D6D006D6D6D00FFFFFF00FFFFFF00FFFFFF006D6D6D006D6D
      6D006D6D6D0061616100494949004949490000000000000000009D9D9D00FFFF
      FF00FFFFFF00FFFFFF00CCCCCC00FFFFFF00CCCCCC00FFFFFF00CCCCCC00E6E6
      E600494949000000000000000000000000009D9D9D00FFFFFF00AAAAAA00AAAA
      AA0061616100B6B6B60086868600B6B6B60086868600B6B6B600616161006161
      6100616161006161610061616100494949009D9D9D00FFFFFF00AAAAAA00AAAA
      AA00AAAAAA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006D6D6D009D9D
      9D006D6D6D004949490049494900000000000000000049494900868686009D9D
      9D00868686006D6D6D006D6D6D00FFFFFF00FFFFFF006D6D6D006D6D6D006D6D
      6D006D6D6D0061616100494949004949490000000000000000009D9D9D00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CCCCCC00FFFFFF00CCCCCC00E6E6E600E6E6
      E600494949000000000000000000000000009D9D9D00CCCCCC00FFFFFF00CCCC
      CC00FFFFFF0061616100FFFFFF009D9D9D00B6B6B60086868600494949000000
      0000000000000000000000000000000000009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006D6D6D00CCCC
      CC009D9D9D004949490049494900000000000000000000000000494949008686
      86009D9D9D00868686006D6D6D00FFFFFF006D6D6D006D6D6D006D6D6D006D6D
      6D006D6D6D0061616100494949000000000000000000000000009D9D9D00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CCCCCC0049494900494949004949
      4900494949000000000000000000000000009D9D9D00FFFFFF00616161006161
      6100CCCCCC00AAAAAA0061616100616161006161610061616100000000000000
      0000000000004949490000000000000000009D9D9D006D6D6D006D6D6D006D6D
      6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D
      6D009D9D9D006D6D6D0049494900000000000000000000000000494949008686
      86009D9D9D009D9D9D0086868600868686006D6D6D006D6D6D006D6D6D006D6D
      6D006D6D6D0049494900494949000000000000000000000000009D9D9D00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009D9D9D00FFFFFF004949
      4900000000000000000000000000000000009D9D9D00FFFFFF006D6D6D006161
      6100FFFFFF00FFFFFF00CCCCCC00E6E6E6004949490000000000000000000000
      0000000000004949490000000000000000009D9D9D00AAAAAA00AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA006D6D
      6D00CCCCCC009D9D9D0049494900000000000000000000000000000000004949
      490086868600868686009D9D9D009D9D9D00868686006D6D6D006D6D6D006D6D
      6D006161610049494900000000000000000000000000000000009D9D9D00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009D9D9D00494949000000
      0000000000000000000000000000000000009D9D9D00FFFFFF00868686006161
      6100FFFFFF00AAAAAA00AAAAAA00E6E6E6004949490000000000000000004949
      4900494949004949490049494900494949009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D006D6D6D009D9D9D006D6D6D00494949000000000000000000000000000000
      00004949490049494900868686008686860086868600868686006D6D6D004949
      49004949490000000000000000000000000000000000000000009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D00000000000000
      0000000000000000000000000000000000009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00E6E6E6004949490000000000000000000000
      0000000000004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006D6D6D009D9D9D009D9D9D00494949000000000000000000000000000000
      0000000000000000000049494900494949004949490049494900494949000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D004949490000000000000000000000
      0000000000004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006D6D6D006D6D6D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000494949004949490049494900494949000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000049494900494949000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004949490000000000494949000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000494949000000000000000000494949000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000049494900000000000000000000000000000000004949
      4900000000000000000000000000000000000000000000000000000000004949
      4900000000000000000000000000000000004949490000000000000000000000
      0000000000000000000000000000000000000000000000000000494949000000
      0000000000000000000000000000494949000000000000000000000000000000
      0000494949000000000000000000000000004949490049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000004949490049494900000000000000000000000000494949004949
      4900000000000000000000000000000000000000000000000000000000004949
      4900494949000000000000000000000000004949490049494900000000000000
      0000000000000000000000000000000000000000000000000000494949004949
      4900000000000000000000000000494949004949490000000000000000000000
      0000494949000000000000000000000000004949490049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D00494949000000000000000000494949006D6D6D004949
      4900000000000000000000000000000000000000000000000000000000004949
      49006D6D6D00494949000000000000000000494949006D6D6D00494949000000
      0000000000000000000000000000000000000000000000000000494949006D6D
      6D00494949000000000000000000494949006D6D6D0049494900000000000000
      00004949490000000000000000000000000049494900494949009D9D9D009D9D
      9D00AAAAAA00AAAAAA00B6B6B600FFFFFF00FFFFFF009D9D9D00494949004949
      4900000000000000000000000000000000000000000000000000000000004949
      49006D6D6D006D6D6D004949490000000000494949006D6D6D006D6D6D004949
      4900000000000000000000000000000000000000000000000000000000004949
      49006D6D6D006D6D6D004949490000000000494949006D6D6D006D6D6D004949
      4900000000000000000000000000000000000000000000000000494949006D6D
      6D006D6D6D004949490000000000494949006D6D6D006D6D6D00494949000000
      00004949490000000000000000000000000049494900494949009D9D9D00AAAA
      AA00AAAAAA00B6B6B600FFFFFF00FFFFFF009D9D9D009D9D9D00494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D00494949000000000000000000494949006D6D6D004949
      4900000000000000000000000000000000000000000000000000000000004949
      49006D6D6D00494949000000000000000000494949006D6D6D00494949000000
      0000000000000000000000000000000000000000000000000000494949006D6D
      6D00494949000000000000000000494949006D6D6D0049494900000000000000
      0000494949000000000000000000000000004949490049494900AAAAAA00AAAA
      AA00B6B6B600FFFFFF00FFFFFF009D9D9D009D9D9D0086868600494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000004949490049494900000000000000000000000000494949004949
      4900000000000000000000000000000000000000000000000000000000004949
      4900494949000000000000000000000000004949490049494900000000000000
      0000000000000000000000000000000000000000000000000000494949004949
      4900000000000000000000000000494949004949490000000000000000000000
      0000494949000000000000000000000000004949490049494900AAAAAA00B6B6
      B600FFFFFF00FFFFFF009D9D9D009D9D9D008686860086868600494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000049494900000000000000000000000000000000004949
      4900000000000000000000000000000000000000000000000000000000004949
      4900000000000000000000000000000000004949490000000000000000000000
      0000000000000000000000000000000000000000000000000000494949000000
      0000000000000000000000000000494949000000000000000000000000000000
      0000494949000000000000000000000000004949490049494900B6B6B600FFFF
      FF00FFFFFF009D9D9D009D9D9D00868686008686860079797900494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004949490049494900FFFFFF00FFFF
      FF009D9D9D009D9D9D008686860086868600797979006D6D6D00494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004949490049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004949490049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000494949006D6D
      6D00494949004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000494949004949490049494900000000000000000049494900494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000494949004949490049494900494949004949490049494900494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000494949006D6D
      6D006D6D6D006D6D6D0049494900494949000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D00494949000000000000000000494949006D6D6D004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D004949
      4900000000000000000000000000000000000000000000000000494949000000
      0000000000000000000000000000494949000000000000000000000000000000
      0000494949000000000000000000000000000000000000000000494949006D6D
      6D006D6D6D006D6D6D006D6D6D006D6D6D004949490049494900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D00494949000000000000000000494949006D6D6D004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D004949
      4900000000000000000000000000000000000000000000000000494949000000
      0000000000000000000049494900494949000000000000000000000000004949
      4900494949000000000000000000000000000000000000000000494949006D6D
      6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D00494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D00494949000000000000000000494949006D6D6D004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D004949
      4900000000000000000000000000000000000000000000000000494949000000
      000000000000494949006D6D6D00494949000000000000000000494949006D6D
      6D00494949000000000000000000000000000000000000000000494949006D6D
      6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D
      6D00494949000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D00494949000000000000000000494949006D6D6D004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D004949
      4900000000000000000000000000000000000000000000000000494949000000
      0000494949006D6D6D006D6D6D004949490000000000494949006D6D6D006D6D
      6D00494949000000000000000000000000000000000000000000494949006D6D
      6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D00494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D00494949000000000000000000494949006D6D6D004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D004949
      4900000000000000000000000000000000000000000000000000494949000000
      000000000000494949006D6D6D00494949000000000000000000494949006D6D
      6D00494949000000000000000000000000000000000000000000494949006D6D
      6D006D6D6D006D6D6D006D6D6D006D6D6D004949490049494900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D00494949000000000000000000494949006D6D6D004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D004949
      4900000000000000000000000000000000000000000000000000494949000000
      0000000000000000000049494900494949000000000000000000000000004949
      4900494949000000000000000000000000000000000000000000494949006D6D
      6D006D6D6D006D6D6D0049494900494949000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D00494949000000000000000000494949006D6D6D004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000494949006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D004949
      4900000000000000000000000000000000000000000000000000494949000000
      0000000000000000000000000000494949000000000000000000000000000000
      0000494949000000000000000000000000000000000000000000494949006D6D
      6D00494949004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000494949004949490049494900000000000000000049494900494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000494949004949490049494900494949004949490049494900494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000616161004949490000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000049494900494949004949490049494900494949004949
      4900494949004949490049494900494949000000000049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900494949004949490049494900000000000000000000000000000000000000
      0000000000009D9D9D0049494900494949004949490049494900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006161610061616100868686006D6D6D0049494900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000494949009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D00494949000000000049494900CCCCCC00FFFF
      FF009D9D9D00FFFFFF009D9D9D00FFFFFF009D9D9D00FFFFFF009D9D9D00FFFF
      FF009D9D9D00FFFFFF0049494900000000000000000000000000000000000000
      00009D9D9D004949490000000000000000000000000000000000494949000000
      0000000000000000000000000000000000000000000000000000000000006161
      61006161610086868600C2C2C200FFFFFF00E6E6E6006D6D6D00494949000000
      0000000000000000000000000000000000000000000000000000000000004949
      4900494949009D9D9D009D9D9D00FFFFFF00B6B6B600FFFFFF00FFFFFF00FFFF
      FF00B6B6B600FFFFFF009D9D9D00494949000000000049494900FFFFFF00CCCC
      CC00FFFFFF00CCCCCC00FFFFFF00E6E6E600FFFFFF009D9D9D00FFFFFF009D9D
      9D00FFFFFF009D9D9D0049494900000000000000000000000000000000009D9D
      9D009D9D9D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000061616100616161008686
      8600C2C2C200FFFFFF00FFFFFF00FFFFFF00E6E6E600E6E6E6006D6D6D004949
      4900000000000000000000000000000000000000000000000000494949009D9D
      9D009D9D9D009D9D9D009D9D9D00FFFFFF00FFFFFF00FFFFFF00B6B6B600FFFF
      FF00FFFFFF00FFFFFF009D9D9D00494949000000000049494900CCCCCC00FFFF
      FF00CCCCCC00FFFFFF00E6E6E6009D9D9D00E6E6E600FFFFFF009D9D9D00FFFF
      FF009D9D9D00FFFFFF0049494900000000000000000000000000000000009D9D
      9D009D9D9D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6D0086868600C2C2C200FFFF
      FF00FFFFFF00E6E6E600E6E6E6006D6D6D009D9D9D00AAAAAA00E6E6E6006D6D
      6D004949490000000000000000000000000000000000494949009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D00FFFFFF00B6B6B6006D6D6D006D6D6D006D6D
      6D009D9D9D00FFFFFF009D9D9D00494949000000000049494900FFFFFF009D9D
      9D00FFFFFF009D9D9D00FFFFFF00FFFFFF00FFFFFF00CCCCCC00FFFFFF00CCCC
      CC00FFFFFF009D9D9D0049494900000000000000000000000000000000009D9D
      9D009D9D9D000000000000000000000000000000000000000000000000009D9D
      9D00494949000000000000000000000000006D6D6D009D9D9D00FFFFFF00E6E6
      E600AAAAAA006D6D6D006D6D6D006D6D6D00494949009D9D9D009D9D9D00E6E6
      E6006D6D6D0049494900000000000000000000000000494949009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D00FFFFFF006D6D6D009D9D9D009D9D9D009D9D
      9D006D6D6D00FFFFFF009D9D9D004949490000000000494949009D9D9D00FFFF
      FF009D9D9D00FFFFFF009D9D9D009D9D9D009D9D9D00FFFFFF00CCCCCC00FFFF
      FF009D9D9D00FFFFFF0049494900000000009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D004949490000000000000000009D9D9D009D9D
      9D009D9D9D004949490000000000000000006D6D6D009D9D9D00E6E6E6006D6D
      6D006D6D6D009D9D9D009D9D9D009D9D9D006D6D6D0049494900797979009D9D
      9D00AAAAAA006D6D6D004949490000000000494949009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D00FFFFFF006D6D6D009D9D9D006D6D6D009D9D
      9D006D6D6D00FFFFFF009D9D9D00494949000000000049494900FFFFFF00FFFF
      FF00FFFFFF009D9D9D00FFFFFF009D9D9D009D9D9D009D9D9D00FFFFFF00CCCC
      CC00FFFFFF009D9D9D004949490000000000000000009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D004949490000000000000000009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D0049494900000000006D6D6D006D6D6D006D6D6D009D9D
      9D009D9D9D006D6D6D006D6D6D009D9D9D009D9D9D006D6D6D00494949007979
      79009D9D9D009D9D9D006D6D6D0049494900494949009D9D9D009D9D9D009D9D
      9D006D6D6D006D6D6D009D9D9D00FFFFFF006D6D6D00FFFFFF009D9D9D006D6D
      6D006D6D6D00FFFFFF009D9D9D00494949000000000049494900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF009D9D9D00FFFFFF009D9D9D009D9D9D009D9D9D00FFFF
      FF00CCCCCC00FFFFFF00494949000000000000000000000000009D9D9D009D9D
      9D009D9D9D004949490000000000000000009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D00494949006D6D6D00CCCCCC009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D006D6D6D006D6D6D006D6D6D006D6D6D004949
      4900797979009D9D9D006D6D6D0049494900494949009D9D9D009D9D9D006D6D
      6D006D6D6D006D6D6D009D9D9D00FFFFFF00B6B6B6006D6D6D006D6D6D006D6D
      6D009D9D9D00FFFFFF009D9D9D00494949000000000049494900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF009D9D9D00E6E6E6009D9D9D00FFFFFF00CCCC
      CC00FFFFFF00CCCCCC0049494900000000000000000000000000000000009D9D
      9D00494949000000000000000000000000000000000000000000000000009D9D
      9D0049494900000000000000000000000000000000006D6D6D00CCCCCC009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D006D6D6D006D6D
      6D0049494900797979006D6D6D0000000000494949009D9D9D009D9D9D006D6D
      6D006D6D6D006D6D6D009D9D9D00FFFFFF00FFFFFF00FFFFFF00B6B6B600FFFF
      FF00494949004949490049494900494949000000000049494900FFFFFF00FFFF
      FF00FFFFFF009D9D9D00FFFFFF00FFFFFF00E6E6E6009D9D9D009D9D9D00FFFF
      FF00CCCCCC00FFFFFF0049494900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009D9D
      9D004949490000000000000000000000000000000000000000006D6D6D00CCCC
      CC009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D006161
      61006D6D6D00494949006D6D6D0000000000494949009D9D9D009D9D9D00E6E6
      E6006D6D6D006D6D6D009D9D9D00FFFFFF00B6B6B600FFFFFF00FFFFFF00FFFF
      FF009D9D9D00FFFFFF009D9D9D00000000000000000049494900FFFFFF00FFFF
      FF00FFFFFF009D9D9D009D9D9D00E6E6E6009D9D9D009D9D9D00FFFFFF009D9D
      9D00FFFFFF00CCCCCC0049494900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009D9D
      9D00494949000000000000000000000000000000000000000000000000006D6D
      6D00CCCCCC009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D00868686006161
      61006D6D6D006D6D6D004949490049494900000000009D9D9D009D9D9D009D9D
      9D00FFFFFF00E6E6E6009D9D9D00FFFFFF00FFFFFF00FFFFFF00B6B6B600FFFF
      FF009D9D9D009D9D9D0000000000000000000000000049494900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF009D9D9D009D9D9D009D9D9D00FFFFFF009D9D9D00FFFF
      FF009D9D9D00FFFFFF0049494900000000000000000000000000000000000000
      0000000000009D9D9D00000000000000000000000000000000009D9D9D004949
      4900000000000000000000000000000000000000000000000000000000000000
      00006D6D6D00CCCCCC009D9D9D009D9D9D006D6D6D006D6D6D00616161006D6D
      6D006D6D6D00616161004949490000000000000000009D9D9D009D9D9D00FFFF
      FF00E6E6E600FFFFFF009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D004949490000000000000000000000000049494900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004949
      4900494949004949490049494900000000000000000000000000000000000000
      000000000000000000009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006D6D6D00CCCCCC009D9D9D009D9D9D009D9D9D006D6D6D006161
      61004949490000000000000000000000000000000000000000009D9D9D009D9D
      9D009D9D9D00E6E6E600FFFFFF00E6E6E6006D6D6D006D6D6D006D6D6D006D6D
      6D00494949000000000000000000000000000000000049494900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004949
      4900FFFFFF004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006D6D6D00CCCCCC009D9D9D0061616100494949000000
      0000000000000000000000000000000000000000000000000000000000009D9D
      9D009D9D9D009D9D9D009D9D9D00FFFFFF00E6E6E6006D6D6D00494949004949
      4900000000000000000000000000000000000000000049494900FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004949
      4900494949000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006D6D6D004949490000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D00000000000000
      0000000000000000000000000000000000000000000049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900494949004949490049494900494949000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009D9D9D00E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E6000000000000000000494949006D6D6D006D6D
      6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D
      6D006D6D6D006D6D6D006D6D6D00494949000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009D9D9D00FFFFFF00000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00E6E6E600000000009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D006D6D
      6D006D6D6D009D9D9D006D6D6D00494949000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009D9D9D00FFFFFF009D9D9D00E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E60000000000FFFF
      FF00FFFFFF00FFFFFF00E6E6E600000000009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC009D9D9D006D6D6D006D6D6D00494949000000000000000000000000000000
      0000000000000000000049494900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000049494900000000000000
      0000000000000000000000000000000000009D9D9D00FFFFFF009D9D9D00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6E6E60000000000FFFF
      FF00FFFFFF00FFFFFF00E6E6E60000000000000000009D9D9D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00CCCCCC00FFFFFF00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC006D6D6D006D6D6D00494949000000000000000000000000000000
      0000000000004949490049494900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000049494900494949000000
      0000000000000000000000000000000000009D9D9D00FFFFFF009D9D9D00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6E6E60000000000FFFF
      FF00FFFFFF00FFFFFF00E6E6E60000000000000000009D9D9D00FFFFFF00FFFF
      FF006D6D6D006161610061616100616161006161610061616100CCCCCC00CCCC
      CC00CCCCCC009D9D9D006D6D6D00494949000000000000000000000000000000
      000049494900AAAAAA0049494900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000049494900AAAAAA004949
      4900000000000000000000000000000000009D9D9D00FFFFFF009D9D9D00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6E6E60000000000FFFF
      FF00FFFFFF00FFFFFF00E6E6E60000000000000000009D9D9D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00CCCCCC00FFFFFF00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC009D9D9D006D6D6D00494949000000000000000000000000004949
      4900AAAAAA00AAAAAA0049494900494949004949490049494900494949004949
      4900494949004949490000000000000000000000000000000000494949004949
      4900494949004949490049494900494949004949490049494900AAAAAA00AAAA
      AA00494949000000000000000000000000009D9D9D00FFFFFF009D9D9D00AAAA
      AA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA0000000000FFFF
      FF00FFFFFF00FFFFFF00E6E6E60000000000000000009D9D9D00FFFFFF00FFFF
      FF006D6D6D006D6D6D006D6D6D00616161006161610061616100616161006161
      6100616161009D9D9D006D6D6D0049494900000000000000000049494900AAAA
      AA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAA
      AA00AAAAAA004949490000000000000000000000000000000000AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAA
      AA00AAAAAA004949490000000000000000009D9D9D00FFFFFF009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D0000000000E6E6
      E600FFFFFF00FFFFFF00E6E6E60000000000000000009D9D9D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CCCCCC00FFFFFF00CCCCCC00CCCC
      CC00CCCCCC009D9D9D006D6D6D00494949000000000000000000AAAAAA00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00AAAAAA004949490000000000000000000000000000000000AAAAAA00E6E6
      E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600E6E6E600CCCC
      CC00AAAAAA004949490000000000000000009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006D6D
      6D00E6E6E6006D6D6D00E6E6E60000000000000000009D9D9D00FFFFFF00FFFF
      FF006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D0061616100616161006161
      6100616161009D9D9D006D6D6D0049494900000000000000000000000000AAAA
      AA00CCCCCC00CCCCCC0049494900AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAA
      AA00AAAAAA004949490000000000000000000000000000000000AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00E6E6E600AAAA
      AA00494949000000000000000000000000009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF006D6D6D006D6D6D00E6E6E60000000000000000009D9D9D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CCCCCC00FFFFFF00CCCC
      CC00CCCCCC009D9D9D006D6D6D00494949000000000000000000000000000000
      0000AAAAAA00CCCCCC0049494900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AAAAAA00AAAAAA004949
      4900000000000000000000000000000000009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009D9D
      9D009D9D9D006D6D6D00E6E6E60000000000000000009D9D9D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CCCCCC00FFFF
      FF00CCCCCC009D9D9D006D6D6D00494949000000000000000000000000000000
      000000000000AAAAAA0049494900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AAAAAA00494949000000
      0000000000000000000000000000000000009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E6E6E60000000000000000009D9D9D00FFFFFF00FFFF
      FF006D6D6D006D6D6D006D6D6D006D6D6D00FFFFFF00FFFFFF00FFFFFF00CCCC
      CC00FFFFFF009D9D9D006D6D6D00494949000000000000000000000000000000
      0000000000000000000049494900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000AAAAAA00000000000000
      0000000000000000000000000000000000009D9D9D006D6D6D006D6D6D006D6D
      6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D
      6D006D6D6D006D6D6D006D6D6D0000000000000000009D9D9D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF009D9D9D006D6D6D00494949000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009D9D9D00E6E6E600AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00AAAAAA0000000000000000009D9D9D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF009D9D9D006D6D6D00494949000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D0000000000000000009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000494949004949490000000000000000000000000000000000000000006D6D
      6D00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004949490049494900000000000000
      0000000000000000000000000000000000004949490049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900494949004949490049494900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008686
      86009D9D9D0086868600494949000000000000000000000000006D6D6D009D9D
      9D00868686000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000868686009D9D9D0086868600494949000000
      00000000000000000000000000000000000061616100CCCCCC009D9D9D009D9D
      9D009D9D9D008686860086868600868686008686860086868600868686008686
      8600868686008686860049494900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000868686009D9D
      9D009D9D9D00868686004949490000000000000000006D6D6D00868686009D9D
      9D009D9D9D008686860000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000868686009D9D9D009D9D9D0086868600494949000000
      00000000000000000000000000000000000061616100CCCCCC009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D0086868600868686008686
      8600868686008686860049494900000000000000000000000000000000000000
      00000000000000000000000000000000000000000000868686009D9D9D009D9D
      9D00868686004949490000000000000000000000000000000000000000008686
      8600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000494949004949
      490049494900494949009D9D9D009D9D9D008686860049494900000000000000
      00000000000000000000000000000000000061616100CCCCCC00FFFFFF009D9D
      9D009D9D9D006161610061616100616161006161610061616100868686008686
      8600868686008686860049494900000000000000000000000000000000000000
      000049494900494949004949490049494900494949009D9D9D009D9D9D008686
      8600494949000000000000000000000000000000000000000000000000008686
      8600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009D9D9D00AAAAAA00AAAA
      AA00AAAAAA007979790049494900868686004949490000000000000000000000
      00006D6D6D0000000000000000000000000061616100CCCCCC009D9D9D00FFFF
      FF009D9D9D0061616100DADADA00DADADA00DADADA00616161009D9D9D008686
      86008686860086868600494949000000000000000000000000009D9D9D004949
      49009D9D9D009D9D9D009D9D9D00797979007979790049494900868686004949
      4900000000000000000000000000000000000000000000000000000000008686
      8600000000000000000000000000000000004949490049494900000000000000
      0000000000000000000000000000000000009D9D9D00CCCCCC00AAAAAA00AAAA
      AA00CCCCCC00AAAAAA0079797900494949000000000000000000000000006D6D
      6D008686860000000000000000000000000061616100CCCCCC00FFFFFF009D9D
      9D00FFFFFF00616161009D9D9D00DADADA00DADADA00616161009D9D9D009D9D
      9D0086868600868686004949490000000000000000009D9D9D00AAAAAA00AAAA
      AA00AAAAAA00AAAAAA00AAAAAA009D9D9D009D9D9D0079797900494949000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000868686009D9D9D0086868600494949000000
      0000000000000000000000000000000000009D9D9D00CCCCCC00E6E6E600CCCC
      CC00AAAAAA00CCCCCC00AAAAAA004949490000000000000000006D6D6D009D9D
      9D00868686006D6D6D006D6D6D000000000061616100CCCCCC009D9D9D00FFFF
      FF009D9D9D00616161009D9D9D009D9D9D00DADADA00616161009D9D9D009D9D
      9D0086868600868686004949490000000000000000009D9D9D00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00AAAAAA00AAAAAA009D9D9D009D9D9D00494949000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000868686009D9D9D009D9D9D0086868600494949000000
      0000000000000000000000000000000000009D9D9D00CCCCCC00FFFFFF00E6E6
      E600CCCCCC00AAAAAA00AAAAAA00494949000000000000000000000000008686
      86009D9D9D0000000000000000006D6D6D0061616100CCCCCC00FFFFFF009D9D
      9D00FFFFFF0061616100616161006161610061616100616161009D9D9D008686
      86009D9D9D008686860049494900000000009D9D9D00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00AAAAAA00AAAAAA009D9D9D00797979004949
      4900000000000000000000000000000000000000000000000000494949004949
      490049494900494949009D9D9D009D9D9D008686860049494900000000000000
      0000000000000000000000000000000000009D9D9D00AAAAAA00FFFFFF00FFFF
      FF00E6E6E600AAAAAA00AAAAAA00494949000000000000000000000000000000
      00008686860000000000000000006D6D6D0061616100CCCCCC009D9D9D00FFFF
      FF009D9D9D00FFFFFF009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D008686860049494900000000009D9D9D00CCCCCC00E6E6E600E6E6
      E600E6E6E600CCCCCC00CCCCCC00CCCCCC00AAAAAA009D9D9D009D9D9D004949
      490000000000000000000000000000000000000000009D9D9D00AAAAAA00AAAA
      AA00AAAAAA007979790049494900868686004949490000000000000000000000
      000000000000000000000000000000000000000000009D9D9D00AAAAAA00CCCC
      CC00CCCCCC00CCCCCC009D9D9D00000000000000000000000000000000000000
      00000000000000000000000000006D6D6D0061616100CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC0049494900000000009D9D9D00CCCCCC00FFFFFF00FFFF
      FF00E6E6E600E6E6E600CCCCCC00CCCCCC00CCCCCC00AAAAAA009D9D9D004949
      4900000000000000000000000000000000009D9D9D00CCCCCC00AAAAAA00AAAA
      AA00CCCCCC00AAAAAA0079797900494949000000000000000000000000000000
      0000000000006D6D6D00000000000000000000000000000000009D9D9D009D9D
      9D009D9D9D009D9D9D0000000000000000000000000086868600000000000000
      0000000000000000000000000000000000006161610061616100616161006161
      6100616161006161610061616100616161006161610061616100616161006161
      6100616161006161610049494900000000009D9D9D00AAAAAA00FFFFFF00FFFF
      FF00FFFFFF00E6E6E600E6E6E600CCCCCC00CCCCCC00AAAAAA009D9D9D004949
      4900000000000000000000000000000000009D9D9D00CCCCCC00E6E6E600CCCC
      CC00AAAAAA00CCCCCC00AAAAAA00494949000000000000000000000000000000
      000000000000868686006D6D6D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000086868600000000000000
      00006D6D6D000000000000000000000000000000000061616100CCCCCC00CCCC
      CC00B6B6B600CCCCCC00B6B6B600494949000000000000000000000000000000
      000000000000000000000000000000000000000000009D9D9D00CCCCCC00FFFF
      FF00FFFFFF00FFFFFF00E6E6E600CCCCCC00CCCCCC00AAAAAA00494949000000
      0000000000000000000000000000000000009D9D9D00CCCCCC00FFFFFF00E6E6
      E600CCCCCC00AAAAAA00AAAAAA00494949000000000000000000868686008686
      8600868686009D9D9D009D9D9D006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000086868600000000000000
      0000868686006D6D6D0000000000000000000000000000000000616161006161
      6100616161006161610061616100000000000000000000000000000000000000
      000000000000000000000000000000000000000000009D9D9D00AAAAAA00CCCC
      CC00FFFFFF00FFFFFF00E6E6E600CCCCCC00CCCCCC00AAAAAA00494949000000
      0000000000000000000000000000000000009D9D9D00AAAAAA00FFFFFF00FFFF
      FF00E6E6E600AAAAAA00AAAAAA00494949000000000000000000000000000000
      0000000000009D9D9D0086868600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000868686008686
      86009D9D9D009D9D9D006D6D6D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009D9D9D009D9D
      9D00AAAAAA00CCCCCC00CCCCCC00CCCCCC009D9D9D009D9D9D00000000000000
      000000000000000000000000000000000000000000009D9D9D00AAAAAA00CCCC
      CC00CCCCCC00CCCCCC009D9D9D00000000000000000000000000000000000000
      0000000000008686860000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009D9D9D008686860000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009D9D9D009D9D9D009D9D9D009D9D9D000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009D9D9D009D9D
      9D009D9D9D009D9D9D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000868686000000000000000000000000000000000000000000000000004949
      4900000000000000000000000000000000000000000049494900494949004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006D6D6D008686
      860049494900000000000000000000000000000000006D6D6D006D6D6D004949
      4900000000000000000000000000000000000000000000000000000000000000
      0000494949004949490049494900494949004949490049494900494949004949
      4900494949004949490049494900000000004949490049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900494949004949490049494900000000004949490049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      49004949490049494900494949000000000000000000000000006D6D6D009D9D
      9D0049494900000000000000000000000000000000006D6D6D009D9D9D004949
      4900000000000000000000000000000000000000000000000000000000000000
      000061616100CCCCCC009D9D9D009D9D9D009D9D9D009D9D9D00868686009D9D
      9D008686860086868600494949000000000061616100CCCCCC009D9D9D009D9D
      9D009D9D9D008686860086868600868686008686860086868600868686008686
      86008686860086868600494949000000000061616100CCCCCC009D9D9D009D9D
      9D009D9D9D008686860086868600868686008686860086868600868686008686
      86008686860086868600494949000000000000000000000000006D6D6D00CCCC
      CC0049494900000000000000000000000000000000006D6D6D009D9D9D004949
      4900000000000000000000000000000000000000000000000000000000000000
      000061616100CCCCCC00CCCCCC009D9D9D009D9D9D009D9D9D009D9D9D008686
      86009D9D9D0086868600494949000000000061616100CCCCCC009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D0086868600868686008686
      86008686860086868600494949000000000061616100CCCCCC009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D00616161009D9D9D0086868600868686008686
      86008686860086868600494949000000000049494900494949006D6D6D009D9D
      9D0049494900494949004949490049494900494949006D6D6D009D9D9D004949
      4900494949004949490049494900000000000000000000000000000000000000
      000061616100CCCCCC009D9D9D00CCCCCC009D9D9D009D9D9D009D9D9D009D9D
      9D008686860086868600494949000000000061616100CCCCCC00FFFFFF009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D00868686008686
      86008686860086868600494949000000000061616100CCCCCC00FFFFFF009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D00868686008686
      86008686860086868600494949000000000049494900E6E6E6006D6D6D00CCCC
      CC0049494900E6E6E600E6E6E600E6E6E600E6E6E6006D6D6D009D9D9D004949
      4900E6E6E600E6E6E60049494900000000000000000000000000000000000000
      000061616100CCCCCC00FFFFFF009D9D9D00CCCCCC009D9D9D009D9D9D009D9D
      9D009D9D9D0086868600494949000000000061616100CCCCCC009D9D9D00FFFF
      FF009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D008686
      86008686860086868600494949000000000061616100CCCCCC009D9D9D00FFFF
      FF009D9D9D009D9D9D009D9D9D00616161009D9D9D009D9D9D009D9D9D008686
      86008686860086868600494949000000000049494900FFFFFF006D6D6D009D9D
      9D0049494900FFFFFF00FFFFFF00FFFFFF00FFFFFF006D6D6D009D9D9D004949
      4900FFFFFF00E6E6E60049494900000000004949490049494900494949004949
      490061616100CCCCCC009D9D9D00FFFFFF009D9D9D00CCCCCC009D9D9D009D9D
      9D009D9D9D0086868600494949000000000061616100CCCCCC00FFFFFF009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D008686860086868600494949000000000061616100CCCCCC00FFFFFF009D9D
      9D00FFFFFF009D9D9D009D9D9D009D9D9D00616161009D9D9D009D9D9D009D9D
      9D008686860086868600494949000000000049494900FFFFFF006D6D6D00CCCC
      CC0049494900FFFFFF00FFFFFF00FFFFFF00FFFFFF006D6D6D00B6B6B6004949
      4900FFFFFF00E6E6E600494949000000000061616100CCCCCC009D9D9D009D9D
      9D0061616100CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00494949000000000061616100CCCCCC009D9D9D00FFFF
      FF009D9D9D00FFFFFF009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D008686860086868600494949000000000061616100CCCCCC009D9D9D00FFFF
      FF009D9D9D00FFFFFF009D9D9D009D9D9D009D9D9D00616161009D9D9D009D9D
      9D008686860086868600494949000000000049494900FFFFFF006D6D6D009D9D
      9D0049494900FFFFFF00FFFFFF0049494900FFFFFF0049494900E6E6E6004949
      4900FFFFFF0049494900494949000000000061616100CCCCCC00CCCCCC009D9D
      9D0061616100CCCCCC00CCCCCC00CCCCCC00B6B6B60061616100616161006161
      61006161610061616100000000000000000061616100CCCCCC00FFFFFF009D9D
      9D00FFFFFF009D9D9D00FFFFFF009D9D9D009D9D9D009D9D9D009D9D9D008686
      86009D9D9D0086868600494949000000000061616100CCCCCC00FFFFFF009D9D
      9D00FFFFFF0061616100FFFFFF009D9D9D009D9D9D00616161009D9D9D008686
      86009D9D9D00868686004949490000000000494949006D6D6D009D9D9D00CCCC
      CC006D6D6D004949490049494900E6E6E600494949009D9D9D00FFFFFF009D9D
      9D004949490049494900494949000000000061616100CCCCCC009D9D9D00CCCC
      CC009D9D9D006161610061616100616161006161610086868600494949000000
      00000000000000000000000000000000000061616100CCCCCC009D9D9D00FFFF
      FF009D9D9D00FFFFFF009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D0086868600494949000000000061616100CCCCCC009D9D9D00FFFF
      FF009D9D9D00FFFFFF006161610061616100616161009D9D9D009D9D9D009D9D
      9D009D9D9D008686860049494900000000006D6D6D009D9D9D00CCCCCC006D6D
      6D00CCCCCC006D6D6D0049494900FFFFFF009D9D9D00FFFFFF00FFFFFF00E6E6
      E60049494900E6E6E600494949000000000061616100CCCCCC00FFFFFF009D9D
      9D00CCCCCC009D9D9D009D9D9D009D9D9D008686860086868600494949000000
      00000000000000000000000000000000000061616100CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00494949000000000061616100CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC0049494900000000006D6D6D00CCCCCC0049494900FFFF
      FF006D6D6D00CCCCCC00494949009D9D9D00FFFFFF009D9D9D009D9D9D009D9D
      9D00FFFFFF00E6E6E600494949000000000061616100CCCCCC009D9D9D00FFFF
      FF009D9D9D00CCCCCC009D9D9D009D9D9D009D9D9D0086868600494949000000
      0000000000000000000000000000000000006161610061616100616161006161
      6100616161006161610061616100616161006161610061616100616161006161
      6100616161006161610049494900000000006161610061616100616161006161
      6100616161006161610061616100616161006161610061616100616161006161
      6100616161006161610049494900000000006D6D6D00CCCCCC0049494900FFFF
      FF006D6D6D009D9D9D0049494900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00E6E6E600494949000000000061616100CCCCCC00CCCCCC00CCCC
      CC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00494949000000
      0000000000000000000000000000000000000000000061616100CCCCCC00CCCC
      CC00B6B6B600CCCCCC00B6B6B600494949000000000000000000000000000000
      0000000000000000000000000000000000000000000061616100CCCCCC00CCCC
      CC00B6B6B600CCCCCC00B6B6B600494949000000000000000000000000000000
      0000000000000000000000000000000000009D9D9D006D6D6D00CCCCCC004949
      4900CCCCCC00494949006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D
      6D006D6D6D006D6D6D00494949000000000061616100CCCCCC00CCCCCC00CCCC
      CC00B6B6B6006161610061616100616161006161610061616100000000000000
      0000000000000000000000000000000000000000000000000000616161006161
      6100616161006161610061616100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000616161006161
      6100616161006161610061616100000000000000000000000000000000000000
      0000000000000000000000000000000000009D9D9D00AAAAAA006D6D6D00AAAA
      AA006D6D6D00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAA
      AA00AAAAAA00AAAAAA0049494900000000000000000061616100616161006161
      6100616161000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D0049494900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004949
      4900494949000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900494949000000000000000000000000000000000000000000000000000000
      0000494949004949490049494900494949004949490049494900868686009D9D
      9D00868686004949490049494900494949000000000000000000000000000000
      0000000000000000000049494900494949004949490049494900494949004949
      4900494949004949490049494900000000000000000000000000000000000000
      0000000000000000000000000000494949004949490049494900494949004949
      4900494949004949490049494900494949000000000049494900FFFFFF00FFFF
      FF00FFFFFF00E6E6E600E6E6E600E6E6E600E6E6E600AAAAAA00AAAAAA004949
      49006D6D6D004949490000000000000000000000000000000000000000000000
      00009D9D9D00E6E6E600E6E6E600E6E6E600E6E6E600868686009D9D9D009D9D
      9D008686860049494900E6E6E600494949000000000000000000000000000000
      000000000000000000009D9D9D00E6E6E600E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E60049494900000000000000000049494900494949004949
      49004949490049494900494949009D9D9D00E6E6E600E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E600E6E6E600494949004949490049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900494949006D6D6D0049494900000000000000000000000000000000000000
      00009D9D9D00FFFFFF00CCCCCC00FFFFFF00868686009D9D9D009D9D9D008686
      860049494900FFFFFF00E6E6E600494949000000000000000000000000000000
      000000000000000000009D9D9D00CCCCCC009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D00E6E6E60049494900000000006161610086868600868686008686
      86008686860086868600868686009D9D9D00FFFFFF009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D00E6E6E600494949009D9D9D00FFFFFF00FFFFFF00E6E6
      E600E6E6E600E6E6E600E6E6E6009D9D9D009D9D9D009D9D9D00E6E6E600E6E6
      E600494949004949490049494900000000000000000000000000000000000000
      00009D9D9D00CCCCCC00FFFFFF00868686009D9D9D009D9D9D00868686004949
      4900FFFFFF00CCCCCC00E6E6E600494949004949490049494900494949004949
      490049494900494949009D9D9D00FFFFFF00CCCCCC00FFFFFF00CCCCCC00FFFF
      FF00CCCCCC00E6E6E600494949000000000061616100B6B6B600B6B6B6008686
      8600B6B6B60086868600868686009D9D9D00CCCCCC00FFFFFF00CCCCCC00FFFF
      FF00CCCCCC00E6E6E600E6E6E600494949009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00E6E6E600E6E6E600E6E6E6006D6D6D006D6D6D006D6D6D00E6E6E600E6E6
      E600494949009D9D9D0049494900000000000000000000000000494949004949
      49004949490049494900494949009D9D9D00868686008686860049494900FFFF
      FF00CCCCCC00FFFFFF00E6E6E600494949009D9D9D00E6E6E600E6E6E600E6E6
      E600E6E6E600E6E6E6009D9D9D00CCCCCC009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D00E6E6E600494949000000000061616100FFFFFF00B6B6B600B6B6
      B600B6B6B600B6B6B600868686009D9D9D00FFFFFF009D9D9D009D9D9D00FFFF
      FF00797979004949490049494900494949009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D00494949009D9D9D009D9D9D00494949000000000049494900AAAAAA00CCCC
      CC00AAAAAA00CCCCCC0049494900868686008686860049494900FFFFFF00CCCC
      CC00FFFFFF00CCCCCC00E6E6E600494949009D9D9D00FFFFFF006D6D6D006D6D
      6D006D6D6D006D6D6D009D9D9D00FFFFFF00CCCCCC00FFFFFF00CCCCCC00FFFF
      FF00E6E6E600E6E6E600494949000000000061616100B6B6B600FFFFFF00B6B6
      B600B6B6B60086868600B6B6B6009D9D9D00FFFFFF00CCCCCC00FFFFFF00CCCC
      CC009D9D9D00FFFFFF0049494900000000009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00E6E6E600E6E6E600E6E6E600E6E6E600E6E6E6004949
      49009D9D9D00494949009D9D9D00494949009D9D9D00AAAAAA00CCCCCC00CCCC
      CC00AAAAAA00CCCCCC00797979004949490049494900FFFFFF00CCCCCC00FFFF
      FF00CCCCCC00FFFFFF00E6E6E600494949009D9D9D00CCCCCC00FFFFFF00CCCC
      CC00FFFFFF00CCCCCC009D9D9D00FFFFFF00AAAAAA00AAAAAA00FFFFFF004949
      49004949490049494900494949000000000061616100FFFFFF00B6B6B600FFFF
      FF00B6B6B600B6B6B600B6B6B6009D9D9D00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009D9D9D00494949000000000000000000000000009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D00494949009D9D9D0049494900494949009D9D9D00CCCCCC00CCCCCC00CCCC
      CC00AAAAAA00E6E6E600CCCCCC0049494900AAAAAA00CCCCCC00FFFFFF00CCCC
      CC00FFFFFF00CCCCCC00E6E6E600494949009D9D9D00FFFFFF006D6D6D006D6D
      6D006D6D6D006D6D6D009D9D9D00FFFFFF00FFFFFF00FFFFFF00CCCCCC009D9D
      9D00FFFFFF0049494900000000000000000061616100FFFFFF00FFFFFF00B6B6
      B600FFFFFF00B6B6B600B6B6B6009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D0049494900000000000000000000000000000000009D9D9D00E6E6
      E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004949
      49009D9D9D00494949009D9D9D00494949009D9D9D00CCCCCC00CCCCCC00CCCC
      CC00AAAAAA00FFFFFF00CCCCCC0049494900AAAAAA00FFFFFF00CCCCCC00FFFF
      FF00CCCCCC00FFFFFF00E6E6E600494949009D9D9D00CCCCCC00FFFFFF00CCCC
      CC00FFFFFF00CCCCCC009D9D9D00FFFFFF00FFFFFF00FFFFFF00FFFFFF009D9D
      9D004949490000000000000000000000000061616100FFFFFF00FFFFFF00FFFF
      FF00B6B6B600FFFFFF00B6B6B600B6B6B60086868600B6B6B60086868600B6B6
      B600868686004949490000000000000000000000000000000000000000009D9D
      9D00FFFFFF00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00FFFFFF004949
      4900494949004949490049494900000000009D9D9D00CCCCCC00CCCCCC00CCCC
      CC00AAAAAA00FFFFFF00CCCCCC0049494900AAAAAA00CCCCCC00FFFFFF00CCCC
      CC00FFFFFF00CCCCCC00E6E6E600494949009D9D9D00FFFFFF006D6D6D006D6D
      6D00FFFFFF00494949009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D000000000000000000000000000000000061616100FFFFFF00FFFFFF004949
      4900494949004949490049494900494949004949490049494900494949008686
      8600868686004949490000000000000000000000000000000000000000009D9D
      9D00E6E6E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6E6
      E600494949000000000000000000000000009D9D9D00AAAAAA00CCCCCC00CCCC
      CC00AAAAAA00CCCCCC00CCCCCC0049494900FFFFFF00FFFFFF00CCCCCC00FFFF
      FF00CCCCCC00E6E6E600E6E6E600494949009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00CCCCCC009D9D9D00FFFFFF00494949000000000000000000000000000000
      00000000000000000000000000000000000061616100FFFFFF00FFFFFF008686
      8600CCCCCC009D9D9D009D9D9D009D9D9D00868686006D6D6D00494949008686
      8600868686004949490000000000000000000000000000000000000000000000
      00009D9D9D00FFFFFF00AAAAAA00AAAAAA00AAAAAA00AAAAAA00AAAAAA00FFFF
      FF0049494900000000000000000000000000000000009D9D9D00AAAAAA00CCCC
      CC00AAAAAA00CCCCCC0049494900E6E6E600FFFFFF00FFFFFF00FFFFFF00CCCC
      CC00494949004949490049494900494949009D9D9D00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF009D9D9D0049494900000000000000000000000000000000000000
      00000000000000000000000000000000000061616100FFFFFF00FFFFFF00FFFF
      FF0086868600CCCCCC006161610061616100868686004949490086868600B6B6
      B600868686004949490000000000000000000000000000000000000000000000
      00009D9D9D00E6E6E600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00E6E6E60049494900000000000000000000000000000000009D9D9D009D9D
      9D009D9D9D009D9D9D00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009D9D9D00FFFFFF0049494900000000009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000061616100616161006161
      61006161610086868600FFFFFF00CCCCCC004949490061616100616161006161
      6100616161000000000000000000000000000000000000000000000000000000
      0000000000009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D009D9D9D0000000000000000000000000000000000000000000000
      00009D9D9D00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF009D9D9D004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008686860086868600868686006D6D6D0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D009D9D
      9D009D9D9D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004949490049494900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004949490049494900494949004949
      4900494949004949490049494900494949004949490049494900494949000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004949490049494900494949004949490049494900000000000000
      0000868686009D9D9D0086868600494949000000000000000000494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900494949004949490049494900000000000000000049494900494949004949
      4900494949004949490049494900494949004949490049494900494949004949
      4900000000000000000000000000000000006161610061616100868686008686
      86006D6D6D00868686006D6D6D00868686006D6D6D00868686006D6D6D004949
      4900000000000000000000000000000000000000000000000000000000004949
      4900494949006D6D6D009D9D9D006D6D6D009D9D9D006D6D6D00494949008686
      8600B6B6B6009D9D9D0086868600494949000000000061616100868686008686
      8600494949004949490049494900494949004949490049494900AAAAAA00AAAA
      AA00494949006161610049494900000000000000000049494900868686008686
      8600868686006D6D6D00868686006D6D6D00868686006D6D6D00868686004949
      49000000000000000000000000000000000061616100CCCCCC00616161008686
      86008686860086868600868686006D6D6D00868686006D6D6D00868686006D6D
      6D004949490000000000000000000000000000000000000000006D6D6D006161
      6100616161006D6D6D006D6D6D0049494900494949004949490049494900B6B6
      B6009D9D9D00868686004949490000000000000000006161610086868600B6B6
      B6006D6D6D006D6D6D0049494900494949004949490049494900E6E6E600AAAA
      AA00494949008686860049494900000000000000000049494900868686008686
      860086868600868686006D6D6D00868686006D6D6D00868686006D6D6D004949
      49000000000000000000000000000000000061616100CCCCCC009D9D9D006161
      61008686860086868600868686008686860086868600868686006D6D6D008686
      86006D6D6D00494949000000000000000000000000006D6D6D00929292009292
      92006D6D6D006D6D6D006D6D6D009D9D9D00AAAAAA00AAAAAA00797979004949
      4900868686004949490000000000000000000000000061616100B6B6B600B6B6
      B6006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D0049494900FFFFFF00E6E6
      E600494949008686860049494900000000000000000049494900868686008686
      860086868600868686008686860086868600868686006D6D6D00868686004949
      49000000000000000000000000000000000061616100CCCCCC00FFFFFF009D9D
      9D00616161008686860086868600868686008686860086868600868686006D6D
      6D00868686006D6D6D004949490000000000000000006D6D6D00AAAAAA00AAAA
      AA00929292006D6D6D009D9D9D00CCCCCC00AAAAAA00AAAAAA00AAAAAA007979
      7900494949004949490000000000000000000000000061616100B6B6B600B6B6
      B6006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D006D6D
      6D00494949008686860049494900000000000000000049494900868686008686
      86008686860086868600868686008686860086868600868686006D6D6D004949
      49000000000000000000000000000000000061616100CCCCCC009D9D9D00FFFF
      FF009D9D9D006161610061616100616161006161610061616100616161006161
      6100616161006161610061616100494949006D6D6D00CCCCCC00AAAAAA009292
      92006D6D6D006D6D6D00CCCCCC00E6E6E600CCCCCC00CCCCCC00AAAAAA00AAAA
      AA00494949006D6D6D0049494900000000000000000061616100FFFFFF00B6B6
      B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6B600B6B6
      B600B6B6B6008686860049494900000000000000000049494900868686008686
      8600868686008686860086868600868686008686860086868600868686004949
      49000000000000000000000000000000000061616100CCCCCC00FFFFFF009D9D
      9D00FFFFFF009D9D9D009D9D9D009D9D9D009D9D9D009D9D9D00494949000000
      0000000000000000000000000000000000006D6D6D00CCCCCC00AAAAAA006D6D
      6D009D9D9D006D6D6D00CCCCCC00FFFFFF00E6E6E600CCCCCC00AAAAAA00AAAA
      AA00494949009D9D9D0049494900000000000000000061616100FFFFFF00B6B6
      B600616161006161610061616100616161006161610061616100616161006161
      6100B6B6B6008686860049494900000000000000000049494900868686008686
      8600868686008686860086868600868686008686860086868600868686004949
      49000000000000000000000000000000000061616100CCCCCC009D9D9D00FFFF
      FF00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00494949000000
      0000000000000000000000000000000000006D6D6D006D6D6D006D6D6D00AAAA
      AA00AAAAAA006D6D6D009D9D9D00FFFFFF00FFFFFF00E6E6E600CCCCCC009D9D
      9D0049494900AAAAAA0049494900000000000000000061616100FFFFFF008686
      8600FFFFFF00FFFFFF00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCCCC00CCCC
      CC0061616100B6B6B60049494900000000000000000049494900494949004949
      4900494949008686860086868600868686008686860086868600868686004949
      49000000000000000000000000000000000061616100FFFFFF00CCCCCC00B6B6
      B600616161006161610061616100616161006161610061616100616161000000
      000000000000000000000000000000000000AAAAAA00E6E6E600AAAAAA00AAAA
      AA00AAAAAA009D9D9D006D6D6D009D9D9D00CCCCCC00CCCCCC009D9D9D004949
      4900AAAAAA00AAAAAA0049494900000000000000000061616100FFFFFF008686
      8600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CCCCCC00CCCC
      CC0061616100B6B6B600494949000000000000000000494949009D9D9D00FFFF
      FF009D9D9D004949490049494900494949004949490049494900494949004949
      4900000000000000000000000000000000000000000061616100616161006161
      6100000000000000000000000000000000000000000000000000000000000000
      000055555500555555005555550000000000AAAAAA00E6E6E6009D9D9D006D6D
      6D006D6D6D00AAAAAA009D9D9D006D6D6D006D6D6D006D6D6D006D6D6D009D9D
      9D00AAAAAA006D6D6D0049494900000000000000000061616100FFFFFF008686
      8600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CCCC
      CC0061616100B6B6B60049494900000000000000000000000000494949004949
      4900494949000000000000000000000000000000000000000000000000000000
      0000000000000000000049494900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006D6D6D00555555000000000000000000AAAAAA006D6D6D009292
      92006D6D6D00AAAAAA009D9D9D009D9D9D009D9D9D00AAAAAA009D9D9D00AAAA
      AA009D9D9D004949490000000000000000000000000061616100FFFFFF008686
      8600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CCCC
      CC0061616100B6B6B60049494900000000000000000000000000000000000000
      0000000000000000000000000000000000004949490049494900494949000000
      0000000000000000000049494900000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6D0000000000000000000000
      00006D6D6D000000000055555500000000000000000061616100CCCCCC00AAAA
      AA00929292006D6D6D00AAAAAA009D9D9D009D9D9D009D9D9D00AAAAAA009D9D
      9D00AAAAAA004949490000000000000000000000000061616100FFFFFF008686
      8600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CCCC
      CC00616161006161610049494900000000000000000000000000000000000000
      0000000000000000000000000000000000004949490049494900000000000000
      0000000000004949490049494900000000000000000000000000000000000000
      000000000000000000000000000000000000000000006D6D6D006D6D6D006D6D
      6D0000000000000000000000000000000000000000000000000061616100CCCC
      CC00AAAAAA00929292006D6D6D006D6D6D006D6D6D00AAAAAA006D6D6D00AAAA
      AA00494949000000000000000000000000000000000061616100FFFFFF008686
      8600868686008686860086868600868686008686860086868600868686008686
      860061616100E6E6E60049494900000000000000000000000000000000000000
      0000000000000000000000000000000000004949490000000000494949004949
      4900494949004949490000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006161
      610061616100AAAAAA00AAAAAA00929292006D6D6D006D6D6D00AAAAAA00AAAA
      AA00000000000000000000000000000000000000000061616100616161008686
      8600868686008686860086868600868686008686860086868600868686008686
      8600616161006161610049494900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000061616100616161006161610061616100AAAAAA00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000B00000000100010000000000800500000000000000000000
      000000000000000000000000FFFFFF00FFFF800300000000FF80800300000000
      FF80800300000000DF80800300000000CF808003000000008400800300000000
      4C008003000000005C008003000000007C018003000000007C07800300000000
      B407800300000000F807800300000000F00F800300000000F8FF800700000000
      F57F800F00000000FFFF801F00000000FFFF8001FFFFFC00DFFB80010001F800
      8FFF80010001E00087F780010001C000C7EF800100018000E3CF800100018000
      F19F800100010000F83F800100010000FC7F800100010000F83F800100010000
      F19F800100010001C3CF80010001800387E7800180FF80038FFB8003C1FFC007
      FFFF8007FFFFE00FFFFF800FFFFFF83FFC1FFFFFF000FFFFF007C007F0000001
      E003C007F0000001C001C007F0000001C001C007000000018000C00700000001
      8000C007000000018000C007000000018000C007000000018000C007001F0001
      C001C007003B0001C001C00F007B0001E003C01F00600000F007C03F007BFFF0
      FC1FFFFF007BFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FFFFFFFFFFFFFFFC
      FFFFFFFFFFFFFFFAFFFFFFFFFFFFFFF6FFFFFFFFFFFFFFFFFDEFEF7FDEF7000F
      F9CFE73FCE77000FF18FE31FC637000FE10FE10FC217000FF18FE31FC637000F
      F9CFE73FCE77000FFDEFEF7FDEF7000FFFFFFFFFFFFF000FFFFFFFFFFFFF000F
      FFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFCFFFFFFFFFFFFFFFC3FFF18FF00FFFFFC0FFF18FF00FDEF7
      C03FF18FF00FDCE7C00FF18FF00FD8C7C007F18FF00FD087C00FF18FF00FD8C7
      C03FF18FF00FDCE7C0FFF18FF00FDEF7C3FFF18FF00FFFFFCFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7FFC008001F83FF83FF8008001
      F3DFE01FE0008001E7FF800FC0008001E7FF000780008001E7E7000380008001
      00C30001000080018181000000008001C300000000008001E7E7800100008001
      FFE7C00100018001FFE7E00080038001FBCFF00180038001FC1FF807C0078003
      FFFFFC1FE00F8007FFFFFE7FF83F800FFFFFC000FFFFFFFF00018000FFFFFFFF
      3FE10000FFFFFFFF00210000FDFFFFBF00218000F9FFFF9F00218000F1FFFF8F
      00218000E003C00700218000C003C00300218000C003C00300018000E003C007
      00018000F1FFFF8F00018000F9FFFF9F00018000FDFFFFBF00018000FFFFFFFF
      00018000FFFFFFFF00018001FFFFFFFFFFFFFFF3EFFFFF3F0001FFE1C7FFFE1F
      0001FFC183FFFC1F0001FF83EFFFC03F0001F007EFFF80770001C00FEF3F00E7
      0001801FFE1F00C10001801FFC1F00E60001000FC03F00F60001000F807F81FE
      0001000F00FBC3BF0001000F00F9FFB780FF801F00C0FFB3C1FF801F00F9FFC1
      FFFFC03F81FBFFF3FFFFF0FFC3FFFFF7EF8FFFFFFFFFFFFFC78FF00100010001
      C78FF00100010001C78FF001000100010001F001000100010001F00100010001
      0001000100010001000100010001000100010003000100010001001F00010001
      0001001F000100010001001F000100010001001F80FF80FF0001003FC1FFC1FF
      000187FFFFFFFFFF0001FFFFFFFFFFFFFFFFFFE7FFFFFFFFC007F000FC01FE00
      8003F000FC0180000001F000FC0100000001F000000100000001C00000010000
      000080000001000100000000000100038000000000030003C000000000070003
      E0010000000F0003E007000000FF0003F007800001FF0003F003C00103FF8007
      F803F003FFFFF87FFFFFF007FFFFFFFFFFFFFFF9FFFFFFFF001FF830C001800F
      000FE0008001800F0007C0018001800F000380038001800F000180038001800F
      000000018001800F001F00018001800F001F00018001800F001F00018001800F
      8FF100018001C7FDFFF980038001FF1DFF7580038001FF39FF8FC0078001FF43
      FFFFE00F8001FFFFFFFFF83FFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
end
