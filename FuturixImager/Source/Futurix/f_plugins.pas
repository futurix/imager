unit f_plugins;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Dialogs, Forms, Menus,
  ComCtrls, c_const, c_reg, c_utils;

procedure InstallPlugIns();
procedure UpdatePlugIns();
procedure SetDialogs();
procedure SetSaveDialog();


implementation

uses w_main, f_graphics, f_images, f_ui, f_tools;

// adds plug-ins from ini
procedure InstallPlugIns();
var
  c: integer;
  i: TMenuItem;
  s: TStringList;
begin
  // setting sun
  SetDialogs();

  // the beginning
  s := TStringList.Create();

  s.Clear();
  s.AddStrings(fx.Plugins.ListImport());

  if (s.Count > 0) then
    begin
    s.Sort();
    frmMain.mImport.Clear();

    for c := 0 to (s.Count - 1) do
      begin
      i := TMenuItem.Create(nil);
      i.Caption := s.Strings[c];
      i.Hint := s.Strings[c];
      i.OnClick := frmMain.HandleFImport;
      frmMain.mImport.Add(i);
      end;

    frmMain.mImport.Enabled := true;
    end;

  // setting FExport
  s.Clear();
  s.AddStrings(fx.Plugins.ListExport());

  if (s.Count > 0) then
    begin
    s.Sort();
    frmMain.mExport.Clear();

    for c := 0 to (s.Count - 1) do
      begin
      i := TMenuItem.Create(nil);
      i.Caption := s.Strings[c];
      i.Hint := s.Strings[c];
      i.OnClick := frmMain.HandleFExport;
      frmMain.mExport.Add(i);
      end;

    frmMain.mExport.Enabled := true;
    end;

  // setting FTool
  s.Clear();
  s.AddStrings(fx.Plugins.ListTool());

  if (s.Count > 0) then
    begin
    s.Sort();

    for c := (s.Count - 1) downto 0 do
      begin
      i := TMenuItem.Create(nil);
      i.Caption := s.Strings[c];
      i.Hint := s.Strings[c];
      i.OnClick := frmMain.HandleFTool;
      frmMain.mTools.Insert(0, i);
      end;
    end;

  // separator
  if (frmMain.mTools.Count > 1) then
    begin
    i := TMenuItem.Create(nil);
    i.Caption := '-';
    frmMain.mTools.Insert(
        frmMain.mTools.IndexOf(frmMain.miOptions), i);
    end;

  // cleaning
  i := TMenuItem.Create(nil);
  FreeAndNil(s);
  FreeAndNil(i);

  // setting roles
  infRoles.capture := IsSupportedRole(PR_CAPTURE);
  infRoles.scan := IsSupportedRole(PR_SCAN);
  infRoles.jpegll := IsSupportedRole(PR_JPEGLL);

  // optimizing menus
  frmMain.mImport.Visible := (frmMain.mImport.Count > 0);
  frmMain.mExport.Visible := (frmMain.mExport.Count > 0);
  frmMain.N14.Visible := (frmMain.mImport.Visible or frmMain.mExport.Visible);
end;

// updates all plug-ins from ini
procedure UpdatePlugIns();
var
  i: integer;
begin
  // cleaning
  frmMain.mImport.Clear();
  frmMain.mExport.Clear();

  for i := (frmMain.mTools.Count - 1) downto 0 do
    begin
    if (frmMain.mTools.Items[i].Tag <> 7) then
        frmMain.mTools.Delete(i);
    end;

  // now installing plug-ins
  InstallPlugIns();
  Able();
end;

// sets open and save dialogs
procedure SetDialogs();
var
  h: TStringList;
  i: integer;
  s, t_d: string;
begin
  h := TStringList.Create();
  h.AddStrings(fx.Plugins.ListOpen());
  s := '';

  if (h.Count > 0) then
    begin
    h.Sort();

    // default filter is "*.*"
    for i := 0 to (h.Count - 1) do
      begin
      t_d := fx.Plugins.FindFormatDescription(h.Strings[i]);

      if (t_d = '') then
        t_d := ('*.' + h.Strings[i])
      else
        t_d := (t_d + ' (*.' + h.Strings[i] + ')');

      s := s + t_d + '|' + '*.' + h.Strings[i];

      if (i <> (h.Count-1)) then
        s := s + '|';
      end;

    s := 'All files (*.*)|*.*|' + s;
    frmMain.dlgOpen.Filter := s;
    end;

  // temp clearing
  frmMain.SaveExtensions.Clear();
  frmMain.SaveExtensions.AddStrings(fx.Plugins.ListSave());
  s := '';
  t_d := '';

  if (frmMain.SaveExtensions.Count > 0) then
    begin
    frmMain.SaveExtensions.Sort();

    for i := 0 to (frmMain.SaveExtensions.Count - 1) do
      begin
      t_d := fx.Plugins.FindFormatDescription(frmMain.SaveExtensions.Strings[i]);

      if (t_d = '') then
        t_d := ('*.' + frmMain.SaveExtensions.Strings[i])
      else
        t_d := (t_d + ' (*.' + frmMain.SaveExtensions.Strings[i] + ')');

      s:= s + t_d + '|' + '*.' + frmMain.SaveExtensions.Strings[i];

      if (i <> (frmMain.SaveExtensions.Count - 1)) then
        s := s + '|';
      end;

    frmMain.dlgSave.Filter := s;
    end;

  // final
  FreeAndNil(h);

  // setting MRU
  if frmMain.bNoMRU then
    begin
    // disabling
    frmMain.mRecent.Visible := false;
    frmMain.tbnLast.Enabled := false;
    frmMain.mru.ClearItems(true);
    frmMain.tbnOpen.DropdownMenu := frmMain.popNoMRU;
    end
  else
    begin
    // enabling
    frmMain.mRecent.Visible := true;
    frmMain.tbnLast.Enabled := true;
    frmMain.tbnOpen.Style := tbsDropDown;
    frmMain.tbnOpen.DropdownMenu := frmMain.popMRU;
    end;
end;

// sets default filename and extension for saving images
procedure SetSaveDialog();
var
  tmp, ext: string;
begin
  if FileExists(infImage.path) then
    frmMain.dlgSave.InitialDir := ExtractFileDir(infImage.path);

  if (IsPresent() and not IsUnsaved()) then
    begin
    tmp := ExtractFileName(infImage.path);
    ext := ExtractFileExt(infImage.path);
    Delete(tmp, Pos(ext, tmp), Length(ext));
    frmMain.dlgSave.FileName := tmp;
    end
  else
    frmMain.dlgSave.FileName := 'Untitled';

  // selecting extension
  if (FxRegRInt('SaveDialog_FilterSize', 0) = Length(frmMain.dlgSave.Filter)) then
    frmMain.dlgSave.FilterIndex := FxRegRInt('SaveDialog_FilterIndex', 1)
  else
    frmMain.dlgSave.FilterIndex := 1;

  frmMain.dlgSaveTypeChange(frmMain);
end;

end.
