unit w_show;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, StdCtrls, ExtCtrls, ImgList,
  c_const, c_pos;

type
  TfrmShow = class(TForm)
    Timer: TTimer;
    btnStart: TButton;
    btnStop: TButton;
    btnSet: TButton;
    gbxDirection: TGroupBox;
    rbnNormal: TRadioButton;
    rbnReverse: TRadioButton;
    rbnRandom: TRadioButton;
    edtTimer: TEdit;
    lblTimer: TLabel;
    stxHint: TStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnSetClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmShow: TfrmShow;

implementation

uses main, globals, f_debug, f_reg;

{$R *.DFM}

procedure TfrmShow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;

// saving position
SaveWindowPosition(frmShow,reg,sReg + '\Position\SlideShow');

// saving settings
reg.OpenKey(sReg + '\SlideShow',true);
if rbnNormal.Checked then reg.WInteger('ShowOrder',0)
  else if rbnReverse.Checked then reg.WInteger('ShowOrder',1)
  	else if rbnRandom.Checked then reg.WInteger('ShowOrder',2)
      else reg.WInteger('ShowOrder',0);
reg.WInteger('Timer',Timer.Interval);
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
RestoreWindowPosition(frmShow,reg,sReg + '\Position\SlideShow',100,15);

// loading settings
reg.OpenKey(sReg + '\SlideShow',true);
Timer.Interval:=reg.RInt('Timer',10000);
try
  edtTimer.Text:=FloatToStr(Timer.Interval/1000);
  except
  end;

case reg.RInt('ShowOrder',0) of
  0: rbnNormal.Checked:=true;
  1: rbnReverse.Checked:=true;
  2: rbnRandom.Checked:=true;
  end;
reg.CloseKey();

// setting UI
frmMain.tbnShow.Down:=true;
frmMain.miShow.Checked:=true;
end;

procedure TfrmShow.TimerTimer(Sender: TObject);
begin
if rbnNormal.Checked then frmMain.miGoForwardClick(frmShow)
  else if rbnReverse.Checked then frmMain.miGoBackClick(frmShow)
  	else if rbnRandom.Checked then frmMain.miGoRandomClick(frmShow)
      else frmMain.miGoForwardClick(frmShow);
end;

procedure TfrmShow.btnStartClick(Sender: TObject);
begin
Timer.Enabled:=true;
end;

procedure TfrmShow.btnStopClick(Sender: TObject);
begin
Timer.Enabled:=false;
end;

procedure TfrmShow.btnSetClick(Sender: TObject);
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

procedure TfrmShow.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (Key=VK_F3) then
    frmShow.Visible:=(not frmShow.Visible);
end;

end.
