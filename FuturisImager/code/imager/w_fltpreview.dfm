object frmFltPreview: TfrmFltPreview
  Left = 190
  Top = 105
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Apply Filter...'
  ClientHeight = 333
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
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
  object lblFilters: TLabel
    Left = 7
    Top = 7
    Width = 30
    Height = 13
    Caption = 'Filters:'
    Transparent = True
  end
  object lblPreview: TLabel
    Left = 155
    Top = 7
    Width = 41
    Height = 13
    Caption = 'Preview:'
    Transparent = True
  end
  object bvlSep: TBevel
    Left = 7
    Top = 295
    Width = 414
    Height = 2
  end
  object lbxFilters: TListBox
    Left = 7
    Top = 23
    Width = 143
    Height = 265
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    OnClick = lbxFiltersClick
    OnDblClick = btnOKClick
  end
  object btnOK: TButton
    Left = 268
    Top = 300
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 346
    Top = 300
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object pnlPreview: TPanel
    Left = 155
    Top = 23
    Width = 265
    Height = 265
    Caption = 'No preview available'
    TabOrder = 3
    object imgPreview: TImage
      Left = 4
      Top = 4
      Width = 256
      Height = 256
      Center = True
    end
  end
end
