unit w_hist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, histogrambox;

type
  TfrmHist = class(TForm)
    hist: THistogramBox;
    btnClose: TButton;
    cbxRed: TCheckBox;
    cbxGreen: TCheckBox;
    cbxBlue: TCheckBox;
    cbxGrey: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbxRedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
	frmHist: TfrmHist;


implementation

uses main;

{$R *.dfm}

procedure TfrmHist.FormCreate(Sender: TObject);
begin
	hist.AttachedImageEnProc := frmMain.img.Proc;
end;

procedure TfrmHist.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
end;

procedure TfrmHist.FormDestroy(Sender: TObject);
begin
	frmHist := nil;
end;

procedure TfrmHist.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

procedure TfrmHist.cbxRedClick(Sender: TObject);
begin
	if cbxRed.Checked then
        hist.HistogramKind := hist.HistogramKind + [hkRed]
    else
    	hist.HistogramKind := hist.HistogramKind - [hkRed];

	if cbxGreen.Checked then
    	hist.HistogramKind := hist.HistogramKind + [hkGreen]
    else
    	hist.HistogramKind := hist.HistogramKind - [hkGreen];

	if cbxBlue.Checked then
    	hist.HistogramKind := hist.HistogramKind + [hkBlue]
    else
    	hist.HistogramKind := hist.HistogramKind - [hkBlue];

	if cbxGrey.Checked then
    	hist.HistogramKind := hist.HistogramKind + [hkGray]
    else
    	hist.HistogramKind := hist.HistogramKind - [hkGray];
end;

end.
