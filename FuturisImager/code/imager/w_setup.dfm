object frmSetup: TfrmSetup
  Left = 190
  Top = 105
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Imager Settings'
  ClientHeight = 264
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
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
    Left = 138
    Top = 230
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 217
    Top = 230
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object gbxGeneralSettings: TGroupBox
    Left = 7
    Top = 7
    Width = 285
    Height = 129
    Caption = ' General '
    TabOrder = 2
    object cbxOpenAfterSave: TCheckBox
      Left = 11
      Top = 80
      Width = 258
      Height = 17
      Caption = 'Open after Save'
      Checked = True
      ParentShowHint = False
      ShowHint = False
      State = cbChecked
      TabOrder = 0
    end
    object cbxAllFiles: TCheckBox
      Left = 11
      Top = 100
      Width = 260
      Height = 17
      Caption = 'Show all files in Open dialog by default'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object cbxFullPath: TCheckBox
      Left = 11
      Top = 40
      Width = 252
      Height = 17
      Caption = 'Show full image path in window title'
      TabOrder = 2
    end
    object cbxHand: TCheckBox
      Left = 11
      Top = 60
      Width = 265
      Height = 17
      Caption = 'Use Hand tool for image scrolling'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object cbxFSCenter: TCheckBox
      Left = 11
      Top = 20
      Width = 260
      Height = 17
      Caption = 'Center image in Full Screen mode'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
  end
  object gbxColors: TGroupBox
    Left = 7
    Top = 140
    Width = 285
    Height = 84
    Caption = ' Colors '
    TabOrder = 3
    object lblSFSColor: TLabel
      Left = 18
      Top = 53
      Width = 80
      Height = 13
      Caption = 'FullScreen Color:'
    end
    object lblSWinColor: TLabel
      Left = 18
      Top = 24
      Width = 68
      Height = 13
      Caption = 'Window color:'
    end
    object pkrColor: TColorPickerButton
      Left = 144
      Top = 20
      Width = 126
      Height = 22
      CustomText = 'Custom'
      DefaultText = 'Default'
      Flat = True
      PopupSpacing = 8
      SelectionColor = clAppWorkSpace
      ShowSystemColors = False
    end
    object pkrFSColor: TColorPickerButton
      Left = 144
      Top = 49
      Width = 126
      Height = 22
      CustomText = 'Custom'
      DefaultText = 'Default'
      Flat = True
      PopupSpacing = 8
      ShowSystemColors = False
    end
  end
end
