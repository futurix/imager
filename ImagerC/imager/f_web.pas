// http utils
unit f_web;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms;

procedure OpenWeb(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
function GetTempFileName():string;
function GetExtension(ct: string):string;
function ValidateWebAddress(address: string):boolean;

implementation

uses globals, main, f_graphics, f_filectrl, f_nav, f_debug, f_ui, f_reg;

// loads file from http server
procedure OpenWeb(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
var
  LoadFile: TLoadFile;
  lib: THandle;
  content_type, ext, tmp, renamed, ren: string;
begin
// starting the stuff
try
  lib:=LoadLibrary('webload.dll');
  if lib=0 then
    Report('Cannot load "WEBLOAD.DLL" library!',2)
  else
    begin
    @LoadFile:=GetProcAddress(lib,'LoadFile');
    if not (@LoadFile=nil) then
      begin
      tmp:=GetTempFileName();
      content_type:=String(LoadFile(Application.Handle,PChar(path),PChar(tmp),PChar(infSettings.uagent),PChar(infSettings.appHome)));
      if content_type<>'Cancelled' then
        begin
        ext:=GetExtension(content_type);
        if ext<>'' then
          begin
          renamed:=StringReplace(tmp,'tmp',ext,[rfReplaceAll,rfIgnoreCase]);
          if RenameFile(tmp,renamed)=true then
            begin
            FillBitmap(nil,true,DoImageLoad(renamed));
            FillImage(renamed,path,ftWeb,itNormal);
            Able(true);
            if add_to_mru then frmMain.MRU.Add(path);
            if not same_folder then ScanFolder(renamed) else FindFileNumber();
            if ((opFSCenter in infSettings.options) and infSettings.full_screen) then Center();
            end
          else
            begin
            ren:=('Cannot rename file: ' + tmp + ' - try to rename it yourself (to .' + ext + ' extension)and open it.');
            Report(ren,2);
            end;
          end
        else
          Report('Unsupported file format or HTTP error.',2);
        end;
      end;
    FreeLibrary(lib);
    end;
  except end;
end;

// returns temp filename
function GetTempFileName():string;
var
  tmp: string;
begin
tmp:=(IncludeTrailingBackSlash(ExtractFileDir(Application.ExeName))+'temp\');
if DirExists(tmp)=false then
  CreateDirectory(PChar(tmp),nil);
Randomize();
tmp:=(tmp+IntToStr(Round(Random(9)))+IntToStr(Round(Random(9)))+
          IntToStr(Round(Random(9)))+IntToStr(Round(Random(9)))+
          IntToStr(Round(Random(9)))+IntToStr(Round(Random(9)))+
          IntToStr(Round(Random(9)))+IntToStr(Round(Random(9)))+'.tmp');
Result:=PChar(tmp);
end;

// get extension from content type
function GetExtension(ct: string):string;
begin
if Pos('gif',ct)<>0 then Result:='gif'
  else if Pos('jpeg',ct)<>0 then Result:='jpg'
  else if Pos('png',ct)<>0 then Result:='png'
  else Result:='';
end;

// is valid http ?
function ValidateWebAddress(address: string):boolean;
begin
if ((Length(address)>7)and(Pos('http://',Trim(address))=1)) then
  Result:=true
else
  Result:=false;
end;

end.
