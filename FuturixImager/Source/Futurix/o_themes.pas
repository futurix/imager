unit o_themes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls;

type
  TfraOptThemes = class(TFrame)
    lblSelect: TLabel;
    ComboBox1: TComboBox;
  private
  public
    procedure Load();
    procedure Reload();
    procedure Save();
    procedure Cancelled();
  end;


implementation

{$R *.dfm}

procedure TfraOptThemes.Load();
begin
  //
end;

procedure TfraOptThemes.Reload();
begin
  //
end;

procedure TfraOptThemes.Save();
begin
  //
end;

procedure TfraOptThemes.Cancelled();
begin
  //
end;

end.
