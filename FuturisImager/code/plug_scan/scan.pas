unit scan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, ShellAPI,
  c_reg, c_utils, c_const;

var
  reg: TFuturisRegistry;
  mod_folder: string = '';
  current_dll: string = '';
  dll_counter: integer = 0;

function DoScan(app: THandle; imager_dir: PChar):integer; stdcall;
procedure ProcessLib(filename: string);
function SortData(module_type: integer; value1, value2: PChar):BOOL; stdcall;
procedure WriteData(key, value1, value2: string; write_type: integer);

implementation

function DoScan(app: THandle; imager_dir: PChar):integer;
var
  current_folder: string;
begin
Result:=0;

// creating registry object
reg:=TFuturisRegistry.Create();
reg.RootKey:=HKEY_CURRENT_USER;

// creating registry keys
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
current_folder:=Slash(String(imager_dir)) + 'plugins';
if DirExists(current_folder) then
  begin
  mod_folder:=current_folder;
  ScanFolderRecF(current_folder,'*.dll',@ProcessLib);
  mod_folder:='';
  end;

// end
FreeAndNil(reg);
end;

procedure ProcessLib(filename: string);
var
  lib: THandle;
  supp: TFIPISquery;
begin
lib:=LoadLibrary(PChar(filename));
if lib<>0 then
  begin
  if ((GetProcAddress(lib,'FIPISquery')<>nil) and (GetProcAddress(lib,'FIPISquery')<>nil)) then
    begin
    current_dll:=filename;
    @supp:=GetProcAddress(lib,'FIPISquery');
    supp(PChar(current_dll),SortData,HInstance);
    current_dll:='';
    end;
  FreeLibrary(lib);
  end;
end;

function SortData(module_type: integer; value1, value2: PChar):BOOL;
begin
Result:=true;
// working

case module_type of
  PT_FOPEN: WriteData('Open',String(value1),String(value2),0);
  PT_FOPENMULTI: WriteData('Multi',String(value1),String(value2),0);
  PT_FOPENANIM: WriteData('Anim',String(value1),String(value2),0);
  PT_FSAVE: WriteData('Save',String(value1),String(value2),0);
  PT_FIMPORT: WriteData('Import',String(value1),String(value2),0);
  PT_FEXPORT: WriteData('Export',String(value1),String(value2),0);
  PT_FFILTER: WriteData('Filters',String(value1),String(value2),0);
  PT_FINFO: WriteData('Info',String(value1),String(value2),0);
  PT_FTOOL: WriteData('Tools',String(value1),String(value2),0);
  PT_FDESCR: WriteData('Descr',String(value1),String(value2),1);
  else Result:=false;
  end;
end;

procedure WriteData(key, value1, value2: string; write_type: integer);
begin
case write_type of
  0: // normal (key,value1=dll)
    begin
    reg.OpenKey(sModules + '\' + key,true);
    reg.WString(value1,ExtractFileName(current_dll));
    reg.CloseKey();
    end;
  1: // normal (key,value1=value2)
    begin
    reg.OpenKey(sModules + '\' + key,true);
    reg.WString(value1,value2);
    reg.CloseKey();
    end;
  end;
end;

exports
  DoScan;

end.
