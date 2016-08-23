unit blur;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls,
  c_const;

type
  TfrmBlur = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    gbxBlur: TGroupBox;
    trbAmount: TTrackBar;
    lblValue: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure trbAmountChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  PRGBTriple = ^TRGBTriple;
  TRGBTriple = packed record
    b: byte;
    g: byte;
    r: byte;
  end;

  PRow = ^TRow;
  TRow = array[0..1000000] of TRGBTriple;

  PPRows = ^TPRows;
  TPRows = array[0..1000000] of PRow;

const
  MaxKernelSize = 100;

type
  TKernelSize = 1..MaxKernelSize;

  TKernel = record
    Size: TKernelSize;
    Weights: array[-MaxKernelSize..MaxKernelSize] of single;
  end;

procedure MakeGaussianKernel(var K: TKernel; radius: double; MaxData, DataGranularity: double);
function TrimInt(Lower, Upper, theInteger: integer): integer;
function TrimReal(Lower, Upper: integer; x: double): integer;
procedure BlurRow(var theRow: array of TRGBTriple; K: TKernel; P: PRow);
procedure GBlur(theBitmap: TBitmap; radius: double);
function FIPISfilter(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap; stdcall;

var
  frmBlur: TfrmBlur;
  canceled: boolean = true;
  bmp: TBitmap;

implementation

{$R *.DFM}

procedure MakeGaussianKernel(var K: TKernel; radius: double; MaxData, DataGranularity: double);
var
  j: integer;
  temp, delta: double;
  KernelSize: TKernelSize;
begin
for j:= Low(K.Weights) to High(K.Weights) do
  begin
  temp:= j/radius;
  K.Weights[j]:= exp(- temp*temp/2);
  end;
temp:= 0;
for j:= Low(K.Weights) to High(K.Weights) do
  temp:= temp + K.Weights[j];
for j:= Low(K.Weights) to High(K.Weights) do
  K.Weights[j]:= K.Weights[j] / temp;

KernelSize:= MaxKernelSize;
delta:= DataGranularity / (2*MaxData);
temp:= 0;
while (temp < delta) and (KernelSize > 1) do
  begin
  temp:= temp + 2 * K.Weights[KernelSize];
  dec(KernelSize);
  end;
K.Size:= KernelSize;

temp:= 0;
for j:= -K.Size to K.Size do
  temp:= temp + K.Weights[j];
for j:= -K.Size to K.Size do
  K.Weights[j]:= K.Weights[j] / temp;
end;

function TrimInt(Lower, Upper, theInteger: integer): integer;
begin
if (theInteger <= Upper) and (theInteger >= Lower) then
  result:= theInteger
else
  if theInteger > Upper then
    result:= Upper
  else
    result:= Lower;
end;

function TrimReal(Lower, Upper: integer; x: double): integer;
begin
if (x < upper) and (x >= lower) then
  result:= trunc(x)
else
  if x > Upper then
    result:= Upper
  else
    result:= Lower;
end;

procedure BlurRow(var theRow: array of TRGBTriple; K: TKernel; P: PRow);
var
  j, n: integer;
  tr, tg, tb: double;
  w: double;
begin
for j:= 0 to High(theRow) do
  begin
  tb:= 0;
  tg:= 0;
  tr:= 0;
  for n:= -K.Size to K.Size do
    begin
    w:= K.Weights[n];
    with theRow[TrimInt(0, High(theRow), j - n)] do
      begin
      tb:= tb + w * b;
      tg:= tg + w * g;
      tr:= tr + w * r;
      end;
    end;
  with P[j] do
    begin
    b:= TrimReal(0, 255, tb);
    g:= TrimReal(0, 255, tg);
    r:= TrimReal(0, 255, tr);
    end;
  end;
Move(P[0], theRow[0], (High(theRow) + 1) * Sizeof(TRGBTriple));
end;

procedure GBlur(theBitmap: TBitmap; radius: double);
var
  Row, Col: integer;
  theRows: PPRows;
  K: TKernel;
  ACol: PRow; P:PRow;
begin
if (theBitmap.HandleType <> bmDIB) or (theBitmap.PixelFormat <> pf24Bit) then
  raise exception.Create('GBlur works only with 24-bit images');
MakeGaussianKernel(K, radius, 255, 1);
GetMem(theRows, theBitmap.Height * SizeOf(PRow));
GetMem(ACol, theBitmap.Height * SizeOf(TRGBTriple));

for Row:= 0 to theBitmap.Height - 1 do
  theRows[Row]:= theBitmap.Scanline[Row];

P:= AllocMem(theBitmap.Width*SizeOf(TRGBTriple));
for Row:= 0 to theBitmap.Height - 1 do
  BlurRow(Slice(theRows[Row]^, theBitmap.Width), K, P);

ReAllocMem(P, theBitmap.Height*SizeOf(TRGBTriple));
for Col:= 0 to theBitmap.Width - 1 do
  begin
  for Row:= 0 to theBitmap.Height - 1 do
    ACol[Row]:= theRows[Row][Col];
  BlurRow(Slice(ACol^, theBitmap.Height), K, P);
  for Row:= 0 to theBitmap.Height - 1 do
    theRows[Row][Col]:= ACol[Row];
  end;
FreeMem(theRows);
FreeMem(ACol);
ReAllocMem(P, 0);
end;

function FIPISquery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
func(PT_FFILTER,'Gaussian Blur',' ');
Result:=true;
end;

function FIPISfilter(info: PChar; preview: boolean; app, wnd: THandle; img: hBitmap):hBitmap;
var
  local_bmp: TBitmap;
begin
// tuning internals
Application.Handle:=app;
bmp:=TBitmap.Create();
bmp.Handle:=img;
bmp.PixelFormat:=pf24Bit;
local_bmp:=TBitmap.Create();

if preview then
  begin
  GBlur(bmp,(2));
  local_bmp.Assign(bmp);
  Result:=local_bmp.ReleaseHandle();
  end
else
  begin
  // displaying form
  frmBlur:=TfrmBlur.Create(Application);
  frmBlur.ShowModal();

  // sending result
  if canceled then
    Result:=0
  else
    begin
    local_bmp.Assign(bmp);
    Result:=local_bmp.ReleaseHandle();
    end;

  frmBlur.Free();
  end;

FreeAndNil(bmp);
FreeAndNil(local_bmp);
end;

procedure TfrmBlur.btnCancelClick(Sender: TObject);
begin
Close();
end;

procedure TfrmBlur.trbAmountChange(Sender: TObject);
begin
lblValue.Caption:=FloatToStr(trbAmount.Position/10);
end;

procedure TfrmBlur.btnOKClick(Sender: TObject);
begin
canceled:=false;
if trbAmount.Position=0 then
  canceled:=true
else
  GBlur(bmp,(trbAmount.Position/10));
Close();
end;

exports
  FIPISquery, FIPISfilter;

end.
