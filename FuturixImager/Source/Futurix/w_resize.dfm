object frmResize: TfrmResize
  Left = 190
  Top = 79
  ActiveControl = btnOK
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Resize Image'
  ClientHeight = 178
  ClientWidth = 248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Shell Dlg 2'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  PopupMode = pmAuto
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object btnOK: TButton
    Left = 85
    Top = 146
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 166
    Top = 146
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = btnCancelClick
  end
  object cbxProportions: TCheckBox
    Left = 6
    Top = 122
    Width = 235
    Height = 17
    Caption = 'Save proportions'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object pclType: TPageControl
    Left = 6
    Top = 6
    Width = 235
    Height = 113
    ActivePage = shtSize
    HotTrack = True
    TabOrder = 0
    object shtSize: TTabSheet
      Caption = 'Size'
      object lblWidth: TLabel
        Left = 10
        Top = 13
        Width = 32
        Height = 13
        Caption = 'Width:'
        Transparent = True
      end
      object lblHeight: TLabel
        Left = 10
        Top = 48
        Width = 35
        Height = 13
        Caption = 'Height:'
        Transparent = True
      end
      object lblPixels: TLabel
        Left = 175
        Top = 32
        Width = 27
        Height = 13
        Caption = 'pixels'
        Transparent = True
      end
      object edtSizeH: TEdit
        Left = 69
        Top = 45
        Width = 75
        Height = 21
        TabOrder = 2
        Text = '1'
        OnChange = edtSizeHChange
      end
      object edtSizeW: TEdit
        Left = 69
        Top = 10
        Width = 75
        Height = 21
        TabOrder = 0
        Text = '1'
        OnChange = edtSizeWChange
      end
      object updSizeW: TUpDown
        Left = 144
        Top = 10
        Width = 16
        Height = 21
        TabOrder = 1
        Wrap = True
        OnChangingEx = updSizeWChangingEx
      end
      object updSizeH: TUpDown
        Left = 144
        Top = 45
        Width = 16
        Height = 21
        TabOrder = 3
        Wrap = True
        OnChangingEx = updSizeHChangingEx
      end
    end
    object shtScale: TTabSheet
      Caption = 'Scale'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblPercent: TLabel
        Left = 175
        Top = 32
        Width = 11
        Height = 13
        Caption = '%'
        Transparent = True
      end
      object lblHeightS: TLabel
        Left = 10
        Top = 48
        Width = 35
        Height = 13
        Caption = 'Height:'
        Transparent = True
      end
      object lblWidthS: TLabel
        Left = 10
        Top = 13
        Width = 32
        Height = 13
        Caption = 'Width:'
        Transparent = True
      end
      object edtScaleH: TEdit
        Left = 69
        Top = 45
        Width = 75
        Height = 21
        TabOrder = 2
        Text = '1'
        OnChange = edtScaleHChange
      end
      object edtScaleW: TEdit
        Left = 69
        Top = 10
        Width = 75
        Height = 21
        TabOrder = 0
        Text = '1'
        OnChange = edtScaleWChange
      end
      object updScaleW: TUpDown
        Left = 144
        Top = 10
        Width = 16
        Height = 21
        TabOrder = 1
        Wrap = True
        OnChangingEx = updScaleWChangingEx
      end
      object updScaleH: TUpDown
        Left = 144
        Top = 45
        Width = 16
        Height = 21
        TabOrder = 3
        Wrap = True
        OnChangingEx = updScaleHChangingEx
      end
    end
    object shtMethod: TTabSheet
      Caption = 'Method'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblMethod: TLabel
        Left = 10
        Top = 13
        Width = 40
        Height = 13
        Caption = 'Method:'
        Transparent = True
      end
      object cmbQuality: TComboBox
        Left = 69
        Top = 10
        Width = 145
        Height = 21
        AutoDropDown = True
        Style = csDropDownList
        ItemHeight = 0
        ItemIndex = 0
        TabOrder = 0
        Text = 'Bicubic'
        Items.Strings = (
          'Bicubic'
          'Bilinear'
          'FastLinear'
          'Linear'
          'Nearest'
          'Mitchell'
          'Lanczos3'
          'BSpline'
          'Bell'
          'Hermite'
          'Triangle'
          'None')
      end
    end
  end
end
