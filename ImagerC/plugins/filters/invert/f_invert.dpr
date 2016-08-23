library f_invert;

uses Windows, Classes, Graphics;

const
  MaxPixelCount = 32768;

type
  PRGBArray = ^TRGBArray;
  TRGBArray = array[0..MaxPixelCount - 1] of TRGBTriple;

{$R *.RES}
{$R fipis.res}

procedure FastNegativeBitmap(OrigBmp, DestBmp: TBitmap);
var
  i, j: Integer;
  TmpBmp: TBitmap;
  OrigRow, DestRow: PRGBArray;
begin
  TmpBmp := TBitmap.Create;
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


function FIPISfilter(info: PChar; app: THandle; img: hBitmap):hBitmap; stdcall;
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
bmp.Free();
end;

exports FIPISfilter;

begin
end.
