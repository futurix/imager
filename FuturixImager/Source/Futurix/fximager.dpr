program fximager;

{$R 'futurix.res' 'futurix.rc'}

uses
  Windows,
  Messages,
  Forms,
  SysUtils,
  Graphics,
  Dialogs,
  w_main in 'w_main.pas' {frmMain},
  w_about in 'w_about.pas' {frmAbout},
  w_custzoom in 'w_custzoom.pas' {frmCustZoom},
  w_info in 'w_info.pas' {frmInfo},
  f_filectrl in 'f_filectrl.pas',
  f_graphics in 'f_graphics.pas',
  f_images in 'f_images.pas',
  f_nav in 'f_nav.pas',
  f_plugins in 'f_plugins.pas',
  f_tools in 'f_tools.pas',
  f_ui in 'f_ui.pas',
  w_show in 'w_show.pas' {frmShow},
  w_editor in 'w_editor.pas' {frmEditor},
  w_resize in 'w_resize.pas' {frmResize},
  w_rotate in 'w_rotate.pas' {frmRotate},
  w_optgeneral in 'w_optgeneral.pas' {frmOldOptions},
  f_toolbar in 'f_toolbar.pas',
  w_custtb in 'w_custtb.pas' {frmCustTB},
  f_instance in 'f_instance.pas',
  w_preview in 'w_preview.pas' {frmPrint},
  w_sharpen in 'w_sharpen.pas' {frmSharpen},
  fx_core in 'fx_core.pas',
  fx_consts in 'fx_consts.pas',
  fx_ver in 'fx_ver.pas',
  fx_mru in 'fx_mru.pas',
  w_options in 'w_options.pas' {frmOptions},
  fx_pluginscanner in 'fx_pluginscanner.pas',
  fx_pluginmanager in 'fx_pluginmanager.pas',
  fx_internalp in 'fx_internalp.pas';

{$R *.RES}

begin
  Graphics.DefFontData.Name := 'MS Shell Dlg 2';

    hPrevious := 0;
    aAtom := 0;
    sParams := '';
        
    CheckPreviousInstance();
    sParams := Trim(sParams);

    if (hPrevious <> 0) then
        begin
        PassParamsToPreviousInstance();
        Exit;
        end
    else
      begin
        Application.Initialize();
        Application.MainFormOnTaskbar := True;
        Application.Title := 'FuturixImager';
        Application.CreateForm(TfrmMain, frmMain);
  Application.Run();
        end;
end.
