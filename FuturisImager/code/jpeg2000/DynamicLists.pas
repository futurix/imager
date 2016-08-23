////////////////////////////////////////////////////////////////////////////////
//
// DynamicLists.pas - Dynamic list class
// -------------------------------------
// Version:   2003-09-20
// Maintain:  Michael Vinther  |  mv@logicnet.dk
//
// Last changes:
//   Move implemented
//
// Suggested improvements:
//
unit DynamicLists;

interface

uses Windows, SysUtils, Monitor, Streams, StreamUtils, MemUtils, SortUtils;

type
  TDynamicList = class(TStreamClass)
    private
      FMirrorPointer : ^Pointer;
      FListSize : Integer;
      FRecordSize : Integer;
      procedure SetListSize(NewSize: Integer);
      procedure SetCount(NewCount: Integer);
    protected
      FData : PByteArray;
      FCount : Integer;
      property ListSize: Integer read FListSize write SetListSize;
    public
      // FListSize increase in IncCount when list too small <1 mean double
      GrowBy : Integer;

      constructor Create(RecordSize: Integer; var MirrorPointer);
      destructor Destroy; override;

      procedure Assign(Other: TObject); override;
      procedure Append(Next: TDynamicList);
      procedure Clear; virtual;
      procedure Move(Index,NewIndex: Integer);
      // Delete Index and preserve list order
      procedure Delete(Index: Integer);
      // Delete Index, list order can be changed
      procedure FastDelete(Index: Integer);

      procedure SaveToStream(Stream: TBaseStream); override;
      procedure LoadFromStream(Stream: TBaseStream); override;

      property RecordSize: Integer read FRecordSize;
      property Count: Integer read FCount write SetCount;

      // Increase count by 1
      procedure IncCount;
      function Next: Integer;
      // Fill data with zeros
      procedure Zero;
      // Optimize memory use
      procedure Optimize;
    end;

  TObjectArray = array [0..0] of TObject;
  PObjectArray = ^TObjectArray;

  TDynamicObjectList = class(TDynamicList)
    protected
      // If true, objects are freed on delete and destroy
      OwnsObjects : Boolean;
    public
      constructor Create(var MirrorPointer);

      procedure Clear; override;
      function Add(NewObject: TObject): Integer;
      function AddUnique(NewObject: TObject): Integer;
      procedure Insert(Index: Integer; NewObject: TObject);
      function IndexOf(Obj: TObject): Integer; virtual;
      // Delete object and preserve list order
      procedure Delete(Index: Integer);
      // Delete object but does preserve list order
      procedure FastDelete(Index: Integer);
      procedure Remove(Obj: TObject);
      procedure FastRemove(Obj: TObject);
    end;

  // Sorted object list to enable binary search for fast IndexOf
  TSortedObjectList = class(TDynamicObjectList)
    protected
      GroupAdd : Boolean;
      procedure Sort;
      function Find(Obj: TObject; out Index: Integer): Boolean;
    public
      function Add(NewObject: TObject): Integer;
      function AddUnique(NewObject: TObject): Integer;
      function IndexOf(Obj: TObject): Integer; override;

      // Call before adding many objects to postpone the sorting
      procedure BeginGroupAdd;
    end;

  TPointerArray = array[0..0] of Pointer;
  PPointerArray = ^TPointerArray;

  TDynamicPointerList = class(TDynamicList)
    protected
      // If true, objects are freed on clear and destroy
      OwnsObjects : Boolean;
    public
      constructor Create(var MirrorPointer);
      procedure Clear; override;

      function Add(NewData: Pointer): Integer;
    end;

implementation

//=====================================================================================================
// TDynamicList
//=====================================================================================================
constructor TDynamicList.Create(RecordSize: Integer; var MirrorPointer);
begin
  inherited Create;
  FRecordSize:=RecordSize;
  FMirrorPointer:=@MirrorPointer;
end;

destructor TDynamicList.Destroy;
begin
  Clear;
  inherited;
end;

