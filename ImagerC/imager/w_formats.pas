unit w_formats;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Registry, ShellAPI, ShlObj, CheckLst;

type
  TfrmFormats = class(TForm)
    lblExtensions: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    gbxIcon: TGroupBox;
    btnRefresh: TButton;
    btnSelectAll: TButton;
    btnSelectNone: TButton;
    btnIconViewer: TButton;
    gbxAdds: TGroupBox;
    btnChangeDescription: TButton;
    imgIcon1: TImage;
    imgIcon2: TImage;
    imgIcon3: TImage;
    imgIcon4: TImage;
    rbnIcon1: TRadioButton;
    rbnIcon2: TRadioButton;
    rbnIcon3: TRadioButton;
    rbnIcon4: TRadioButton;
    cbxPrintEnabled: TCheckBox;
    cbxFS: TCheckBox;
    cbxSS: TCheckBox;
    cbxSSFS: TCheckBox;
    cbxBrowser: TCheckBox;
    clbExt: TCheckListBox;
    bvlSep: TBevel;

    procedure GetExtensions();
    procedure GetSupportInfo();
    procedure SaveSupportInfo();
    procedure ChangeDescription();
    function GetExt(ext: string):boolean;
    procedure SetExt(ext: string);
    procedure UnRegExt(ext: string);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure imgIcon1Click(Sender: TObject);
    procedure imgIcon2Click(Sender: TObject);
    procedure imgIcon3Click(Sender: TObject);
    procedure imgIcon4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnChangeDescriptionClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnSelectNoneClick(Sender: TObject);
    procedure btnIconViewerClick(Sender: TObject);
    procedure rbnIcon1Click(Sender: TObject);
    procedure rbnIcon2Click(Sender: TObject);
    procedure rbnIcon3Click(Sender: TObject);
    procedure rbnIcon4Click(Sender: TObject);
    procedure Uninstall();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFormats: TfrmFormats;
  icon_num: integer = 1;
  description: string = 'Futuris Imager Document';

implementation

uses main, globals, f_strutils, f_reg;

{$R *.DFM}

// loads all supported extensions into list
procedure TfrmFormats.GetExtensions();
var
   s: TStringList;
   i: integer;
   excl, tmp: string;
begin
s:=TStringList.Create();
reg.OpenKey(sFIPIS + '\Open',true);
reg.GetValueNames(s);
reg.CloseKey();
reg.OpenKey(sFIPIS,true);
excl:=RegReadStr('RegEx','');
reg.CloseKey();
s.Sort();
clbExt.Items.Clear();
clbExt.Items.AddStrings(s);
for i:=0 to (s.Count-1) do begin
                           tmp:=('?' + s.Strings[i] + '?');
                           if Pos(tmp,excl)<>0 then clbExt.Items.Delete(clbExt.Items.IndexOf(s[i]));
                           end;
s.Free();
end;

// loads info from registry
procedure TfrmFormats.GetSupportInfo();
var
   i: integer;
begin
reg.RootKey:=HKEY_CLASSES_ROOT;
for i:=0 to (clbExt.Items.Count-1) do begin
                                      if GetExt(clbExt.Items.Strings[i])=true then clbExt.Checked[i]:=true else clbExt.Checked[i]:=false;
                                      end;
reg.CloseKey();
reg.RootKey:=HKEY_CURRENT_USER;
end;

// saves info to registry
procedure TfrmFormats.SaveSupportInfo();
var
   i: integer;
begin
reg.RootKey:=HKEY_CLASSES_ROOT;
for i:=0 to (clbExt.Items.Count-1) do begin
                                      if clbExt.Checked[i]=true then SetExt(clbExt.Items.Strings[i])
                                      else begin
                                           // removing association (if exist)
                                           if GetExt(clbExt.Items.Strings[i])=true then UnRegExt(clbExt.Items.Strings[i]);
                                           end;
                                      end;
reg.CloseKey();
reg.RootKey:=HKEY_CURRENT_USER;
end;

// change description
procedure TfrmFormats.ChangeDescription();
var
   tmp: string;
begin
tmp:=description;
InputQuery('Description change','You can change Imager''s supported formats description, that appears in Windows Explorer...',tmp);
if tmp<>'' then begin
                description:=tmp;
                WriteHandler();
                end;
end;

// is extension supported ?
function TfrmFormats.GetExt(ext: string):boolean;
begin
Result:=false;
if reg.OpenKey('\.'+ext,false) then begin
                                    if reg.ReadString('')='FuturisImager' then Result:=true;
                                    end;
end;

// add extension support
procedure TfrmFormats.SetExt(ext: string);
var
  tmp: string;
begin
reg.OpenKey('\.'+ext,true);
tmp:=RegReadStr('','');
if ((tmp<>'') and (tmp<>'FuturisImager')) then
  reg.WriteString('FuturisImagerC.bak',tmp);
reg.WriteString('','FuturisImager');
end;

// removing extension support
procedure TfrmFormats.UnRegExt(ext: string);
var
  tmp: string;
