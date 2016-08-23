object frmEditor: TfrmEditor
  Left = 190
  Top = 79
  ActiveControl = img
  Align = alClient
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Edit Image'
  ClientHeight = 548
  ClientWidth = 767
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object imgPreview: TImageEnView
    Left = 0
    Top = 26
    Width = 542
    Height = 486
    Cursor = crDefault
    Background = clAppWorkSpace
    ParentCtl3D = False
    LegacyBitmap = False
    ScrollBars = ssNone
    EnableAlphaChannel = True
    AutoShrink = True
    ImageEnVersion = '2.2.4'
    Align = alClient
    Visible = False
    TabOrder = 4
  end
  object cbrEditor: TCoolBar
    Left = 0
    Top = 0
    Width = 767
    Height = 26
    AutoSize = True
    BandBorderStyle = bsNone
    BandMaximize = bmNone
    Bands = <
      item
        Control = tbrEditor
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 26
        Width = 767
      end>
    EdgeBorders = []
    FixedOrder = True
    ShowText = False
    object tbrEditor: TToolBar
      Left = 0
      Top = 0
      Width = 763
      Height = 26
      AutoSize = True
      BorderWidth = 1
      Caption = 'Editor Toolbar'
      DisabledImages = frmMain.imlDis
      EdgeBorders = []
      Flat = True
      HideClippedButtons = True
      Images = frmMain.imlStd
      TabOrder = 0
      Transparent = True
      Wrapable = False
      object tbnModSel: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        Caption = 'Select'
        ImageIndex = 31
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnModSelClick
      end
      object tbnModHand: TToolButton
        Left = 23
        Top = 0
        AutoSize = True
        Caption = 'Hand'
        ImageIndex = 32
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnModHandClick
      end
      object tbnModPencil: TToolButton
        Left = 46
        Top = 0
        AutoSize = True
        Caption = 'Pencil'
        ImageIndex = 33
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnModPencilClick
      end
      object tbnModFlood: TToolButton
        Left = 69
        Top = 0
        AutoSize = True
        Caption = 'Flood Fill'
        ImageIndex = 35
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnModFloodClick
      end
      object tbnModDraw: TToolButton
        Left = 92
        Top = 0
        AutoSize = True
        Caption = 'Draw'
        ImageIndex = 36
        ParentShowHint = False
        ShowHint = True
        Visible = False
        OnClick = tbnModDrawClick
      end
      object Sep1: TToolButton
        Left = 115
        Top = 0
        Width = 8
        ImageIndex = 24
        Style = tbsSeparator
      end
      object tbnCut: TToolButton
        Left = 123
        Top = 0
        AutoSize = True
        Caption = 'Cut'
        ImageIndex = 21
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnCutClick
      end
      object tbnCopy: TToolButton
        Left = 146
        Top = 0
        AutoSize = True
        Caption = 'Copy'
        ImageIndex = 5
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnCopyClick
      end
      object tbnPaste: TToolButton
        Left = 169
        Top = 0
        AutoSize = True
        Caption = 'Paste'
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnPasteClick
      end
      object tbnPasteSel: TToolButton
        Left = 192
        Top = 0
        AutoSize = True
        Caption = 'Paste+'
        ImageIndex = 26
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnPasteSelClick
      end
      object Sep2: TToolButton
        Left = 215
        Top = 0
        Width = 8
        ImageIndex = 9
        Style = tbsSeparator
      end
      object tbnUndo: TToolButton
        Left = 223
        Top = 0
        AutoSize = True
        Caption = 'Undo'
        Enabled = False
        ImageIndex = 18
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnUndoClick
      end
      object tbnRedo: TToolButton
        Left = 246
        Top = 0
        AutoSize = True
        Caption = 'Redo'
        Enabled = False
        ImageIndex = 22
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnRedoClick
      end
      object Sep3: TToolButton
        Left = 269
        Top = 0
        Width = 8
        ImageIndex = 10
        Style = tbsSeparator
      end
      object tbnSetFit: TToolButton
        Left = 277
        Top = 0
        AutoSize = True
        Caption = 'Fit Mode'
        ImageIndex = 25
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnSetFitClick
      end
      object tbnZoom: TToolButton
        Left = 300
        Top = 0
        AutoSize = True
        Caption = 'Zoom'
        DropdownMenu = popZoom
        ImageIndex = 24
        ParentShowHint = False
        ShowHint = True
        Style = tbsDropDown
      end
      object Sep5: TToolButton
        Left = 336
        Top = 0
        Width = 8
        ImageIndex = 101
        Style = tbsSeparator
      end
      object tbnSelection: TToolButton
        Left = 344
        Top = 0
        AutoSize = True
        Caption = 'Selection'
        DropdownMenu = popSelection
        ImageIndex = 28
        ParentShowHint = False
        ShowHint = True
        Style = tbsDropDown
      end
      object tbnEraseSelection: TToolButton
        Left = 380
        Top = 0
        AutoSize = True
        Caption = 'Erase'
        ImageIndex = 29
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnEraseSelectionClick
      end
      object Sep6: TToolButton
        Left = 403
        Top = 0
        Width = 8
        ImageIndex = 102
        Style = tbsSeparator
      end
      object tbnResize: TToolButton
        Left = 411
        Top = 0
        AutoSize = True
        Caption = 'Resize'
        ImageIndex = 27
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnResizeClick
      end
      object tbnCrop: TToolButton
        Left = 434
        Top = 0
        AutoSize = True
        Caption = 'Crop'
        ImageIndex = 23
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnCropClick
      end
      object tbnRotate: TToolButton
        Left = 457
        Top = 0
        AutoSize = True
        Caption = 'Rotate'
        ImageIndex = 20
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnRotateClick
      end
    end
  end
  object sbxBottom: TScrollBox
    Left = 0
    Top = 512
    Width = 767
    Height = 36
    Align = alBottom
    AutoScroll = False
    BorderStyle = bsNone
    TabOrder = 0
    DesignSize = (
      767
      36)
    object btnApply: TButton
      Left = 604
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Apply'
      TabOrder = 0
      OnClick = btnApplyClick
    end
    object btnCancel: TButton
      Left = 685
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object pnlFlood: TPanel
      Left = 0
      Top = 0
      Width = 129
      Height = 36
      Align = alLeft
      AutoSize = True
      BevelOuter = bvNone
      BorderWidth = 2
      ParentBackground = True
      TabOrder = 2
      Visible = False
      object lblTolerance: TLabel
        Left = 2
        Top = 2
        Width = 54
        Height = 32
        Align = alLeft
        Caption = 'Tolerance: '
        Transparent = True
        Layout = tlCenter
      end
      object pnlTolerance: TPanel
        Left = 56
        Top = 2
        Width = 71
        Height = 32
        Align = alLeft
        BevelOuter = bvNone
        ParentBackground = True
        TabOrder = 0
        object edtTolerance: TEdit
          Left = 1
          Top = 6
          Width = 49
          Height = 21
          Cursor = crArrow
          ReadOnly = True
          TabOrder = 0
          Text = '10'
        end
        object updTolerance: TUpDown
          Left = 50
          Top = 6
          Width = 15
          Height = 21
          Associate = edtTolerance
          Max = 32
          Position = 10
          TabOrder = 1
        end
      end
    end
  end
  object sbxSide: TScrollBox
    Left = 542
    Top = 26
    Width = 225
    Height = 486
    Align = alRight
    AutoScroll = False
    BevelEdges = [beLeft, beRight]
    BevelInner = bvSpace
    BevelOuter = bvSpace
    BevelKind = bkSoft
    BorderStyle = bsNone
    TabOrder = 1
    object pnlColorSelector: TPanel
      Left = 0
      Top = 0
      Width = 221
      Height = 179
      Align = alTop
      BevelOuter = bvNone
      BorderWidth = 5
      ParentBackground = True
      TabOrder = 0
      object pnlColor: TPanel
        Left = 5
        Top = 5
        Width = 211
        Height = 19
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = True
        ParentColor = True
        TabOrder = 0
        object lblColor: TLabel
          Left = 0
          Top = 0
          Width = 32
          Height = 19
          Align = alLeft
          Alignment = taRightJustify
          Caption = 'Color: '
          FocusControl = boxColorSelector
          Transparent = True
          Layout = tlCenter
        end
        object sbxColor: TScrollBox
          Left = 32
          Top = 0
          Width = 179
          Height = 19
          Align = alClient
          AutoScroll = False
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clWhite
          ParentColor = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
      end
      object boxColorSelector: THSVBox
        Left = 5
        Top = 29
        Width = 211
        Height = 145
        OnChange = boxColorSelectorChange
        Align = alClient
        ParentShowHint = False
        ShowHint = True
      end
      object pnlSep1: TPanel
        Left = 5
        Top = 24
        Width = 211
        Height = 5
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = True
        TabOrder = 2
      end
    end
    object pnlSep2: TPanel
      Left = 0
      Top = 179
      Width = 221
      Height = 10
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = True
      TabOrder = 1
    end
    object lvwFilters: TListView
      Left = 0
      Top = 189
      Width = 221
      Height = 297
      Align = alClient
      BorderStyle = bsNone
      Columns = <
        item
          AutoSize = True
          Caption = 'Filters'
          MinWidth = 100
        end>
      ColumnClick = False
      HotTrackStyles = [htHandPoint, htUnderlineHot]
      ReadOnly = True
      RowSelect = True
      ParentColor = True
      ShowColumnHeaders = False
      SmallImages = frmMain.imlFixed
      TabOrder = 2
      ViewStyle = vsReport
      OnDblClick = lvwFiltersDblClick
      OnKeyDown = lvwFiltersKeyDown
    end
  end
  object img: TImageEnView
    Left = 0
    Top = 26
    Width = 542
    Height = 486
    Cursor = crDefault
    Background = clAppWorkSpace
    ParentCtl3D = False
    LegacyBitmap = False
    MouseInteract = [miSelect]
    SelectionBase = iesbBitmap
    EnableAlphaChannel = True
    ImageEnVersion = '2.2.4'
    Align = alClient
    TabOrder = 2
    TabStop = True
    OnMouseDown = imgMouseDown
    OnMouseMove = imgMouseMove
  end
  object proc: TImageEnProc
    AttachedImageEn = img
    Background = clAppWorkSpace
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clWindowText
    PreviewFont.Height = -11
    PreviewFont.Name = 'MS Shell Dlg 2'
    PreviewFont.Style = []
    UndoLimit = 32
    Left = 126
    Top = 130
  end
  object appEvents: TApplicationEvents
    OnIdle = appEventsIdle
    Left = 126
    Top = 160
  end
  object popSelection: TPopupMenu
    Left = 126
    Top = 190
    object piSelectAll: TMenuItem
      Caption = 'Select All'
      OnClick = piSelectAllClick
    end
    object piInvertSelection: TMenuItem
      Caption = 'Invert Selection'
      OnClick = piInvertSelectionClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object piRemoveSelection: TMenuItem
      Caption = 'Remove Selection'
      OnClick = piRemoveSelectionClick
    end
  end
  object popZoom: TPopupMenu
    Left = 156
    Top = 190
    object piZm6: TMenuItem
      Caption = '6%'
      OnClick = piZm6Click
    end
    object piZm12: TMenuItem
      Caption = '12%'
      OnClick = piZm12Click
    end
    object piZm25: TMenuItem
      Caption = '25%'
      OnClick = piZm25Click
    end
    object piZm50: TMenuItem
      Caption = '50%'
      OnClick = piZm50Click
    end
    object piZm75: TMenuItem
      Caption = '75%'
      OnClick = piZm75Click
    end
    object piZm100: TMenuItem
      Caption = '100%'
      OnClick = piZm100Click
    end
    object piZm150: TMenuItem
      Caption = '150%'
      OnClick = piZm150Click
    end
    object piZm200: TMenuItem
      Caption = '200%'
      OnClick = piZm200Click
    end
    object piZm400: TMenuItem
      Caption = '400%'
      OnClick = piZm400Click
    end
  end
end
