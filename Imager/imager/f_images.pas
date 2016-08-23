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

uses main, globals, w_custzoom, f_ui;

// main zoom procedure
procedure Zoom(scale: double);
var
  tmp: TBitmap;
begin
if scale<>infImage.zoom_factor then
  begin
  if scale<>1 then
    begin
    if scale<0.01 then
      scale:=0.01;

    tmp:=TBitmap.Create();
    SetStretchBltMode(tmp.Canvas.Handle,COLORONCOLOR);
    tmp.PixelFormat:=pf24bit;
    tmp.Width:=Round(infImage.original.Width*scale);
    tmp.Height:=Round(infImage.original.Height*scale);

    SetStretchBltMode(tmp.Canvas.Handle,COLORONCOLOR);
    StretchBlt(tmp.Canvas.Handle,0,0,tmp.Width,tmp.Height,
               infImage.original.Canvas.Handle,
               0,0,infImage.original.Width,infImage.original.Height,SRCCOPY);

    infImage.zoom_factor:=scale;
    infImage.modified:=false;

    if infSettings.full_screen=true then
      CenterCancel();
    frmMain.imgMain.Picture.Bitmap.Assign(tmp);

    if infSettings.full_screen=true then Center();
    FreeAndNil(tmp);
    end
  else
    RestoreOriginal();
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
if infSettings.full_screen then
  Center();
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
if not Assigned(frmCustZoom) then
  begin
  Application.CreateForm(TfrmCustZoom,frmCustZoom);
  frmCustZoom.ShowModal();
  end;
end;

// fits image to window
procedure ZoomToFit();
var
  tmp_scr_width, tmp_scr_height: integer;
  tmp_wh,                 //width-to-height
  tmp_cw, tmp_ch: double; // client-to-width/height
  fit_tmp: TBitmap;
  fit_width, fit_height: integer;
  fit_scale: double;
begin
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
if ((tmp_scr_width/tmp_wh)<=tmp_scr_height) then
  begin
  // width
  fit_width:=tmp_scr_width;
  fit_height:=Round(tmp_scr_width/tmp_wh);
  fit_scale:=tmp_cw;
  end
else
  begin
  // height
  fit_height:=tmp_scr_height;
  fit_width:=Round(tmp_scr_height*tmp_wh);
  fit_scale:=tmp_ch;
  end;

fit_tmp:=TBitmap.Create();
fit_tmp.PixelFormat:=pf24bit;
fit_tmp.Width:=fit_width;
fit_tmp.Height:=fit_height;

SetStretchBltMode(fit_tmp.Canvas.Handle,COLORONCOLOR);
StretchBlt(fit_tmp.Canvas.Handle,0,0,fit_tmp.Width,fit_tmp.Height,
           infImage.original.Canvas.Handle,
           0,0,infImage.original.Width,infImage.original.Height,SRCCOPY);

infImage.zoom_factor:=fit_scale;
infImage.modified:=false;

if infSettings.full_screen=true then
  CenterCancel();
frmMain.imgMain.Picture.Bitmap.Assign(fit_tmp);
if infSettings.full_screen=true then
  Center();

FreeAndNil(fit_tmp);
end;

end.
