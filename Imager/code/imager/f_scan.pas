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
function  SortData(module_type: integer; value1, value2: PChar):BOOL; stdcall;
procedure WriteData(key, value1: string; value2: string = ' ');


implementation

uses globals, main, f_tools;

procedure DoScan();
var
	current_folder: string;
begin
	// recreating registry keys
	reg.OpenKey(sModules,true);

	reg.DeleteKey('Open');
	reg.DeleteKey('Save');
	reg.DeleteKey('Import');
	reg.DeleteKey('Export');
	reg.DeleteKey('Filters');
	reg.DeleteKey('Tools');
	reg.DeleteKey('Descr');
	reg.DeleteKey('Multi');
	reg.DeleteKey('Anim');
	reg.DeleteKey('Info');

	reg.CreateKey('Open');
	reg.CreateKey('Save');
	reg.CreateKey('Import');
	reg.CreateKey('Export');
	reg.CreateKey('Filters');
	reg.CreateKey('Tools');
	reg.CreateKey('Descr');
	reg.CreateKey('Multi');
	reg.CreateKey('Anim');
	reg.CreateKey('Info');

	reg.CloseKey();

	// looping through locations
	current_folder := NoSlash(GetAppFolder());

	if DirExists(current_folder) then
  		begin
  		mod_folder := current_folder;
  		ScanFolderRecF(current_folder, '*.dll', @ProcessLib);
  		mod_folder := '';
  		end;
end;

procedure ProcessLib(filename: string);
var
	lib: THandle;
	supp: TFQuery;
begin
	lib := LoadLibrary(PChar(filename));

    if (lib <> 0) then
  		begin
  		if (GetProcAddress(lib, 'FQuery') <> nil) then
    		begin
    		current_dll := filename;
    		@supp := GetProcAddress(lib, 'FQuery');
    		supp(PChar(current_dll), SortData, HInstance);
    		current_dll := '';
    		end;

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
    reg.WString(value1, ExtractFileName(current_dll));
    reg.CloseKey();

    if ((Trim(value2) <> '') and (value2 <> '')) then
    	begin
        reg.OpenKey(sModules + '\Descr', true);
        reg.WString(value1, value2);
        reg.CloseKey();
        end;
end;

end.
