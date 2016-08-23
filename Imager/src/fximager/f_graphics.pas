// graphics routines
unit f_graphics;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms,
  ImageEnIO, c_const, c_utils, c_reg, c_locales;

procedure OpenImage();
procedure Reopen();
procedure Save();
procedure CloseImage(turn_off_ui: boolean = true);
procedure Load(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
function  DoImageLoad(path: string): HBITMAP;
function  DoPreviewLoad(path: string): HBITMAP;
function  Write(path: string): BOOL;
procedure OpenLocal(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
procedure OpenUntitled(bmp: TBitmap; img: hBitmap = 0);
function  SupportedExt(ext: string):boolean;
function  FileType(path: string):integer;
function  IsSupported(filename: string):boolean;
function  GetTypeString(ext: string; default: string = ''):string;
function  IsSupportedRole(role: string): boolean;
procedure ExecuteRole(role: string);


implementation

uses main, f_plugins, f_ui, f_tools, f_nav, f_images, f_anim, f_multi;

// starts open process
procedure OpenImage();
begin
	if ((infImage.image_type <> itUnsaved) and (infImage.image_type <> itNone)) then
  		frmMain.dlgOpen.InitialDir := ExtractFileDir(infImage.path)
	else
  		begin
  		reg.OpenKey(sSettings, true);
  		frmMain.dlgOpen.InitialDir := reg.RStr('OpenPath', '');
  		reg.CloseKey();
        end;

	if frmMain.dlgOpen.Execute() then
  		begin
  		reg.OpenKey(sSettings, true);
  		reg.WriteString('OpenPath', ExtractFileDir(frmMain.dlgOpen.FileName));
  		reg.CloseKey();

  		Load(frmMain.dlgOpen.FileName);
  		end;
end;

// reloads image
procedure Reopen();
var
	tmp: string;
begin
	if ((infImage.image_type <> itUnsaved) and (infImage.image_type <> itNone)) then
  		begin
  		tmp := infImage.path;

  		CloseImage();
  		Load(tmp);
  		end;
end;

// starts saving process
procedure Save();
var
	tmp: string;
	res: BOOL;
begin
	SetSaveDialog();

    if frmMain.dlgSave.Execute() then
  		begin
  		res := Write(frmMain.dlgSave.FileName);

        reg.OpenKey(sSettings, true);
        reg.WInteger('SaveDialog_FilterSize', Length(frmMain.dlgSave.Filter));
        reg.WInteger('SaveDialog_FilterIndex', frmMain.dlgSave.FilterIndex);
        reg.CloseKey();

  		if frmMain.bOpenAfterSave then
    		begin
    		if (res and IsSupported(frmMain.dlgSave.FileName)) then
      			begin
      			tmp := frmMain.dlgSave.FileName;
      			CloseImage();
      			Load(tmp);
      			end;
            end;
  		end;
end;

// closes file
procedure CloseImage(turn_off_ui: boolean = true);
begin
	frmMain.img.Proc.ClearAllUndo();

	// specific things
	case infImage.image_type of
  		itNone: FillImage('', itNone);
  		itNormal: FillImage('', itNone);
  		itAnimated: CloseAnim();
  		itMulti: CloseMulti();
 		end;

  	// nullifying
	frmMain.img.Blank();

    if turn_off_ui then
  		Able();
end;

// loads file from given path
procedure Load(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
begin
	// start
	case FileType(path) of
  		1:
        	begin
    		CloseImage(false);
    		OpenLocal(path, add_to_mru, same_folder);
    		end;
  		3:
        	begin
    		CloseImage(false);
    		OpenAnim(path, add_to_mru, same_folder);
   			end;
  		4:
        	begin
    		CloseImage(false);
    		OpenMulti(path, add_to_mru, same_folder);
    		end;
  		5:
        	begin
    		CloseImage();
    		ShowMessage(LoadLStr(620));
    		end;
    else
        begin
    	CloseImage();
        OpenLocal(path, add_to_mru);
        end;
  	end;
end;

function DoImageLoad(path: string):hBitmap;
var
	FxImgOpen: TFxImgOpen;
	bmp: hBitmap;
	lib: THandle;
	ext, lib_path: string;
    tmp_res: TFxImgResult;
begin
    Result := 0;

	if not FileExists(path) then
  		begin
  		FileNotFound(path);
  		Abort();
  		end;

	ext := LowerCase(ExtractExt(path));
	reg.OpenKey(sModules + '\' + PS_FOPEN, true);
	lib_path := reg.RStr(ext, '');
	reg.CloseKey();

	// main stuff
	if ((lib_path <> '') and (lib_path <> sInternalFormat)) then
  		begin
  		lib := LoadLibrary(PChar(lib_path));
  		if (lib <> 0) then
    		begin
    		@FxImgOpen := GetProcAddress(lib, EX_OPENPLAIN);
    		if (@FxImgOpen <> nil) then
      			begin
                tmp_res := FxImgOpen(PChar(path), PChar(ext), Application.Handle, frmMain.Handle, FxImgGlobalCallback);

                if (tmp_res.result_type = RT_HBITMAP) then
      				bmp := tmp_res.result_value
                else
                	bmp := 0;

      			if (bmp <> 0) then
        			Result := bmp;
      			end;

    		FreeLibrary(lib);
    		end;
  		end;
end;

function DoPreviewLoad(path: string): HBITMAP;
var
	FxImgOpen: TFxImgOpen;
    io: TImageEnIO;
	bmp: hBitmap;
	lib: THandle;
	ext, lib_path: string;
    is_raw, is_jbig, is_magick: boolean;
    tmp_res: TFxImgResult;
begin
    Result := 0;

	if not FileExists(path) then
  		begin
  		FileNotFound(path);
  		Abort();
  		end;

	ext := LowerCase(ExtractExt(path));
	reg.OpenKey(sModules + '\' + PS_FOPEN, true);
	lib_path := reg.RStr(ext, '');
	reg.CloseKey();

	// main stuff
	if ((lib_path <> '') and (lib_path <> sInternalFormat)) then
  		begin
  		lib := LoadLibrary(PChar(lib_path));
  		if (lib <> 0) then
    		begin
    		@FxImgOpen := GetProcAddress(lib, EX_OPENPLAIN);
    		if (@FxImgOpen <> nil) then
      			begin
                tmp_res := FxImgOpen(PChar(path), PChar(ext), Application.Handle, frmMain.Handle, FxImgGlobalCallback);

                if (tmp_res.result_type = RT_HBITMAP) then
      				bmp := tmp_res.result_value
                else
                	bmp := 0;

      			if (bmp <> 0) then
        			Result := bmp;
      			end;

    		FreeLibrary(lib);
    		end;
  		end;

   if (Result = 0) then
    	begin
        // internal formats
    	is_raw := (	(ext = 'crw') or (ext = 'cr2') or (ext = 'dng') or (ext = 'nef') or
        			(ext = 'raw') or (ext = 'raf') or (ext = 'x3f') or (ext = 'orf') or
                    (ext = 'srf') or (ext = 'mrw') or (ext = 'dcr') or (ext = 'bay') or (ext = 'pef'));

    	is_jbig := ((ext = 'jbg') or (ext = 'jbig') or (ext = 'bie'));

    	is_magick := ((ext = 'dcm') or (ext = 'dicom') or (ext = 'cut') or (ext = 'avs') or
        			(ext = 'cin') or (ext = 'dot') or (ext = 'dpx') or (ext = 'fits') or
                    (ext = 'fpx') or (ext = 'mat') or (ext = 'miff') or (ext = 'mtv') or
                    (ext = 'palm') or (ext = 'pict') or (ext = 'pix') or (ext = 'pwp') or
                    (ext = 'rla') or (ext = 'sgi') or (ext = 'sun') or (ext = 'svg') or
                    (ext = 'ttf') or (ext = 'vicar') or (ext = 'viff') or (ext = 'xcf'));

    	if ((not init_raw) and is_raw and (FileExists(path_app + FN_ADDRAW))) then
            begin
            IEFileFormatRemove(ioRAW);
    		IEAddExtIOPlugIn(path_app + FN_ADDRAW);

            init_raw := true;
            end;

    	if ((not init_jbig) and is_jbig and (FileExists(path_app + FN_ADDJBIG))) then
        	begin
    		IEAddExtIOPlugIn(path_app + FN_ADDJBIG);

            init_jbig := true;
            end;

    	if ((not init_magick) and is_magick and (FileExists(path_app + FN_ADDMAGICK))) then
        	begin
    		IEAddExtIOPlugIn(path_app + FN_ADDMAGICK);

            init_magick := true;
            end;
        end;

    if (Result = 0) then
    	begin
        // guessing the format
        io := TImageEnIO.Create(nil);
        io.Params.JPEG_DCTMethod := ioJPEG_IFAST;

        try
        	io.LoadFromFile(path);

        	if io.Aborting then
        		io.LoadFromFileAuto(path);

            except
            	io.Aborting := true;
            end;

        if not io.Aborting and not io.IEBitmap.IsEmpty then
        	Result := io.IEBitmap.VclBitmap.ReleaseHandle();

        FreeAndNil(io);
        end;
end;

// saves file
function Write(path: string): BOOL;
var
	FxImgSave: TFxImgSave;
	lib: THandle;
	ext, lib_path: string;
	res: integer;
    bim: TBitmap;
    tmp_res: TFxImgResult;
begin
	// start
	ext := ExtractFileExt(path);
	ext := LowerCase(ext);
	Result := FALSE;

	Delete(ext, 1, 1);
	reg.OpenKey(sModules + '\' + PS_FSAVE, true);
	lib_path := reg.RStr(ext, '');
	reg.CloseKey();

	// main stuff
	if (lib_path <> '') then
  		begin
  		lib := LoadLibrary(PChar(lib_path));

  		if (lib <> 0) then
    		begin
    		@FxImgSave := GetProcAddress(lib, EX_SAVE);
    		if (@FxImgSave <> nil) then
      			begin
                bim := TBitmap.Create();
                bim.Assign(frmMain.img.IEBitmap.VclBitmap);
                bim.PixelFormat := pf24bit;

                tmp_res := FxImgSave(PChar(path), PChar(ext), bim.ReleaseHandle(), Application.Handle, frmMain.Handle, FxImgGlobalCallback);

                if (tmp_res.result_type = RT_BOOL) then
                	res := tmp_res.result_value
                else
                	res := 0;

                FreeAndNil(bim);

     			if (res <> 0) then
        			frmMain.img.Proc.ClearAllUndo();

      			Result := (res = FX_TRUE);
      			end;

            FreeLibrary(lib);
    		end;
  		end;
end;

// opens local file
procedure OpenLocal(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
var
	bmp: HBITMAP;
    ext: string;
    is_raw, is_jbig, is_magick: boolean;
begin
    ext := LowerCase(ExtractExt(path));
	bmp := DoImageLoad(path);

    if (bmp <> 0) then
  		begin
  		// loading
  		FillImage(path, itNormal);
  		FillBitmap(nil, bmp);

  		if add_to_mru then
        	frmMain.MRU.Add(path);

        if not same_folder then
      		ScanFolder(path)
        else
      		FindFileNumber();

        FinalizeImage();
        Able();
    	end
    else
    	begin
        // internal formats
    	is_raw := (	(ext = 'crw') or (ext = 'cr2') or (ext = 'dng') or (ext = 'nef') or
        			(ext = 'raw') or (ext = 'raf') or (ext = 'x3f') or (ext = 'orf') or
                    (ext = 'srf') or (ext = 'mrw') or (ext = 'dcr') or (ext = 'bay') or (ext = 'pef'));
    	is_jbig := ((ext = 'jbg') or (ext = 'jbig') or (ext = 'bie'));
    	is_magick := ((ext = 'dcm') or (ext = 'dicom') or (ext = 'cut') or (ext = 'avs') or
        			(ext = 'cin') or (ext = 'dot') or (ext = 'dpx') or (ext = 'fits') or
                    (ext = 'fpx') or (ext = 'mat') or (ext = 'miff') or (ext = 'mtv') or
                    (ext = 'palm') or (ext = 'pict') or (ext = 'pix') or (ext = 'pwp') or
                    (ext = 'rla') or (ext = 'sgi') or (ext = 'sun') or (ext = 'svg') or
                    (ext = 'ttf') or (ext = 'vicar') or (ext = 'viff') or (ext = 'xcf'));

    	if ((not init_raw) and is_raw and (FileExists(path_app + FN_ADDRAW))) then
            begin
            IEFileFormatRemove(ioRAW);
    		IEAddExtIOPlugIn(path_app + FN_ADDRAW);

            init_raw := true;
            end;

    	if ((not init_jbig) and is_jbig and (FileExists(path_app + FN_ADDJBIG))) then
        	begin
    		IEAddExtIOPlugIn(path_app + FN_ADDJBIG);

            init_jbig := true;
            end;

    	if ((not init_magick) and is_magick and (FileExists(path_app + FN_ADDMAGICK))) then
        	begin
    		IEAddExtIOPlugIn(path_app + FN_ADDMAGICK);

            init_magick := true;
            end;

        frmMain.img.IO.Params.JPEG_DCTMethod := ioJPEG_IFAST;

        try
        	frmMain.img.IO.LoadFromFile(path);

        	if frmMain.img.IO.Aborting then
        		frmMain.img.IO.LoadFromFileAuto(path);

            except
            	frmMain.img.IO.Aborting := true;
            end;

        if not frmMain.img.IO.Aborting then
        	begin
  			//24-bits?
            infImage.path := path;
			infImage.image_type := itNormal;

            Header();

  			if add_to_mru then
        		frmMain.MRU.Add(path);

        	if not same_folder then
      			ScanFolder(path)
        	else
      			FindFileNumber();

            FinalizeImage();
            Able();
            end;
        end;
end;

procedure OpenUntitled(bmp: TBitmap; img: hBitmap = 0);
begin
	CloseImage(false);

	if (img <> 0) then
  		begin
  		// loading from hBitmap
  		FillBitmap(nil, img);
  		FillImage('', itUnsaved);
        FinalizeImage();
  		Able();
  		end
	else
 		begin
  		// loading from TBitmap
  		if (bmp <> nil) then
    		begin
    		FillBitmap(bmp);
            FillImage('', itUnsaved);
            FinalizeImage();
    		Able();
    		end;
  		end;
end;

// finds out if supported by FOpen
function SupportedExt(ext: string):boolean;
begin
	reg.OpenKey(sModules + '\' + PS_FOPEN, true);

	if reg.RStr(ext, '') <> '' then
  		Result := true
	else
  		Result := false;

	reg.CloseKey();
end;

// finds out file type
function FileType(path: string):integer;
begin
	Result := 0;                                                	// not supported

    if IsAnimation(ExtractExt(path)) then Result := 3               	// animation
  		else if IsMulti(ExtractExt(path)) then Result := 4            	// multi-page
    		else if SupportedExt(ExtractExt(path)) then Result := 1     // normal
      			else if not FileExists(path) then Result := 5;      // not exists
end;

// finds out file type
function IsSupported(filename: string):boolean;
begin
	Result := false;

	case FileType(filename) of
  		1, 3, 4: Result := true;
  	end;
end;

// returns file type string or ''
function GetTypeString(ext: string; default: string = ''):string;
begin
	reg.OpenKey(sModules + '\' + PS_FDESCR, true);
	Result := reg.RStr(ext, default);
	reg.CloseKey();
end;

function IsSupportedRole(role: string): boolean;
var
	lr: TFRegistry;
begin
    Result := false;
    
    lr := TFRegistry.Create(RA_READONLY);

	if lr.OpenKey(sModules + '\' + PS_FROLE, false) then
    	begin
        Result := (lr.RStr(role, '') <> '');

        lr.CloseKey();
        end;

    FreeAndNil(lr);
end;

procedure ExecuteRole(role: string);
var
	lr: TFRegistry;
    lib_path: string;
begin
    lib_path := '';

    lr := TFRegistry.Create(RA_READONLY);

	if lr.OpenKey(sModules + '\' + PS_FROLE, false) then
    	begin
        lib_path := lr.RStr(role, '');
        lr.CloseKey();
        end;

    FreeAndNil(lr);

    if (lib_path <> '') then
    	begin
        if ((role = PR_SCAN) or (role = PR_CAPTURE)) then
            frmMain.DoHandleFImport(lib_path, role) 		// importer roles
        else if ((role = PR_JPEGLL) or (role = PR_HEX) or (role = PR_EMAIL)) then
            frmMain.DoHandleFTool(lib_path, role); 			// tool roles
        end;
end;

end.
