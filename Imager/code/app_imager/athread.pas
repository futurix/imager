unit athread;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs, Forms,
  c_const;

type
  TAnimationThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure FrameCycle();
    procedure SendResult;
    procedure JustEnded;
  end;

var
	frame: hBitmap;


implementation

uses main, f_anim, f_ui;

procedure TAnimationThread.Execute;
var
	i: integer;
begin
	FreeOnTerminate := true;

	// endless loop
	i := 1;
	repeat
  		begin
        if Terminated then Break;
    	if not Terminated then FrameCycle();
    	if Terminated then Break;
  		end;
  	until (i = 0);

	// terminating
	Synchronize(JustEnded);
	thrAnim := nil;
end;

procedure TAnimationThread.FrameCycle();
var
    tmp_res: TFxImgResult;
begin
    tmp_res.result_type := RT_INT;
    tmp_res.result_value := frame;

	if not Terminated then
  		if (@infAnim.FxImgAnimGetFrame <> nil) then
    		tmp_res := infAnim.FxImgAnimGetFrame(Application.Handle, frmMain.Handle, FxImgGlobalCallback);

	if ((tmp_res.result_type = RT_INT) and (tmp_res.result_value <> 0)) then
  		begin
        frame := tmp_res.result_value;

  		if not Terminated then Synchronize(SendResult);
  		if not Terminated then sleep(tmp_res.result_xtra);
  		end;
end;

procedure TAnimationThread.SendResult;
var
	bim: TBitmap;
begin
	bim := TBitmap.Create();
    bim.Handle := frame;
    bim.PixelFormat := pf24bit;

    frmMain.img.IEBitmap.Assign(bim);
    frmMain.img.Repaint();

	FreeAndNil(bim);
end;

procedure TAnimationThread.JustEnded;
begin
	ATuneUI(false);
end;

end.
