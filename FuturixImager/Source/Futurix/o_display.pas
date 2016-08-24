unit o_display;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ExtCtrls, StdCtrls;

type
  TfraOptDisplay = class(TFrame)
  private
  public
    procedure Load();
    procedure Reload();
    procedure Save();
    procedure Cancelled();
  end;


implementation

uses w_options;

{$R *.dfm}

procedure TfraOptDisplay.Load();
begin
  //
end;

procedure TfraOptDisplay.Reload();
begin
  //
end;

procedure TfraOptDisplay.Save();
begin
  //
end;

procedure TfraOptDisplay.Cancelled();
begin
  //
end;

end.
