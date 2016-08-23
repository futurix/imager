unit scan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, FileFind, IniFiles, Registry, ShellAPI;

type
  TfrmScan = class(TForm)
    fsrScan: TFileSearch;
    pnlStatus: TPanel;
    procedure fsrScanFileFind(fullpath: String; info: TSearchRec);

    procedure RegistryCleanUp();
    procedure ProcessLibrary(path: string);
    procedure MergeFile(path, dll: string);
    procedure MergeSection(section, dll: string; keys: TStringList);
    procedure MergeSectionEx(section, dll: string; keys, values: TStringList);
    procedure OpenRegistryBranch(section: string);
    procedure MergeAdds(regex: string);
    procedure CheckAdditionalParams();
    procedure Finish();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function DoScan(app: THandle; imager_dir: PChar):integer; stdcall;

const
     sReg = '\Software\Futuris\ImagerC';
     sFIPIS = '\Software\Futuris\FIPIS';

var
  frmScan: TfrmScan;
  reg: TRegistry;
  dir: string;

implementation

{$R *.DFM}

function DoScan(app: THandle; imager_dir: PChar):integer;
begin
// setting variables
Application.Handle:=app;
reg:=TRegistry.Create();
reg.RootKey:=HKEY_CURRENT_USER;
dir:=IncludeTrailingBackSlash(String(imager_dir));
try
   CreateDirectory(PChar(dir + 'temp'),nil);
   except
   end;
frmScan:=TfrmScan.Create(Application);
// working
frmScan.Show();
frmScan.RegistryCleanUp();
frmScan.fsrScan.SearchFile:=(dir + 'plugins\*.dll');
frmScan.fsrScan.Start();
frmScan.CheckAdditionalParams();
frmScan.Finish();
frmScan.Hide();
// freeing everything
frmScan.Free();
reg.Free();
Result:=1;
end;

procedure TfrmScan.fsrScanFileFind(fullpath: String; info: TSearchRec);
begin
ProcessLibrary(fullpath + info.Name);
end;

procedure TfrmScan.RegistryCleanUp();
begin
try reg.DeleteKey(sFIPIS + '\Open') except end;
try reg.DeleteKey(sFIPIS + '\Save') except end;
try reg.DeleteKey(sFIPIS + '\Import') except end;
try reg.DeleteKey(sFIPIS + '\Export') except end;
try reg.DeleteKey(sFIPIS + '\Filters') except end;
try reg.DeleteKey(sFIPIS + '\Tools') except end;
try reg.DeleteKey(sFIPIS + '\Descr') except end;
try reg.DeleteKey(sFIPIS + '\Multi') except end;
try reg.DeleteKey(sFIPIS + '\Anim') except end;
try reg.DeleteKey(sFIPIS + '\Info') except end;
reg.OpenKey(sFIPIS,true);
try reg.DeleteValue('RegEx') finally end;
reg.CloseKey();
end;

procedure TfrmScan.ProcessLibrary(path: string);
var
   lib: hwnd;
   res: TResourceStream;
   tmp: string;
