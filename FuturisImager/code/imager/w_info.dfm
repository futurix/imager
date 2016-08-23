object frmInfo: TfrmInfo
  Left = 190
  Top = 105
  ActiveControl = btnOK
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'File Information'
  ClientHeight = 343
  ClientWidth = 442
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
    Left = 363
    Top = 311
    Width = 73
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object lvwInfo: TListView
    Left = 7
    Top = 7
    Width = 429
    Height = 300
    Columns = <
      item
        Caption = 'Keys'
        Width = -1
        WidthType = (
          -1)
      end
      item
        Caption = 'Values'
        Width = -1
        WidthType = (
          -1)
      end>
    ColumnClick = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
end
