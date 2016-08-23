unit fx_mru;

interface

uses
  Windows, Classes, SysUtils, Generics.Collections, Menus,
  c_const, c_reg;

type
  FuturixMRU = class(TObject)
  private
    items: TList<string>;
    connections: TList<TObject>;

    function GetItemsCount(): integer;
  public
    constructor Create();
    destructor Destroy(); override;

    procedure Update();
    procedure AddItem(document: string; do_update: boolean);
    procedure RemoveItem(document: string; do_update: boolean);
    function HasItem(document: string): boolean;
    procedure AddConnection(link: TObject; do_update: boolean);
    procedure ClearItems(do_update: boolean);
    procedure CleanUp(do_update: boolean);
    procedure EnforceLimit();
    function GetLastItem(): string;
    procedure Save();

    property Count: integer read GetItemsCount;
  end;


implementation

uses w_main, fx_defs;

constructor FuturixMRU.Create();
var
  reg: TFRegistry;
  temp: TStringList;
  str: string;
begin
  items := TList<string>.Create();
  connections := TList<TObject>.Create();

  reg := TFRegistry.Create(RA_READONLY);
  reg.RootKey := HKEY_CURRENT_USER;

  if reg.OpenKey(sSettings, false) then
    begin
    temp := TStringList.Create();
    reg.RStrings('MRU', temp);

    for str in temp do
      items.Add(str);

    EnforceLimit();
    FreeAndNil(temp);
    end;

  FreeAndNil(reg);
end;

procedure FuturixMRU.Update();
var
  link: TObject;
  str: string;
  m: TMenuItem;
begin
  for link in connections do
    begin
    if link is TMenuItem then
      begin
      // clean up
      (link as TMenuItem).Clear();

      // adding items
      for str in items do
        begin
        m := TMenuItem.Create(nil);
        m.Caption := ExtractFileName(str);
        m.Hint := str;
        m.OnClick := frmMain.mruClick;
        (link as TMenuItem).Add(m);
        end;

      // if no items available
      if (items.Count = 0) then
        begin
        m := TMenuItem.Create(nil);
        m.Caption := '(no recent files)';
        m.Enabled := false;
        (link as TMenuItem).Add(m);
        end;
      end
    else if link is TPopupMenu then
      begin
      // clean up
      (link as TPopupMenu).Items.Clear();

      // adding items
      for str in items do
        begin
        m := TMenuItem.Create(nil);
        m.Caption := ExtractFileName(str);
        m.Hint := str;
        m.OnClick := frmMain.mruClick;
        (link as TPopupMenu).Items.Add(m);
        end;

      // if no items available
      if (items.Count = 0) then
        begin
        m := TMenuItem.Create(nil);
        m.Caption := '(no recent files)';
        m.Enabled := false;
        (link as TPopupMenu).Items.Add(m);
        end;
      end;
    end;
end;

procedure FuturixMRU.AddItem(document: string; do_update: boolean);
begin
  if items.Contains(document) then
    items.Remove(document);

  items.Insert(0, document);
  EnforceLimit();

  if do_update then
    Update();
end;

procedure FuturixMRU.RemoveItem(document: string; do_update: boolean);
begin
  if items.Contains(document) then
    items.Remove(document);

  if do_update then
    Update();
end;

function FuturixMRU.HasItem(document: string): boolean;
begin
  Result := items.Contains(document);
end;

procedure FuturixMRU.AddConnection(link: TObject; do_update: boolean);
begin
  connections.Add(link);

  if do_update then
    Update();
end;

procedure FuturixMRU.ClearItems(do_update: boolean);
begin
  items.Clear();

  if do_update then
    Update();
end;

procedure FuturixMRU.CleanUp(do_update: boolean);
var
  i: integer;
begin
  for i := (items.Count - 1) downto 0 do
    if not FileExists(items[i]) then
      items.Delete(i);

  if do_update then
    Update();
end;

procedure FuturixMRU.EnforceLimit();
begin
  if (items.Count > MRU_LIMIT) then
    begin
    try
      items.DeleteRange(MRU_LIMIT, items.Count - MRU_LIMIT);
    except
    end;
    end;
end;

function FuturixMRU.GetLastItem(): string;
begin
  if (infImage.path <> '') then
    begin
    if (items.Count >= 2) then
      begin
      if FileExists(items[1]) then
        Result := items[1];
      end;
    end
  else
    begin
    if (items.Count >= 1) then
      begin
      if FileExists(items[0]) then
        Result := items[0];
      end;
    end;
end;

procedure FuturixMRU.Save();
var
  reg: TFRegistry;
  temp: TStringList;
  str: string;
begin
  reg := TFRegistry.Create(RA_FULL);
  reg.RootKey := HKEY_CURRENT_USER;

  if reg.OpenKey(sSettings, true) then
    begin
    temp := TStringList.Create();

    for str in items do
      temp.Add(str);

    reg.WStrings('MRU', temp);
    FreeAndNil(temp);
    end;

  FreeAndNil(reg);
end;

function FuturixMRU.GetItemsCount(): integer;
begin
  if Assigned(items) then
    Result := items.Count
  else
    Result := 0;
end;

destructor FuturixMRU.Destroy();
begin
  FreeAndNil(items);
  FreeAndNil(connections);

  inherited;
end;

end.
