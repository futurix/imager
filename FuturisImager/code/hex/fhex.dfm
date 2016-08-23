object frmHex: TfrmHex
  Left = 190
  Top = 105
  ActiveControl = btnClose
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'View as Hex'
  ClientHeight = 523
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object hexEditor: TMPHexEditor
    Left = 0
    Top = 0
    Width = 742
    Height = 489
    Cursor = crIBeam
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    BytesPerRow = 16
    Translation = tkAsIs
    OffsetFormat = '-!10:0x|'
    Colors.Background = clWindow
    Colors.ChangedBackground = 11075583
    Colors.ChangedText = clMaroon
    Colors.CursorFrame = clNavy
    Colors.Offset = clBlack
    Colors.OddColumn = clBlue
    Colors.EvenColumn = clNavy
    Colors.CurrentOffsetBackground = clBtnShadow
    Colors.OffsetBackGround = clBtnFace
    Colors.CurrentOffset = clBtnHighlight
    Colors.Grid = clBtnFace
    Colors.NonFocusCursorFrame = clAqua
    FocusFrame = True
    DrawGridLines = False
    ReadOnlyView = True
    HideSelection = True
    ShowRuler = True
    ShowPositionIfNotFocused = True
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 489
    Width = 742
    Height = 34
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = True
    TabOrder = 1
    object btnClose: TButton
      Left = 663
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Close'
      Default = True
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
end
