unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  futuris_hint, Registry, ShellAPI, VirtualExplorerTree, VirtualTrees,
  ExtCtrls;

type
  TFIPISopen = function(path, ext: PChar; app: THandle):hBitmap; stdcall;

type
  TfrmMain = class(TForm)
    pnlLeft: TPanel;
    splMain: TSplitter;
    pnlPreview: TPanel;
    splPreview: TSplitter;
    imgPreview: TImage;
    pnlSpacer: TPanel;
    elwMain: TExplorerListview;
    etvMain: TExplorerTreeview;
    function IsSupported(ext: string):boolean;
    procedure DoPreview(img: hBitmap);
    procedure ClearPreview();
    procedure Preview(path: string);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure splPreviewMoved(Sender: TObject);
    procedure splMainMoved(Sender: TObject);
    procedure elwMainClick(Sender: TObject);
    procedure elwMainDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
     sReg = '\Software\Futuris\ImagerC';
     sFIPIS = '\Software\Futuris\FIPIS';
     sName = 'Futuris Imager';

var
  frmMain: TfrmMain;
  reg: TRegistry;

function DirExists(const Name: string): Boolean;

implementation

{$R *.DFM}

function DirExists(const Name: string): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Name));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;

function TfrmMain.IsSupported(ext: string):boolean;
begin
reg.OpenKey(sFIPIS + '\Open',true);
if reg.ReadString(LowerCase(ext))<>'' then Result:=true else Result:=false;
reg.CloseKey();
end;

procedure TfrmMain.DoPreview(img: hBitmap);
var
   res_width, res_height, tmp_width, tmp_height,
   left, top, right, bottom: integer;
   scale: double;
   bmp: TBitmap;
begin
pnlPreview.Caption:='';
imgPreview.Picture.Bitmap.Canvas.Brush.Color:=clBtnFace;
imgPreview.Picture.Bitmap.Canvas.FillRect(imgPreview.Picture.Bitmap.Canvas.ClipRect);
imgPreview.Visible:=true;
// creating bitmap and filling it
bmp:=TBitmap.Create();
bmp.Handle:=img;
// starting count best fit
scale:=bmp.Width/bmp.Height;
tmp_width:=(imgPreview.ClientRect.Right-imgPreview.ClientRect.Left-2);
tmp_height:=(imgPreview.ClientRect.Bottom-imgPreview.ClientRect.Top-2);
if ((tmp_width/scale)<=tmp_height) then begin
                                        // width
                                        res_width:=tmp_width;
                                        res_height:=Round(tmp_width/scale);
                                        left:=0;
                                        right:=res_width;
                                        top:=Round((imgPreview.ClientRect.Bottom-res_height)/2);
                                        bottom:=top+res_height;
                                        end
else begin
     // height
     res_height:=tmp_height;
     res_width:=Round(tmp_height*scale);
     left:=Round((imgPreview.ClientRect.Right-res_width)/2);
     right:=left+res_width;
     top:=0;
     bottom:=res_height;
     end;
// displaying
imgPreview.Picture.Bitmap.Width:=imgPreview.Width;
imgPreview.Picture.Bitmap.Height:=imgPreview.Height;
imgPreview.Picture.Bitmap.Canvas.StretchDraw(Rect(1+left,1+top,right-1,bottom-1),bmp);
imgPreview.Picture.Bitmap.Canvas.Brush.Color:=clBlack;
imgPreview.Picture.Bitmap.Canvas.FrameRect(Rect(left,top,right,bottom));
//clearing bitmap
bmp.Free();
end;

procedure TfrmMain.ClearPreview();
begin
imgPreview.Picture.Bitmap.Canvas.FillRect(imgPreview.Picture.Bitmap.Canvas.ClipRect);
imgPreview.Visible:=false;
pnlPreview.Caption:='No preview available.';
end;

procedure TfrmMain.Preview(path: string);
var
   FIPISopen: TFIPISopen;
   img: hBitmap;
   lib: THandle;
   ext, lib_path: string;
begin
ext:=ExtractFileExt(path);
Delete(ext,1,1);
ext:=LowerCase(ext);
reg.OpenKey(sFIPIS + '\Open',true);
lib_path:=IncludeTrailingBackSlash(ExtractFileDir(Application.ExeName)) + 'plugins\' + reg.ReadString(ext);
reg.CloseKey();
// main stuff
if lib_path<>'' then begin
                     lib:=LoadLibrary(PChar(lib_path));
                     if lib<>0 then begin
                                    @FIPISopen:=GetProcAddress(lib,'FIPISopen');
                                    if not (@FIPISopen=nil) then begin
                                                                 img:=FIPISopen(PChar(path),PChar(ext),Application.Handle);
                                                                 if img<>0 then begin
                                                                                //Success!!!
                                                                                DoPreview(img);
                                                                                end
                                                                 else ClearPreview();
                                                                 end;
                                    FreeLibrary(lib);
                                    end;
                     end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
   tmp: string;
