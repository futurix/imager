unit f_graphics;

interface

uses
  Windows, Messages, SysUtils, Classes, Dialogs, Graphics, Forms,
  ImageEnIO, c_const, c_utils, c_reg, c_locales, c_graphics, c_ie;

type
  TFxOpenResult = record
    bitmap: HBITMAP;
    page, pages: ULONG;
  end;

function DoImageLoad(path: string; page: integer = 0): TFxOpenResult;
function DoPreviewLoad(path: string): HBITMAP;

procedure OpenLocal(path: string; add_to_mru: boolean = true; page: integer = 0; silent: boolean = false);
procedure OpenUntitled(bmp: TBitmap; img: hBitmap = 0);
procedure CloseImage(turn_off_ui: boolean = true);
function Write(path: string): BOOL;

function IsSupported(path: string): boolean;
function GetTypeString(ext: string): string;

function IsSupportedRole(role: string): boolean;
procedure ExecuteRole(role: string);

procedure MGoToPage(index: integer);
procedure MGoFirst();
procedure MGoPrev();
procedure MGoNext();
procedure MGoLast();


implementation

uses w_main, f_plugins, f_ui, f_tools, f_nav, f_images, fx_consts;

function DoImageLoad(path: string; page: integer = 0): TFxOpenResult;
var
  FxImgOpen: TFxImgOpen;
  ext: string;
  tmp_res: TFxImgResult;
begin
  Result.bitmap := 0;
  Result.page := 0;
  Result.pages := 0;

  if not FileExists(path) then
    begin
    FileNotFound(path);
    Abort();
    end;

  ext := ExtractExt(path);

  // main
  FxImgOpen := fx.Plugins.ResolveOpen(ext);

  if (@FxImgOpen <> nil) then
    begin
    tmp_res := FxImgOpen(PWideChar(path), PWideChar(ext), page, Application.Handle, frmMain.Handle, FxImgGlobalCallback);

    if (tmp_res.result_type = RT_HBITMAP) then
      begin
      Result.bitmap := tmp_res.result_value;
      Result.page := page;
      Result.pages := tmp_res.result_xtra;
      end;
    end;
end;

// TODO: switch to the future thumbnail interface
function DoPreviewLoad(path: string): HBITMAP;
var
  FxImgOpen: TFxImgOpen;
  io: TImageEnIO;
  cnv: TBitmap;
  ext: string;
  tmp_res: TFxImgResult;
begin
  Result := 0;

  if not FileExists(path) then
    begin
    FileNotFound(path);
    Abort();
    end;

  ext := ExtractExt(path);

  // main stuff
  FxImgOpen := fx.Plugins.ResolveOpen(ext);

  if (@FxImgOpen <> nil) then
    begin
    tmp_res := FxImgOpen(PWideChar(path), PWideChar(ext), 0, Application.Handle, frmMain.Handle, FxImgGlobalCallback);

    if (tmp_res.result_type = RT_HBITMAP) then
      Result := tmp_res.result_value;
    end;

  if (Result = 0) then
    begin
    // guessing the format
    io := TImageEnIO.Create(nil);
    io.Params.JPEG_DCTMethod := ioJPEG_IFAST;
    io.Params.BMP_HandleTransparency := true;

    try
      io.LoadFromFile(path);

      if io.Aborting then
        io.LoadFromFileAuto(path);

    except
      io.Aborting := true;
    end;

    if not io.Aborting and not io.IEBitmap.IsEmpty then
      begin
      io.IEBitmap.PrepareAlphaForExternalUse();

      cnv := TBitmap.Create();
      io.IEBitmap.CopyToTBitmap(cnv);

      cnv.ApplyLimits();
      Result := cnv.ReleaseHandle();

      FreeAndNil(cnv);
      end;

    FreeAndNil(io);
    end;
end;

// loads file from given path
procedure OpenLocal(path: string; add_to_mru: boolean = true; page: integer = 0; silent: boolean = false);
var
  res: TFxOpenResult;
  ext: string;
