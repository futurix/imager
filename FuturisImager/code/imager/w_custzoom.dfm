object frmCustZoom: TfrmCustZoom
  Left = 190
  Top = 105
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Custom Zoom'
  ClientHeight = 216
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
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
  object btnOK: TButton
    Left = 119
    Top = 186
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 197
    Top = 186
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object gbxCustomZoom: TGroupBox
    Left = 7
    Top = 7
    Width = 265
    Height = 57
    Caption = ' Custom Zoom '
    TabOrder = 2
    object lblQualityValue: TLabel
      Left = 230
      Top = 18
      Width = 18
      Height = 13
      Caption = '100'
      Transparent = True
    end
    object tbrQuality: TTrackBar
      Left = 7
      Top = 19
      Width = 221
      Height = 21
      Max = 400
      PageSize = 25
      Frequency = 25
      Position = 100
      TabOrder = 0
      ThumbLength = 11
      OnChange = tbrQualityChange
    end
  end
  object gbxQuickSelection: TGroupBox
    Left = 7
    Top = 67
    Width = 265
    Height = 115
    Caption = ' Quick Selection '
    TabOrder = 3
    object sbnZ6: TSpeedButton
      Left = 7
      Top = 18
      Width = 49
      Height = 22
      Caption = '6%'
      Flat = True
      OnClick = sbnZ6Click
    end
    object sbnZ66: TSpeedButton
      Left = 57
      Top = 41
      Width = 49
      Height = 22
      Caption = '66%'
      Flat = True
      OnClick = sbnZ66Click
    end
    object sbnZ25: TSpeedButton
      Left = 157
      Top = 18
      Width = 49
      Height = 22
      Caption = '25%'
      Flat = True
      OnClick = sbnZ25Click
    end
    object sbnZ100: TSpeedButton
      Left = 207
      Top = 41
      Width = 49
      Height = 22
      Caption = '100%'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnClick = sbnZ100Click
    end
    object sbnZ12: TSpeedButton
      Left = 107
      Top = 18
      Width = 49
      Height = 22
      Caption = '12%'
      Flat = True
      OnClick = sbnZ12Click
    end
    object sbnZ50: TSpeedButton
      Left = 7
      Top = 41
      Width = 49
      Height = 22
      Caption = '50%'
      Flat = True
      OnClick = sbnZ50Click
    end
    object sbnZ10: TSpeedButton
      Left = 57
      Top = 18
      Width = 49
      Height = 22
      Caption = '10%'
      Flat = True
      OnClick = sbnZ10Click
    end
    object sbnZ75: TSpeedButton
      Left = 107
      Top = 41
      Width = 49
      Height = 22
      Caption = '75%'
      Flat = True
      OnClick = sbnZ75Click
    end
    object sbnZ99: TSpeedButton
      Left = 157
      Top = 41
      Width = 49
      Height = 22
      Caption = '99%'
      Flat = True
      OnClick = sbnZ99Click
    end
    object sbnZ33: TSpeedButton
      Left = 207
      Top = 18
      Width = 49
      Height = 22
      Caption = '33%'
      Flat = True
      OnClick = sbnZ33Click
    end
    object sbnZ110: TSpeedButton
      Left = 7
      Top = 64
      Width = 49
      Height = 22
      Caption = '110%'
      Flat = True
      OnClick = sbnZ110Click
    end
    object sbnZ125: TSpeedButton
      Left = 57
      Top = 64
      Width = 49
      Height = 22
      Caption = '125%'
      Flat = True
      OnClick = sbnZ125Click
    end
    object sbnZ150: TSpeedButton
      Left = 107
      Top = 64
      Width = 49
      Height = 22
      Caption = '150%'
      Flat = True
      OnClick = sbnZ150Click
    end
    object sbnZ175: TSpeedButton
      Left = 157
      Top = 64
      Width = 49
      Height = 22
      Caption = '175%'
      Flat = True
      OnClick = sbnZ175Click
    end
    object sbnZ200: TSpeedButton
      Left = 207
      Top = 64
      Width = 49
      Height = 22
      Caption = '200%'
      Flat = True
      OnClick = sbnZ200Click
    end
    object sbnZ300: TSpeedButton
      Left = 7
      Top = 87
      Width = 49
      Height = 22
      Caption = '300%'
      Flat = True
      OnClick = sbnZ300Click
    end
    object sbnZ400: TSpeedButton
      Left = 57
      Top = 87
      Width = 49
      Height = 22
      Caption = '400%'
      Flat = True
      OnClick = sbnZ400Click
    end
    object sbnZ500: TSpeedButton
      Left = 107
      Top = 87
      Width = 49
      Height = 22
      Caption = '500%'
      Flat = True
      OnClick = sbnZ500Click
    end
    object sbnZ800: TSpeedButton
      Left = 157
      Top = 87
      Width = 49
      Height = 22
      Caption = '800%'
      Flat = True
      OnClick = sbnZ800Click
    end
    object sbnZ1000: TSpeedButton
      Left = 207
      Top = 87
      Width = 49
      Height = 22
      Caption = '1000%'
      Flat = True
      OnClick = sbnZ1000Click
    end
  end
end
