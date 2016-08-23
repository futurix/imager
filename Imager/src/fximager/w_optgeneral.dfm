object frmOptions: TfrmOptions
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 433
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 306
    Top = 400
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 386
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object pclOptions: TPageControl
    Left = 10
    Top = 9
    Width = 451
    Height = 383
    ActivePage = shtGeneral
    HotTrack = True
    TabOrder = 2
    object shtGeneral: TTabSheet
      Caption = 'General'
      object lblClearMRU: TLabel
        Left = 10
        Top = 330
        Width = 97
        Height = 13
        Caption = 'Clear recent files list'
        Transparent = True
        OnClick = lblClearMRUClick
      end
      object lvwSettings: TListView
        Left = 10
        Top = 10
        Width = 420
        Height = 315
        Checkboxes = True
        Columns = <
          item
            Width = -1
            WidthType = (
              -1)
          end>
        ColumnClick = False
        ReadOnly = True
        RowSelect = True
        ShowColumnHeaders = False
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object shtFormats: TTabSheet
      Caption = 'File Formats'
      ImageIndex = 7
      object lblAddParams: TLabel
        Left = 10
        Top = 330
        Width = 100
        Height = 13
        Caption = 'Additional settings...'
        Transparent = True
        OnClick = lblAddParamsClick
      end
      object lvwExt: TListView
        Left = 10
        Top = 10
        Width = 420
        Height = 295
        Checkboxes = True
        Columns = <
          item
            Caption = 'Extension'
            Width = -1
            WidthType = (
              -1)
          end
          item
            Caption = 'Description'
            Width = -1
            WidthType = (
              -1)
          end>
        ColumnClick = False
        ReadOnly = True
        RowSelect = True
        PopupMenu = popFormats
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
      end
      object cbxShowRare: TCheckBox
        Left = 10
        Top = 310
        Width = 420
        Height = 17
        Caption = 'Show rare or incompletely supported formats'
        TabOrder = 1
        OnClick = cbxShowRareClick
      end
    end
    object shtBeh: TTabSheet
      Caption = 'Misc'
      ImageIndex = 1
      object lblMouseDrag: TLabel
        Left = 245
        Top = 55
        Width = 120
        Height = 13
        Caption = 'On mouse click and drag:'
        FocusControl = cbxMouseDrag
        Transparent = True
      end
      object lblArrows: TLabel
        Left = 10
        Top = 10
        Width = 100
        Height = 13
        Caption = 'Arrow keys function:'
        FocusControl = cbxArrows
        Transparent = True
      end
      object lblEnter: TLabel
        Left = 245
        Top = 10
        Width = 101
        Height = 13
        Caption = 'Enter key behaviour:'
        FocusControl = cbxEnter
        Transparent = True
      end
      object lblWheel: TLabel
        Left = 10
        Top = 55
        Width = 145
        Height = 13
        Caption = 'Mouse wheel default function:'
        FocusControl = cbxWheel
        Transparent = True
      end
      object lblNewImage: TLabel
        Left = 10
        Top = 120
        Width = 99
        Height = 13
        Caption = 'On new image open:'
        FocusControl = cbxNewImage
        Transparent = True
      end
      object lblSFSColor: TLabel
        Left = 10
        Top = 215
        Width = 178
        Height = 13
        Caption = 'Background color in full screen mode:'
        Transparent = True
      end
      object lblSWinColor: TLabel
        Left = 10
        Top = 170
        Width = 150
        Height = 13
        Caption = 'Main window background color:'
        Transparent = True
      end
      object lblResample: TLabel
        Left = 10
        Top = 265
        Width = 139
        Height = 13
        Caption = 'Filter for high quality display:'
        FocusControl = cbxResample
        Transparent = True
      end
      object cbxArrows: TComboBox
        Left = 10
        Top = 25
        Width = 175
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'File navigation'
        Items.Strings = (
          'File navigation'
          'Image scrolling')
      end
      object cbxEnter: TComboBox
        Left = 245
        Top = 25
        Width = 175
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 1
        Text = 'Switch between display modes'
        Items.Strings = (
          'Switch between display modes'
          'Toggle full screen mode')
      end
      object cbxWheel: TComboBox
        Left = 10
        Top = 70
        Width = 175
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = 'File navigation'
        Items.Strings = (
          'File navigation'
          'Zooming'
          'Image scrolling')
      end
      object cbxMouseDrag: TComboBox
        Left = 245
        Top = 70
        Width = 175
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 3
        Text = 'Scroll image'
        Items.Strings = (
          'Scroll image'
          'Zoom to selected rectangle')
      end
      object cbxNewImage: TComboBox
        Left = 10
        Top = 135
        Width = 410
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 4
        Text = 'Keep previous display state (and zoom to 100% in normal state)'
        Items.Strings = (
          'Keep previous display state (and zoom to 100% in normal state)'
          'Do nothing (keep previous zoom and display state)'
          'Set display state to "Fit Big"'
          'Set display state to "Fit All"'
          'Set display state to "Normal" and reset zoom to 100%'
          'Set display state to "Normal" and keep previous zoom')
      end
      object cbxReverseWheel: TCheckBox
        Left = 10
        Top = 95
        Width = 175
        Height = 17
        Caption = 'Reverse direction'
        TabOrder = 5
      end
      object sbxFSColor: TScrollBox
        Left = 10
        Top = 230
        Width = 175
        Height = 25
        Cursor = crHandPoint
        AutoScroll = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clBlack
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = sbxFSColorClick
      end
      object sbxMainColor: TScrollBox
        Left = 10
        Top = 185
        Width = 175
        Height = 25
        Cursor = crHandPoint
        AutoScroll = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clAppWorkSpace
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = sbxMainColorClick
      end
      object cbxResample: TComboBox
        Left = 10
        Top = 280
        Width = 175
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 8
        Text = 'Fast linear'
        Items.Strings = (
          'Fast linear'
          'Linear'
          'Triangle'
          'Bicubic'
          'Bilinear'
          'Nearest neighbour'
          'B-spline'
          'Mitchell'
          'Bell'
          'Hermite'
          'Lanczos 3'
          'White on black drawing'
          'Black on white drawing')
      end
    end
    object shtPlugins: TTabSheet
      Caption = 'Plug-ins'
      ImageIndex = 6
      object lblInstPlugins: TLabel
        Left = 10
        Top = 10
        Width = 85
        Height = 13
        Caption = 'Installed plug-ins:'
        FocusControl = lvwPlugins
        Transparent = True
      end
      object lblGetPlugins: TLabel
        Left = 10
        Top = 330
        Width = 96
        Height = 13
        Caption = 'Get more plug-ins...'
        Transparent = True
        OnClick = lblGetPluginsClick
      end
      object lblPlugScan: TLabel
        Left = 10
        Top = 310
        Width = 115
        Height = 13
        Caption = 'Scan for new plug-ins...'
        Transparent = True
        OnClick = lblPlugScanClick
      end
      object lblOpenPlugFolder: TLabel
        Left = 210
        Top = 310
        Width = 109
        Height = 13
        Caption = 'Open plug-ins folder...'
        Transparent = True
        OnClick = lblOpenPlugFolderClick
      end
      object lvwPlugins: TListView
        Left = 10
        Top = 25
        Width = 420
        Height = 280
        Columns = <
          item
            Caption = 'File'
            Width = -1
            WidthType = (
              -1)
          end
          item
            Caption = 'Description'
            Width = -1
            WidthType = (
              -1)
          end>
        ColumnClick = False
        ReadOnly = True
        RowSelect = True
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object shtPlugCfg: TTabSheet
      Caption = 'Additional'
      ImageIndex = 6
      object lblPlugCfg: TLabel
        Left = 10
        Top = 10
        Width = 102
        Height = 13
        Caption = 'Plug-in configuration:'
        FocusControl = lvwPlugCfg
        Transparent = True
      end
      object lvwPlugCfg: TListView
        Left = 10
        Top = 25
        Width = 420
        Height = 315
        Columns = <
          item
            Width = -1
            WidthType = (
              -1)
          end>
        ColumnClick = False
        ReadOnly = True
        RowSelect = True
        ShowColumnHeaders = False
        SmallImages = frmMain.imlFixed
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = lvwPlugCfgDblClick
        OnKeyDown = lvwPlugCfgKeyDown
      end
    end
    object shtLang: TTabSheet
      Caption = 'Languages'
      ImageIndex = 4
      object lblLocale: TLabel
        Left = 10
        Top = 10
        Width = 107
        Height = 13
        Caption = 'Available localizations:'
        FocusControl = cbxLanguages
        Transparent = True
      end
      object lblLocaleInfo: TLabel
        Left = 10
        Top = 50
        Width = 420
        Height = 275
        AutoSize = False
        Transparent = True
      end
      object lblGetLocales: TLabel
        Left = 10
        Top = 330
        Width = 116
        Height = 13
        Caption = 'Get more localizations...'
        Transparent = True
        OnClick = lblGetLocalesClick
      end
      object cbxLanguages: TComboBox
        Left = 10
        Top = 25
        Width = 420
        Height = 21
        AutoComplete = False
        Style = csDropDownList
        ItemHeight = 0
        TabOrder = 0
        OnChange = cbxLanguagesChange
      end
    end
    object shtThemes: TTabSheet
      Caption = 'Themes'
      ImageIndex = 5
      object lblTheme: TLabel
        Left = 10
        Top = 10
        Width = 85
        Height = 13
        Caption = 'Available themes:'
        FocusControl = cbxThemes
        Transparent = True
      end
      object lblGetThemes: TLabel
        Left = 10
        Top = 330
        Width = 94
        Height = 13
        Caption = 'Get more themes...'
        Transparent = True
        OnClick = lblGetThemesClick
      end
      object lblThemeInfo: TLabel
        Left = 10
        Top = 50
        Width = 420
        Height = 85
        AutoSize = False
        Transparent = True
      end
      object cbxThemes: TComboBox
        Left = 10
        Top = 25
        Width = 420
        Height = 21
        AutoComplete = False
        Style = csDropDownList
        ItemHeight = 0
        TabOrder = 0
        OnChange = cbxThemesChange
      end
      object sbxPreview: TScrollBox
        Left = 10
        Top = 145
        Width = 420
        Height = 180
        HorzScrollBar.Smooth = True
        HorzScrollBar.Tracking = True
        VertScrollBar.Smooth = True
        VertScrollBar.Tracking = True
        ParentBackground = True
        TabOrder = 1
        object tbrPreview: TToolBar
          Left = 0
          Top = 0
          Width = 416
          Height = 92
          AutoSize = True
          BorderWidth = 1
          Caption = 'Preview Toolbar'
          EdgeBorders = []
          Flat = True
          Images = imlPreview
          TabOrder = 0
          Transparent = True
          object ToolButton0: TToolButton
            Left = 0
            Top = 0
            AutoSize = True
            ImageIndex = 0
          end
          object ToolButton1: TToolButton
            Left = 23
            Top = 0
            AutoSize = True
            Caption = 'ToolButton1'
            ImageIndex = 1
          end
          object ToolButton2: TToolButton
            Left = 46
            Top = 0
            AutoSize = True
            Caption = 'ToolButton2'
            ImageIndex = 2
          end
          object ToolButton3: TToolButton
            Left = 69
            Top = 0
            AutoSize = True
            Caption = 'ToolButton3'
            ImageIndex = 3
          end
          object ToolButton4: TToolButton
            Left = 92
            Top = 0
            AutoSize = True
            Caption = 'ToolButton4'
            ImageIndex = 4
          end
          object ToolButton5: TToolButton
            Left = 115
            Top = 0
            AutoSize = True
            Caption = 'ToolButton5'
            ImageIndex = 5
          end
          object ToolButton6: TToolButton
            Left = 138
            Top = 0
            AutoSize = True
            Caption = 'ToolButton6'
            ImageIndex = 6
          end
          object ToolButton7: TToolButton
            Left = 161
            Top = 0
            AutoSize = True
            Caption = 'ToolButton7'
            ImageIndex = 7
          end
          object ToolButton8: TToolButton
            Left = 184
            Top = 0
            AutoSize = True
            Caption = 'ToolButton8'
            ImageIndex = 8
          end
          object ToolButton9: TToolButton
            Left = 207
            Top = 0
            AutoSize = True
            Caption = 'ToolButton9'
            ImageIndex = 9
          end
          object ToolButton10: TToolButton
            Left = 230
            Top = 0
            AutoSize = True
            Caption = 'ToolButton10'
            ImageIndex = 10
          end
          object ToolButton19: TToolButton
            Left = 253
            Top = 0
            AutoSize = True
            Caption = 'ToolButton19'
            ImageIndex = 19
          end
          object ToolButton11: TToolButton
            Left = 276
            Top = 0
            AutoSize = True
            Caption = 'ToolButton11'
            ImageIndex = 11
          end
          object ToolButton12: TToolButton
            Left = 299
            Top = 0
            AutoSize = True
            Caption = 'ToolButton12'
            ImageIndex = 12
          end
          object ToolButton14: TToolButton
            Left = 322
            Top = 0
            AutoSize = True
            Caption = 'ToolButton14'
            ImageIndex = 14
          end
          object ToolButton13: TToolButton
            Left = 345
            Top = 0
            AutoSize = True
            Caption = 'ToolButton13'
            ImageIndex = 13
            Wrap = True
          end
          object ToolButton15: TToolButton
            Left = 0
            Top = 22
            AutoSize = True
            Caption = 'ToolButton15'
            ImageIndex = 15
          end
          object ToolButton16: TToolButton
            Left = 23
            Top = 22
            AutoSize = True
            Caption = 'ToolButton16'
            ImageIndex = 16
          end
          object ToolButton17: TToolButton
            Left = 46
            Top = 22
            AutoSize = True
            Caption = 'ToolButton17'
            ImageIndex = 17
          end
          object ToolButton21: TToolButton
            Left = 69
            Top = 22
            AutoSize = True
            Caption = 'ToolButton21'
            ImageIndex = 21
          end
          object ToolButton18: TToolButton
            Left = 92
            Top = 22
            AutoSize = True
            Caption = 'ToolButton18'
            ImageIndex = 18
          end
          object ToolButton22: TToolButton
            Left = 115
            Top = 22
            AutoSize = True
            Caption = 'ToolButton22'
            ImageIndex = 22
          end
          object ToolButton23: TToolButton
            Left = 138
            Top = 22
            AutoSize = True
            Caption = 'ToolButton23'
            ImageIndex = 23
          end
          object ToolButton24: TToolButton
            Left = 161
            Top = 22
            AutoSize = True
            Caption = 'ToolButton24'
            ImageIndex = 24
          end
          object ToolButton25: TToolButton
            Left = 184
            Top = 22
            AutoSize = True
            Caption = 'ToolButton25'
            ImageIndex = 25
          end
          object ToolButton26: TToolButton
            Left = 207
            Top = 22
            AutoSize = True
            Caption = 'ToolButton26'
            ImageIndex = 26
          end
          object ToolButton27: TToolButton
            Left = 230
            Top = 22
            AutoSize = True
            Caption = 'ToolButton27'
            ImageIndex = 27
          end
          object ToolButton28: TToolButton
            Left = 253
            Top = 22
            AutoSize = True
            Caption = 'ToolButton28'
            ImageIndex = 28
          end
          object ToolButton29: TToolButton
            Left = 276
            Top = 22
            AutoSize = True
            Caption = 'ToolButton29'
            ImageIndex = 29
          end
          object ToolButton30: TToolButton
            Left = 299
            Top = 22
            AutoSize = True
            Caption = 'ToolButton30'
            ImageIndex = 30
          end
          object ToolButton31: TToolButton
            Left = 322
            Top = 22
            AutoSize = True
            Caption = 'ToolButton31'
            ImageIndex = 31
          end
          object ToolButton32: TToolButton
            Left = 345
            Top = 22
            AutoSize = True
            Caption = 'ToolButton32'
            ImageIndex = 32
            Wrap = True
          end
          object ToolButton33: TToolButton
            Left = 0
            Top = 44
            AutoSize = True
            Caption = 'ToolButton33'
            ImageIndex = 33
          end
          object ToolButton34: TToolButton
            Left = 23
            Top = 44
            AutoSize = True
            Caption = 'ToolButton34'
            ImageIndex = 34
          end
          object ToolButton35: TToolButton
            Left = 46
            Top = 44
            AutoSize = True
            Caption = 'ToolButton35'
            ImageIndex = 35
          end
          object ToolButton36: TToolButton
            Left = 69
            Top = 44
            AutoSize = True
            Caption = 'ToolButton36'
            ImageIndex = 36
          end
          object ToolButton37: TToolButton
            Left = 92
            Top = 44
            AutoSize = True
            Caption = 'ToolButton37'
            ImageIndex = 37
          end
          object ToolButton38: TToolButton
            Left = 115
            Top = 44
            AutoSize = True
            Caption = 'ToolButton38'
            ImageIndex = 38
          end
          object ToolButton39: TToolButton
            Left = 138
            Top = 44
            AutoSize = True
            Caption = 'ToolButton39'
            ImageIndex = 39
          end
          object ToolButton40: TToolButton
            Left = 161
            Top = 44
            AutoSize = True
            Caption = 'ToolButton40'
            ImageIndex = 40
          end
          object ToolButton41: TToolButton
            Left = 184
            Top = 44
            AutoSize = True
            Caption = 'ToolButton41'
            ImageIndex = 41
          end
          object ToolButton42: TToolButton
            Left = 207
            Top = 44
            AutoSize = True
            Caption = 'ToolButton42'
            ImageIndex = 42
          end
          object ToolButton43: TToolButton
            Left = 230
            Top = 44
            AutoSize = True
            Caption = 'ToolButton43'
            ImageIndex = 43
          end
          object ToolButton44: TToolButton
            Left = 253
            Top = 44
            AutoSize = True
            Caption = 'ToolButton44'
            ImageIndex = 44
          end
          object ToolButton20: TToolButton
            Left = 276
            Top = 44
            AutoSize = True
            Caption = 'ToolButton20'
            ImageIndex = 20
          end
          object ToolButton45: TToolButton
            Left = 299
            Top = 44
            AutoSize = True
            Caption = 'ToolButton45'
            ImageIndex = 45
          end
          object ToolButton46: TToolButton
            Left = 322
            Top = 44
            AutoSize = True
            Caption = 'ToolButton46'
            ImageIndex = 46
          end
          object ToolButton47: TToolButton
            Left = 345
            Top = 44
            AutoSize = True
            Caption = 'ToolButton47'
            ImageIndex = 47
            Wrap = True
          end
          object ToolButton48: TToolButton
            Left = 0
            Top = 66
            AutoSize = True
            Caption = 'ToolButton48'
            ImageIndex = 48
          end
          object ToolButton49: TToolButton
            Left = 23
            Top = 66
            AutoSize = True
            Caption = 'ToolButton49'
            ImageIndex = 49
          end
          object ToolButton50: TToolButton
            Left = 46
            Top = 66
            AutoSize = True
            Caption = 'ToolButton50'
            ImageIndex = 50
          end
          object ToolButton51: TToolButton
            Left = 69
            Top = 66
            AutoSize = True
            Caption = 'ToolButton51'
            ImageIndex = 51
          end
          object ToolButton52: TToolButton
            Left = 92
            Top = 66
            AutoSize = True
            Caption = 'ToolButton52'
            ImageIndex = 52
          end
          object ToolButton53: TToolButton
            Left = 115
            Top = 66
            AutoSize = True
            Caption = 'ToolButton53'
            ImageIndex = 53
          end
          object ToolButton54: TToolButton
            Left = 138
            Top = 66
            AutoSize = True
            Caption = 'ToolButton54'
            ImageIndex = 54
          end
          object ToolButton55: TToolButton
            Left = 161
            Top = 66
            AutoSize = True
            Caption = 'ToolButton55'
            ImageIndex = 55
          end
          object ToolButton56: TToolButton
            Left = 184
            Top = 66
            AutoSize = True
            Caption = 'ToolButton56'
            ImageIndex = 56
          end
          object ToolButton57: TToolButton
            Left = 207
            Top = 66
            AutoSize = True
            Caption = 'ToolButton57'
            ImageIndex = 57
          end
          object ToolButton58: TToolButton
            Left = 230
            Top = 66
            AutoSize = True
            Caption = 'ToolButton58'
            ImageIndex = 58
          end
          object ToolButton59: TToolButton
            Left = 253
            Top = 66
            AutoSize = True
            Caption = 'ToolButton59'
            ImageIndex = 59
          end
          object ToolButton60: TToolButton
            Left = 276
            Top = 66
            AutoSize = True
            Caption = 'ToolButton60'
            ImageIndex = 60
          end
          object ToolButton61: TToolButton
            Left = 299
            Top = 66
            AutoSize = True
            Caption = 'ToolButton61'
            ImageIndex = 61
          end
          object ToolButton62: TToolButton
            Left = 322
            Top = 66
            AutoSize = True
            Caption = 'ToolButton62'
            ImageIndex = 62
          end
        end
      end
    end
  end
  object imlPreview: TImageList
    Left = 406
    Top = 208
  end
  object popFormats: TPopupMenu
    Left = 376
    Top = 208
    object piSelectAll: TMenuItem
      Caption = 'Select All'
      OnClick = piSelectAllClick
    end
    object piSelectNone: TMenuItem
      Caption = 'Select None'
      OnClick = piSelectNoneClick
    end
  end
end
