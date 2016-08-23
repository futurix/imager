program fxformats;

{$R 'futurix.res' 'futurix.rc'}

uses
  Windows,
  Messages,
  Forms,
  SysUtils,
  Graphics,
  Dialogs,
  f_tools in 'f_tools.pas',
  w_optgeneral in 'w_optgeneral.pas' {frmOptions},
  w_optformats in 'w_optformats.pas' {frmOptFormats};

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

  		Application.Initialize();
        Application.MainFormOnTaskbar := True;
  		Application.Title := 'FuturixImager';
  		Application.CreateForm(TfrmOptions, frmOptions);
  		Application.Run();
  		end;
end.
