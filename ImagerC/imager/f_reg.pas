// registry routines
unit f_reg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Registry, ShellAPI, ShlObj;

function RegReadStr(key: string; default: string):string;
function RegReadBool(key: string; default: boolean):boolean;
function RegReadInt(key: string; default: integer):integer;
procedure UpdateAssociations();
procedure WriteHandler();
procedure PutRegDock();

implementation

uses globals, f_strutils;

function RegReadStr(key: string; default: string):string;
var
   tmp: string;
begin
try
   tmp:=reg.ReadString(key);
   if tmp<>'' then Result:=tmp else Result:=default;
   except
         Result:=default;
         end;
end;

function RegReadBool(key: string; default: boolean):boolean;
begin
try
   Result:=reg.ReadBool(key);
   except
         Result:=default;
         end;
end;

function RegReadInt(key: string; default: integer):integer;
begin
try
   Result:=reg.ReadInteger(key);
   except
         Result:=default;
         end;
end;

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
  print, fs, ss, ssfs, browser: boolean;
begin
// preparing
reg.OpenKey(sReg + '\Formats',true);
icon_num:=RegReadInt('Icon',1);
description:=RegReadStr('Description','Futuris Imager Document');
if description='Image file' then description:='Futuris Imager Document'; // fix for ugly name
print:=RegReadBool('ContextPrint',false);
fs:=RegReadBool('FullScreen',false);
ss:=RegReadBool('SlideShow',false);
ssfs:=RegReadBool('FSinSlideShow',false);
browser:=RegReadBool('Thumbnails',false);
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
if not fs then reg.WriteString('','"' + Application.ExeName + '" "%1"') else reg.WriteString('','"' + Application.ExeName + '" "%1" /fs');
if print then begin
              reg.OpenKey('\FuturisImager\Shell\Print',true);
              reg.WriteString('','&Print');
              reg.OpenKey('\FuturisImager\Shell\Print\Command',true);
              reg.WriteString('','"' + Application.ExeName + '" "%1" /print');
              end
else begin
     reg.OpenKey('\FuturisImager\Shell\Print',true);
     reg.DeleteValue('');
     reg.OpenKey('\FuturisImager\Shell\Print\Command',true);
     reg.DeleteValue('');
     reg.DeleteKey('\FuturisImager\Shell\Print\Command');
     reg.DeleteKey('\FuturisImager\Shell\Print');
     end;
if ss then begin
           // directory
           reg.OpenKey('\Directory\Shell\SlideShow',true);
           reg.WriteString('','&Slide Show');
           reg.OpenKey('\Directory\Shell\SlideShow\Command',true);
           if not ssfs then reg.WriteString('','"' + Application.ExeName + '" "%1" /ss') else reg.WriteString('','"' + Application.ExeName + '" "%1" /ss /fs');
           // drive
           reg.OpenKey('\Drive\Shell\SlideShow',true);
           reg.WriteString('','&Slide Show');
           reg.OpenKey('\Drive\Shell\SlideShow\Command',true);
           if not ssfs then reg.WriteString('','"' + Application.ExeName + '" "%1" /ss') else reg.WriteString('','"' + Application.ExeName + '" "%1" /ss /fs');
           end
else begin
     // directory
     reg.OpenKey('\Directory\Shell\SlideShow',true);
     reg.DeleteValue('');
     reg.OpenKey('\Directory\Shell\SlideShow\Command',true);
     reg.DeleteValue('');
     reg.DeleteKey('\Directory\Shell\SlideShow\Command');
     reg.DeleteKey('\Directory\Shell\SlideShow');
     // drive
     reg.OpenKey('\Drive\Shell\SlideShow',true);
     reg.DeleteValue('');
     reg.OpenKey('\Drive\Shell\SlideShow\Command',true);
     reg.DeleteValue('');
     reg.DeleteKey('\Drive\Shell\SlideShow\Command');
     reg.DeleteKey('\Drive\Shell\SlideShow');
     end;
if browser then begin
                // directory
                reg.OpenKey('\Directory\Shell\Thumbnails',true);
                reg.WriteString('','&Thumbnails');
                reg.OpenKey('\Directory\Shell\Thumbnails\Command',true);
                reg.WriteString('','"' + GetAppFolder() + 'browser.exe' + '" "%1"');
                // drive
                reg.OpenKey('\Drive\Shell\Thumbnails',true);
                reg.WriteString('','&Thumbnails');
                reg.OpenKey('\Drive\Shell\Thumbnails\Command',true);
                reg.WriteString('','"' + GetAppFolder() + 'browser.exe' + '" "%1"');
                end
else begin
     // directory
     reg.OpenKey('\Directory\Shell\Thumbnails',true);
     reg.DeleteValue('');
     reg.OpenKey('\Directory\Shell\Thumbnails\Command',true);
     reg.DeleteValue('');
     reg.DeleteKey('\Directory\Shell\Thumbnails\Command');
     reg.DeleteKey('\Directory\Shell\Thumbnails');
     // drive
     reg.OpenKey('\Drive\Shell\Thumbnails',true);
     reg.DeleteValue('');
     reg.OpenKey('\Drive\Shell\Thumbnails\Command',true);
     reg.DeleteValue('');
     reg.DeleteKey('\Drive\Shell\Thumbnails\Command');
     reg.DeleteKey('\Drive\Shell\Thumbnails');
     end;
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
