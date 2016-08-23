library f_gif;

uses
  SysUtils,
  Classes,
  Windows,
  Graphics,
  gifimage,
  gifexp in 'gifexp.pas' {frmGIFExport};

var
   glbimg: TGifImage;
   loops, frames, frame: integer;
   prev: TBitmap;
   start: boolean = false;

{$R *.RES}
{$R fipis.res}

function GetLoops():integer;
var
   tmp: integer;
begin
// loops
if frames>1 then begin
                 // animated
                 try
                    if TGIFApplicationExtension(glbimg.Images.SubImages[0].Extensions[0]).Identifier='NETSCAPE' then begin
                                                                                                                     tmp:=TGIFAppExtNSLoop(glbimg.Images.SubImages[0].Extensions[0]).Loops;
                                                                                                                     if tmp=0 then tmp:=-7;
                                                                                                                     end
                    else tmp:=0;
                    Result:=tmp;
                 except
                       Result:=0;
                 end;
                 end
else Result:=0;
end;

procedure SetFramesNLoops();
begin
frames:=glbimg.Images.Count;
frame:=glbimg.Images.Count-1;
loops:=GetLoops();
end;

function FIPISopen(path,ext: PChar; app: THandle):hBitmap; stdcall;
var
   bmp: TBitmap;
   gif: TGifImage;
begin
gif:=TGifImage.Create();
bmp:=TBitmap.Create();
try
   gif.LoadFromFile(String(path));
   bmp.Height:=gif.Height;
   bmp.Width:=gif.Width;
   bmp.Canvas.Draw(0,0,gif);
   Result:=bmp.ReleaseHandle();
   except
         on EInvalidGraphic do Result:=0;
         end;
bmp.Free();
gif.Free();
end;

function FIPISsave(path,ext: PChar; app: THandle; img: hBitmap):integer; stdcall;
var
   bmp: TBitmap;
   gif: TGifImage;
begin
gif:=TGifImage.Create();
bmp:=TBitmap.Create();
Result:=1;
try
   bmp.Handle:=img;
   gif.Assign(bmp);
   gif.Optimize([],rmNone,dmNearest,8);
   gif.SaveToFile(String(path));
   except
         Result:=0;
   end;
bmp.Free();
gif.Free();
end;

function FIPISanimInit(filename, ext: PChar; app: THandle):integer; stdcall;
begin
glbimg:=TGifImage.Create();
prev:=TBitmap.Create();
Result:=1;
try
   glbimg.LoadFromFile(String(filename));
   prev.Width:=glbimg.Images.SubImages[0].Width;
   prev.Height:=glbimg.Images.SubImages[0].Height;
   prev.Canvas.Brush.Color:=glbimg.BackgroundColor;
   prev.Canvas.FillRect(prev.Canvas.ClipRect);
   start:=true;
   SetFramesNLoops();
   except
   Result:=0;
   end;
end;

function FIPISanimRestart():integer; stdcall;
begin
try
   SetFramesNLoops();
   prev.Canvas.Brush.Color:=glbimg.BackgroundColor;
   prev.Canvas.FillRect(prev.Canvas.ClipRect);
   start:=true;
   // result
   Result:=1;
   except
         Result:=0;
         end;
end;

function FIPISanimConfirm():integer; stdcall;
begin
try
   if glbimg.Images.Count>1 then Result:=1
   else Result:=0;
   except
   Result:=0;
   end;
end;

function FIPISanimGetFrame(var img: hBitmap; var delay: integer):integer; stdcall;
var
   tmp, old: TBitmap;
