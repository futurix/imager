// file operations
unit f_filectrl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Dialogs,
  ShellAPI, FileCtrl, c_utils;

resourcestring
	  rsDelConf = 'Do you really want to delete current file ?';
	  rsMoveCapt = 'Select destination folder ...';
	  rsRenQuery = 'Type new file name (with extension) ...';

procedure FDelete();
procedure FMove();
procedure FRename();
procedure FCopy();


implementation

uses globals, f_graphics, f_nav;

procedure FDelete();
var
	op: TSHFileOpStruct;
	tmp: string;
begin
	if infImage.file_type = ftLocal then
  		begin
  		if Application.MessageBox(PChar(rsDelConf), 'Futuris Imager', MB_YESNO + MB_ICONQUESTION) = ID_YES then
    		begin
    		tmp := infImage.path;
    		CloseImage();

    		if HiWord(GetKeyState(VK_SHIFT)) <> 0 then
      			begin
      			// permanent
      			op.Wnd := 0;
      			op.wFunc := FO_DELETE;
      			op.pFrom := PChar(tmp);
      			op.pTo := nil;
      			op.fFlags := FOF_NOCONFIRMATION + FOF_SILENT;
      			op.lpszProgressTitle := 'Futuris Imager';

      			SHFileOperation(op);
      			end
    		else
      			begin
      			// recycle bin
      			op.Wnd := 0;
      			op.wFunc := FO_DELETE;
      			op.pFrom := PChar(tmp);
      			op.pTo := nil;
      			op.fFlags := FOF_ALLOWUNDO + FOF_NOCONFIRMATION + FOF_SILENT;
      			op.lpszProgressTitle := 'Futuris Imager';

      			SHFileOperation(op);
      			end;

    		GoNext();
    		end;
  		end;
end;

procedure FMove();
var
	op: TSHFileOpStruct;
	tmp, fl: string;
begin
	if infImage.file_type = ftLocal then
  		begin
  		if SelectDirectory(PChar(rsMoveCapt), '', tmp) then
    		begin
    		fl := infImage.path;
    		CloseImage();

    		op.Wnd := 0;
    		op.wFunc := FO_MOVE;
    		op.pFrom := PChar(fl);
    		op.pTo := PChar(tmp);
    		op.fFlags := FOF_ALLOWUNDO + FOF_NOCONFIRMATION + FOF_SILENT;
    		op.lpszProgressTitle := 'Futuris Imager';

    		SHFileOperation(op);

    		Load(Slash(tmp) + ExtractFileName(fl));
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
  		if InputQuery('Futuris Imager', rsRenQuery, name) then
    		begin
    		CloseImage();

    		new := Slash(ExtractFileDir(tmp)) + name;

    		if RenameFile(tmp, new) then
     			Load(new);
    		end;
  		end;
end;

procedure FCopy();
var
	op: TSHFileOpStruct;
	tmp, fl: string;
begin
	if infImage.file_type = ftLocal then
  		begin
  		if SelectDirectory(PChar(rsMoveCapt), '', tmp) then
    		begin
    		fl := infImage.path;

    		op.Wnd := 0;
    		op.wFunc := FO_COPY;
    		op.pFrom := PChar(fl);
    		op.pTo := PChar(tmp);
    		op.fFlags := FOF_ALLOWUNDO + FOF_NOCONFIRMATION + FOF_SILENT;
    		op.lpszProgressTitle := 'Futuris Imager';

    		SHFileOperation(op);
    		end;
  		end;
end;

end.
