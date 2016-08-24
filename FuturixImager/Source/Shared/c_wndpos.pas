unit c_wndpos;

interface

uses
  Windows, Messages, SysUtils, Forms,
  c_reg, c_const;

type
  PForm = ^TForm;

procedure SaveWindowState(form: PForm; path: string; prefix: string = '');
procedure RestoreWindowState(form: PForm; path: string; d_left, d_right, d_top, d_bottom: integer; d_flags: integer = 0; d_showcmd: integer = SW_SHOWNORMAL; prefix: string = '');
procedure SaveWindowPosition(form: PForm; path: string; prefix: string = '');
procedure RestoreWindowPosition(form: PForm; path: string; d_top, d_left: integer; prefix: string = '');
procedure SaveWindowSize(form: PForm; path: string; prefix: string = '');
procedure RestoreWindowSize(form: PForm; path: string; d_width, d_height: integer; prefix: string = '');


implementation

procedure SaveWindowState(form: PForm; path: string; prefix: string = '');
var
  wnd: TWindowPlacement;
  registry: TFRegistry;
begin
  registry := TFRegistry.Create(RA_FULL);
  registry.RootKey := HKEY_CURRENT_USER;

  // getting data
  wnd.length := SizeOf(wnd);
  GetWindowPlacement(form.Handle, @wnd);

  // saving data
  if registry.OpenKey(path, true) then
    begin
    registry.WBin(prefix + 'Data', wnd, sizeof(wnd));

    registry.CloseKey();
    end;

  FreeAndNil(registry);
end;

procedure RestoreWindowState(form: PForm; path: string; d_left, d_right, d_top, d_bottom: integer; d_flags: integer = 0; d_showcmd: integer = SW_SHOWNORMAL; prefix: string = '');
var
  wnd: TWindowPlacement;
  registry: TFRegistry;
begin
  registry := TFRegistry.Create(RA_READONLY);
  registry.RootKey := HKEY_CURRENT_USER;

  // setting defaults
  wnd.length := SizeOf(wnd);
  wnd.flags := registry.RInt(prefix + 'Flags', d_flags);
  wnd.showCmd := registry.RInt(prefix + 'ShowCmd', d_showcmd);
  wnd.ptMinPosition.X := registry.RInt(prefix + 'MinX', $FFFFFF);
  wnd.ptMinPosition.Y := registry.RInt(prefix + 'MinY', $FFFFFF);
  wnd.ptMaxPosition.X := registry.RInt(prefix + 'MaxX', $FFFFFF);
  wnd.ptMaxPosition.Y := registry.RInt(prefix + 'MaxY', $FFFFFF);
  wnd.rcNormalPosition.Left := registry.RInt(prefix + 'NrmL', d_left);
  wnd.rcNormalPosition.Top := registry.RInt(prefix + 'NrmT', d_top);
  wnd.rcNormalPosition.Right := registry.RInt(prefix + 'NrmR', d_right);
  wnd.rcNormalPosition.Bottom := registry.RInt(prefix + 'NrmB', d_bottom);

  // restoring data
  if registry.OpenKey(path, false) then
    begin
    registry.RBin(prefix + 'Data', wnd, sizeof(wnd));

    registry.CloseKey();
    end;

  SetWindowPlacement(form.Handle, @wnd);

  FreeAndNil(registry);
end;

procedure SaveWindowPosition(form: PForm; path: string; prefix: string = '');
var
  registry: TFRegistry;
begin
  registry := TFRegistry.Create(RA_FULL);
  registry.RootKey := HKEY_CURRENT_USER;

  // saving data
  if registry.OpenKey(path, true) then
    begin
    registry.WInteger(prefix + 'Top', form.Top);
    registry.WInteger(prefix + 'Left', form.Left);

    registry.CloseKey();
    end;

  FreeAndNil(registry);
end;

procedure RestoreWindowPosition(form: PForm; path: string; d_top, d_left: integer; prefix: string = '');
var
  registry: TFRegistry;
  left, top: integer;
begin
  registry := TFRegistry.Create(RA_READONLY);
  registry.RootKey := HKEY_CURRENT_USER;

  // setting defaults
  left := d_left;
  top := d_top;

  // restoring data
  if registry.OpenKey(path, false) then
    begin
    left := registry.RInt(prefix + 'Left', d_left);
    top := registry.RInt(prefix + 'Top', d_top);

    registry.CloseKey();
    end;

  form.SetBounds(left, top, form.Width, form.Height);

  FreeAndNil(registry);
end;

procedure SaveWindowSize(form: PForm; path: string; prefix: string = '');
var
  registry: TFRegistry;
begin
  registry := TFRegistry.Create(RA_FULL);
  registry.RootKey := HKEY_CURRENT_USER;

  // saving data
  if registry.OpenKey(path, true) then
    begin
    registry.WInteger(prefix + 'Width', form.Width);
    registry.WInteger(prefix + 'Height', form.Height);

    registry.CloseKey();
    end;

  FreeAndNil(registry);
end;

procedure RestoreWindowSize(form: PForm; path: string; d_width, d_height: integer; prefix: string = '');
var
  registry: TFRegistry;
  width, height: integer;
begin
  registry := TFRegistry.Create(RA_READONLY);
  registry.RootKey := HKEY_CURRENT_USER;

  // setting defaults
  width := d_width;
  height := d_height;

  // restoring data
  if registry.OpenKey(path, false) then
    begin
    width := registry.RInt(prefix + 'Width', d_width);
    height := registry.RInt(prefix + 'Height', d_height);

    registry.CloseKey();
    end;

  form.SetBounds(form.Left, form.Top, width, height);

  FreeAndNil(registry);
end;

end.
