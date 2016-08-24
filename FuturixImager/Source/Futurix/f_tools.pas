unit f_tools;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms, ShellAPI,
  ShlObj, Printers, c_const, c_utils, c_reg, c_locales;

procedure ProcessCommandLine();
procedure PrintImage();
procedure FileNotFound(path: string);
procedure OpenURL(url: WideString);
procedure PutRegDock();
procedure DefaultPrograms(pr: string = '/launch');
function IsShift(): boolean;
function IsCtrl(): boolean;


implementation

uses w_main, w_show, f_graphics, f_ui, f_nav, f_filectrl, w_preview;

procedure ProcessCommandLine();
var
  fs: boolean;
  filename: string;
begin
  fs := false;
  filename := '';

  // parsing full screen
  if ((ParamStr(1) = '/fs') or (ParamStr(1) = '-fs') or (ParamStr(1) = '--fs') or
    (ParamStr(2) = '/fs') or (ParamStr(2) = '-fs') or (ParamStr(2) = '--fs')) then
    fs := true;

  // parsing filename
  if (ParamCount() > 0) then
    begin
    if FileExists(ParamStr(1)) then
      filename := ParamStr(1);

    if (ParamCount() > 1) then
      begin
      if FileExists(ParamStr(2)) then
        filename := ParamStr(2);
      end;
    end;

  // applying
  if (fs and (not frmMain.full_screen)) then
    ToggleFS();

  if (filename <> '') then
    OpenLocal(filename);
end;

procedure PrintImage();
begin
  if (Printer.Printers.Count > 0) then
    begin
    if not Assigned(frmPrint) then
      begin
      Application.CreateForm(TfrmPrint, frmPrint);

      if FileExists(infImage.path) then
        frmPrint.prwPrint.PrintJobTitle := ExtractFileName(infImage.path)
      else
        frmPrint.prwPrint.PrintJobTitle := sAppName;

      frmPrint.DrawView();
      frmPrint.ShowModal();
      end;
    end
  else
    ShowMessage(LoadLStr(3261));
end;

procedure FileNotFound(path: string);
begin
  if (frmMain.mru.HasItem(path)) then
    begin
    frmMain.mru.RemoveItem(path, true);

    if (infImage.filenum > -1) then
      Dec(infImage.filenum);
    end;

  if (files.IndexOf(path) <> -1) then
    begin
    files.Delete(files.IndexOf(path));

    if (infImage.filenum > -1) then
      Dec(infImage.filenum);

    if (files.Count > 0) then
      GoNext();
    end;
end;

procedure OpenURL(url: WideString);
begin
  ShellExecuteW(Application.Handle, 'open', PWideChar(url), nil, nil, SW_SHOWNORMAL);
end;

procedure PutRegDock();
begin
  FxRegWStr(sAppName, Application.ExeName, sReg);
  FxRegWStr('InstallationPath', fx.ApplicationPath, sReg);
end;

procedure DefaultPrograms(pr: string);
begin
  ShellExecute(
    Application.Handle, 'open', PWideChar(fx.ApplicationPath + FXFILE_FORMATS),
    PWideChar(pr), nil, SW_SHOWNORMAL);
end;

function IsShift(): boolean;
begin
  Result := (HiWord(GetKeyState(VK_SHIFT)) <> 0);
end;

function IsCtrl(): boolean;
begin
  Result := (HiWord(GetKeyState(VK_CONTROL)) <> 0);
end;

end.
