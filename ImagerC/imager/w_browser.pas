unit w_browser;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ExtCtrls, FileCtrl;

type
  TfrmFile = class(TForm)
    pnlDrives: TPanel;
    splFile: TSplitter;
    popFiles: TPopupMenu;
    piCustomMask: TMenuItem;
    lbxDir: TDirectoryListBox;
    lbxFiles: TFileListBox;
    cbxDrives: TDriveComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbxFilesDblClick(Sender: TObject);
    procedure piCustomMaskClick(Sender: TObject);
    procedure lbxFilesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFile: TfrmFile;

implementation

uses main, globals, f_web, f_ui, f_reg, f_windows, f_graphics, f_filectrl;

{$R *.DFM}

procedure TfrmFile.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
SaveFormPosition(frmFile,sReg + '\Position\Browser');
reg.OpenKey(sReg + '\Browser',true);
reg.WriteString('LastDir',lbxFiles.Directory);
reg.WriteString('Mask',lbxFiles.Mask);
reg.WriteInteger('Splitter',lbxDir.Height);
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
LoadFormPosition(frmFile,sReg + '\Position\Browser',177,373,71,5,0);
// last folder
reg.OpenKey(sReg + '\Browser',true);
last_path:=RegReadStr('LastDir','C:');
if (infImage.file_type=ftLocal) then lbxFiles.Directory:=ExtractFileDir(infImage.path)
else begin
     if ((last_path<>'') and (DirExists(last_path))) then lbxFiles.Directory:=last_path
     else lbxFiles.Directory:='C:\';
     end;
// splitter
lbxDir.Height:=RegReadInt('Splitter',97);
// UI
frmMain.tbnFileBrowser.Down:=true;
frmMain.miFileManager.Checked:=true;
// mask
lbxFiles.Mask:=RegReadStr('Mask','*.*');
reg.CloseKey();
end;

procedure TfrmFile.lbxFilesDblClick(Sender: TObject);
begin
Load(lbxFiles.FileName);
end;

procedure TfrmFile.piCustomMaskClick(Sender: TObject);
var
   mask: string;
begin
mask:=lbxFiles.Mask;
if InputQuery('Mask','Type new or modify current mask.',mask)=true then begin
                                                                        if mask<>'' then lbxFiles.Mask:=mask;
                                                                        end;
end;

procedure TfrmFile.lbxFilesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=VK_RETURN then Load(lbxFiles.FileName);
end;

end.
