library f_core;

uses
  SysUtils, Windows, Classes, Graphics, Forms, Dialogs,
  ImageEnIO, ImageEnProc, hyieutils,
  c_const, c_utils,
  JPEG2Ksave in 'JPEG2Ksave.pas' {frmJPsave},
  TIFFsave in 'TIFFsave.pas' {frmTIFFsave},
  JPEGsave in 'JPEGsave.pas' {frmJPEGsave};

var
	mio: TImageEnIO;
    gframe: cardinal = 0;
    gframes: cardinal = 0;
    gfile: string = '';

	pio: TImageEnIO;
    gpage: cardinal = 0;
    gpages: cardinal = 0;
    gfilep: string = '';
    gext: string = '';

{$R *.RES}


function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
	func(PT_FOPEN, 'jpg', ' ');
	func(PT_FOPEN, 'jpeg', ' ');
	func(PT_FOPEN, 'jfif', ' ');
	func(PT_FOPEN, 'jp2', ' ');
	func(PT_FOPEN, 'jpc', ' ');
	func(PT_FOPEN, 'j2k', ' ');
    func(PT_FOPEN, 'j2c', ' ');
    func(PT_FOPEN, 'gif', ' ');
	func(PT_FOPEN, 'pbm', ' ');
	func(PT_FOPEN, 'pgm', ' ');
	func(PT_FOPEN, 'ppm', ' ');
	func(PT_FOPEN, 'bmp', ' ');
	func(PT_FOPEN, 'emf', ' ');
	func(PT_FOPEN, 'wmf', ' ');
	func(PT_FOPEN, 'pcx', ' ');
	func(PT_FOPEN, 'dcx', ' ');
	func(PT_FOPEN, 'png', ' ');
	func(PT_FOPEN, 'tga', ' ');
	func(PT_FOPEN, 'tif', ' ');
	func(PT_FOPEN, 'tiff', ' ');

	func(PT_FOPENMULTI, 'dcx', ' ');
	func(PT_FOPENMULTI, 'tif', ' ');
	func(PT_FOPENMULTI, 'tiff', ' ');

    func(PT_FOPENANIM, 'gif', ' ');

    func(PT_FSAVE, 'jp2', ' ');
    func(PT_FSAVE, 'j2k', ' ');
    func(PT_FSAVE, 'bmp', ' ');
	func(PT_FSAVE, 'jpg', ' ');
	func(PT_FSAVE, 'pcx', ' ');
	func(PT_FSAVE, 'png', ' ');
	func(PT_FSAVE, 'pbm', ' ');
	func(PT_FSAVE, 'pgm', ' ');
	func(PT_FSAVE, 'ppm', ' ');
	func(PT_FSAVE, 'tga', ' ');
	func(PT_FSAVE, 'tif', ' ');

	func(PT_FDESCR, 'jpg', 'Joint Photographic Experts Group (*.jpg)');
	func(PT_FDESCR, 'jpeg', 'Joint Photographic Experts Group (*.jpeg)');
	func(PT_FDESCR, 'jfif', 'Joint Photographic Experts Group (*.jfif)');
	func(PT_FDESCR, 'jp2', 'JPEG 2000 (*.jp2)');
	func(PT_FDESCR, 'jpc', 'JPEG 2000 (*.jpc)');
	func(PT_FDESCR, 'j2k', 'JPEG 2000 (*.j2k)');
	func(PT_FDESCR, 'j2c', 'JPEG 2000 (*.j2c)');
    func(PT_FDESCR, 'gif', 'CompuServe GIF (*.gif)');
	func(PT_FDESCR, 'pbm', 'Portable bitmap format - black and white (*.pbm)');
	func(PT_FDESCR, 'pgm', 'Portable bitmap format - grayscale (*.pgm)');
	func(PT_FDESCR, 'ppm', 'Portable bitmap format - true color (*.ppm)');
	func(PT_FDESCR, 'bmp', 'Windows Bitmap (*.bmp)');
	func(PT_FDESCR, 'emf', 'Windows Metafile (*.wmf)');
	func(PT_FDESCR, 'wmf', 'Enhanced Metafile (*.emf)');
	func(PT_FDESCR, 'pcx', 'ZSoft Paintbrush (*.pcx)');
	func(PT_FDESCR, 'dcx', 'ZSoft Multi-page Paintbrush (*.dcx)');
	func(PT_FDESCR, 'png', 'Portable Network Graphics (*.png)');
	func(PT_FDESCR, 'tga', 'Truevision Targa (*.tga)');
	func(PT_FDESCR, 'tif', 'Tag Image File Format (*.tif)');
	func(PT_FDESCR, 'tiff', 'Tag Image File Format (*.tiff)');

    func(PT_FIMPORT, 'Get Image from Digital Camera or Scanner...', ' ');

	func(PT_FFILTER, 'Flip Horizontal', ' ');
	func(PT_FFILTER, 'Flip Vertical', ' ');
	func(PT_FFILTER, 'Invert', ' ');

    func(PT_FTOOL, 'Create HTML for Image...', ' ');

	Result := true;
