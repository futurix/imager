object frmOptFormats: TfrmOptFormats
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'File Formats'
  ClientHeight = 222
  ClientWidth = 283
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
  object lblChangeDescr: TLabel
    Left = 10
    Top = 125
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
    Top = 145
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
    Left = 115
    Top = 185
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 195
    Top = 185
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object cbxFS: TCheckBox
    Left = 10
    Top = 100
    Width = 175
    Height = 17
    Caption = 'Start in full screen mode'
    TabOrder = 2
  end
  object gbxIcon: TGroupBox
    Left = 10
    Top = 10
    Width = 260
    Height = 85
    Caption = ' Select icon '
    TabOrder = 3
    object imgIcon1: TImage
      Left = 12
      Top = 35
      Width = 32
      Height = 32
      OnClick = imgIcon1Click
    end
    object imgIcon2: TImage
      Left = 76
      Top = 35
      Width = 32
      Height = 32
      OnClick = imgIcon2Click
    end
    object imgIcon3: TImage
      Left = 144
      Top = 35
      Width = 32
      Height = 32
      OnClick = imgIcon3Click
    end
    object imgIcon4: TImage
      Left = 212
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
      Left = 75
      Top = 18
      Width = 18
      Height = 17
      TabOrder = 1
      OnClick = rbnIcon2Click
    end
    object rbnIcon3: TRadioButton
      Left = 143
      Top = 18
      Width = 16
      Height = 17
      TabOrder = 2
      OnClick = rbnIcon3Click
    end
    object rbnIcon4: TRadioButton
      Left = 211
      Top = 18
      Width = 17
      Height = 17
      TabOrder = 3
      OnClick = rbnIcon4Click
    end
  end
end
