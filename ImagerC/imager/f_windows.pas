// forms manipulation routines
unit f_windows;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms;

procedure SaveFormPosition(form: TForm; path: string);
procedure LoadFormPosition(form: TForm; path: string; def_width: integer = 640; def_height: integer = 400; def_top: integer = 40; def_left: integer = 0; def_state: integer = 0);
procedure SaveFormPosOnly(form: TForm; path: string);
procedure LoadFormPosOnly(form: TForm; path: string; def_top: integer = 40; def_left: integer = 45);

implementation

uses globals, f_reg;

// saves form position to registry
procedure SaveFormPosition(form: TForm; path: string);
begin
reg.OpenKey(path,true);
reg.WriteInteger('Top',form.Top);
reg.WriteInteger('Left',form.Left);
reg.WriteInteger('Width',form.Width);
reg.WriteInteger('Height',form.Height);
if form.WindowState=wsMaximized then reg.WriteInteger('State',1)
  else reg.WriteInteger('State',0);
reg.CloseKey();
end;

// loads form position from registry
procedure LoadFormPosition(form: TForm; path: string; def_width: integer = 640; def_height: integer = 400; def_top: integer = 40; def_left: integer = 0; def_state: integer = 0);
begin
reg.OpenKey(path,true);
form.Top:=RegReadInt('Top',def_top);
form.Left:=RegReadInt('Left',def_left);
form.Width:=RegReadInt('Width',def_width);
form.Height:=RegReadInt('Height',def_height);
case RegReadInt('State',def_state) of
  1: form.WindowState:=wsMaximized;
  0: form.WindowState:=wsNormal;
  end;
reg.CloseKey();
end;

// saves form position-only to registry
procedure SaveFormPosOnly(form: TForm; path: string);
begin
reg.OpenKey(path,true);
reg.WriteInteger('Top',form.Top);
reg.WriteInteger('Left',form.Left);
reg.CloseKey();
end;

// loads form position-only from ini file
procedure LoadFormPosOnly(form: TForm; path: string; def_top: integer = 40; def_left: integer = 45);
begin
reg.OpenKey(path,true);
form.Top:=RegReadInt('Top',def_top);
form.Left:=RegReadInt('Left',def_left);
reg.CloseKey();
end;

end.