end;

function FIPISopen(path, ext: PChar; app: THandle):hBitmap; stdcall;
var
	bmp: TBitmap;
    io: TImageEnIO;
begin
    Result := 0;

    io := TImageEnIO.Create(nil);
    bmp := TBitmap.Create();

    io.LoadFromFile(String(path));

    if not io.Aborting then
    	begin
        bmp.Assign(io.IEBitmap.VclBitmap);
        bmp.PixelFormat := pf24bit;
        Result := bmp.ReleaseHandle();
        end;

    FreeAndNil(io);
    FreeAndNil(bmp);
end;

function FIPISsave(path, ext: PChar; app, wnd: THandle; img: hBitmap):integer; stdcall;
var
	bmp: TBitmap;
    mex: string;
    io: TImageEnIO;
begin
    Result := 0;

	bmp := TBitmap.Create();
    bmp.Handle := img;
    bmp.PixelFormat := pf24bit;

    mex := ExtractExt(String(path));

    if ((mex = 'jp2') or (mex = 'j2k')) then
    	begin
        frmJPsave := TfrmJPsave.Create(nil);
		frmJPsave.ShowModal();

        if jp2_confirm then
        	begin
            io := TImageEnIO.Create(nil);
            io.IEBitmap.Assign(bmp);

            if frmJPsave.cbxLossless.Checked then
            	io.Params.J2000_Rate := 1.0
            else
            	io.Params.J2000_Rate := (frmJPsave.tbrQuality.Position / 100);

            if (io.Params.J2000_Rate < 0.001) then
            	io.Params.J2000_Rate := 0.001;

            if (mex = 'j2k') then
            	io.SaveToFileJ2K(String(path))
            else
            	io.SaveToFileJP2(String(path));

            if not io.Aborting then
            	Result := 1;

            FreeAndNil(io);
            end;

        FreeAndNil(frmJPsave);
        end
        
    else if (mex = 'bmp') then
    	begin
        bmp.SaveToFile(String(path));
        Result := 1;
        end

    else if (mex = 'jpg') then
    	begin
  		frmJPEGsave := TfrmJPEGsave.Create(nil);
  		frmJPEGsave.ShowModal();

        if jpeg_confirm then
    		begin
            io := TImageEnIO.Create(nil);
            io.IEBitmap.Assign(bmp);

    		if (frmJPEGsave.tbrQuality.Position > 0) then
            	io.Params.JPEG_Quality := frmJPEGsave.tbrQuality.Position
            else
                io.Params.JPEG_Quality := 1;
            io.Params.JPEG_Progressive := frmJPEGsave.cbxProgressive.Checked;
            io.Params.JPEG_OptimalHuffman := frmJPEGsave.cbxOptimized.Checked;

            io.SaveToFileJpeg(String(path));

            if not io.Aborting then
            	Result := 1;

            FreeAndNil(io);
            end;

        FreeAndNil(frmJPEGsave);
        end

    else if (mex = 'pcx') then
    	begin
        io := TImageEnIO.Create(nil);
        io.IEBitmap.Assign(bmp);

        io.Params.PCX_Compression := ioPCX_RLE;
        io.SaveToFilePCX(String(path));

        if not io.Aborting then
        	Result := 1;

        FreeAndNil(io);
        end

    else if (mex = 'png') then
    	begin
        io := TImageEnIO.Create(nil);
        io.IEBitmap.Assign(bmp);

        io.Params.PNG_Filter := ioPNG_FILTER_SUB;
        io.Params.PNG_Compression := 9;
        io.SaveToFilePNG(String(path));

        if not io.Aborting then
        	Result := 1;

        FreeAndNil(io);
        end

    else if ((mex = 'pbm') or (mex = 'pgm') or (mex = 'ppm')) then
    	begin
        io := TImageEnIO.Create(nil);
        io.IEBitmap.Assign(bmp);

        io.IEBitmap.DefaultDitherMethod := ieOrdered;

        if (mex = 'pbm') then
        	begin
            io.IEBitmap.PixelFormat := ie1g;
            io.Params.BitsPerSample := 1;
            io.Params.SamplesPerPixel := 1;
            end
        else if (mex = 'pgm') then
        	begin
            io.IEBitmap.PixelFormat := ie8g;
            io.Params.BitsPerSample := 8;
            io.Params.SamplesPerPixel := 1;
            end
        else
        	begin
            io.Params.BitsPerSample := 8;
            io.Params.SamplesPerPixel := 3;
            end;

        io.SaveToFilePXM(String(path));

        if not io.Aborting then
        	Result := 1;

        FreeAndNil(io);
        end

    else if (mex = 'tga') then
    	begin
        io := TImageEnIO.Create(nil);
        io.IEBitmap.Assign(bmp);

        io.Params.TGA_Compressed := true;
        io.SaveToFileTGA(String(path));

        if not io.Aborting then
        	Result := 1;

        FreeAndNil(io);
        end

    else if (mex = 'tif') then
    	begin
        frmTIFFsave := TfrmTIFFsave.Create(nil);
        frmTIFFsave.ShowModal();

        if tiff_confirm then
    		begin
            io := TImageEnIO.Create(nil);
            io.IEBitmap.Assign(bmp);

            io.IEBitmap.DefaultDitherMethod := ieOrdered;

            if frmTIFFsave.rbnCNone.Checked then
            	io.Params.TIFF_Compression := ioTIFF_UNCOMPRESSED
            else if frmTIFFsave.rbnCLZW.Checked then
                io.Params.TIFF_Compression := IoTIFF_LZW
            else if frmTIFFsave.rbnCJPEG.Checked then
                begin
                io.Params.TIFF_Compression := ioTIFF_JPEG;

      			if (frmTIFFsave.tbrQuality.Position > 0) then
        			io.Params.TIFF_JPEGQuality := frmTIFFsave.tbrQuality.Position
      			else
        			io.Params.TIFF_JPEGQuality := 1;
                end
            else if frmTIFFsave.rbnCPackBits.Checked then
                io.Params.TIFF_Compression := ioTIFF_PACKBITS
            else if frmTIFFsave.rbnCG31.Checked then
                begin
                io.IEBitmap.PixelFormat := ie1g;
                io.Params.TIFF_Compression := ioTIFF_G3FAX1D;
                end
            else if frmTIFFsave.rbnCG32.Checked then
                begin
                io.IEBitmap.PixelFormat := ie1g;
                io.Params.TIFF_Compression := ioTIFF_G3FAX2D;
                end
            else if frmTIFFsave.rbnCG4.Checked then
            	begin
                io.IEBitmap.PixelFormat := ie1g;
                io.Params.TIFF_Compression := ioTIFF_G4FAX;
                end
            else if frmTIFFsave.rbnCZlib.Checked then
                io.Params.TIFF_Compression := ioTIFF_CCITT1D
            else
                io.Params.TIFF_Compression := IoTIFF_LZW;

            io.SaveToFileTIFF(String(path));

            if not io.Aborting then
            	Result := 1;

            FreeAndNil(io);
        	end;

        FreeAndNil(frmTIFFsave);
        end;

	FreeAndNil(bmp);
