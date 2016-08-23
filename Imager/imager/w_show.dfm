object frmShow: TfrmShow
  Left = 190
  Top = 105
  BorderStyle = bsToolWindow
  Caption = 'Slide Show'
  ClientHeight = 25
  ClientWidth = 215
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
  object tbrShow: TToolBar
    Left = 0
    Top = 0
    Width = 215
    Height = 26
    AutoSize = True
    BorderWidth = 1
    Caption = 'Slide Show'
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
      ImageIndex = 24
      ParentShowHint = False
      ShowHint = True
      OnClick = tbnStartClick
    end
    object tbnStop: TToolButton
      Left = 23
      Top = 0
      Hint = 'Stop|Stop slide show'
      Caption = 'tbnStop'
      ImageIndex = 26
      ParentShowHint = False
      ShowHint = True
      OnClick = tbnStopClick
    end
    object Sep_1: TToolButton
      Left = 46
      Top = 0
      Width = 8
      Caption = 'Sep_1'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object tbnReverse: TToolButton
      Left = 54
      Top = 0
      Hint = 'Reverse|Reverse direction'
      Caption = 'tbnReverse'
      ImageIndex = 28
      ParentShowHint = False
      ShowHint = True
      OnClick = tbnReverseClick
    end
    object Sep_2: TToolButton
      Left = 77
      Top = 0
      Width = 8
      Caption = 'Sep_2'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object pnlTimer: TPanel
      Left = 85
      Top = 0
      Width = 49
      Height = 22
      BevelOuter = bvNone
      Caption = 'Timer:'
      TabOrder = 1
    end
    object edtTimer: TEdit
      Left = 134
      Top = 0
      Width = 54
      Height = 22
      Hint = 'Advance time|Delay between 2 images display ( in seconds )'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = '10'
    end
    object tbnSet: TToolButton
      Left = 188
      Top = 0
      Hint = 'Set|Change timer value'
      Caption = 'Set'
      ImageIndex = 20
      ParentShowHint = False
      ShowHint = True
      OnClick = tbnSetClick
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = TimerTimer
    Top = 29
  end
end
