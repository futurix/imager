// plug-ins manipulation routines
unit f_plugins;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Dialogs, Forms, Menus;

procedure InstallPlugIns();
procedure UpdatePlugIns();
procedure SetDialogs();
procedure HandleFilter(name: string);
procedure SetSaveDialog();

implementation

uses globals, main, fipis, f_graphics, f_images, f_web, f_strutils, f_reg, f_ui;

// adds plug-ins from ini
procedure InstallPlugIns();
var
  c,z: integer;
  i: TMenuItem;
  s: TStringList;
begin
// the beginning
s:=TStringList.Create();
// setting sun
SetDialogs();
// setting FIPISimport
s.Clear();
reg.OpenKey(sFIPIS + '\Import',true);
reg.GetValueNames(s);
reg.CloseKey();
s.Sort();
if s.Count>0 then begin
                  frmMain.mImport.Clear();
                  for c:=0 to (s.Count-1) do begin
                                             i:=TMenuItem.Create(nil);
                                             i.Caption:=s.Strings[c];
                                             i.Hint:=s.Strings[c];
                                             i.OnClick:=frmMain.HandleFIPISimport;
                                             frmMain.mImport.Add(i);
                                             end;
                  frmMain.mImport.Enabled:=true;
                  end;
// setting FIPISexport
s.Clear();
reg.OpenKey(sFIPIS + '\Export',true);
reg.GetValueNames(s);
reg.CloseKey();
s.Sort();
if s.Count>0 then begin
                  frmMain.mExport.Clear();
                  for c:=0 to (s.Count-1) do begin
                                             i:=TMenuItem.Create(nil);
                                             i.Caption:=s.Strings[c];
                                             i.Hint:=s.Strings[c];
                                             i.OnClick:=frmMain.HandleFIPISexport;
                                             frmMain.mExport.Add(i);
                                             end;
                  frmMain.mExport.Enabled:=true;
                  end;
// setting FIPISfilter
s.Clear();
reg.OpenKey(sFIPIS + '\Filters',true);
reg.GetValueNames(s);
reg.CloseKey();
s.Sort();
if s.Count>0 then begin
                  if s.Count<20 then z:=s.Count-1 else z:=19;
                  for c:=z downto 0 do begin
                                       i:=TMenuItem.Create(nil);
                                       i.Caption:=s.Strings[c];
                                       i.Hint:=s.Strings[c];
                                       i.OnClick:=frmMain.HandleFIPISfilter;
                                       frmMain.mModify.Insert(0,i);
                                       end;
                  end;
// separator
if frmMain.mModify.Count>1 then begin
                                if s.Count>20 then begin
                                                   i:=TMenuItem.Create(nil);
                                                   i.Caption:='<< more filters below >>';
                                                   i.Enabled:=false;
                                                   i.Hint:='Additional filters available in Filters Lister.';
                                                   i.Tag:=7;
                                                   frmMain.mModify.Insert(frmMain.mModify.Count-1,i);
                                                   end;
                                i:=TMenuItem.Create(nil);
                                i.Caption:='-';
                                frmMain.mModify.Insert(frmMain.mModify.Count-1,i);
                                end;
// setting FIPIStool
s.Clear();
reg.OpenKey(sFIPIS + '\Tools',true);
reg.GetValueNames(s);
reg.CloseKey();
s.Sort();
if s.Count>0 then begin
                  for c:=(s.Count-1) downto 0 do begin
                                                 i:=TMenuItem.Create(nil);
                                                 i.Caption:=s.Strings[c];
                                                 i.Hint:=s.Strings[c];
                                                 i.OnClick:=frmMain.HandleFIPIStool;
                                                 frmMain.mTools.Insert(0,i);
                                                 end;
                  end;
// setting Apps
s.Clear();
reg.OpenKey(sFIPIS + '\Apps',true);
reg.GetValueNames(s);
reg.CloseKey();
s.Sort();
if s.Count>0 then begin
                  // separator
                  i:=TMenuItem.Create(nil);
                  i.Caption:='-';
                  frmMain.mTools.Insert(frmMain.mTools.Count-1,i);
                  // apps
                  for c:=0 to (s.Count-1) do begin
                                             i:=TMenuItem.Create(nil);
                                             i.Caption:=s.Strings[c];
                                             i.Hint:=s.Strings[c];
                                             i.Tag:=7; // marking for later recognition
                                             i.OnClick:=frmMain.HandleApps;
                                             frmMain.mTools.Insert(frmMain.mTools.Count-1,i);
                                             end;
                  end;
// separator
if frmMain.mTools.Count>1 then begin
                               i:=TMenuItem.Create(nil);
                               i.Caption:='-';
                               frmMain.mTools.Insert(frmMain.mTools.Count-1,i);
                               end;
// freeing
i:=TMenuItem.Create(nil);
s.Free();
i.Free();
end;

// updates all plug-ins from ini
procedure UpdatePlugIns();
var
   tmp: boolean;
begin
tmp:=(infImage.path<>'');
// cleaning
frmMain.mImport.Clear();
frmMain.mExport.Clear();
repeat frmMain.mModify.Delete(0) until frmMain.mModify.Count=1;
repeat frmMain.mTools.Delete(0) until frmMain.mTools.Count=1;
// now installing plug-ins
InstallPlugIns();
Able(tmp);
end;

