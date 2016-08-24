unit w_custtb;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ExtCtrls, c_utils, c_const, c_reg, c_locales;

type
  TfrmCustTB = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    lbxAvailable: TListBox;
    lbxBar: TListBox;
    lblAvailable: TLabel;
    btnAdd: TButton;
    btnRemove: TButton;
    btnSeparator: TButton;
    lblToolbar: TLabel;
    btnReset: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnSeparatorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure lbxAvailableDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lbxAvailableDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbxAvailableEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure lbxBarDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lbxBarDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbxBarEndDrag(Sender, Target: TObject; X, Y: Integer);
  private
    { Private declarations }
  public
    procedure FillLists(template: string = '');
  procedure SaveLists();

    procedure Localize();
  end;

var
  frmCustTB: TfrmCustTB;

  
implementation

uses f_tools, main, f_toolbar;

{$R *.dfm}

procedure TfrmCustTB.FillLists(template: string = '');
var
  left, right: TStringList;
  tmp: string;
  i, pos: integer;
begin
  if (template = '') then
       tmp := FxRegRStr('MainToolbar', sDefaultToolbar)
  else
      tmp := template;
        
  // filling right
  right := TStringList.Create();
  right.Sorted := false;
  StrSplit(tmp, ',', right);

  // setting right
  lbxBar.Clear();

  for i := 0 to (right.Count - 1) do
      lbxBar.Items.Add(ExpandSynName(right[i]));

  // filling left
  tmp := sAllButtons;

  left := TStringList.Create();
  left.Sorted := false;
  StrSplit(tmp, ',', left);

  // tuning left
  for i := 0 to (right.Count - 1) do
       begin
        pos := left.IndexOf(right[i]);

        if (pos <> -1) then
          left.Delete(left.IndexOf(right[i]));
        end;

  // setting left
  lbxAvailable.Clear();

  for i:=0 to (left.Count - 1) do
      lbxAvailable.Items.Add(ExpandSynName(left[i]));

    // freeing
  FreeAndNil(right);
  FreeAndNil(left);
end;

procedure TfrmCustTB.SaveLists();
var
  i: integer;
  tmp: string;
begin
  if (lbxBar.Count > 0) then
      begin
       // deleting empty items (just for safety)
       for i := 0 to (lbxBar.Count - 1) do
           if (lbxBar.Items[i] = '') then
              lbxBar.Items.Delete(i);

       // making string
       tmp := '';

       for i := 0 to (lbxBar.Count - 2) do
           tmp := tmp + CollapseSynName(lbxBar.Items[i]) + ',';

       tmp := tmp + CollapseSynName(lbxBar.Items[lbxBar.Count - 1]);

       // saving
       FxRegWStr('MainToolbar', tmp);
       end;
end;

procedure TfrmCustTB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmCustTB.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then
      Close();
end;

procedure TfrmCustTB.btnCancelClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmCustTB.btnOKClick(Sender: TObject);
begin
  SaveLists();
  Close();
    
  ApplyCustomToolbar(true);
end;

procedure TfrmCustTB.btnSeparatorClick(Sender: TObject);
begin
  if (lbxBar.ItemIndex <> -1) then
       lbxBar.Items.Insert(lbxBar.ItemIndex, LoadLStr(3502))
  else
      lbxBar.Items.Insert(lbxBar.Count - 1, LoadLStr(3502));
end;

procedure TfrmCustTB.FormCreate(Sender: TObject);
begin
    Localize();

  FillLists();
end;

procedure TfrmCustTB.btnAddClick(Sender: TObject);
begin
    if (lbxAvailable.ItemIndex <> -1) then
      begin
    if (lbxBar.ItemIndex <> -1) then
         begin
         lbxBar.Items.Insert(lbxBar.ItemIndex, lbxAvailable.Items[lbxAvailable.ItemIndex]);
         lbxAvailable.Items.Delete(lbxAvailable.ItemIndex);
         end
        else
          begin
         lbxBar.Items.Insert(lbxBar.Count - 1, lbxAvailable.Items[lbxAvailable.ItemIndex]);
         lbxAvailable.Items.Delete(lbxAvailable.ItemIndex);
            end;
        end;
end;

procedure TfrmCustTB.btnRemoveClick(Sender: TObject);
begin
  if ((lbxBar.ItemIndex <> -1) and (lbxBar.Items[lbxBar.ItemIndex] <> LoadLStr(3502)) and (lbxBar.Items[lbxBar.ItemIndex] <> '')) then
       begin
       lbxAvailable.Items.Add(lbxBar.Items[lbxBar.ItemIndex]);
       lbxBar.Items.Delete(lbxBar.ItemIndex);
       end
  else
      if ((lbxBar.ItemIndex <> -1) and (lbxBar.Items[lbxBar.ItemIndex] = LoadLStr(3502))) then
          lbxBar.Items.Delete(lbxBar.ItemIndex);
end;

procedure TfrmCustTB.FormDestroy(Sender: TObject);
begin
  frmCustTB := nil;
end;

procedure TfrmCustTB.Localize();
begin
    Self.Caption       := LoadLStr(3503);

    lblAvailable.Caption  := LoadLStr(3504);
    lblToolbar.Caption    := LoadLStr(3505);
    btnAdd.Caption      := LoadLStr(3506);
    btnRemove.Caption    := LoadLStr(3507);
    btnSeparator.Caption  := LoadLStr(3502);
    btnReset.Caption    := LoadLStr(3508);

    btnOK.Caption      := LoadLStr(50);
    btnCancel.Caption    := LoadLStr(51);
end;

procedure TfrmCustTB.btnResetClick(Sender: TObject);
begin
  FillLists(sDefaultToolbar);
end;

procedure TfrmCustTB.lbxAvailableDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  i: integer;
begin
    if ((Source is TListBox) and (TListBox(Source).Name = lbxBar.Name) and (lbxBar.ItemIndex <> -1)) then
      begin
        i := lbxAvailable.ItemAtPos(Point(X, Y), true);

        if (lbxBar.Items.Strings[lbxBar.ItemIndex] <> LoadLStr(3502)) then
            begin
            if (i = -1) then
            lbxAvailable.Items.Add(lbxBar.Items.Strings[lbxBar.ItemIndex])
            else
                lbxAvailable.Items.Insert(i, lbxBar.Items.Strings[lbxBar.ItemIndex]);
            end;

        lbxBar.Items.Delete(lbxBar.ItemIndex);
        end;
end;

procedure TfrmCustTB.lbxAvailableDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := ((Source is TListBox) and (TListBox(Source).Name = lbxBar.Name));
end;

procedure TfrmCustTB.lbxAvailableEndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  //
end;

procedure TfrmCustTB.lbxBarDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  i: integer;
    s: string;
begin
    if ((Source is TListBox) and (TListBox(Source).ItemIndex <> -1)) then
      begin
        i := lbxBar.ItemAtPos(Point(X, Y), true);
        s := TListBox(Source).Items.Strings[TListBox(Source).ItemIndex];

        TListBox(Source).Items.Delete(TListBox(Source).ItemIndex);

        if (i = -1) then
          lbxBar.Items.Add(s)
        else
          lbxBar.Items.Insert(i, s);
        end;
end;

procedure TfrmCustTB.lbxBarDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source is TListBox);
end;

procedure TfrmCustTB.lbxBarEndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  //
end;

end.
