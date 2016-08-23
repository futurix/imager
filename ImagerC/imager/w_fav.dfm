object frmFav: TfrmFav
  Left = 192
  Top = 107
  Width = 197
  Height = 342
  ActiveControl = lvwFavs
  BorderStyle = bsSizeToolWin
  Caption = 'Favorites'
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
  object lvwFavs: TListView
    Left = 0
    Top = 22
    Width = 189
    Height = 293
    Align = alClient
    BorderWidth = 2
    Columns = <>
    HotTrackStyles = [htHandPoint]
    HoverTime = 5000
    ParentShowHint = False
    ShowColumnHeaders = False
    ShowHint = False
    SmallImages = frmMain.imlMain
    SortType = stText
    TabOrder = 0
    ViewStyle = vsList
    OnClick = lvwFavsClick
    OnDblClick = lvwFavsDblClick
  end
  object tbrFav: TToolBar
    Left = 0
    Top = 0
    Width = 189
    Height = 22
    AutoSize = True
    Caption = 'Tools'
    EdgeBorders = []
    Flat = True
    Images = frmMain.imlMain
    TabOrder = 1
    Wrapable = False
    object tbnAdd: TToolButton
      Left = 0
      Top = 0
      Hint = 'Add|Add to favorites'
      Caption = 'Add'
      ImageIndex = 34
      ParentShowHint = False
      ShowHint = True
      OnClick = tbnAddClick
    end
    object ToolButton3: TToolButton
      Left = 23
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object tbnRename: TToolButton
      Left = 31
      Top = 0
      Hint = 'Modify|Modify favorite'
      Caption = 'Rename'
      ImageIndex = 35
      ParentShowHint = False
      ShowHint = True
      OnClick = tbnRenameClick
    end
    object tbnDelete: TToolButton
      Left = 54
      Top = 0
      Hint = 'Delete|Delete favorite'
      Caption = 'Delete'
      ImageIndex = 36
      ParentShowHint = False
      ShowHint = True
      OnClick = tbnDeleteClick
    end
  end
end
