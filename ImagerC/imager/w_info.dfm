object frmInfo: TfrmInfo
  Left = 192
  Top = 107
  ActiveControl = btnOK
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'File Information'
  ClientHeight = 177
  ClientWidth = 322
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
  object lblPath: TLabel
    Left = 8
    Top = 8
    Width = 25
    Height = 13
    Caption = 'Path:'
    Transparent = True
  end
  object lblDimensions: TLabel
    Left = 8
    Top = 48
    Width = 57
    Height = 13
    Caption = 'Dimensions:'
    Transparent = True
  end
  object lblModDimensions: TLabel
    Left = 112
    Top = 48
    Width = 84
    Height = 13
    Caption = 'Mod. Dimensions:'
    Transparent = True
  end
  object bvlSep: TBevel
    Left = 8
    Top = 136
    Width = 305
    Height = 2
  end
  object lblSize: TLabel
    Left = 8
    Top = 88
    Width = 40
    Height = 13
    Caption = 'File size:'
  end
  object lblStamp: TLabel
    Left = 144
    Top = 88
    Width = 72
    Height = 13
    Caption = 'File time stamp:'
  end
  object btnOK: TButton
    Left = 240
    Top = 144
    Width = 73
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = btnOKClick
  end
  object edtPath: TEdit
    Left = 8
    Top = 24
    Width = 305
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 1
  end
  object edtDims: TEdit
    Left = 8
    Top = 64
    Width = 86
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 2
  end
  object edtModDims: TEdit
    Left = 112
    Top = 64
    Width = 83
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 3
  end
  object btnAdditional: TButton
    Left = 8
    Top = 144
    Width = 150
    Height = 25
    Caption = 'Additional Information'
    TabOrder = 4
    Visible = False
    OnClick = btnAdditionalClick
  end
  object edtSize: TEdit
    Left = 8
    Top = 104
    Width = 121
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 5
  end
  object edtStamp: TEdit
    Left = 144
    Top = 104
    Width = 169
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 6
  end
end
