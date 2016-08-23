object frmJExport: TfrmJExport
  Left = 192
  Top = 107
  ActiveControl = btnSave
  BorderStyle = bsDialog
  Caption = 'JPEG Export'
  ClientHeight = 230
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblSize: TLabel
    Left = 5
    Top = 203
    Width = 40
    Height = 13
    Caption = 'File size:'
  end
  object btnSave: TButton
    Left = 249
    Top = 201
    Width = 75
    Height = 25
    Caption = 'Save'
    Default = True
    TabOrder = 0
    OnClick = btnSaveClick
  end
  object btnCancel: TButton
    Left = 327
    Top = 201
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object pclJExport: TPageControl
    Left = 5
    Top = 5
    Width = 397
    Height = 193
    ActivePage = shtSettings
    HotTrack = True
    TabOrder = 2
    object shtSettings: TTabSheet
      Caption = 'Settings'
      object cbxGrayScale: TCheckBox
        Left = 10
        Top = 87
        Width = 97
        Height = 17
        Caption = 'GrayScale'
        TabOrder = 0
        OnClick = cbxGrayScaleClick
      end
      object gbxQuality: TGroupBox
        Left = 10
        Top = 15
        Width = 367
        Height = 69
        Caption = ' Quality '
        TabOrder = 1
        object lblQuality: TLabel
          Left = 330
          Top = 24
          Width = 12
          Height = 13
          Caption = '80'
        end
        object tbrQuality: TTrackBar
          Left = 4
          Top = 21
          Width = 317
          Height = 35
          Max = 100
          Min = 1
          Orientation = trHorizontal
          PageSize = 5
          Frequency = 10
          Position = 80
          SelEnd = 0
          SelStart = 0
          TabOrder = 0
          TickMarks = tmBottomRight
          TickStyle = tsAuto
          OnChange = tbrQualityChange
        end
      end
    end
    object shtPreview: TTabSheet
      Caption = 'Preview'
      ImageIndex = 1
      object sbxPreview: TScrollBox
        Left = 0
        Top = 0
        Width = 389
        Height = 165
        HorzScrollBar.Smooth = True
        HorzScrollBar.Tracking = True
        VertScrollBar.Smooth = True
        VertScrollBar.Tracking = True
        Align = alClient
        Color = clAppWorkSpace
        ParentColor = False
        TabOrder = 0
        object imgPreview: TImage
          Left = 0
          Top = 0
          Width = 105
          Height = 105
          AutoSize = True
        end
      end
    end
  end
  object dlgJSave: TSaveDialog
    DefaultExt = 'jpg'
    FileName = 'Untitled.jpg'
    Filter = 'JPEG Images (*.jpg; *.jpeg)|*.jpg; *.jpeg'
    Title = 'Save JPEG ...'
    Left = 367
    Top = 4
  end
end
