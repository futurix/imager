object frmShow: TfrmShow
  Left = 190
  Top = 105
  AutoSize = True
  BorderStyle = bsToolWindow
  Caption = 'Slide Show'
  ClientHeight = 30
  ClientWidth = 247
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object tbrShow: TCoolBar
    Left = 0
    Top = 0
    Width = 247
    Height = 30
    AutoSize = True
    BandBorderStyle = bsNone
    BandMaximize = bmNone
    Bands = <
      item
        Control = itbShow
        HorizontalOnly = True
        ImageIndex = -1
        MinHeight = 30
        Width = 247
      end>
    EdgeBorders = []
    FixedOrder = True
    ShowText = False
    object itbShow: TToolBar
      Left = 0
      Top = 0
      Width = 243
      Height = 30
      AutoSize = True
      ButtonHeight = 30
      ButtonWidth = 31
      Caption = 'Slide Show'
      DisabledImages = frmMain.imlDisabled
      EdgeBorders = []
      Flat = True
      Images = frmMain.imlMain
      TabOrder = 0
      Transparent = True
      Wrapable = False
      object tbnStart: TToolButton
        Left = 0
        Top = 0
        Hint = 'Start|Start slide show'
        Caption = 'tbnStart'
        ImageIndex = 15
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnStartClick
      end
      object tbnStop: TToolButton
        Left = 31
        Top = 0
        Hint = 'Stop|Stop slide show'
        Caption = 'tbnStop'
        ImageIndex = 17
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnStopClick
      end
      object Sep_1: TToolButton
        Left = 62
        Top = 0
        Width = 8
        Caption = 'Sep_1'
        ImageIndex = 2
        Style = tbsSeparator
      end
      object tbnReverse: TToolButton
        Left = 70
        Top = 0
        Hint = 'Reverse|Reverse direction'
        Caption = 'tbnReverse'
        ImageIndex = 19
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnReverseClick
      end
      object Sep_2: TToolButton
        Left = 101
        Top = 0
        Width = 8
        Caption = 'Sep_2'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object pnlTimer: TPanel
        Left = 109
        Top = 0
        Width = 49
        Height = 30
        BevelOuter = bvNone
        Caption = 'Timer:'
        TabOrder = 1
      end
      object edtTimer: TEdit
        Left = 158
        Top = 0
        Width = 54
        Height = 30
        Hint = 'Advance time|Delay between 2 images display ( in seconds )'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        Text = '10'
      end
      object tbnSet: TToolButton
        Left = 212
        Top = 0
        Hint = 'Set|Change timer value'
        Caption = 'Set'
        ImageIndex = 27
        ParentShowHint = False
        ShowHint = True
        OnClick = tbnSetClick
      end
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = TimerTimer
    Top = 29
  end
end
