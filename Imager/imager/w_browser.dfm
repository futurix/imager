object frmFile: TfrmFile
  Left = 190
  Top = 105
  Align = alClient
  BorderStyle = bsNone
  Caption = 'File Browser'
  ClientHeight = 466
  ClientWidth = 185
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
  object shlTree: TShellTreeView
    Left = 0
    Top = 0
    Width = 185
    Height = 466
    AutoContextMenus = False
    ObjectTypes = [otFolders, otNonFolders, otHidden]
    Root = 'rfMyComputer'
    UseShellImages = True
    Align = alClient
    AutoRefresh = False
    Indent = 19
    ParentColor = False
    RightClickSelect = True
    ShowButtons = False
    ShowLines = False
    ShowRoot = False
    TabOrder = 0
    OnDblClick = shlTreeDblClick
    OnKeyDown = shlTreeKeyDown
  end
end
