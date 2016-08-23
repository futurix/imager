unit w_confplugs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileFind;

type
  TfrmConfPlugs = class(TForm)
    btnOK: TButton;
    lbxPlugs: TListBox;
    lblFollowing: TLabel;
    fsrConf: TFileSearch;
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fsrConfFileFind(fullpath: String; info: TSearchRec);
    procedure lbxPlugsDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfPlugs: TfrmConfPlugs;

implementation

uses fipis, f_strutils;

{$R *.DFM}

procedure TfrmConfPlugs.btnOKClick(Sender: TObject);
begin
Close();
end;

procedure TfrmConfPlugs.FormCreate(Sender: TObject);
begin
fsrConf.SearchFile:=(GetAppFolder() + 'plugins\*.dll');
fsrConf.Start();
end;

procedure TfrmConfPlugs.fsrConfFileFind(fullpath: String;
  info: TSearchRec);
var
   lib: THandle;
   FIPISconfig: TFIPISconfig;
begin
lib:=LoadLibrary(PChar(fullpath + info.Name));
if lib<>0 then begin
               @FIPISconfig:=GetProcAddress(lib,'FIPISconfig');
               if @FIPISconfig<>nil then lbxPlugs.Items.Add(info.Name);
               FreeLibrary(lib);
               end;
end;

procedure TfrmConfPlugs.lbxPlugsDblClick(Sender: TObject);
var
   lib: THandle;
   FIPISconfig: TFIPISconfig;
begin
lib:=LoadLibrary(PChar(GetAppFolder() + 'plugins\' + lbxPlugs.Items[lbxPlugs.ItemIndex]));
if lib<>0 then begin
               @FIPISconfig:=GetProcAddress(lib,'FIPISconfig');
               if @FIPISconfig<>nil then FIPISconfig(frmConfPlugs.Handle);
               FreeLibrary(lib);
               end;
end;

procedure TfrmConfPlugs.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrmConfPlugs.FormDestroy(Sender: TObject);
begin
frmConfPlugs:=nil;
end;

end.
