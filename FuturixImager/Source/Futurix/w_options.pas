unit w_options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImgList;

type
  TfrmOptions = class(TForm)
    sbxFrameHost: TScrollBox;
    sbxCommands: TScrollBox;
    tvwCategories: TTreeView;
    btnOK: TButton;
    btnCancel: TButton;
    sbxSplitter: TScrollBox;
    StaticText1: TStaticText;
    imlOptions: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Localize();
  end;

var
  frmOptions: TfrmOptions;

implementation

{$R *.dfm}

procedure TfrmOptions.FormCreate(Sender: TObject);
begin
  Localize();
end;

procedure TfrmOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //

  Action := caFree;
end;

procedure TfrmOptions.FormDestroy(Sender: TObject);
begin
  frmOptions := nil;
end;

procedure TfrmOptions.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Self.Close();
end;

procedure TfrmOptions.Localize();
begin
  //Self.Caption      := Format(LoadLStr(700), [sAppName]);
end;

procedure TfrmOptions.btnOKClick(Sender: TObject);
begin
  //

  Close();
end;

procedure TfrmOptions.btnCancelClick(Sender: TObject);
begin
  //

  Close();
end;

end.
