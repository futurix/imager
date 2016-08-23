library template;

{
 This is only template for plug-in.
 Remove functions you don't need.

 FIPISabout is required for all plug-ins.
}

uses SysUtils, Windows, Classes, Graphics;

{$R *.RES}

function FIPISopen(path,ext: PChar; app: THandle):hBitmap; stdcall;
begin
//
end;

function FIPISsave(path,ext: PChar; app: THandle; img: hBitmap):integer; stdcall;
begin
//
end;

function FIPISimport(info: PChar; app: THandle):hBitmap; stdcall;
begin
//
end;

function FIPISexport(info: PChar; app: THandle; img: hBitmap):integer; stdcall;
begin
//
end;

function FIPISfilter(info: PChar; app: THandle; img: hBitmap):hBitmap; stdcall;
begin
//
end;

function FIPIStool(info,path: PChar; app: THandle; img: hBitmap):hBitmap; stdcall;
begin
//
end;

function FIPISinfo(display, path, ext: PChar; app: THandle):integer; stdcall;
begin
//
end;

function FIPISanimInit(filename, ext: PChar; app: THandle):integer; stdcall;
begin
//
end;

function FIPISanimConfirm():integer; stdcall;
begin
//
end;

function FIPISanimRestart():integer; stdcall;
begin
//
end;

function FIPISanimGetFrame(var img: hBitmap; var delay: integer):integer; stdcall;
begin
//
end;

function FIPISanimDeInit():integer; stdcall;
begin
//
end;

function FIPISmultiInit(filename, ext: PChar; app: THandle):integer; stdcall;
begin
//
end;

function FIPISmultiGetPages():integer; stdcall;
begin
//
end;

function FIPISmultiGetPage(index: integer):hBitmap; stdcall;
begin
//
end;

function FIPISmultiDeInit():integer; stdcall
begin
//
end;

exports FIPISopen, FIPISsave, FIPISimport, FIPISexport,
        FIPISfilter, FIPIStool, FIPISinfo,
        FIPISanimInit, FIPISanimConfirm, FIPISanimRestart,
        FIPISanimGetFrame, FIPISanimDeInit,
        FIPISmultiInit, FIPISmultiGetPages, FIPISmultiGetPage,
        FIPISmultiDeInit;

begin
end.