end;

function FIPISanimInit(filename, ext: PChar; app: THandle):integer; stdcall;
begin
	Result := 1;
    gframe := 0;

	// initializing
    mio := TImageEnIO.Create(nil);
    gframes := mio.LoadFromFileGIF(String(filename));
    gfile := String(filename);

    if mio.Aborting then
        Result := 0;
end;

function FIPISanimConfirm():integer; stdcall;
begin
	if (gframes < 2) then
  		Result := 0
	else
  		Result := 1;
end;

function FIPISanimRestart():integer; stdcall;
begin
	gframe := 0;
	Result := 1;
end;

function FIPISanimGetFrame(var img: hBitmap; var delay: integer):integer; stdcall;
var
	bmp: TBitmap;
begin
    Result := 1;

	mio.Params.GIF_ImageIndex := gframe;
    mio.LoadFromFileGIF(gfile);

    // getting bitmap
    bmp := TBitmap.Create();
    bmp.Assign(mio.IEBitmap.VclBitmap);
    bmp.PixelFormat := pf24bit;
    img := bmp.ReleaseHandle();
    FreeAndNil(bmp);

    // getting delay
    delay := mio.Params.GIF_DelayTime*10;

    if (delay < 50) then
		delay := 50;
        
    // increasing
	gframe := gframe + 1;

    // round up
    if (gframe = gframes) then
		gframe := 0;
