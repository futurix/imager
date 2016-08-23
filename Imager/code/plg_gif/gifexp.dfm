object frmGIFExport: TfrmGIFExport
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'GIF Export'
  ClientHeight = 274
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pclGExport: TPageControl
    Left = 5
    Top = 5
    Width = 390
    Height = 233
    ActivePage = shtSettings
    HotTrack = True
    TabOrder = 0
    object shtSettings: TTabSheet
      Caption = 'Settings'
      object gbxColorReduction: TGroupBox
        Left = 10
        Top = 4
        Width = 164
        Height = 190
        Caption = ' Color Reduction '
        TabOrder = 0
        object rbnNone: TRadioButton
          Left = 11
          Top = 17
          Width = 140
          Height = 17
          Caption = 'None'
          TabOrder = 0
        end
        object rbnWindows20: TRadioButton
          Left = 11
          Top = 37
          Width = 138
          Height = 17
          Caption = 'Windows 20-color'
          TabOrder = 1
        end
        object rbnWindows256: TRadioButton
          Left = 11
          Top = 57
          Width = 136
          Height = 17
          Caption = 'Windows 256-color'
          TabOrder = 2
        end
        object rbnWindowsGray: TRadioButton
          Left = 11
          Top = 77
          Width = 137
          Height = 17
          Caption = 'Windows GrayScale'
          TabOrder = 3
        end
        object rbnMonochrome: TRadioButton
          Left = 11
          Top = 97
          Width = 139
          Height = 17
          Caption = 'Monochrome'
          TabOrder = 4
        end
        object rbnGrayScale: TRadioButton
          Left = 11
          Top = 117
          Width = 139
          Height = 17
          Caption = 'GrayScale'
          TabOrder = 5
        end
        object rbnNetscape: TRadioButton
          Left = 11
          Top = 137
          Width = 139
          Height = 17
          Caption = 'Netscape WebSafe'
          TabOrder = 6
        end
        object rbnQuantizeWindows: TRadioButton
          Left = 11
          Top = 157
          Width = 139
          Height = 17
          Caption = 'Optimal 256-colors'
          Checked = True
          TabOrder = 7
          TabStop = True
        end
      end
      object gbxDither: TGroupBox
        Left = 182
        Top = 4
        Width = 186
        Height = 190
        Caption = ' Dither '
        TabOrder = 1
        object rbnNearest: TRadioButton
          Left = 11
          Top = 17
          Width = 113
          Height = 17
          Caption = 'Nearest'
          TabOrder = 0
        end
        object rbnFloydSteinberg: TRadioButton
          Left = 11
          Top = 36
          Width = 113
          Height = 17
          Caption = 'Floyd Steinberg'
          Checked = True
          TabOrder = 1
          TabStop = True
        end
        object rbnStucki: TRadioButton
          Left = 11
          Top = 55
          Width = 113
          Height = 17
          Caption = 'Stucki'
          TabOrder = 2
        end
        object rbnSierra: TRadioButton
          Left = 11
          Top = 74
          Width = 113
          Height = 17
          Caption = 'Sierra'
          TabOrder = 3
        end
        object rbnJaJuNI: TRadioButton
          Left = 11
          Top = 93
          Width = 129
          Height = 17
          BiDiMode = bdLeftToRight
          Caption = 'Jarvis, Judice && Ninke'
          ParentBiDiMode = False
          TabOrder = 4
        end
        object rbnStevArche: TRadioButton
          Left = 11
          Top = 112
          Width = 137
          Height = 17
          Caption = 'Stevenson && Arche'
          TabOrder = 5
        end
        object rbnBurkes: TRadioButton
          Left = 11
          Top = 131
          Width = 113
          Height = 17
          Caption = 'Burkes'
          TabOrder = 6
        end
      end
    end
    object shtPreview: TTabSheet
      Caption = 'Preview'
      ImageIndex = 1
      OnShow = shtPreviewShow
      object sbxPreview: TScrollBox
        Left = 0
        Top = 0
        Width = 382
        Height = 205
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
  object btnCancel: TButton
    Left = 320
    Top = 242
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object btnOK: TButton
    Left = 242
    Top = 242
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOKClick
  end
  object dlgGSave: TSaveDialog
    DefaultExt = 'gif'
    FileName = 'Untitled.gif'
    Filter = 'CompuServe GIF Images (*.gif)|*.gif'
    Title = 'Save GIF ...'
    Left = 361
    Top = 3
  end
end
