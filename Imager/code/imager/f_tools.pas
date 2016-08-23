// tool routines
unit f_tools;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms, ShellAPI,
  c_const, c_utils;

procedure PrintImage(fast: boolean = false);
procedure CommandLine();
procedure PlugScan();
procedure FileNotFound(path: string);
procedure CheckLibrariesDependancies();
procedure Report(what: string; priority: integer = 1);
procedure ExecInFolder(what: string);
function  GetAppFolder(with_slash: boolean = true):string;


implementation

uses globals, main, w_show, f_graphics, f_ui, f_nav,
     f_filectrl, f_reg, f_scan, w_setup;

// print with preview
procedure PrintImage(fast: boolean = false);
var
	DoPrint: TFHelpPrint;
	lib: THandle;
	bmp: TBitmap;
begin
	// starting the stuff
	lib := 0;

	try
		lib := LoadLibrary('img_helper.dll');

		if (lib = 0) then
  			Application.MessageBox('Cannot load Futuris Imager Helper DLL!', 'Error!', MB_OK + MB_ICONERROR)
		else
  			begin
  			@DoPrint := GetProcAddress(lib, 'FHelpPrint');

  			if not (@DoPrint = nil) then
    			begin
    			bmp := TBitmap.Create();
    			bmp.Assign(frmMain.img.IEBitmap.VclBitmap);
    			bmp.PixelFormat := pf24bit;

    			DoPrint(Application.Handle, bmp.ReleaseHandle(), PChar(infImage.path), fast);

    			FreeAndNil(bmp);
    			end;
  			end;
	finally
    	FreeLibrary(lib);
    end;
end;

// reads command line
procedure CommandLine();
var
	i: integer;
	already_loaded: boolean;
begin
	already_loaded := false;

    for i := 1 to ParamCount() do
  		begin
  		// Parsing params
  		if FileExists(ParamStr(i)) then
    		begin
    		if already_loaded = false then
      			begin
      			// loading file
      			already_loaded := true;
      			Load(ParamStr(i));
      			end;
    		end
  		else
    		begin
            if ((ParamStr(i) = '/fs') or (ParamStr(i) = '-fs')) then
        		if not infSettings.full_screen then
          			ToggleFS();
            if ((ParamStr(i) = '/unreg') or (ParamStr(i) = '-unreg')) then
               	begin
				Application.CreateForm(TfrmSetup, frmSetup);
				frmSetup.btnSelectNone.Click();
				frmSetup.Uninstall();
        		FreeAndNil(frmSetup);

            	UpdateAssociations();
        		Application.ShowMainForm:=false;
        		Application.Terminate();
                end;
   			end;
  		end;
end;

// scans for plug-ins
procedure PlugScan();
begin
	DoScan();
end;

// do something if file not found
procedure FileNotFound(path: string);
begin
	if (frmMain.MRU.Files.IndexOf(path) <> -1) then
  		begin
  		frmMain.MRU.Files.Delete(frmMain.MRU.Files.IndexOf(path));

  		if (infImage.filenum > -1) then
    		Dec(infImage.filenum);
  		end;

	if (files.IndexOf(path) <> -1) then
  		begin
  		files.Delete(files.IndexOf(path));

  		if (infImage.filenum > -1) then
    		Dec(infImage.filenum);

  		if (files.Count > 0) then
    		GoNext();
  		end;
end;

// checks for libraries existance (and warns about missing ones)
procedure CheckLibrariesDependancies();
begin
	if not FileExists(GetAppFolder() + 'img_helper.dll') then
  		begin
  		frmMain.tbnPrint.Visible := false;
  		frmMain.miPrint.Visible := false;
  		frmMain.miPrintPreview.Visible := false;
  		frmMain.Sep_1.Free();
  		end;
end;

// error report
procedure Report(what: string; priority: integer = 1);
begin
	case priority of
  		1:
        	begin
     		// normal (default)
     		Application.MessageBox(PChar(what), 'Futuris Imager', MB_OK + MB_ICONINFORMATION);
     		end;
  		2:
        	begin
     		// critical
     		Application.MessageBox(PChar(what), 'Futuris Imager', MB_OK + MB_ICONERROR);
     		end;
  		3:
        	begin
     		// fatal (with exit)
     		Application.MessageBox(PChar(what), 'Futuris Imager', MB_OK + MB_ICONERROR);
     		Application.Terminate();
     		end;
    end;
end;

// executes file in Imager's folder
procedure ExecInFolder(what: string);
var
	tmp: string;
begin
	tmp:=GetAppFolder() + what;
	ShellExecute(Application.Handle, 'open', PChar(tmp), nil, nil, SW_SHOWNORMAL);
end;

// returns application folder with/without trailing slash
function GetAppFolder(with_slash: boolean = true):string;
begin
	if with_slash then
  		Result := Slash(ExtractFileDir(Application.ExeName))
	else
  		Result := NoSlash(ExtractFileDir(Application.ExeName))
end;

end.
