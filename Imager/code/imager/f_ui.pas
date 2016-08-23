// UI routines
unit f_ui;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UxTheme,
  ShellAPI, c_const;
  
procedure ApplyToolbarSkin(large: boolean = false);
procedure ToggleMainToolbar(strict: boolean = false; visible: boolean = true);
procedure ToggleStatusbar(strict: boolean = false; visible: boolean = true);
procedure Able(action: boolean);
procedure Lock(action: boolean; read_only: boolean = false; read_anim: boolean = false);
procedure FSSavePos();
procedure Header();
procedure ToggleFS();
procedure MirrorHint();
procedure IdleUI();


implementation

uses main, globals, f_clipboard, f_reg, f_nav, f_graphics, f_tools, w_show,
  f_images;

procedure ApplyToolbarSkin(large: boolean = false);
var
	res: TResourceStream;
    bmp: TBitmap;
begin
	if large then
		res := TResourceStream.Create(HInstance, 'TBLA', 'RT_BITMAP')
    else
    	res := TResourceStream.Create(HInstance, 'TBSA', 'RT_BITMAP');

    bmp := TBitmap.Create();
    bmp.LoadFromStream(res);

    frmMain.imlMain.Height := bmp.Height;
    frmMain.imlMain.Width := bmp.Height;
    frmMain.imlMain.Clear();
    frmMain.imlMain.AddMasked(bmp, bmp.Canvas.Pixels[0,0]);

    FreeAndNil(bmp);
    FreeAndNil(res);

	if large then
		res := TResourceStream.Create(HInstance, 'TBLD', 'RT_BITMAP')
    else
    	res := TResourceStream.Create(HInstance, 'TBSD', 'RT_BITMAP');

    bmp := TBitmap.Create();
    bmp.LoadFromStream(res);

    frmMain.imlDisabled.Height := bmp.Height;
    frmMain.imlDisabled.Width := bmp.Height;
    frmMain.imlDisabled.Clear();
    frmMain.imlDisabled.AddMasked(bmp, bmp.Canvas.Pixels[0,0]);

    FreeAndNil(bmp);
    FreeAndNil(res);

    frmMain.itbMain.ButtonHeight := frmMain.imlMain.Height + 6;
    frmMain.itbMain.ButtonWidth := frmMain.imlMain.Height + 8;
end;

// toggles main toolbar
procedure ToggleMainToolbar(strict: boolean = false; visible: boolean = true);
begin
	if strict then
  		begin
  		// reading visible value
  		frmMain.tbrMain.Visible := visible;
  		frmMain.miToolbar.Checked := visible;
  		frmMain.piTBMain.Checked := visible;
  		end
	else
  		begin
  		// simple toggling on/off
  		if frmMain.tbrMain.Visible then
    		begin
    		// off
    		frmMain.tbrMain.Visible := false;
    		frmMain.miToolbar.Checked := false;
            frmMain.piTBMain.Checked := false;
    		end
  		else
    		begin
    		// on
    		frmMain.tbrMain.Visible := true;
    		frmMain.miToolbar.Checked := true;
    		frmMain.piTBMain.Checked := true;
    		end;
  		end;
end;

// toggles statusbar
procedure ToggleStatusbar(strict: boolean = false; visible: boolean = true);
begin
	if strict then
  		begin
  		// reading visible value
  		frmMain.sbrMain.Visible := visible;
  		frmMain.miStatusBar.Checked := visible;
  		frmMain.piStatusBar.Checked := visible;
  		end
	else
  		begin
  		// simple toggling on/off
  		if frmMain.sbrMain.Visible then
    		begin
    		// off
    		frmMain.sbrMain.Visible := false;
    		frmMain.miStatusBar.Checked := false;
    		frmMain.piStatusBar.Checked := false;
    		end
  		else
    		begin
    		// on
    		frmMain.sbrMain.Visible := true;
    		frmMain.miStatusBar.Checked := true;
    		frmMain.piStatusBar.Checked := true;
    		end;
  		end;
end;

// locks UI on file presence
procedure Able(action: boolean);
var
	i: integer;
