object frmTools: TfrmTools
  Left = 192
  Top = 107
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Tool Links'
  ClientHeight = 315
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblNote: TLabel
    Left = 240
    Top = 128
    Width = 69
    Height = 143
    Caption = 
      'Changes will'#13#10'be applied'#13#10'on Imager'#39's'#13#10'restart.'#13#10'Add "%1" to'#13#10'en' +
      'd of path'#13#10'to pass tool'#13#10'current file'#13#10'path or "%2" - '#13#10'current ' +
      'file'#39's '#13#10'folder.'
  end
  object lbxTools: TListBox
    Left = 3
    Top = 4
    Width = 230
    Height = 307
    ItemHeight = 13
    TabOrder = 0
  end
  object btnAdd: TButton
    Left = 237
    Top = 4
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 1
    OnClick = btnAddClick
  end
  object btnModify: TButton
    Left = 237
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Modify'
    TabOrder = 2
    OnClick = btnModifyClick
  end
  object btnDelete: TButton
    Left = 237
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 3
    OnClick = btnDeleteClick
  end
  object btnOK: TButton
    Left = 237
    Top = 286
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 4
    OnClick = btnOKClick
  end
  object btnRename: TButton
    Left = 237
    Top = 60
    Width = 75
    Height = 25
    Caption = 'Rename'
    TabOrder = 5
    OnClick = btnRenameClick
  end
  object dlgSelFile: TOpenDialog
    Filter = 'All files|*.*'
    Title = 'Select link destination ...'
    Left = 8
    Top = 9
  end
end
