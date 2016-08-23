// global definitions
unit globals;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, IniFiles, Registry,
  c_const, c_reg;

type
	TDoPrint = function(app: THandle; img: hBitmap; filename: PChar; fast: boolean):integer; stdcall;

	TFileTypes = (ftNone, ftLocal, ftUnsaved);
	TImageTypes = (itNone, itNormal, itAnimated, itMulti);
    TDisplayStyles = (dsNormal, dsFit);
	TOptionsValues = (opOpenAfterSave, opFullPathInTitle, opOpenDef, opNoMRU);
	TOptions = set of TOptionsValues;

var
	files: TStringList;
	reg: TFuturisRegistry;

var infImage: record
	path: string;
	file_type: TFileTypes;
	image_type: TImageTypes;
	filenum: integer;
end;

var infSettings: record
	options: TOptions;
	dir: string;
	full_screen: boolean;
end;

var infMulti: record
	lib: THandle;
	pages, page: integer;

	// functions
	FIPISmultiInit: TFIPISmultiInit;
	FIPISmultiGetPages: TFIPISmultiGetPages;
	FIPISmultiGetPage: TFIPISmultiGetPage;
	FIPISmultiDeInit: TFIPISmultiDeInit;
end;

var infAnim: record
	lib: THandle;

	// functions
	FIPISanimInit: TFIPISanimInit;
	FIPISanimConfirm: TFIPISanimConfirm;
	FIPISanimRestart: TFIPISanimRestart;
	FIPISanimGetFrame: TFIPISanimGetFrame;
	FIPISanimDeInit: TFIPISanimDeInit;
end;

procedure FillImage(path: string; file_type: TFileTypes; image_type: TImageTypes);
procedure FillBitmap(bmp: TBitmap; img: hBitmap = 0);


implementation

uses main, f_images;

procedure FillImage(path: string; file_type: TFileTypes; image_type: TImageTypes);
begin
	infImage.path:=path;
	infImage.file_type:=file_type;
	infImage.image_type:=image_type;

    frmMain.img.Repaint();
end;

procedure FillBitmap(bmp: TBitmap; img: hBitmap = 0);
var
	bim: TBitmap;
begin
	if (img = 0) then
  		begin
  		bmp.PixelFormat := pf24bit;
  		frmMain.img.IEBitmap.Assign(bmp);
    	end
	else
  		begin
        bim := TBitmap.Create();
        bim.Handle := img;
        bim.PixelFormat := pf24bit;
        frmMain.img.IEBitmap.Assign(bim);
        FreeAndNil(bim);
  		end;

    frmMain.img.Repaint();
end;

end.
