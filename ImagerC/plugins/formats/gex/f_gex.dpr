library f_gex;

{$HINTS OFF}
{$WARNINGS OFF}

uses
  SysUtils, Classes, Windows, Graphics, GraphicEx;

{$R *.RES}
{$R fipis.res}

function FIPISopen(path, ext: PChar; app: THandle):hBitmap; stdcall;
var
   bmp: TBitmap;
   tif: TTIFFGraphic;
   eps: TEPSGraphic;
   sgi: TSGIGraphic;
   dsk: TAutodeskGraphic;
   tga: TTargaGraphic;
   pcx: TPCXGraphic;
   pcd: TPCDGraphic;
   ppm: TPPMGraphic;
   cut: TCUTGraphic;
   wvf: TRLAGraphic;
   psd: TPSDGraphic;
   img: TPicture;
   psp: TPSPGraphic;
begin
Result:=0;
// Starting stuff
if ((ext='tif')or(ext='tiff')or(ext='fax')or(ext='')) then begin
                                                              // TTIFFGraphic
                                                              tif:=TTIFFGraphic.Create();
                                                              bmp:=TBitmap.Create();
                                                              try
                                                                 tif.LoadFromFile(path);
                                                                 bmp.Assign(tif);
                                                                 Result:=bmp.ReleaseHandle();
                                                                 except
                                                                 end;
                                                              tif.Free();
                                                              bmp.Free();
                                                              end
else if (ext='eps') then begin
                         // TEPSGraphic
                         eps:=TEPSGraphic.Create();
                         bmp:=TBitmap.Create();
                         try
                            eps.LoadFromFile(path);
                            bmp.Assign(eps);
                            Result:=bmp.ReleaseHandle();
                            except
                            end;
                         eps.Free();
                         bmp.Free();
                         end
else if ((ext='bw')or(ext='rgb')or(ext='rgba')or(ext='sgi')) then begin
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
else if ((ext='cel')or(ext='pic')) then begin
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
else if ((ext='tga')or(ext='vst')or(ext='icb')or(ext='vda')or(ext='win')) then begin
                                                                               // TTargaGraphic
                                                                               tga:=TTargaGraphic.Create();
                                                                               bmp:=TBitmap.Create();
                                                                               try
                                                                                  tga.LoadFromFile(path);
                                                                                  bmp.Assign(tga);
                                                                                  Result:=bmp.ReleaseHandle();
                                                                                  except
                                                                                  end;
                                                                               tga.Free();
                                                                               bmp.Free();
                                                                               end
else if ((ext='pcx')or(ext='pcc')or(ext='scr')) then begin
                                                     // TPCXGraphic
                                                     pcx:=TPCXGraphic.Create();
                                                     bmp:=TBitmap.Create();
                                                     try
                                                        pcx.LoadFromFile(path);
                                                        bmp.Assign(pcx);
                                                        Result:=bmp.ReleaseHandle();
                                                        except
                                                        end;
                                                     pcx.Free();
                                                     bmp.Free();
                                                     end
else if (ext='pcd') then begin
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
else if ((ext='ppm')or(ext='pgm')or(ext='pbm')) then begin
                                                     // TPPMGraphic
                                                     ppm:=TPPMGraphic.Create();
                                                     bmp:=TBitmap.Create();
                                                     try
                                                        ppm.LoadFromFile(path);
                                                        bmp.Assign(ppm);
                                                        Result:=bmp.ReleaseHandle();
                                                        except
                                                        end;
                                                     ppm.Free();
                                                     bmp.Free();
                                                     end
else if (ext='cut') then begin
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
else if ((ext='rla')or(ext='rpf')) then begin
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
else if ((ext='psd')or(ext='pdd')) then begin
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
else if (ext='psp') then begin
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

function FIPISsave(path, ext: PChar; app: THandle; img: hBitmap):integer; stdcall;
var
   bmp: TBitmap;
   tga: TTargaGraphic;
begin
Result:=1;
tga:=TTargaGraphic.Create();
bmp:=TBitmap.Create();
try
   bmp.Handle:=img;
   tga.Assign(bmp);
   tga.SaveToFile(path);
   except
         Result:=0;
   end;
tga.Free();
bmp.Free();
end;

exports
       FIPISopen, FIPISsave;

begin
end.
