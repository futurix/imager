library f_jpeg;
// 0FF6F740-2F20-11D5-B653-8D6A009BCE3A

uses
  SysUtils,
  Windows,
  Classes,
  Graphics,
  Jpeg,
  Dialogs,
  Registry,
  info in 'info.pas' {frmInfo},
  jexport in 'jexport.pas' {frmJExport};

{$R *.RES}
{$R fipis.res}

function FIPISopen(path,ext: PChar; app: THandle):hBitmap; stdcall;
var
   bmp: TBitmap;
   jpg: TJpegImage;
begin
bmp:=TBitmap.Create();
jpg:=TJpegImage.Create();
try
   jpg.LoadFromFile(String(path));
   bmp.Height:=jpg.Height;
   bmp.Width:=jpg.Width;
   bmp.Canvas.Draw(0,0,jpg);
   Result:=bmp.ReleaseHandle();
   except
         on EInvalidGraphic do Result:=0;
         end;
bmp.Free();
jpg.Free();
end;

function FIPISconfig(app: THandle):integer; stdcall;
var
   tmp: string;
   val: integer;
begin
reg:=TRegistry.Create();
reg.RootKey:=HKEY_CURRENT_USER;
reg.OpenKey(sReg + '\Plug-ins\0FF6F740-2F20-11D5-B653-8D6A009BCE3A',true);
tmp:=reg.ReadString('Quality');
if tmp='' then tmp:='80';
reg.CloseKey();
if InputQuery('JPEG Plug-in','Changing JPEG compression quality - from 1 to 100',tmp) then
                    begin;
                    try
                       val:=StrToInt(tmp);
                       except
                             val:=80;
                       end;
                    reg.OpenKey(sReg + '\Plug-ins\0FF6F740-2F20-11D5-B653-8D6A009BCE3A',true);
                    reg.WriteString('Quality',IntToStr(val));
                    reg.CloseKey();
                    end;
reg.Free();
Result:=1;
end;

function FIPISsave(path,ext: PChar; app: THandle; img: hBitmap):integer; stdcall;
var
   bmp: TBitmap;
   jpg: TJpegImage;
   tmp: string;
begin
bmp:=TBitmap.Create();
jpg:=TJpegImage.Create();
Result:=1;
try
   bmp.Handle:=img;
   reg:=TRegistry.Create();
   reg.RootKey:=HKEY_CURRENT_USER;
   reg.OpenKey(sReg + '\Plug-ins\0FF6F740-2F20-11D5-B653-8D6A009BCE3A',true);
   tmp:=reg.ReadString('Quality');
   if tmp='' then tmp:='80';
   jpg.CompressionQuality:=StrToInt(tmp);
   reg.CloseKey();
   reg.Free();
   jpg.Assign(bmp);
   jpg.SaveToFile(String(path));
   except
         Result:=0;
   end;
bmp.Free();
jpg.Free();
end;

exports
       FIPISopen, FIPISsave, FIPISexport, FIPISconfig, FIPISinfo;

begin
end.
 