end;

function FIPISanimDeInit():integer; stdcall;
begin
	Result := 1;
	FreeAndNil(mio);
end;

function FIPISmultiInit(filename, ext: PChar; app: THandle):integer; stdcall;
begin
    gpage := 0;
    gext := ExtractExt(String(filename));
    gfilep := String(filename);

	// initializing
    pio := TImageEnIO.Create(nil);

    if (gext = 'dcx') then
        begin
        gpages := EnumDCXIm(String(filename));
    	pio.LoadFromFileDCX(String(filename));
        end
    else
    	gpages := pio.LoadFromFileTIFF(String(filename));

    if pio.Aborting then
        Result := 0
    else
    	Result := gpages;
end;

function FIPISmultiGetPages():integer; stdcall;
begin
	if (gext = 'dcx') then
		Result := EnumDCXIm(String(gfilep))
	else
  		Result := EnumTIFFIm(String(gfilep));
end;

function FIPISmultiGetPage(index: integer):hBitmap; stdcall;
var
	bmp: TBitmap;
begin
    bmp := TBitmap.Create();

	if (gext = 'dcx') then
        begin
        pio.Params.DCX_ImageIndex := index;
        pio.LoadFromFileDCX(gfilep);
        end
	else
        begin
        pio.Params.TIFF_ImageIndex := index;
        pio.LoadFromFileTIFF(gfilep);
        end;

    if pio.Aborting then
        Result := 0
    else
    	begin
        bmp.Assign(pio.IEBitmap.VclBitmap);
        bmp.PixelFormat := pf24bit;
    	Result := bmp.ReleaseHandle();
        end;

    FreeAndNil(bmp);
end;

function FIPISmultiDeInit():integer; stdcall;
begin
	Result := 1;
    FreeAndNil(pio);
end;

