object frmScan: TfrmScan
  Left = 192
  Top = 107
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Futuris Imager'
  ClientHeight = 22
  ClientWidth = 236
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlStatus: TPanel
    Left = 0
    Top = 0
    Width = 236
    Height = 22
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Scanning for plug-ins...'
    TabOrder = 0
  end
  object fsrScan: TFileSearch
    OnFileFind = fsrScanFileFind
    Left = 5
    Top = 9
  end
end
