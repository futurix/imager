library img_helper;

uses
  SysUtils,
  Classes,
  main in 'main.pas',
  selcolor in 'selcolor.pas' {frmSelectColor},
  seldither in 'seldither.pas' {frmDither},
  view in 'view.pas' {frmPrint};

{$R *.res}

exports
  FHelpSelectColor, FHelpDither, FHelpDitherOnDemand,
  FHelpGetBitmap, FHelpBrowseForBitmap, FHelpPrint;

begin
end.
 
