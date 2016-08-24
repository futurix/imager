unit o_welcome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, StdCtrls;

type
  TfraOptWelcome = class(TFrame)
    StaticText1: TStaticText;
  private
    { Private declarations }
  public
    procedure Load();
    procedure Save();
  end;


implementation

{$R *.dfm}

procedure TfraOptWelcome.Load();
begin
  //
end;

procedure TfraOptWelcome.Save();
begin
  //
end;

end.
