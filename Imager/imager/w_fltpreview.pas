unit w_fltpreview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls,
  c_const;

type
  TfrmFltPreview = class(TForm)
    lbxFilters: TListBox;
    lblFilters: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    lblPreview: TLabel;
    pnlPreview: TPanel;
    imgPreview: TImage;
    bvlSep: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure lbxFiltersClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFltPreview: TfrmFltPreview;

implementation

uses main, globals, f_reg, f_plugins, f_images;

{$R *.dfm}

procedure TfrmFltPreview.FormCreate(Sender: TObject);
begin
reg.OpenKey(sModules + '\Filters',true);
reg.GetValueNames(lbxFilters.Items);
reg.CloseKey();
end;

procedure TfrmFltPreview.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrmFltPreview.FormDestroy(Sender: TObject);
begin
frmFltPreview:=nil;
end;

procedure TfrmFltPreview.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=VK_ESCAPE then
  Self.Close();
end;

procedure TfrmFltPreview.btnOKClick(Sender: TObject);
begin
if ((lbxFilters.ItemIndex<>-1) and (HandleFilter(lbxFilters.Items[lbxFilters.ItemIndex]))) then
  Self.Close();
end;

procedure TfrmFltPreview.btnCancelClick(Sender: TObject);
begin
Self.Close();
end;

procedure TfrmFltPreview.lbxFiltersClick(Sender: TObject);
var
  tmp: HBITMAP;
begin
if lbxFilters.ItemIndex<>-1 then
  begin
  tmp:=HandleFilterPreview(lbxFilters.Items[lbxFilters.ItemIndex]);
  if tmp<>0 then
    begin
    pnlPreview.Caption:='';
    imgPreview.Picture.Bitmap.Handle:=tmp;
    end
  else
    begin
    pnlPreview.Caption:='No preview available';
    imgPreview.Picture.Bitmap.Assign(infImage.null_bitmap);
    end;
  end;
end;

end.
