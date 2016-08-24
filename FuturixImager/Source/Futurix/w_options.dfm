object frmOptions: TfrmOptions
  Left = 0
  Top = 0
  ActiveControl = btnOK
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
    ExplicitHeight = 449
    object StaticText1: TStaticText
      Left = 8
      Top = 5
      Width = 560
      Height = 477
      Align = alClient
      Alignment = taCenter
      AutoSize = False
      Caption = 
        'This dialog is incomplete (you are using alpha version after all' +
        '!). To open old version - please click OK.'
      TabOrder = 0
    end
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
  object tvwCategories: TTreeView
    Left = 0
    Top = 0
    Width = 168
    Height = 487
    Align = alLeft
    BorderStyle = bsNone
    Images = imlOptions
    Indent = 35
    ReadOnly = True
    RowSelect = True
    ShowButtons = False
    ShowLines = False
    ShowRoot = False
    TabOrder = 2
    Items.NodeData = {
      030C0000002C0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      00000000000107570065006C0063006F006D0065002C00000000000000000000
      00FFFFFFFFFFFFFFFF000000000000000000000000010744006900730070006C
      0061007900300000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      000000000001094200650068006100760069006F007500720030000000000000
      0000000000FFFFFFFFFFFFFFFF00000000000000000000000001094300750073
      0074006F006D0069007A006500280000000000000000000000FFFFFFFFFFFFFF
      FF0000000000000000000000000105460069006C00650073002C000000000000
      0000000000FFFFFFFFFFFFFFFF00000000000000000000000001074500640069
      00740069006E006700360000000000000000000000FFFFFFFFFFFFFFFF000000
      000000000000000000010C4100730073006F00630069006100740069006F006E
      0073002E0000000000000000000000FFFFFFFFFFFFFFFF000000000000000000
      000000010850006C00750067002D0069006E0073002A00000000000000000000
      00FFFFFFFFFFFFFFFF00000000000000000000000001065400680065006D0065
      007300300000000000000000000000FFFFFFFFFFFFFFFF000000000000000000
      00000001094C0061006E006700750061006700650073002C0000000000000000
      000000FFFFFFFFFFFFFFFF000000000000000000000000010755007000640061
      007400650073002E0000000000000000000000FFFFFFFFFFFFFFFF0000000000
      00000000000000000841006400760061006E00630065006400}
    ExplicitHeight = 450
  end
  object sbxSplitter: TScrollBox
    Left = 0
    Top = 487
    Width = 744
    Height = 1
    Align = alBottom
    AutoScroll = False
    BorderStyle = bsNone
    Color = clBtnShadow
    ParentColor = False
    TabOrder = 3
    ExplicitTop = 409
  end
  object imlOptions: TImageList
    ColorDepth = cd32Bit
    Height = 32
    Width = 32
    Left = 4
    Top = 492
  end
end
