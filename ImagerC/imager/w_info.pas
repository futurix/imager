unit w_info;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfrmInfo = class(TForm)
    btnOK: TButton;
    edtPath: TEdit;
    edtDims: TEdit;
    edtModDims: TEdit;
    lblPath: TLabel;
    lblDimensions: TLabel;
    lblModDimensions: TLabel;
    btnAdditional: TButton;
    bvlSep: TBevel;
    lblSize: TLabel;
    edtSize: TEdit;
    edtStamp: TEdit;
    lblStamp: TLabel;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAdditionalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInfo: TfrmInfo;

implementation

uses main, globals, f_web, f_info, f_filectrl, f_strutils;

{$R *.DFM}

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

begin
case infImage.file_type of
                        ftNone: begin
                                edtPath.Enabled:=false;
                                edtDims.Enabled:=false;
                                edtModDims.Enabled:=false;
                                edtSize.Enabled:=false;
                                edtStamp.Enabled:=false;
                                end;
                        ftLocal: begin
                                 case infImage.image_type of
                                                          itNone: begin
                                                                  edtPath.Enabled:=false;
                                                                  edtDims.Enabled:=false;
                                                                  edtModDims.Enabled:=false;
                                                                  edtSize.Enabled:=false;
                                                                  end;
                                                          itNormal: begin
                                                                    edtPath.Text:=infImage.path;
                                                                    edtDims.Text:=IntToStr(infImage.original.Width)+' x '+IntToStr(infImage.original.Height);
                                                                    edtModDims.Text:=IntToStr(frmMain.imgMain.Width)+' x '+IntToStr(frmMain.imgMain.Height);
                                                                    edtSize.Text:=Format('%f kb',[(FileSize(infImage.path)/1024)]);
                                                                    edtStamp.Text:=DateTimeToStr(FileDateToDateTime(FileAge(infImage.path)));
                                                                    end;
                                                          itAnimated: begin
                                                                      edtPath.Text:=infImage.path;
                                                                      edtDims.Enabled:=false;
                                                                      edtModDims.Enabled:=false;
                                                                      edtSize.Text:=Format('%f kb',[(FileSize(infImage.path)/1024)]);
                                                                      edtStamp.Text:=DateTimeToStr(FileDateToDateTime(FileAge(infImage.path)));
                                                                      end;
                                                          itMulti: begin
                                                                   edtPath.Text:=infImage.path;
                                                                   edtDims.Enabled:=false;
                                                                   edtModDims.Enabled:=false;
                                                                   edtSize.Text:=Format('%f kb',[(FileSize(infImage.path)/1024)]);
                                                                   edtStamp.Text:=DateTimeToStr(FileDateToDateTime(FileAge(infImage.path)));
                                                                   end;
                                                          end;
                                 if IsInformed(GetExt(infImage.path)) then btnAdditional.Visible:=true;
                                 end;
                        ftWeb: begin
                               edtPath.Text:=infImage.url;
                               edtDims.Text:=IntToStr(infImage.original.Width)+' x '+IntToStr(infImage.original.Height);
                               edtModDims.Text:=IntToStr(frmMain.imgMain.Width)+' x '+IntToStr(frmMain.imgMain.Height);
                               edtSize.Enabled:=false;
                               edtStamp.Enabled:=false;
                               if IsInformed(GetExt(infImage.path)) then btnAdditional.Visible:=true;
                               end;
                        ftUnsaved: begin
                                   edtPath.Text:='unsaved image';
                                   edtDims.Text:=IntToStr(infImage.original.Width)+' x '+IntToStr(infImage.original.Height);
                                   edtModDims.Text:=IntToStr(frmMain.imgMain.Width)+' x '+IntToStr(frmMain.imgMain.Height);
                                   edtSize.Enabled:=false;
                                   edtStamp.Enabled:=false;
                                   end;
                        else Close();
                        end;
end;

procedure TfrmInfo.btnAdditionalClick(Sender: TObject);
begin
if infImage.file_type=ftWeb then ShowAdditionalInformation(infImage.url,infImage.path,GetExt(infImage.path))
else ShowAdditionalInformation(infImage.path,infImage.path,GetExt(infImage.path));
end;

end.
