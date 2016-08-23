library f_graphicex;

uses
  SysUtils, Classes, Windows, Graphics, GraphicEx,
  c_const;

{$R *.res}

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
	func(PT_FOPEN, 'eps', ' ');
	func(PT_FOPEN, 'sgi', ' ');
	func(PT_FOPEN, 'cel', ' ');
	func(PT_FOPEN, 'pic', ' ');
	func(PT_FOPEN, 'pcd', ' ');
	func(PT_FOPEN, 'cut', ' ');
	func(PT_FOPEN, 'rla', ' ');
	func(PT_FOPEN, 'psd', ' ');
	func(PT_FOPEN, 'pdd', ' ');
	func(PT_FOPEN, 'psp', ' ');

	func(PT_FDESCR, 'eps', 'Encapsulated PostScript (*.eps)');
	func(PT_FDESCR, 'sgi', 'SGI Image (*.sgi)');
	func(PT_FDESCR, 'cel', 'Autodesk Image (*.cel)');
	func(PT_FDESCR, 'pic', 'Autodesk Image (*.pic)');
	func(PT_FDESCR, 'pcd', 'Kodak Photo-CD (*.pcd)');
	func(PT_FDESCR, 'cut', 'Dr. Halo (*.cut)');
	func(PT_FDESCR, 'rla', 'SGI Wavefront Image (*.rla)');
	func(PT_FDESCR, 'psd', 'Adobe Photoshop (*.psd)');
	func(PT_FDESCR, 'pdd', 'Adobe PhotoDeluxe (*.pdd)');
	func(PT_FDESCR, 'psp', 'Jasc Paintshop Pro (*.psp)');

	Result := true;
end;

function FIPISopen(path,ext: PChar; app: THandle):hBitmap; stdcall;
var
	bmp: TBitmap;
	sgi: TSGIGraphic;
	dsk: TAutodeskGraphic;
	pcd: TPCDGraphic;
	cut: TCUTGraphic;
	wvf: TRLAGraphic;
	psd: TPSDGraphic;
	psp: TPSPGraphic;
    eps: TEPSGraphic;
begin
Result:=0;

if ((ext='bw')or(ext='rgb')or(ext='rgba')or(ext='sgi')) then
  begin
  // TSGIGraphic
  sgi:=TSGIGraphic.Create();
  bmp:=TBitmap.Create();
  try
    sgi.LoadFromFile(path);
    bmp.Assign(sgi);
    Result:=bmp.ReleaseHandle();
    except
    end;
  sgi.Free();
  bmp.Free();
  end
else if ((ext='cel')or(ext='pic')) then
  begin
  // TAutodeskGraphic
  dsk:=TAutodeskGraphic.Create();
  bmp:=TBitmap.Create();
  try
    dsk.LoadFromFile(path);
    bmp.Assign(dsk);
    Result:=bmp.ReleaseHandle();
    except
    end;
  dsk.Free();
  bmp.Free();
  end
else if (ext='pcd') then
  begin
  // TPCDGraphic
  pcd:=TPCDGraphic.Create();
  bmp:=TBitmap.Create();
  try
    pcd.LoadFromFile(path);
    bmp.Assign(pcd);
    Result:=bmp.ReleaseHandle();
    except
    end;
  pcd.Free();
  bmp.Free();
  end
else if (ext='cut') then
  begin
  // TCUTGraphic
  cut:=TCUTGraphic.Create();
  bmp:=TBitmap.Create();
  try
    cut.LoadFromFile(path);
    bmp.Assign(cut);
    Result:=bmp.ReleaseHandle();
    except
    end;
  cut.Free();
  bmp.Free();
  end
else if (ext='eps') then
	begin
  	// TEPSGraphic
  	eps := TEPSGraphic.Create();
  	bmp := TBitmap.Create();

  	try
    	eps.LoadFromFile(path);
    	bmp.Assign(eps);
    	Result := bmp.ReleaseHandle();
  	except
  	end;

  	FreeAndNil(eps);
  	FreeAndNil(bmp);
  	end
else if ((ext='rla')or(ext='rpf')) then
  begin
  // TRLAGraphic
  wvf:=TRLAGraphic.Create();
  bmp:=TBitmap.Create();
  try
    wvf.LoadFromFile(path);
    bmp.Assign(wvf);
    Result:=bmp.ReleaseHandle();
    except
    end;
  wvf.Free();
  bmp.Free();
  end
else if ((ext='psd')or(ext='pdd')) then
  begin
  // TPSDGraphic
  psd:=TPSDGraphic.Create();
  bmp:=TBitmap.Create();
  try
    psd.LoadFromFile(path);
    bmp.Assign(psd);
    Result:=bmp.ReleaseHandle();
    except
    end;
  psd.Free();
  bmp.Free();
  end
else if (ext='psp') then
  begin
  // TPSPGraphic
  psp:=TPSPGraphic.Create();
  bmp:=TBitmap.Create();
  try
    psp.LoadFromFile(path);
    bmp.Assign(psp);
    Result:=bmp.ReleaseHandle();
    except
    end;
  psp.Free();
  bmp.Free();
  end;
end;

exports
  FIPISquery, FIPISopen;

begin
end.