begin
	frmMain.miReopen.Enabled := action;
	frmMain.miSaveAs.Enabled := action;
	frmMain.miClose.Enabled := action;
	frmMain.piClose.Enabled := action;
	if (frmMain.mExport.Count > 0) then
    	frmMain.mExport.Enabled := action
    else
    	frmMain.mExport.Enabled := false;
	frmMain.miPrint.Enabled := action;
	frmMain.miPrintPreview.Enabled := action;
	frmMain.miCopy.Enabled := action;

    frmMain.mZoom.Enabled := action;
    frmMain.miZoomIn.Enabled := action;
    frmMain.miZoomOut.Enabled := action;
    frmMain.tbnZoomIn.Enabled := action;
    frmMain.tbnZoomOut.Enabled := action;
	frmMain.tbnZoomMisc.Enabled := action;
	frmMain.tbnRotate.Enabled := action;

	frmMain.miFiltersDialog.Enabled := action;
	for i := 0 to (frmMain.mTools.Count - 1) do
 		begin
  		if (frmMain.mTools.Items[i].Tag <> 7) then
        	frmMain.mTools.Items[i].Enabled := action
        else
        	frmMain.mTools.Items[i].Enabled := true;
  		end;
    frmMain.miInfo.Enabled := action;

	frmMain.tbnFilters.Enabled := action;
	frmMain.miGoBack.Enabled := action;
	frmMain.miGoForward.Enabled := action;
	frmMain.miGoFirst.Enabled := action;
	frmMain.miGoLast.Enabled := action;
	frmMain.miGoRandom.Enabled := action;
	frmMain.tbnSave.Enabled := action;
	frmMain.tbnClose.Enabled := action;
	frmMain.tbnPrint.Enabled := action;
	frmMain.tbnCopy.Enabled := action;
	frmMain.tbnInfo.Enabled := action;
	frmMain.tbnGoBack.Enabled := action;
	frmMain.tbnGoForward.Enabled := action;
	frmMain.tbnGoRandom.Enabled := action;
	frmMain.miShow.Enabled := action;
	frmMain.miStartSlideShow.Enabled := action;
	frmMain.piBack.Enabled := action;
	frmMain.piForward.Enabled := action;
	frmMain.miFMove.Enabled := action;
	frmMain.miFRename.Enabled := action;
	frmMain.miFCopy.Enabled := action;
	frmMain.miFDelete.Enabled := action;
end;

// locks UI on special file types
procedure Lock(action: boolean; read_only: boolean = false; read_anim: boolean = false);
var
	i: integer;
begin
    if action then
    	read_only := true;

    if read_only then
    	read_anim := true;

	frmMain.miSaveAs.Enabled := action;
	if (frmMain.mExport.Count > 0) then
    	frmMain.mExport.Enabled := action
  	else
    	frmMain.mExport.Enabled := false;
	frmMain.miPrint.Enabled := read_only;
	frmMain.miPrintPreview.Enabled := read_only;
	frmMain.miCopy.Enabled := read_only;

    frmMain.mZoom.Enabled := read_anim;
    frmMain.miZoomIn.Enabled := read_anim;
    frmMain.miZoomOut.Enabled := read_anim;
    frmMain.tbnZoomIn.Enabled := read_anim;
    frmMain.tbnZoomOut.Enabled := read_anim;
	frmMain.tbnZoomMisc.Enabled := read_anim;
	frmMain.tbnRotate.Enabled := read_anim;

    frmMain.miFiltersDialog.Enabled := action;
	for i := 0 to (frmMain.mTools.Count - 1) do
  		begin
  		if frmMain.mTools.Items[i].Tag <> 7 then
        	frmMain.mTools.Items[i].Enabled := action
    	else
        	frmMain.mTools.Items[i].Enabled := true;
  		end;
    frmMain.miInfo.Enabled := read_anim;
	frmMain.tbnFilters.Enabled := action;
	frmMain.tbnSave.Enabled := action;
	frmMain.tbnPrint.Enabled := read_only;
	frmMain.tbnCopy.Enabled := read_only;
	frmMain.miInfo.Enabled := read_only;
    frmMain.tbnInfo.Enabled := read_only;
	frmMain.miFMove.Enabled := read_only;
	frmMain.miFRename.Enabled := read_only;
	frmMain.miFCopy.Enabled := read_only;
	frmMain.miFDelete.Enabled := read_only;
