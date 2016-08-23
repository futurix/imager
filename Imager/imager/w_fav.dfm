object frmFav: TfrmFav
  Left = 190
  Top = 105
  ActiveControl = lvwFavs
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Favorites'
  ClientHeight = 315
  ClientWidth = 189
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
    Top = 36
    Width = 189
    Height = 279
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
    Height = 36
    AutoSize = True
    BorderWidth = 1
    ButtonHeight = 30
    ButtonWidth = 31
    Caption = 'Tools'
    DisabledImages = frmMain.imlDisabled
    Flat = True
    Images = frmMain.imlMain
    TabOrder = 1
    Transparent = True
    Wrapable = False
    object tbnAdd: TToolButton
      Left = 0
      Top = 0
      Hint = 'Add|Add to favorites'
      Caption = 'Add'
      ImageIndex = 29
      ParentShowHint = False
      ShowHint = True
      OnClick = tbnAddClick
    end
    object ToolButton3: TToolButton
      Left = 31
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object tbnRename: TToolButton
      Left = 39
      Top = 0
      Hint = 'Modify|Modify favorite'
      Caption = 'Rename'
      ImageIndex = 30
      ParentShowHint = False
      ShowHint = True
      OnClick = tbnRenameClick
    end
    object tbnDelete: TToolButton
      Left = 70
      Top = 0
      Hint = 'Delete|Delete favorite'
      Caption = 'Delete'
      ImageIndex = 31
      ParentShowHint = False
      ShowHint = True
      OnClick = tbnDeleteClick
    end
  end
end
