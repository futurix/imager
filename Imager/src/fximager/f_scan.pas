unit f_scan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, ShellAPI, Forms,
  c_reg, c_utils, c_const, c_locales;

var
	current_dll: string = '';

procedure DoPluginScan();
procedure DoLocaleScan();
procedure DoThemesScan();
procedure ProcessLib(filename: string);
procedure ProcessLocale(filename: string);
procedure ProcessTheme(filename: string);
function  SortData(module_type: longword; value1, value2: PChar):BOOL; cdecl;
procedure WriteData(key, value1: string);
procedure WriteInternal(key, value: string);
procedure WriteDescr(ext, name: string);
procedure WriteNotRec(ext: string);
procedure WriteLocale(name: string);
procedure WriteTheme(name: string);


implementation

uses main, f_tools, ComObj;

procedure DoPluginScan();
begin
	// recreating registry keys
    reg.OpenKey(sModules, true);
    reg.DeleteKey(PS_FNAME);
    reg.DeleteKey(PS_FCONFIG);
    reg.DeleteKey(PS_FROLE);
    reg.DeleteKey(PS_FNOTREC);
    reg.DeleteKey(PS_FOPEN);
    reg.DeleteKey(PS_FOPENMULTI);
    reg.DeleteKey(PS_FOPENANIM);
    reg.DeleteKey(PS_FSAVE);
    reg.DeleteKey(PS_FIMPORT);
    reg.DeleteKey(PS_FEXPORT);
    reg.DeleteKey(PS_FFILTER);
    reg.DeleteKey(PS_FINFO);
    reg.DeleteKey(PS_FTOOL);
    reg.DeleteKey(PS_FDESCR);
    reg.CloseKey();

    // adding internal formats
	WriteInternal(PS_FOPEN, 'jpg');
	WriteInternal(PS_FOPEN, 'jpeg');
	WriteInternal(PS_FOPEN, 'jfif');
    WriteInternal(PS_FOPEN, 'jpe');
	WriteInternal(PS_FOPEN, 'jp2');
	WriteInternal(PS_FOPEN, 'jpc');
	WriteInternal(PS_FOPEN, 'j2k');
    WriteInternal(PS_FOPEN, 'j2c');
    WriteInternal(PS_FOPEN, 'gif');
	WriteInternal(PS_FOPEN, 'pbm');
	WriteInternal(PS_FOPEN, 'pgm');
	WriteInternal(PS_FOPEN, 'ppm');
	WriteInternal(PS_FOPEN, 'bmp');
	WriteInternal(PS_FOPEN, 'dib');
	WriteInternal(PS_FOPEN, 'emf');
	WriteInternal(PS_FOPEN, 'wmf');
	WriteInternal(PS_FOPEN, 'pcx');
	WriteInternal(PS_FOPEN, 'dcx');
	WriteInternal(PS_FOPEN, 'png');
	WriteInternal(PS_FOPEN, 'tga');
	WriteInternal(PS_FOPEN, 'tif');
	WriteInternal(PS_FOPEN, 'tiff');
    WriteInternal(PS_FOPEN, 'wbmp');
    WriteInternal(PS_FOPEN, 'wbm');

    WriteNotRec('dcx');
    WriteNotRec('jpe');
    WriteNotRec('jfif');

	WriteDescr('jpg', LoadLStr(1000));
	WriteDescr('jpeg', LoadLStr(1000));
	WriteDescr('jfif', LoadLStr(1000));
    WriteDescr('jpe', LoadLStr(1000));
	WriteDescr('jp2', LoadLStr(1001));
	WriteDescr('jpc', LoadLStr(1001));
	WriteDescr('j2k', LoadLStr(1001));
    WriteDescr('j2c', LoadLStr(1001));
    WriteDescr('gif', LoadLStr(1002));
	WriteDescr('pbm', LoadLStr(1003));
	WriteDescr('pgm', LoadLStr(1004));
	WriteDescr('ppm', LoadLStr(1005));
	WriteDescr('bmp', LoadLStr(1006));
	WriteDescr('dib', LoadLStr(1006));
	WriteDescr('emf', LoadLStr(1007));
	WriteDescr('wmf', LoadLStr(1008));
	WriteDescr('pcx', LoadLStr(1009));
	WriteDescr('dcx', LoadLStr(1010));
	WriteDescr('png', LoadLStr(1011));
	WriteDescr('tga', LoadLStr(1012));
	WriteDescr('tif', LoadLStr(1013));
	WriteDescr('tiff', LoadLStr(1013));
    WriteDescr('wbmp', LoadLStr(1014));
    WriteDescr('wbm', LoadLStr(1014));

    if FileExists(path_app + FN_ADDRAW) then
    	begin
        current_dll := path_app + FN_ADDRAW;
        WriteData(PS_FNAME, 'Raw camera formats support');
        current_dll := '';

        WriteInternal(PS_FOPEN, 'crw');
        WriteInternal(PS_FOPEN, 'cr2');
        WriteInternal(PS_FOPEN, 'dng');
        WriteInternal(PS_FOPEN, 'nef');
        WriteInternal(PS_FOPEN, 'raw');
        WriteInternal(PS_FOPEN, 'raf');
        WriteInternal(PS_FOPEN, 'x3f');
        WriteInternal(PS_FOPEN, 'orf');
        WriteInternal(PS_FOPEN, 'srf');
        WriteInternal(PS_FOPEN, 'mrw');
        WriteInternal(PS_FOPEN, 'dcr');
        WriteInternal(PS_FOPEN, 'bay');
        WriteInternal(PS_FOPEN, 'pef');

        WriteNotRec('x3f');
        WriteNotRec('orf');
        WriteNotRec('srf');
        WriteNotRec('mrw');
        WriteNotRec('dcr');
        WriteNotRec('bay');
        WriteNotRec('pef');

        WriteDescr('crw', LoadLStr(1035));
        WriteDescr('cr2', LoadLStr(1035));
        WriteDescr('dng', LoadLStr(1036));
        WriteDescr('nef', LoadLStr(1037));
        WriteDescr('raw', LoadLStr(1038));
        WriteDescr('raf', LoadLStr(1039));
        WriteDescr('x3f', LoadLStr(1038));
        WriteDescr('orf', LoadLStr(1038));
        WriteDescr('srf', LoadLStr(1038));
        WriteDescr('mrw', LoadLStr(1038));
        WriteDescr('dcr', LoadLStr(1038));
        WriteDescr('bay', LoadLStr(1038));
        WriteDescr('pef', LoadLStr(1038));
        end;

    if FileExists(path_app + FN_ADDJBIG) then
    	begin
        current_dll := path_app + FN_ADDJBIG;
        WriteData(PS_FNAME, 'JBIG support');
        current_dll := '';

        WriteInternal(PS_FOPEN, 'jbg');
        WriteInternal(PS_FOPEN, 'jbig');
        WriteInternal(PS_FOPEN, 'bie');

        WriteNotRec('bie');

        WriteDescr('jbg', LoadLStr(1040));
        WriteDescr('jbig', LoadLStr(1040));
        WriteDescr('bie', LoadLStr(1040));
        end;

    if FileExists(path_app + FN_ADDMAGICK) then
    	begin
        current_dll := path_app + FN_ADDMAGICK;
        WriteData(PS_FNAME, 'ImageMagick integration');
        current_dll := '';

        WriteInternal(PS_FOPEN, 'dcm');
        WriteInternal(PS_FOPEN, 'dicom');
        WriteInternal(PS_FOPEN, 'cut');
        WriteInternal(PS_FOPEN, 'avs');
        WriteInternal(PS_FOPEN, 'cin');
        WriteInternal(PS_FOPEN, 'dot');
        WriteInternal(PS_FOPEN, 'dpx');
        WriteInternal(PS_FOPEN, 'fits');
        WriteInternal(PS_FOPEN, 'fpx');
        WriteInternal(PS_FOPEN, 'mat');
        WriteInternal(PS_FOPEN, 'miff');
        WriteInternal(PS_FOPEN, 'mtv');
        WriteInternal(PS_FOPEN, 'palm');
        WriteInternal(PS_FOPEN, 'pict');
        WriteInternal(PS_FOPEN, 'pix');
        WriteInternal(PS_FOPEN, 'pwp');
        WriteInternal(PS_FOPEN, 'rla');
        WriteInternal(PS_FOPEN, 'sgi');
        WriteInternal(PS_FOPEN, 'sun');
        WriteInternal(PS_FOPEN, 'svg');
        WriteInternal(PS_FOPEN, 'ttf');
        WriteInternal(PS_FOPEN, 'vicar');
        WriteInternal(PS_FOPEN, 'viff');
        WriteInternal(PS_FOPEN, 'xcf');

        WriteNotRec('avs');
        WriteNotRec('cin');
        WriteNotRec('cut');
        WriteNotRec('dot');
        WriteNotRec('dpx');
        WriteNotRec('fits');
        WriteNotRec('mat');
        WriteNotRec('miff');
        WriteNotRec('mtv');
        WriteNotRec('palm');
        WriteNotRec('pix');
        WriteNotRec('pwp');
        WriteNotRec('sun');
        WriteNotRec('svg');
        WriteNotRec('ttf');
        WriteNotRec('vicar');
        WriteNotRec('viff');

        WriteDescr('dcm',   LoadLStr(1041));
        WriteDescr('dicom', LoadLStr(1041));
        WriteDescr('cut',   LoadLStr(1042));
        WriteDescr('avs',   LoadLStr(1043));
        WriteDescr('cin',   LoadLStr(1044));
        WriteDescr('dot',   LoadLStr(1045));
        WriteDescr('dpx',   LoadLStr(1046));
        WriteDescr('fits',  LoadLStr(1047));
        WriteDescr('fpx',   LoadLStr(1048));
        WriteDescr('mat',   LoadLStr(1049));
        WriteDescr('miff',  LoadLStr(1050));
        WriteDescr('mtv',   LoadLStr(1051));
        WriteDescr('palm',  LoadLStr(1052));
        WriteDescr('pict',  LoadLStr(1053));
        WriteDescr('pix',   LoadLStr(1054));
        WriteDescr('pwp',   LoadLStr(1055));
        WriteDescr('rla',   LoadLStr(1056));
        WriteDescr('sgi',   LoadLStr(1057));
        WriteDescr('sun',   LoadLStr(1058));
        WriteDescr('svg',   LoadLStr(1059));
        WriteDescr('ttf',   LoadLStr(1060));
        WriteDescr('vicar', LoadLStr(1061));
        WriteDescr('viff',  LoadLStr(1062));
        WriteDescr('xcf',   LoadLStr(1063));
        end;

  	ScanFolderF(NoSlash(path_app), '*.dll', @ProcessLib);
