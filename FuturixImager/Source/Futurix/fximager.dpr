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
  f_toolbar in 'f_toolbar.pas',
  w_custtb in 'w_custtb.pas' {frmCustTB},
  f_instance in 'f_instance.pas',
  w_preview in 'w_preview.pas' {frmPrintPreview},
  w_sharpen in 'w_sharpen.pas' {frmSharpen},
  fx_core in 'fx_core.pas',
  fx_defs in 'fx_defs.pas',
  fx_mru in 'fx_mru.pas',
  w_options in 'w_options.pas' {frmOptions},
  fx_pluginscanner in 'fx_pluginscanner.pas',
  fx_pluginmanager in 'fx_pluginmanager.pas',
  fx_internalp in 'fx_internalp.pas',
  o_display in 'o_display.pas' {fraOptDisplay: TFrame},
  o_plugins in 'o_plugins.pas' {fraOptPlugins: TFrame},
  fx_cmdline in 'fx_cmdline.pas',
  o_formats in 'o_formats.pas' {fraOptFormats: TFrame},
  o_formatsxp in 'o_formatsxp.pas' {fraOptFormatsXP: TFrame},
  w_save_JPEG in 'w_save_JPEG.pas' {frmJPEGsave},
  w_save_JPEG2K in 'w_save_JPEG2K.pas' {frmJPsave},
  w_save_TIFF in 'w_save_TIFF.pas' {frmTIFFsave},
  w_save_XR in 'w_save_XR.pas' {frmXRsave},
  w_lsJPEG_cut in 'w_lsJPEG_cut.pas' {frmCut},
  w_lsJPEG_rotate in 'w_lsJPEG_rotate.pas' {frmJPEG},
  w_setwall in 'w_setwall.pas' {frmWallpaperS},
  w_viewwall in 'w_viewwall.pas' {frmWallpaper},
  fx_formats_legacy in 'fx_formats_legacy.pas',
  o_themes in 'o_themes.pas' {fraOptThemes: TFrame},
  o_iconlib in 'o_iconlib.pas' {fraOptIconLib: TFrame},
  o_general in 'o_general.pas' {fraOptGeneral: TFrame},
  o_advanced in 'o_advanced.pas' {fraOptAdvanced: TFrame};

begin
  Graphics.DefFontData.Name := 'MS Shell Dlg 2';

  hPrevious := 0;
  aAtom := 0;
  sParams := '';

  if ProcessSpecialArguments() then
    Exit();

  CheckPreviousInstance();
  sParams := Trim(sParams);

  if (hPrevious <> 0) then
    begin
    PassParamsToPreviousInstance();
    Exit();
    end;

  Application.Initialize();
  Application.MainFormOnTaskbar := True;
  Application.Title := 'FuturixImager';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run();
end.
