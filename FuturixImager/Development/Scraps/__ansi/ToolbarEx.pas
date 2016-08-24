unit ToolbarEx;

interface

uses
  Classes, Windows, ComCtrls, Controls, Messages;

type
  TToolButton = class(ComCtrls.TToolButton)
  private
    FWholeDropDown: boolean;
    procedure SetWholeDropDown(const Value: boolean);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property  WholeDropDown: boolean read FWholeDropDown write SetWholeDropDown default false;
  end;

  TToolBar = class(ComCtrls.TToolBar)
  private
    function  CheckBtnMsg(var Message: TMessage): boolean;
  protected
    procedure WndProc(var Message: TMessage); override;
  end;


implementation

uses
  CommCtrl, SysUtils;

constructor TToolButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWholeDropDown := false;
end;

procedure TToolButton.SetWholeDropDown(const Value: boolean);
begin
  if FWholeDropDown <> Value then
  begin
    FWholeDropDown := Value;
    RefreshControl;
  end;
end;

function TToolBar.CheckBtnMsg(var Message: TMessage): boolean;
var
  B : ToolbarEx.TToolButton;

  function CheckButton(ACtrl: TControl; var Style: Byte): boolean;
  begin
	Result := ACtrl.InheritsFrom(ToolbarEx.TToolButton);
    if Result then
    begin
      B := ToolbarEx.TToolButton(ACtrl);
      Result := B.FWholeDropDown;
      if Result and (GetComCtlVersion >= ComCtlVersionIE5) then
        Style := Style or BTNS_WHOLEDROPDOWN;
    end;
  end;

var
  BT: PTBButton;
  BI: PTBButtonInfoW;
begin
  Result := false;
  B := nil;
  if Message.Msg = TB_INSERTBUTTON then
  begin
    BT := PTBButton(Message.LParam);
    CheckButton(TControl(BT.dwData), BT.fsStyle);
  end
  else if Message.Msg = TB_SETBUTTONINFO then
  begin
    BI := PTBButtonInfoW(Message.LParam);
    CheckButton(TControl(BI.lParam), BI.fsStyle);
  end;
end;

procedure TToolBar.WndProc(var Message: TMessage);
var
  Handled : boolean;
begin
  Handled := CheckBtnMsg(Message);
  if not Handled then
    inherited WndProc(Message);
end;

end.
