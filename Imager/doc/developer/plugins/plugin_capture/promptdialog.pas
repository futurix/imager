//------------------------------------------------------------------------------
//  Apprehend Version  : 4.1
//  Copyright (c) 2005 : Adirondack Software & Graphics
//  Created            : 1-09-1992
//  Last Modification  : 07-26-2005
//  Description        : Promptdialog Unit
//------------------------------------------------------------------------------

unit promptdialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmPosition = class ( TForm )
    Label2: TLabel;
    Label1: TLabel;
    procedure FormShow ( Sender: TObject );
    procedure FormKeyDown ( Sender: TObject;var Key: Word;
      Shift: TShiftState );
    procedure FormKeyPress ( Sender: TObject;var Key: Char );
  private
    { Private declarations }
  public
    { Public declarations }
    TMx: Integer;
  end;

var
  frmPosition: TfrmPosition;

implementation

{$R *.dfm}

procedure TfrmPosition.FormShow ( Sender: TObject );
begin
  TMx := 0;
end;

procedure TfrmPosition.FormKeyDown ( Sender: TObject;var Key: Word;
  Shift: TShiftState );
begin
  if ( Key = VK_Escape ) then
    Hide;
end;

procedure TfrmPosition.FormKeyPress ( Sender: TObject;var Key: Char );
begin
  Hide;
end;

end.

