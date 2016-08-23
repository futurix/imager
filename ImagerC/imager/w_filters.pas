unit w_filters;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmFilters = class(TForm)
    lbxFilters: TListBox;
    pnlButtons: TPanel;
    btnApply: TButton;
    btnRestore: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbxFiltersDblClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFilters: TfrmFilters;

implementation

uses globals, main, f_windows, f_reg, f_plugins, f_images;

{$R *.DFM}

procedure TfrmFilters.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
SaveFormPosition(frmFilters,sReg + '\Position\Filters');
// UI setup
frmMain.miFilters.Checked:=false;
frmMain.tbnFilters.Down:=false;
end;

procedure TfrmFilters.FormDestroy(Sender: TObject);
begin
frmFilters:=nil;
end;

procedure TfrmFilters.FormCreate(Sender: TObject);
begin
LoadFormPosition(frmFilters,sReg + '\Position\Filters',203,246,71,5,0);
reg.OpenKey(sFIPIS + '\Filters',true);
reg.GetValueNames(lbxFilters.Items);
reg.CloseKey();
// UI setup
frmMain.miFilters.Checked:=true;
frmMain.tbnFilters.Down:=true;
end;

procedure TfrmFilters.lbxFiltersDblClick(Sender: TObject);
begin
if lbxFilters.ItemIndex<>-1 then HandleFilter(lbxFilters.Items[lbxFilters.ItemIndex]);
end;

procedure TfrmFilters.btnApplyClick(Sender: TObject);
begin
ApplyChanges();
end;

procedure TfrmFilters.btnRestoreClick(Sender: TObject);
begin
RestoreOriginal();
end;

end.
