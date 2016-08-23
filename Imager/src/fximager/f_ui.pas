unit f_ui;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UxTheme,
  ShellAPI, c_const;

procedure ApplyToolbarSkin();
procedure ToggleMainToolbar(strict: boolean = false; visible: boolean = true);
procedure ToggleStatusbar(strict: boolean = false; visible: boolean = true);
procedure Able();
procedure FSSavePos();
procedure Header();
procedure ToggleFS();


implementation

uses main, f_nav, f_graphics, f_tools, w_show, f_images;

procedure ApplyToolbarSkin();
var
	res: TResourceStream;
    bmp: TBitmap;
begin
	res := TResourceStream.Create(HInstance, 'TBSA', 'RT_BITMAP');

    bmp := TBitmap.Create();
    bmp.LoadFromStream(res);

    frmMain.imlStd.Height := bmp.Height;
    frmMain.imlStd.Width := bmp.Height;
    frmMain.imlStd.Clear();
    frmMain.imlStd.AddMasked(bmp, bmp.Canvas.Pixels[0,0]);

    FreeAndNil(bmp);
    FreeAndNil(res);

	res := TResourceStream.Create(HInstance, 'TBSD', 'RT_BITMAP');

    bmp := TBitmap.Create();
    bmp.LoadFromStream(res);

    frmMain.imlDis.Height := bmp.Height;
    frmMain.imlDis.Width := bmp.Height;
    frmMain.imlDis.Clear();
    frmMain.imlDis.AddMasked(bmp, bmp.Canvas.Pixels[0,0]);

    FreeAndNil(bmp);
    FreeAndNil(res);

    frmMain.itbMain.ButtonHeight := frmMain.imlStd.Height + 6;
    frmMain.itbMain.ButtonWidth := frmMain.imlStd.Height + 8;
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

procedure Able();
var
	i: integer;
    is_file, is_writable, is_filled: boolean;
begin
    is_file := ((infImage.image_type <> itUnsaved) and (infImage.image_type <> itNone));
    is_writable := not ((infImage.image_type = itAnimated) or (infImage.image_type = itMulti) or (infImage.image_type = itNone));
    is_filled := (infImage.image_type <> itNone);

	frmMain.miReopen.Enabled := is_file;

	frmMain.miSaveAs.Enabled := is_filled;
	frmMain.tbnSave.Enabled := is_filled;

	frmMain.miClose.Enabled := is_filled;
	frmMain.piClose.Enabled := is_filled;
	frmMain.tbnClose.Enabled := is_filled;

	if (frmMain.mExport.Count > 0) then
    	frmMain.mExport.Enabled := is_filled
    else
    	frmMain.mExport.Enabled := false;

	frmMain.miPrint.Enabled := is_filled;
	frmMain.miPrintPreview.Enabled := is_filled;
	frmMain.tbnPrint.Enabled := is_filled;

	frmMain.miCopy.Enabled := is_filled;
	frmMain.tbnCopy.Enabled := is_filled;

    frmMain.mZoom.Enabled := is_filled;
    frmMain.miZoomIn.Enabled := is_filled;
    frmMain.miZoomOut.Enabled := is_filled;
    frmMain.tbnZoomIn.Enabled := is_filled;
    frmMain.tbnZoomOut.Enabled := is_filled;
	frmMain.tbnZoomMisc.Enabled := is_filled;
    frmMain.tbnZoomFit.Enabled := is_filled;
	frmMain.tbnRotate.Enabled := is_filled;

	frmMain.miEditor.Enabled := is_writable;
	frmMain.tbnEditor.Enabled := is_writable;

	for i := 0 to (frmMain.mTools.Count - 1) do
 		begin
  		if (frmMain.mTools.Items[i].Tag <> 7) then
        	frmMain.mTools.Items[i].Enabled := is_filled
        else
        	frmMain.mTools.Items[i].Enabled := true;
  		end;

    frmMain.miInfo.Enabled := is_filled;
	frmMain.tbnInfo.Enabled := is_filled;

	frmMain.miGoBack.Enabled := is_file;
	frmMain.miGoForward.Enabled := is_file;
	frmMain.miGoFirst.Enabled := is_file;
	frmMain.miGoLast.Enabled := is_file;
	frmMain.miGoRandom.Enabled := is_file;
	frmMain.tbnGoBack.Enabled := is_file;
	frmMain.tbnGoForward.Enabled := is_file;
    frmMain.tbnGoRandom.Enabled := is_file;
	frmMain.piBack.Enabled := is_file;
	frmMain.piForward.Enabled := is_file;

	frmMain.miShow.Enabled := is_file;
	frmMain.miStartShow.Enabled := is_file;

	frmMain.miFMove.Enabled := is_file;
	frmMain.miFRename.Enabled := is_file;
	frmMain.miFCopy.Enabled := is_file;
	frmMain.miFDelete.Enabled := is_file;
