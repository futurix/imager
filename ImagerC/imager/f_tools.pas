// tool routines
unit f_tools;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms, ShellAPI;

procedure PrintImage(fast: boolean = false);
procedure CommandLine();
procedure ProcessStartUp();
procedure PlugScan();
procedure FileNotFound(path: string);

implementation

uses globals, main, w_show, f_graphics, f_ui, f_strutils, f_nav,
     f_filectrl, f_reg, w_formats;

// print with preview
procedure PrintImage(fast: boolean = false);
var
  DoPrint: TDoPrint;
  lib: THandle;
  bmp: TBitmap;
begin
// starting the stuff
lib:=0;
try
lib:=LoadLibrary('print.dll');
if lib=0 then Application.MessageBox('Cannot load print DLL!','Error!',MB_OK+MB_ICONERROR)
else begin
     @DoPrint:=GetProcAddress(lib,'DoPrint');
     if not (@DoPrint=nil) then begin
                                bmp:=TBitmap.Create();
                                bmp.Assign(infImage.original);
                                bmp.PixelFormat:=pf24bit;
                                DoPrint(Application.Handle,bmp.ReleaseHandle,PChar(infImage.path),fast);
                                bmp.Free();
                                end;
     end;
except
end;
FreeLibrary(lib);
end;

// reads command line
procedure CommandLine();
var
   i: integer;
   already_loaded: boolean;
begin
already_loaded:=false;
for i:=1 to ParamCount() do begin
                            // Parsing params
                            if FileExists(ParamStr(i)) then begin
                                                            if already_loaded=false then begin
                                                                                         // loading file
                                                                                         already_loaded:=true;
                                                                                         Load(ParamStr(i));
                                                                                         end
                                                            else begin
                                                                 // starting external app
                                                                 ShellExecute(0,'open',PChar(ParamStr(i)),nil,nil,SW_SHOWNORMAL);
                                                                 end;
                                                            end
                            else begin
                                 if DirExists(ParamStr(i)) then begin
                                                                Include(infSettings.showparams, soDirAsParam);
                                                                infSettings.dir:=ParamStr(i);
                                                                end
                                 else begin
                                      if ParamStr(i)='/fs' then if not infSettings.full_screen then ToggleFS();
                                      if ParamStr(i)='/print' then begin
                                                              if infImage.path<>'' then begin
                                                                                        Application.ShowMainForm:=false;
                                                                                        PrintImage(true);
                                                                                        Application.Terminate();
                                                                                        end;
                                                              end;
                                      if ((ParamStr(i)='/ss') or (ParamStr(i)='/show') or (ParamStr(i)='/slideshow')) then Include(infSettings.showparams, soSlideShow);
                                      if ParamStr(i)='/regdock' then begin
                                                                     if not Assigned(frmFormats) then begin
                                                                                                      WriteHandler();
                                                                                                      PutRegDock();
                                                                                                      UpdateAssociations();
                                                                                                      Application.ShowMainForm:=false;
                                                                                                      Application.Terminate();
                                                                                                      end;
                                                                     end;
                                      if ParamStr(i)='/unreg' then begin
                                                                   Application.CreateForm(TfrmFormats,frmFormats);
                                                                   frmFormats.btnSelectNone.Click();
                                                                   frmFormats.Uninstall();
                                                                   frmFormats.Free();
                                                                   UpdateAssociations();
                                                                   Application.ShowMainForm:=false;
                                                                   Application.Terminate();
                                                                   end;
                                      end;
                                 end;
                            end;
end;

// runs advanced start-up routines
procedure ProcessStartUp();
begin
if soSlideShow in infSettings.showparams then begin
                                              if soDirAsParam in infSettings.showparams then begin
                                                                                             // slide show in dir
                                                                                             Exclude(infSettings.showparams, soSlideShow);
                                                                                             Exclude(infSettings.showparams, soDirAsParam);
                                                                                             ScanFolder(infSettings.dir);
                                                                                             if files.Count>0 then begin
                                                                                                                   Load(files[0]);
                                                                                                                   frmMain.miStartSlideShowClick(Application);
                                                                                                                   end
                                                                                             else if infSettings.full_screen then ToggleFS();
                                                                                             infSettings.dir:='';
                                                                                             end
                                              else begin
                                                   // simple slide show
                                                   Exclude(infSettings.showparams, soSlideShow);
                                                   if infImage.path<>'' then frmMain.miStartSlideShowClick(Application);
                                                   end;
                                              end
else begin
     if soDirAsParam in infSettings.showparams then begin
                                                    // opening folder
                                                    Exclude(infSettings.showparams, soDirAsParam);
                                                    ScanFolder(infSettings.dir);
                                                    if files.Count>0 then Load(files[0]);
                                                    infSettings.dir:='';
                                                    end;
     end;
end;

// scans for plug-ins
procedure PlugScan();
var
   lib: THandle;
   DoScan: TDoScan;
begin
lib:=LoadLibrary('PLUGSCAN.DLL');
if lib<>0 then begin
               try
                  @DoScan:=GetProcAddress(lib,'DoScan');
                  if not (@DoScan=nil) then DoScan(Application.Handle,PChar(GetAppFolder()))
                  else MessageBox(0,'Required DLL "PLUGSCAN.DLL" corrupted. Plug-ins cannot be scanned.','Error!',MB_OK+MB_ICONERROR);
                  finally
                         FreeLibrary(lib);
                  end;
               end
else MessageBox(0,'Required DLL "PLUGSCAN.DLL" not found. Plug-ins cannot be scanned.','Error!',MB_OK+MB_ICONERROR);
end;

// do something if file not found
procedure FileNotFound(path: string);
begin
if frmMain.MRU.Files.IndexOf(path)<>-1 then begin
                                            frmMain.MRU.Files.Delete(frmMain.MRU.Files.IndexOf(path));
                                            if infImage.filenum>-1 then Dec(infImage.filenum);
                                            end;
if files.IndexOf(path)<>-1 then begin
                                files.Delete(files.IndexOf(path));
                                if infImage.filenum>-1 then Dec(infImage.filenum);
                                if files.Count>0 then GoNext();
                                end;
end;

end.
