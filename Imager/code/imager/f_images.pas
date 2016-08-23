// image transformations
unit f_images;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, StdCtrls,
  hyieutils, imageenview,
  globals;

procedure Zoom(scale: integer; change_style: boolean = false);
procedure ZoomIn();
procedure ZoomOut();
procedure CustomZoom();
procedure SetDisplayStyle(style: TDisplayStyles; careful: boolean = false);
function  GetDisplayStyle():TDisplayStyles;
procedure SetCenter(center: boolean);
function  GetCenter():boolean;
procedure SetScrollbars(show: boolean);
function  GetScrollbars():boolean;


implementation

uses main, w_custzoom, f_ui;

// main zoom procedure
procedure Zoom(scale: integer; change_style: boolean = false);
begin
    if change_style then
   		SetDisplayStyle(dsNormal, true);
        
	frmMain.img.Zoom := scale;
end;

// zoom in by 50%
procedure ZoomIn();
begin
    if (Round(frmMain.img.Zoom * 2) <= 1000000) then
		Zoom(Round(frmMain.img.Zoom * 2), true);
end;

// zoom out by 50%
procedure ZoomOut();
begin
	if (Round(frmMain.img.Zoom / 2) >= 1) then
		Zoom(Round(frmMain.img.Zoom / 2), true);
end;

// sets custom zoom scale
procedure CustomZoom();
begin
	if not Assigned(frmCustZoom) then
  		begin
  		Application.CreateForm(TfrmCustZoom, frmCustZoom);
  		frmCustZoom.ShowModal();
  		end;
end;

// sets display styles
procedure SetDisplayStyle(style: TDisplayStyles; careful: boolean = false);
begin
	case style of
    	dsNormal:
        	begin
            if frmMain.img.AutoShrink then
    			frmMain.img.AutoShrink := false;
            if frmMain.img.AutoStretch then
    			frmMain.img.AutoStretch := false;

            if (infImage.file_type <> ftNone) then
            	begin
            	frmMain.mZoom.Enabled := true;
            	frmMain.tbnZoomIn.Enabled := true;
            	frmMain.tbnZoomOut.Enabled := true;
            	frmMain.tbnZoomMisc.Enabled := true;
            	end;

            if not careful then
            	frmMain.img.Zoom := 100;

    		frmMain.miDSNormal.Checked := true;
    		frmMain.piDSNormal.Checked := true;
            end;

        dsFit:
        	begin
            if not frmMain.img.AutoShrink then
    			frmMain.img.AutoShrink := true;
            if frmMain.img.AutoStretch then
    			frmMain.img.AutoStretch := false;

            if (infImage.file_type <> ftNone) then
            	begin
            	frmMain.mZoom.Enabled := true;
            	frmMain.tbnZoomIn.Enabled := true;
            	frmMain.tbnZoomOut.Enabled := true;
            	frmMain.tbnZoomMisc.Enabled := true;
            	end;

    		frmMain.miDSFit.Checked := true;
    		frmMain.piDSFit.Checked := true;
            end;
    end;

    frmMain.img.Update();
end;

// returns display styles
function GetDisplayStyle():TDisplayStyles;
begin
	if ((frmMain.img.AutoShrink = true) and (frmMain.img.AutoStretch = false)) then
    	Result := dsFit
    else
    	Result := dsNormal;
end;

// sets image centering
procedure SetCenter(center: boolean);
begin
    frmMain.img.Center := center;

    frmMain.miDSCenterImage.Checked := frmMain.img.Center;
    frmMain.piDSCenterImage.Checked := frmMain.img.Center;
end;

// returns image centering
function GetCenter():boolean;
begin
	Result := frmMain.img.Center;
end;

// sets scrollbar display
procedure SetScrollbars(show: boolean);
begin
    if show then
    	frmMain.img.ScrollBars := ssBoth
    else
        frmMain.img.ScrollBars := ssNone;

    frmMain.miDSScrollbars.Checked := GetScrollbars();
    frmMain.piDSScrollbars.Checked := GetScrollbars();
end;

// returns scrollbar display
function GetScrollbars():boolean;
begin
    Result := (frmMain.img.ScrollBars = ssBoth);
end;

end.
