unit w_browser;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ExtCtrls, FileCtrl,
  c_const, ComCtrls, ShellCtrls;

type
  TfrmFile = class(TForm)
    shlTree: TShellTreeView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure shlTreeDblClick(Sender: TObject);
    procedure shlTreeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFile: TfrmFile;

implementation

uses main, globals, f_ui, f_reg, f_graphics, f_filectrl;

{$R *.DFM}

procedure TfrmFile.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
reg.OpenKey(sReg + '\Browser',true);
reg.WriteString('LastDir',shlTree.Path);
reg.CloseKey();
end;

procedure TfrmFile.FormDestroy(Sender: TObject);
begin
// UI
frmMain.tbnFileBrowser.Down:=false;
frmMain.miFileManager.Checked:=false;

// other
frmFile:=nil;
end;

procedure TfrmFile.FormCreate(Sender: TObject);
var
  last_path: string;
begin
// last folder
reg.OpenKey(sReg + '\Browser',true);
last_path:=reg.RStr('LastDir','C:\');
if (infImage.file_type=ftLocal) then
  shlTree.Path:=ExtractFileDir(infImage.path)
else
  begin
  if ((last_path<>'') and (DirExists(last_path))) then shlTree.Path:=last_path
    else shlTree.Path:='C:\';
  end;

// UI
frmMain.tbnFileBrowser.Down:=true;
frmMain.miFileManager.Checked:=true;

reg.CloseKey();
end;

procedure TfrmFile.shlTreeDblClick(Sender: TObject);
begin
if FileExists(shlTree.Path) then
  begin
  case FileType(shlTree.Path) of
    1, 3, 4: Load(shlTree.Path);
  end;
  end;
end;

procedure TfrmFile.shlTreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=VK_RETURN then
  if FileExists(shlTree.Path) then
    begin
    case FileType(shlTree.Path) of
      1, 3, 4: Load(shlTree.Path);
    end;
    end;
end;

end.
