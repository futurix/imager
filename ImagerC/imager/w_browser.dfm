object frmFile: TfrmFile
  Left = 192
  Top = 107
  Width = 177
  Height = 386
  ActiveControl = lbxFiles
  BorderStyle = bsSizeToolWin
  Caption = 'File Browser'
  Color = clBtnFace
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
  object splFile: TSplitter
    Left = 0
    Top = 121
    Width = 169
    Height = 3
    Cursor = crVSplit
    Align = alTop
    AutoSnap = False
    ResizeStyle = rsUpdate
  end
  object pnlDrives: TPanel
    Left = 0
    Top = 0
    Width = 169
    Height = 24
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object cbxDrives: TDriveComboBox
      Left = 1
      Top = 2
      Width = 167
      Height = 19
      Anchors = [akLeft, akTop, akRight]
      DirList = lbxDir
      TabOrder = 0
    end
  end
  object lbxDir: TDirectoryListBox
    Left = 0
    Top = 24
    Width = 169
    Height = 97
    Align = alTop
    FileList = lbxFiles
    ItemHeight = 16
    TabOrder = 1
  end
  object lbxFiles: TFileListBox
    Left = 0
    Top = 124
    Width = 169
    Height = 235
    Align = alClient
    ItemHeight = 16
    PopupMenu = popFiles
    ShowGlyphs = True
    TabOrder = 2
    OnDblClick = lbxFilesDblClick
  end
  object popFiles: TPopupMenu
    Left = 136
    Top = 46
    object piCustomMask: TMenuItem
      Caption = 'Set Custom Mask'
      OnClick = piCustomMaskClick
    end
  end
end
