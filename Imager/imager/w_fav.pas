unit w_fav;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, ToolWin,
  c_const;

type
  TfrmFav = class(TForm)
    lvwFavs: TListView;
    tbrFav: TToolBar;
    tbnAdd: TToolButton;
    tbnDelete: TToolButton;
    ToolButton3: TToolButton;
    tbnRename: TToolButton;

    procedure UpdateFavs();

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvwFavsDblClick(Sender: TObject);
    procedure lvwFavsClick(Sender: TObject);
    procedure tbnDeleteClick(Sender: TObject);
    procedure tbnAddClick(Sender: TObject);
    procedure tbnRenameClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFav: TfrmFav;

implementation

uses main, globals, f_strutils, f_graphics, f_reg;

{$R *.DFM}

procedure TfrmFav.UpdateFavs();
var
  s: TStringList;
  i: integer;
  item: TListItem;
begin
lvwFavs.Items.Clear();
s:=TStringList.Create();
reg.OpenKey(sReg + '\Favorites',true);
reg.GetValueNames(s);
if s.Count>0 then
  begin
  for i:=0 to (s.Count-1) do
    begin
    item:=lvwFavs.Items.Add();
    item.Caption:=s[i];
    item.ImageIndex:=37;
    end;
  end;
s.Free();
reg.CloseKey();
end;

procedure TfrmFav.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
frmMain.tbnFav.Down:=false;
frmMain.miFavorites.Checked:=false;
end;

procedure TfrmFav.FormDestroy(Sender: TObject);
begin
frmFav:=nil;
end;

procedure TfrmFav.FormCreate(Sender: TObject);
begin
frmMain.tbnFav.Down:=true;
frmMain.miFavorites.Checked:=true;
UpdateFavs();
end;

procedure TfrmFav.lvwFavsDblClick(Sender: TObject);
begin
reg.OpenKey(sReg + '\Favorites',true);
if lvwFavs.Selected<>nil then Load(reg.RStr(lvwFavs.Selected.Caption,''));
reg.CloseKey();
end;

procedure TfrmFav.lvwFavsClick(Sender: TObject);
begin
reg.OpenKey(sReg + '\Favorites',true);
if lvwFavs.Selected<>nil then
  frmMain.sbrMain.Panels[1].Text:=reg.RStr(lvwFavs.Selected.Caption,'');
reg.CloseKey();
end;

procedure TfrmFav.tbnDeleteClick(Sender: TObject);
begin
if MessageBox(Application.Handle,'Are you sure you want to delete this favorite ?','Futuris Imager',MB_YESNO+MB_ICONQUESTION)=ID_NO then Abort();
reg.OpenKey(sReg + '\Favorites',true);
if lvwFavs.Selected<>nil then
  begin
  reg.DeleteValue(lvwFavs.Selected.Caption);
  lvwFavs.Items.Delete(lvwFavs.Selected.Index);
  end;
reg.CloseKey();
end;

procedure TfrmFav.tbnAddClick(Sender: TObject);
var
  url, ttl: string;
begin
url:=infImage.path;
ttl:=ExtractFileName(infImage.path);
if not InputQuery('Futuris Imager','Type a name for new favorite...',ttl)
   then Abort();
if ttl='' then
  begin
  ShowMessage('Favorite name cannot be blank!');
  Abort();
  end;
reg.OpenKey(sReg + '\Favorites',true);
if reg.RStr(ttl,'')<>'' then
  begin
  ShowMessage('Favorite with such title already exists!');
  Abort();
  end;
reg.CloseKey();
if not InputQuery('Futuris Imager','Type new favorite path...',url)
   then Abort();
if ttl='' then
  begin
  ShowMessage('Favorite path cannot be blank!');
  Abort();
  end;
reg.OpenKey(sReg + '\Favorites',true);
reg.WriteString(ttl,url);
reg.CloseKey();
UpdateFavs();
end;

procedure TfrmFav.tbnRenameClick(Sender: TObject);
var
  ttl, url, new: string;
begin
reg.OpenKey(sReg + '\Favorites',true);
if lvwFavs.Selected<>nil then
  begin
  ttl:=lvwFavs.Selected.Caption;
  new:=ttl;
  if InputQuery('Futuris Imager','Type new name...',new) then
    begin
    url:=reg.RStr(ttl,'');
    reg.DeleteValue(lvwFavs.Selected.Caption);
    lvwFavs.Items.Delete(lvwFavs.Selected.Index);
    reg.WriteString(new,url);
    UpdateFavs();
    end;
  end;
reg.CloseKey();
end;

end.
