unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Dialogs,
  c_const, c_utils, c_reg;

function FHelpGetBitmap(path: PChar; app: THandle):HBITMAP; stdcall;
function FHelpBrowseForBitmap(app, wnd: THandle):HBITMAP; stdcall;


implementation

function FHelpGetBitmap(path: PChar; app: THandle):HBITMAP;
var
  FOpen: TFOpen;
  bmp: HBITMAP;
  lib: THandle;
  reg: TFuturisRegistry;
  ext, lib_path, folder: string;
begin
// initializing
reg:=TFuturisRegistry.Create();
reg.RootKey:=HKEY_CURRENT_USER;

reg.OpenKey(sReg + '\Paths',true);
folder:=reg.RStr('Directory','');
reg.Closekey();

ext:=ExtractExt(path);

reg.OpenKey(sModules + '\Open',true);
lib_path:=folder + reg.RStr(ext,'');
reg.CloseKey();

// main stuff
Result:=0;
if lib_path<>'' then
  begin
  lib:=LoadLibrary(PChar(lib_path));
  if lib<>0 then
    begin
    @FOpen:=GetProcAddress(lib,'FOpen');
    if not (@FOpen=nil) then
      begin
      bmp:=FOpen(PChar(path),PChar(ext),app);
      if bmp<>0 then
        begin
        //Success!!!
        Result:=bmp;
        end;
      end;
    FreeLibrary(lib);
    end;
  end;

// cleaning
FreeAndNil(reg);
end;

function FHelpBrowseForBitmap(app, wnd: THandle):HBITMAP;
var
  dlgOpen: TOpenDialog;
begin
Result:=0;

// getting filename
dlgOpen:=TOpenDialog.Create(nil);
dlgOpen.Filter:='All Files|*.*';
if dlgOpen.Execute() then
  begin
  Result:=FHelpGetBitmap(PChar(dlgOpen.FileName),app);
  end;

// cleaning
FreeAndNil(dlgOpen);
end;

end.
