Unit BMP2WBMP;
{$HINTS OFF}
{$WARNINGS OFF}
Interface
uses WinProcs, Wintypes, Graphics, Classes;

Function  SaveAsWBmpFile (Bmp:TBitmap; Filename:String): Boolean;
Function  LoadFromWBmpFile(Bmp:TBitmap; FileName:String): Boolean;

procedure Convert_Bmp_To_WBmp (BmpFileName,WBmpFileName:String);
procedure Convert_WBmp_To_Bmp (WBmpFileName,BmpFileName:String);

Implementation

(*
  SaveAsWBmpFile() saves a bitmap as a wbmp file,
  which can be read by WAP-compatible browsers.
  WBmp type 0 is supported (b/w uncompressed bitmap).
  If colour reduction is not needed use bmp_already_is_black_and_white
  as define. It will improve performance significantly.
  Change it from
     {  $Define bmp_already_....}
  to
     {$Define bmp_already_...}

 written by Volker Berninger, Marburg, Germany  (Berninger@wahlinfo.de)
*)

Function  SaveAsWBmpFile (Bmp:TBitmap; Filename:String): Boolean;
{  $Define bmp_already_is_black_and_white}
const
  BorderWhite= 220*3;
  BorderLight= 195 *3;
  BorderLightGray= 160*3;
  BorderGray=125*3;
  BorderDarkGray=90*3;
  BorderDark=60*3;
  BorderBlack=30*2;
var F:File; Col:TColor;
    Buf: Array[0..256] of Byte;  (* maximum bitmap width = 256*8 pixels *)
    Gray,BufLen,BPos,A,B,X,Y:Longint;
 procedure Write_To_Header(L:Longint); var extra:Longint; b:Byte;
 begin
  extra:=0;  While L>=128 do begin Inc(extra); Dec(l,128); end;
  if extra>0 then begin b:=128+extra; BlockWrite(F,b,1); end;
  b:=l; BlockWrite(F,b,1);
 end;
begin
 SaveAsWBmpFile:=False;
 if Bmp=NIL then EXIT; if Bmp.Empty then EXIT;
 if Bmp.Width=0 then EXIT; if Bmp.Height=0 then EXIT;
 AssignFile(F,FileName);
 Rewrite(F,1); if IOResult<>0 then EXIT;
 BufLen:=Bmp.Width shr 3 + Byte(Bmp.Width and 7>0);
 Write_To_Header(0); Write_To_Header(0);
 Write_To_Header(Bmp.Width); Write_To_Header(Bmp.Height);
 for Y:=0 to Bmp.Height-1
  do begin
      FillChar(Buf,SizeOf(Buf),0); BPos:=0; B:=128;
      for X:=0 to Bmp.Width-1
       do begin
           {$IfDef bmp_already_is_black_and_white}
           if Bmp.Canvas.Pixels[X,Y]<>clBlack then Inc(Buf[BPos],B);
           {$Else}
           Col:=Bmp.Canvas.Pixels[X,Y];
           Gray:= (Col and $ff) + ((Col shr 8) and $ff) + ((Col shr 16) and $ff);
           if (Gray>BorderWhite) then Inc(Buf[BPos],B) else
           if (Gray>BorderLight)
             then begin if (X mod 3<>0)or(Y mod 3<>1) then Inc(Buf[BPos],B) end else
           if (Gray>BorderLightGray)
             then begin if (X and 1=1)or(Y and 1=1) then Inc(Buf[BPos],B) end else
           if (Gray>BorderGray)
             then begin if (X and 1=1)=(Y and 1<>1) then Inc(Buf[BPos],B) end else
           if (Gray>BorderDarkGray)
             then begin if (X mod 3=1)and(Y mod 3=2) then Inc(Buf[BPos],B) end else
           if (Gray>BorderDark)
             then begin if (X and 3=0) and (Y and 3=0) then Inc(Buf[BPos],B) end else
           if (Gray>BorderBlack)
             then begin if (X mod 5=1) and (Y mod 5=3) then Inc(Buf[BPos],B) end;
          {$EndIf}
           if B>1 then B:=B shr 1 else begin B:=128; Inc(BPos); end;
          end;
      BlockWrite(F,Buf,BufLen);
     end;
 CloseFile(F);
 SaveAsWBmpFile:=True;
