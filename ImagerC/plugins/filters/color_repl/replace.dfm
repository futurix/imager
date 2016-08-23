object frmColorReplacer: TfrmColorReplacer
  Left = 192
  Top = 107
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Color Replace'
  ClientHeight = 312
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblColorToReplace: TLabel
    Left = 2
    Top = 10
    Width = 77
    Height = 13
    Caption = 'Color to replace:'
    Transparent = True
  end
  object lblReplacementColor: TLabel
    Left = 165
    Top = 10
    Width = 92
    Height = 13
    Caption = 'Replacement color:'
    Transparent = True
  end
  object pkrRColor: TColorPickerButton
    Left = 261
    Top = 6
    Width = 65
    Height = 22
    CustomText = 'Custom'
    DefaultText = 'Default'
    PopupSpacing = 8
    SelectionColor = clWhite
    ShowSystemColors = False
  end
  object pkrColor: TColorPickerButton
    Left = 83
    Top = 6
    Width = 65
    Height = 22
    CustomText = 'Custom'
    DefaultText = 'Default'
    PopupSpacing = 8
    ShowSystemColors = False
  end
  object sbxReplace: TScrollBox
    Left = 1
    Top = 36
    Width = 437
    Height = 245
    HorzScrollBar.Smooth = True
    HorzScrollBar.Tracking = True
    VertScrollBar.Smooth = True
    VertScrollBar.Tracking = True
    Color = clAppWorkSpace
    ParentColor = False
    TabOrder = 0
    object imgPreview: TImage
      Left = 0
      Top = 0
      Width = 105
      Height = 105
      AutoSize = True
      OnMouseDown = imgPreviewMouseDown
    end
  end
  object btnCancel: TButton
    Left = 363
    Top = 285
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object btnOK: TButton
    Left = 284
    Top = 285
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnPreview: TButton
    Left = 362
    Top = 5
    Width = 75
    Height = 25
    Caption = 'Preview'
    TabOrder = 3
    OnClick = btnPreviewClick
  end
  object dlgColor: TColorDialog
    Ctl3D = True
    Options = [cdFullOpen, cdAnyColor]
    Left = 403
    Top = 41
  end
end
