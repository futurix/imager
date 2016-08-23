// registry routines
unit f_reg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Registry, ShellAPI, ShlObj, c_const;

procedure UpdateAssociations();
procedure WriteHandler();
procedure PutRegDock();

implementation

uses globals, f_strutils;

// updates registry associations
procedure UpdateAssociations();
begin
SHChangeNotify(SHCNE_ASSOCCHANGED,0,nil,nil);
end;

// writes format handler into registry
procedure WriteHandler();
var
  icon_num: integer;
  description: string;
  fs: boolean;
begin
// preparing
reg.OpenKey(sReg + '\Formats',true);
icon_num:=reg.RInt('Icon',1);
description:=reg.RStr('Description','Futuris Imager Document');
if description='Image file' then
  description:='Futuris Imager Document'; // fix for ugly name
fs:=reg.RBool('FullScreen',false);
reg.CloseKey();

// doing stuff
reg.RootKey:=HKEY_CLASSES_ROOT;
reg.OpenKey('\FuturisImager',true);
reg.WriteString('',description);
reg.OpenKey('\FuturisImager\DefaultIcon',true);
reg.WriteString('',GetAppFolder() + 'imager.exe' + ',' + IntToStr(icon_num));
reg.OpenKey('\FuturisImager\Shell\Open',true);
reg.WriteString('','&Open');
reg.OpenKey('\FuturisImager\Shell\Open\Command',true);
if not fs then
  reg.WriteString('','"' + Application.ExeName + '" "%1"')
else
  reg.WriteString('','"' + Application.ExeName + '" "%1" /fs');
reg.CloseKey();
reg.RootKey:=HKEY_CURRENT_USER;
end;

// writes folders info into Registry
procedure PutRegDock();
begin
reg.OpenKey(sReg + '\Paths',true);
reg.WriteString('Directory',GetAppFolder());
reg.WriteString('Executable',Application.ExeName);
reg.WriteString('PlugsDir',(GetAppFolder() + 'plugins\'));
reg.CloseKey();
end;

end.
