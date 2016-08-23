object frmOptGeneral: TfrmOptGeneral
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 337
  ClientWidth = 472
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
    Left = 306
    Top = 302
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 386
    Top = 302
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object pclOptions: TPageControl
    Left = 10
    Top = 9
    Width = 451
    Height = 285
    ActivePage = shtTasks
    HotTrack = True
    TabOrder = 2
    object shtTasks: TTabSheet
      Caption = 'Tasks'
      ImageIndex = 3
      object sbnFileFormats: TSpeedButton
        Left = 10
        Top = 10
        Width = 420
        Height = 25
        Caption = 'File Formats'
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000120B0000120B00000001000029000000FFFFFF00F7FB
          FF00A5FFFF009CFFFF0094FBFF0094F7FF008CF7FF008CF3FF008CEBFF0084EB
          FF008CE7FF007BE3FF0084DBFF0073DBFF0073D7FF006BD7FF0063D3FF006BCF
          FF0063CBFF005AC7FF0073C7E70052C3F7006BBEEF0042B2DE006BAEDE0031AE
          D60021A6D6005A9ADE00188EB5001886AD004271CE0018799C003961BD003149
          B500083CAD00FF00FF001830AD00182CAD001020A5001820A50008109C000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000232323232323
          2323232323232323232323231F1F1F1F1F1F1F1F1F1F1F1F1F1F231D1A1A1A1A
          1A1A1A1A1A1A1A1A1A1F1C121A030F0F0F0F201E100F19031A1F1C111A030B0B
          0B0B26280D0B17021A1F1C111A03090909202625210917041A1F1C121A020505
          18281614281615031A1F1C0E1A03030A281E0303212413031A1F1C0C1A000000
          0001000001281B001A1F1C090A1A1A1A1A1A1A1A1A22281A1A231C0807070707
          070000000000262723231C0003030303001C1C1C1C1C22262823231C00010100
          1C23232323232328282323231C1C1C1C23232323232323232323232323232323
          2323232323232323232323232323232323232323232323232323}
        Margin = 5
        OnClick = sbnFileFormatsClick
      end
      object sbnPlugins: TSpeedButton
        Left = 10
        Top = 40
        Width = 420
        Height = 25
        Caption = 'Plug-ins'
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000120B0000120B0000000100004C000000FDFCFA00E6F8
          EA00FDF2E600F3ECE400E8E8E700FEEAD600E9E6D800FEE2C700E7DDD300A5E8
          B100D7D7D600FCD8C300FDD7B700E9D3B80058F18500B4CFCE00FDD3A800F9CA
          B90063C5F200F2C8A90054C2F5009DD0A7004CE6730095C4CA00C3CC91005AC0
          D60043B9ED00E5BCA200B1B6C10035B4E700F3BC8700F8B1AB003AD357004AAC
          D50087BD7D00EBB37800D4A59800A4A3A200D9A68500CAA29400169CD3002CC4
          43002F99CF00C49A94009BA08C00A79B930099999900CD9B81004F93C000F7A6
          43000595C900B5948700C6957A00C18E7900768E8E002F8BB2001BB32900B389
          8400E2944600D3925200B88574004BA33700147ABA0013AA1A001578AB00188D
          5300A6746D003D894600106BA700029604002F8A1900666565004F743800227C
          250010579D00FF00FF0000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000004B4B4B474747
          4747474747474747474B4B4B4224242424272B2B2B2B3339474B4B4B3C080507
          07070C0C0C10101B474B4B4B3C08050507070710100C101B474B4B4B35060505
          050D234A3B341013474B4B4B340602050530441D3E401E13474B4B4B2F040202
          1C2A1A2128323611474B4B4B260302020F14122540321711474B4B4B26020646
          3D41192E372A0711474B4B4B26002216202938480C050711474B4B4B26000E16
          1549454507050511474B4B4B260001160A433F1802050511474B4B4B26000001
          2D2C09020B0B1F3C474B4B4B260000000000000031313A474B4B4B4B26000000
          000000002623474B4B4B4B4B262626262626262626474B4B4B4B}
        Margin = 5
        OnClick = sbnPluginsClick
      end
      object sbnLanguages: TSpeedButton
        Left = 10
        Top = 70
        Width = 420
        Height = 25
        Caption = 'Languages'
        Flat = True
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          08000000000000010000120B0000120B00000001000009000000FFFFFF00C0C0
          C00000FF00008080800000800000FF00FF00FF00000080000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000050505050505
          0808080805050505050505050505080807070707080805050505050505080707
          0707070707070805050505050404040408060707070707080505050404040204
          0408060704040404080505040102040204080704040404040805040400010204
          0406040204040404040804040001040606060401020404040408030604040606
          0606070401020404040803060606040406060607060401040408050306040204
          0606070607060401080505030604020204040404060706040805050503000102
          0204040404060707050505050503000101020404040407050505050505050303
          0001010304040505050505050505050503030303050505050505}
        Margin = 5
        OnClick = sbnLanguagesClick
      end
    end
    object shtGeneral: TTabSheet
      Caption = 'General'
      object lblSFSColor: TLabel
        Left = 225
        Top = 180
        Width = 178
        Height = 13
        Caption = 'Background color in full screen mode:'
        Transparent = True
      end
      object lblSWinColor: TLabel
        Left = 10
        Top = 180
        Width = 150
        Height = 13
        Caption = 'Main window background color:'
        Transparent = True
      end
      object lblClearMRU: TLabel
        Left = 10
        Top = 150
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
      object cbxNoMRU: TCheckBox
        Left = 10
        Top = 130
        Width = 420
        Height = 17
        Caption = 'Disable recent file list'
        TabOrder = 0
      end
      object cbxOpenAfterSave: TCheckBox
        Left = 10
        Top = 100
        Width = 420
        Height = 17
        Caption = 'Open resulting image after save'
        Checked = True
        ParentShowHint = False
        ShowHint = False
        State = cbChecked
        TabOrder = 1
      end
      object cbxFullPath: TCheckBox
        Left = 10
        Top = 40
        Width = 420
        Height = 17
        Caption = 'Show full image path in window title'
        TabOrder = 2
      end
      object cbxAllFiles: TCheckBox
        Left = 10
        Top = 80
        Width = 420
        Height = 17
        Caption = 'Show all files in Open dialog by default'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object sbxFSColor: TScrollBox
        Left = 225
        Top = 195
        Width = 175
        Height = 25
        Cursor = crHandPoint
        AutoScroll = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clBlack
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = sbxFSColorClick
      end
      object sbxMainColor: TScrollBox
        Left = 10
        Top = 195
        Width = 175
        Height = 25
        Cursor = crHandPoint
        AutoScroll = False
        BevelKind = bkFlat
        BorderStyle = bsNone
        Color = clAppWorkSpace
        ParentColor = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = sbxMainColorClick
      end
      object cbxFitAll: TCheckBox
        Left = 10
        Top = 10
        Width = 420
        Height = 17
        Caption = 'Enable "Fit All" display mode'
        TabOrder = 6
      end
      object cbxInstance: TCheckBox
        Left = 10
        Top = 60
        Width = 420
        Height = 17
        Caption = 'Allow multiple program instances'
        Checked = True
        State = cbChecked
        TabOrder = 7
      end
    end
    object shtBeh: TTabSheet
      Caption = 'Behavior'
      ImageIndex = 1
      object lblMouseDrag: TLabel
        Left = 245
        Top = 85
        Width = 120
        Height = 13
        Caption = 'On mouse click and drag:'
        Transparent = True
      end
      object lblArrows: TLabel
        Left = 10
        Top = 40
        Width = 100
        Height = 13
        Caption = 'Arrow keys function:'
        Transparent = True
      end
      object lblEnter: TLabel
        Left = 245
        Top = 40
        Width = 101
        Height = 13
        Caption = 'Enter key behaviour:'
        Transparent = True
      end
      object lblWheel: TLabel
        Left = 10
        Top = 85
        Width = 145
        Height = 13
        Caption = 'Mouse wheel default function:'
        Transparent = True
      end
      object lblNewImage: TLabel
        Left = 10
        Top = 150
        Width = 99
        Height = 13
        Caption = 'On new image open:'
        Transparent = True
      end
      object cbxArrows: TComboBox
        Left = 10
        Top = 55
        Width = 175
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 0
        Text = 'File navigation'
        Items.Strings = (
          'File navigation'
          'Image scrolling')
      end
      object cbxEnter: TComboBox
        Left = 245
        Top = 55
        Width = 175
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 1
        Text = 'Switch between display modes'
        Items.Strings = (
          'Switch between display modes'
          'Toggle full screen mode')
      end
      object cbxWheel: TComboBox
        Left = 10
        Top = 100
        Width = 175
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 2
        Text = 'File navigation'
        Items.Strings = (
          'File navigation'
          'Zooming'
          'Image scrolling')
      end
      object cbxMouseDrag: TComboBox
        Left = 245
        Top = 100
        Width = 175
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 3
        Text = 'Scroll image'
        Items.Strings = (
          'Scroll image'
          'Zoom to selected rectangle')
      end
      object cbxNewImage: TComboBox
        Left = 10
        Top = 165
        Width = 410
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 4
        Text = 'Keep previous display state (and zoom to 100% in normal state)'
        Items.Strings = (
          'Keep previous display state (and zoom to 100% in normal state)'
          'Do nothing (keep previous zoom and display state)'
          'Set display state to "Fit Big"'
          'Set display state to "Fit All"'
          'Set display state to "Normal" and reset zoom to 100%'
          'Set display state to "Normal" and keep previous zoom')
      end
      object cbxDblClick: TCheckBox
        Left = 10
        Top = 10
        Width = 420
        Height = 17
        Caption = 'Switch to full screen mode on image double click'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object cbxReverseWheel: TCheckBox
        Left = 10
        Top = 125
        Width = 175
        Height = 17
        Caption = 'Reverse direction'
        TabOrder = 6
      end
    end
    object shtPerformance: TTabSheet
      Caption = 'Performance'
      ImageIndex = 2
      object lblWarning: TLabel
        Left = 10
        Top = 50
        Width = 420
        Height = 49
        AutoSize = False
        Caption = 
          'It is not recommended to combine high quality display filter wit' +
          'h progressive image loading'
        Transparent = True
        WordWrap = True
      end
      object lblWarnRAM: TLabel
        Left = 10
        Top = 170
        Width = 420
        Height = 48
        AutoSize = False
        Caption = 
          'Do not use this option if computer has less then 1Gb of RAM and ' +
          'you are viewing huge images'
        Transparent = True
        WordWrap = True
      end
      object cbxHighQ: TCheckBox
        Left = 10
        Top = 30
        Width = 420
        Height = 17
        Caption = 'Use slower high quality display filter'
        TabOrder = 0
      end
      object cbxDelayHighQ: TCheckBox
        Left = 10
        Top = 100
        Width = 420
        Height = 17
        Caption = 'Delay display filter on image scrolling'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object cbxCMS: TCheckBox
        Left = 10
        Top = 120
        Width = 420
        Height = 17
        Caption = 'Enable search for embedded color profiles'
        TabOrder = 2
      end
      object cbxUseMemory: TCheckBox
        Left = 10
        Top = 150
        Width = 420
        Height = 17
        Caption = 'Load all images directly into memory'
        TabOrder = 3
      end
      object cbxProgress: TCheckBox
        Left = 10
        Top = 10
        Width = 420
        Height = 17
        Caption = 'Progressive image loading (may slow down image opening)'
        TabOrder = 4
      end
    end
  end
end
