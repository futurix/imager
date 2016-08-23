unit w_instplugs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FileFind, VersInfo;

type
  TfrmInstPlugs = class(TForm)
    fsrPlugs: TFileSearch;
    lblSelect: TLabel;
    btnOK: TButton;
    lbxPlugs: TListBox;
    gbxAbout: TGroupBox;
    lblNameVer: TLabel;
    verInfo: TdfsVersionInfoResource;
    lblAuthor: TLabel;
    lblComments: TLabel;
    memComments: TMemo;
    lblDLLnVer: TLabel;
    lblTM: TLabel;
    lblCopy: TLabel;

    procedure GetInfo(lib: string);
    procedure CleanAll();
    function IsFIPIS(lib: string):boolean;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fsrPlugsFileFind(fullpath: String; info: TSearchRec);
    procedure lbxPlugsClick(Sender: TObject);
    procedure lbxPlugsKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInstPlugs: TfrmInstPlugs;

implementation

uses f_strutils, fipis, globals, f_debug;

{$R *.DFM}

procedure TfrmInstPlugs.GetInfo(lib: string);
begin
// settings
CleanAll();
verInfo.Filename:=lib;
// extracting
lblNameVer.Caption:=verInfo.FileDescription + ' ' + verInfo.FileVersion.AsString;
lblAuthor.Caption:='Author: ' + verInfo.CompanyName;
memComments.Lines.Add(verInfo.Comments);
lblDLLnVer.Caption:='File: ' + ExtractFileName(lib);
lblCopy.Caption:=verInfo.LegalCopyright;
lblTM.Caption:=verInfo.LegalTrademarks;
end;

procedure TfrmInstPlugs.CleanAll();
begin
lblNameVer.Caption:='';
lblAuthor.Caption:='';
memComments.Lines.Clear();
lblDLLnVer.Caption:='';
lblCopy.Caption:='';
lblTM.Caption:='';
end;

// checks if dll is FIPIS plug-in (if FIPIS resource exist)
function TfrmInstPlugs.IsFIPIS(lib: string):boolean;
var
   tst: THandle;
begin
tst:=LoadLibrary(PChar(lib));
if tst<>0 then begin
               // checking
               if FindResource(tst,'SPECS','FIPIS')<>0 then Result:=true
               else Result:=false;
               FreeLibrary(tst);
               end
else Result:=false;
end;

procedure TfrmInstPlugs.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrmInstPlugs.FormDestroy(Sender: TObject);
begin
frmInstPlugs:=nil;
end;

procedure TfrmInstPlugs.btnOKClick(Sender: TObject);
begin
Close();
end;

procedure TfrmInstPlugs.FormCreate(Sender: TObject);
begin
CleanAll();
fsrPlugs.SearchFile:=(GetAppFolder() + 'plugins\*.dll');
fsrPlugs.Start();
end;

procedure TfrmInstPlugs.fsrPlugsFileFind(fullpath: String;
  info: TSearchRec);
begin
if IsFIPIS(fullpath + info.Name) then lbxPlugs.Items.Add(ExtractRelativePath(GetAppFolder() + 'plugins\',fullpath + info.Name));
end;

procedure TfrmInstPlugs.lbxPlugsClick(Sender: TObject);
begin
if lbxPlugs.ItemIndex<>-1 then GetInfo(GetAppFolder() + 'plugins\' + lbxPlugs.Items[lbxPlugs.ItemIndex]);
end;

procedure TfrmInstPlugs.lbxPlugsKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if lbxPlugs.ItemIndex<>-1 then GetInfo(GetAppFolder() + 'plugins\' + lbxPlugs.Items[lbxPlugs.ItemIndex]);
end;

end.
