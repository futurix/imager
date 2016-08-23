// FIPIS definitions
unit fipis;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms;

type
  TFIPISopen = function(path, ext: PChar; app: THandle):hBitmap; stdcall;
  TFIPISsave = function(path, ext: PChar; app: THandle; img: hBitmap):integer; stdcall;
  TFIPISimport = function(info: PChar; app: THandle):hBitmap; stdcall;
  TFIPISexport = function(info: PChar; app: THandle; img: hBitmap):integer; stdcall;
  TFIPISfilter = function(info: PChar; app: THandle; img: hBitmap):hBitmap; stdcall;
  TFIPIStool = function(info,path: PChar; app: THandle; img: hBitmap):hBitmap; stdcall;
  TFIPISinfo = function(display, path, ext: PChar; app: THandle):integer; stdcall;
  TFIPISconfig = function(app: THandle):integer; stdcall;
  TFIPISabout = function(var name, version, descr, author, misc: PChar):integer; stdcall;
  // animation
  TFIPISanimInit = function(filename, ext: PChar; app: THandle):integer; stdcall;
  TFIPISanimConfirm = function():integer; stdcall;
  TFIPISanimRestart = function():integer; stdcall;
  TFIPISanimGetFrame = function(var img: hBitmap; var delay: integer):integer; stdcall;
  TFIPISanimDeInit = function():integer; stdcall;
  //multi-page
  TFIPISmultiInit = function(filename, ext: PChar; app: THandle):integer; stdcall;
  TFIPISmultiGetPages = function():integer; stdcall;
  TFIPISmultiGetPage = function(index: integer):hBitmap; stdcall;
  TFIPISmultiDeInit = function():integer; stdcall;
  
implementation

end.
