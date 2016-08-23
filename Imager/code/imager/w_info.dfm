object frmInfo: TfrmInfo
  Left = 190
  Top = 79
  ActiveControl = btnOK
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
  object btnOK: TButton
    Left = 513
    Top = 390
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
    Height = 377
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
        ImageEnVersion = '2.1.9'
        Align = alClient
        TabOrder = 0
      end
    end
  end
  object btnHistogram: TButton
    Left = 5
    Top = 390
    Width = 75
    Height = 25
    Caption = 'Histogram'
    TabOrder = 2
    OnClick = btnHistogramClick
  end
end
