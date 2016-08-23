// Futuris Imager
program imager;

{$R 'futuris.res' 'futuris.rc'}

uses
  Forms,
  Graphics,
  main in 'main.pas' {frmMain},
  w_about in 'w_about.pas' {frmAbout},
  w_custzoom in 'w_custzoom.pas' {frmCustZoom},
  w_setup in 'w_setup.pas' {frmSetup},
  w_formats in 'w_formats.pas' {frmFormats},
  w_info in 'w_info.pas' {frmInfo},
  f_global in 'f_global.pas',
  f_filectrl in 'f_filectrl.pas',
  f_graphics in 'f_graphics.pas',
  f_images in 'f_images.pas',
  f_nav in 'f_nav.pas',
  f_plugins in 'f_plugins.pas',
  f_tools in 'f_tools.pas',
  f_ui in 'f_ui.pas',
  f_clipboard in 'f_clipboard.pas',
  f_frmman in 'f_frmman.pas',
  f_multi in 'f_multi.pas',
  f_anim in 'f_anim.pas',
  globals in 'globals.pas',
  athread in 'athread.pas',
  w_show in 'w_show.pas' {frmShow},
  w_new in 'w_new.pas' {frmNew},
  f_reg in 'f_reg.pas',
  w_fltpreview in 'w_fltpreview.pas' {frmFltPreview},
  f_scan in 'f_scan.pas';

{$R *.RES}

begin
  Graphics.DefFontData.Name := 'MS Shell Dlg';

  Application.Initialize;
  Application.Title := 'Futuris Imager';
  Application.HelpFile := '';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