end;

// loads temp window position from ini
procedure FSRestorePos();
begin
	reg.OpenKey(sReg + '\FullScreen', true);

	case reg.RInt('State', 0) of
  		0: frmMain.WindowState := wsNormal;
  		1: frmMain.WindowState := wsMaximized;
  	end;

	// common part
	case reg.RInt('TBMain', 0) of
  		0: frmMain.tbrMain.Visible := false;
  		1: frmMain.tbrMain.Visible := true;
  	end;

    case reg.RInt('TBStatus', 0) of
  		0: frmMain.sbrMain.Visible := false;
  		1: frmMain.sbrMain.Visible := true;
  	end;

    if (frmMain.WindowState <> wsMaximized) then
  		begin
  		frmMain.Top := reg.RInt('Top', 0);
  		frmMain.Left := reg.RInt('Left', 0);
  		frmMain.Width := reg.RInt('Width', 550);
  		frmMain.Height := reg.RInt('Height', 400);
  		end;
        
	reg.CloseKey();
end;

// saves temp window position to ini
procedure FSSavePos();
begin
	reg.OpenKey(sReg + '\FullScreen', true);

	case frmMain.WindowState of
  		wsMaximized: reg.WriteInteger('State', 1);
  	else
    	begin
   		reg.WriteInteger('State', 0);
        reg.WriteInteger('Top', frmMain.Top);
    	reg.WriteInteger('Left', frmMain.Left);
    	reg.WriteInteger('Width', frmMain.Width);
    	reg.WriteInteger('Height', frmMain.Height);
    	end;
	end;

	if frmMain.tbrMain.Visible then
    	reg.WriteInteger('TBMain', 1)
  	else
    	reg.WriteInteger('TBMain', 0);

    if frmMain.sbrMain.Visible then
    	reg.WriteInteger('TBStatus', 1)
  	else
    	reg.WriteInteger('TBStatus', 0);

    reg.CloseKey();
end;

// sets Imager's window header
procedure Header();
begin
	if (infImage.path <> '') then
  		begin
  		if (opFullPathInTitle in infSettings.options) then
    		begin
    		// full path
    		Application.Title := (infImage.path + ' - Futuris Imager');
    		frmMain.Caption := (infImage.path + ' - Futuris Imager');
    		end
  		else
    		begin
    		Application.Title := (ExtractFileName(infImage.path) + ' - Futuris Imager');
    		frmMain.Caption := (ExtractFileName(infImage.path) + ' - Futuris Imager');
    		end;
  		end
	else
  		begin
  		Application.Title := 'Futuris Imager';
  		frmMain.Caption := 'Futuris Imager';
  		end;
end;

// full-screen toggle
procedure ToggleFS();
begin
	if (infSettings.full_screen = false) then
  		begin
  		// starting FS
  		frmMain.Hide(); // hiding form to hide blinking
  		FSSavePos();

  		reg.OpenKey(sReg + '\Main', true);
  		frmMain.sbxMain.Color := StringToColor(reg.RStr('FSColor', 'clBlack'));
        frmMain.img.Background := frmMain.sbxMain.Color;
  		reg.CloseKey();

  		frmMain.miFullScreen.Checked := true;
  		frmMain.tbnFullScreen.Down := true;
  		frmMain.piFullScreen.Checked := true;
  		frmMain.Menu := nil;
  		frmMain.tbrMain.Visible := false;
  		frmMain.sbrMain.Visible := false;
  		frmMain.sbxMain.BorderStyle := bsNone;
        frmMain.BorderStyle := bsNone;
  		frmMain.WindowState := wsMaximized;
  		frmMain.piMinimize.Visible := true;
  		infSettings.full_screen := true;

		frmMain.Show();
  		end
    else
  		begin
  		// closing FS
  		frmMain.Hide();
  		frmMain.miFullScreen.Checked := false;
  		frmMain.tbnFullScreen.Down := false;
  		frmMain.piFullScreen.Checked := false;

  		reg.OpenKey(sReg + '\Main', true);
  		frmMain.sbxMain.Color := StringToColor(reg.RStr('Color', 'clAppWorkSpace'));
        frmMain.img.Background := frmMain.sbxMain.Color;
  		reg.CloseKey();

  		frmMain.WindowState := wsNormal;
  		frmMain.BorderStyle := bsSizeable;
  		frmMain.Menu := frmMain.mnuMain;
  		frmMain.tbrMain.Visible := true;
  		frmMain.sbrMain.Visible := true;

        if (UseThemes() = false) then
  			frmMain.sbxMain.BorderStyle := bsSingle;
  		FSRestorePos();
  		frmMain.piMinimize.Visible := false;
  		infSettings.full_screen := false;

  		frmMain.Show();
  		end;

	// restore drag-n-drop support
    DragAcceptFiles(frmMain.Handle, true);
