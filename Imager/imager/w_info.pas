unit w_info;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls,
  c_const;

type
  TfrmInfo = class(TForm)
    btnOK: TButton;
    lvwInfo: TListView;

    procedure AddCommonInfo();
    procedure AddToList(name, value: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInfo: TfrmInfo;

function IsInformed(ext: string):boolean;
function GetInfo(name, value: PChar):BOOL; stdcall;

implementation

uses main, globals, f_filectrl, f_strutils;

{$R *.DFM}

function IsInformed(ext: string):boolean;
begin
reg.OpenKey(sModules + '\Info',true);
if reg.RStr(ext,'')<>'' then
  Result:=true
else
  Result:=false;
reg.CloseKey();
end;

procedure TfrmInfo.AddCommonInfo();
begin
case infImage.file_type of
  ftLocal:
    begin
    case infImage.image_type of
      itNormal:
        begin
        AddToList('Path',infImage.path);
        AddToList('File Size',Format('%f kb',[(FileSize(infImage.path)/1024)]));
        AddToList('File Timestamp',DateTimeToStr(FileDateToDateTime(FileAge(infImage.path))));
        AddToList('','');
        AddToList('Dimensions',IntToStr(infImage.original.Width)+' x '+IntToStr(infImage.original.Height));
        AddToList('Modified Size',IntToStr(frmMain.imgMain.Width)+' x '+IntToStr(frmMain.imgMain.Height));
        end;
      itAnimated, itMulti:
        begin
        AddToList('Path',infImage.path);
        AddToList('File Size',Format('%f kb',[(FileSize(infImage.path)/1024)]));
        AddToList('File Timestamp',DateTimeToStr(FileDateToDateTime(FileAge(infImage.path))));
        end;
      end;
    end;
  ftUnsaved:
    begin
    AddToList('Dimensions',IntToStr(infImage.original.Width)+' x '+IntToStr(infImage.original.Height));
    AddToList('Modified Size',IntToStr(frmMain.imgMain.Width)+' x '+IntToStr(frmMain.imgMain.Height));
    end;
  end;
end;

function GetInfo(name, value: PChar):BOOL;
begin
if name='ADD_PREBUILT_INFORMATION' then
  frmInfo.AddCommonInfo()
else
  frmInfo.AddToList(String(name), String(value));
  
Result:=true;
end;

procedure TfrmInfo.AddToList(name, value: string);
var
  tmp: TListItem;
begin
tmp:=lvwInfo.Items.Add();
tmp.Caption:=name;
if value<>'' then
  tmp.SubItems.Add(value);
end;

procedure TfrmInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrmInfo.FormDestroy(Sender: TObject);
begin
frmInfo:=nil;
end;

procedure TfrmInfo.btnOKClick(Sender: TObject);
begin
Close();
end;

procedure TfrmInfo.FormCreate(Sender: TObject);
var
  FIPISinfo: TFIPISinfo;
  lib: THandle;
begin
if IsInformed(GetExt(infImage.path)) then
  begin
  reg.OpenKey(sModules + '\Info',true);
  lib:=LoadLibrary(PChar(GetAppFolder() + 'plugins\' + reg.RStr(GetExt(infImage.path),'')));
  reg.CloseKey();
  if lib<>0 then
    begin
    @FIPISinfo:=GetProcAddress(lib,'FIPISinfo');
    if not (@FIPISinfo=nil) then
      FIPISinfo(PChar(infImage.path), PChar(GetExt(infImage.path)), GetInfo, Application.Handle, frmMain.Handle);
    FreeLibrary(lib);
    end
  else AddCommonInfo();
  end
else
  AddCommonInfo();
end;

procedure TfrmInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=VK_ESCAPE then
  Self.Close();
end;

end.
