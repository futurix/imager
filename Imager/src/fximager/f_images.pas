unit f_images;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, StdCtrls,
  hyieutils, imageenview, main, c_locales;
  
procedure FinalizeImage();
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

uses w_custzoom, f_ui;

procedure FinalizeImage();
begin
	case frmMain.nNewBitmap of
    	0:  // Keep previous display state (and zoom to 100% in normal state)
        	begin
            frmMain.img.Zoom := 100;
            end;

        1:  // Do nothing (keep previous zoom and display state)
        	begin
            // well, doing nothing
            end;

        2:  // Set display state to "Fit Big"
        	begin
            if (GetDisplayStyle() <> dsFitBig) then
            	SetDisplayStyle(dsFitBig);
            end;

        3:  // Set display state to "Fit All"
        	begin
            if (GetDisplayStyle() <> dsFitAll) then
            	SetDisplayStyle(dsFitAll);
            end;

        4:  // Set display state to "Normal" and reset zoom to 100%
        	begin
            if ((GetDisplayStyle() <> dsNormal) or (frmMain.img.Zoom <> 100.0)) then
            	SetDisplayStyle(dsNormal);
            end;

        5:  // Set display state to "Normal" and keep previous zoom
        	begin
            if (GetDisplayStyle() <> dsNormal) then
            	SetDisplayStyle(dsNormal, true);
            end;

        else
        	begin
            // same as 0
            frmMain.img.Zoom := 100;
            end;
        end;

    frmMain.img.Repaint();
end;

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
    if ((frmMain.img.Zoom  < 25) and (frmMain.img.Zoom >= 10)) then
    	Zoom(25, true)
    else if ((frmMain.img.Zoom  < 50) and (frmMain.img.Zoom >= 25)) then
    	Zoom(50, true)
    else if ((frmMain.img.Zoom  < 75) and (frmMain.img.Zoom >= 50)) then
    	Zoom(75, true)
    else if ((frmMain.img.Zoom  < 100) and (frmMain.img.Zoom >= 75)) then
    	Zoom(100, true)
    else if ((frmMain.img.Zoom  < 125) and (frmMain.img.Zoom >= 100)) then
    	Zoom(125, true)
    else if ((frmMain.img.Zoom  < 150) and (frmMain.img.Zoom >= 125)) then
    	Zoom(150, true)
    else if ((frmMain.img.Zoom  < 200) and (frmMain.img.Zoom >= 150)) then
    	Zoom(200, true)
    else if ((frmMain.img.Zoom  < 300) and (frmMain.img.Zoom >= 200)) then
    	Zoom(300, true)
    else if ((frmMain.img.Zoom  < 400) and (frmMain.img.Zoom >= 300)) then
    	Zoom(400, true)
    else if (Round(frmMain.img.Zoom * 2) <= 250000) then
		Zoom(Round(frmMain.img.Zoom * 2), true);
end;

// zoom out by 50%
procedure ZoomOut();
begin
    if ((frmMain.img.Zoom <= 600) and (frmMain.img.Zoom > 400)) then
    	Zoom(400, true)
    else if ((frmMain.img.Zoom <= 400) and (frmMain.img.Zoom > 300)) then
    	Zoom(300, true)
    else if ((frmMain.img.Zoom <= 300) and (frmMain.img.Zoom > 200)) then
    	Zoom(200, true)
    else if ((frmMain.img.Zoom <= 200) and (frmMain.img.Zoom > 150)) then
    	Zoom(150, true)
    else if ((frmMain.img.Zoom <= 150) and (frmMain.img.Zoom > 125)) then
    	Zoom(125, true)
    else if ((frmMain.img.Zoom <= 125) and (frmMain.img.Zoom > 100)) then
    	Zoom(100, true)
    else if ((frmMain.img.Zoom <= 100) and (frmMain.img.Zoom > 75)) then
    	Zoom(75, true)
    else if ((frmMain.img.Zoom <= 75) and (frmMain.img.Zoom > 50)) then
    	Zoom(50, true)
    else if ((frmMain.img.Zoom <= 50) and (frmMain.img.Zoom > 25)) then
    	Zoom(25, true)
    else if (Round(frmMain.img.Zoom / 2) >= 1) then
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

            if (infImage.image_type <> itNone) then
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

            if (frmMain.nMouseDrag = 0) then
                frmMain.img.MouseInteract := [miScroll]
            else
                frmMain.img.MouseInteract := [miSelectZoom];

            frmMain.SetHintPanelText(LoadLStr(212));
            end;

        dsFitBig:
        	begin
            if not frmMain.img.AutoShrink then
    			frmMain.img.AutoShrink := true;
            if frmMain.img.AutoStretch then
    			frmMain.img.AutoStretch := false;

            if (infImage.image_type <> itNone) then
            	begin
            	frmMain.mZoom.Enabled := true;
            	frmMain.tbnZoomIn.Enabled := true;
            	frmMain.tbnZoomOut.Enabled := true;
            	frmMain.tbnZoomMisc.Enabled := true;
            	end;

    		frmMain.miDSFitBig.Checked := true;
    		frmMain.piDSFitBig.Checked := true;

            frmMain.img.MouseInteract := [];

            frmMain.SetHintPanelText(LoadLStr(214));
            end;

        dsFitAll:
        	begin
            if not frmMain.img.AutoShrink then
    			frmMain.img.AutoShrink := true;
            if not frmMain.img.AutoStretch then
    			frmMain.img.AutoStretch := true;

            if (infImage.image_type <> itNone) then
            	begin
            	frmMain.mZoom.Enabled := true;
            	frmMain.tbnZoomIn.Enabled := true;
            	frmMain.tbnZoomOut.Enabled := true;
            	frmMain.tbnZoomMisc.Enabled := true;
            	end;

    		frmMain.miDSFitAll.Checked := true;
    	    frmMain.piDSFitAll.Checked := true;

            frmMain.img.MouseInteract := [];

            frmMain.SetHintPanelText(LoadLStr(216));
            end;
    end;

    frmMain.img.Update();
end;

// returns display styles
function GetDisplayStyle():TDisplayStyles;
begin
	if ((frmMain.img.AutoShrink = true) and (frmMain.img.AutoStretch = false)) then
    	Result := dsFitBig
    else if ((frmMain.img.AutoShrink = true) and (frmMain.img.AutoStretch = true)) then
    	Result := dsFitAll
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
