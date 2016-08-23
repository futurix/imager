// functions for window position saving/restoring 
unit c_pos;

interface

uses Windows, Messages, SysUtils, Forms, c_reg;

procedure SaveWindowState(form: TForm; registry: TFuturisRegistry; path: string);
procedure RestoreWindowState(form: TForm; registry: TFuturisRegistry; path: string;
                             d_l, d_r, d_t, d_b, d_f, d_s: integer);
procedure SaveWindowPosition(form: TForm; registry: TFuturisRegistry; path: string);
procedure RestoreWindowPosition(form: TForm; registry: TFuturisRegistry; path: string;
                                d_t, d_l: integer);
procedure SaveWindowSize(form: TForm; registry: TFuturisRegistry; path: string);
procedure RestoreWindowSize(form: TForm; registry: TFuturisRegistry; path: string;
                            d_w, d_h: integer);

implementation

procedure SaveWindowState(form: TForm; registry: TFuturisRegistry; path: string);
var
  wnd: TWindowPlacement;
begin
// getting data
wnd.length:=SizeOf(wnd);
GetWindowPlacement(form.Handle,@wnd);
// saving data
registry.OpenKey(path,true);
registry.WInteger('Flags',wnd.flags);
registry.WInteger('ShowCmd',wnd.showCmd);
registry.WInteger('MinX',wnd.ptMinPosition.X);
registry.WInteger('MinY',wnd.ptMinPosition.Y);
registry.WInteger('MaxX',wnd.ptMaxPosition.X);
registry.WInteger('MaxY',wnd.ptMaxPosition.Y);
registry.WInteger('NrmL',wnd.rcNormalPosition.Left);
registry.WInteger('NrmT',wnd.rcNormalPosition.Top);
registry.WInteger('NrmR',wnd.rcNormalPosition.Right);
registry.WInteger('NrmB',wnd.rcNormalPosition.Bottom);
registry.CloseKey();
end;

procedure RestoreWindowState(form: TForm; registry: TFuturisRegistry; path: string;
                             d_l, d_r, d_t, d_b, d_f, d_s: integer);
var
  wnd: TWindowPlacement;
begin
// restoring data
registry.OpenKey(path,true);
wnd.length:=SizeOf(wnd);
wnd.flags:=registry.RIntC('Flags',d_f);
wnd.showCmd:=registry.RIntC('ShowCmd',d_s);
wnd.ptMinPosition.X:=registry.RIntC('MinX',$FFFFFF);
wnd.ptMinPosition.Y:=registry.RIntC('MinY',$FFFFFF);
wnd.ptMaxPosition.X:=registry.RIntC('MaxX',$FFFFFF);
wnd.ptMaxPosition.Y:=registry.RIntC('MaxY',$FFFFFF);
wnd.rcNormalPosition.Left:=registry.RIntC('NrmL',d_l);
wnd.rcNormalPosition.Top:=registry.RIntC('NrmT',d_t);
wnd.rcNormalPosition.Right:=registry.RIntC('NrmR',d_r);
wnd.rcNormalPosition.Bottom:=registry.RIntC('NrmB',d_b);
registry.CloseKey();
// setting data
SetWindowPlacement(form.Handle,@wnd);
end;

procedure SaveWindowPosition(form: TForm; registry: TFuturisRegistry; path: string);
begin
// saving data
registry.OpenKey(path,true);
registry.WInteger('Top',form.Top);
registry.WInteger('Left',form.Left);
registry.CloseKey();
end;

procedure RestoreWindowPosition(form: TForm; registry: TFuturisRegistry; path: string;
                                d_t, d_l: integer);
begin
// restoring data
registry.OpenKey(path,true);
form.Top:=registry.RIntC('Top',d_t);
form.Left:=registry.RIntC('Left',d_l);
registry.CloseKey();
end;

procedure SaveWindowSize(form: TForm; registry: TFuturisRegistry; path: string);
begin
// saving data
registry.OpenKey(path,true);
registry.WInteger('Width',form.Width);
registry.WInteger('Height',form.Height);
registry.CloseKey();
end;

procedure RestoreWindowSize(form: TForm; registry: TFuturisRegistry; path: string;
                            d_w, d_h: integer);
begin
// restoring data
registry.OpenKey(path,true);
form.Width:=registry.RIntC('Width',d_w);
form.Height:=registry.RIntC('Height',d_h);
registry.CloseKey();
end;

end.
