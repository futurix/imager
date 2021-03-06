object frmInfo: TfrmInfo
  Left = 190
  Top = 79
  ActiveControl = btnClose
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Image Information'
  ClientHeight = 423
  ClientWidth = 592
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 200
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
  DesignSize = (
    592
    423)
  PixelsPerInch = 96
  TextHeight = 13
  object btnClose: TButton
    Left = 513
    Top = 390
    Width = 73
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    Default = True
    TabOrder = 0
    OnClick = btnCloseClick
  end
  object pclInfo: TPageControl
    Left = 5
    Top = 5
    Width = 581
    Height = 377
    ActivePage = shtGeneral
    Anchors = [akLeft, akTop, akRight, akBottom]
    HotTrack = True
    TabOrder = 1
    object shtGeneral: TTabSheet
      BorderWidth = 5
      Caption = 'General'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lvwInfo: TListView
        Left = 0
        Top = 0
        Width = 563
        Height = 339
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
        ShowColumnHeaders = False
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object shtEXIFinfo: TTabSheet
      BorderWidth = 5
      Caption = 'EXIF'
      ImageIndex = 3
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lvwEXIF: TListView
        Left = 0
        Top = 0
        Width = 563
        Height = 339
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
        ShowColumnHeaders = False
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object shtEXIF: TTabSheet
      BorderWidth = 5
      Caption = 'EXIF Thumbnail'
      ImageIndex = 1
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object imgThumb: TImageEnView
        Left = 0
        Top = 0
        Width = 563
        Height = 339
        Cursor = crDefault
        Background = clAppWorkSpace
        ParentCtl3D = False
        LegacyBitmap = False
        MouseInteract = [miZoom, miScroll]
        ImageEnVersion = '3.1.0'
        EnableInteractionHints = True
        Align = alClient
        TabOrder = 0
      end
    end
    object shtHist: TTabSheet
      BorderWidth = 5
      Caption = 'Histogram'
      ImageIndex = 3
      OnShow = shtHistShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlHist: TPanel
        Left = 0
        Top = 311
        Width = 563
        Height = 28
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object rbnAll: TRadioButton
          Left = 0
          Top = 6
          Width = 90
          Height = 17
          Caption = 'All'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rbnAllClick
        end
        object rbnGrey: TRadioButton
          Left = 95
          Top = 6
          Width = 90
          Height = 17
          Caption = 'Grey'
          TabOrder = 1
          OnClick = rbnAllClick
        end
        object rbnRed: TRadioButton
          Left = 190
          Top = 6
          Width = 90
          Height = 17
          Caption = 'Red'
          TabOrder = 2
          OnClick = rbnAllClick
        end
        object rbnGreen: TRadioButton
          Left = 285
          Top = 6
          Width = 90
          Height = 17
          Caption = 'Green'
          TabOrder = 3
          OnClick = rbnAllClick
        end
        object rbnBlue: TRadioButton
          Left = 380
          Top = 6
          Width = 90
          Height = 17
          Caption = 'Blue'
          TabOrder = 4
          OnClick = rbnAllClick
        end
      end
      object sbxHist: TScrollBox
        Left = 0
        Top = 0
        Width = 563
        Height = 311
        Align = alClient
        AutoScroll = False
        Color = clWhite
        Padding.Left = 10
        Padding.Top = 10
        Padding.Right = 10
        Padding.Bottom = 10
        ParentColor = False
        TabOrder = 1
        object hist: THistogramBox
          Left = 10
          Top = 10
          Width = 539
          Height = 287
          HistogramKind = [hkRed, hkGreen, hkBlue, hkGray]
          Labels = [hlHorizontal]
          HistogramStyle = hsLines
          Align = alClient
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 592
          ExplicitHeight = 423
        end
      end
    end
  end
end
