// form launching routines
unit f_frmman;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, ShellAPI;

procedure ShowAbout();
procedure ShowSettings();
procedure ShowFormats();
procedure ShowWeb();
procedure ShowFiles();
procedure ShowFavs();
procedure ShowThumb();
procedure ShowShow();
procedure ShowFilters();
procedure ShowInfo();
procedure ShowInstPlugs();
procedure ShowConfPlugs();
procedure ShowTools();
procedure ShowPlace();
procedure ShowNew();
procedure ShowCut();
procedure ShowPCopy();
procedure ShowPPaste();

implementation

uses w_about, w_web, w_custzoom, w_setup, w_formats, w_info, w_filters,
     w_instplugs, w_confplugs, w_tools, w_show, w_browser, w_new, w_fav,
     f_strutils, f_filectrl, main, globals;

procedure ShowAbout();
begin
if not Assigned(frmAbout) then begin
                               Application.CreateForm(TfrmAbout,frmAbout);
                               frmAbout.ShowModal();
                               end;
end;

procedure ShowSettings();
begin
if not Assigned(frmSetup) then begin
                               Application.CreateForm(TfrmSetup,frmSetup);
                               frmSetup.ShowModal();
                               end;
end;

procedure ShowFormats();
begin
if not Assigned(frmFormats) then begin
                                 Application.CreateForm(TfrmFormats,frmFormats);
                                 frmFormats.ShowModal();
                                 end;
end;

procedure ShowWeb();
begin
if not Assigned(frmWeb) then begin
                             Application.CreateForm(TfrmWeb,frmWeb);
                             frmWeb.Show();
                             end
else frmWeb.Close();
end;

procedure ShowFiles();
begin
if not Assigned(frmFile) then begin
                              Application.CreateForm(TfrmFile,frmFile);
                              frmFile.Show();
                              end
else frmFile.Close();
end;

procedure ShowFavs();
begin
if not Assigned(frmFav) then begin
                             Application.CreateForm(TfrmFav,frmFav);
                             frmFav.Show();
                             end
else frmFav.Close();
end;

procedure ShowThumb();
var
   tmp, dir: string;
begin
tmp:=(GetAppFolder() + 'browser.exe');
if infImage.path<>'' then begin
                          dir:=Slash(ExtractFileDir(infImage.path));
                          ShellExecute(0,'open',PCHar(tmp),PChar(dir),nil,SW_SHOWNORMAL);
                          end
else ShellExecute(0,'open',PCHar(tmp),nil,nil,SW_SHOWNORMAL);
end;

procedure ShowShow();
begin
if not Assigned(frmShow) then begin
                              Application.CreateForm(TfrmShow,frmShow);
                              frmShow.Show();
                              end
else frmShow.Close();
end;

procedure ShowFilters();
begin
if not Assigned(frmFilters) then begin
                                 Application.CreateForm(TfrmFilters,frmFilters);
                                 frmFilters.Show();
                                 end
else frmFilters.Close();
end;

procedure ShowInfo();
begin
if not Assigned(frmInfo) then begin
                              Application.CreateForm(TfrmInfo,frmInfo);
                              frmInfo.ShowModal();
                              end;
end;

procedure ShowInstPlugs();
begin
if not Assigned(frmInstPlugs) then begin
                                   Application.CreateForm(TfrmInstPlugs,frmInstPlugs);
                                   frmInstPlugs.ShowModal();
                                   end;
end;

procedure ShowConfPlugs();
begin
if not Assigned(frmConfPlugs) then begin
                                   Application.CreateForm(TfrmConfPlugs,frmConfPlugs);
                                   frmConfPlugs.ShowModal();
                                   end;
end;

procedure ShowTools();
begin
if not Assigned(frmTools) then begin
                               Application.CreateForm(TfrmTools,frmTools);
                               frmTools.ShowModal();
                               end;
end;

procedure ShowPlace();
begin
//
end;

procedure ShowNew();
begin
if not Assigned(frmNew) then begin
                             Application.CreateForm(TfrmNew,frmNew);
                             frmNew.ShowModal();
                             end;
end;

procedure ShowCut();
begin
//
end;

procedure ShowPCopy();
begin
//
end;

procedure ShowPPaste();
begin
//
end;

end.