begin
// creating inis
reg:=TRegistry.Create();
reg.RootKey:=HKEY_CURRENT_USER;
reg.OpenKey(sReg + '\Thumbs',true);
try frmMain.Top:=reg.ReadInteger('Top') except frmMain.Top:=65 end;
try frmMain.Left:=reg.ReadInteger('Left') except frmMain.Left:=60 end;
try frmMain.Width:=reg.ReadInteger('Width') except frmMain.Width:=500 end;
try frmMain.Height:=reg.ReadInteger('Height') except frmMain.Height:=350 end;
try
   if reg.ReadInteger('State')=0 then frmMain.WindowState:=wsNormal
   else frmMain.WindowState:=wsMaximized
   except frmMain.WindowState:=wsMaximized end;
// loading splitters position
try pnlLeft.Width:=reg.ReadInteger('Vertical')
    except pnlLeft.Width:=185 end;
try pnlPreview.Height:=reg.ReadInteger('Horizontal')
    except pnlPreview.Height:=185 end;
tmp:=reg.ReadString('Path');
if tmp='' then tmp:='C:\';
// loading browsing position
if ((ParamCount>0) and (DirExists(ParamStr(1)))) then elwMain.BrowseTo(ParamStr(1),true,true,true,true)
  else elwMain.BrowseTo(tmp,true,true,true,true);
reg.CloseKey();
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
reg.OpenKey(sReg + '\Thumbs',true);
// saving position
if frmMain.WindowState=wsMaximized then reg.WriteInteger('State',1)
else reg.WriteInteger('State',0);
reg.WriteInteger('Top',frmMain.Top);
reg.WriteInteger('Left',frmMain.Left);
reg.WriteInteger('Width',frmMain.Width);
reg.WriteInteger('Height',frmMain.Height);
// saving splitters position
reg.WriteInteger('Vertical',pnlLeft.Width);
reg.WriteInteger('Horizontal',pnlPreview.Height);
// saving browsing position
reg.WriteString('Path',ExtractFilePath(elwMain.SelectedPath));
reg.CloseKey();
// freeing
reg.Free();
end;

procedure TfrmMain.splPreviewMoved(Sender: TObject);
var
   tmp: string;
begin
if elwMain.SelectedPath<>'' then
  begin
  tmp:=ExtractFileExt(elwMain.SelectedPath);
  if tmp<>'' then
    begin
    Delete(tmp,1,1);
    if IsSupported(tmp) then Preview(elwMain.SelectedPath)
    else ClearPreview();
    end;
  end
else ClearPreview(); 
end;

procedure TfrmMain.splMainMoved(Sender: TObject);
var
   tmp: string;
begin
if elwMain.SelectedPath<>'' then
  begin
  tmp:=ExtractFileExt(elwMain.SelectedPath);
  if tmp<>'' then
    begin
    Delete(tmp,1,1);
    if IsSupported(tmp) then Preview(elwMain.SelectedPath)
    else ClearPreview();
    end;
  end
else ClearPreview(); 
end;

procedure TfrmMain.elwMainClick(Sender: TObject);
var
  tmp: string;
begin
if elwMain.SelectedPath<>'' then
  begin
  tmp:=ExtractFileExt(elwMain.SelectedPath);
  if tmp<>'' then
    begin
    Delete(tmp,1,1);
    if IsSupported(tmp) then Preview(elwMain.SelectedPath)
    else ClearPreview();
    end;
  end
else ClearPreview();
end;

procedure TfrmMain.elwMainDblClick(Sender: TObject);
var
   tmp, path: string;
begin
if elwMain.SelectedPath<>'' then
  begin
  tmp:=ExtractFileExt(elwMain.SelectedPath);
  if tmp<>'' then
    begin
    Delete(tmp,1,1);
    if IsSupported(tmp) then
      begin
      Preview(elwMain.SelectedPath);
      path:=IncludeTrailingBackSlash(ExtractFileDir(Application.ExeName));
      path:=path + 'imager.exe';
      ShellExecute(0,'open',PChar(path),PChar(String(elwMain.SelectedPath)),nil,SW_SHOWNORMAL);
      end
    else ClearPreview();
    end;
  end
else ClearPreview();
end;

end.
