unit w_web;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, ToolWin, ImgList, Buttons;

type
  TfrmWeb = class(TForm)
    lblAddress: TLabel;
    edtURL: TEdit;
    sbnGo: TSpeedButton;
    tbrWeb: TToolBar;
    tbnRefresh: TToolButton;
    Sep_1: TToolButton;
    pnlSTimer: TPanel;
    pnlEdit: TPanel;
    tbnStart: TToolButton;
    tbnStop: TToolButton;
    edtTime: TEdit;
    Timer: TTimer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbnGoClick(Sender: TObject);
    procedure edtURLKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbnRefreshClick(Sender: TObject);
    procedure tbnStartClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure tbnStopClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWeb: TfrmWeb;

implementation

uses main, globals, f_reg, f_ui, f_web, f_windows;

{$R *.DFM}

procedure TfrmWeb.FormClose(Sender: TObject; var Action: TCloseAction);
begin
SaveFormPosition(frmWeb,sReg + '\Position\Web');
Action:=caFree;
end;

procedure TfrmWeb.FormDestroy(Sender: TObject);
begin
// UI
frmMain.tbnWeb.Down:=false;
frmMain.miWeb.Checked:=false;
frmMain.piWeb.Checked:=false;
// other
frmWeb:=nil;
end;

procedure TfrmWeb.FormCreate(Sender: TObject);
begin
LoadFormPosition(frmWeb,sReg + '\Position\Web',448,80,71,5,0);
// UI
frmMain.tbnWeb.Down:=true;
frmMain.miWeb.Checked:=true;
frmMain.piWeb.Checked:=true;
end;

procedure TfrmWeb.sbnGoClick(Sender: TObject);
begin
OpenWeb(edtURL.Text);
end;

procedure TfrmWeb.edtURLKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=VK_RETURN then OpenWeb(edtURL.Text);
end;

procedure TfrmWeb.tbnRefreshClick(Sender: TObject);
begin
if infImage.url<>'' then OpenWeb(infImage.url);
end;

procedure TfrmWeb.tbnStartClick(Sender: TObject);
begin
try
   Timer.Interval:=StrToInt(edtTime.Text)*1000;
   except
         on EConvertError do begin
                             Application.MessageBox('Numeric required!','Error!',MB_OK+MB_ICONERROR);
                             edtTime.Text:='60';
                             Abort();
                             end;
         end;
   Timer.Enabled:=true;
end;

procedure TfrmWeb.TimerTimer(Sender: TObject);
begin
tbnRefreshClick(frmMain);
end;

procedure TfrmWeb.tbnStopClick(Sender: TObject);
begin
Timer.Enabled:=false;
end;

end.