// sets open and save dialogs
procedure SetDialogs();
var
   h, d: TStringList;
   i: integer;
   s, t_d, all: string;
begin
h:=TStringList.Create();
d:=TStringList.Create();
s:='';
reg.OpenKey(sFIPIS,true);
all:=RegReadStr('DefaultFilter','');
reg.CloseKey();
if all<>'' then all:=('Major supported formats|' + all);
// common ( descriptions )
reg.OpenKey(sFIPIS + '\Descr',true);
reg.GetValueNames(d);
reg.CloseKey();
// open dialog
reg.OpenKey(sFIPIS + '\Open',true);
reg.GetValueNames(h);
reg.CloseKey();
reg.OpenKey(sFIPIS + '\Descr',true);
if h.Count>0 then begin
                  if (opOpenDef in infSettings.options) then begin
                                                             // default filter is "*.*"
                                                             for i:=0 to (h.Count-1) do begin
                                                                                        t_d:=RegReadStr(h.Strings[i],'');
                                                                                        if t_d='' then t_d:=('*.'+h.Strings[i]);
                                                                                        s:= s + t_d + '|' + '*.' + h.Strings[i];
                                                                                        if i<>(h.Count-1) then s:=s+'|';
                                                                                        end;
                                                             s:=('All files (*.*)|*.*|' + s);
                                                             if all<>'' then s:=(s + '|' + all);
                                                             frmMain.dlgOpen.Filter:=s;
                                                             end
                  else begin
                       // default filter is combined one
                       for i:=0 to (h.Count-1) do begin
                                                  t_d:=RegReadStr(h.Strings[i],'');
                                                  if t_d='' then t_d:=('*.'+h.Strings[i]);
                                                  s:= s + t_d + '|' + '*.' + h.Strings[i];
                                                  if i<>(h.Count-1) then s:=s+'|';
                                                  end;
                       if all<>'' then s:=(all + '|' + s);
                       s:=(s + '|All files (*.*)|*.*');
                       frmMain.dlgOpen.Filter:=s;
                       end;
                  end;
reg.CloseKey();
// temp clearing
h.Clear();
s:='';
t_d:='';
// save dialog
reg.OpenKey(sFIPIS + '\Save',true);
reg.GetValueNames(h);
reg.CloseKey();
reg.OpenKey(sFIPIS + '\Descr',true);
if h.Count>0 then begin
                  for i:=0 to (h.Count-1) do begin
                                             t_d:=RegReadStr(h.Strings[i],'');
                                             if t_d='' then t_d:=('*.'+h.Strings[i]);
                                             s:= s + t_d + '|' + '*.' + h.Strings[i];
                                             if i<>(h.Count-1) then s:=s+'|';
                                             end;
                  frmMain.dlgSave.Filter:=s;
                  end;
reg.CloseKey();
// final
d.Free();
h.Free();
end;

// handles filters
procedure HandleFilter(name: string);
var
   FIPISfilter: TFIPISfilter;
   lib: THandle;
   func_result: hBitmap;
   image: TBitmap;
begin
// starting the stuff
lib:=0;
try
reg.OpenKey(sFIPIS + '\Filters',true);
lib:=LoadLibrary(PChar(GetAppFolder() + 'plugins\' + RegReadStr(name,'')));
reg.CloseKey();
if lib=0 then Application.MessageBox('Cannot load filter DLL!','Error!',MB_OK+MB_ICONERROR)
else begin
     @FIPISfilter:=GetProcAddress(lib,'FIPISfilter');
     if not (@FIPISfilter=nil) then begin
                                    image:=TBitmap.Create();
                                    image.Assign(frmMain.imgMain.Picture.Bitmap);
                                    image.PixelFormat:=pf24bit;
                                    func_result:=FIPISfilter(PChar(name),Application.Handle,image.Handle);
                                    if func_result<>0 then begin
                                                           // start working with result
                                                           frmMain.imgMain.Picture.Bitmap.Handle:=func_result;
                                                           infImage.modified:=true;
                                                           frmMain.imgMain.Invalidate();
                                                           if (opAutoApply in infSettings.options) then ApplyChanges();
                                                           end;
                                    image.Free();
                                    end;
     end;
finally
FreeLibrary(lib);
end;
end;

// sets default filename and extension for saving images
procedure SetSaveDialog();
var
   tmp, ext: string;
   s: TStringList;
begin
if ((infImage.file_type<>ftUnsaved)and(infImage.file_type<>ftWeb)) then begin
                                                                        tmp:=ExtractFileName(infImage.path);
                                                                        ext:=ExtractFileExt(infImage.path);
                                                                        Delete(tmp,Pos(ext,tmp),Length(ext));
                                                                        frmMain.dlgSave.FileName:=tmp;
                                                                        end
else begin
     frmMain.dlgSave.FileName:='Untitled';
     end;
if ExtractFileExt(frmMain.dlgSave.FileName)='' then begin
                                                    s:=TStringList.Create();
                                                    reg.OpenKey(sFIPIS + '\Save',true);
                                                    reg.GetValueNames(s);
                                                    reg.CloseKey();
                                                    frmMain.dlgSave.DefaultExt:=s.Strings[(frmMain.dlgSave.FilterIndex-1)];
                                                    s.Free();
                                                    end;
end;

end.