begin
lib:=LoadLibrary(PChar(path));
if lib<>0 then begin
               try
                  res:=TResourceStream.Create(lib,'SPECS','FIPIS');
                  tmp:=(IntToStr(Random(9)) +
                        IntToStr(Random(9)) +
                        IntToStr(Random(9)) +
                        IntToStr(Random(9)) +
                        IntToStr(Random(9)) +
                        IntToStr(Random(9)) +
                        IntToStr(Random(9)) +
                        IntToStr(Random(9)));
                  tmp:=(dir + 'temp\' + tmp);
                  res.SaveToFile(tmp);
                  res.Free();
                  MergeFile(tmp,path);
                  except end;
               end;
end;

procedure TfrmScan.MergeFile(path, dll: string);
var
   ini: TIniFile;
   k,v: TStringList;
   dyn: string;
   i: integer;
begin
// initializing
ini:=TIniFile.Create(path);
k:=TStringList.Create();
v:=TStringList.Create();
dyn:=ExtractRelativePath(dir + 'plugins\',dll);
// working
if ini.SectionExists('FIPISopen') then begin
                                       ini.ReadSection('FIPISopen',k);
                                       MergeSection('FIPISopen',dyn,k);
                                       k.Clear();
                                       end;
if ini.SectionExists('FIPISsave') then begin
                                       ini.ReadSection('FIPISsave',k);
                                       MergeSection('FIPISsave',dyn,k);
                                       k.Clear();
                                       end;
if ini.SectionExists('FIPISimport') then begin
                                        ini.ReadSection('FIPISimport',k);
                                        MergeSection('FIPISimport',dyn,k);
                                        k.Clear();
                                        end;
if ini.SectionExists('FIPISexport') then begin
                                         ini.ReadSection('FIPISexport',k);
                                         MergeSection('FIPISexport',dyn,k);
                                         k.Clear();
                                         end;
if ini.SectionExists('FIPISmulti') then begin
                                        ini.ReadSection('FIPISmulti',k);
                                        MergeSection('FIPISmulti',dyn,k);
                                        k.Clear();
                                        end;
if ini.SectionExists('FIPISanim') then begin
                                       ini.ReadSection('FIPISanim',k);
                                       MergeSection('FIPISanim',dyn,k);
                                       k.Clear();
                                       end;
if ini.SectionExists('FIPISinfo') then begin
                                       ini.ReadSection('FIPISinfo',k);
                                       MergeSection('FIPISinfo',dyn,k);
                                       k.Clear();
                                       end;
if ini.SectionExists('FIPISfilter') then begin
                                         ini.ReadSection('FIPISfilter',k);
                                         MergeSection('FIPISfilter',dyn,k);
                                         k.Clear();
                                         end;
if ini.SectionExists('FIPIStool') then begin
                                       ini.ReadSection('FIPIStool',k);
                                       MergeSection('FIPIStool',dyn,k);
                                       k.Clear();
                                       end;
if ini.SectionExists('FIPISdescr') then begin
                                        ini.ReadSection('FIPISdescr',k);
                                        for i:=0 to (k.Count-1) do v.Add(ini.ReadString('FIPISdescr',k[i],''));
                                        MergeSectionEx('FIPISdescr',dyn,k,v);
                                        k.Clear();
                                        v.Clear();
                                        end;
if ini.SectionExists('General')
   then if ini.ReadString('General','RegEx','')<>'' then MergeAdds(ini.ReadString('General','RegEx',''));
// freeing
ini.Free();
k.Free();
v.Free();
DeleteFile(path);
end;

procedure TfrmScan.MergeSection(section, dll: string; keys: TStringList);
var
   i: integer;
begin
OpenRegistryBranch(section);
for i:=0 to (keys.Count-1) do begin
                              if reg.ValueExists(keys[i]) then begin
                                                               if Application.MessageBox(PChar('Values conflict for "' + keys[i] + '". Old value: "' + reg.ReadString(keys[i]) + '". New value: "' + dll + '". Would you like me to change to new one ?'),'Futuris Imager',MB_YESNO+MB_ICONQUESTION)=ID_YES
                                                                  then reg.WriteString(keys[i],dll);
                                                               end
                              else reg.WriteString(keys[i],dll);
                              end;
reg.CloseKey();
end;

procedure TfrmScan.MergeSectionEx(section, dll: string; keys, values: TStringList);
var
   i: integer;
begin
OpenRegistryBranch(section);
for i:=0 to (keys.Count-1) do begin
                              if reg.ValueExists(keys[i]) then begin
                                                               if Application.MessageBox(PChar('Values conflict for "' + keys[i] + '". Old value: "' + reg.ReadString(keys[i]) + '". New value: "' + values[i] + '". Would you like me to change to new one ?'),'Futuris Imager',MB_YESNO+MB_ICONQUESTION)=ID_YES
                                                                  then reg.WriteString(keys[i],values[i]);
                                                               end
                              else reg.WriteString(keys[i],values[i]);
                              end;
reg.CloseKey();
end;

procedure TfrmScan.OpenRegistryBranch(section: string);
begin
if section='FIPISopen' then reg.OpenKey(sFIPIS + '\Open',true)
else if section='FIPISsave' then reg.OpenKey(sFIPIS + '\Save',true)
else if section='FIPISimport' then reg.OpenKey(sFIPIS + '\Import',true)
else if section='FIPISexport' then reg.OpenKey(sFIPIS + '\Export',true)
else if section='FIPISmulti' then reg.OpenKey(sFIPIS + '\Multi',true)
else if section='FIPISanim' then reg.OpenKey(sFIPIS + '\Anim',true)
else if section='FIPISinfo' then reg.OpenKey(sFIPIS + '\Info',true)
else if section='FIPISfilter' then reg.OpenKey(sFIPIS + '\Filters',true)
else if section='FIPIStool' then reg.OpenKey(sFIPIS + '\Tools',true)
else if section='FIPISdescr' then reg.OpenKey(sFIPIS + '\Descr',true);
end;

procedure TfrmScan.MergeAdds(regex: string);
var
   tmp: string;
begin
reg.OpenKey(sFIPIS,true);
tmp:=reg.ReadString('RegEx');
if tmp<>'' then tmp:=tmp + regex else tmp:=regex;
tmp:=StringReplace(tmp,'????','?',[rfReplaceAll]);
tmp:=StringReplace(tmp,'???','?',[rfReplaceAll]);
tmp:=StringReplace(tmp,'??','?',[rfReplaceAll]);
reg.WriteString('RegEx',tmp);
reg.CloseKey();
end;

procedure TfrmScan.CheckAdditionalParams();
var
   tmp: string;
begin
if FileExists(dir + 'capture.exe') then begin
                                        reg.OpenKey(sFIPIS + '\Apps',true);
                                        reg.WriteString('Screen Capture',dir + 'capture.exe');
                                        reg.CloseKey();
                                        end;
if FileExists(dir + 'htmlcat.exe') then begin
                                        reg.OpenKey(sFIPIS + '\Apps',true);
                                        reg.WriteString('HTML Catalogue Creator',dir + 'htmlcat.exe');
                                        reg.CloseKey();
                                        end;
reg.OpenKey(sFIPIS,true);
if reg.ReadString('DefaultFilter')='' then reg.WriteString('DefaultFilter','*.*');
if reg.ReadString('BrowsingMask')=''
   then begin
        tmp:='*.bmp;*.gif;*.jpg;*.jpeg;*.ico;*.wmf;*.emf';
        if FileExists(dir + 'plugins\f_gex.dll') then tmp:=tmp + ';*.pcx;*.tif;*.tga;*.tiff;*.pcd;*.psd';
        if FileExists(dir + 'plugins\f_mng.dll') then tmp:=tmp + ';*.png;*.mng;*.jng';
        reg.WriteString('BrowsingMask',tmp);
        end;
reg.CloseKey();
reg.OpenKey(sReg + '\UI',true);
if reg.ReadString('Skin')=''
   then if FileExists(dir + 'skins\colorful.bmp') then reg.WriteString('Skin',dir + 'skins\colorful.bmp');
reg.CloseKey();
end;

procedure TfrmScan.Finish();
begin
ShellExecute(0,'open',PChar(dir + 'cleantmp.exe'),nil,nil,SW_SHOWNORMAL);
end;

end.
