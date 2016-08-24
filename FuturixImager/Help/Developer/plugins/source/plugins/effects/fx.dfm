object frmFX: TfrmFX
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 74
  ClientWidth = 423
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 258
    Top = 37
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 337
    Top = 37
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object tbrAmount: TTrackBar
    Left = 3
    Top = 12
    Width = 415
    Height = 21
    Max = 100
    Min = 1
    PageSize = 1
    Frequency = 2
    Position = 1
    TabOrder = 2
    ThumbLength = 14
    TickMarks = tmBoth
    TickStyle = tsNone
    OnChange = TrackBarChange
  end
end