procedure TDynamicList.SetListSize(NewSize: Integer);
begin
  Assert(FCount<=FListSize); // Fail if not FCount<=FListSize
  if NewSize<>FListSize then
  begin
    FListSize:=NewSize;
    ReallocMem(FData,NewSize*FRecordSize);
    FMirrorPointer^:=FData;
    if NewSize<FCount then FCount:=NewSize;
  end;
end;

procedure TDynamicList.SetCount(NewCount: Integer);
begin
  if NewCount>ListSize then ListSize:=NewCount;
  FCount:=NewCount;
end;

procedure TDynamicList.SaveToStream(Stream: TBaseStream);
begin
  Stream.Write(FCount,4);
  Stream.Write(FData^,FCount*FRecordSize);
end;

procedure TDynamicList.LoadFromStream(Stream: TBaseStream);
var
  ACount : Integer;
begin
  ListSize:=0;
  Stream.Read(ACount,4);
  Count:=ACount;
  Stream.Read(FData^,ACount*FRecordSize);
end;

procedure TDynamicList.Assign(Other: TObject);
begin
  if Other is TDynamicList then
  begin
    Assert(TDynamicList(Other).FRecordSize=FRecordSize);
    Clear;
    ListSize:=TDynamicList(Other).Count;
    FCount:=ListSize;
    System.Move(TDynamicList(Other).FData^,FData^,Count*FRecordSize);
  end
  else inherited;
end;

procedure TDynamicList.Append(Next: TDynamicList);
var
  NewStart : Integer;
begin
  NewStart:=Count;
  Count:=Count+Next.Count;
  System.Move(Next.FData^,FData^[NewStart*FRecordSize],Next.Count*FRecordSize);
end;

procedure TDynamicList.Clear;
begin
  ListSize:=0;
end;

procedure TDynamicList.IncCount;
begin
  if FCount>=ListSize then
  begin
    if (ListSize=0) and (GrowBy=0) then ListSize:=16
    else if GrowBy>0 then ListSize:=ListSize+GrowBy
    else ListSize:=ListSize*2;
  end;
  Inc(FCount);
end;

function TDynamicList.Next: Integer;
begin
  Result:=FCount;
  if FCount>=ListSize then
  begin
    if (ListSize=0) and (GrowBy=0) then ListSize:=16
    else if GrowBy>0 then ListSize:=ListSize+GrowBy
    else ListSize:=ListSize*2;
  end;
  Inc(FCount);
end;

procedure TDynamicList.Zero;
begin
  ZeroMem(FData^,Count*FRecordSize);
end;

procedure TDynamicList.Optimize;
begin
  ListSize:=Count;
end;

procedure TDynamicList.Move(Index,NewIndex: Integer);
var
  Temp : Pointer;
begin
  Assert((Index>=0) and (Index<Count));
  Assert((NewIndex>=0) and (NewIndex<Count));
  if Index<>NewIndex then
  begin
    if FRecordSize=4 then Temp:=Pointer(PIntegerArray(FData)^[Index])
    else
    begin
      Assert(False,ClassName+': Not implemented');
      Temp:=nil;
    end;

    if NewIndex<Index then System.Move(FData^[NewIndex*FRecordSize],FData^[(NewIndex+1)*FRecordSize],(Index-NewIndex)*FRecordSize)
    else System.Move(FData^[(Index+1)*FRecordSize],FData^[Index*FRecordSize],(NewIndex-Index)*FRecordSize);

    if FRecordSize=4 then Pointer(PIntegerArray(FData)^[NewIndex]):=Temp
    else Assert(False);
  end;
end;

procedure TDynamicList.Delete(Index: Integer);
begin
  Assert((Index>=0) and (Index<Count));
  Dec(FCount);
  System.Move(FData^[(Index+1)*FRecordSize],FData^[Index*FRecordSize],(Count-Index)*FRecordSize);
end;

procedure TDynamicList.FastDelete(Index: Integer);
begin
  Assert((Index>=0) and (Index<Count));
  Dec(FCount);
  System.Move(FData^[FCount*FRecordSize],FData^[Index*FRecordSize],FRecordSize);
end;

//=====================================================================================================
// TDynamicObjectList
//=====================================================================================================
constructor TDynamicObjectList.Create(var MirrorPointer);
begin
  inherited Create(SizeOf(Pointer),MirrorPointer);
  OwnsObjects:=True;
