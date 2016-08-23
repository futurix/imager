program fximager;

{$R 'futurix.res' 'futurix.rc'}

uses
  Windows,
  Messages,
  Forms,
  SysUtils,
  Graphics,
  Dialogs,
  main in 'main.pas' {frmMain},
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
  f_multi in 'f_multi.pas',
  f_anim in 'f_anim.pas',
  athread in 'athread.pas',
  w_show in 'w_show.pas' {frmShow},
  f_scan in 'f_scan.pas',
  w_editor in 'w_editor.pas' {frmEditor},
  w_resize in 'w_resize.pas' {frmResize},
  w_rotate in 'w_rotate.pas' {frmRotate},
  w_optgeneral in 'w_optgeneral.pas' {frmOptions},
  w_optformats in 'w_optformats.pas' {frmOptFormats},
  f_toolbar in 'f_toolbar.pas',
  w_custtb in 'w_custtb.pas' {frmCustTB},
  f_instance in 'f_instance.pas',
  w_preview in 'w_preview.pas' {frmPrint},
  w_sharpen in 'w_sharpen.pas' {frmSharpen};

{$R *.RES}

begin
	if ((ParamStr(1) = '/uninstall') or (ParamStr(1) = '-uninstall') or (ParamStr(1) = '--uninstall')) then
    	begin
        Uninstall();
        UpdateAssociations();
        end
    else
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
  			Application.Title := 'FuturixImager';
  			Application.CreateForm(TfrmMain, frmMain);
  Application.Run();
        	end;
  		end;
end.
