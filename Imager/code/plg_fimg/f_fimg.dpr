library f_fimg;

uses
  SysUtils, Windows, Classes, Graphics,
  ImageEnIO, ImageEnProc, hyieutils, IEMView,
  freeimage, c_const;

var
	mp_filename: string = '';

{$R *.RES}


function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; cdecl;
begin
	func(PT_FOPEN, 'koa', 'Commodore 64 Koala format (*.koa)');
	func(PT_FOPEN, 'iff', 'Amiga IFF (*.iff)');
	func(PT_FOPEN, 'ilbm', 'Amiga IFF (*.ilbm)');
	func(PT_FOPEN, 'lbm', 'Amiga IFF (*.lbm)');
	func(PT_FOPEN, 'dds', 'DirectDraw Surface (*.dds)');
	func(PT_FOPEN, 'ras', 'Sun Rasterfile (*.ras)');
	func(PT_FOPEN, 'xbm', 'X11 Bitmap Format (*.xbm)');
	func(PT_FOPEN, 'xpm', 'X11 Pixmap Format (*.xpm)');
	func(PT_FOPEN, 'ico', 'Windows Icon (*.ico)');
	func(PT_FOPEN, 'hdr', 'High Dynamic Range Image (*.hdr)');

	func(PT_FOPENMULTI, 'ico', ' ');

	Result := true;
end;

function FOpen(path,ext: PChar; app: THandle):hBitmap; cdecl;
var
  dib: PFIBITMAP;
  t: FREE_IMAGE_FORMAT;
  bmp: HBITMAP;
  bitm: TBitmap;
begin
Result:=0;

// analyzing
if ext='koa' then t:=FIF_KOALA
else if ext='iff' then t:=FIF_IFF
else if ext='ilbm' then t:=FIF_LBM
else if ext='lbm' then t:=FIF_LBM
else if ext='dds' then t:=FIF_DDS
else if ext='ras' then t:=FIF_RAS
else if ext='xbm' then t:=FIF_XBM
else if ext='xpm' then t:=FIF_XPM
else if ext='ico' then t:=FIF_ICO
else if ext='hdr' then t:=FIF_HDR
else t:=FreeImage_GetFileType(PChar(path), 16);

if (t <> FIF_UNKNOWN) then
  begin
  dib := FreeImage_Load(t, PChar(path), 0);
  if (dib <> nil) then
    begin
    bitm := TBitmap.Create();

    if (t = FIF_HDR) then
    	dib := FreeImage_ToneMapping(dib, FITMO_DRAGO03, 1, 0);

    bmp := CreateDIBitmap(GetDC(0), FreeImage_GetInfoHeader(dib)^, CBM_INIT, PAnsiChar(FreeImage_GetBits(dib)), FreeImage_GetInfo(dib^)^, DIB_RGB_COLORS);
    bitm.Handle := bmp;
    bitm.PixelFormat := pf24bit;
    Result := bitm.ReleaseHandle();
    FreeAndNil(bitm);
    FreeImage_Unload(dib);
    end;
  end;
end;

function FMultiStart(filename, ext: PChar; app: THandle):integer; cdecl;
var
	mp: PFIMULTIBITMAP;
begin
	Result := 0;
    mp_filename := filename;

	mp := FreeImage_OpenMultiBitmap(FIF_ICO, PChar(mp_filename), false, true, false);

	if (mp <> nil) then
  		begin
  		Result := FreeImage_GetPageCount(mp);
        FreeImage_CloseMultiBitmap(mp, 0);
  		end;
end;

function FMultiGetPage(index: integer):hBitmap; cdecl;
var
	mp: PFIMULTIBITMAP;
  	dib: PFIBITMAP;
  	bmp: HBITMAP;
  	bitm: TBitmap;
begin
	Result := 0;

    mp := FreeImage_OpenMultiBitmap(FIF_ICO, PChar(mp_filename), false, true, false);

	if (mp <> nil) then
  		begin
		dib := FreeImage_LockPage(mp, index);

		if (dib <> nil) then
  			begin
  			bitm := TBitmap.Create();
 			bmp := CreateDIBitmap(GetDC(0), FreeImage_GetInfoHeader(dib)^, CBM_INIT, PAnsiChar(FreeImage_GetBits(dib)), FreeImage_GetInfo(dib^)^, DIB_RGB_COLORS);
  			bitm.Handle := bmp;
  			bitm.PixelFormat := pf24bit;
  			Result := bitm.ReleaseHandle();
  			FreeAndNil(bitm);
  			FreeImage_UnlockPage(mp, dib, false);
  			end;

        FreeImage_CloseMultiBitmap(mp, 0);
        end;
end;

function FMultiStop():integer; cdecl;
begin
	Result := 1;
end;

exports
	FQuery, FOpen,
	FMultiStart, FMultiGetPage, FMultiStop;

begin
end.
