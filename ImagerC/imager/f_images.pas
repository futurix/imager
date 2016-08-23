// image transformations
unit f_images;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms;

procedure Zoom(scale: double);
procedure ZoomIn();
procedure ZoomOut();
procedure RestoreOriginal();
procedure ApplyChanges();
procedure CustomZoom();
procedure ZoomToFit();

implementation

uses main, globals, rsthread, rfthread, w_custzoom, f_ui;

// main zoom procedure
procedure Zoom(scale: double);
begin
if scale<>infImage.zoom_factor then begin
                                    if scale<>1 then begin
                                                     // setting UI
                                                     frmMain.miZoomOut.Enabled:=false;
                                                     frmMain.miZoomIn.Enabled:=false;
                                                     frmMain.mZoom.Enabled:=false;
                                                     frmMain.mZMMethods.Enabled:=false;
                                                     frmMain.tbnZoom.Enabled:=false;
                                                     frmMain.tbnZoomFit.Enabled:=false;
                                                     frmMain.tbnZoomOrig.Enabled:=false;
                                                     frmMain.sbrMain.Panels[1].Text:='Resizing...';
                                                     // starting Thread
                                                     th_scale:=scale;
                                                     thrResize:=TResizeThread.Create(false);
                                                     // dummy IntToStr
                                                     IntToStr(thrResize.ThreadID);
                                                     end
                                    else RestoreOriginal();
                                    end;
end;

// zoom in by 50%
procedure ZoomIn();
begin
Zoom(infImage.zoom_factor*2);
end;

// zoom out by 50%
procedure ZoomOut();
begin
Zoom(infImage.zoom_factor/2);
end;

// restores original image (aka Undo)
procedure RestoreOriginal();
begin
frmMain.imgMain.Picture.Assign(infImage.original);
infImage.zoom_factor:=1;
if infSettings.full_screen then Center();
end;

// applies changes
procedure ApplyChanges();
begin
infImage.original.Assign(frmMain.imgMain.Picture.Bitmap);
infImage.modified:=true;
end;

// sets custom zoom scale
procedure CustomZoom();
begin
if not Assigned(frmCustZoom) then begin
                                  Application.CreateForm(TfrmCustZoom,frmCustZoom);
                                  frmCustZoom.ShowModal();
                                  end;
end;

// fits image to window
procedure ZoomToFit();
var
   tmp_scr_width, tmp_scr_height: integer;
   tmp_wh, //width-to-height
   tmp_cw, tmp_ch: double; // client-to-width/height
begin
// setting UI
frmMain.miZoomOut.Enabled:=false;
frmMain.miZoomIn.Enabled:=false;
frmMain.mZoom.Enabled:=false;
frmMain.mZMMethods.Enabled:=false;
frmMain.tbnZoom.Enabled:=false;
frmMain.tbnZoomFit.Enabled:=false;
frmMain.tbnZoomOrig.Enabled:=false;
frmMain.sbrMain.Panels[1].Text:='Resizing...';
// fix for scroll bars
frmMain.imgMain.Picture.Assign(infImage.null_bitmap);
frmMain.imgMain.Width:=0;
frmMain.imgMain.Height:=0;
// new method
tmp_wh:=infImage.original.Width/infImage.original.Height;
tmp_scr_width:=(frmMain.sbxMain.ClientRect.Right-frmMain.sbxMain.ClientRect.Left);
tmp_scr_height:=(frmMain.sbxMain.ClientRect.Bottom-frmMain.sbxMain.ClientRect.Top);
tmp_cw:=tmp_scr_width/infImage.original.Width;
tmp_ch:=tmp_scr_height/infImage.original.Height;
if ((tmp_scr_width/tmp_wh)<=tmp_scr_height) then begin
                                                 // width
                                                 fit_width:=tmp_scr_width;
                                                 fit_height:=Round(tmp_scr_width/tmp_wh);
                                                 fit_scale:=tmp_cw;
                                                 end
else begin
     // height
     fit_height:=tmp_scr_height;
     fit_width:=Round(tmp_scr_height*tmp_wh);
     fit_scale:=tmp_ch;
     end;
// starting Thread
thrFit:=TFitThread.Create(false);
// dummy IntToStr
IntToStr(thrFit.ThreadID);
end;

end.
