// clipboard routines
unit f_clipboard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Clipbrd;

procedure CBCopy();
procedure CBPaste();
procedure CBClear();
function IsBitmapInCB():boolean;

implementation

uses globals, main, f_graphics;

// copies image to clipboard
procedure CBCopy();
begin
Clipboard.Assign(infImage.original);
end;

// pastes image from clipboard
procedure CBPaste();
var
  tmp: TBitmap;
  wmf: TMetaFile;
begin
tmp:=TBitmap.Create();
if Clipboard.HasFormat(CF_BITMAP) then
  begin
  tmp.Assign(Clipboard);
  OpenUntitled(tmp);
  end
else
  if Clipboard.HasFormat(CF_METAFILEPICT) then
    begin
    wmf:=TMetaFile.Create();
    wmf.Assign(Clipboard);
    tmp.Width:=wmf.Width;
    tmp.Height:=wmf.Height;
    tmp.Canvas.Draw(0,0,wmf);
    OpenUntitled(tmp);
    wmf.Free();
    end;
tmp.Free();
end;

// clears clipboard
procedure CBClear();
begin
Clipboard.Clear();
end;

// return true if ClipBoard contains bitmap
function IsBitmapInCB():boolean;
begin
if ((Clipboard.HasFormat(CF_BITMAP)) or (Clipboard.HasFormat(CF_METAFILEPICT))) then
  Result:=true else Result:=false;
end;

end.
