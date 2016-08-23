// animation
unit f_anim;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs, Forms,
  IniFiles, athread, c_const, c_utils;

function  IsAnimation(ext: string):boolean;
procedure OpenAnim(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
procedure APlay();
procedure APause();
procedure AStop();
procedure ATuneUI(playing: boolean = true);
procedure CloseAnim();

var
	thrAnim: TAnimationThread;


implementation

uses globals, f_reg, f_graphics, f_tools, f_ui,
	f_nav, main;

// is animated
function IsAnimation(ext: string):boolean;
begin
	reg.OpenKey(sModules + '\Anim', true);

	if reg.RStr(ext, '') <> '' then
    	Result := true
  	else
    	Result := false;

	reg.CloseKey();
end;

// opens animated image
procedure OpenAnim(path: string; add_to_mru: boolean = true; same_folder: boolean = false);
begin
	if not FileExists(path) then
  		begin
  		FileNotFound(path);
  		Abort();
  		end;

	// loading dll and settings
	reg.OpenKey(sModules + '\Anim', true);
	infAnim.lib := LoadLibrary(PChar(GetAppFolder() + reg.RStr(ExtractExt(path), '')));
	reg.CloseKey();

	if infAnim.lib<>0 then
  		begin
  		@infAnim.FIPISanimInit := GetProcAddress(infAnim.lib, 'FIPISanimInit');
  		@infAnim.FIPISanimConfirm := GetProcAddress(infAnim.lib, 'FIPISanimConfirm');
  		@infAnim.FIPISanimRestart := GetProcAddress(infAnim.lib, 'FIPISanimRestart');
  		@infAnim.FIPISanimGetFrame := GetProcAddress(infAnim.lib, 'FIPISanimGetFrame');
  		@infAnim.FIPISanimDeInit := GetProcAddress(infAnim.lib, 'FIPISanimDeInit');

  		if ((@infAnim.FIPISanimInit <> nil) and
			(@infAnim.FIPISanimConfirm <> nil) and
      		(@infAnim.FIPISanimRestart <> nil) and
      		(@infAnim.FIPISanimGetFrame <> nil) and
      		(@infAnim.FIPISanimDeInit <> nil)) then
    		begin
        	// settings
    		if (infAnim.FIPISanimInit(PChar(path), PChar(ExtractExt(path)), Application.Handle) = 0) then
      			begin
      			CloseAnim();
      			FileNotFound(path);
      			Exit;
      			end;

    		if (infAnim.FIPISanimConfirm() = 0) then
      			begin
      			CloseAnim();
      			OpenLocal(path, add_to_mru, same_folder);
      			Exit;
      			end;

    		// starting
    		FillImage(path, ftLocal, itAnimated);

    		// tuning UI
    		if add_to_mru then
      			frmMain.MRU.Add(path);

    		if same_folder = false then
       		 	ScanFolder(path)
        	else
        		FindFileNumber();

    		frmMain.sbxMain.ControlStyle := frmMain.sbxMain.ControlStyle + [csOpaque];

    		// starting animation
    		Able(true);
    		Lock(false, false, true);
            frmMain.mAnim.Visible := true;
    		frmMain.pAnim.Visible := true;
    		ATuneUI();
    		APlay();
    		end;
  		end;
end;

// starts playback
procedure APlay();
begin
	if (thrAnim = nil) then
  		begin
  		infAnim.FIPISanimRestart();
  		thrAnim := TAnimationThread.Create(false);
  		ATuneUI();
  		end
	else
  		if thrAnim.Suspended then
    		thrAnim.Resume();
end;

// pauses playback
procedure APause();
begin
	if (thrAnim <> nil) then
  		if thrAnim.Suspended then thrAnim.Resume()
    		else thrAnim.Suspend();
end;

// stops playback
procedure AStop();
begin
	if (thrAnim <> nil) then
  		if thrAnim.Suspended then
    		thrAnim.Resume();

	if (thrAnim <> nil) then
  		thrAnim.Terminate();

	try
		if (thrAnim <> nil) then
  			thrAnim.WaitFor();
	except
	end;

	ATuneUI(false);
end;

// UI settings for animation
procedure ATuneUI(playing: boolean = true);
begin
	if playing then
  		begin
  		// playback
		frmMain.piAnimPlay.Enabled := false;
		frmMain.piAnimPause.Enabled := true;
		frmMain.piAnimStop.Enabled := true;

		frmMain.miAnimPlay.Enabled := false;
		frmMain.miAnimPause.Enabled := true;
		frmMain.miAnimStop.Enabled := true;
  		end
	else
  		begin
  		// navigation
		frmMain.piAnimPlay.Enabled := true;
		frmMain.piAnimPause.Enabled := false;
		frmMain.piAnimStop.Enabled := false;

		frmMain.miAnimPlay.Enabled := true;
		frmMain.miAnimPause.Enabled := false;
		frmMain.miAnimStop.Enabled := false;
  		end;
end;

// closes animated image
procedure CloseAnim();
begin
	if (thrAnim <> nil) then
  		if thrAnim.Suspended then
    		thrAnim.Resume();

	if (thrAnim <> nil) then
  		thrAnim.Terminate();

	try
		if (thrAnim <> nil) then
  			thrAnim.WaitFor();
	except
	end;

	if (@infAnim.FIPISanimDeInit <> nil) then
  		infAnim.FIPISanimDeInit();

	if (infAnim.lib <> 0) then
  		FreeLibrary(infAnim.lib);

	frmMain.sbxMain.ControlStyle := frmMain.sbxMain.ControlStyle - [csOpaque];
    frmMain.mAnim.Visible := false;
	frmMain.pAnim.Visible := false;
	FillImage('', ftNone, itNone);
end;

end.
