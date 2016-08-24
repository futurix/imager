unit o_formatsxp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ComCtrls, StdCtrls,
  c_utils, c_const;

type
  TfraOptFormatsXP = class(TFrame)
    lvwFormats: TListView;
    sbxCommands: TScrollBox;
    btnNone: TButton;
    btnAll: TButton;
    cbxRare: TCheckBox;
    procedure cbxRareClick(Sender: TObject);
    procedure btnAllClick(Sender: TObject);
    procedure btnNoneClick(Sender: TObject);
  private
  public
    procedure Init();
    procedure Load();
    procedure Reload();
    procedure Save();
    procedure Cancelled();
  end;


implementation

uses w_options, w_main, fx_formats_legacy;

{$R *.dfm}

procedure TfraOptFormatsXP.btnAllClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to (lvwFormats.Items.Count - 1) do
    lvwFormats.Items[i].Checked := true;
end;

procedure TfraOptFormatsXP.btnNoneClick(Sender: TObject);
var
  i: integer;
begin
  for i := 0 to (lvwFormats.Items.Count - 1) do
    lvwFormats.Items[i].Checked := false;
end;

procedure TfraOptFormatsXP.cbxRareClick(Sender: TObject);
begin
  Reload();
end;

//TODO: show registered rare formats without looking at the checkbox's setting
procedure TfraOptFormatsXP.Init();
var
  exts: TStringList;
  ext: string;
  item: TListItem;
begin
  exts := fx.Plugins.ListOpen();

  lvwFormats.Items.BeginUpdate();
  lvwFormats.Items.Clear();

  for ext in exts do
    begin
    if (cbxRare.Checked or not fx.Plugins.IsRareFormat(ext)) then
      begin
      item := lvwFormats.Items.Add();
      item.Caption := ext;
      item.SubItems.Add(fx.Plugins.FindFormatDescription(ext));
      item.Checked := GetExt(ext);
      end;
    end;

  // column sizes
  lvwFormats.Column[0].Width := -1;
  if (lvwFormats.Column[0].Width < 100) then
    lvwFormats.Column[0].Width := 100;
  lvwFormats.Column[1].Width :=
    lvwFormats.Width - lvwFormats.Column[0].Width -
    GetSystemMetrics(SM_CXVSCROLL) - GetSystemMetrics(SM_CXEDGE) * 4;

  lvwFormats.Items.EndUpdate();

  FreeAndNil(exts);
end;

procedure TfraOptFormatsXP.Load();
begin
  Init();
end;

procedure TfraOptFormatsXP.Reload();
begin
  Init();
end;

//TODO: do this only if something changed
procedure TfraOptFormatsXP.Save();
var
  i: integer;
begin
  // safety first
  if IsVista() then
    Exit();

  // handler
  WriteHandlers();

  // registering formats
  for i := 0 to (lvwFormats.Items.Count - 1) do
    begin
    if lvwFormats.Items[i].Checked then
      SetExt(lvwFormats.Items[i].Caption)
    else
      if GetExt(lvwFormats.Items[i].Caption) then
        UnsetExt(lvwFormats.Items[i].Caption);
    end;

  // updating stuff
  UpdateAssociations();
end;

procedure TfraOptFormatsXP.Cancelled();
begin
  //
end;

end.