end;

procedure DoLocaleScan();
begin
    reg.OpenKey(sModules, true);
    reg.DeleteKey(PS_FLOCALE);
    reg.CloseKey();

	ScanFolderF(NoSlash(path_app), '*.dll', @ProcessLocale);
end;

procedure DoThemesScan();
begin
    reg.OpenKey(sModules, true);
    reg.DeleteKey(PS_FTHEME);
    reg.CloseKey();

	ScanFolderF(NoSlash(path_app), '*.dll', @ProcessTheme);
end;

procedure ProcessLib(filename: string);
var
	lib: THandle;
	supp: TFxImgQuery;
begin
	lib := LoadLibrary(PChar(filename));

    if (lib <> 0) then
  		begin
        current_dll := filename;

        if ((LoadResString(lib, 1) <> sLocaleID) and (LoadResString(lib, 1) <> sThemeID) and (GetProcAddress(lib, EX_QUERY) <> nil)) then
    		begin
            // library is compatible plug-in
    		@supp := GetProcAddress(lib, EX_QUERY);
    		supp(PChar(current_dll), SortData, Application.Handle, frmMain.Handle, FxImgGlobalCallback);
    		end;

        current_dll := '';
  		FreeLibrary(lib);
  		end;
end;

procedure ProcessLocale(filename: string);
var
	lib: THandle;
    tmp: string;
