object frmEditor: TfrmEditor
  Left = 190
  Top = 79
  ActiveControl = img
  BorderIcons = [biSystemMenu]
  Caption = 'Edit Image'
  ClientHeight = 546
  ClientWidth = 739
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    000001002000000000004004000000000000000000000000000000000000FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A068
    50FF804830FF804820FF804820FF905840FFA07060FFA07060FFA07060FF9060
    40FF804020FF803010FF703010FF703010FF703010FF0000000000000000A070
    50FFF0E0D0FFD0B8A0FFC09880FFC09080FFC0A090FF707070FF505850FF0000
    00FFA0A8A0FF806050FF503830FF503830FF703010FF0000000000000000A078
    60FFF0F0F0FFF0D8D0FFE0C0B0FFD0A890FFC0A090FFA0A0A0FFFFFFFFFF5090
    B0FF101010FFA0A8A0FF807060FF605040FF703010FF0000000000000000A078
    60FFFFF8FFFFFFF0F0FFF0E0D0FFE0B8A0FFC0A090FFA0A0A0FF90B8C0FF70D0
    E0FF5098B0FF101010FFA0A8A0FF000800FF803010FF0000000000000000B080
    70FFA08070FFF0F0F0FFFFF0F0FFF0E0D0FFE0B0A0FFC0B8B0FF50A0B0FF90E0
    F0FF60C0D0FF5098B0FF101010FFA0A8A0FF804020FF0000000000000000B088
    70FFF0E0E0FFA08070FFF0E8E0FFF0E8E0FFF0D0D0FFD0C0B0FFC0B8B0FF50A0
    B0FF90E0F0FF60C0D0FF5098B0FF101010FF806860FF0000000000000000C090
    80FFFFFFFFFFF0E0E0FFA08070FFF0E8E0FFF0D8D0FF605040FFD0B0A0FFE0C8
    C0FF60A8B0FF90E0F0FF60C0D0FF5098B0FF101010FF3058603000000000C098
    80FFFFFFFFFFFFFFFFFFF0E0E0FFA08070FFA08070FFF0D8D0FFFFE0D0FFFFD8
    C0FFE0C8C0FF70B0C0FF90E0F0FF70C8E0FF808880FF303890FF30388050C0A0
    90FFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0FFFFF0F0FFFFF0E0FFD0C8D0FF2050
    D0FF2050C0FFE0C8C0FF80B0C0FFD0B8B0FF7088D0FF6070B0FF303890FFC0A8
    90FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0FFFFF0F0FF3060D0FF70C0
    FFFF4090D0FF2050C0FFE0C8C0FF6070B0FF7090E0FF6078D0FF6070B0FFD0A8
    90FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F0FF3060D0FFC0E8
    FFFF70C0FFFF2050D0FFFFD8C0FFE0C8C0FF6070B0FF6070B0FF6078C030D0A8
    90FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0D8F0FF3060
    D0FF3060D0FFD0C8D0FFFFE0D0FFE0C0B0FF804820FF0000000000000000D0A8
    90FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8
    F0FFFFF0F0FFFFF0E0FFFFE8E0FFFFE0D0FF804830FF0000000000000000D0A8
    90FFD0A890FFD0A890FFD0A890FFC0A890FFC0A090FFC09880FFC09080FFB088
    70FFB08070FFA07860FFA07860FFA07050FFA06850FF0000000000000000FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FFFF0003FFFF0003FFFF0003FFFF0003FFFF0003FFFF0003FFFF0001FFFF0000
    FFFF0000FFFF0000FFFF0000FFFF0003FFFF0003FFFF0003FFFFFFFFFFFF}
  KeyPreview = True
  OldCreateOrder = False
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object imgPreview: TImageEnView
    Left = 0
    Top = 22
    Width = 514
    Height = 488
    Cursor = crDefault
    Background = clAppWorkSpace
    ParentCtl3D = False
    LegacyBitmap = False
    ScrollBars = ssNone
    AutoShrink = True
    ImageEnVersion = '3.1.0'
    EnableInteractionHints = True
    Align = alClient
    Visible = False
    TabOrder = 4
  end
  object cbrEditor: TCoolBar
    Left = 0
    Top = 0
    Width = 739
    Height = 22
    AutoSize = True
    BandBorderStyle = bsNone
    BandMaximize = bmNone
    Bands = <
      item
        Control = tbrEditor
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 22
        Width = 737
      end>
    EdgeBorders = []
    FixedOrder = True
    ShowText = False
    object tbrEditor: TToolBar
      Left = 0
      Top = 0
      Width = 739
      Height = 22
      AutoSize = True
      Caption = 'Editor Toolbar'
      DisabledImages = frmMain.imlDis
      HideClippedButtons = True
      Images = frmMain.imlStd
      TabOrder = 0
      Transparent = True
      Wrapable = False
      object tbnModSel: TToolButton
        Left = 0
        Top = 0
        Hint = 'Rectangle Selection Tool'
        AutoSize = True
        Caption = 'Select'
        ImageIndex = 28
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnModSelClick
      end
      object tbnModHand: TToolButton
        Left = 23
        Top = 0
        Hint = 'Hand Tool'
        AutoSize = True
        Caption = 'Hand'
        ImageIndex = 29
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnModHandClick
      end
      object tbnModPencil: TToolButton
        Left = 46
        Top = 0
        Hint = 'Pencil Tool'
        AutoSize = True
        Caption = 'Pencil'
        ImageIndex = 30
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnModPencilClick
      end
      object tbnModFlood: TToolButton
        Left = 69
        Top = 0
        Hint = 'Flood Fill Tool'
        AutoSize = True
        Caption = 'Flood Fill'
        ImageIndex = 31
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnModFloodClick
      end
      object tbnModDraw: TToolButton
        Left = 92
        Top = 0
        Hint = 'Drawing Tools'
        AutoSize = True
        Caption = 'Draw'
        ImageIndex = 32
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
        Hint = 'Cut'
        AutoSize = True
        Caption = 'Cut'
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnCutClick
      end
      object tbnCopy: TToolButton
        Left = 146
        Top = 0
        Hint = 'Copy'
        AutoSize = True
        Caption = 'Copy'
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnCopyClick
      end
      object tbnPaste: TToolButton
        Left = 169
        Top = 0
        Hint = 'Paste'
        AutoSize = True
        Caption = 'Paste'
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnPasteClick
      end
      object tbnPasteSel: TToolButton
        Left = 192
        Top = 0
        Hint = 'Paste to Selection'
        AutoSize = True
        Caption = 'Paste+'
        ImageIndex = 39
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
        Hint = 'Undo'
        AutoSize = True
        Caption = 'Undo'
        Enabled = False
        ImageIndex = 9
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnUndoClick
      end
      object tbnRedo: TToolButton
        Left = 246
        Top = 0
        Hint = 'Redo'
        AutoSize = True
        Caption = 'Redo'
        Enabled = False
        ImageIndex = 10
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
        Hint = 'Fit'
        AutoSize = True
        Caption = 'Fit'
        ImageIndex = 38
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnSetFitClick
      end
      object tbnZoom: TToolButton
        Left = 300
        Top = 0
        Hint = 'Zoom'
        AutoSize = True
        Caption = 'Zoom'
        DropdownMenu = popZoom
        ImageIndex = 37
        ParentShowHint = False
        ShowHint = True
        Style = tbsDropDown
      end
      object Sep5: TToolButton
        Left = 344
        Top = 0
        Width = 8
        ImageIndex = 101
        Style = tbsSeparator
      end
      object tbnSelection: TToolButton
        Left = 352
        Top = 0
        Hint = 'Selection'
        AutoSize = True
        Caption = 'Selection'
        DropdownMenu = popSelection
        ImageIndex = 41
        ParentShowHint = False
        ShowHint = True
        Style = tbsDropDown
      end
      object tbnEraseSelection: TToolButton
        Left = 396
        Top = 0
        Hint = 'Erase Selection'
        AutoSize = True
        Caption = 'Erase'
        ImageIndex = 42
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnEraseSelectionClick
      end
      object Sep6: TToolButton
        Left = 419
        Top = 0
        Width = 8
        ImageIndex = 102
        Style = tbsSeparator
      end
      object tbnResize: TToolButton
        Left = 427
        Top = 0
        Hint = 'Resize'
        AutoSize = True
        Caption = 'Resize'
        ImageIndex = 40
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnResizeClick
      end
      object tbnCrop: TToolButton
        Left = 450
        Top = 0
        Hint = 'Crop'
        AutoSize = True
        Caption = 'Crop'
        ImageIndex = 36
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnCropClick
      end
      object tbnRotate: TToolButton
        Left = 473
        Top = 0
        Hint = 'Rotate'
        AutoSize = True
        Caption = 'Rotate'
        ImageIndex = 34
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnRotateClick
      end
    end
  end
  object sbxBottom: TScrollBox
    Left = 0
    Top = 510
    Width = 739
    Height = 36
    Align = alBottom
    AutoScroll = False
    BorderStyle = bsNone
    TabOrder = 0
    DesignSize = (
      739
      36)
    object btnApply: TButton
      Left = 576
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Apply'
      TabOrder = 0
      OnClick = btnApplyClick
    end
    object btnCancel: TButton
      Left = 657
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
        ExplicitHeight = 13
      end
      object pnlTolerance: TPanel
        Left = 56
        Top = 2
        Width = 71
        Height = 32
        Align = alLeft
        BevelOuter = bvNone
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
    Left = 514
    Top = 22
    Width = 225
    Height = 488
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
      TabOrder = 0
      object pnlColor: TPanel
        Left = 5
        Top = 5
        Width = 211
        Height = 19
        Align = alTop
        BevelOuter = bvNone
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
          ExplicitHeight = 13
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
        Cursor = crHandPoint
        Hint = 'Click here to choose color'
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
      TabOrder = 1
    end
    object lvwFilters: TListView
      Left = 0
      Top = 189
      Width = 221
      Height = 299
      Align = alClient
      Columns = <
        item
          Caption = 'Filters'
          MinWidth = 100
          Width = -1
          WidthType = (
            -1)
        end>
      ColumnClick = False
      HotTrackStyles = [htHandPoint, htUnderlineHot]
      ReadOnly = True
      RowSelect = True
      ShowColumnHeaders = False
      TabOrder = 2
      ViewStyle = vsReport
      OnDblClick = lvwFiltersDblClick
      OnKeyDown = lvwFiltersKeyDown
    end
  end
  object img: TImageEnView
    Left = 0
    Top = 22
    Width = 514
    Height = 488
    Cursor = crDefault
    Background = clAppWorkSpace
    ParentCtl3D = False
    LegacyBitmap = False
    MouseInteract = [miSelect]
    SelectionBase = iesbBitmap
    ImageEnVersion = '3.1.0'
    EnableInteractionHints = True
    Align = alClient
    TabOrder = 2
    TabStop = True
    OnMouseDown = imgMouseDown
    OnMouseMove = imgMouseMove
  end
  object proc: TImageEnProc
    AttachedImageEn = img
    Background = clAppWorkSpace
    PreviewsParams = [prppShowResetButton, prppHardReset]
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
