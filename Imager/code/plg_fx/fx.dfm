object frmFX: TfrmFX
  Left = 190
  Top = 79
  Width = 620
  Height = 450
  ActiveControl = btnOK
  BorderIcons = []
  Caption = 'Change image colors'
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
  DesignSize = (
    612
    423)
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 451
    Top = 7
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 530
    Top = 7
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object sbxPreview: TScrollBox
    Left = 6
    Top = 40
    Width = 600
    Height = 375
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Anchors = [akLeft, akTop, akRight, akBottom]
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
    Width = 412
    Height = 21
    Anchors = [akLeft, akTop, akRight]
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
