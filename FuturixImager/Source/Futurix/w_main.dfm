object frmMain: TfrmMain
  Left = 190
  Top = 79
  Caption = 'FuturixImager'
  ClientHeight = 661
  ClientWidth = 1015
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  Menu = mnuMain
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShortCut = FormShortCut
  PixelsPerInch = 96
  TextHeight = 13
  object sbxMain: TScrollBox
    Left = 0
    Top = 24
    Width = 1015
    Height = 618
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
      Width = 1011
      Height = 614
      Cursor = crDefault
      Background = clAppWorkSpace
      ParentCtl3D = False
      BorderStyle = bsNone
      LegacyBitmap = False
      DoubleBuffer = False
      MouseInteract = [miScroll]
      ImageEnVersion = '3.1.1'
      OnMouseWheel = imgMouseWheel
      EnableInteractionHints = True
      Align = alClient
      PopupMenu = popMain
      TabOrder = 0
      TabStop = True
      OnDblClick = imgDblClick
      OnMouseDown = imgMouseDown
    end
  end
  object sbrMain: TStatusBar
    Left = 0
    Top = 642
    Width = 1015
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
    Width = 1015
    Height = 24
    AutoSize = True
    BandBorderStyle = bsNone
    BandMaximize = bmNone
    Bands = <
      item
        Control = itbMain
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 22
        Width = 1013
      end>
    EdgeBorders = [ebTop]
    FixedOrder = True
    ShowText = False
    object itbMain: TToolBar
      Left = 0
      Top = 0
      Width = 1015
      Height = 22
      AutoSize = True
      Caption = 'Toolbar'
      DisabledImages = imlDis
      HideClippedButtons = True
      Images = imlStd
      PopupMenu = popBars
      TabOrder = 0
      Transparent = True
      Wrapable = False
      object tbnOpen: TToolButton
        Left = 0
        Top = 0
        Hint = 'Open'
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
        Left = 44
        Top = 0
        Hint = 'Save As'
        AutoSize = True
        Caption = 'Save'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = miSaveAsClick
      end
      object tbnLast: TToolButton
        Left = 67
        Top = 0
        Hint = 'Load Previous'
        AutoSize = True
        Caption = 'Previous'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        OnClick = miLoadLastClick
      end
      object tbnClose: TToolButton
        Left = 90
        Top = 0
        Hint = 'Close'
        AutoSize = True
        Caption = 'Close'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = miCloseClick
      end
      object tbnPrint: TToolButton
        Left = 113
        Top = 0
        Hint = 'Print'
        AutoSize = True
        Caption = 'Print'
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        OnClick = miPrintPreviewClick
      end
      object tbnCopy: TToolButton
        Left = 136
        Top = 0
        Hint = 'Copy'
        AutoSize = True
        Caption = 'Copy'
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        OnClick = miCopyClick
      end
      object tbnPaste: TToolButton
        Left = 159
        Top = 0
        Hint = 'Paste'
        AutoSize = True
        Caption = 'Paste'
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        OnClick = miPasteClick
      end
      object tbnEditor: TToolButton
        Left = 182
        Top = 0
        Hint = 'Editor'
        Caption = 'Editor'
        ImageIndex = 22
        ParentShowHint = False
        ShowHint = True
        OnClick = miEditorClick
      end
      object tbnMultiPrev: TToolButton
        Left = 205
        Top = 0
        Hint = 'Previous Page'
        AutoSize = True
        Caption = 'Previous'
        Enabled = False
        ImageIndex = 16
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnMultiPrevClick
      end
      object tbnMultiNext: TToolButton
        Left = 228
        Top = 0
        Hint = 'Next Page'
        AutoSize = True
        Caption = 'Next'
        Enabled = False
        ImageIndex = 15
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnMultiNextClick
      end
      object tbnZoomIn: TToolButton
        Left = 251
        Top = 0
        Hint = 'Zoom In'
        AutoSize = True
        Caption = 'Zoom In'
        ImageIndex = 17
        ParentShowHint = False
        ShowHint = True
        OnClick = miZoomInClick
      end
      object tbnZoomOut: TToolButton
        Left = 274
        Top = 0
        Hint = 'Zoom Out'
        AutoSize = True
        Caption = 'Zoom Out'
        ImageIndex = 18
        ParentShowHint = False
        ShowHint = True
        OnClick = miZoomOutClick
      end
      object tbnRotate: TToolButton
        Left = 297
        Top = 0
        Hint = 'Rotate'
        AutoSize = True
        Caption = 'Rotate'
        ImageIndex = 34
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnRotateClick
      end
      object tbnZoomMisc: TToolButton
        Left = 320
        Top = 0
        Hint = 'Zoom'
        AutoSize = True
        Caption = 'Zoom'
        DropdownMenu = popZoom
        ImageIndex = 19
        ParentShowHint = False
        ShowHint = True
        Style = tbsDropDown
      end
      object tbnDisp: TToolButton
        Left = 364
        Top = 0
        Hint = 'Display Options'
        AutoSize = True
        Caption = 'Display'
        DropdownMenu = popDisp
        ImageIndex = 20
        ParentShowHint = False
        ShowHint = True
        Style = tbsDropDown
        OnClick = tbnDispClick
      end
      object tbnFullScreen: TToolButton
        Left = 408
        Top = 0
        Hint = 'Full Screen'
        AutoSize = True
        Caption = 'Full Screen'
        ImageIndex = 21
        ParentShowHint = False
        ShowHint = True
        OnClick = miFullScreenClick
      end
      object tbnInfo: TToolButton
        Left = 431
        Top = 0
        Hint = 'File Info'
        AutoSize = True
        Caption = 'Info'
        ImageIndex = 23
        ParentShowHint = False
        ShowHint = True
        OnClick = miInfoClick
      end
      object tbnGoBack: TToolButton
        Left = 454
        Top = 0
        Hint = 'Go Back'
        AutoSize = True
        Caption = 'Back'
        ImageIndex = 12
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoBackClick
      end
      object tbnGoForward: TToolButton
        Left = 477
        Top = 0
        Hint = 'Go Forward'
        AutoSize = True
        Caption = 'Forward'
        ImageIndex = 13
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoForwardClick
      end
      object tbnUndo: TToolButton
        Left = 500
        Top = 0
        Hint = 'Undo'
        AutoSize = True
        Caption = 'Undo'
        ImageIndex = 9
        ParentShowHint = False
        ShowHint = True
        OnClick = miUndoClick
      end
      object tbnGoRandom: TToolButton
        Left = 523
        Top = 0
        Hint = 'Go Random'
        AutoSize = True
        Caption = 'Random'
        ImageIndex = 47
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoRandomClick
      end
      object tbnZoomFit: TToolButton
        Left = 546
        Top = 0
        Hint = 'Zoom to Fit'
        AutoSize = True
        Caption = 'Fit'
        ImageIndex = 38
        ParentShowHint = False
        ShowHint = True
        OnClick = miZmFitClick
      end
      object tbnShow: TToolButton
        Left = 569
        Top = 0
        Hint = 'Slide Show'
        AutoSize = True
        Caption = 'Slide Show'
        ImageIndex = 49
        ParentShowHint = False
        ShowHint = True
        OnClick = miStartShowClick
      end
      object tbnRScan: TToolButton
        Left = 592
        Top = 0
        Hint = 'Scan'
        AutoSize = True
        Caption = 'Scan'
        Enabled = False
        ImageIndex = 54
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnRScanClick
      end
      object tbnRCapture: TToolButton
        Left = 615
        Top = 0
        Hint = 'Screen Capture'
        AutoSize = True
        Caption = 'Capture'
        Enabled = False
        ImageIndex = 56
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnRCaptureClick
      end
      object tbnRJPEG: TToolButton
        Left = 638
        Top = 0
        Hint = 'Lossless JPEG Transformations'
        AutoSize = True
        Caption = 'JPEG Transf.'
        Enabled = False
        ImageIndex = 57
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnRJPEGClick
      end
      object tbnGoToPage: TToolButton
        Left = 661
        Top = 0
        Hint = 'Go To Page'
        AutoSize = True
        Caption = 'Go To'
        Enabled = False
        ImageIndex = 59
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnGoToPageClick
      end
      object tbnFDelete: TToolButton
        Left = 684
        Top = 0
        Hint = 'Delete File'
        AutoSize = True
        Caption = 'Delete'
        ImageIndex = 24
        ParentShowHint = False
        ShowHint = True
        OnClick = miFDeleteClick
      end
      object tbnFCopy: TToolButton
        Left = 707
        Top = 0
        Hint = 'Copy File'
        AutoSize = True
        Caption = 'Copy'
        ImageIndex = 25
        ParentShowHint = False
        ShowHint = True
        OnClick = miFCopyClick
      end
      object tbnFMove: TToolButton
        Left = 730
        Top = 0
        Hint = 'Move File'
        AutoSize = True
        Caption = 'Move'
        ImageIndex = 26
        ParentShowHint = False
        ShowHint = True
        OnClick = miFMoveClick
      end
      object tbnFRename: TToolButton
        Left = 753
        Top = 0
        Hint = 'Rename File'
        AutoSize = True
        Caption = 'Rename'
        ImageIndex = 27
        ParentShowHint = False
        ShowHint = True
        OnClick = miFRenameClick
      end
      object tbnZoom100: TToolButton
        Left = 776
        Top = 0
        Hint = 'Zoom to 100%'
        AutoSize = True
        Caption = '100%'
        ImageIndex = 44
        ParentShowHint = False
        ShowHint = True
        OnClick = miZM100Click
      end
      object tbnZoomWidth: TToolButton
        Left = 799
        Top = 0
        Hint = 'Zoom to Width'
        AutoSize = True
        Caption = 'Width'
        ImageIndex = 45
        ParentShowHint = False
        ShowHint = True
        OnClick = miZmWidthClick
      end
      object tbnZoomHeight: TToolButton
        Left = 822
        Top = 0
        Hint = 'Zoom to Height'
        AutoSize = True
        Caption = 'Height'
        ImageIndex = 46
        ParentShowHint = False
        ShowHint = True
        OnClick = miZmHeightClick
      end
      object tbnRotateCCW: TToolButton
        Left = 845
        Top = 0
        Hint = 'Rotate CCW'
        AutoSize = True
        Caption = 'Rotate CCW'
        ImageIndex = 35
        ParentShowHint = False
        ShowHint = True
        OnClick = miRotateViewCCWClick
      end
      object tbnGoFirst: TToolButton
        Left = 868
        Top = 0
        Hint = 'Go First'
        AutoSize = True
        Caption = 'First'
        ImageIndex = 11
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoFirstClick
      end
      object tbnGoLast: TToolButton
        Left = 891
        Top = 0
        Hint = 'Go Last'
        AutoSize = True
        Caption = 'Last'
        ImageIndex = 14
        ParentShowHint = False
        ShowHint = True
        OnClick = miGoLastClick
      end
      object tbnOptions: TToolButton
        Left = 914
        Top = 0
        Hint = 'Options'
        AutoSize = True
        Caption = 'Options'
        ImageIndex = 50
        ParentShowHint = False
        ShowHint = True
        OnClick = miOptionsClick
      end
      object tbnHelp: TToolButton
        Left = 937
        Top = 0
        Hint = 'Help'
        AutoSize = True
        Caption = 'Help'
        ImageIndex = 51
        ParentShowHint = False
        ShowHint = True
      end
      object tbnOnline: TToolButton
        Left = 960
        Top = 0
        Hint = 'Open Website'
        AutoSize = True
        Caption = 'Website'
        ImageIndex = 52
        ParentShowHint = False
        ShowHint = True
        OnClick = miWebSiteClick
      end
      object tbnAbout: TToolButton
        Left = 983
        Top = 0
        Hint = 'About'
        AutoSize = True
        Caption = 'About'
        ImageIndex = 53
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
        Caption = 'Load Previous'
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
          Caption = 'Toolbar'
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
        object miDSFit: TMenuItem
          Caption = 'Fit Large Images'
          RadioItem = True
          OnClick = miDSFitClick
        end
        object miDSNormal: TMenuItem
          Caption = 'Normal Display'
          RadioItem = True
          OnClick = miDSNormalClick
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
          Caption = 'Go To Page'
          OnClick = tbnGoToPageClick
        end
        object miMultiExtract: TMenuItem
          Caption = 'Extract Page'
          OnClick = tbnExtractPageClick
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
        Caption = 'FuturixImager Website'
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
    object pRecent: TMenuItem
      Caption = 'Open Recent'
      object N31: TMenuItem
        Caption = '-'
      end
    end
    object piClose: TMenuItem
      Caption = 'Close'
      OnClick = miCloseClick
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object pMulti: TMenuItem
      Caption = 'Pages'
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
        Caption = 'Go To Page'
        OnClick = tbnGoToPageClick
      end
      object piMultiExtract: TMenuItem
        Caption = 'Extract Page'
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
      Caption = 'Custom...'
      OnClick = miZMCustomClick
    end
  end
  object popBars: TPopupMenu
    Left = 537
    Top = 159
    object piTBMain: TMenuItem
      Caption = 'Toolbar'
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
    ColorDepth = cd32Bit
    Left = 444
    Top = 221
  end
  object popDisp: TPopupMenu
    Left = 569
    Top = 159
    object piDSFit: TMenuItem
      Caption = 'Fit Large Images'
      RadioItem = True
      OnClick = miDSFitClick
    end
    object piDSNormal: TMenuItem
      Caption = 'Normal Display'
      RadioItem = True
      OnClick = miDSNormalClick
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
    Title = 'Save Image'
    OnTypeChange = dlgSaveTypeChange
    Left = 475
    Top = 190
  end
  object popMRU: TPopupMenu
    Left = 601
    Top = 159
    object piMRU: TMenuItem
      Caption = 'MRU'
      Visible = False
    end
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
  object dlgOpen: TOpenDialog
    Filter = 'All files (*.*)|*.*'
    Title = 'Open Image'
    Left = 444
    Top = 190
  end
  object imlDis: TImageList
    ColorDepth = cd32Bit
    Left = 475
    Top = 221
  end
end
