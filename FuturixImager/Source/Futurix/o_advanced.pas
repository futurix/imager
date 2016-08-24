unit o_advanced;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls;

type
  TfraOptAdv = class(TFrame)
  private
  public
    procedure Load();
    procedure Reload();
    procedure Save();
    procedure Cancelled();
  end;


implementation

{$R *.dfm}

procedure TfraOptAdv.Load();
begin
  //
end;

procedure TfraOptAdv.Reload();
begin
  //
end;

procedure TfraOptAdv.Save();
begin
  //
end;

procedure TfraOptAdv.Cancelled();
begin
  //
end;

end.
