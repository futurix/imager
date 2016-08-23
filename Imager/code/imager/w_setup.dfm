object frmSetup: TfrmSetup
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Preferences'
  ClientHeight = 307
  ClientWidth = 438
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
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
    Left = 277
    Top = 275
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 357
    Top = 275
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object pclSetup: TPageControl
    Left = 5
    Top = 5
    Width = 427
    Height = 263
    ActivePage = shtGeneral
    HotTrack = True
    TabOrder = 2
    object shtGeneral: TTabSheet
      Caption = 'General'
      object cbxAllFiles: TCheckBox
        Left = 10
        Top = 50
        Width = 400
        Height = 17
        Caption = 'Show all files in Open dialog by default'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object cbxFullPath: TCheckBox
        Left = 10
        Top = 10
        Width = 400
        Height = 17
        Caption = 'Show full image path in window title'
        TabOrder = 1
      end
      object cbxOpenAfterSave: TCheckBox
        Left = 10
        Top = 30
        Width = 400
        Height = 17
        Caption = 'Open resulting image after Save'
        Checked = True
        ParentShowHint = False
        ShowHint = False
        State = cbChecked
        TabOrder = 2
      end
      object cbxUseLargeToolbarButtons: TCheckBox
        Left = 10
        Top = 80
        Width = 400
        Height = 17
        Caption = 'Use large toolbar buttons'
        TabOrder = 3
      end
      object cbxNoMRU: TCheckBox
        Left = 10
        Top = 100
        Width = 400
        Height = 17
        Caption = 'Disable recent file list'
        TabOrder = 4
      end
      object cbxFS: TCheckBox
        Left = 10
        Top = 130
        Width = 400
        Height = 17
        Caption = 'Start Futuris Imager in full screen mode'
        TabOrder = 5
      end
    end
    object shtCosmetic: TTabSheet
      Caption = 'Cosmetic'
      ImageIndex = 1
      object gbxColors: TGroupBox
        Left = 10
        Top = 6
        Width = 400
        Height = 84
        Caption = ' Colors '
        TabOrder = 0
        object lblSFSColor: TLabel
          Left = 18
          Top = 53
          Width = 79
          Height = 13
          Caption = 'FullScreen color:'
        end
        object lblSWinColor: TLabel
          Left = 18
          Top = 24
          Width = 68
          Height = 13
          Caption = 'Window color:'
        end
        object pkrColor: TColorPickerButton
          Left = 254
          Top = 20
          Width = 125
          Height = 22
          CustomText = 'Custom'
          DefaultText = 'Default'
          Flat = True
          PopupSpacing = 8
          SelectionColor = clAppWorkSpace
          ShowSystemColors = False
        end
        object pkrFSColor: TColorPickerButton
          Left = 254
          Top = 49
          Width = 125
          Height = 22
          CustomText = 'Custom'
          DefaultText = 'Default'
          Flat = True
          PopupSpacing = 8
          ShowSystemColors = False
        end
      end
    end
    object shtFormats: TTabSheet
      Caption = 'File Formats'
      ImageIndex = 2
      object lblExtensions: TLabel
        Left = 10
        Top = 10
        Width = 56
        Height = 13
        Caption = 'Extensions:'
      end
      object gbxIcon: TGroupBox
        Left = 227
        Top = 19
        Width = 175
        Height = 85
        Caption = ' Select icon '
        TabOrder = 0
        object imgIcon1: TImage
          Left = 12
          Top = 35
          Width = 32
          Height = 32
          OnClick = imgIcon1Click
        end
        object imgIcon2: TImage
          Left = 52
          Top = 35
          Width = 32
          Height = 32
          OnClick = imgIcon2Click
        end
        object imgIcon3: TImage
          Left = 92
          Top = 35
          Width = 32
          Height = 32
          OnClick = imgIcon3Click
        end
        object imgIcon4: TImage
          Left = 132
          Top = 35
          Width = 32
          Height = 32
          OnClick = imgIcon4Click
        end
        object rbnIcon1: TRadioButton
          Left = 10
          Top = 18
          Width = 18
          Height = 17
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rbnIcon1Click
        end
        object rbnIcon2: TRadioButton
          Left = 51
          Top = 18
          Width = 18
          Height = 17
          TabOrder = 1
          OnClick = rbnIcon2Click
        end
        object rbnIcon3: TRadioButton
          Left = 91
          Top = 18
          Width = 16
          Height = 17
          TabOrder = 2
          OnClick = rbnIcon3Click
        end
        object rbnIcon4: TRadioButton
          Left = 131
          Top = 18
          Width = 17
          Height = 17
          TabOrder = 3
          OnClick = rbnIcon4Click
        end
      end
      object btnRefresh: TButton
        Left = 135
        Top = 196
        Width = 75
        Height = 25
        Caption = 'Refresh'
        TabOrder = 1
        OnClick = btnRefreshClick
      end
      object btnSelectAll: TButton
        Left = 135
        Top = 24
        Width = 75
        Height = 25
        Caption = 'Select All'
        TabOrder = 2
        OnClick = btnSelectAllClick
      end
      object btnSelectNone: TButton
        Left = 135
        Top = 52
        Width = 75
        Height = 25
        Caption = 'Select None'
        TabOrder = 3
        OnClick = btnSelectNoneClick
      end
      object clbExt: TCheckListBox
        Left = 10
        Top = 24
        Width = 121
        Height = 197
        ItemHeight = 13
        TabOrder = 4
      end
    end
    object shtMisc: TTabSheet
      Caption = 'Misc'
      ImageIndex = 3
      object lblRestoreWinIconViewer: TLabel
        Left = 10
        Top = 60
        Width = 178
        Height = 13
        Cursor = crHandPoint
        Caption = 'Restore Windows default icon viewer'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHotLight
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsUnderline]
        ParentColor = False
        ParentFont = False
        Transparent = True
        OnClick = lblRestoreWinIconViewerClick
      end
      object lblChangeFormatsDescription: TLabel
        Left = 10
        Top = 80
        Width = 222
        Height = 13
        Cursor = crHandPoint
        Caption = 'Change Futuris Imager file formats description'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHotLight
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsUnderline]
        ParentFont = False
        Transparent = True
        OnClick = lblChangeFormatsDescriptionClick
      end
      object lblClearMRU: TLabel
        Left = 10
        Top = 110
        Width = 97
        Height = 13
        Cursor = crHandPoint
        Caption = 'Clear recent files list'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHotLight
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsUnderline]
        ParentFont = False
        Transparent = True
        OnClick = lblClearMRUClick
      end
      object lblScanForNewPlugins: TLabel
        Left = 10
        Top = 10
        Width = 159
        Height = 13
        Cursor = crHandPoint
        Caption = 'Scan for new or updated plug-ins'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHotLight
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsUnderline]
        ParentFont = False
        Transparent = True
        OnClick = lblScanForNewPluginsClick
      end
      object lblOpenCustomPluginsFolder: TLabel
        Left = 10
        Top = 30
        Width = 134
        Height = 13
        Cursor = crHandPoint
        Caption = 'Open custom plug-ins folder'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHotLight
        Font.Height = -11
        Font.Name = 'MS Shell Dlg 2'
        Font.Style = [fsUnderline]
        ParentFont = False
        Transparent = True
        OnClick = lblOpenCustomPluginsFolderClick
      end
    end
  end
end
