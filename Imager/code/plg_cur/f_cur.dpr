library f_cur;

uses
  SysUtils, Windows, Classes, Graphics,
  c_const;

{$R *.res}

function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; cdecl;
begin
	func(PT_FOPEN, 'cur', 'Windows Cursor (*.cur)');

	Result := true;
end;

function FOpen(path,ext: PChar; app: THandle):hBitmap; cdecl;
var
	bmp, tmp: TBitmap;
	imh: THandle;
	pic: TPicture;
	iif: TIconInfo;
begin
    Result := 0;
	imh := LoadImage(HInstance, path, IMAGE_ICON, 0, 0, LR_LOADFROMFILE + LR_DEFAULTCOLOR);

	if (imh <> 0) then
  		begin
  		bmp := TBitmap.Create();
  		tmp := TBitmap.Create();
  		pic := TPicture.Create();

  		pic.Icon.Handle := imh;
  		GetIconInfo(imh, iif);

  		if (iif.hbmColor <> 0) then
    		tmp.Handle := iif.hbmColor
  		else
    		tmp.Handle := iif.hbmMask;

  		bmp.Width := tmp.Width;
  		bmp.Height := tmp.Height;
  		bmp.Canvas.Draw(0, 0, pic.Graphic);

  		Result := bmp.ReleaseHandle();

  		FreeAndNil(pic);
  		FreeAndNil(bmp);
  		FreeAndNil(tmp);
  		end;
end;

exports
	FQuery, FOpen;

begin
end.
 