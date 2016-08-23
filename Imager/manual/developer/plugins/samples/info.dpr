library info;

uses
  Windows, Classes, SysUtils,
  c_const;

{$R *.RES}


function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
	func(PT_FINFO, 'bmp', ' ');

	Result := true;
end;

function FInfo(path, ext: PChar; func: TDoubleCallBack; app, wnd: THandle):integer; stdcall;
begin
    {
    	this function passes pairs of strings that will be displayed in "Information" dialog
        (in order that you'll pass them

        there are 2 special pairs of strings:
        1) 'ADD_PREBUILT_INFORMATION' and '' - force Imager add usual image info (dimensions, file size, etc)
        2) '' and '' - force Imager add empty line (separator)
    }

	func('ADD_PREBUILT_INFORMATION', '');
	func('', '');
	func('Obscure Key', 'Obscure Value');

	Result := 1;
end;

exports
	FQuery, FInfo;

begin
end.
