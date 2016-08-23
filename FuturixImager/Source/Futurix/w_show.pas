unit w_show;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, StdCtrls, ExtCtrls, ImgList,
  c_const, c_wndpos, c_reg;

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
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  public
  end;

var
  frmShow: TfrmShow;


implementation

uses w_main, f_tools;

{$R *.DFM}

procedure TfrmShow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;

  // saving position
  SaveWindowPosition(@frmShow, sSettings + '\Wnd', 'Show_');

  // saving settings
  if rbnNormal.Checked then FxRegWInt('SlideShow_Order', 0)
    else if rbnReverse.Checked then FxRegWInt('SlideShow_Order', 1)
    else if rbnRandom.Checked then FxRegWInt('SlideShow_Order', 2)
    else FxRegWInt('SlideShow_Order', 0);
  FxRegWInt('SlideShow_Timer', Timer.Interval);

  // setting UI
  frmMain.miShow.Checked := false;
  frmmain.tbnShow.Down := false;
end;

procedure TfrmShow.FormDestroy(Sender: TObject);
begin
  frmShow := nil;
end;

procedure TfrmShow.FormCreate(Sender: TObject);
begin
  // loading position
  RestoreWindowPosition(@frmShow, sSettings + '\Wnd', 100, 15, 'Show_');

  // loading settings
  Timer.Interval := FxRegRInt('SlideShow_Timer', 5000);
  try
    edtTimer.Text := FloatToStr(Timer.Interval / 1000);
  except
  end;

  case FxRegRInt('SlideShow_Order', 0) of
    0: rbnNormal.Checked := true;
    1: rbnReverse.Checked := true;
    2: rbnRandom.Checked := true;
  end;

  // setting UI
  frmMain.miShow.Checked := true;
  frmmain.tbnShow.Down := true;
end;

procedure TfrmShow.TimerTimer(Sender: TObject);
begin
  Self.Caption := Format('Slide Show (started, %s sec.)', [IntToStr(Round(Timer.Interval / 1000))]);

  if rbnNormal.Checked then frmMain.miGoForwardClick(frmShow)
    else if rbnReverse.Checked then frmMain.miGoBackClick(frmShow)
    else if rbnRandom.Checked then frmMain.miGoRandomClick(frmShow)
    else frmMain.miGoForwardClick(frmShow);
end;

procedure TfrmShow.btnStartClick(Sender: TObject);
begin
  Self.Caption := Format('Slide Show (started, %s sec.)', [IntToStr(Round(Timer.Interval / 1000))]);

  Timer.Enabled := true;
end;

procedure TfrmShow.btnStopClick(Sender: TObject);
begin
  Self.Caption := 'Slide Show';

  Timer.Enabled := false;
end;

procedure TfrmShow.btnSetClick(Sender: TObject);
var
  tmp: integer;
begin
  tmp := 5;

  try
    tmp := StrToInt(edtTimer.Text);
  except
    ShowMessage('You need to input valid number.');
    edtTimer.Text := '5';
    Abort();
  end;

  Timer.Interval := tmp * 1000;

  if Timer.Enabled then
    Self.Caption := Format('Slide Show (started, %s sec.)', [IntToStr(Round(Timer.Interval / 1000))])
  else
    Self.Caption := 'Slide Show';
end;

procedure TfrmShow.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_F3) then
    frmShow.Visible := (not frmShow.Visible);
end;

end.