function FIPISfilter(info: PChar; preview: boolean; app, wnd: THandle; img: HBITMAP):HBITMAP; stdcall;
var
	bmp: TBitmap;
    proc: TImageEnProc;
begin
	bmp := TBitmap.Create();
    bmp.Handle := img;
    bmp.PixelFormat := pf24bit;

    proc := TImageEnProc.Create(nil);
    proc.AttachedIEBitmap.Assign(bmp);

    if (String(info) = 'Flip Horizontal') then
    	proc.Flip(fdHorizontal)
    else if (String(info) = 'Flip Vertical') then
        proc.Flip(fdVertical)
    else if (String(info) = 'Invert') then
    	proc.Negative();

    bmp.Assign(proc.AttachedIEBitmap.VclBitmap);

    FreeAndNil(proc);
	
    Result := bmp.ReleaseHandle();
    FreeAndNil(bmp);
end;

function FIPISimport(info: PChar; app, wnd: THandle):hBitmap; stdcall;
var
	bmp: TBitmap;
    io: TImageEnIO;
begin
    Result := 0;

    if (String(info) = 'Get Image from Digital Camera or Scanner...') then
    	begin
        // working
		io := TImageEnIO.Create(nil);
    	bmp := TBitmap.Create();

        // TWAIN
        if (io.SelectAcquireSource(ieaTwain) and io.Acquire(ieaTwain)) then
			begin
            bmp.Assign(io.IEBitmap.VclBitmap);
            Result := bmp.ReleaseHandle();
            end;

		FreeAndNil(io);
    	FreeAndNil(bmp);
    	end;
end;

function FIPIStool(info,path: PChar; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;
var
	tmp, new: string;
	html: TStringList;
	bmp: TBitmap;
	wdth, hght: integer; // image dimensions
begin
	tmp := String(path);
	Result := 0;

	if (tmp <> '') then
  		begin
  		if (MessageBox(wnd, 'Would you like to create HTML file for current image ?', 'Futuris Imager', MB_YESNO + MB_ICONQUESTION) = ID_YES) then
    		begin
    		// creating html
    		bmp := TBitmap.Create();
    		bmp.Handle := img;
    		wdth := bmp.Width;
    		hght := bmp.Height;
    		FreeAndNil(bmp);

    		new := ChangeFileExt(tmp, '.html');

    		html := TStringList.Create();
    		html.Add('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">');
    		html.Add('<html>');
    		html.Add('<head>');
    		html.Add('<title>' + ExtractFileName(tmp) + '</title>');
    		html.Add('<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">');
    		html.Add('</head>');
    		html.Add('');
    		html.Add('<body bgcolor="#FFFFFF" text="#000000">');
    		html.Add('<img src="' + ExtractFileName(tmp) + '" alt="" width="' + IntToStr(wdth) + '" height="' + IntToStr(hght) + '">');
    		html.Add('</body>');
    		html.Add('</html>');

    		try
      			html.SaveToFile(new);
            except
      			MessageBox(wnd, 'Error while saving resulting HTML file!', 'Error!', MB_OK + MB_ICONERROR);
      			FreeAndNil(html);
      			Exit;
      		end;

    		FreeAndNil(html);
    		MessageBox(wnd, PChar('HTML file created at: "' + new + '"'), 'Futuris Imager', MB_OK + MB_ICONINFORMATION);
        	end;
    	end
	else
  		begin
  		// unsaved files
  		MessageBox(wnd, 'This tool can work only with saved images.', 'Warning!', MB_OK + MB_ICONWARNING);
  		end;
end;

exports
	FIPISquery, FIPISopen, FIPISsave, FIPISfilter, FIPISimport,
	FIPISanimInit, FIPISanimConfirm, FIPISanimRestart, FIPISanimGetFrame, FIPISanimDeInit,
    FIPISmultiInit, FIPISmultiGetPages, FIPISmultiGetPage, FIPISmultiDeInit,
    FIPIStool;

begin
end.
