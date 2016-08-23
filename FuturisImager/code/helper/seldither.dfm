object frmDither: TfrmDither
  Left = 190
  Top = 105
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Dithering'
  ClientHeight = 253
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object gbxColorReduction: TGroupBox
    Left = 8
    Top = 7
    Width = 225
    Height = 207
    Caption = ' Color Reduction '
    TabOrder = 0
    object rbnCRnone: TRadioButton
      Left = 10
      Top = 18
      Width = 204
      Height = 17
      Caption = 'No color reduction'
      TabOrder = 0
    end
    object rbnCRwin20: TRadioButton
      Left = 10
      Top = 38
      Width = 204
      Height = 17
      Caption = 'Windows 20 color system palette'
      TabOrder = 1
    end
    object rbnCRwin256: TRadioButton
      Left = 10
      Top = 58
      Width = 204
      Height = 17
      Caption = 'Windows 256 color halftone palette'
      TabOrder = 2
    end
    object rbnCRwinGr: TRadioButton
      Left = 10
      Top = 78
      Width = 204
      Height = 17
      Caption = 'Windows 4 grayscale colors'
      TabOrder = 3
    end
    object rbnCRmono: TRadioButton
      Left = 10
      Top = 98
      Width = 204
      Height = 17
      Caption = 'Black/white monochrome palette'
      TabOrder = 4
    end
    object rbnCRgrayscale: TRadioButton
      Left = 10
      Top = 118
      Width = 204
      Height = 17
      Caption = 'Uniform 256 shade grayscale palette'
      TabOrder = 5
    end
    object rbnCRnetscape: TRadioButton
      Left = 10
      Top = 138
      Width = 204
      Height = 17
      Caption = 'Netscape 216 color palette'
      TabOrder = 6
    end
    object rbnCRquant: TRadioButton
      Left = 10
      Top = 158
      Width = 204
      Height = 17
      Caption = 'Optimal color palette'
      Checked = True
      TabOrder = 7
      TabStop = True
    end
    object rbnCRquantWin: TRadioButton
      Left = 10
      Top = 178
      Width = 204
      Height = 17
      Caption = 'Optimal 256 color Windows palette'
      TabOrder = 8
    end
  end
  object gbxDithering: TGroupBox
    Left = 240
    Top = 7
    Width = 218
    Height = 207
    Caption = ' Dithering '
    TabOrder = 1
    object rbnDNear: TRadioButton
      Left = 10
      Top = 18
      Width = 202
      Height = 17
      Caption = 'Nearest color matching'
      TabOrder = 0
    end
    object rbnDfs: TRadioButton
      Left = 10
      Top = 38
      Width = 202
      Height = 17
      Caption = 'Floyd Steinberg Error Diffusion'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object rbnDsierra: TRadioButton
      Left = 10
      Top = 78
      Width = 202
      Height = 17
      Caption = 'Sierra Error Diffusion'
      TabOrder = 2
    end
    object rbnDjajuni: TRadioButton
      Left = 10
      Top = 98
      Width = 202
      Height = 17
      Caption = 'Jarvis, Judice && Ninke Error Diffusion'
      TabOrder = 3
    end
    object rbnDstucki: TRadioButton
      Left = 10
      Top = 58
      Width = 202
      Height = 17
      Caption = 'Stucki Error Diffusion'
      TabOrder = 4
    end
    object rbnDstevearche: TRadioButton
      Left = 10
      Top = 118
      Width = 202
      Height = 17
      Caption = 'Stevenson && Arche Error Diffusion'
      TabOrder = 5
    end
    object rbnDburkes: TRadioButton
      Left = 10
      Top = 138
      Width = 202
      Height = 17
      Caption = 'Burkes Error Diffusion'
      TabOrder = 6
    end
  end
  object btnOK: TButton
    Left = 383
    Top = 219
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOKClick
  end
end
