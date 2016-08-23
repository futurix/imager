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
  FIPIShelpSelectColor, FIPIShelpDither, FIPIShelpDitherOnDemand,
  FIPIShelpGetBitmap, FIPIShelpBrowseForBitmap, FIPIShelpPrint;

begin
end.
 
