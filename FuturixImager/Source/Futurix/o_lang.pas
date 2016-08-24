unit o_lang;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls;

type
  TfraOptLang = class(TFrame)
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

procedure TfraOptLang.Load();
begin
  //
end;

procedure TfraOptLang.Reload();
begin
  //
end;

procedure TfraOptLang.Save();
begin
  //
end;

procedure TfraOptLang.Cancelled();
begin
  //
end;

end.
