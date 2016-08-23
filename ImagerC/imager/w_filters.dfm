object frmFilters: TfrmFilters
  Left = 192
  Top = 107
  Width = 203
  Height = 246
  BorderStyle = bsSizeToolWin
  Caption = 'Filters'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbxFilters: TListBox
    Left = 0
    Top = 0
    Width = 195
    Height = 192
    Align = alClient
    Color = clBtnFace
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    OnDblClick = lbxFiltersDblClick
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 192
    Width = 195
    Height = 27
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnApply: TButton
      Left = 0
      Top = 2
      Width = 92
      Height = 25
      Hint = 'Apply Changes'
      Caption = 'Apply Changes'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnApplyClick
    end
    object btnRestore: TButton
      Left = 94
      Top = 2
      Width = 101
      Height = 25
      Hint = 'Restore Original'
      Anchors = [akTop, akRight]
      Caption = 'Restore Original'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnRestoreClick
    end
  end
end
