object frmCustTB: TfrmCustTB
  Left = 190
  Top = 79
  BorderStyle = bsDialog
  Caption = 'Customize Toolbar'
  ClientHeight = 317
  ClientWidth = 486
  Color = clBtnFace
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
  PixelsPerInch = 96
  TextHeight = 13
  object lblAvailable: TLabel
    Left = 10
    Top = 10
    Width = 87
    Height = 13
    Caption = 'Available buttons:'
    Transparent = True
  end
  object lblToolbar: TLabel
    Left = 300
    Top = 10
    Width = 63
    Height = 13
    Caption = 'Main toolbar:'
    Transparent = True
  end
  object btnOK: TButton
    Left = 320
    Top = 280
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 400
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object lbxAvailable: TListBox
    Left = 10
    Top = 25
    Width = 175
    Height = 240
    DragMode = dmAutomatic
    ItemHeight = 13
    TabOrder = 2
    OnDragDrop = lbxAvailableDragDrop
    OnDragOver = lbxAvailableDragOver
    OnEndDrag = lbxAvailableEndDrag
  end
  object lbxBar: TListBox
    Left = 300
    Top = 25
    Width = 175
    Height = 240
    DragMode = dmAutomatic
    ItemHeight = 13
    TabOrder = 3
    OnDragDrop = lbxBarDragDrop
    OnDragOver = lbxBarDragOver
    OnEndDrag = lbxBarEndDrag
  end
  object btnAdd: TButton
    Left = 206
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Add >'
    TabOrder = 4
    OnClick = btnAddClick
  end
  object btnRemove: TButton
    Left = 206
    Top = 124
    Width = 75
    Height = 25
    Caption = '< Remove'
    TabOrder = 5
    OnClick = btnRemoveClick
  end
  object btnSeparator: TButton
    Left = 206
    Top = 165
    Width = 75
    Height = 25
    Caption = 'Separator'
    TabOrder = 6
    OnClick = btnSeparatorClick
  end
  object btnReset: TButton
    Left = 10
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 7
    OnClick = btnResetClick
  end
end
