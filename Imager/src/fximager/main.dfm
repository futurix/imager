object frmMain: TfrmMain
  Left = 190
  Top = 79
  Width = 750
  Height = 550
  ActiveControl = img
  Caption = 'FuturixImager'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  Menu = mnuMain
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShortCut = FormShortCut
  PixelsPerInch = 96
  TextHeight = 13
  object sbxMain: TScrollBox
    Left = 0
    Top = 28
    Width = 742
    Height = 457
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
      Height = 453
      Cursor = crDefault
      Background = clAppWorkSpace
      ParentCtl3D = False
      BorderStyle = bsNone
      LegacyBitmap = False
      DoubleBuffer = False
      MouseInteract = [miScroll]
      OnProgress = imgProgress
      ImageEnVersion = '3.0.0'
      OnMouseWheel = imgMouseWheel
      Align = alClient
      PopupMenu = popMain
      TabOrder = 0
      TabStop = True
      OnDblClick = imgDblClick
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
        Bevel = pbNone
        Width = 55
      end
      item
        Alignment = taCenter
        Bevel = pbNone
        Width = 80
      end
      item
        Alignment = taCenter
        Bevel = pbNone
        Width = 50
      end
      item
        Bevel = pbNone
        Width = 50
      end>
    PopupMenu = popBars
  end
  object tbrMain: TCoolBar
    Left = 0
    Top = 0
    Width = 742
    Height = 28
    AutoSize = True
    BandBorderStyle = bsNone
    BandMaximize = bmNone
    Bands = <
      item
        Control = itbMain
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 26
        Width = 742
      end>
    EdgeBorders = [ebTop]
    FixedOrder = True
    ShowText = False
    object itbMain: TToolBar
      Left = 0
      Top = 0
      Width = 738
      Height = 26
      AutoSize = True
      BorderWidth = 1
      Caption = 'Main Toolbar'
      DisabledImages = imlDis
      EdgeBorders = []
      Flat = True
      HideClippedButtons = True
      Images = imlStd
      PopupMenu = popBars
      TabOrder = 0
      Transparent = True
      Wrapable = False
      object tbnOpen: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = 'Open'
        DropdownMenu = popMRU
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        Style = tbsDropDown
        OnClick = miOpenClick
      end
      object tbnSave: TToolButton
        Left = 36
        Top = 0
        AutoSize = True
        Caption = 'Save'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = miSaveAsClick
      end
      object tbnLast: TToolButton
        Left = 59
        Top = 0
        AutoSize = True
        Caption = 'Last'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        OnClick = miLoadLastClick
      end
      object tbnClose: TToolButton
        Left = 82
        Top = 0
        AutoSize = True
        Caption = 'Close'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = miCloseClick
      end
      object tbnPrint: TToolButton
        Left = 105
        Top = 0
        AutoSize = True
        Caption = 'Print'
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        OnClick = miPrintPreviewClick
      end
      object tbnCopy: TToolButton
        Left = 128
        Top = 0
        AutoSize = True
        Caption = 'Copy'
        ImageIndex = 5
        ParentShowHint = False
        ShowHint = True
        OnClick = miCopyClick
      end
      object tbnPaste: TToolButton
        Left = 151
        Top = 0
        AutoSize = True
        Caption = 'Paste'
        Enabled = False
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        OnClick = miPasteClick
      end
      object tbnEditor: TToolButton
        Left = 174
        Top = 0
        Caption = 'Editor'
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        OnClick = miEditorClick
      end
      object tbnMultiPrev: TToolButton
        Left = 197
        Top = 0
        AutoSize = True
        Caption = 'Previous'
        Enabled = False
        ImageIndex = 17
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnMultiPrevClick
      end
      object tbnMultiNext: TToolButton
        Left = 220
        Top = 0
        AutoSize = True
        Caption = 'Next'
        Enabled = False
        ImageIndex = 16
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnMultiNextClick
      end
      object tbnZoomIn: TToolButton
        Left = 243
        Top = 0
        AutoSize = True
        Caption = 'Zoom In'
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        OnClick = miZoomInClick
      end
      object tbnZoomOut: TToolButton
        Left = 266
        Top = 0
        AutoSize = True
        Caption = 'Zoom Out'
        ImageIndex = 9
        ParentShowHint = False
        ShowHint = True
        OnClick = miZoomOutClick
      end
      object tbnRotate: TToolButton
        Left = 289
        Top = 0
        AutoSize = True
        Caption = 'Rotate'
        ImageIndex = 20
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnRotateClick
      end
      object tbnZoomMisc: TToolButton
        Left = 312
        Top = 0
        AutoSize = True
        Caption = 'Zoom'
        DropdownMenu = popZoom
        ImageIndex = 10
        ParentShowHint = False
        ShowHint = True
        Style = tbsDropDown
      end
      object tbnDisp: TToolButton
        Left = 348
        Top = 0
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
        Left = 384
        Top = 0
        AutoSize = True
        Caption = 'Full Screen'
        ImageIndex = 11
        ParentShowHint = False
        ShowHint = True
        OnClick = miFullScreenClick
      end
      object tbnInfo: TToolButton
        Left = 407
        Top = 0
        AutoSize = True
        Caption = 'Info'
        ImageIndex = 12
        ParentShowHint = False
        ShowHint = True
        OnClick = miInfoClick
      end
      object tbnGoBack: TToolButton
        Left = 430
        Top = 0
        AutoSize = True
        Caption = 'Back'
        ImageIndex = 13
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoBackClick
      end
      object tbnGoForward: TToolButton
        Left = 453
        Top = 0
        AutoSize = True
        Caption = 'Forward'
        ImageIndex = 15
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoForwardClick
      end
      object tbnUndo: TToolButton
        Left = 476
        Top = 0
        Hint = 'Undo|Undo last editing action'
        AutoSize = True
        Caption = 'Undo'
        ImageIndex = 18
        ParentShowHint = False
        ShowHint = True
        OnClick = miUndoClick
      end
      object tbnGoRandom: TToolButton
        Left = 499
        Top = 0
        Hint = 'Random|Go to random file in current folder'
        AutoSize = True
        Caption = 'Random'
        ImageIndex = 14
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoRandomClick
      end
      object tbnZoomFit: TToolButton
        Left = 522
        Top = 0
        Hint = 'Fit|Zoom image to fit the window size'
        AutoSize = True
        Caption = 'Fit'
        ImageIndex = 24
        ParentShowHint = False
        ShowHint = True
        OnClick = miZmFitClick
      end
      object tbnShow: TToolButton
        Left = 545
        Top = 0
        AutoSize = True
        Caption = 'Slide Show'
        ImageIndex = 48
        ParentShowHint = False
        ShowHint = True
        OnClick = miStartShowClick
      end
      object tbnRScan: TToolButton
        Left = 568
        Top = 0
        AutoSize = True
        Caption = 'Scan'
        Enabled = False
        ImageIndex = 53
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnRScanClick
      end
      object tbnRMail: TToolButton
        Left = 591
        Top = 0
        AutoSize = True
        Caption = 'E-mail'
        Enabled = False
        ImageIndex = 54
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnRMailClick
      end
      object tbnRCapture: TToolButton
        Left = 614
        Top = 0
        AutoSize = True
        Caption = 'Capture'
        Enabled = False
        ImageIndex = 55
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnRCaptureClick
      end
      object tbnRJPEG: TToolButton
        Left = 637
        Top = 0
        AutoSize = True
        Caption = 'JPEG Transf.'
        Enabled = False
        ImageIndex = 56
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnRJPEGClick
      end
      object tbnRHEX: TToolButton
        Left = 660
        Top = 0
        AutoSize = True
        Caption = 'HEX'
        Enabled = False
        ImageIndex = 57
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnRHEXClick
      end
      object tbnGoToPage: TToolButton
        Left = 683
        Top = 0
        AutoSize = True
        Caption = 'Page'
        Enabled = False
        ImageIndex = 59
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnGoToPageClick
      end
      object tbnFDelete: TToolButton
        Left = 706
        Top = 0
        AutoSize = True
        Caption = 'Delete File'
        ImageIndex = 38
        ParentShowHint = False
        ShowHint = True
        OnClick = miFDeleteClick
      end
      object tbnFCopy: TToolButton
        Left = 729
        Top = 0
        AutoSize = True
        Caption = 'Copy File'
        ImageIndex = 39
        ParentShowHint = False
        ShowHint = True
        OnClick = miFCopyClick
      end
      object tbnFMove: TToolButton
        Left = 752
        Top = 0
        AutoSize = True
        Caption = 'Move File'
        ImageIndex = 40
        ParentShowHint = False
        ShowHint = True
        OnClick = miFMoveClick
      end
      object tbnFRename: TToolButton
        Left = 775
        Top = 0
        AutoSize = True
        Caption = 'Rename File'
        ImageIndex = 41
        ParentShowHint = False
        ShowHint = True
        OnClick = miFRenameClick
      end
      object tbnZoom100: TToolButton
        Left = 798
        Top = 0
        AutoSize = True
        Caption = '100%'
        ImageIndex = 42
        ParentShowHint = False
        ShowHint = True
        OnClick = miZM100Click
      end
      object tbnZoomWidth: TToolButton
        Left = 821
        Top = 0
        AutoSize = True
        Caption = 'Fit To Width'
        ImageIndex = 43
        ParentShowHint = False
        ShowHint = True
        OnClick = miZmWidthClick
      end
      object tbnZoomHeight: TToolButton
        Left = 844
        Top = 0
        AutoSize = True
        Caption = 'Fit To Height'
        ImageIndex = 44
        ParentShowHint = False
        ShowHint = True
        OnClick = miZmHeightClick
      end
      object tbnRotateCCW: TToolButton
        Left = 867
        Top = 0
        AutoSize = True
        Caption = 'Rotate CCW'
        ImageIndex = 45
        ParentShowHint = False
        ShowHint = True
        OnClick = miRotateViewCCWClick
      end
      object tbnGoFirst: TToolButton
        Left = 890
        Top = 0
        AutoSize = True
        Caption = 'First'
        ImageIndex = 46
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoFirstClick
      end
      object tbnGoLast: TToolButton
        Left = 913
        Top = 0
        AutoSize = True
        Caption = 'Last'
        ImageIndex = 47
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoLastClick
      end
      object tbnOptions: TToolButton
        Left = 936
        Top = 0
        AutoSize = True
        Caption = 'Options'
        ImageIndex = 49
        ParentShowHint = False
        ShowHint = True
        OnClick = miOptionsClick
      end
      object tbnHelp: TToolButton
        Left = 959
        Top = 0
        AutoSize = True
        Caption = 'Help'
        ImageIndex = 50
        ParentShowHint = False
        ShowHint = True
      end
      object tbnOnline: TToolButton
        Left = 982
        Top = 0
        AutoSize = True
        Caption = 'WWW'
        ImageIndex = 51
        ParentShowHint = False
        ShowHint = True
        OnClick = miWebSiteClick
      end
      object tbnAbout: TToolButton
        Left = 1005
        Top = 0
        AutoSize = True
        Caption = 'About'
        ImageIndex = 52
        ParentShowHint = False
        ShowHint = True
        OnClick = miAboutClick
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
        ShortCut = 16463
        OnClick = miOpenClick
      end
      object mRecent: TMenuItem
        Caption = 'Open Recent'
        object NRecent: TMenuItem
          Caption = '-'
        end
      end
      object miLoadLast: TMenuItem
        Caption = 'Load Last'
        ShortCut = 118
        OnClick = miLoadLastClick
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object miSaveAs: TMenuItem
        Caption = 'Save As...'
        ShortCut = 16467
        OnClick = miSaveAsClick
      end
      object miClose: TMenuItem
        Caption = 'Close'
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
        ShortCut = 16457
        OnClick = miInfoClick
      end
      object mFileMan: TMenuItem
        Caption = 'File Management'
        object miFDelete: TMenuItem
          Caption = 'Delete File'
          ShortCut = 46
          OnClick = miFDeleteClick
        end
        object N17: TMenuItem
          Caption = '-'
        end
        object miFCopy: TMenuItem
          Caption = 'Copy File'
          ShortCut = 16468
          OnClick = miFCopyClick
        end
        object miFMove: TMenuItem
          Caption = 'Move File'
          ShortCut = 16461
          OnClick = miFMoveClick
        end
        object miFRename: TMenuItem
          Caption = 'Rename File'
          ShortCut = 16473
          OnClick = miFRenameClick
        end
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object miPrintPreview: TMenuItem
        Caption = 'Print Preview...'
        ShortCut = 16464
        OnClick = miPrintPreviewClick
      end
      object N20: TMenuItem
        Caption = '-'
      end
      object miExit: TMenuItem
        Caption = 'Exit'
        ShortCut = 27
        OnClick = miExitClick
      end
    end
    object mEdit: TMenuItem
      Caption = 'Edit'
      object miUndo: TMenuItem
        Caption = 'Undo'
        ShortCut = 16474
        OnClick = miUndoClick
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object miCopy: TMenuItem
        Caption = 'Copy'
        ShortCut = 16451
        OnClick = miCopyClick
      end
      object miPaste: TMenuItem
        Caption = 'Paste'
        ShortCut = 16470
        OnClick = miPasteClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object miEditor: TMenuItem
        Caption = 'Edit Image...'
        ShortCut = 113
        OnClick = miEditorClick
      end
    end
    object mView: TMenuItem
      Caption = 'View'
      object mToolbars: TMenuItem
        Caption = 'Toolbars'
        object miToolbar: TMenuItem
          Caption = 'Main Toolbar'
          OnClick = miToolbarClick
        end
        object miStatusBar: TMenuItem
          Caption = 'Status Bar'
          OnClick = miStatusBarClick
        end
        object N5: TMenuItem
          Caption = '-'
        end
        object miCustTB: TMenuItem
          Caption = 'Customize...'
          OnClick = miCustTBClick
        end
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object mDisplay: TMenuItem
        Caption = 'Display Options'
        object miDSNormal: TMenuItem
          Caption = 'Normal Display'
          RadioItem = True
          OnClick = miDSNormalClick
        end
        object miDSFitBig: TMenuItem
          Caption = 'Fit Large Images'
          RadioItem = True
          OnClick = miDSFitBigClick
        end
        object miDSFitAll: TMenuItem
          Caption = 'Fit All Images'
          RadioItem = True
          OnClick = miDSFitAllClick
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
        object miZoomIn: TMenuItem
          Caption = 'Zoom In'
          OnClick = miZoomInClick
        end
        object miZoomOut: TMenuItem
          Caption = 'Zoom Out'
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
          ShortCut = 16432
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
          OnClick = miRotateViewClick
        end
        object miRotateViewCCW: TMenuItem
          Caption = 'Rotate View CCW'
          ShortCut = 24658
          OnClick = miRotateViewCCWClick
        end
        object N27: TMenuItem
          Caption = '-'
        end
        object miZMCustom: TMenuItem
          Caption = 'Custom...'
          ShortCut = 16576
          OnClick = miZMCustomClick
        end
      end
      object mMulti: TMenuItem
        Caption = 'Pages'
        Visible = False
        object miMultiFirst: TMenuItem
          Caption = 'First'
          OnClick = tbnMultiFirstClick
        end
        object miMultiPrevious: TMenuItem
          Caption = 'Previous'
          ShortCut = 16459
          OnClick = tbnMultiPrevClick
        end
        object miMultiNext: TMenuItem
          Caption = 'Next'
          ShortCut = 16460
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
      object mGo: TMenuItem
        Caption = 'Go To'
        object miGoBack: TMenuItem
          Caption = 'Back'
          OnClick = miGoBackClick
        end
        object miGoForward: TMenuItem
          Caption = 'Forward'
          OnClick = miGoForwardClick
        end
        object N12: TMenuItem
          Caption = '-'
        end
        object miGoFirst: TMenuItem
          Caption = 'First'
          OnClick = miGoFirstClick
        end
        object miGoLast: TMenuItem
          Caption = 'Last'
          OnClick = miGoLastClick
        end
        object N15: TMenuItem
          Caption = '-'
        end
        object miGoRandom: TMenuItem
          Caption = 'Random'
          ShortCut = 116
          OnClick = miGoRandomClick
        end
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object miShow: TMenuItem
        Caption = 'Slide Show'
        OnClick = miShowClick
      end
      object miStartShow: TMenuItem
        Caption = 'Start Slide Show'
        ShortCut = 117
        OnClick = miStartShowClick
      end
      object N29: TMenuItem
        Caption = '-'
      end
      object miFullScreen: TMenuItem
        Caption = 'Full Screen'
        ShortCut = 122
        OnClick = miFullScreenClick
      end
    end
    object mTools: TMenuItem
      Caption = 'Tools'
      object miOptions: TMenuItem
        Tag = 7
        Caption = 'Options...'
        OnClick = miOptionsClick
      end
    end
    object mHelp: TMenuItem
      Caption = 'Help'
      object miWebSite: TMenuItem
        Caption = 'FuturixImager Online'
        OnClick = miWebSiteClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object miAbout: TMenuItem
        Caption = 'About...'
        OnClick = miAboutClick
      end
    end
  end
  object popMain: TPopupMenu
    Left = 475
    Top = 159
    object piBack: TMenuItem
      Caption = 'Back'
      ImageIndex = 3
      OnClick = miGoBackClick
    end
    object piForward: TMenuItem
      Caption = 'Forward'
      ImageIndex = 4
      OnClick = miGoForwardClick
    end
    object N22: TMenuItem
      Caption = '-'
    end
    object piOpen: TMenuItem
      Caption = 'Open'
      ImageIndex = 0
      OnClick = miOpenClick
    end
    object piClose: TMenuItem
      Caption = 'Close'
      ImageIndex = 1
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
      ImageIndex = 2
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
    object piRotateView: TMenuItem
      Caption = 'Rotate View CW'
      OnClick = miRotateViewClick
    end
    object piRotateViewCCW: TMenuItem
      Caption = 'Rotate View CCW'
      OnClick = miRotateViewCCWClick
    end
    object N28: TMenuItem
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
    object N30: TMenuItem
      Caption = '-'
    end
    object piCustTB: TMenuItem
      Caption = 'Customize...'
      OnClick = miCustTBClick
    end
  end
  object imlStd: TImageList
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
  object imlDis: TImageList
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
    object piDSFitBig: TMenuItem
      Caption = 'Fit Big'
      RadioItem = True
      OnClick = miDSFitBigClick
    end
    object piDSFitAll: TMenuItem
      Caption = 'Fit All'
      RadioItem = True
      OnClick = miDSFitAllClick
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
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Save image as...'
    OnTypeChange = dlgSaveTypeChange
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
  object appEvents: TApplicationEvents
    OnIdle = appEventsIdle
    OnHint = appEventsHint
    Left = 444
    Top = 128
  end
  object imlFixed: TImageList
    Left = 506
    Top = 221
  end
end