end;

procedure FSRestorePos();
begin
	reg.OpenKey(sSettings, true);

	case reg.RInt('FS_State', 0) of
  		0: frmMain.WindowState := wsNormal;
  		1: frmMain.WindowState := wsMaximized;
  	end;

	// common part
	case reg.RInt('FS_TBMain', 0) of
  		0: frmMain.tbrMain.Visible := false;
  		1: frmMain.tbrMain.Visible := true;
  	end;

    case reg.RInt('FS_TBStatus', 0) of
  		0: frmMain.sbrMain.Visible := false;
  		1: frmMain.sbrMain.Visible := true;
  	end;

    if (frmMain.WindowState <> wsMaximized) then
  		begin
  		frmMain.Top := reg.RInt('FS_Top', 0);
  		frmMain.Left := reg.RInt('FS_Left', 0);
  		frmMain.Width := reg.RInt('FS_Width', 550);
  		frmMain.Height := reg.RInt('FS_Height', 400);
  		end;
        
	reg.CloseKey();
end;

// saves temp window position to ini
procedure FSSavePos();
begin
	reg.OpenKey(sSettings, true);

	case frmMain.WindowState of
  		wsMaximized: reg.WriteInteger('FS_State', 1);
  	else
    	begin
   		reg.WriteInteger('FS_State', 0);
        reg.WriteInteger('FS_Top', frmMain.Top);
    	reg.WriteInteger('FS_Left', frmMain.Left);
    	reg.WriteInteger('FS_Width', frmMain.Width);
    	reg.WriteInteger('FS_Height', frmMain.Height);
    	end;
	end;

	if frmMain.tbrMain.Visible then
    	reg.WriteInteger('FS_TBMain', 1)
  	else
    	reg.WriteInteger('FS_TBMain', 0);

    if frmMain.sbrMain.Visible then
    	reg.WriteInteger('FS_TBStatus', 1)
  	else
    	reg.WriteInteger('FS_TBStatus', 0);

    reg.CloseKey();
end;

// sets Imager's window header
procedure Header();
begin
	if (infImage.path <> '') then
  		begin
  		if frmMain.bFullPathInTitle then
    		begin
    		// full path
    		Application.Title := (infImage.path + ' - ' + sAppName);
    		frmMain.Caption := (infImage.path + ' - ' + sAppName);
    		end
  		else
    		begin
    		Application.Title := (ExtractFileName(infImage.path) + ' - ' + sAppName);
    		frmMain.Caption := (ExtractFileName(infImage.path) + ' - ' + sAppName);
    		end;
  		end
	else
  		begin
  		Application.Title := sAppName;
  		frmMain.Caption := sAppName;
  		end;
end;

// full-screen toggle
procedure ToggleFS();
begin
	if not frmMain.full_screen then
  		begin
  		// starting FS
  		FSSavePos();

  		reg.OpenKey(sSettings, true);
  		frmMain.sbxMain.Color := StringToColor(reg.RStr('FSColor', 'clBlack'));
        frmMain.img.Background := frmMain.sbxMain.Color;
  		reg.CloseKey();

  		frmMain.miFullScreen.Checked := true;
  		frmMain.tbnFullScreen.Down := true;
  		frmMain.piFullScreen.Checked := true;

  		frmMain.Menu := nil;
  		frmMain.tbrMain.Visible := false;
  		frmMain.sbrMain.Visible := false;

        frmMain.WindowState := wsMaximized;
  		frmMain.sbxMain.BorderStyle := bsNone;
        frmMain.BorderStyle := bsNone;

  		frmMain.piMinimize.Visible := true;
  		frmMain.full_screen := true;
  		end
    else
  		begin
  		// closing FS
  		frmMain.miFullScreen.Checked := false;
  		frmMain.tbnFullScreen.Down := false;
  		frmMain.piFullScreen.Checked := false;

  		reg.OpenKey(sSettings, true);
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
  		frmMain.full_screen := false;
  		end;

    if not starting then
    	frmMain.img.SetFocus();

	// restore drag-n-drop support
    DragAcceptFiles(frmMain.Handle, true);
end;

end.
