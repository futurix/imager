unit athread;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs, Forms;

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

uses main, f_anim, globals, f_ui;

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
	delay: integer;
begin
	if not Terminated then
  		if (@infAnim.FIPISanimGetFrame <> nil) then
    		infAnim.FIPISanimGetFrame(frame, delay);

	if (frame <> 0) then
  		begin
  		if not Terminated then Synchronize(SendResult);
  		if not Terminated then sleep(delay);
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
