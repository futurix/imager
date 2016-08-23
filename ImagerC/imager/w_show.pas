unit w_show;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, StdCtrls, ExtCtrls, ImgList;

type
  TfrmShow = class(TForm)
    tbrShow: TToolBar;
    tbnStart: TToolButton;
    tbnStop: TToolButton;
    Sep_1: TToolButton;
    tbnReverse: TToolButton;
    Sep_2: TToolButton;
    edtTimer: TEdit;
    pnlTimer: TPanel;
    Timer: TTimer;
    tbnSet: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure tbnStartClick(Sender: TObject);
    procedure tbnStopClick(Sender: TObject);
    procedure tbnReverseClick(Sender: TObject);
    procedure tbnSetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmShow: TfrmShow;
  reverse: boolean = false;

implementation

uses main, f_windows, globals, f_debug, f_reg;

{$R *.DFM}

procedure TfrmShow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
// saving position
SaveFormPosOnly(frmShow,sReg + '\Position\SlideShow');
// saving settings
reg.OpenKey(sReg + '\SlideShow',true);
reg.WriteBool('Order',reverse);
reg.WriteInteger('Timer',Timer.Interval);
reg.CloseKey();
// setting UI
frmMain.tbnShow.Down:=false;
frmMain.miShow.Checked:=false;
end;

procedure TfrmShow.FormDestroy(Sender: TObject);
begin
frmShow:=nil;
end;

procedure TfrmShow.FormCreate(Sender: TObject);
begin
// loading position
LoadFormPosOnly(frmShow,sReg + '\Position\SlideShow',71,5);
// loading settings
reg.OpenKey(sReg + '\SlideShow',true);
Timer.Interval:=RegReadInt('Timer',10000);
reverse:=RegReadBool('Order',false);
reg.CloseKey();
// setting UI
frmMain.tbnShow.Down:=true;
frmMain.miShow.Checked:=true;
end;

procedure TfrmShow.TimerTimer(Sender: TObject);
begin
if not reverse then frmMain.miForwardClick(frmShow)
else frmMain.miBackClick(frmShow);
end;

procedure TfrmShow.tbnStartClick(Sender: TObject);
begin
Timer.Enabled:=true;
end;

procedure TfrmShow.tbnStopClick(Sender: TObject);
begin
Timer.Enabled:=false;
end;

procedure TfrmShow.tbnReverseClick(Sender: TObject);
begin
if reverse then reverse:=false
else reverse:=true;
end;

procedure TfrmShow.tbnSetClick(Sender: TObject);
var
   tmp: integer;
begin
tmp:=10;
try
   tmp:=StrToInt(edtTimer.Text);
   except
         Report('Invalid numeric!');
         edtTimer.Text:='10';
         Abort();
   end;
   Timer.Interval:=tmp*1000;
end;

end.