end;

// hint-to-statusbar
procedure MirrorHint();
begin
	frmMain.sbrMain.Panels[1].Text := GetLongHint(Application.Hint);
end;

// UI maintenance during Idle
procedure IdleUI();
begin
	// setting header
	Header();

	// setting undo
	if (frmMain.img.Proc.CanUndo) then
    	begin
    	frmMain.miUndo.Enabled := true;
    	frmMain.tbnUndo.Enabled := true;
    	end
	else
		begin
    	frmMain.miUndo.Enabled := false;
    	frmMain.tbnUndo.Enabled := false;
    	end;

	// "Paste" button routine
	if IsBitmapInCB() then
  		begin
  		frmMain.tbnPaste.Enabled := true;
  		frmMain.miPaste.Enabled := true;
  		end
	else
  		begin
  		frmMain.tbnPaste.Enabled := false;
  		frmMain.miPaste.Enabled := false;
  		end;

	// file navigation disabling, if only 1 file
	if ((files.Count < 2) or (infImage.file_type <> ftLocal)) then
  		begin
  		frmMain.tbnGoBack.Enabled := false;
  		frmMain.tbnGoForward.Enabled := false;
  		frmMain.tbnGoRandom.Enabled := false;
  		frmMain.piBack.Enabled := false;
  		frmMain.piForward.Enabled := false;
  		frmMain.miGoBack.Enabled := false;
  		frmMain.miGoForward.Enabled := false;
  		frmMain.miGoFirst.Enabled := false;
  		frmMain.miGoLast.Enabled := false;
  		frmMain.miGoRandom.Enabled := false;
  		frmMain.miShow.Enabled := false;
  		frmMain.miStartSlideShow.Enabled := false;
  		if Assigned(frmShow) then
    		frmShow.Close();
  		end
	else
  		begin
 		frmMain.tbnGoBack.Enabled := true;
  		frmMain.tbnGoForward.Enabled := true;
  		frmMain.tbnGoRandom.Enabled := true;
  		frmMain.piBack.Enabled := true;
  		frmMain.piForward.Enabled := true;
  		frmMain.miGoBack.Enabled := true;
  		frmMain.miGoForward.Enabled := true;
  		frmMain.miGoFirst.Enabled := true;
  		frmMain.miGoLast.Enabled := true;
  		frmMain.miGoRandom.Enabled := true;
  		frmMain.miShow.Enabled := true;
  		frmMain.miStartSlideShow.Enabled := true;
  		end;

	// zoom status
	if infImage.file_type = ftNone then
  		frmMain.sbrMain.Panels[0].Width := 0
	else
  		begin
  		frmMain.sbrMain.Panels[0].Width := 75;
  		frmMain.sbrMain.Panels[0].Text := IntToStr(Round(frmMain.img.Zoom)) + '%';
  		end;

	// MRU stuff
	if infImage.path <> '' then
  		begin
  		if frmMain.MRU.Files.Count < 2 then
        	frmMain.tbnLast.Enabled := false
        else
        	frmMain.tbnLast.Enabled := true;
  		end
	else
  		begin
  		if frmMain.MRU.Files.Count < 1 then
        	frmMain.tbnLast.Enabled := false
        else
        	frmMain.tbnLast.Enabled := true;
  		end;
end;

end.
