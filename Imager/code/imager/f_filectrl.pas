// file operations
unit f_filectrl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs,
  ShellAPI, FileCtrl, c_utils, c_const;

procedure FDelete();
procedure FMove();
procedure FRename();
procedure FCopy();


implementation

uses globals, f_graphics, f_nav, main;

procedure FDelete();
var
	op: TSHFileOpStruct;
	tmp: string;
    res: integer;
begin
	if infImage.file_type = ftLocal then
  		begin
  		if Application.MessageBox('Do you really want to delete current file ?', 'Futuris Imager', MB_YESNO + MB_ICONQUESTION) = ID_YES then
    		begin
    		tmp := infImage.path;
    		CloseImage();

    		if HiWord(GetKeyState(VK_SHIFT)) <> 0 then
      			begin
      			// permanent
                if DeleteFile(tmp) then
                	res := 0
                else
                	res := 1;
      			end
    		else
      			begin
      			// recycle bin
      			op.Wnd := frmMain.Handle;
      			op.wFunc := FO_DELETE;
      			op.pFrom := PChar(tmp);
      			op.pTo := nil;
      			op.fFlags := FOF_ALLOWUNDO + FOF_NOCONFIRMATION;
      			op.lpszProgressTitle := 'Futuris Imager';

      			res := SHFileOperation(op);
      			end;

            if (res = 0) then
    			GoNext()
            else
            	Load(tmp);
    		end;
  		end;
end;

procedure FMove();
var
	tmp, fl: string;
    res: longbool;
begin
    reg.OpenKey(sReg + '\Main', true);
    tmp := reg.RStr('LastMoveFolder', '');
    reg.CloseKey();

	if infImage.file_type = ftLocal then
  		begin
  		if SelectDirectory('Select destination folder ...', '', tmp) then
    		begin
    		fl := infImage.path;
    		CloseImage();

            res := MoveFile(PChar(fl), PChar(Slash(tmp) + NoSlash(ExtractFileName(fl))));

            reg.OpenKey(sReg + '\Main', true);
            reg.WString('LastMoveFolder', Slash(tmp));
            reg.CloseKey();

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
	if infImage.file_type = ftLocal then
  		begin
  		tmp := infImage.path;
  		name := ExtractFileName(tmp);
  		if InputQuery('Futuris Imager', 'Type new file name (with extension) ...', name) then
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

    reg.OpenKey(sReg + '\Main', true);
    tmp := reg.RStr('LastCopyFolder', '');
    reg.CloseKey();

	if infImage.file_type = ftLocal then
  		begin
  		if SelectDirectory('Select destination folder ...', '', tmp) then
    		begin
    		fl := infImage.path;

            if FileExists(Slash(tmp) + NoSlash(ExtractFileName(fl))) then
            	if MessageBox(frmMain.Handle, 'The file with the same name already exists in the destination folder. Would you like to overwrite it?', sAppName, MB_YESNO or MB_ICONQUESTION) = ID_YES then
                	can_overwrite := true;

            CopyFile(PChar(fl), PChar(Slash(tmp) + NoSlash(ExtractFileName(fl))), not can_overwrite);

            reg.OpenKey(sReg + '\Main', true);
            reg.WString('LastCopyFolder', Slash(tmp));
            reg.CloseKey();
    		end;
  		end;
end;

end.
