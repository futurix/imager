object frmOptions: TfrmOptions
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'File Associations'
  ClientHeight = 391
  ClientWidth = 439
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblAddParams: TLabel
    Left = 10
    Top = 330
    Width = 100
    Height = 13
    Caption = 'Additional settings...'
    Transparent = True
    OnClick = lblAddParamsClick
  end
  object btnOK: TButton
    Left = 275
    Top = 357
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 355
    Top = 357
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object lvwExt: TListView
    Left = 10
    Top = 10
    Width = 420
    Height = 295
    Checkboxes = True
    Columns = <
      item
        Caption = 'Extension'
        Width = -1
        WidthType = (
          -1)
      end
      item
        Caption = 'Description'
        Width = -1
        WidthType = (
          -1)
      end>
    ColumnClick = False
    ReadOnly = True
    RowSelect = True
    PopupMenu = popFormats
    SortType = stText
    TabOrder = 2
    ViewStyle = vsReport
  end
  object cbxShowRare: TCheckBox
    Left = 10
    Top = 310
    Width = 420
    Height = 17
    Caption = 'Show rare or incompletely supported formats'
    TabOrder = 3
    OnClick = cbxShowRareClick
  end
  object popFormats: TPopupMenu
    Left = 389
    Top = 37
    object piSelectAll: TMenuItem
      Caption = 'Select All'
      OnClick = piSelectAllClick
    end
    object piSelectNone: TMenuItem
      Caption = 'Select None'
      OnClick = piSelectNoneClick
    end
  end
end
