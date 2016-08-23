library f_shtml;

uses Windows, SysUtils, Graphics, Classes;

{$R *.RES}
{$R fipis.res}

function FIPIStool(info,path: PChar; app: THandle; img: hBitmap):hBitmap; stdcall;
var
   tmp, new: string;
   html: TStringList;
   bmp: TBitmap;
   wdth, hght: integer; // image dimensions
begin
tmp:=String(path);
Result:=0;
if tmp<>'' then begin
                if MessageBox(app,'Would you like to create HTML file for current image ?','Futuris Imager',MB_YESNO+MB_ICONQUESTION)=ID_YES then
                   begin
                   // creating html
                   bmp:=TBitmap.Create();
                   bmp.Handle:=img;
                   wdth:=bmp.Width;
                   hght:=bmp.Height;
                   bmp.Free();
                   new:=ChangeFileExt(tmp,'.html');
                   html:=TStringList.Create();
                   html.Add('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">');
                   html.Add('<html>');
                   html.Add('<head>');
                   html.Add('<title>' + ExtractFileName(tmp) + '</title>');
                   html.Add('<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">');
                   html.Add('</head>');
                   html.Add('');
                   html.Add('<body bgcolor="#FFFFFF" text="#000000">');
                   html.Add('<img src="' + ExtractFileName(tmp) + '" alt="" width="' + IntToStr(wdth) + '" height="' + IntToStr(hght) + '">');
                   html.Add('</body>');
                   html.Add('</html>');
                   try
                      html.SaveToFile(new);
                      except
                      MessageBox(app,'Error while saving resulting HTML file!','Error!',MB_OK+MB_ICONERROR);
                      html.Free();
                      Exit;
                      end;
                   html.Free();
                   MessageBox(app,PChar('HTML file created at: "' + new + '"'),'Futuris Imager',MB_OK+MB_ICONINFORMATION);
                   end;
                end
else begin
     // unsaved files
     MessageBox(app,'This tool can work only with saved images.','Warning!',MB_OK+MB_ICONWARNING);
     end;
end;

exports FIPIStool;

begin
end.
 