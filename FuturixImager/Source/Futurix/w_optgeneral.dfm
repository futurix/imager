object frmOldOptions: TfrmOldOptions
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 493
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblFormats: TLabel
    Left = 8
    Top = 465
    Width = 129
    Height = 13
    Caption = 'Set file format associations'
    Transparent = True
    Visible = False
  end
  object btnOK: TButton
    Left = 336
    Top = 460
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 417
    Top = 460
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object pclOptions: TPageControl
    Left = 8
    Top = 8
    Width = 484
    Height = 446
    ActivePage = shtGeneral
    HotTrack = True
    TabOrder = 2
    object shtGeneral: TTabSheet
      Caption = 'General'
      object lblClearMRU: TLabel
        Left = 3
        Top = 402
        Width = 97
        Height = 13
        Caption = 'Clear recent files list'
        Transparent = True
        OnClick = lblClearMRUClick
      end
      object lvwSettings: TListView
        Left = 3
        Top = 3
        Width = 470
        Height = 393
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
    object shtBeh: TTabSheet
      Caption = 'More'
      ImageIndex = 1
      object lblMouseDrag: TLabel
        Left = 240
        Top = 49
        Width = 120
        Height = 13
        Caption = 'On mouse click and drag:'
        FocusControl = cbxMouseDrag
        Transparent = True
      end
      object lblArrows: TLabel
        Left = 3
        Top = 3
        Width = 100
        Height = 13
        Caption = 'Arrow keys function:'
        FocusControl = cbxArrows
        Transparent = True
      end
      object lblEnter: TLabel
        Left = 240
        Top = 3
        Width = 101
        Height = 13
        Caption = 'Enter key behaviour:'
        FocusControl = cbxEnter
        Transparent = True
      end
      object lblWheel: TLabel
        Left = 3
        Top = 49
        Width = 145
        Height = 13
        Caption = 'Mouse wheel default function:'
        FocusControl = cbxWheel
        Transparent = True
      end
      object lblNewImage: TLabel
        Left = 3
        Top = 118
        Width = 99
        Height = 13
        Caption = 'On new image open:'
        FocusControl = cbxNewImage
        Transparent = True
      end
      object lblSFSColor: TLabel
        Left = 3
        Top = 214
        Width = 81
        Height = 13
        Caption = 'Full screen color:'
        FocusControl = sbxFSColor
        Transparent = True
      end
      object lblSWinColor: TLabel
        Left = 3
        Top = 164
        Width = 86
        Height = 13
        Caption = 'Background color:'
        FocusControl = sbxMainColor
        Transparent = True
      end
      object lblResample: TLabel
        Left = 3
        Top = 314
        Width = 139
        Height = 13
        Caption = 'Filter for high quality display:'
        FocusControl = cbxResample
        Transparent = True
      end
      object lblSGradColor: TLabel
        Left = 3
        Top = 264
        Width = 71
        Height = 13
        Caption = 'Gradient color:'
        FocusControl = sbxGradColor
      end
      object cbxArrows: TComboBox
        Left = 3
        Top = 22
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
        Left = 240
        Top = 22
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
        Left = 3
        Top = 68
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
        Left = 240
        Top = 68
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
        Left = 3
        Top = 137
        Width = 175
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
        Left = 3
        Top = 95
        Width = 175
        Height = 17
        Caption = 'Reverse direction'
        TabOrder = 5
      end
      object sbxFSColor: TScrollBox
        Left = 3
        Top = 233
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
        Left = 3
        Top = 183
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
        Left = 3
        Top = 333
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
      object sbxGradColor: TScrollBox
        Left = 3
        Top = 283
        Width = 175
        Height = 25
        Cursor = crHandPoint
        AutoScroll = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clSilver
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        OnClick = sbxGradColorClick
      end
      object rdgBg: TRadioGroup
        Left = 240
        Top = 164
        Width = 175
        Height = 144
        Caption = ' Background style '
        Items.Strings = (
          'Gradient'
          'Solid color'
          'System default'
          'Box pattern'
          'Diagonals')
        TabOrder = 10
      end
    end
    object shtPlugins: TTabSheet
      Caption = 'Plug-ins'
      ImageIndex = 6
      TabVisible = False
      object lblInstPlugins: TLabel
        Left = 3
        Top = 3
        Width = 85
        Height = 13
        Caption = 'Installed plug-ins:'
        FocusControl = lvwPlugins
        Transparent = True
      end
      object lblPlugScan: TLabel
        Left = 3
        Top = 402
        Width = 115
        Height = 13
        Caption = 'Scan for new plug-ins...'
        Transparent = True
      end
      object lblOpenPlugFolder: TLabel
        Left = 229
        Top = 402
        Width = 109
        Height = 13
        Caption = 'Open plug-ins folder...'
        Transparent = True
        OnClick = lblOpenPlugFolderClick
      end
      object lvwPlugins: TListView
        Left = 3
        Top = 22
        Width = 470
        Height = 374
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
      TabVisible = False
      object lblPlugCfg: TLabel
        Left = 3
        Top = 3
        Width = 102
        Height = 13
        Caption = 'Plug-in configuration:'
        FocusControl = lvwPlugCfg
        Transparent = True
      end
      object lvwPlugCfg: TListView
        Left = 3
        Top = 22
        Width = 470
        Height = 393
        Columns = <
          item
            Width = -2
            WidthType = (
              -2)
          end>
        ColumnClick = False
        ReadOnly = True
        RowSelect = True
        ShowColumnHeaders = False
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = lvwPlugCfgDblClick
        OnKeyDown = lvwPlugCfgKeyDown
      end
    end
  end
  object imlPreview: TImageList
    ColorDepth = cd32Bit
    Left = 461
    Top = 9
  end
end
