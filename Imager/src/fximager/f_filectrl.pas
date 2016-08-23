unit f_filectrl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs,
  ShellAPI, FileCtrl, c_utils, c_const, c_reg, c_locales;

procedure FDelete();
procedure FMove();
procedure FRename();
procedure FCopy();


implementation

uses f_graphics, f_nav, main;

procedure FDelete();
var
	op: TSHFileOpStruct;
	tmp: string;
    res: integer;
begin
    ZeroMemory(@op, sizeof(TSHFileOpStruct));

	if ((infImage.image_type <> itUnsaved) and (infImage.image_type <> itNone)) then
  		begin
        tmp := infImage.path;
        CloseImage();

        // recycle bin
        op.Wnd := frmMain.Handle;
        op.wFunc := FO_DELETE;
        op.pFrom := PChar(tmp);
      	op.pTo := nil;
        op.fFlags := (FOF_ALLOWUNDO or FOF_FILESONLY);
        op.hNameMappings := nil;
        op.lpszProgressTitle := sAppName;

        res := SHFileOperation(op);

        if ((res = 0) and (not op.fAnyOperationsAborted)) then
        	GoNext()
        else
        	Load(tmp);
  		end;
end;

procedure FMove();
var
	tmp, fl: string;
    res: longbool;
begin
    tmp := FxRegRStr('LastMoveFolder', '');

	if ((infImage.image_type <> itUnsaved) and (infImage.image_type <> itNone)) then
  		begin
  		if SelectDirectory(LoadLStr(611), '', tmp) then
    		begin
    		fl := infImage.path;
    		CloseImage();

            res := MoveFile(PChar(fl), PChar(Slash(tmp) + NoSlash(ExtractFileName(fl))));

            FxRegWStr('LastMoveFolder', Slash(tmp));

            if res then
    			Load(Slash(tmp) + ExtractFileName(fl))
            else
                Load(fl);
    		end;
  		end;
end;

procedure FRename();
var
	tmp, new, name: string;
begin
	if ((infImage.image_type <> itUnsaved) and (infImage.image_type <> itNone)) then
  		begin
  		tmp := infImage.path;
  		name := ExtractFileName(tmp);
  		if InputQuery(sAppName, LoadLStr(612), name) then
    		begin
    		CloseImage();

    		new := Slash(ExtractFileDir(tmp)) + name;

    		if RenameFile(tmp, new) then
     			Load(new)
            else
            	Load(tmp);
    		end;
  		end;
end;

procedure FCopy();
var
	tmp, fl: string;
    can_overwrite: boolean;
begin
    can_overwrite := false;

    tmp := FxRegRStr('LastCopyFolder', '');

	if ((infImage.image_type <> itUnsaved) and (infImage.image_type <> itNone)) then
  		begin
  		if SelectDirectory(LoadLStr(611), '', tmp) then
    		begin
    		fl := infImage.path;

            if FileExists(Slash(tmp) + NoSlash(ExtractFileName(fl))) then
            	if MessageBox(frmMain.Handle, PChar(LoadLStr(613)), sAppName, MB_YESNO or MB_ICONQUESTION) = ID_YES then
                	can_overwrite := true;

            CopyFile(PChar(fl), PChar(Slash(tmp) + NoSlash(ExtractFileName(fl))), not can_overwrite);

            FxRegWStr('LastCopyFolder', Slash(tmp));
    		end;
  		end;
end;

end.
