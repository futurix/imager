// animation
unit f_anim;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs, Forms, IniFiles, athread;

function IsAnimation(ext: string):boolean;
procedure OpenAnim(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
procedure APlay();
procedure APause();
procedure AStop();
procedure ATuneUI(playing: boolean = true);
procedure CloseAnim();

var
   thrAnim: TAnimationThread;

implementation

uses globals, fipis, f_reg, f_debug, f_graphics, f_tools, f_ui,
     f_strutils, f_external, f_nav, main;

// is animated
function IsAnimation(ext: string):boolean;
begin
reg.OpenKey(sFIPIS + '\Anim',true);
if RegReadStr(ext,'')<>'' then Result:=true else Result:=false;
reg.CloseKey();
end;

// opens animated image
procedure OpenAnim(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
begin
if not FileExists(path) then begin
                             FileNotFound(path);
                             Abort();
                             end;
// loading dll and settings
reg.OpenKey(sFIPIS + '\Anim',true);
infAnim.lib:=LoadLibrary(PChar(GetAppFolder() + 'plugins\' + RegReadStr(GetExt(path),'')));
reg.CloseKey();
if infAnim.lib<>0 then begin
                       @infAnim.FIPISanimInit:=GetProcAddress(infAnim.lib,'FIPISanimInit');
                       @infAnim.FIPISanimConfirm:=GetProcAddress(infAnim.lib,'FIPISanimConfirm');
                       @infAnim.FIPISanimRestart:=GetProcAddress(infAnim.lib,'FIPISanimRestart');
                       @infAnim.FIPISanimGetFrame:=GetProcAddress(infAnim.lib,'FIPISanimGetFrame');
                       @infAnim.FIPISanimDeInit:=GetProcAddress(infAnim.lib,'FIPISanimDeInit');
                       if ((@infAnim.FIPISanimInit<>nil) and
                           (@infAnim.FIPISanimConfirm<>nil) and
                           (@infAnim.FIPISanimRestart<>nil) and
                           (@infAnim.FIPISanimGetFrame<>nil) and
                           (@infAnim.FIPISanimDeInit<>nil)) then begin
                                                                 // settings
                                                                 if infAnim.FIPISanimInit(PChar(path),PChar(GetExt(path)),Application.Handle)=0 then begin
                                                                                                                                                     CloseAnim();
                                                                                                                                                     FileNotFound(path);
                                                                                                                                                     Exit;
                                                                                                                                                     end;
                                                                 if infAnim.FIPISanimConfirm()=0 then begin
                                                                                                      CloseAnim();
                                                                                                      OpenLocal(path, add_to_mru, same_folder);
                                                                                                      Exit;
                                                                                                      end;
                                                                 // starting
                                                                 FillImage(path,'',ftLocal,itAnimated);
                                                                 // tuning UI
                                                                 if add_to_mru then frmMain.MRU.Add(path);
                                                                 if same_folder=false then ScanFolder(path) else FindFileNumber();
                                                                 if not infSettings.full_screen then frmMain.tbrAnim.Visible:=true;
                                                                 frmMain.sbxMain.ControlStyle:=frmMain.sbxMain.ControlStyle+[csOpaque];
                                                                 // starting animation
                                                                 Able(true);
                                                                 Lock(false);
                                                                 frmMain.pAnim.Visible:=true;
                                                                 ATuneUI();
                                                                 APlay();
                                                                 end;
                       end;
end;

// starts playback
procedure APlay();
begin
if thrAnim=nil then begin
                    infAnim.FIPISanimRestart();
                    thrAnim:=TAnimationThread.Create(false);
                    ATuneUI();
                    end
else begin
     if thrAnim.Suspended then thrAnim.Resume();
     end;
end;

// pauses playback
procedure APause();
begin
if thrAnim<>nil then begin
                     if thrAnim.Suspended then thrAnim.Resume()
                     else thrAnim.Suspend();
                     end;
end;

// stops playback
procedure AStop();
begin
if thrAnim<>nil then begin
                     if thrAnim.Suspended then thrAnim.Resume();
                     thrAnim.Terminate();
                     thrAnim.WaitFor();
                     ATuneUI(false);
                     end;
end;

// UI settings for animation
procedure ATuneUI(playing: boolean = true);
begin
if playing then begin
                // playback
                frmMain.tbnPlay.Enabled:=false;
                frmMain.tbnPause.Enabled:=true;
                frmMain.tbnStop.Enabled:=true;
                end
else begin
     // navigation
     frmMain.tbnPlay.Enabled:=true;
     frmMain.tbnPause.Enabled:=false;
     frmMain.tbnStop.Enabled:=false;
     end;
frmMain.piAnimPlay.Enabled:=frmMain.tbnPlay.Enabled;
frmMain.piAnimPause.Enabled:=frmMain.tbnPause.Enabled;
frmMain.piAnimStop.Enabled:=frmMain.tbnStop.Enabled;
end;

// closes animated image
procedure CloseAnim();
begin
if thrAnim<>nil then begin
                     thrAnim.Terminate();
                     thrAnim.WaitFor();
                     end;
if @infAnim.FIPISanimDeInit<>nil then infAnim.FIPISanimDeInit();
if infAnim.lib<>0 then FreeLibrary(infAnim.lib);
frmMain.sbxMain.ControlStyle:=frmMain.sbxMain.ControlStyle-[csOpaque];
frmMain.tbrAnim.Visible:=false;
frmMain.pAnim.Visible:=false;
FillImage('','',ftNone,itNone);
end;

end.
