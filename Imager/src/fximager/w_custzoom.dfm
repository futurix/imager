object frmCustZoom: TfrmCustZoom
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Custom Zoom'
  ClientHeight = 104
  ClientWidth = 268
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblCustomZoom: TLabel
    Left = 10
    Top = 10
    Width = 65
    Height = 13
    Caption = 'Custom Zoom'
    Transparent = True
  end
  object lblQualityValue: TLabel
    Left = 228
    Top = 28
    Width = 18
    Height = 13
    Caption = '100'
    Transparent = True
  end
  object btnOK: TButton
    Left = 105
    Top = 72
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 184
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object tbrQuality: TTrackBar
    Left = 5
    Top = 29
    Width = 221
    Height = 21
    Max = 400
    PageSize = 25
    Frequency = 25
    Position = 100
    TabOrder = 2
    ThumbLength = 11
    OnChange = tbrQualityChange
  end
end
