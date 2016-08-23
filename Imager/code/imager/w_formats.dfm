object frmFormats: TfrmFormats
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'File Formats Setup'
  ClientHeight = 300
  ClientWidth = 437
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg'
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
    Left = 4
    Top = 4
    Width = 54
    Height = 13
    Caption = 'Extensions:'
  end
  object bvlSep: TBevel
    Left = 4
    Top = 264
    Width = 427
    Height = 2
  end
  object btnOK: TButton
    Left = 278
    Top = 270
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 356
    Top = 270
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object gbxIcon: TGroupBox
    Left = 223
    Top = 89
    Width = 208
    Height = 76
    Caption = ' Select icon '
    TabOrder = 2
    object imgIcon1: TImage
      Left = 26
      Top = 35
      Width = 32
      Height = 32
      OnClick = imgIcon1Click
    end
    object imgIcon2: TImage
      Left = 64
      Top = 35
      Width = 32
      Height = 32
      OnClick = imgIcon2Click
    end
    object imgIcon3: TImage
      Left = 101
      Top = 35
      Width = 32
      Height = 32
      OnClick = imgIcon3Click
    end
    object imgIcon4: TImage
      Left = 138
      Top = 35
      Width = 32
      Height = 32
      OnClick = imgIcon4Click
    end
    object rbnIcon1: TRadioButton
      Left = 24
      Top = 18
      Width = 18
      Height = 17
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbnIcon1Click
    end
    object rbnIcon2: TRadioButton
      Left = 63
      Top = 18
      Width = 18
      Height = 17
      TabOrder = 1
      OnClick = rbnIcon2Click
    end
    object rbnIcon3: TRadioButton
      Left = 100
      Top = 18
      Width = 16
      Height = 17
      TabOrder = 2
      OnClick = rbnIcon3Click
    end
    object rbnIcon4: TRadioButton
      Left = 137
      Top = 18
      Width = 17
      Height = 17
      TabOrder = 3
      OnClick = rbnIcon4Click
    end
  end
  object btnRefresh: TButton
    Left = 130
    Top = 19
    Width = 75
    Height = 25
    Caption = 'Refresh'
    TabOrder = 3
    OnClick = btnRefreshClick
  end
  object btnSelectAll: TButton
    Left = 130
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Select All'
    TabOrder = 4
    OnClick = btnSelectAllClick
  end
  object btnSelectNone: TButton
    Left = 130
    Top = 236
    Width = 75
    Height = 25
    Caption = 'Select None'
    TabOrder = 5
    OnClick = btnSelectNoneClick
  end
  object gbxAdds: TGroupBox
    Left = 223
    Top = 14
    Width = 208
    Height = 70
    Caption = ' Additional actions '
    TabOrder = 7
    object btnChangeDescription: TButton
      Left = 10
      Top = 42
      Width = 189
      Height = 23
      Caption = 'Change formats description'
      TabOrder = 0
      OnClick = btnChangeDescriptionClick
    end
  end
  object btnIconViewer: TButton
    Left = 233
    Top = 30
    Width = 189
    Height = 23
    Caption = 'Restore Windows icons viewer'
    TabOrder = 6
    OnClick = btnIconViewerClick
  end
  object cbxFS: TCheckBox
    Left = 223
    Top = 169
    Width = 208
    Height = 17
    Caption = 'Run Futuris Imager in full screen mode'
    TabOrder = 8
  end
  object clbExt: TCheckListBox
    Left = 4
    Top = 19
    Width = 121
    Height = 241
    ItemHeight = 13
    TabOrder = 9
  end
end
