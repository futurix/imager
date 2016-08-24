unit f_anim;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs, Forms,
  IniFiles, athread, c_const, c_reg, c_utils;

function  IsAnimation(ext: string):boolean;
procedure OpenAnim(path: string; add_to_mru: boolean = true);
procedure APlay();
procedure APause();
procedure AStop();
procedure ATuneUI(playing: boolean = true);
procedure CloseAnim();

var
  thrAnim: TAnimationThread;


implementation

uses f_graphics, f_tools, f_ui, f_nav, main;

// is animated
function IsAnimation(ext: string):boolean;
begin
    Result := (FxRegRStr(ext, '', sModules + '\' + PS_FOPENANIM) <> '');
end;

// opens animated image
procedure OpenAnim(path: string; add_to_mru: boolean = true);
var
  tmp_res: TFxImgResult;
begin
  if not FileExists(path) then
      begin
      FileNotFound(path);
      Abort();
      end;

  // loading dll and settings
  infAnim.lib := LoadLibrary(PChar(FxRegRStr(ExtractExt(path), '', sModules + '\' + PS_FOPENANIM)));

  if (infAnim.lib <> 0) then
      begin
      @infAnim.FxImgAnimStart := GetProcAddress(infAnim.lib, EX_ANIMSTART);
      @infAnim.FxImgAnimRestart := GetProcAddress(infAnim.lib, EX_ANIMRESTART);
      @infAnim.FxImgAnimGetFrame := GetProcAddress(infAnim.lib, EX_ANIMFRAME);
      @infAnim.FxImgAnimStop := GetProcAddress(infAnim.lib, EX_ANIMSTOP);

      if ((@infAnim.FxImgAnimStart <> nil) and
          (@infAnim.FxImgAnimRestart <> nil) and
          (@infAnim.FxImgAnimGetFrame <> nil) and
          (@infAnim.FxImgAnimStop <> nil)) then
        begin
          // settings
            tmp_res := infAnim.FxImgAnimStart(PChar(path), PChar(ExtractExt(path)), Application.Handle, frmMain.Handle, FxImgGlobalCallback);
        if ((tmp_res.result_type <> RT_BOOL) or ((tmp_res.result_type = RT_BOOL) and (tmp_res.result_value = FX_FALSE))) then
            begin
            CloseAnim();
            OpenLocal(path, add_to_mru);
            Exit;
            end;

        // starting
        FillImage(path, itAnimated);

        // tuning UI
        if add_to_mru then
          frmMain.mru.AddItem(path, true);

        ScanFolder(path);

        // starting animation
        Able();
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
        infAnim.FxImgAnimRestart(Application.Handle, frmMain.Handle, FxImgGlobalCallback);
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

  if (@infAnim.FxImgAnimStop <> nil) then
      infAnim.FxImgAnimStop(Application.Handle, frmMain.Handle, FxImgGlobalCallback);

  if (infAnim.lib <> 0) then
      FreeLibrary(infAnim.lib);

  frmMain.sbxMain.ControlStyle := frmMain.sbxMain.ControlStyle - [csOpaque];
    frmMain.mAnim.Visible := false;
  frmMain.pAnim.Visible := false;
  FillImage('', itNone);
end;

end.
