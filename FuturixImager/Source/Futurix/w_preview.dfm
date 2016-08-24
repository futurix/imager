object frmPrint: TfrmPrint
  Left = 190
  Top = 79
  ActiveControl = btnClose
  BorderIcons = [biSystemMenu]
  Caption = 'Print Preview'
  ClientHeight = 540
  ClientWidth = 742
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001002000680400001600000028000000100000002000
    000001002000000000004004000000000000000000000000000000000000FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000030507050203040FF2038505000000000FFFFFF00B0A0
    90FF604830FF604830FF604830FF604830FF604830FF604830FF604830FF6048
    30FF604830FF504840FF305060FF4078C0FF304860FF30506050FFFFFF00B0A0
    90FFFFFFFFFFB0A090FFB0A090FFB0A090FFB0A090FFB0A090FFB0A090FFB0A0
    90FF908880FF305070FF3080D0FF4098E0FF50B0F0FF506870FFFFFFFF00B0A0
    90FFFFFFFFFFFFFFFFFFFFF8FFFFF0F0F0FFD0D8D0FF909890FF706860FF6068
    60FF505860FF407090FF40A0E0FF60C8FFFF7090A0FF70889050FFFFFF00B0A0
    90FFFFFFFFFFFFFFFFFFFFFFFFFFE0E0E0FF909090FFB0A8A0FFD0C0B0FFD0B0
    A0FF807870FF505850FF6090B0FF7098B0FF7088908000000000FFFFFF00B0A0
    90FFFFFFFFFFFFFFFFFFFFFFFFFFB0B0B0FFC0B8B0FFFFF0E0FFFFE8E0FFF0D8
    C0FFF0D0B0FF807870FF60586090708890800000000000000000FFFFFF00C0A8
    90FFFFFFFFFFFFFFFFFFFFFFFFFFA09890FFF0E8E0FFFFF8F0FFFFF0F0FFFFE8
    E0FFF0D8D0FFD0B0A0FF505850E0000000000000000000000000FFFFFF00C0A8
    A0FFFFFFFFFFFFFFFFFFFFFFFFFFA0A090FFF0E8E0FFFFFFFFFFFFF8F0FFFFF0
    F0FFFFE8E0FFE0C0B0FF606060E0000000000000000000000000FFFFFF00C0B0
    A0FFFFFFFFFFFFFFFFFFFFFFFFFFC0C8C0FFC0C0C0FFFFFFFFFFFFFFFFFFFFF8
    F0FFFFF0E0FFB0A090FF60606080000000000000000000000000FFFFFF00D0B0
    A0FFFFFFFFFFFFFFFFFFFFFFFFFFF0F8FFFFC0B8B0FFC0C0C0FFF0E8E0FFF0E8
    E0FFB0B0A0FF707060FF80706010000000000000000000000000FFFFFF00D0B8
    A0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F8FFFFC0C8C0FFA0A090FF9090
    80FF909090FF605040FF00000000000000000000000000000000FFFFFF00D0B8
    B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB0A090FF6048
    30FF604830FF604830FF00000000000000000000000000000000FFFFFF00D0C0
    B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0A890FFD0C8
    C0FF604830FFD0B0A09000000000000000000000000000000000FFFFFF00E0C0
    B0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0A8A0FF6048
    30FFD0B0A0900000000000000000000000000000000000000000FFFFFF00E0C0
    B0FFE0C0B0FFE0C0B0FFE0C0B0FFE0C0B0FFD0C0B0FFD0B8B0FFD0B0A0FFD0B0
    A090000000000000000000000000000000000000000000000000FFFFFF00FFFF
    FFFFFFE3FFFF0001FFFF0001FFFF0001FFFF0003FFFF0007FFFF000FFFFF000F
    FFFF000FFFFF000FFFFF001FFFFF001FFFFF001FFFFF003FFFFF007FFFFF}
  OldCreateOrder = False
  PopupMode = pmExplicit
  PopupParent = frmMain.Owner
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object prwPrint: TPrintPreview
    Left = 0
    Top = 22
    Width = 742
    Height = 466
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Color = clAppWorkSpace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 0
    Font.Name = 'Arial'
    Font.Style = []
    ParentColor = False
    TabOrder = 0
    Units = mmLoMetric
    PaperView.BorderWidth = 0
    UsePrinterOptions = True
  end
  object tbrPrintMain: TCoolBar
    Left = 0
    Top = 0
    Width = 742
    Height = 22
    AutoSize = True
    BandBorderStyle = bsNone
    BandMaximize = bmNone
    Bands = <
      item
        Control = itbPrintMain
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 22
        Width = 742
      end>
    EdgeBorders = []
    FixedOrder = True
    ShowText = False
    object itbPrintMain: TToolBar
      Left = 0
      Top = 0
      Width = 738
      Height = 22
      AutoSize = True
      ButtonWidth = 55
      Caption = 'Print'
      HideClippedButtons = True
      Images = frmMain.imlStd
      List = True
      ShowCaptions = True
      TabOrder = 0
      Transparent = True
      Wrapable = False
      object tbnPrint: TToolButton
        Left = 0
        Top = 0
        Hint = 'Print'
        AutoSize = True
        Caption = 'Print'
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = False
        OnClick = tbnPrintClick
      end
      object Sep_1: TToolButton
        Left = 53
        Top = 0
        Width = 8
        Caption = 'Sep_1'
        ImageIndex = 4
        Style = tbsSeparator
      end
      object tbnZoom: TToolButton
        Left = 61
        Top = 0
        Hint = 'Zoom'
        AutoSize = True
        Caption = 'Zoom'
        DropdownMenu = popZoom
        ImageIndex = 19
        ParentShowHint = False
        ShowHint = False
        Style = tbsDropDown
      end
      object tbnSetup: TToolButton
        Left = 131
        Top = 0
        Hint = 'Setup'
        AutoSize = True
        Caption = 'Setup'
        ImageIndex = 43
        ParentShowHint = False
        ShowHint = False
        OnClick = tbnSetupClick
      end
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 488
    Width = 742
    Height = 52
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    DesignSize = (
      742
      52)
    object btnClose: TButton
      Left = 661
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      Default = True
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object cbxProportional: TCheckBox
      Left = 7
      Top = 29
      Width = 150
      Height = 17
      Caption = 'Proportional'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = cbxProportionalClick
    end
    object cbxShrinkOnlyLarge: TCheckBox
      Left = 163
      Top = 29
      Width = 150
      Height = 17
      Caption = 'Shrink large images'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = cbxProportionalClick
    end
    object cbxCenter: TCheckBox
      Left = 319
      Top = 29
      Width = 150
      Height = 17
      Caption = 'Center image'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = cbxProportionalClick
    end
    object cbxAllPages: TCheckBox
      Left = 268
      Top = 6
      Width = 150
      Height = 17
      Caption = 'Print all pages'
      TabOrder = 4
    end
    object cbxDPI: TCheckBox
      Left = 7
      Top = 6
      Width = 255
      Height = 17
      Caption = 'Print using original resolution'
      TabOrder = 5
      OnClick = cbxProportionalClick
    end
  end
  object popZoom: TPopupMenu
    TrackButton = tbLeftButton
    Left = 12
    Top = 49
    object piZMFit: TMenuItem
      Caption = 'Zoom To Fit'
      OnClick = piZMFitClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object piZMWidth: TMenuItem
      Caption = 'Zoom To Width'
      OnClick = piZMWidthClick
    end
    object piZMHeight: TMenuItem
      Caption = 'Zoom To Height'
      OnClick = piZMHeightClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object piZM25: TMenuItem
      Caption = '25%'
      OnClick = piZM25Click
    end
    object piZM50: TMenuItem
      Caption = '50%'
      OnClick = piZM50Click
    end
    object piZM75: TMenuItem
      Caption = '75%'
      OnClick = piZM75Click
    end
    object piZM100: TMenuItem
      Caption = '100%'
      OnClick = piZM100Click
    end
    object piZM150: TMenuItem
      Caption = '150%'
      OnClick = piZM150Click
    end
    object piZM200: TMenuItem
      Caption = '200%'
      OnClick = piZM200Click
    end
  end
  object dlgPageSetup: TPageSetupDialog
    MinMarginLeft = 0
    MinMarginTop = 0
    MinMarginRight = 0
    MinMarginBottom = 0
    MarginLeft = 2500
    MarginTop = 2500
    MarginRight = 2500
    MarginBottom = 2500
    PageWidth = 21000
    PageHeight = 29700
    Left = 42
    Top = 49
  end
end
