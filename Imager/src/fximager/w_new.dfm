object frmNew: TfrmNew
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'New Image'
  ClientHeight = 111
  ClientWidth = 400
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
  object gbxSize: TGroupBox
    Left = 10
    Top = 10
    Width = 176
    Height = 59
    Caption = ' Size '
    TabOrder = 0
    object lblWidth: TLabel
      Left = 12
      Top = 14
      Width = 32
      Height = 13
      Caption = 'Width:'
    end
    object lblHeight: TLabel
      Left = 88
      Top = 14
      Width = 35
      Height = 13
      Caption = 'Height:'
    end
    object edtWidth: TEdit
      Left = 12
      Top = 28
      Width = 70
      Height = 21
      TabOrder = 0
      Text = '500'
    end
    object edtHeight: TEdit
      Left = 88
      Top = 28
      Width = 75
      Height = 21
      TabOrder = 1
      Text = '350'
    end
  end
  object gbxColor: TGroupBox
    Left = 196
    Top = 10
    Width = 195
    Height = 59
    Caption = ' Background Color '
    TabOrder = 1
    object sbxColor: TScrollBox
      Left = 10
      Top = 22
      Width = 175
      Height = 25
      Cursor = crHandPoint
      AutoScroll = False
      BevelKind = bkFlat
      BorderStyle = bsNone
      Color = clWhite
      ParentColor = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = sbxColorClick
    end
  end
  object btnCancel: TButton
    Left = 316
    Top = 75
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnOK: TButton
    Left = 236
    Top = 75
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = btnOKClick
  end
end
