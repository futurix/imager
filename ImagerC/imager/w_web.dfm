object frmWeb: TfrmWeb
  Left = 192
  Top = 107
  Width = 448
  Height = 75
  BorderStyle = bsSizeToolWin
  Caption = 'Web'
  Color = clBtnFace
  Constraints.MaxHeight = 100
  Constraints.MinHeight = 75
  Constraints.MinWidth = 300
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblAddress: TLabel
    Left = 3
    Top = 4
    Width = 38
    Height = 13
    Anchors = [akLeft]
    Caption = 'Address'
    Transparent = True
  end
  object sbnGo: TSpeedButton
    Left = 384
    Top = 1
    Width = 54
    Height = 21
    Hint = 'Click to load image'
    Anchors = [akRight]
    Caption = 'Go'
    Flat = True
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      0800000000000001000000000000000000000001000000000000000000004000
      000080000000FF000000002000004020000080200000FF200000004000004040
      000080400000FF400000006000004060000080600000FF600000008000004080
      000080800000FF80000000A0000040A0000080A00000FFA0000000C0000040C0
      000080C00000FFC0000000FF000040FF000080FF0000FFFF0000000020004000
      200080002000FF002000002020004020200080202000FF202000004020004040
      200080402000FF402000006020004060200080602000FF602000008020004080
      200080802000FF80200000A0200040A0200080A02000FFA0200000C0200040C0
      200080C02000FFC0200000FF200040FF200080FF2000FFFF2000000040004000
      400080004000FF004000002040004020400080204000FF204000004040004040
      400080404000FF404000006040004060400080604000FF604000008040004080
      400080804000FF80400000A0400040A0400080A04000FFA0400000C0400040C0
      400080C04000FFC0400000FF400040FF400080FF4000FFFF4000000060004000
      600080006000FF006000002060004020600080206000FF206000004060004040
      600080406000FF406000006060004060600080606000FF606000008060004080
      600080806000FF80600000A0600040A0600080A06000FFA0600000C0600040C0
      600080C06000FFC0600000FF600040FF600080FF6000FFFF6000000080004000
      800080008000FF008000002080004020800080208000FF208000004080004040
      800080408000FF408000006080004060800080608000FF608000008080004080
      800080808000FF80800000A0800040A0800080A08000FFA0800000C0800040C0
      800080C08000FFC0800000FF800040FF800080FF8000FFFF80000000A0004000
      A0008000A000FF00A0000020A0004020A0008020A000FF20A0000040A0004040
      A0008040A000FF40A0000060A0004060A0008060A000FF60A0000080A0004080
      A0008080A000FF80A00000A0A00040A0A00080A0A000FFA0A00000C0A00040C0
      A00080C0A000FFC0A00000FFA00040FFA00080FFA000FFFFA0000000C0004000
      C0008000C000FF00C0000020C0004020C0008020C000FF20C0000040C0004040
      C0008040C000FF40C0000060C0004060C0008060C000FF60C0000080C0004080
      C0008080C000FF80C00000A0C00040A0C00080A0C000FFA0C00000C0C00040C0
      C00080C0C000FFC0C00000FFC00040FFC00080FFC000FFFFC0000000FF004000
      FF008000FF00FF00FF000020FF004020FF008020FF00FF20FF000040FF004040
      FF008040FF00FF40FF000060FF004060FF008060FF00FF60FF000080FF004080
      FF008080FF00FF80FF0000A0FF0040A0FF0080A0FF00FFA0FF0000C0FF0040C0
      FF0080C0FF00FFC0FF0000FFFF0040FFFF0080FFFF00FFFFFF00E1E1E1E10000
      00E1E1E1E1E1E1E1E1E1E1E1E1003000E1E1E1E1E1E1E1E1E1E1E1E12C3900E1
      E1E1E1E1E1E1E1E1E1E1E1E12C3D00E1E1E1E1E1E1E1E1E1E1E1E1E12C3D00E1
      E1E1E100E1E1E1E1E1E1E1E12CDE00E1E1E1E10000E1E1E1E1E1E1E12CFF3900
      E1E1E1003000E1E1E1E1E1E1E12CDE3900000000393000E1E1E1E1E1E12CFFDE
      3D30303939393000E1E1E1E1E1E12CFFFFDE3D3D3D3D393000E1E1E1E1E1E12C
      2CFFFFFFDE3D3D00E1E1E1E1E1E1E1E1E12C2C2CFFDE00E1E1E1E1E1E1E1E1E1
      E1E1E12CFF00E1E1E1E1E1E1E1E1E1E1E1E1E12C00E1E1E1E1E1E1E1E1E1E1E1
      E1E1E12CE1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1E1}
    ParentShowHint = False
    ShowHint = True
    OnClick = sbnGoClick
  end
  object edtURL: TEdit
    Left = 44
    Top = 1
    Width = 337
    Height = 21
    Hint = 'Type image URL here'
    Anchors = [akLeft, akRight]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    Text = 'http://'
    OnKeyDown = edtURLKeyDown
  end
  object tbrWeb: TToolBar
    Left = 0
    Top = 24
    Width = 440
    Height = 24
    Align = alBottom
    AutoSize = True
    ButtonWidth = 64
    Caption = 'Web ToolBar'
    Flat = True
    Images = frmMain.imlMain
    List = True
    ShowCaptions = True
    TabOrder = 1
    Wrapable = False
    object tbnRefresh: TToolButton
      Left = 0
      Top = 0
      Hint = 'Reload image'
      AutoSize = True
      Caption = 'Refresh'
      ImageIndex = 41
      ParentShowHint = False
      ShowHint = True
      OnClick = tbnRefreshClick
    end
    object Sep_1: TToolButton
      Left = 68
      Top = 0
      Width = 8
      Caption = 'Sep_1'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object pnlSTimer: TPanel
      Left = 76
      Top = 0
      Width = 47
      Height = 22
      BevelOuter = bvNone
      Caption = 'Timer:'
      TabOrder = 0
    end
    object pnlEdit: TPanel
      Left = 123
      Top = 0
      Width = 66
      Height = 22
      BevelOuter = bvNone
      TabOrder = 1
      object edtTime: TEdit
        Left = 3
        Top = 1
        Width = 59
        Height = 21
        Hint = 'Auto-reload time'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = '60'
      end
    end
    object tbnStart: TToolButton
      Left = 189
      Top = 0
      Hint = 'Start auto-reload mode'
      AutoSize = True
      Caption = 'Start'
      ImageIndex = 24
      ParentShowHint = False
      ShowHint = True
      OnClick = tbnStartClick
    end
    object tbnStop: TToolButton
      Left = 242
      Top = 0
      Hint = 'Stop auto-reload mode'
      AutoSize = True
      Caption = 'Stop'
      ImageIndex = 26
      ParentShowHint = False
      ShowHint = True
      OnClick = tbnStopClick
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = TimerTimer
    Left = 304
    Top = 20
  end
end