begin
reg.OpenKey('\.'+ext,true);
if reg.ValueExists('FuturisImagerC.bak') then
  begin
  tmp:=RegReadStr('FuturisImagerC.bak','');
  reg.WriteString('',tmp);
  reg.DeleteValue('FuturisImagerC.bak');
  end
else
  reg.WriteString('','');
end;

procedure TfrmFormats.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrmFormats.FormDestroy(Sender: TObject);
begin
frmFormats:=nil;
end;

procedure TfrmFormats.btnCancelClick(Sender: TObject);
begin
frmFormats.Close();
end;

procedure TfrmFormats.imgIcon1Click(Sender: TObject);
begin
rbnIcon1.Checked:=true;
icon_num:=1;
end;

procedure TfrmFormats.imgIcon2Click(Sender: TObject);
begin
rbnIcon2.Checked:=true;
icon_num:=2;
end;

procedure TfrmFormats.imgIcon3Click(Sender: TObject);
begin
rbnIcon3.Checked:=true;
icon_num:=3;
end;

procedure TfrmFormats.imgIcon4Click(Sender: TObject);
begin
rbnIcon4.Checked:=true;
icon_num:=4;
end;

procedure TfrmFormats.FormCreate(Sender: TObject);
begin
imgIcon1.Picture.Icon.Handle:=LoadIcon(HInstance,MAKEINTRESOURCE(1));
imgIcon2.Picture.Icon.Handle:=LoadIcon(HInstance,MAKEINTRESOURCE(2));
imgIcon3.Picture.Icon.Handle:=LoadIcon(HInstance,MAKEINTRESOURCE(3));
imgIcon4.Picture.Icon.Handle:=LoadIcon(HInstance,MAKEINTRESOURCE(4));
reg.OpenKey(sReg + '\Formats',true);
icon_num:=RegReadInt('Icon',1);
case icon_num of
  1: rbnIcon1.Checked:=true;
  2: rbnIcon2.Checked:=true;
  3: rbnIcon3.Checked:=true;
  4: rbnIcon4.Checked:=true;
  end;
cbxPrintEnabled.Checked:=RegReadBool('ContextPrint',false);
cbxFS.Checked:=RegReadBool('FullScreen',false);
cbxSS.Checked:=RegReadBool('SlideShow',false);
cbxSSFS.Checked:=RegReadBool('FSinSlideShow',false);
cbxBrowser.Checked:=RegReadBool('Thumbnails',false);
description:=RegReadStr('Description','Futuris Imager Document');
if description='Image file' then description:='Futuris Imager Document'; // fix for ugly name
reg.CloseKey();
GetExtensions();
GetSupportInfo();
end;

procedure TfrmFormats.btnOKClick(Sender: TObject);
begin
reg.OpenKey(sReg + '\Formats',true);
reg.WriteInteger('Icon',icon_num);
reg.WriteBool('ContextPrint',cbxPrintEnabled.Checked);
reg.WriteBool('FullScreen',cbxFS.Checked);
reg.WriteBool('SlideShow',cbxSS.Checked);
reg.WriteBool('FSinSlideShow',cbxSSFS.Checked);
reg.WriteBool('Thumbnails',cbxBrowser.Checked);
reg.WriteString('Description',description);
reg.CloseKey();
SaveSupportInfo();
WriteHandler();
UpdateAssociations();
frmFormats.Close();
end;

procedure TfrmFormats.btnChangeDescriptionClick(Sender: TObject);
begin
ChangeDescription();
end;

procedure TfrmFormats.btnRefreshClick(Sender: TObject);
begin
GetExtensions();
GetSupportInfo();
end;

procedure TfrmFormats.btnSelectAllClick(Sender: TObject);
var
   i: integer;
begin
for i:=0 to (clbExt.Items.Count-1) do clbExt.Checked[i]:=true;
end;

procedure TfrmFormats.btnSelectNoneClick(Sender: TObject);
var
   i: integer;
begin
for i:=0 to (clbExt.Items.Count-1) do clbExt.Checked[i]:=false;
end;

procedure TfrmFormats.btnIconViewerClick(Sender: TObject);
begin
reg.RootKey:=HKEY_CLASSES_ROOT;
if reg.OpenKey('\.ico',false)=true then begin
                                        reg.WriteString('','icofile');
                                        reg.CloseKey();
                                        UpdateAssociations();
                                        end;
reg.RootKey:=HKEY_CURRENT_USER;
end;

procedure TfrmFormats.rbnIcon1Click(Sender: TObject);
begin
icon_num:=1;
end;

procedure TfrmFormats.rbnIcon2Click(Sender: TObject);
begin
icon_num:=2;
end;

procedure TfrmFormats.rbnIcon3Click(Sender: TObject);
begin
icon_num:=3;
end;

procedure TfrmFormats.rbnIcon4Click(Sender: TObject);
begin
icon_num:=4;
end;

// removes info from registry
procedure TfrmFormats.Uninstall();
var
   i: integer;
begin
reg.RootKey:=HKEY_CLASSES_ROOT;
for i:=0 to (clbExt.Items.Count-1) do UnRegExt(clbExt.Items.Strings[i]);
reg.CloseKey();
reg.RootKey:=HKEY_CURRENT_USER;
end;

end.
