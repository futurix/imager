unit f_scan;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, ShellAPI, Forms,
  c_reg, c_utils, c_const, c_locales;

var
	mod_folder: string = '';
	current_dll: string = '';

procedure DoPluginScan();
procedure ProcessLib(filename: string);
function  SortData(module_type: integer; value1, value2: PChar):BOOL; cdecl;
procedure WriteData(key, value1: string);
procedure WriteInternal(key, value: string);
procedure WriteDescr(ext, name: string);
procedure WriteLocale(name: string);
procedure WriteTheme(name: string);


implementation

uses main, f_tools, ComObj;

procedure DoPluginScan();
begin
	// recreating registry keys
    reg.OpenKey(sModules, true);
    reg.DeleteKey(PS_FNAME);
    reg.DeleteKey(PS_FROLE);
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
    reg.DeleteKey(PS_FLOCALE);
    reg.DeleteKey(PS_FTHEME);
    reg.CloseKey();

    // adding internal formats
	WriteInternal(PS_FOPEN, 'jpg');
	WriteInternal(PS_FOPEN, 'jpeg');
	WriteInternal(PS_FOPEN, 'jfif');
	WriteInternal(PS_FOPEN, 'jp2');
	WriteInternal(PS_FOPEN, 'jpc');
	WriteInternal(PS_FOPEN, 'j2k');
    WriteInternal(PS_FOPEN, 'j2c');
    WriteInternal(PS_FOPEN, 'gif');
	WriteInternal(PS_FOPEN, 'pbm');
	WriteInternal(PS_FOPEN, 'pgm');
	WriteInternal(PS_FOPEN, 'ppm');
	WriteInternal(PS_FOPEN, 'bmp');
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

	WriteDescr('jpg', LoadLStr(1000) + ' (*.jpg)');
	WriteDescr('jpeg', LoadLStr(1000) + ' (*.jpeg)');
	WriteDescr('jfif', LoadLStr(1000) + ' (*.jfif)');
	WriteDescr('jp2', LoadLStr(1001) + ' (*.jp2)');
	WriteDescr('jpc', LoadLStr(1001) + ' (*.jpc)');
	WriteDescr('j2k', LoadLStr(1001) + ' (*.j2k)');
    WriteDescr('j2c', LoadLStr(1001) + ' (*.j2c)');
    WriteDescr('gif', LoadLStr(1002) + ' (*.gif)');
	WriteDescr('pbm', LoadLStr(1003) + ' (*.pbm)');
	WriteDescr('pgm', LoadLStr(1004) + ' (*.pgm)');
	WriteDescr('ppm', LoadLStr(1005) + ' (*.ppm)');
	WriteDescr('bmp', LoadLStr(1006) + ' (*.bmp)');
	WriteDescr('emf', LoadLStr(1007) + ' (*.emf)');
	WriteDescr('wmf', LoadLStr(1008) + ' (*.wmf)');
	WriteDescr('pcx', LoadLStr(1009) + ' (*.pcx)');
	WriteDescr('dcx', LoadLStr(1010) + ' (*.dcx)');
	WriteDescr('png', LoadLStr(1011) + ' (*.png)');
	WriteDescr('tga', LoadLStr(1012) + ' (*.tga)');
	WriteDescr('tif', LoadLStr(1013) + ' (*.tif)');
	WriteDescr('tiff', LoadLStr(1013) + ' (*.tiff)');
    WriteDescr('wbmp', LoadLStr(1014) + ' (*.wbmp)');
    WriteDescr('wbm', LoadLStr(1014) + ' (*.wbm)');

    if FileExists(path_app + FN_ADDRAW) then
    	begin
        current_dll := path_app + FN_ADDRAW;
        WriteData(PS_FNAME, 'Raw Camera Formats Add-on');
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

        WriteDescr('crw', LoadLStr(1035) + ' (*.crw)');
        WriteDescr('cr2', LoadLStr(1035) + ' (*.cr2)');
        WriteDescr('dng', LoadLStr(1036) + ' (*.dng)');
        WriteDescr('nef', LoadLStr(1037) + ' (*.nef)');
        WriteDescr('raw', LoadLStr(1038) + ' (*.raw)');
        WriteDescr('raf', LoadLStr(1039) + ' (*.raf)');
        WriteDescr('x3f', LoadLStr(1038) + ' (*.x3f)');
        WriteDescr('orf', LoadLStr(1038) + ' (*.orf)');
        WriteDescr('srf', LoadLStr(1038) + ' (*.srf)');
        WriteDescr('mrw', LoadLStr(1038) + ' (*.mrw)');
        WriteDescr('dcr', LoadLStr(1038) + ' (*.dcr)');
        WriteDescr('bay', LoadLStr(1038) + ' (*.bay)');
        WriteDescr('pef', LoadLStr(1038) + ' (*.pef)');
        end;

    if FileExists(path_app + FN_ADDJBIG) then
    	begin
        current_dll := path_app + FN_ADDJBIG;
        WriteData(PS_FNAME, 'JBIG Add-on');
        current_dll := '';

        WriteInternal(PS_FOPEN, 'jbg');
        WriteInternal(PS_FOPEN, 'jbig');
        WriteInternal(PS_FOPEN, 'bie');

        WriteDescr('jbg', LoadLStr(1040) + ' (*.jbg)');
        WriteDescr('jbig', LoadLStr(1040) + ' (*.jbig)');
        WriteDescr('bie', LoadLStr(1040) + ' (*.bie)');
        end;

    if FileExists(path_app + FN_ADDMAGICK) then
    	begin
        current_dll := path_app + FN_ADDMAGICK;
        WriteData(PS_FNAME, 'ImageMagick Add-on');
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

        WriteDescr('dcm',   LoadLStr(1041) + ' (*.dcm)');
        WriteDescr('dicom', LoadLStr(1041) + ' (*.dicom)');
        WriteDescr('cut',   LoadLStr(1042) + ' (*.cut)');
        WriteDescr('avs',   LoadLStr(1043) + ' (*.avs)');
        WriteDescr('cin',   LoadLStr(1044) + ' (*.cin)');
        WriteDescr('dot',   LoadLStr(1045) + ' (*.dot)');
        WriteDescr('dpx',   LoadLStr(1046) + ' (*.dpx)');
        WriteDescr('fits',  LoadLStr(1047) + ' (*.fits)');
        WriteDescr('fpx',   LoadLStr(1048) + ' (*.fpx)');
        WriteDescr('mat',   LoadLStr(1049) + ' (*.mat)');
        WriteDescr('miff',  LoadLStr(1050) + ' (*.miff)');
        WriteDescr('mtv',   LoadLStr(1051) + ' (*.mtv)');
        WriteDescr('palm',  LoadLStr(1052) + ' (*.palm)');
        WriteDescr('pict',  LoadLStr(1053) + ' (*.pict)');
        WriteDescr('pix',   LoadLStr(1054) + ' (*.pix)');
        WriteDescr('pwp',   LoadLStr(1055) + ' (*.pwp)');
        WriteDescr('rla',   LoadLStr(1056) + ' (*.rla)');
        WriteDescr('sgi',   LoadLStr(1057) + ' (*.sgi)');
        WriteDescr('sun',   LoadLStr(1058) + ' (*.sun)');
        WriteDescr('svg',   LoadLStr(1059) + ' (*.svg)');
        WriteDescr('ttf',   LoadLStr(1060) + ' (*.ttf)');
        WriteDescr('vicar', LoadLStr(1061) + ' (*.vicar)');
        WriteDescr('viff',  LoadLStr(1062) + ' (*.viff)');
        WriteDescr('xcf',   LoadLStr(1063) + ' (*.xcf)');
        end;

	// going through locations
	mod_folder := NoSlash(path_app);
  	ScanFolderF(NoSlash(path_app), '*.dll', @ProcessLib);
  	mod_folder := '';
