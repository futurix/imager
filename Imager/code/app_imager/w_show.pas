unit w_show;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ToolWin, StdCtrls, ExtCtrls, ImgList,
  c_const, c_wndpos, c_locales;

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
    { Private declarations }
  public
    procedure Localize();
  end;

var
	frmShow: TfrmShow;


implementation

uses main, f_tools;

{$R *.DFM}

procedure TfrmShow.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;

	// saving position
	SaveWindowPosition(@frmShow, sSettings + '\Wnd', 'Show_');

	// saving settings
	reg.OpenKey(sSettings, true);
	if rbnNormal.Checked then reg.WInteger('SlideShow_ShowOrder', 0)
  		else if rbnReverse.Checked then reg.WInteger('SlideShow_ShowOrder', 1)
  			else if rbnRandom.Checked then reg.WInteger('SlideShow_ShowOrder', 2)
      			else reg.WInteger('SlideShow_ShowOrder', 0);
	reg.WInteger('SlideShow_Timer', Timer.Interval);
	reg.CloseKey();

	// setting UI
	frmMain.miShow.Checked := false;
end;

procedure TfrmShow.FormDestroy(Sender: TObject);
begin
	frmShow := nil;
end;

procedure TfrmShow.FormCreate(Sender: TObject);
begin
    Localize();

	// loading position
	RestoreWindowPosition(@frmShow, sSettings + '\Wnd', 100, 15, 'Show_');

	// loading settings
	reg.OpenKey(sSettings, true);
	Timer.Interval := reg.RInt('SlideShow_Timer', 5000);
	try
  		edtTimer.Text := FloatToStr(Timer.Interval / 1000);
  	except
  	end;

	case reg.RInt('SlideShow_ShowOrder', 0) of
  		0: rbnNormal.Checked := true;
  		1: rbnReverse.Checked := true;
  		2: rbnRandom.Checked := true;
  	end;
	reg.CloseKey();

	// setting UI
	frmMain.miShow.Checked := true;
end;

procedure TfrmShow.TimerTimer(Sender: TObject);
begin
	Self.Caption := Format(LoadLStr(728), [IntToStr(Round(Timer.Interval / 1000))]);

	if rbnNormal.Checked then frmMain.miGoForwardClick(frmShow)
  		else if rbnReverse.Checked then frmMain.miGoBackClick(frmShow)
  			else if rbnRandom.Checked then frmMain.miGoRandomClick(frmShow)
      			else frmMain.miGoForwardClick(frmShow);
end;

procedure TfrmShow.btnStartClick(Sender: TObject);
begin
	Self.Caption := Format(LoadLStr(728), [IntToStr(Round(Timer.Interval / 1000))]);

	Timer.Enabled := true;
end;

procedure TfrmShow.btnStopClick(Sender: TObject);
begin
    Self.Caption := LoadLStr(720);

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
    	ShowMessage(LoadLStr(621));
		edtTimer.Text := '5';
		Abort();
	end;

	Timer.Interval := tmp * 1000;

	if Timer.Enabled then
		Self.Caption := Format(LoadLStr(728), [IntToStr(Round(Timer.Interval / 1000))])
	else
		Self.Caption := LoadLStr(720);
end;

procedure TfrmShow.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if (Key = VK_F3) then
    	frmShow.Visible := (not frmShow.Visible);
end;

procedure TfrmShow.Localize();
begin
    Self.Caption			:= LoadLStr(720);
    btnStart.Caption		:= LoadLStr(60);
	btnStop.Caption			:= LoadLStr(61);
    lblTimer.Caption		:= LoadLStr(721);
    btnSet.Caption			:= LoadLStr(722);
    gbxDirection.Caption	:= LoadLStr(723);
    rbnNormal.Caption		:= LoadLStr(724);
    rbnReverse.Caption		:= LoadLStr(725);
    rbnRandom.Caption		:= LoadLStr(726);
    stxHint.Caption			:= LoadLStr(727);
end;

end.
