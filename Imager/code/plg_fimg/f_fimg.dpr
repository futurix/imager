library f_fimg;

uses
  SysUtils, Windows, Classes, Graphics,
  freeimage, c_const;

var
	mp_filename: string = '';

{$R *.RES}


function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
func(PT_FOPEN,'koa',' ');
func(PT_FOPEN,'iff',' ');
func(PT_FOPEN,'ilbm',' ');
func(PT_FOPEN,'lbm',' ');
func(PT_FOPEN,'dds',' ');
func(PT_FOPEN,'ras',' ');
func(PT_FOPEN,'xbm',' ');
func(PT_FOPEN,'xpm',' ');
func(PT_FOPEN,'ico',' ');

func(PT_FOPENMULTI,'ico',' ');

func(PT_FDESCR,'koa','Commodore 64 Koala format (*.koa)');
func(PT_FDESCR,'iff','Amiga IFF (*.iff)');
func(PT_FDESCR,'ilbm','Amiga IFF (*.ilbm)');
func(PT_FDESCR,'lbm','Amiga IFF (*.lbm)');
func(PT_FDESCR,'dds','DirectDraw Surface (*.dds)');
func(PT_FDESCR,'ras','Sun Rasterfile (*.ras)');
func(PT_FDESCR,'xbm','X11 Bitmap Format (*.xbm)');
func(PT_FDESCR,'xpm','X11 Pixmap Format (*.xpm)');
func(PT_FDESCR,'ico','Windows Icon (*.ico)');
Result:=true;
end;

function FIPISopen(path,ext: PChar; app: THandle):hBitmap; stdcall;
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
else t:=FreeImage_GetFileType(PChar(path), 16);

if t<>FIF_UNKNOWN then
  begin
  dib:=FreeImage_Load(t, PChar(path), 0);
  if dib<>nil then
    begin
    bitm:=TBitmap.Create();
    bmp:=CreateDIBitmap(GetDC(0),FreeImage_GetInfoHeader(dib)^, CBM_INIT, PAnsiChar(FreeImage_GetBits(dib)), FreeImage_GetInfo(dib^)^, DIB_RGB_COLORS);
    bitm.Handle:=bmp;
    bitm.PixelFormat:=pf24bit;
    Result:=bitm.ReleaseHandle();
    FreeAndNil(bitm);
    FreeImage_Unload(dib);
    end;
  end;
end;

function FIPISmultiInit(filename, ext: PChar; app: THandle):integer; stdcall;
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

function FIPISmultiGetPages():integer; stdcall;
var
	mp: PFIMULTIBITMAP;
begin
	Result := 0;

    mp := FreeImage_OpenMultiBitmap(FIF_ICO, PChar(mp_filename), false, true, false);

	if (mp <> nil) then
  		begin
		Result:=FreeImage_GetPageCount(mp);
        FreeImage_CloseMultiBitmap(mp, 0);
        end;
end;

function FIPISmultiGetPage(index: integer):hBitmap; stdcall;
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

function FIPISmultiDeInit():integer; stdcall;
begin
	Result := 1;
end;

exports
  FIPISquery, FIPISopen,
  FIPISmultiInit, FIPISmultiGetPages, FIPISmultiGetPage, FIPISmultiDeInit;

begin
end.
