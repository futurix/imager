object frmCut: TfrmCut
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Cut'
  ClientHeight = 235
  ClientWidth = 588
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PopupMode = pmExplicit
  PopupParent = frmJPEG.Owner
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object labelPreview: TLabel
    Left = 8
    Top = 191
    Width = 60
    Height = 13
    Caption = '0 x 0 x 0 x 0'
    Transparent = True
  end
  object labelHint: TLabel
    Left = 8
    Top = 8
    Width = 213
    Height = 13
    Caption = 'Please select the size of rectangle to cut out'
    Transparent = True
  end
  object labelTop: TLabel
    Left = 46
    Top = 27
    Width = 22
    Height = 13
    Alignment = taRightJustify
    Caption = 'Top:'
    Transparent = True
  end
  object labelRight: TLabel
    Left = 39
    Top = 68
    Width = 29
    Height = 13
    Alignment = taRightJustify
    Caption = 'Right:'
    Transparent = True
  end
  object labelBottom: TLabel
    Left = 30
    Top = 109
    Width = 38
    Height = 13
    Alignment = taRightJustify
    Caption = 'Bottom:'
    Transparent = True
  end
  object labelLeft: TLabel
    Left = 45
    Top = 150
    Width = 23
    Height = 13
    Alignment = taRightJustify
    Caption = 'Left:'
    Transparent = True
  end
  object trackTop: TTrackBar
    Left = 74
    Top = 27
    Width = 500
    Height = 35
    Max = 100
    Min = 1
    PageSize = 16
    Frequency = 16
    Position = 1
    PositionToolTip = ptRight
    TabOrder = 0
    OnChange = trackTopChange
  end
  object trackRight: TTrackBar
    Left = 74
    Top = 68
    Width = 500
    Height = 35
    Max = 100
    Min = 1
    PageSize = 16
    Frequency = 16
    Position = 1
    PositionToolTip = ptRight
    TabOrder = 1
    OnChange = trackTopChange
  end
  object trackLeft: TTrackBar
    Left = 74
    Top = 150
    Width = 500
    Height = 35
    Max = 100
    Min = 1
    PageSize = 16
    Frequency = 16
    Position = 1
    PositionToolTip = ptRight
    TabOrder = 2
    OnChange = trackTopChange
  end
  object trackBottom: TTrackBar
    Left = 74
    Top = 109
    Width = 500
    Height = 35
    Max = 100
    Min = 1
    PageSize = 16
    Frequency = 16
    Position = 1
    PositionToolTip = ptRight
    TabOrder = 3
    OnChange = trackTopChange
  end
  object buttonOK: TButton
    Left = 505
    Top = 202
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 4
    OnClick = buttonOKClick
  end
end
