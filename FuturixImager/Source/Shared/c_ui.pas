unit c_ui;

interface

uses
  Windows, SysUtils, Classes, StdCtrls, Controls, Graphics,
  c_const;

// misc functions
procedure SetStyleAsLink(var lbl: TLabel);


implementation

// applies URL style to a label
procedure SetStyleAsLink(var lbl: TLabel);
begin
  lbl.Cursor := crHandPoint;
  lbl.Font.Color := clHotLight;
  lbl.Font.Style := [fsUnderline];
end;

end.
