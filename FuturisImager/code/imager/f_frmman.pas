// form launching routines
unit f_frmman;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs, ShellAPI,
  c_const;

procedure ShowAbout();
procedure ShowSettings();
procedure ShowFormats();
procedure ShowThumb();
procedure ShowShow();
procedure ShowFilters();
procedure ShowInfo();
procedure ShowNew();

implementation

uses
  w_about, w_custzoom, w_setup, w_formats, w_info,
  w_show, w_new,
  f_strutils, f_filectrl, main, globals, w_fltpreview;

procedure ShowAbout();
begin
if not Assigned(frmAbout) then
  begin
  Application.CreateForm(TfrmAbout,frmAbout);
  frmAbout.ShowModal();
  end;
end;

procedure ShowSettings();
begin
if not Assigned(frmSetup) then
  begin
  Application.CreateForm(TfrmSetup,frmSetup);
  frmSetup.ShowModal();
  end;
end;

procedure ShowFormats();
begin
if not Assigned(frmFormats) then
  begin
  Application.CreateForm(TfrmFormats,frmFormats);
  frmFormats.ShowModal();
  end;
end;

procedure ShowThumb();
var
   tmp, dir: string;
begin
tmp:=(GetAppFolder() + 'browser.exe');
if infImage.path<>'' then
  begin
  dir:=Slash(ExtractFileDir(infImage.path));
  ShellExecute(0,'open',PCHar(tmp),PChar(dir),nil,SW_SHOWNORMAL);
  end
else
  ShellExecute(0,'open',PCHar(tmp),nil,nil,SW_SHOWNORMAL);
end;

procedure ShowShow();
begin
if not Assigned(frmShow) then
  begin
  Application.CreateForm(TfrmShow,frmShow);
  frmShow.Show();
  end
else
  frmShow.Close();
end;

procedure ShowFilters();
begin
if not Assigned(frmFltPreview) then
  begin
  Application.CreateForm(TfrmFltPreview,frmFltPreview);
  frmFltPreview.ShowModal();
  end;
end;

procedure ShowInfo();
begin
if not Assigned(frmInfo) then
  begin
  Application.CreateForm(TfrmInfo,frmInfo);
  frmInfo.ShowModal();
  end;
end;

procedure ShowNew();
begin
if not Assigned(frmNew) then
  begin
  Application.CreateForm(TfrmNew,frmNew);
  frmNew.ShowModal();
  end;
end;

end.
