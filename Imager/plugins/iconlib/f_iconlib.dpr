library f_iconlib;

uses
  SysUtils, Windows, Classes, Graphics,
  c_const;

{$R *.res}

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
func(PT_FOPEN,'ico',' ');
func(PT_FOPEN,'cur',' ');
func(PT_FDESCR,'ico','Windows Icon (*.ico)');
func(PT_FDESCR,'cur','Windows Cursor (*.cur)');
Result:=true;
end;

function FIPISopen(path,ext: PChar; app: THandle):hBitmap; stdcall;
var
  bmp, tmp: TBitmap;
  imh: THandle;
  pic: TPicture;
  iif: TIconInfo;
begin
imh:=LoadImage(HInstance,path,IMAGE_ICON,0,0,LR_LOADFROMFILE+LR_DEFAULTCOLOR);
if imh<>0 then
  begin
  bmp:=TBitmap.Create();
  tmp:=TBitmap.Create();
  pic:=TPicture.Create();

  pic.Icon.Handle:=imh;
  GetIconInfo(imh,iif);

  if iif.hbmColor<>0 then
    tmp.Handle:=iif.hbmColor
  else
    tmp.Handle:=iif.hbmMask;

  bmp.Width:=tmp.Width;
  bmp.Height:=tmp.Height;
  bmp.Canvas.Draw(0,0,pic.Graphic);

  Result:=bmp.ReleaseHandle();

  FreeAndNil(pic);
  FreeAndNil(bmp);
  FreeAndNil(tmp);
  end
else
  Result:=0;
end;

exports
  FIPISquery, FIPISopen;

begin
end.
 