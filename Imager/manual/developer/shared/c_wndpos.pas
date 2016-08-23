// functions for window position saving/restoring 
unit c_wndpos;

interface

uses Windows, Messages, SysUtils, Forms, c_reg, c_const;

type
  PForm = ^TForm;

procedure SaveWindowState(form: PForm; path: string; prefix: string = '');
procedure RestoreWindowState(form: PForm; path: string; d_l, d_r, d_t, d_b, d_f, d_s: integer; prefix: string = '');
procedure SaveWindowPosition(form: PForm; path: string; prefix: string = '');
procedure RestoreWindowPosition(form: PForm; path: string; d_t, d_l: integer; prefix: string = '');
procedure SaveWindowSize(form: PForm; path: string; prefix: string = '');
procedure RestoreWindowSize(form: PForm; path: string; d_w, d_h: integer; prefix: string = '');


implementation

procedure SaveWindowState(form: PForm; path: string; prefix: string = '');
var
	wnd: TWindowPlacement;
    registry: TFRegistry;
begin
    registry := TFRegistry.Create(RA_FULL);
    registry.RootKey := HKEY_CURRENT_USER;

	// getting data
	wnd.length:=SizeOf(wnd);
	GetWindowPlacement(form.Handle, @wnd);

	// saving data
	if registry.OpenKey(path, true) then
    	begin
		registry.WInteger(prefix + 'Flags', wnd.flags);
		registry.WInteger(prefix + 'ShowCmd', wnd.showCmd);
		registry.WInteger(prefix + 'MinX', wnd.ptMinPosition.X);
		registry.WInteger(prefix + 'MinY', wnd.ptMinPosition.Y);
		registry.WInteger(prefix + 'MaxX', wnd.ptMaxPosition.X);
		registry.WInteger(prefix + 'MaxY', wnd.ptMaxPosition.Y);
		registry.WInteger(prefix + 'NrmL', wnd.rcNormalPosition.Left);
		registry.WInteger(prefix + 'NrmT', wnd.rcNormalPosition.Top);
		registry.WInteger(prefix + 'NrmR', wnd.rcNormalPosition.Right);
		registry.WInteger(prefix + 'NrmB', wnd.rcNormalPosition.Bottom);
		registry.CloseKey();
    	end;

    FreeAndNil(registry);
end;

procedure RestoreWindowState(form: PForm; path: string; d_l, d_r, d_t, d_b, d_f, d_s: integer; prefix: string = '');
var
	wnd: TWindowPlacement;
    registry: TFRegistry;
begin
    registry := TFRegistry.Create(RA_READONLY);
    registry.RootKey := HKEY_CURRENT_USER;

	// restoring data
	if registry.OpenKey(path, true) then
        begin
		wnd.length := SizeOf(wnd);
		wnd.flags := registry.RInt(prefix + 'Flags', d_f);
		wnd.showCmd := registry.RInt(prefix + 'ShowCmd', d_s);
		wnd.ptMinPosition.X := registry.RInt(prefix + 'MinX', $FFFFFF);
		wnd.ptMinPosition.Y := registry.RInt(prefix + 'MinY', $FFFFFF);
		wnd.ptMaxPosition.X := registry.RInt(prefix + 'MaxX', $FFFFFF);
		wnd.ptMaxPosition.Y := registry.RInt(prefix + 'MaxY', $FFFFFF);
		wnd.rcNormalPosition.Left := registry.RInt(prefix + 'NrmL', d_l);
		wnd.rcNormalPosition.Top := registry.RInt(prefix + 'NrmT', d_t);
		wnd.rcNormalPosition.Right := registry.RInt(prefix + 'NrmR', d_r);
		wnd.rcNormalPosition.Bottom := registry.RInt(prefix + 'NrmB', d_b);
		registry.CloseKey();
        end;

	// setting data
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

procedure RestoreWindowPosition(form: PForm; path: string; d_t, d_l: integer; prefix: string = '');
var
	registry: TFRegistry;
begin
    registry := TFRegistry.Create(RA_READONLY);
    registry.RootKey := HKEY_CURRENT_USER;

	// restoring data
	if registry.OpenKey(path, true) then
    	begin
        form.SetBounds(registry.RInt(prefix + 'Left', d_l), registry.RInt(prefix + 'Top', d_t), form.Width, form.Height);
		registry.CloseKey();
        end;

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

procedure RestoreWindowSize(form: PForm; path: string; d_w, d_h: integer; prefix: string = '');
var
	registry: TFRegistry;
begin
    registry := TFRegistry.Create(RA_READONLY);
    registry.RootKey := HKEY_CURRENT_USER;

	// restoring data
	if registry.OpenKey(path, true) then
    	begin
        form.SetBounds(form.Left, form.Top, registry.RInt(prefix + 'Width', d_w), registry.RInt(prefix + 'Height', d_h));
		registry.CloseKey();
        end;

    FreeAndNil(registry);
end;

end.
