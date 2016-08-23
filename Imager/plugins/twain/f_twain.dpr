library f_twain;

uses
  SysUtils, Classes, Windows, Graphics,
  MultiTWAIN, c_const;

procedure CallbackFxn(CurDib: THandle; index: Integer); stdcall; forward;

var
   hdib, testdib: hbitmap;
   w, h: integer;
   bmp: TPicture;

{$R *.RES}

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
func(PT_FIMPORT,'TWAIN Acquire',' ');
Result:=true;
end;

function FIPISimport(info: PChar; app, wnd: THandle):hBitmap; stdcall;
begin
// init
bmp:=TPicture.Create();
hDib:=0;
w:=0;
h:=0;
testDib:=0;
Result:=0;
TWAIN_RegisterCallback(CallbackFxn);

// do it!
try
  if TWAIN_SelectImageSource(wnd)<>0 then
    begin
    hdib:=TWAIN_AcquireNative(0,0);
    TestDib:=TWAIN_GetDib(0);
    CopyDibIntoImage(TestDib,bmp);
    TWAIN_FreeNative(TestDib);
    TestDib:=0;
    Result:=bmp.Bitmap.Handle;
    bmp.Bitmap.ReleaseHandle();
    end;
  except
  end;
// finish
bmp.Free();
end;

procedure CallbackFxn(CurDib: THandle; index: Integer); stdcall;
begin
// does nothing, but required
end;

exports
  FIPISquery, FIPISimport;

begin
end.
