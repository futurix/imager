object frmHist: TfrmHist
  Left = 190
  Top = 79
  ActiveControl = btnClose
  BorderStyle = bsDialog
  Caption = 'Histogram'
  ClientHeight = 430
  ClientWidth = 612
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
  object hist: THistogramBox
    Left = 6
    Top = 5
    Width = 600
    Height = 386
    Background = clBtnFace
    HistogramKind = [hkRed, hkGreen, hkBlue, hkGray]
    Labels = [hlHorizontal]
    HistogramStyle = hsLines
  end
  object btnClose: TButton
    Left = 532
    Top = 399
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    Default = True
    ModalResult = 2
    TabOrder = 1
  end
  object cbxRed: TCheckBox
    Left = 6
    Top = 403
    Width = 100
    Height = 17
    Caption = 'Red'
    Checked = True
    State = cbChecked
    TabOrder = 2
    OnClick = cbxRedClick
  end
  object cbxGreen: TCheckBox
    Left = 111
    Top = 403
    Width = 100
    Height = 17
    Caption = 'Green'
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnClick = cbxRedClick
  end
  object cbxBlue: TCheckBox
    Left = 221
    Top = 403
    Width = 100
    Height = 17
    Caption = 'Blue'
    Checked = True
    State = cbChecked
    TabOrder = 4
    OnClick = cbxRedClick
  end
  object cbxGrey: TCheckBox
    Left = 331
    Top = 403
    Width = 100
    Height = 17
    Caption = 'Grey'
    Checked = True
    State = cbChecked
    TabOrder = 5
    OnClick = cbxRedClick
  end
end