end;


(*
  LoadFromWBmpFile loads a bitmap from a wbmp file.
  WBmp type 0 is supported (b/w uncompressed bitmap)
  If your Delphi Version does not support the bitmap property
  pixelformat and you get a compiler error then you must
  rename "Def Win32" to "Def __Win32__"
*)


Function  LoadFromWBmpFile (Bmp:TBitmap; Filename:String): Boolean;
type TScanLine= Array[0..$fff] of Byte;
     PScanLine= ^TScanLine;
var F:File;
    BMPLine: PScanLine;
    Buf:TScanLine;
    X,Y,L,Dummy,BufLen,BMPWidth,BMPHeight:Longint;
    Col:TColor;
 Function Read_From_Header: Longint;
 var B:Byte; Mul,Res:Longint;
 begin
  Res:=0; Mul:=0;
  BlockRead(F,B,1); if B>128 then begin Mul:=B-128; BlockRead(F,B,1); end;
  Read_From_Header:=B + Mul shl 7; {B + Mul*128 }
 end;
Label ErrorExit;
begin
 LoadFromWBmpFile:=False;
 if Bmp=NIL then EXIT;
 AssignFile(F,FileName); Reset(F,1); if IOResult<>0 then EXIT;
 L:=Read_From_Header; (*TypeField*)
 if L>0 then begin ErrorEXIT: CloseFile(F); EXIT; end; (*unsupported format*)
 Dummy:=Read_From_Header; (*FixHeaderFiled*)
 BmpWidth:=Read_From_Header; if BmpWidth=0 then Goto ErrorExit;
 BmpHeight:=Read_From_Header; if BmpHeight=0 then Goto ErrorExit;
 BufLen:=BmpWidth shr 3 + Byte(BmpWidth and 7>0);
 Bmp.Width:=BMPWidth;
 Bmp.Height:=BMPHeight;
 {$IfDef Win32}
  Bmp.PixelFormat:= pf1Bit;
 {$Else}
  GetMem(BmpLine,BufLen);
 {$Endif}
 for Y:=0 to Bmp.Height-1
  do if Not EOF(F)
   then begin
       {$IfDef Win32}
        BMPLine:= BMP.ScanLine[Y];
        BlockRead(F,BmpLine^,BufLen);
       {$Else}
        BlockRead(F,BmpLine^,BufLen);
        for X:=0 to Bmp.Width-1
         do begin
             if BmpLine^[X shr 3] and (1 shl (7-(X and 7))) =0
              then Bmp.Canvas.Pixels[X,Y]:=clBlack
              else Bmp.Canvas.Pixels[X,Y]:=clWhite;
             end;
       {$Endif}
      end;
 {$IfNDef Win32} FreeMem(BmpLine,BufLen); {$Endif}
 CloseFile(F);
 LoadFromWBmpFile:=True;
end;




procedure Convert_Bmp_To_WBmp (BmpFileName,WBmpFileName:String);
var Bitmap:TBitmap;
begin
 Bitmap:=TBitmap.Create;
 Bitmap.LoadFromFile(BmpFileName);
 SaveAsWBmpFile(Bitmap,WBMPFileName);
 Bitmap.Free;
end;

procedure Convert_WBmp_To_Bmp (WBmpFileName,BmpFileName:String);
var Bitmap:TBitmap;
begin
 Bitmap:=TBitmap.Create;
 LoadFromWBMPFile(Bitmap,WBmpFileName);
 Bitmap.SaveToFile(BMPFileName);
 Bitmap.Free;
end;

{$HINTS ON}
{$WARNINGS ON}

end.

