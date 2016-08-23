// NT specific stuff
unit h_nt;

interface

uses
  Messages, SysUtils, Windows;

function CheckTokenMembership(TokenHandle: THandle; SidToCheck: PSID; var IsMember: BOOL): BOOL; stdcall;


implementation

function CheckTokenMembership; external 'advapi32.dll' name 'CheckTokenMembership';

end.
