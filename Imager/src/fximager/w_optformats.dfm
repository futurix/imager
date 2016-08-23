object frmOptFormats: TfrmOptFormats
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'File Formats'
  ClientHeight = 385
  ClientWidth = 432
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
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
  object lblExtensions: TLabel
    Left = 10
    Top = 10
    Width = 56
    Height = 13
    Caption = 'Extensions:'
  end
  object lblChangeDescr: TLabel
    Left = 10
    Top = 300
    Width = 149
    Height = 13
    Cursor = crHandPoint
    Caption = 'Change file formats description'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = [fsUnderline]
    ParentFont = False
    Transparent = True
    OnClick = lblChangeDescrClick
  end
  object lblRestoreIcon: TLabel
    Left = 10
    Top = 320
    Width = 178
    Height = 13
    Cursor = crHandPoint
    Caption = 'Restore Windows default icon viewer'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = [fsUnderline]
    ParentColor = False
    ParentFont = False
    Transparent = True
    OnClick = lblRestoreIconClick
  end
  object btnOK: TButton
    Left = 265
    Top = 349
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 345
    Top = 349
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object cbxFS: TCheckBox
    Left = 245
    Top = 99
    Width = 175
    Height = 17
    Caption = 'Start in full screen mode'
    TabOrder = 2
  end
  object clbExt: TCheckListBox
    Left = 10
    Top = 25
    Width = 121
    Height = 268
    ItemHeight = 13
    TabOrder = 3
  end
  object btnSelectNone: TButton
    Left = 135
    Top = 55
    Width = 75
    Height = 25
    Caption = 'Select None'
    TabOrder = 4
    OnClick = btnSelectNoneClick
  end
  object btnSelectAll: TButton
    Left = 135
    Top = 25
    Width = 75
    Height = 25
    Caption = 'Select All'
    TabOrder = 5
    OnClick = btnSelectAllClick
  end
  object btnRefresh: TButton
    Left = 135
    Top = 268
    Width = 75
    Height = 25
    Caption = 'Refresh'
    TabOrder = 6
    OnClick = btnRefreshClick
  end
  object gbxIcon: TGroupBox
    Left = 245
    Top = 10
    Width = 175
    Height = 85
    Caption = ' Select icon '
    TabOrder = 7
    object imgIcon1: TImage
      Left = 12
      Top = 35
      Width = 32
      Height = 32
      OnClick = imgIcon1Click
    end
    object imgIcon2: TImage
      Left = 52
      Top = 35
      Width = 32
      Height = 32
      OnClick = imgIcon2Click
    end
    object imgIcon3: TImage
      Left = 92
      Top = 35
      Width = 32
      Height = 32
      OnClick = imgIcon3Click
    end
    object imgIcon4: TImage
      Left = 132
      Top = 35
      Width = 32
      Height = 32
      OnClick = imgIcon4Click
    end
    object rbnIcon1: TRadioButton
      Left = 10
      Top = 18
      Width = 18
      Height = 17
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbnIcon1Click
    end
    object rbnIcon2: TRadioButton
      Left = 51
      Top = 18
      Width = 18
      Height = 17
      TabOrder = 1
      OnClick = rbnIcon2Click
    end
    object rbnIcon3: TRadioButton
      Left = 91
      Top = 18
      Width = 16
      Height = 17
      TabOrder = 2
      OnClick = rbnIcon3Click
    end
    object rbnIcon4: TRadioButton
      Left = 131
      Top = 18
      Width = 17
      Height = 17
      TabOrder = 3
      OnClick = rbnIcon4Click
    end
  end
end
