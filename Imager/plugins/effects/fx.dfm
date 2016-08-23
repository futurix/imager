object frmFX: TfrmFX
  Left = 190
  Top = 105
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Change image colors'
  ClientHeight = 262
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 338
    Top = 7
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 417
    Top = 7
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object sbxPreview: TScrollBox
    Left = 6
    Top = 40
    Width = 487
    Height = 214
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Color = clAppWorkSpace
    ParentColor = False
    TabOrder = 2
    object imgPreview: TImage
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      AutoSize = True
    end
  end
  object tbrAmount: TTrackBar
    Left = 0
    Top = 11
    Width = 263
    Height = 21
    Max = 100
    Min = 1
    PageSize = 1
    Frequency = 2
    Position = 1
    TabOrder = 3
    ThumbLength = 14
    TickMarks = tmBoth
    TickStyle = tsNone
    OnChange = TrackBarChange
  end
end
