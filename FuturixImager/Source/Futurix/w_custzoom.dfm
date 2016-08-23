object frmCustZoom: TfrmCustZoom
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Custom Zoom'
  ClientHeight = 86
  ClientWidth = 280
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
  object lblQualityValue: TLabel
    Left = 235
    Top = 12
    Width = 18
    Height = 13
    Caption = '100'
    Transparent = True
  end
  object btnOK: TButton
    Left = 116
    Top = 53
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 197
    Top = 53
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object tbrQuality: TTrackBar
    Left = 8
    Top = 8
    Width = 221
    Height = 32
    Max = 400
    PageSize = 25
    Frequency = 25
    Position = 100
    ShowSelRange = False
    TabOrder = 2
    ThumbLength = 23
    OnChange = tbrQualityChange
  end
end
