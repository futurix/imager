program browser;

uses
  Forms,
  main in 'main.pas' {frmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Futuris File Browser';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
