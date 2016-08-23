// plug-ins manipulation routines
unit f_plugins;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Dialogs, Forms, Menus,
  ComCtrls, c_const, c_utils, c_locales;

procedure InstallPlugIns();
procedure UpdatePlugIns();
procedure SetDialogs();
procedure SetSaveDialog();


implementation

uses main, f_graphics, f_images, f_ui, f_tools;

// adds plug-ins from ini
procedure InstallPlugIns();
var
	c: integer;
	i: TMenuItem;
	s: TStringList;
begin
	// the beginning
	s := TStringList.Create();

	// setting sun
	SetDialogs();

	// setting FImport
	s.Clear();

	reg.OpenKey(sModules + '\' + PS_FIMPORT, true);
	reg.GetValueNames(s);
	reg.CloseKey();

	s.Sort();
	if (s.Count > 0) then
  		begin
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

	reg.OpenKey(sModules + '\' + PS_FEXPORT, true);
	reg.GetValueNames(s);
	reg.CloseKey();

	s.Sort();

	if (s.Count > 0) then
  		begin
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

	reg.OpenKey(sModules + '\' + PS_FTOOL, true);
	reg.GetValueNames(s);
	reg.CloseKey();

	s.Sort();

	if (s.Count > 0) then
  		begin
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
  		frmMain.mTools.Insert(frmMain.mTools.Count - 1, i);
  		end;

	// freeing
	i := TMenuItem.Create(nil);

	FreeAndNil(s);
	FreeAndNil(i);

    // setting roles
    infRoles.capture := IsSupportedRole(PR_CAPTURE);
    infRoles.scan := IsSupportedRole(PR_SCAN);
    infRoles.email := IsSupportedRole(PR_EMAIL);
    infRoles.hex := IsSupportedRole(PR_HEX);
    infRoles.jpegll := IsSupportedRole(PR_JPEGLL);

    // optimizing menus
    frmMain.mImport.Visible := (frmMain.mImport.Count > 0);
    frmMain.mExport.Visible := (frmMain.mExport.Count > 0);
    frmMain.N14.Visible := (frmMain.mImport.Visible or frmMain.mExport.Visible);
end;

// updates all plug-ins from ini
procedure UpdatePlugIns();
begin
	// cleaning
	frmMain.mImport.Clear();
	frmMain.mExport.Clear();

	while
    	(frmMain.mTools.Count > 2)
    do
    	frmMain.mTools.Delete(0);

	// now installing plug-ins
	InstallPlugIns();
	Able();
end;

// sets open and save dialogs
procedure SetDialogs();
var
	h, d: TStringList;
	i: integer;
	s, t_d: string;
begin
	h := TStringList.Create();
	d := TStringList.Create();
	s := '';

	// common ( descriptions )
	reg.OpenKey(sModules + '\' + PS_FDESCR, true);
	reg.GetValueNames(d);
	reg.CloseKey();

	// open dialog
	reg.OpenKey(sModules + '\' + PS_FOPEN, true);
	reg.GetValueNames(h);
	reg.CloseKey();

    h.Sort();

	reg.OpenKey(sModules + '\' + PS_FDESCR, true);

	if (h.Count > 0) then
  		begin
  		if frmMain.bOpenDef then
    		begin
    		// default filter is "*.*"
    		for i := 0 to (h.Count - 1) do
      			begin
      			t_d := reg.RStr(h.Strings[i], '');

      			if t_d = '' then
        			t_d := ('*.' + h.Strings[i]);

      			s := s + t_d + '|' + '*.' + h.Strings[i];

      			if i<>(h.Count-1) then
        			s := s + '|';
      			end;

    		s := (LoadLStr(408) + ' (*.*)|*.*|' + s);

    		frmMain.dlgOpen.Filter := s;
    		end
  		else
    		begin
    		// default filter is combined one
    		for i := 0 to (h.Count - 1) do
      			begin
      			t_d := reg.RStr(h.Strings[i], '');

      			if t_d = '' then
        			t_d := ('*.' + h.Strings[i]);

      			s := s + t_d + '|' + '*.' + h.Strings[i];

      			if (i <> (h.Count - 1)) then
        			s := s+'|';
     			 end;

    		s := (s + '|' + LoadLStr(408) + ' (*.*)|*.*');

    		frmMain.dlgOpen.Filter := s;
    		end;
 		end;

	reg.CloseKey();

	// temp clearing
	frmMain.SaveExtensions.Clear();
	s := '';
	t_d := '';

	// save dialog
	reg.OpenKey(sModules + '\' + PS_FSAVE, true);
	reg.GetValueNames(frmMain.SaveExtensions);
	reg.CloseKey();

    frmMain.SaveExtensions.Sort();

	reg.OpenKey(sModules + '\' + PS_FDESCR, true);

	if (frmMain.SaveExtensions.Count > 0) then
  		begin
  		for i := 0 to (frmMain.SaveExtensions.Count - 1) do
    		begin
   			t_d := reg.RStr(frmMain.SaveExtensions.Strings[i], '');

    		if t_d = '' then
      			t_d := ('*.' + frmMain.SaveExtensions.Strings[i]);

    		s:= s + t_d + '|' + '*.' + frmMain.SaveExtensions.Strings[i];

    		if (i <> (frmMain.SaveExtensions.Count - 1)) then
      			s := s + '|';
    		end;

  		frmMain.dlgSave.Filter := s;
  		end;

	reg.CloseKey();

	// final
	FreeAndNil(d);
	FreeAndNil(h);


    // setting MRU
    if frmMain.bNoMRU then
    	begin
        // disabling
        frmMain.mRecent.Visible := false;
        frmMain.miReopen.Visible := false;
        frmMain.tbnLast.Enabled := false;
        frmMain.MRU.Files.Clear();
		frmMain.tbnOpen.DropdownMenu := frmMain.popNoMRU;
		end
    else
    	begin
        // enabling
        frmMain.mRecent.Visible := true;
        frmMain.miReopen.Visible := true;
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

	if (((infImage.image_type <> itUnsaved) and (infImage.image_type <> itNone))) then
  		begin
  		tmp := ExtractFileName(infImage.path);
  		ext := ExtractFileExt(infImage.path);
  		Delete(tmp, Pos(ext, tmp), Length(ext));
  		frmMain.dlgSave.FileName := tmp;
  		end
	else
  		frmMain.dlgSave.FileName := LoadLStr(409);

    // selecting extension
    reg.OpenKey(sSettings, true);
    if (reg.RInt('SaveDialog_FilterSize', 0) = Length(frmMain.dlgSave.Filter)) then
        frmMain.dlgSave.FilterIndex := reg.RInt('SaveDialog_FilterIndex', 1)
    else
    	frmMain.dlgSave.FilterIndex := 1;
    reg.CloseKey();

    frmMain.dlgSaveTypeChange(frmMain);
end;

end.