end;

procedure ProcessLib(filename: string);
var
	lib: THandle;
	supp: TFxImgQuery;
    tmp: string;
begin
	lib := LoadLibrary(PChar(filename));

    if (lib <> 0) then
  		begin
        current_dll := filename;

        if (LoadResString(lib, 1) = sLocaleID) then
        	begin
            // library is compatible locale
            tmp := LoadResString(lib, 2);

            if (Trim(tmp) <> '') then
                WriteLocale(tmp);
            end
        else if (LoadResString(lib, 3) = sThemeID) then
        	begin
            // library is compatible theme
            tmp := LoadResString(lib, 4);

            if (Trim(tmp) <> '') then
                WriteTheme(tmp);
            end
        else if (GetProcAddress(lib, EX_QUERY) <> nil) then
    		begin
            // library is compatible plug-in
    		@supp := GetProcAddress(lib, EX_QUERY);
    		supp(PChar(current_dll), SortData, Application.Handle, frmMain.Handle, FxImgGlobalCallback);
    		end;

        current_dll := '';
  		FreeLibrary(lib);
  		end;
end;

function SortData(module_type: integer; value1, value2: PChar):BOOL;
begin
	Result := true;

    // working
	case module_type of
        PT_FNAME: 		WriteData(PS_FNAME, 	 	String(value1));
        PT_FROLE: 		WriteData(PS_FROLE, 	 	String(value1));
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
