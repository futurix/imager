// HTML help header
unit h_chm;

interface

uses
  Windows, h_win;

const
  HH_DISPLAY_TOPIC           = $0000;

function HtmlHelpW(hwndCaller: HWND; pszFile: LPCWSTR; uCommand: UINT; dwData: DWORD_PTR): HWND; stdcall;
function HtmlHelp(hwndCaller: HWND; pszFile: LPCTSTR; uCommand: UINT; dwData: DWORD_PTR): HWND; stdcall;


implementation

function HtmlHelpW; external 'hhctrl.ocx' name 'HtmlHelpW';
function HtmlHelp; external 'hhctrl.ocx' name 'HtmlHelpW';

end.
