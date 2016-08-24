unit f_multi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Dialogs, Controls, Forms, IniFiles,
  c_reg, c_const, c_utils, c_locales;

function  IsMulti(ext: string):boolean;
procedure OpenMulti(path: string; add_to_mru: boolean = true);
procedure MGoToPage(index: integer);
function  MGetPage(index: integer): HBITMAP;
procedure MPage();
procedure MGoFirst();
procedure MGoPrev();
procedure MGoNext();
procedure MGoLast();
procedure MExtract();
procedure CloseMulti();


implementation

uses f_ui, f_tools, f_graphics, f_nav, main, f_images;

// is multipage
function IsMulti(ext: string):boolean;
begin
    Result := (FxRegRStr(ext, '', sModules + '\' + PS_FOPENMULTI) <> '');
end;

// opens multi-page image
procedure OpenMulti(path: string; add_to_mru: boolean = true);
var
  tmp_res: TFxImgResult;
begin
  if not FileExists(path) then
      begin
      FileNotFound(path);
      Abort();
      end;

  // loading dll and settings
    infMulti.lib := LoadLibrary(PChar(FxRegRStr(ExtractExt(path), '', sModules + '\' + PS_FOPENMULTI)));

  if (infMulti.lib <> 0) then
      begin
      @infMulti.FxImgMultiStart := GetProcAddress(infMulti.lib, EX_MULTISTART);
      @infMulti.FxImgMultiGetPage := GetProcAddress(infMulti.lib, EX_MULTIPAGE);
      @infMulti.FxImgMultiStop := GetProcAddress(infMulti.lib, EX_MULTISTOP);

      if ((@infMulti.FxImgMultiStart <> nil) and
          (@infMulti.FxImgMultiGetPage <> nil) and
          (@infMulti.FxImgMultiStop <> nil)) then
        begin
        // settings
            tmp_res := infMulti.FxImgMultiStart(PChar(path), PChar(ExtractExt(path)), Application.Handle, frmMain.Handle, FxImgGlobalCallback);

            if (tmp_res.result_type = RT_INT) then
              infMulti.pages := tmp_res.result_value
            else
              infMulti.pages := 0;

        if (infMulti.pages <= 1) then
            begin
            CloseMulti();
            OpenLocal(path, add_to_mru);
            Abort();
            end;

        infMulti.page := 0;
        FillImage(path, itMulti);

        // tuning UI
        if add_to_mru then
          frmMain.mru.AddItem(path, true);

        ScanFolder(path);

            frmMain.mMulti.Visible := true;
            frmMain.tbnMultiPrev.Enabled := true;
        frmMain.tbnMultiNext.Enabled := true;
            frmMain.tbnGoToPage.Enabled := true;
        frmMain.pMulti.Visible := true;

        Able();
        MGoToPage(0);
        end;
      end;
end;

// goes to page
procedure MGoToPage(index: integer);
var
  bmp: HBITMAP;
  bim: TBitmap;
    tmp_res: TFxImgResult;
begin
    tmp_res := infMulti.FxImgMultiGetPage(index, Application.Handle, frmMain.Handle, FxImgGlobalCallback);

    if (tmp_res.result_type = RT_HBITMAP) then
    bmp := tmp_res.result_value
    else
      bmp := 0;

    if (bmp <> 0) then
      begin
    bim := TBitmap.Create();
      bim.Handle := bmp;
      bim.PixelFormat := pf24bit;

        FillBitmap(bim);

      FreeAndNil(bim);
      infMulti.page := index;

        FinalizeImage();
      end;
end;

// retrieves page
function MGetPage(index: integer): HBITMAP;
var
    tmp_res: TFxImgResult;
begin
    tmp_res := infMulti.FxImgMultiGetPage(index, Application.Handle, frmMain.Handle, FxImgGlobalCallback);

    if (tmp_res.result_type = RT_HBITMAP) then
    Result := tmp_res.result_value
    else
      Result := 0;
end;

// opens page
procedure MPage();
var
  tmp: string;
  num: integer;
begin
  num := 0;
  tmp := IntToStr(infMulti.pages);

    if InputQuery(LoadLStr(630), Format(LoadLStr(631), [tmp]), tmp) then
      begin
      // browsing
      try
        num := StrToInt(tmp);
      except
        ShowMessage(LoadLStr(621));
        Abort();
      end;

      Dec(num);
      if ((num >= 0) and (num < infMulti.pages)) then
        MGoToPage(num)
      else
        ShowMessage(LoadLStr(632));
      end;
end;

procedure MGoFirst();
begin
  MGoToPage(0);
end;

procedure MGoPrev();
begin
  if infMulti.page > 0 then
      MGoToPage(infMulti.page - 1)
  else
      MGoToPage(infMulti.pages - 1);
end;

procedure MGoNext();
begin
  if infMulti.page < (infMulti.pages - 1) then
      MGoToPage(infMulti.page + 1)
  else
      MGoToPage(0);
end;

procedure MGoLast();
begin
  MGoToPage(infMulti.pages - 1);
end;

// extracts current frame from multi-page to normal
procedure MExtract();
var
  img: HBITMAP;
    tmp_res: TFxImgResult;
begin
    tmp_res := infMulti.FxImgMultiGetPage(infMulti.page, Application.Handle, frmMain.Handle, FxImgGlobalCallback);

    if (tmp_res.result_type = RT_HBITMAP) then
    img := tmp_res.result_value
    else
      img := 0;

  if img <> 0 then
      OpenUntitled(nil, img);
end;

// closes multi-page image
procedure CloseMulti();
begin
  if @infMulti.FxImgMultiStop <> nil then
      infMulti.FxImgMultiStop(Application.Handle, frmMain.Handle, FxImgGlobalCallback);

  if infMulti.lib <> 0 then
      FreeLibrary(infMulti.lib);

    frmMain.mMulti.Visible := false;
    frmMain.tbnMultiPrev.Enabled := false;
    frmMain.tbnMultiNext.Enabled := false;
    frmMain.tbnGoToPage.Enabled := false;
  frmMain.pMulti.Visible := false;
  FillImage('', itNone);
end;

end.
