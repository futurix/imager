object frmInfo: TfrmInfo
  Left = 190
  Top = 79
  Width = 600
  Height = 452
  ActiveControl = btnOK
  BorderIcons = [biSystemMenu]
  Caption = 'File Information'
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 200
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  DesignSize = (
    592
    425)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 513
    Top = 392
    Width = 73
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object pclInfo: TPageControl
    Left = 5
    Top = 5
    Width = 581
    Height = 379
    ActivePage = shtGeneral
    Anchors = [akLeft, akTop, akRight, akBottom]
    HotTrack = True
    TabOrder = 1
    object shtGeneral: TTabSheet
      BorderWidth = 5
      Caption = 'General'
      object lvwInfo: TListView
        Left = 0
        Top = 0
        Width = 563
        Height = 341
        Align = alClient
        Columns = <
          item
            Caption = 'Keys'
            Width = -1
            WidthType = (
              -1)
          end
          item
            Caption = 'Values'
            Width = -1
            WidthType = (
              -1)
          end>
        ColumnClick = False
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object shtEXIFinfo: TTabSheet
      BorderWidth = 5
      Caption = 'EXIF'
      ImageIndex = 3
      TabVisible = False
      object lvwEXIF: TListView
        Left = 0
        Top = 0
        Width = 563
        Height = 341
        Align = alClient
        Columns = <
          item
            Caption = 'Keys'
            Width = -1
            WidthType = (
              -1)
          end
          item
            Caption = 'Values'
            Width = -1
            WidthType = (
              -1)
          end>
        ColumnClick = False
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object shtEXIF: TTabSheet
      BorderWidth = 5
      Caption = 'EXIF Thumbnail'
      ImageIndex = 1
      TabVisible = False
      object imgThumb: TImageEnView
        Left = 0
        Top = 0
        Width = 497
        Height = 438
        Cursor = crDefault
        Background = clAppWorkSpace
        ParentCtl3D = False
        LegacyBitmap = False
        MouseInteract = [miZoom, miScroll]
        EnableAlphaChannel = True
        Align = alClient
        TabOrder = 0
      end
    end
    object shtHistogram: TTabSheet
      BorderWidth = 5
      Caption = 'Histogram'
      ImageIndex = 3
      object boxHistogram: THistogramBox
        Left = 0
        Top = 0
        Width = 563
        Height = 311
        HistogramKind = [hkRed, hkGreen, hkBlue, hkGray]
        Labels = [hlHorizontal]
        HistogramStyle = hsLines
        Align = alClient
      end
      object pnlPlaceholder: TPanel
        Left = 0
        Top = 311
        Width = 563
        Height = 30
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object cbxBlue: TCheckBox
          Left = 184
          Top = 9
          Width = 90
          Height = 17
          Caption = 'Blue'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = cbxRedClick
        end
        object cbxRed: TCheckBox
          Left = 0
          Top = 9
          Width = 90
          Height = 17
          Caption = 'Red'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = cbxRedClick
        end
        object cbxGreen: TCheckBox
          Left = 92
          Top = 9
          Width = 90
          Height = 17
          Caption = 'Green'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = cbxRedClick
        end
        object cbxGray: TCheckBox
          Left = 276
          Top = 9
          Width = 90
          Height = 17
          Caption = 'Gray'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = cbxRedClick
        end
      end
    end
  end
end
