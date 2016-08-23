library f_invert;

uses
  SysUtils, Windows, Classes, Graphics, c_const;

const
  MaxPixelCount = 32768;

type
  PRGBArray = ^TRGBArray;
  TRGBArray = array[0..MaxPixelCount - 1] of TRGBTriple;

{$R *.res}

procedure FastNegativeBitmap(OrigBmp, DestBmp: TBitmap);
var
  i, j: Integer;
  TmpBmp: TBitmap;
  OrigRow, DestRow: PRGBArray;
begin
  TmpBmp := TBitmap.Create;
  TmpBmp.PixelFormat:=pf24Bit;
  try
    TmpBmp.Width := OrigBmp.Width;
    TmpBmp.Height := OrigBmp.Height;
    OrigBmp.PixelFormat := pf24bit;
    TmpBmp.PixelFormat := OrigBmp.PixelFormat;
    for i := 0 to TmpBmp.Height - 1 do
    begin
      OrigRow := OrigBmp.ScanLine[i];
      DestRow := TmpBmp.ScanLine[i];
      for j := 0 to TmpBmp.Width - 1 do
      begin
        DestRow[j].rgbtRed := not OrigRow[j].rgbtRed;
        DestRow[j].rgbtGreen := not OrigRow[j].rgbtGreen;
        DestRow[j].rgbtBlue := not OrigRow[j].rgbtBlue;
      end;
    end;
    DestBmp.Assign(TmpBmp);
  finally
    TmpBmp.Free;
  end;
end;

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
func(PT_FFILTER,'Invert',' ');
Result:=true;
end;

function FIPISfilter(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;
var
  bmp: TBitmap;
begin
// tuning internals
bmp:=TBitmap.Create();
bmp.Handle:=img;
bmp.PixelFormat:=pf24Bit;

// inverting
FastNegativeBitmap(bmp,bmp);

// sending result
Result:=bmp.ReleaseHandle();
FreeAndNil(bmp);
end;

exports
  FIPISquery, FIPISfilter;

begin
end.
 