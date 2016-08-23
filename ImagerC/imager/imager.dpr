// Futuris Imager ( codebase C )
program imager;

{$R 'futuris.res' 'futuris.rc'}

uses
  Forms,
  main in 'main.pas' {frmMain},
  w_about in 'w_about.pas' {frmAbout},
  w_web in 'w_web.pas' {frmWeb},
  rsthread in 'rsthread.pas',
  w_custzoom in 'w_custzoom.pas' {frmCustZoom},
  rfthread in 'rfthread.pas',
  w_setup in 'w_setup.pas' {frmSetup},
  w_formats in 'w_formats.pas' {frmFormats},
  w_info in 'w_info.pas' {frmInfo},
  f_global in 'f_global.pas',
  f_debug in 'f_debug.pas',
  f_external in 'f_external.pas',
  f_filectrl in 'f_filectrl.pas',
  f_graphics in 'f_graphics.pas',
  f_images in 'f_images.pas',
  f_nav in 'f_nav.pas',
  f_plugins in 'f_plugins.pas',
  f_strutils in 'f_strutils.pas',
  f_system in 'f_system.pas',
  f_tools in 'f_tools.pas',
  f_ui in 'f_ui.pas',
  f_web in 'f_web.pas',
  f_windows in 'f_windows.pas',
  fipis in 'fipis.pas',
  f_clipboard in 'f_clipboard.pas',
  f_frmman in 'f_frmman.pas',
  w_filters in 'w_filters.pas' {frmFilters},
  f_multi in 'f_multi.pas',
  f_anim in 'f_anim.pas',
  globals in 'globals.pas',
  athread in 'athread.pas',
  f_info in 'f_info.pas',
  w_instplugs in 'w_instplugs.pas' {frmInstPlugs},
  w_confplugs in 'w_confplugs.pas' {frmConfPlugs},
  w_browser in 'w_browser.pas' {frmFile},
  w_show in 'w_show.pas' {frmShow},
  w_tools in 'w_tools.pas' {frmTools},
  w_new in 'w_new.pas' {frmNew},
  w_fav in 'w_fav.pas' {frmFav},
  f_reg in 'f_reg.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Futuris Imager';
  Application.HelpFile := '';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
