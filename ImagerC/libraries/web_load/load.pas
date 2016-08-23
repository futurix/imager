unit load;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, HttpProt;

type
  TfrmLoad = class(TForm)
    btnCancel: TButton;
    http: THttpCli;
    lblCurrent: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure httpRequestDone(Sender: TObject; RqType: THttpRequest;
      Error: Word);
    procedure httpDocBegin(Sender: TObject);
    procedure httpDocEnd(Sender: TObject);
    procedure httpDocData(Sender: TObject; Buffer: Pointer; Len: Integer);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function LoadFile(app: THandle; url, tempfile, ua, ref: PChar):PChar; stdcall;

var
  frmLoad: TfrmLoad;
  file_url, temp_file, user_agent, referrer, feedback: string;

implementation

function LoadFile(app: THandle; url, tempfile, ua, ref: PChar):PChar;
begin
// starting up
Application.Handle:=app;
// vars
file_url:=String(url);
temp_file:=String(tempfile);
user_agent:=String(ua);
referrer:=String(ref);
if Length(url)>8 then
  begin
  // form
  frmLoad:=TfrmLoad.Create(Application);
  frmLoad.ShowModal();
  end;
// finalizing
Result:=PChar(feedback);
frmLoad.Free();
end;

{$R *.DFM}

procedure TfrmLoad.FormCreate(Sender: TObject);
begin
http.URL:=file_url;
http.Agent:=user_agent;
http.Reference:=referrer;
http.GetASync();
end;

procedure TfrmLoad.httpRequestDone(Sender: TObject; RqType: THttpRequest;
  Error: Word);
begin
feedback:=http.ContentType;
frmLoad.Close();
end;

procedure TfrmLoad.httpDocBegin(Sender: TObject);
begin
http.RcvdStream:=TFileStream.Create(String(temp_file),fmCreate);
end;

procedure TfrmLoad.httpDocEnd(Sender: TObject);
begin
http.RcvdStream.Free();
http.RcvdStream:=nil;
end;

procedure TfrmLoad.httpDocData(Sender: TObject; Buffer: Pointer;
  Len: Integer);
begin
lblCurrent.Caption:= 'Downloaded: ' + IntToStr(http.RcvdCount) + ' bytes.';
end;

procedure TfrmLoad.btnCancelClick(Sender: TObject);
begin
http.RcvdStream.Free();
http.RcvdStream:=nil;
feedback:='Cancelled';
frmLoad.Close();
end;

end.
