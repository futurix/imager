object frmSetup: TfrmSetup
  Left = 192
  Top = 107
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Imager Settings'
  ClientHeight = 284
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pgcSetup: TPageControl
    Left = 5
    Top = 5
    Width = 324
    Height = 245
    ActivePage = shtGeneral
    HotTrack = True
    TabOrder = 0
    object shtGeneral: TTabSheet
      Caption = 'General'
      object cbxHints: TCheckBox
        Left = 10
        Top = 35
        Width = 212
        Height = 17
        Caption = 'Show hints'
        Checked = True
        ParentShowHint = False
        ShowHint = False
        State = cbChecked
        TabOrder = 0
      end
      object cbxOpenAfterSave: TCheckBox
        Left = 10
        Top = 60
        Width = 228
        Height = 17
        Caption = 'Open after Save'
        Checked = True
        ParentShowHint = False
        ShowHint = False
        State = cbChecked
        TabOrder = 1
      end
      object cbxDeleteTempOnExit: TCheckBox
        Left = 10
        Top = 85
        Width = 249
        Height = 17
        Caption = 'Delete temp files on exit'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
      end
      object cbxAllFiles: TCheckBox
        Left = 10
        Top = 110
        Width = 252
        Height = 17
        Caption = 'Show all files in Open dialog by default'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object cbxFullPath: TCheckBox
        Left = 10
        Top = 135
        Width = 252
        Height = 17
        Caption = 'Show full image path in window title'
        TabOrder = 4
      end
      object cbxHand: TCheckBox
        Left = 10
        Top = 160
        Width = 265
        Height = 17
        Caption = 'Use Hand tool for image scrolling'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object cbxAutoApply: TCheckBox
        Left = 10
        Top = 185
        Width = 266
        Height = 17
        Caption = 'Auto-apply filter results'
        TabOrder = 6
      end
      object cbxFSCenter: TCheckBox
        Left = 10
        Top = 10
        Width = 260
        Height = 17
        Caption = 'Center image in Full Screen mode'
        Checked = True
        State = cbChecked
        TabOrder = 7
      end
    end
    object shtWeb: TTabSheet
      Caption = 'Web'
      ImageIndex = 1
      object lblHRef: TLabel
        Left = 24
        Top = 24
        Width = 38
        Height = 13
        Caption = 'Referer:'
      end
      object lblHUA: TLabel
        Left = 24
        Top = 71
        Width = 56
        Height = 13
        Caption = 'User Agent:'
      end
      object edtReferer: TEdit
        Left = 24
        Top = 39
        Width = 250
        Height = 21
        Hint = 'HTTP Referer for WWW identification'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object edtUA: TEdit
        Left = 24
        Top = 86
        Width = 250
        Height = 21
        Hint = 'HTTP User Agent for identification'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
    end
    object shtColors: TTabSheet
      Caption = 'Colors'
      ImageIndex = 4
      object lblSWinColor: TLabel
        Left = 25
        Top = 28
        Width = 68
        Height = 13
        Caption = 'Window color:'
      end
      object lblSFSColor: TLabel
        Left = 25
        Top = 63
        Width = 80
        Height = 13
        Caption = 'FullScreen Color:'
      end
      object pkrColor: TColorPickerButton
        Left = 150
        Top = 25
        Width = 126
        Height = 22
        CustomText = 'Custom'
        DefaultText = 'Default'
        PopupSpacing = 8
        SelectionColor = clAppWorkSpace
        ShowSystemColors = False
      end
      object pkrFSColor: TColorPickerButton
        Left = 150
        Top = 59
        Width = 126
        Height = 22
        CustomText = 'Custom'
        DefaultText = 'Default'
        PopupSpacing = 8
        ShowSystemColors = False
      end
    end
    object shtMasks: TTabSheet
      Caption = 'Masks'
      ImageIndex = 4
      object gbxOpenDefFilter: TGroupBox
        Left = 10
        Top = 10
        Width = 280
        Height = 62
        Caption = ' Open dialog filter "Major supported formats" entry '
        TabOrder = 0
        object edtOpenDef: TEdit
          Left = 11
          Top = 24
          Width = 250
          Height = 21
          MaxLength = 250
          TabOrder = 0
        end
      end
      object gbxBrowsingMask: TGroupBox
        Left = 10
        Top = 81
        Width = 280
        Height = 62
        Caption = ' Browsing mask '
        TabOrder = 1
        object edtBrowseDef: TEdit
          Left = 11
          Top = 24
          Width = 250
          Height = 21
          MaxLength = 250
          TabOrder = 0
        end
      end
    end
  end
  object btnOK: TButton
    Left = 175
    Top = 254
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 254
    Top = 254
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object dlgColor: TColorDialog
    Ctl3D = True
    Options = [cdFullOpen, cdAnyColor]
    Left = 282
    Top = 3
  end
end