begin
	lib := LoadLibraryEx(PChar(filename), 0, LOAD_LIBRARY_AS_DATAFILE);

    if (lib <> 0) then
  		begin
        current_dll := filename;

        if (LoadResString(lib, 1) = sLocaleID) then
        	begin
            // library is compatible locale
            tmp := LoadResString(lib, 2);

            if (Trim(tmp) <> '') then
                WriteLocale(tmp);
            end;

        current_dll := '';
  		FreeLibrary(lib);
  		end;
end;

procedure ProcessTheme(filename: string);
var
	lib: THandle;
    tmp: string;
begin
	lib := LoadLibraryEx(PChar(filename), 0, LOAD_LIBRARY_AS_DATAFILE);

    if (lib <> 0) then
  		begin
        current_dll := filename;

        if (LoadResString(lib, 1) = sThemeID) then
        	begin
            // library is compatible theme
            tmp := LoadResString(lib, 2);

            if (Trim(tmp) <> '') then
                WriteTheme(tmp);
            end;

        current_dll := '';
  		FreeLibrary(lib);
  		end;
end;

function SortData(module_type: longword; value1, value2: PChar):BOOL;
begin
	Result := true;

    // working
	case module_type of
        PT_FNAME: 		WriteData(PS_FNAME, 	 	String(value1));
        PT_FCONFIG: 	WriteData(PS_FCONFIG, 	 	String(value1));
        PT_FROLE: 		WriteData(PS_FROLE, 	 	String(value1));
        PT_FNOTREC:     WriteNotRec(String(value1));
  		PT_FOPEN: 		WriteData(PS_FOPEN, 	 	String(value1));
  		PT_FOPENMULTI: 	WriteData(PS_FOPENMULTI,	String(value1));
  		PT_FOPENANIM: 	WriteData(PS_FOPENANIM, 	String(value1));
  		PT_FSAVE: 		WriteData(PS_FSAVE, 	 	String(value1));
  		PT_FIMPORT: 	WriteData(PS_FIMPORT,  		String(value1));
  		PT_FEXPORT: 	WriteData(PS_FEXPORT,  		String(value1));
  		PT_FFILTER: 	WriteData(PS_FFILTER, 		String(value1));
  		PT_FINFO: 		WriteData(PS_FINFO, 	 	String(value1));
  		PT_FTOOL: 		WriteData(PS_FTOOL, 	 	String(value1));
        PT_FDESCR: 		WriteDescr(String(value1), 	String(value2));
  	else
    	Result := false;
  	end;
end;

procedure WriteData(key, value1: string);
begin
	reg.OpenKey(sModules + '\' + key, true);
    reg.WString(value1, current_dll);
    reg.CloseKey();
end;

procedure WriteInternal(key, value: string);
begin
	reg.OpenKey(sModules + '\' + key, true);
    reg.WString(value, sInternalFormat);
    reg.CloseKey();
end;

procedure WriteDescr(ext, name: string);
begin
	reg.OpenKey(sModules + '\' + PS_FDESCR, true);
    reg.WString(ext, name);
    reg.CloseKey();
end;

procedure WriteNotRec(ext: string);
begin
	reg.OpenKey(sModules + '\' + PS_FNOTREC, true);
    reg.WString(ext, '');
    reg.CloseKey();
end;

procedure WriteLocale(name: string);
begin
	reg.OpenKey(sModules + '\' + PS_FLOCALE, true);
    reg.WString(name, current_dll);
    reg.CloseKey();
end;

procedure WriteTheme(name: string);
begin
	reg.OpenKey(sModules + '\' + PS_FTHEME, true);
    reg.WString(name, current_dll);
    reg.CloseKey();
end;

end.
