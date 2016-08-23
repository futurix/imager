unit f_scan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, ShellAPI,
  c_reg, c_utils, c_const;

var
	mod_folder: string = '';
	current_dll: string = '';

procedure DoScan();
procedure ProcessLib(filename: string);
function  SortData(module_type: integer; value1, value2: PChar):BOOL; cdecl;
procedure WriteData(key, value1: string; value2: string = ' ');
procedure WriteLocale(name: string);
procedure WriteTheme(name: string);


implementation

uses globals, main, f_tools, ComObj;

procedure DoScan();
begin
	// recreating registry keys
    RegDeleteKeyIncludingSubkeys(HKEY_CURRENT_USER, sModules);

	// going through locations
	if DirExists(path_app) then
  		begin
  		mod_folder := NoSlash(path_app);
  		ScanFolderRecF(NoSlash(path_app), '*.dll', @ProcessLib);
  		mod_folder := '';
  		end;

	if DirExists(path_profile) then
  		begin
  		mod_folder := NoSlash(path_profile);
  		ScanFolderRecF(NoSlash(path_profile), '*.dll', @ProcessLib);
  		mod_folder := '';
  		end;
end;

procedure ProcessLib(filename: string);
var
	lib: THandle;
	supp: TFQuery;
    tmp: string;
begin
	lib := LoadLibrary(PChar(filename));

    if (lib <> 0) then
  		begin
        current_dll := filename;

        if (LoadResString(lib, 1) = sLocaleID) then
        	begin
            // library is compatible locale
            tmp := LoadResString(lib, 2);

            if (Trim(tmp) <> '') then
                WriteLocale(tmp);
            end
        else if (LoadResString(lib, 3) = sThemeID) then
        	begin
            // library is compatible theme
            tmp := LoadResString(lib, 4);

            if (Trim(tmp) <> '') then
                WriteTheme(tmp);
            end
        else if (GetProcAddress(lib, 'FQuery') <> nil) then
    		begin
            // library is compatible plug-in
    		@supp := GetProcAddress(lib, 'FQuery');
    		supp(PChar(current_dll), SortData, HInstance);
    		end;

        current_dll := '';
  		FreeLibrary(lib);
  		end;
end;

function SortData(module_type: integer; value1, value2: PChar):BOOL;
begin
	Result := true;

    // working
	case module_type of
  		PT_FOPEN: 		WriteData('Open', 	 String(value1), String(value2));
  		PT_FOPENMULTI: 	WriteData('Multi',	 String(value1), String(value2));
  		PT_FOPENANIM: 	WriteData('Anim', 	 String(value1), String(value2));
  		PT_FSAVE: 		WriteData('Save', 	 String(value1), String(value2));
  		PT_FIMPORT: 	WriteData('Import',  String(value1));
  		PT_FEXPORT: 	WriteData('Export',  String(value1));
  		PT_FFILTER: 	WriteData('Filters', String(value1));
  		PT_FINFO: 		WriteData('Info', 	 String(value1));
  		PT_FTOOL: 		WriteData('Tools', 	 String(value1));
  	else
    	Result := false;
  	end;
end;

procedure WriteData(key, value1: string; value2: string = ' ');
begin
	reg.OpenKey(sModules + '\' + key, true);
    reg.WString(value1, current_dll);
    reg.CloseKey();

    if ((Trim(value2) <> '') and (value2 <> '')) then
    	begin
        reg.OpenKey(sModules + '\Descr', true);
        reg.WString(value1, value2);
        reg.CloseKey();
        end;
end;

procedure WriteLocale(name: string);
begin
	reg.OpenKey(sModules + '\Locales', true);
    reg.WString(name, current_dll);
    reg.CloseKey();
end;

procedure WriteTheme(name: string);
begin
	reg.OpenKey(sModules + '\Themes', true);
    reg.WString(name, current_dll);
    reg.CloseKey();
end;

end.