begin
try
if frame=(frames-1) then begin
                         // new loop or stop
                         if ((loops>0)
                             or (start))
                                    then begin
                                         // displaying
                                         if not start then Dec(loops);
                                         // first frame
                                         start:=false;
                                         frame:=0;
                                         // bitmaps
                                         tmp:=TBitmap.Create();
                                         old:=TBitmap.Create();
                                         old.Assign(prev);
                                         if ((glbimg.Images.SubImages[frame].Width<>0) and (glbimg.Images.SubImages[frame].Height<>0))
                                            then begin
                                         if glbimg.Images.SubImages[frame].Transparent then begin
                                                                                            prev.Canvas.Brush.Color:=glbimg.Images.SubImages[frame].GraphicControlExtension.TransparentColor;
                                                                                            prev.Canvas.FillRect(prev.Canvas.ClipRect);
                                                                                            end;
                                         tmp.Assign(prev);
                                         glbimg.Images.SubImages[frame].Draw(tmp.Canvas,tmp.Canvas.ClipRect,true,true);
                                         case glbimg.Images.SubImages[frame].GraphicControlExtension.Disposal of
                                              dmNone: prev.Assign(tmp);
                                              dmNoDisposal: prev.Assign(tmp);
                                              dmBackground: begin
                                                            if glbimg.Images.SubImages[frame].Transparent then begin
                                                                                                               prev.Canvas.Brush.Color:=glbimg.Images.SubImages[frame].GraphicControlExtension.TransparentColor;
                                                                                                               prev.Canvas.FillRect(prev.Canvas.ClipRect);
                                                                                                               end
                                                            else begin
                                                                 prev.Canvas.Brush.Color:=glbimg.BackgroundColor;
                                                                 prev.Canvas.FillRect(prev.Canvas.ClipRect);
                                                                 end;
                                                            end;
                                              dmPrevious: prev.Assign(old);
                                              end;
                                         try
                                            if glbimg.Images.SubImages[frame].GraphicControlExtension.Delay>3 then delay:=glbimg.Images.SubImages[frame].GraphicControlExtension.Delay*10
                                            else delay:=30;
                                            except
                                            delay:=GIFDefaultDelay*10;
                                            end;
                                         end
                                         else begin
                                              tmp.Assign(prev);
                                              delay:=0;
                                              end;
                                         img:=tmp.ReleaseHandle();
                                         tmp.Free();
                                         old.Free();
                                         end
                         else begin
                              if loops=-7 then begin
                                               // forever loop
                                               frame:=0;
                                               // bitmaps
                                               tmp:=TBitmap.Create();
                                               old:=TBitmap.Create();
                                               old.Assign(prev);
                                               tmp.Assign(prev);
                                               if ((glbimg.Images.SubImages[frame].Width<>0) and (glbimg.Images.SubImages[frame].Height<>0))
                                                  then begin
                                               glbimg.Images.SubImages[frame].Draw(tmp.Canvas,tmp.Canvas.ClipRect,true,true);
                                               case glbimg.Images.SubImages[frame].GraphicControlExtension.Disposal of
                                                    dmNone: prev.Assign(tmp);
                                                    dmNoDisposal: prev.Assign(tmp);
                                                    dmBackground: begin
                                                                  if glbimg.Images.SubImages[frame].Transparent then begin
                                                                                                                     prev.Canvas.Brush.Color:=glbimg.Images.SubImages[frame].GraphicControlExtension.TransparentColor;
                                                                                                                     prev.Canvas.FillRect(prev.Canvas.ClipRect);
                                                                                                                     end
                                                                  else begin
                                                                       prev.Canvas.Brush.Color:=glbimg.BackgroundColor;
                                                                       prev.Canvas.FillRect(prev.Canvas.ClipRect);
                                                                       end;
                                                                  end;
                                                    dmPrevious: prev.Assign(old);
                                                    end;
                                               try
                                                  if glbimg.Images.SubImages[frame].GraphicControlExtension.Delay>3 then delay:=glbimg.Images.SubImages[frame].GraphicControlExtension.Delay*10
                                                  else delay:=30;
                                                  except
                                                  delay:=GIFDefaultDelay*10;
                                                  end;
                                               end
                                               else delay:=0;
                                               img:=tmp.ReleaseHandle();
                                               tmp.Free();
                                               old.Free();
                                               end
                              else begin
                                   // stopping
                                   img:=0;
                                   delay:=0;
                                   end;
                              end;
                         end
else begin
     // next frame
     Inc(frame);
     // bitmaps
     tmp:=TBitmap.Create();
     old:=TBitmap.Create();
     old.Assign(prev);
     tmp.Assign(prev);
     if ((glbimg.Images.SubImages[frame].Width<>0) and (glbimg.Images.SubImages[frame].Height<>0))
        then begin
     glbimg.Images.SubImages[frame].Draw(tmp.Canvas,tmp.Canvas.ClipRect,true,true);
     case glbimg.Images.SubImages[frame].GraphicControlExtension.Disposal of
          dmNone: prev.Assign(tmp);
          dmNoDisposal: prev.Assign(tmp);
          dmBackground: begin
                        if glbimg.Images.SubImages[frame].Transparent then begin
                                                                           prev.Canvas.Brush.Color:=glbimg.Images.SubImages[frame].GraphicControlExtension.TransparentColor;
                                                                           prev.Canvas.FillRect(prev.Canvas.ClipRect);
                                                                           end
                        else begin
                             prev.Canvas.Brush.Color:=glbimg.BackgroundColor;
                             prev.Canvas.FillRect(prev.Canvas.ClipRect);
                             end;
                        end;
          dmPrevious: prev.Assign(old);
          end;
     try
        if glbimg.Images.SubImages[frame].GraphicControlExtension.Delay>3 then delay:=glbimg.Images.SubImages[frame].GraphicControlExtension.Delay*10
        else delay:=30;
        except
        delay:=GIFDefaultDelay*10;
        end;
     end
     else delay:=0;
     img:=tmp.ReleaseHandle();
     tmp.Free();
     old.Free();
     end;
// Result
Result:=1;
except
      Result:=0;
      img:=0;
      delay:=0;
      end;
end;

function FIPISanimDeInit():integer; stdcall;
begin
try
   glbimg.Free();
   prev.Free();
   except
   end;
Result:=1;
end;

exports
       FIPISopen, FIPISsave, FIPISexport,
       FIPISanimInit, FIPISanimConfirm, FIPISanimRestart, FIPISanimGetFrame, FIPISanimDeInit;

begin
GIFImageDefaultDrawOptions:=[goAsync, goLoop, goAnimate, goDither, goAutoDither, goClearOnLoop];

end.
 