unit rsthread;

interface

uses
  Classes, Graphics, futuris_resample;

type
  TResizeThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure SendResult();
  end;

var
   th_tmp: TBitmap;
   th_scale: double;
   th_filter: TResamplingFilter;

implementation

uses main, globals, f_ui;

procedure TResizeThread.Execute;
begin
FreeOnTerminate:=true;
try
if th_scale<>0 then begin
                    if Terminated=false then th_tmp:=TBitmap.Create();
                    if Terminated=false then Stretch(Round(infImage.original.Width*th_scale),Round(infImage.original.Height*th_scale),th_filter,0,infImage.original,th_tmp);
                    if Terminated=false then infImage.zoom_factor:=th_scale;
                    if Terminated=false then infImage.modified:=false;
                    if Terminated=false then Synchronize(SendResult);
                    if Terminated=false then th_tmp.Free();
                    end;
except
end;
thrResize:=nil;
end;

procedure TResizeThread.SendResult;
begin
if infSettings.full_screen=true then CenterCancel();
frmMain.imgMain.Picture.Bitmap.Assign(th_tmp);
frmMain.miZoomOut.Enabled:=true;
frmMain.miZoomIn.Enabled:=true;
frmMain.mZoom.Enabled:=true;
frmMain.mZMMethods.Enabled:=true;
frmMain.tbnZoom.Enabled:=true;
frmMain.tbnZoomFit.Enabled:=true;
frmMain.tbnZoomOrig.Enabled:=true;
if frmMain.sbrMain.Panels[1].Text='Resizing...' then frmMain.sbrMain.Panels[1].Text:='';
if infSettings.full_screen=true then Center();
end;

end.
