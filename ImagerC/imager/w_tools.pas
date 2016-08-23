unit w_tools;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmTools = class(TForm)
    lbxTools: TListBox;
    btnAdd: TButton;
    btnModify: TButton;
    btnDelete: TButton;
    btnOK: TButton;
    dlgSelFile: TOpenDialog;
    lblNote: TLabel;
    btnRename: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnModifyClick(Sender: TObject);
    procedure btnRenameClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTools: TfrmTools;

implementation

uses fipis, globals, main, f_reg, f_plugins;

{$R *.DFM}

procedure TfrmTools.FormClose(Sender: TObject; var Action: TCloseAction);
begin
UpdatePlugIns();
Action:=caFree;
end;

procedure TfrmTools.FormDestroy(Sender: TObject);
begin
frmTools:=nil;
end;

procedure TfrmTools.btnOKClick(Sender: TObject);
begin
Close();
end;

procedure TfrmTools.FormCreate(Sender: TObject);
begin
reg.OpenKey(sFIPIS + '\Apps',true);
reg.GetValueNames(lbxTools.Items);
reg.CloseKey();
end;

procedure TfrmTools.btnAddClick(Sender: TObject);
var
   name: string;
begin
reg.OpenKey(sFIPIS + '\Apps',true);
if InputQuery('Type new link name','This name will appear in Imager menu',name) then
                    begin
                    if ((dlgSelFile.Execute) and (FileExists(dlgSelFile.FileName))) then begin
                                                                                         reg.WriteString(name,dlgSelFile.FileName);
                                                                                         lbxTools.Clear();
                                                                                         reg.GetValueNames(lbxTools.Items);
                                                                                         end;
                    end;
reg.CloseKey();
end;

procedure TfrmTools.btnModifyClick(Sender: TObject);
var
   tmp: string;
begin
reg.OpenKey(sFIPIS + '\Apps',true);
if lbxTools.ItemIndex=-1 then Abort();
tmp:=RegReadStr(lbxTools.Items[lbxTools.ItemIndex],'');
if InputQuery('Changing path','Modify tool path',tmp) then reg.WriteString(lbxTools.Items[lbxTools.ItemIndex],tmp);
reg.CloseKey();
end;

procedure TfrmTools.btnRenameClick(Sender: TObject);
var
   tmp, old, value: string;
begin
reg.OpenKey(sFIPIS + '\Apps',true);
if lbxTools.ItemIndex=-1 then Abort();
tmp:=lbxTools.Items[lbxTools.ItemIndex];
old:=tmp;
value:=RegReadStr(lbxTools.Items[lbxTools.ItemIndex],'');
if InputQuery('Changing name','Modify tool name, that appears in menu',tmp) then
                        begin
                        reg.DeleteValue(old);
                        reg.WriteString(tmp,value);
                        lbxTools.Items.Clear();
                        reg.GetValueNames(lbxTools.Items);
                        end;
reg.CloseKey();
end;

procedure TfrmTools.btnDeleteClick(Sender: TObject);
begin
reg.OpenKey(sFIPIS + '\Apps',true);
if lbxTools.ItemIndex=-1 then Abort();
reg.DeleteValue(lbxTools.Items[lbxTools.ItemIndex]);
lbxTools.Items.Clear();
reg.GetValueNames(lbxTools.Items);
reg.CloseKey();
end;

end.
