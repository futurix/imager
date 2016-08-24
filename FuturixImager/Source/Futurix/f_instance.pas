unit f_instance;

interface

uses
  Windows, Messages, SysUtils, Classes,
  c_const, c_utils, c_reg;

const
  MAIN_FORM_CLASS             = 'TfrmMain';

  UM_APP_ID_CHECK             = WM_APP + 161;
  UM_RESTORE_APPLICATION      = WM_APP + 162;
  UM_PREVIOUS_INST_PARAMS     = WM_APP + 163;

  APP_ID                      = 178361;

var
  hPrevious: THandle;
  aAtom: TAtom;
  sParams: string;

function EnumWindowsFunc(Handle: HWND; Param: LParam): boolean; stdcall;
procedure PassParamsToPreviousInstance();
procedure CheckPreviousInstance();


implementation

function EnumWindowsFunc(Handle: HWND; Param: LParam): boolean;

  function IsAPrevInstanceRunning: boolean;
  var
    ClassName: array[0..30] of WideChar;
    iAppID: integer;
  begin
    GetClassName(Handle, ClassName, 30);
    iAppID := SendMessage(Handle, UM_APP_ID_CHECK, 0, 0);

    Result := (StrIComp(ClassName, MAIN_FORM_CLASS) = 0) and (iAppID = APP_ID);
  end;

begin
  Result := not IsAPrevInstanceRunning;

  if not Result then
    hPrevious := Handle;
end;

procedure PassParamsToPreviousInstance();
begin
  PostMessage(hPrevious, UM_RESTORE_APPLICATION, 0, 0);
    
  if (sParams <> '') then
    begin
    aAtom := GlobalAddAtom(PWideChar(sParams));

    if (aAtom <> 0) then
      begin
      SendMessage(hPrevious, UM_PREVIOUS_INST_PARAMS, aAtom, 0);
      GlobalDeleteAtom(aAtom);
      end;
    end;
end;

procedure CheckPreviousInstance();
var
  bDoIt: boolean;
begin
  bDoIt := FxRegRBool('OneInstanceOnly', false);

  if bDoIt then
    begin
    EnumWindows(@EnumWindowsFunc, 0);

    if (ParamCount() > 0) then
      begin
      if (FileExists(ParamStr(1))) then
        begin
        sParams := ParamStr(1);
        end
      else
        begin
        if (ParamCount() > 1) then
          begin
          if (FileExists(ParamStr(2))) then
            sParams := ParamStr(2);
          end;
        end;
      end;
    end;
end;

end.
