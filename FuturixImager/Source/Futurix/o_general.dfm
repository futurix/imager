object fraOptGeneral: TfraOptGeneral
  Left = 0
  Top = 0
  Width = 503
  Height = 414
  TabOrder = 0
  DesignSize = (
    503
    414)
  object lblFormatOptions: TLabel
    Left = 0
    Top = 3
    Width = 109
    Height = 13
    Caption = 'File Format Options'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblMisc: TLabel
    Left = 0
    Top = 68
    Width = 79
    Height = 13
    Caption = 'Miscellaneous'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblClearMRU: TLabel
    Left = 0
    Top = 156
    Width = 97
    Height = 13
    Caption = 'Clear recent files list'
    OnClick = lblClearMRUClick
  end
  object cbxEnableCMS: TCheckBox
    Left = 20
    Top = 22
    Width = 460
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Enable color management'
    TabOrder = 0
  end
  object cbxAutoRotateEXIF: TCheckBox
    Left = 20
    Top = 45
    Width = 460
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Auto-rotate photos based on EXIF data'
    TabOrder = 1
  end
  object cbxDisableMRU: TCheckBox
    Left = 20
    Top = 87
    Width = 460
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Disable recent files list'
    TabOrder = 2
  end
  object cbxFullPathInTitle: TCheckBox
    Left = 20
    Top = 110
    Width = 460
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Show full file path in window title'
    TabOrder = 3
  end
  object cbxAllowMulti: TCheckBox
    Left = 20
    Top = 133
    Width = 460
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Allow multiple program instances'
    TabOrder = 4
  end
end
