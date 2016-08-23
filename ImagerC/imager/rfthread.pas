unit rfthread;

interface

uses
  Classes, Graphics, futuris_resample;

type
  TFitThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure SendResult();
  end;

var
   fit_tmp: TBitmap;
   fit_width, fit_height: integer;
   fit_scale: double;

implementation

uses main, rsthread, globals, f_ui;

procedure TFitThread.Execute;
begin
FreeOnTerminate:=true;
try
   if Terminated=false then fit_tmp:=TBitmap.Create();
   if Terminated=false then Stretch(fit_width,fit_height,th_filter,0,infImage.original,fit_tmp);
   if Terminated=false then infImage.zoom_factor:=fit_scale;
   if Terminated=false then infImage.modified:=false;
   if Terminated=false then Synchronize(SendResult);
   if Terminated=false then fit_tmp.Free();
   except
         end;
thrFit:=nil;
end;

procedure TFitThread.SendResult;
begin
if infSettings.full_screen=true then CenterCancel();
frmMain.imgMain.Picture.Bitmap.Assign(fit_tmp);
frmMain.miZoomOut.Enabled:=true;
frmMain.miZoomIn.Enabled:=true;
frmMain.mZoom.Enabled:=true;
frmMain.tbnZoomFit.Enabled:=true;
frmMain.tbnZoomOrig.Enabled:=true;
frmMain.mZMMethods.Enabled:=true;
frmMain.tbnZoom.Enabled:=true;
if frmMain.sbrMain.Panels[1].Text='Resizing...' then frmMain.sbrMain.Panels[1].Text:='';
if infSettings.full_screen=true then Center();
end;

end.
