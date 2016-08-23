// debugging and reporting
unit f_debug;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms;

procedure Report(what: string; priority: integer = 1);

implementation

// error report
procedure Report(what: string; priority: integer = 1);
begin
case priority of
  1: begin
     // normal (default)
     Application.MessageBox(PChar(what),'Futuris Imager',MB_OK+MB_ICONINFORMATION);
     end;
  2: begin
     // critical
     Application.MessageBox(PChar(what),'Futuris Imager',MB_OK+MB_ICONERROR);
     end;
  3: begin
     // fatal (with exit)
     Application.MessageBox(PChar(what),'Futuris Imager',MB_OK+MB_ICONERROR);
     Application.Terminate();
     end;
  end;
end;

end.