end;

procedure TDynamicObjectList.Clear;
var I : Integer;
begin
  if OwnsObjects then for I:=0 to Count-1 do PObjectArray(FData)^[I].Free;
  inherited;
end;

function TDynamicObjectList.Add(NewObject: TObject): Integer;
begin
  Result:=Count;
  IncCount;
  PObjectArray(FData)^[Result]:=NewObject;
end;

function TDynamicObjectList.AddUnique(NewObject: TObject): Integer;
begin
  Result:=IndexOf(NewObject);
  if Result=-1 then Result:=Add(NewObject);
end;

function TDynamicObjectList.IndexOf(Obj: TObject): Integer;
var I : Integer;
begin
  Result:=-1;
  for I:=0 to Count-1 do if PObjectArray(FData)^[I]=Obj then
  begin
    Result:=I;
    Break;
  end;
end;

procedure TDynamicObjectList.Insert(Index: Integer; NewObject: TObject);
begin
  IncCount;
  System.Move(PObjectArray(FData)^[Index],PObjectArray(FData)^[Index+1],(FCount-1-Index)*4);
  PObjectArray(FData)^[Index]:=NewObject;
end;

procedure TDynamicObjectList.Delete(Index: Integer);
begin
  Assert(Index<>-1);
  if OwnsObjects then PObjectArray(FData)^[Index].Free;
  Dec(FCount);
  System.Move(FData^[(Index+1)*FRecordSize],FData^[Index*FRecordSize],(Count-Index)*FRecordSize);
end;

procedure TDynamicObjectList.FastDelete(Index: Integer);
begin
  Assert(Index<>-1);
  if OwnsObjects then PObjectArray(FData)^[Index].Free;
  Dec(FCount);
  PObjectArray(FData)^[Index]:=PObjectArray(FData)^[FCount];
end;

procedure TDynamicObjectList.Remove(Obj: TObject);
begin
  Delete(IndexOf(Obj));
end;

procedure TDynamicObjectList.FastRemove(Obj: TObject);
begin
  FastDelete(IndexOf(Obj));
end;

//=====================================================================================================
// TSortedObjectList
//=====================================================================================================

function TSortedObjectList.Find(Obj: TObject; out Index: Integer): Boolean;
var
  L, H, I : Integer;
begin
  if GroupAdd then Sort;
  Result:=False;
  L := 0;
  H := FCount - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    if DWord(PObjectArray(FData)^[I])<DWord(Obj) then L := I + 1 else
    begin
      H := I - 1;
      if PObjectArray(FData)^[I]=Obj then
      begin
        Result := True;
        L := I; // Correct?
      end;
    end;
  end;
  Index := L;
end;

procedure TSortedObjectList.BeginGroupAdd;
begin
  GroupAdd:=True;
end;

procedure TSortedObjectList.Sort;
begin
  GroupAdd:=False;
  QuickSortDWord(PDWordArray(FData)^,0,Count-1);
end;

function TSortedObjectList.Add(NewObject: TObject): Integer;
begin
  if GroupAdd then Result:=inherited Add(NewObject)
  else
  begin
    Find(NewObject,Result);
    Insert(Result,NewObject);
  end;
end;

function TSortedObjectList.AddUnique(NewObject: TObject): Integer;
begin
  if not Find(NewObject,Result) then Insert(Result,NewObject);
end;

function TSortedObjectList.IndexOf(Obj: TObject): Integer;
begin
  if not Find(Obj,Result) then Result:=-1;
end;

//=====================================================================================================
// TDynamicPointerList
//=====================================================================================================
constructor TDynamicPointerList.Create(var MirrorPointer);
begin
  inherited Create(SizeOf(Pointer),MirrorPointer);
  OwnsObjects:=True;
end;

procedure TDynamicPointerList.Clear;
var I : Integer;
begin
  if OwnsObjects then for I:=0 to Count-1 do FreeMem(PPointerArray(FData)^[I]);
  inherited;
end;

function TDynamicPointerList.Add(NewData: Pointer): Integer;
begin
  Result:=Count;
  IncCount;
  PPointerArray(FData)^[Result]:=NewData;
end;

end.

