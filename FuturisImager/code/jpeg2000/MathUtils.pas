////////////////////////////////////////////////////////////////////////////////
//
// MathUtils.pas - Math functions
// ------------------------------
// Version:   2003-09-23
// Maintain:  Michael Vinther   |    mv@logicnet.dk
//
unit MathUtils;

interface

uses Windows, SysUtils, Math;

{$IFDEF SingleFloat}
type Float = Single;
const MaxFloat = MaxSingle;
{$ELSE}
type Float = Double;
const MaxFloat = MaxDouble;
{$ENDIF}

type
  PFloat = ^Float;
  TFloatArray = array[0..511] of Float;
  PFloatArray = ^TFloatArray;

  TSingleArray = array[0..255] of Single;
  PSingleArray = ^TSingleArray;

  TDoubleArray = array[0..255] of Double;
  PDoubleArray = ^TDoubleArray;

  TFloatPoint = record
                  X, Y : Float;
                end;
  TFloatPointArray = array of TFloatPoint;

  Fix = packed record // Used for typecasting in fix-point math
          Dec : Word; Int : SmallInt;
        end;

// Shuffle list
procedure ShuffleList(var List: array of Integer; Count: Integer);

// Integer "rounding"
function Ceil4(X: Integer): Integer;
function Ceil8(X: Integer): Integer;
function Ceil16(X: Integer): Integer;
function FloorInt(Value: Integer; StepSize: Integer): Integer; // Round towards zero
function RoundInt(Value: Integer; StepSize: Integer): Integer; // OPTIMIZE!

// "Differentiate" X, like diff in Matlab
procedure Diff(var X: array of Double);

// Solve system of liniar equtions, Tx = y when T is tridiagonal by simple
// Gaussian elimination.
// T(i,1)x(i-1) + T(i,2)x(i) + T(i,3)x(i+1) = y(i)
// The contents of y is replaced by the solution, x.
// Note that T is modified
type
  TTriDiagRec = record case Integer of
                   0:(Upper, Diag, Lower : Double);
                   1:(T1,T2,T3 : Double);
                end;
procedure TridiagonalSolve(var T: array of TTriDiagRec; var y: array of Double; N: Integer=0);

function InRange(A,Min,Max: Integer): Boolean;
function InRangeR(const A,Min,Max: Double): Boolean;
function ForceInRange(A,Min,Max: Integer): Integer;
function ForceInRangeR(const A,Min,Max: Double): Double;

function FloatPoint(const X,Y: Float): TFloatPoint;
function OffsetPoint(const P,Offset: TPoint): TPoint;
function LineInRect(const P1,P2: TPoint; const Rect: TRect): Boolean;

function sinc(const x: Double): Double;

implementation

{$IFDEF VER140}
uses Types;
{$ENDIF}

function sinc(const x: Double): Double;
var
  xPi : Double;
begin
  if abs(x)<1e-8 then Result:=1
  else
  begin
    xPi:=x*Pi;
    Result:=sin(xPi)/xPi;
  end;
end;

function FloatPoint(const X,Y: Float): TFloatPoint;
begin
  Result.X:=X;
  Result.Y:=Y;
end;

function OffsetPoint(const P,Offset: TPoint): TPoint;
begin
  Result.X:=P.X+Offset.X;
  Result.Y:=P.Y+Offset.Y;
end;

function LineInRect(const P1,P2: TPoint; const Rect: TRect): Boolean;
begin
  Result:=(Min(P1.Y,P2.Y)<=Rect.Bottom) and (Max(P1.Y,P2.Y)>=Rect.Top) and
          (Min(P1.X,P2.X)<=Rect.Right) and (Max(P1.X,P2.X)>=Rect.Left) and (
          ((P2.Y=P1.Y) or
           InRange(P1.X+Round((P2.X-P1.X)/(P2.Y-P1.Y)*(Rect.Top-P1.Y)),Rect.Left,Rect.Right) or
           InRange(P1.X+Round((P2.X-P1.X)/(P2.Y-P1.Y)*(Rect.Bottom-P1.Y)),Rect.Left,Rect.Right)) or
          ((P2.X=P1.X) or
           InRange(P1.Y+Round((P2.Y-P1.Y)/(P2.X-P1.X)*(Rect.Left-P1.X)),Rect.Top,Rect.Bottom) or
           InRange(P1.Y+Round((P2.Y-P1.Y)/(P2.X-P1.X)*(Rect.Right-P1.X)),Rect.Top,Rect.Bottom)));
end;

function InRange(A,Min,Max: Integer): Boolean;
begin
  Result:=(A>=Min) and (A<=Max);
end;

function InRangeR(const A,Min,Max: Double): Boolean;
begin
  Result:=(A>=Min) and (A<=Max);
end;

function ForceInRange(A,Min,Max: Integer): Integer;
begin
  Result:=A;
  if Result<Min then Result:=Min
  else if Result>Max then Result:=Max;
end;

function ForceInRangeR(const A,Min,Max: Double): Double;
begin
  Result:=A;
  if Result<Min then Result:=Min
  else if Result>Max then Result:=Max;
end;

procedure ShuffleList(var List: array of Integer; Count: Integer);
var
  I, R, T : Integer;
begin
  for I:=0 to Count-1 do
  begin
    R:=Random(Count);
    T:=List[I];
    List[I]:=List[R];
    List[R]:=T;
  end;
end;

function Ceil4(X: Integer): Integer;
begin
  Result:=(X+3) and $fffffffc;
end;

function Ceil8(X: Integer): Integer;
begin
  Result:=(X+7) and $fffffff8;
end;

function Ceil16(X: Integer): Integer;
begin
  Result:=(X+15) and $fffffff0;
end;

// Round towards zero
function FloorInt(Value: Integer; StepSize: Integer): Integer;
begin
  Result:=Value-Value mod StepSize;
end;

function RoundInt(Value: Integer; StepSize: Integer): Integer;
begin
  //Result:=FloorInt(Value+StepSize div 2,StepSize);
  Result:=Round(Value/StepSize)*StepSize;
end;

procedure TridiagonalSolve(var T: array of TTriDiagRec; var y: array of Double; N: Integer);
// Solve system of liniar equtions, Tx = y when T is tridiagonal by simple
// Gaussian elimination.
//
// T(i,1)x(i-1) + T(i,2)x(i) + T(i,3)x(i+1) = y(i)
//
// The contents of y is replaced by the solution, x.
//
// Original Matlab version by Hans Bruun Nielsen, IMM, DTU. 01.10.09 / 10.30
// (tridsolv.m)
var
  i : Integer;
  e : Double;
begin
  if n=0 then n:=Length(T);

  // Forward
  for i:=1 to n-1 do
  begin
    e:=T[i].T1/T[i-1].T2;  // Elimination factor
    T[i].T2:=T[i].T2-e*T[i-1].T3;
    y[i]:=y[i]-e*y[i-1];
  end;
  // Back
  y[n-1]:=y[n-1]/T[n-1].T2;
  for i:=n-2 downto 0 do y[i]:=(y[i]-T[i].T3*y[i+1])/T[i].T2;
end;

procedure Diff(var X: array of Double);
var
  I : Integer;
begin
  for I:=Low(X) to High(X)-1 do X[I]:=X[I+1]-X[I];
  X[High(X)]:=0;
end;

end.

