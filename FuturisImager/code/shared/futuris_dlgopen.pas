unit futuris_dlgopen;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
    Dialogs, ExtCtrls, CommDlg, StdCtrls, AgOpenDialog;

type
    TFuturisOpenDialog = class;
    TPreviewNotify = procedure(Sender:TFuturisOpenDialog; Ext : string) of object;
    TFuturisOpenDialog = class(TAgOpenDialog)
      private
        FPreviewImage : TImage;
        FSize, FName, FType, FSupport: TLabel;
        FBorder: TShape;
        FOnPreview : TPreviewNotify;
        procedure FPreview;
      protected
        procedure DoSelectionChange; override;
        procedure DoShow; override;
        function TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool; override;
      public
        FPanel: TPanel;
        constructor Create(AOwner: TComponent); override;
        destructor Destroy; override;
        function Execute: Boolean; override;
        property Size: TLabel read FSize write FSize;
        property Name: TLabel read FName write FName;
        property FileType: TLabel read FType write FType;
        property Support: TLabel read FSupport write FSupport;
        property PreviewImage : TImage read FPreviewImage write FPreviewImage;
      published
        property OnPreview : TPreviewNotify read FOnPreview write FOnPreview;
      end;
      TFuturisSaveDialog = class(TFuturisOpenDialog)
        function Execute: Boolean; override;
      end;

procedure Register;

implementation

{$R *.RES}

var
   Ext : string;

constructor TFuturisOpenDialog.Create(AOwner: TComponent);
begin
inherited Create(AOwner);
Filter:='All files (*.*)|*.*';
FPanel:=TPanel.Create(Self);
with FPanel do begin
               BevelOuter:=bvNone;
               BevelInner:=bvNone;
               BorderStyle:=bsNone;
               BorderWidth:=0;
               end;
// labels
FSize:=TLabel.Create(Self);
with FSize do begin
              Parent:=FPanel;
              Left:=180;
              Top:=6;
              Visible:=true;
              end;
FName:=TLabel.Create(Self);
with FName do begin
              Parent:=FPanel;
              Left:=180;
              Top:=26;
              Visible:=true;
              end;
FType:=TLabel.Create(Self);
with FType do begin
              Parent:=FPanel;
              Left:=180;
              Top:=46;
              Visible:=true;
              end;
FSupport:=TLabel.Create(Self);
with FSupport do begin
                 Parent:=FPanel;
                 Left:=180;
                 Top:=66;
                 Visible:=true;
                 end;
// image border
FBorder:=TShape.Create(Self);
with FBorder do begin
                Parent:=FPanel;
                Left:=0;
                Top:=0;
                Width:=162;
                Height:=162;
                Brush.Color:=clWhite;
                end;
// preview image
FPreviewImage:=TImage.Create(Self);
with FPreviewImage do begin
                      Parent:=FPanel;
                      AutoSize:=False;
                      Width:=150;
                      Height:=150;
                      Top:=6;
                      Left:=6;
                      Canvas.Brush.Color:=clWhite;
                      Canvas.FillRect(BoundsRect);
                      Visible:=True;
                      end;
end;

destructor TFuturisOpenDialog.Destroy;
begin
FSize.Free;
FName.Free;
FType.Free;
FSupport.Free;
FBorder.Free;
FPreviewImage.Free;
FPanel.Free;
inherited Destroy;
end;

function TFuturisOpenDialog.TaskModalDialog(DialogFunc: Pointer; var DialogData): Bool;
begin
TOpenFileName(DialogData).hInstance:=FindClassHInstance(TFuturisOpenDialog);
Result:=inherited TaskModalDialog(DialogFunc, DialogData);
end;

procedure TFuturisOpenDialog.DoSelectionChange;
begin
FPreview;
inherited DoSelectionChange;
end;

procedure TFuturisOpenDialog.DoShow;
var
   tmps: TRect;
begin
tmps:=GetStaticRect;
FPanel.ParentWindow:=Handle;
FPanel.BoundsRect:=Rect(tmps.Left+6,tmps.Bottom,tmps.Right,tmps.Bottom+172);
FPreview;
inherited DoShow;
end;

procedure TFuturisOpenDialog.FPreview;
begin
Ext:=LowerCase(copy(ExtractFileExt(FileName), 2, 9999));
if FileExists(FileName) then FOnPreview(Self, Ext);
end;

function TFuturisOpenDialog.Execute: Boolean;
begin
if ofOldStyleDialog in Options then Options := Options -[ofOldStyleDialog];
Template:='FUTURISPREVIEW';
Result:=inherited Execute;
end;

function TFuturisSaveDialog.Execute: Boolean;
begin
if ofOldStyleDialog in Options then Options := Options -[ofOldStyleDialog];
Template:='FUTURISPREVIEW';
Result:=DoExecute(@GetSaveFileName);
end;

procedure Register;
begin
RegisterComponents('Custom', [TFuturisOpenDialog, TFuturisSaveDialog]);
end;

end.


