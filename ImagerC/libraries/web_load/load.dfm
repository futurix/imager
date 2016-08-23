object frmLoad: TfrmLoad
  Left = 192
  Top = 107
  ActiveControl = btnCancel
  BorderStyle = bsDialog
  Caption = 'Downloading...'
  ClientHeight = 25
  ClientWidth = 311
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblCurrent: TLabel
    Left = 83
    Top = 6
    Width = 137
    Height = 13
    Caption = 'Starting download process... '
  end
  object btnCancel: TButton
    Left = 0
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Cancel'
    Default = True
    TabOrder = 0
    OnClick = btnCancelClick
  end
  object http: THttpCli
    ProxyPort = '80'
    Agent = 'Mozilla/3.0 (compatible)'
    Accept = 'image/gif, image/jpeg, image/pjpeg, image/png'
    NoCache = False
    ContentTypePost = 'application/x-www-form-urlencoded'
    MultiThreaded = False
    OnDocBegin = httpDocBegin
    OnDocData = httpDocData
    OnDocEnd = httpDocEnd
    OnRequestDone = httpRequestDone
    Left = 5
    Top = 83
  end
end
