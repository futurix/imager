object frmInfo: TfrmInfo
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'File Information'
  ClientHeight = 444
  ClientWidth = 461
  Color = clBtnFace
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
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 382
    Top = 412
    Width = 73
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object pclInfo: TPageControl
    Left = 5
    Top = 5
    Width = 450
    Height = 400
    ActivePage = shtGeneral
    HotTrack = True
    TabOrder = 1
    object shtGeneral: TTabSheet
      Caption = 'General'
      object lvwInfo: TListView
        Left = 5
        Top = 5
        Width = 432
        Height = 361
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
      Caption = 'EXIF'
      ImageIndex = 3
      TabVisible = False
      object lvwEXIF: TListView
        Left = 5
        Top = 5
        Width = 432
        Height = 362
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
      Caption = 'EXIF Thumbnail'
      ImageIndex = 1
      TabVisible = False
      object imgThumb: TImageEnView
        Left = 5
        Top = 5
        Width = 432
        Height = 361
        Cursor = crDefault
        Background = clAppWorkSpace
        ParentCtl3D = False
        LegacyBitmap = False
        MouseInteract = [miScroll]
        EnableAlphaChannel = True
        AutoShrink = True
        TabOrder = 0
      end
    end
    object shtHistogram: TTabSheet
      Caption = 'Histogram'
      ImageIndex = 3
      object boxHistogram: THistogramBox
        Left = 5
        Top = 5
        Width = 432
        Height = 342
        HistogramKind = [hkRed, hkGreen, hkBlue, hkGray]
        Labels = [hlHorizontal]
        HistogramStyle = hsLines
      end
      object cbxRed: TCheckBox
        Left = 5
        Top = 351
        Width = 90
        Height = 17
        Caption = 'Red'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = cbxRedClick
      end
      object cbxGreen: TCheckBox
        Left = 97
        Top = 351
        Width = 90
        Height = 17
        Caption = 'Green'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = cbxRedClick
      end
      object cbxBlue: TCheckBox
        Left = 189
        Top = 351
        Width = 90
        Height = 17
        Caption = 'Blue'
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = cbxRedClick
      end
      object cbxGray: TCheckBox
        Left = 281
        Top = 351
        Width = 90
        Height = 17
        Caption = 'Gray'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnClick = cbxRedClick
      end
    end
  end
end
