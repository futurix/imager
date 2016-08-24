object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 525
  ClientWidth = 744
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
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
  object sbxFrameHost: TScrollBox
    Left = 168
    Top = 0
    Width = 576
    Height = 487
    Align = alClient
    AutoScroll = False
    BorderStyle = bsNone
    Padding.Left = 8
    Padding.Top = 5
    Padding.Right = 8
    Padding.Bottom = 5
    TabOrder = 0
    ExplicitLeft = 250
    ExplicitTop = 27
    ExplicitWidth = 456
    ExplicitHeight = 394
  end
  object sbxCommands: TScrollBox
    Left = 0
    Top = 488
    Width = 744
    Height = 37
    Align = alBottom
    AutoScroll = False
    BorderStyle = bsNone
    TabOrder = 1
    DesignSize = (
      744
      37)
    object btnOK: TButton
      Left = 582
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      Left = 663
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object sbxSplitterB: TScrollBox
    Left = 0
    Top = 487
    Width = 744
    Height = 1
    Align = alBottom
    AutoScroll = False
    BorderStyle = bsNone
    Color = clBtnShadow
    ParentColor = False
    TabOrder = 2
  end
  object sbxWrapper: TScrollBox
    Left = 0
    Top = 0
    Width = 168
    Height = 487
    Align = alLeft
    AutoScroll = False
    BorderStyle = bsNone
    Color = clWindow
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 2
    ParentColor = False
    TabOrder = 3
    object tvwCategories: TTreeView
      Left = 2
      Top = 2
      Width = 164
      Height = 483
      Align = alClient
      BorderStyle = bsNone
      HideSelection = False
      Images = imlOptions
      Indent = 35
      ReadOnly = True
      RightClickSelect = True
      RowSelect = True
      ShowButtons = False
      ShowLines = False
      ShowRoot = False
      TabOrder = 0
      OnChange = tvwCategoriesChange
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 168
      ExplicitHeight = 487
    end
  end
  object imlOptions: TImageList
    ColorDepth = cd32Bit
    Height = 32
    Width = 32
    Left = 4
    Top = 492
  end
end