begin
  if FileExists(path) then
    begin
    CloseImage(false);

    ext := ExtractExt(path);
    res := DoImageLoad(path, page);

    if (res.bitmap <> 0) then
      begin
      // loading
      FillImage(path, res.pages, res.page);
      FillBitmap(nil, res.bitmap);

      if add_to_mru then
        frmMain.mru.AddItem(path, true);

      ScanFolder(path);

      FinalizeImage();
      Able();
      end
    else
      begin
      // internal formats
      frmMain.img.IO.Params.JPEG_DCTMethod := ioJPEG_IFAST;
      frmMain.img.IO.Params.BMP_HandleTransparency := true;

      try
        frmMain.img.IO.LoadFromFile(path);

        if frmMain.img.IO.Aborting then
          frmMain.img.IO.LoadFromFileAuto(path);

      except
        frmMain.img.IO.Aborting := true;
      end;

      if not frmMain.img.IO.Aborting then
        begin
        FillImage(path, 0, 0);

        if add_to_mru then
          frmMain.mru.AddItem(path, true);

        ScanFolder(path);

        FinalizeImage();
        Header();
        Able();
        end;
      end;
    end
  else
    begin
    CloseImage();

    if not silent then
      ShowMessage(LoadLStr(620));
    end;
end;

procedure OpenUntitled(bmp: TBitmap; img: HBITMAP = 0);
begin
  CloseImage(false);

  if (img <> 0) then
    begin
    // loading from hBitmap
    FillBitmap(nil, img);
    FillImage('');
    FinalizeImage();

    Able();
    end
  else
    begin
    // loading from TBitmap
    if (bmp <> nil) then
      begin
      FillBitmap(bmp);
      FillImage('');
      FinalizeImage();

      Able();
      end;
    end;
end;

// closes file
procedure CloseImage(turn_off_ui: boolean = true);
begin
  frmMain.img.Proc.ClearAllUndo();

  // specific things
  FillImage('');

  // nullifying
  frmMain.img.Blank();

  if turn_off_ui then
    Able();
end;

// saves file
function Write(path: string): BOOL;
var
  FxImgSave: TFxImgSave;
  ext: string;
  res: integer;
  bim: TBitmap;
  tmp_res: TFxImgResult;
begin
  // start
  ext := ExtractExt(path);
  Result := FALSE;

  // main stuff
  FxImgSave := fx.Plugins.ResolveSave(ext);

  if (@FxImgSave <> nil) then
    begin
    bim := TBitmap.Create();
    frmMain.img.IEBitmap.PrepareAlphaForExternalUse();
    frmMain.img.IEBitmap.CopyToTBitmap(bim);
    bim.ApplyLimits();

    tmp_res := FxImgSave(PWideChar(path), PWideChar(ext), bim.ReleaseHandle(), Application.Handle, frmMain.Handle, FxImgGlobalCallback);

    if (tmp_res.result_type = RT_BOOL) then
      res := tmp_res.result_value
    else
      res := 0;

    FreeAndNil(bim);

    if (res <> 0) then
      frmMain.img.Proc.ClearAllUndo();

    Result := (res = FX_TRUE);
    end;
end;

// finds out if format is supported
function IsSupported(path: string): boolean;
begin
  Result := fx.Plugins.HasOpen(ExtractExt(path));
end;

// returns file type string or ''
function GetTypeString(ext: string): string;
begin
  Result := fx.Plugins.FindFormatDescription(ext);
end;

function IsSupportedRole(role: string): boolean;
begin
  Result := fx.Plugins.HasRole(role);
end;

//TODO: all other roles
procedure ExecuteRole(role: string);
var
  id: integer;
begin
  id := fx.Plugins.FindRoleHandler(role);

  if (id <> PI_NULL) then
    begin
    if ((role = PR_SCAN) or (role = PR_CAPTURE)) then
      // importer roles
      frmMain.DoHandleFImport(
        fx.Plugins.GetFunctionFromPlugin(id, CP_FIMPORT),
        role)
    else if ((role = PR_JPEGLL) or (role = PR_EMAIL)) then
      // tool roles
      frmMain.DoHandleFTool(
        fx.Plugins.GetFunctionFromPlugin(id, CP_FTOOL),
        role);
    end;
end;

// opens specific page
procedure MGoToPage(index: integer);
begin
  OpenLocal(infImage.path, true, index);
end;

procedure MGoFirst();
begin
  MGoToPage(0);
end;

procedure MGoPrev();
begin
  if infImage.page > 0 then
    MGoToPage(infImage.page - 1)
  else
    MGoToPage(infImage.pages - 1);
end;

procedure MGoNext();
begin
  if infImage.page < (infImage.pages - 1) then
    MGoToPage(infImage.page + 1)
  else
    MGoToPage(0);
end;

procedure MGoLast();
begin
  MGoToPage(infImage.pages - 1);
end;

end.
