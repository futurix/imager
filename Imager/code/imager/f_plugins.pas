// plug-ins manipulation routines
unit f_plugins;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Dialogs, Forms, Menus,
  ComCtrls, c_const, c_utils;

procedure InstallPlugIns();
procedure UpdatePlugIns();
procedure SetDialogs();
function  HandleFilter(name: string):boolean;
function  HandleFilterPreview(name: string):HBITMAP;
procedure SetSaveDialog();


implementation

uses globals, main, f_graphics, f_images, f_reg, f_ui, f_tools;

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

	reg.OpenKey(sModules + '\Import', true);
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

	reg.OpenKey(sModules + '\Export', true);
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

	reg.OpenKey(sModules + '\Tools', true);
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
end;

// updates all plug-ins from ini
procedure UpdatePlugIns();
var
	tmp: boolean;
begin
	tmp := (infImage.path <> '');

	// cleaning
	frmMain.mImport.Clear();
	frmMain.mExport.Clear();

	while
    	(frmMain.mTools.Count > 1)
    do
    	frmMain.mTools.Delete(0);

	// now installing plug-ins
	InstallPlugIns();
	Able(tmp);
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
	reg.OpenKey(sModules + '\Descr', true);
	reg.GetValueNames(d);
	reg.CloseKey();

	// open dialog
	reg.OpenKey(sModules + '\Open', true);
	reg.GetValueNames(h);
	reg.CloseKey();

    h.Sort();

	reg.OpenKey(sModules + '\Descr', true);

	if (h.Count > 0) then
  		begin
  		if (opOpenDef in infSettings.options) then
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

    		s := ('All files (*.*)|*.*|' + s);

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

    		s := (s + '|All files (*.*)|*.*');

    		frmMain.dlgOpen.Filter := s;
    		end;
 		end;

	reg.CloseKey();

	// temp clearing
	h.Clear();
	s := '';
	t_d := '';

	// save dialog
	reg.OpenKey(sModules + '\Save', true);
	reg.GetValueNames(h);
	reg.CloseKey();

	reg.OpenKey(sModules + '\Descr', true);

	if (h.Count > 0) then
  		begin
  		for i := 0 to (h.Count - 1) do
    		begin
   			t_d := reg.RStr(h.Strings[i], '');

    		if t_d = '' then
      			t_d := ('*.' + h.Strings[i]);

    		s:= s + t_d + '|' + '*.' + h.Strings[i];

    		if (i <> (h.Count - 1)) then
      			s := s + '|';
    		end;

  		frmMain.dlgSave.Filter := s;
  		end;

	reg.CloseKey();

	// final
	FreeAndNil(d);
	FreeAndNil(h);


    // setting MRU
    if (opNoMRU in infSettings.options) then
    	begin
        // disabling
        frmMain.mRecent.Visible := false;
        frmMain.miReopen.Visible := false;
        frmMain.tbnLast.Visible := false;
        frmMain.MRU.Files.Clear();
		frmMain.tbnOpen.DropdownMenu := frmMain.popNoMRU;
		end
    else
    	begin
        // enabling
        frmMain.mRecent.Visible := true;
        frmMain.miReopen.Visible := true;
		frmMain.tbnLast.Visible := true;
		frmMain.tbnOpen.Style := tbsDropDown;
		frmMain.tbnOpen.DropdownMenu := frmMain.popMRU;
		end;
end;

// handles filters
function HandleFilter(name: string):boolean;
var
	FFilter: TFFilter;
	lib: THandle;
	func_result: hBitmap;
	image, bim: TBitmap;
begin
	// starting the stuff
	lib := 0;
	Result := false;

	try
  		reg.OpenKey(sModules + '\Filters', true);
  		lib := LoadLibrary(PChar(reg.RStr(name, '')));
  		reg.CloseKey();

  		if (lib = 0) then
    		Application.MessageBox('Cannot load filter DLL!', 'Error!', MB_OK + MB_ICONERROR)
  		else
    		begin
    		@FFilter := GetProcAddress(lib, 'FFilter');

    		if not (@FFilter = nil) then
      			begin
      			image := TBitmap.Create();
      			image.Assign(frmMain.img.IEBitmap.VclBitmap);
      			image.PixelFormat := pf24bit;

      			func_result := FFilter(PChar(name), false, Application.Handle, frmMain.Handle, image.ReleaseHandle());

      			if (func_result <> 0) then
        			begin
        			// start working with result
        			Result := true;

					bim := TBitmap.Create();
        			bim.Handle := func_result;
        			bim.PixelFormat := pf24bit;

        			frmMain.img.Proc.SaveUndo();

        			frmMain.img.IEBitmap.Assign(bim);
        			frmMain.img.Repaint();

        			FreeAndNil(bim);
        			end;

      			FreeAndNil(image);
      			end;
    		end;
	finally
  		FreeLibrary(lib);
	end;
end;

// handles filters preview
function HandleFilterPreview(name: string):HBITMAP;
var
	FFilter: TFFilter;
	lib: THandle;
	image: TBitmap;
begin
	Result := 0;

	// starting the stuff
	lib := 0;

	try
  		reg.OpenKey(sModules + '\Filters', true);
  		lib := LoadLibrary(PChar(reg.RStr(name, '')));
  		reg.CloseKey();

  		if (lib <> 0)then
    		begin
    		@FFilter := GetProcAddress(lib, 'FFilter');

    		if not (@FFilter = nil) then
      			begin
      			image := TBitmap.Create();
      			image.Assign(frmMain.img.IEBitmap.VclBitmap);
      			image.PixelFormat := pf24bit;

      			Result := FFilter(PChar(name), true, Application.Handle, frmMain.Handle, image.ReleaseHandle());

      			FreeAndNil(image);
      			end;
    		end;
	finally
  		FreeLibrary(lib);
	end;
end;

// sets default filename and extension for saving images
procedure SetSaveDialog();
var
	tmp, ext, last_ext: string;
	s: TStringList;
begin
	if (infImage.file_type <> ftUnsaved) then
  		begin
  		tmp := ExtractFileName(infImage.path);
  		ext := ExtractFileExt(infImage.path);
  		Delete(tmp, Pos(ext, tmp), Length(ext));
  		frmMain.dlgSave.FileName := tmp;
  		end
	else
  		frmMain.dlgSave.FileName := 'Untitled';

    // selecting extension
    s := TStringList.Create();
    reg.OpenKey(sModules + '\Save', true);
    reg.GetValueNames(s);
    reg.CloseKey();

    reg.OpenKey(sReg + '\Main', true);
    last_ext := Trim(reg.RStr('LastSaveExt', ''));
    reg.CloseKey();

    if ((last_ext <> '') and (s.IndexOf(last_ext) <> -1)) then
    	frmMain.dlgSave.DefaultExt := last_ext
    else
    	frmMain.dlgSave.DefaultExt := s.Strings[(frmMain.dlgSave.FilterIndex - 1)];

    FreeAndNil(s);
end;

end.
