library helper;

uses
  SysUtils,
  Classes,
  main in 'main.pas',
  selcolor in 'selcolor.pas' {frmSelectColor},
  seldither in 'seldither.pas' {frmDither};

{$R *.res}

exports
  FIPIShelpSelectColor, FIPIShelpDither, FIPIShelpDitherOnDemand,
  FIPIShelpGetBitmap, FIPIShelpBrowseForBitmap;

begin
end.
 