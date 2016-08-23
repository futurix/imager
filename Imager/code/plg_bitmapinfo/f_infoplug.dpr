library f_infoplug;

uses
  Windows, Classes, SysUtils,
  c_const;

{$R *.RES}

var
  setInfo: TDoubleCallBack;

const
  Bit1 = $01;
  Bit2 = $02;
  Bit3 = $04;
  Bit4 = $08;
  Bit5 = $10;
  Bit6 = $20;
  Bit7 = $40;
  Bit8 = $80;

type
  TArrayOfBytes = array of byte;
  PArrayOfBytes = ^TArrayOfBytes;

  TPCXHead = packed record
                Manufacturer   : Byte;      // $A0
                Version        : Byte;
                Encoding       : Byte;      //should be 1
                BitsPerPixel   : Byte;      //color depth
                Xmin, Ymin     : SmallInt;
                Xmax, Ymax     : SmallInt;  //dimensions
                Hres, Vres     : SmallInt;  //resolutions
                Palette        : Array[0..47] of Byte;
                Reserved       : Byte;
                ColorPlanes    : Byte;
                BytesPerLine   : SmallInt;
                PaletteType    : SmallInt;
                HScreenSize    : SmallInt;
                VScreenSize    : SmallInt;
                Filler         : Array[0..53] of Byte;
             end;

  TBMPHeader = packed record
                    Type_: Word;
                    FileSize: DWORD;
                    Reserved1: Word;
                    Reserved2: Word;
                    OffBits: DWORD;

                    InfoSize: DWORD;
                    Width: Longint;
                    Height: Longint;
                    Planes: Word;
                    BitsPerPixel: Word;
                    Compression: DWORD;
                    SizeImage: DWORD;
                    Hres: Longint;
                    Vres: Longint;
                    ColorsUsed: DWORD;
                    ColorsImportant: DWORD;
                end;

  TIconDirectoryEntry = packed record
                          Width,
                          Height,
                          ColorCount,
                          Reserved: Byte;
                          Planes,
                          BitCount:WORD;
                          BytesInRes,
                          ImageOffset:DWORD;
                        end;
  PIconDirectoryEntry = ^TIconDirectoryEntry;
  TIconHeader = packed record
                  Reserved,
                  Type_,
                  Count: Word;
                end;

  TTGAHeader = packed record
                 ID_Length,
                 ColorMap,
                 ImageType: Byte;
                 FirstEntry,
                 ColorMapLength: Word;
                 ColorMapEntrySize: Byte;
                 XOrigin,
                 YOrigin,
                 Width,
                 Height: Word;
                 BitsperPixel,
                 ImageDescriptor: Byte;
               end;
  TTGAFooter = packed record
                 ExtensionOffset,
                 DeveloperOffset: DWord;
                 Signature: array[0..15] of char;
                 character: char;
                 terminatur: byte;
               end;
  TTGAExtension = packed record
                    ExtensionSize: word;
                    AuthorName: String[40];
                    Comments1,
                    Comments2,
                    Comments3,
                    Comments4: String[80];
                    Month,Day,Year,
                    Hour,Minute,Second: Word;
                  end;

  TGIFHeader = packed record
                 Signuture: array[0..5] of char;
                 Width,
                 Heigth: Word;
                 Packed_,
                 BackgroundIndex,
                 PixelAspectRatio: byte;
               end;

function Empty(AFiller: array of Byte): Boolean;
var
 i : Integer;
begin
  Result := True;
  for i:=0 to length(AFiller)-1 do
    if AFiller[i] <> 0 then
       begin
        Result := False;
        Break;
       end;
end;

procedure LoadHeader(var Head : PArrayOfBytes;path :PChar;var sizevar:cardinal);
var
 tempf : TFilestream;
begin
  tempf := TFileStream.Create(path,fmOpenRead);
  try
    tempf.Read(Head^,sizevar);
    sizevar := tempf.Size;
  finally
    tempf.Free;
  end;
end;

procedure GetPCXInfo(path : PChar);
var
  header : ^TPCXHead;
  s1,s2,s3,s4,s5,s6,
  s7,s8,s9,s10,s11,
  s12,s13,s14,s15,s16,
  s17,s18 : string;
  imageWidth,imageHeight:SmallInt;
  filesize : cardinal;
begin
  New(header);
  filesize:=SizeOF(TPCXHead);
  LoadHeader(PArrayOfBytes(header),path,filesize);
  with Header^ do
    begin
      imageWidth  := (Xmax - Xmin) + 1;
      imageHeight := (Ymax - Ymin) + 1;
      if Manufacturer = $0A then
       s1 := 'Paintbrush format image'
      else
      s1 := '';
      s2 := IntToStr(Version);
      s3 := IntToStr(Encoding);
      s4 := IntToStr(BitsPerPixel);
      s5 := IntToStr(Xmin);
      s6 := IntToStr(Ymin);
      s7 := IntToStr(imageWidth);
      s8 := IntToStr(imageHeight);
      s9 := IntToStr(Hres);
      s10 := IntToStr(Vres);
      if ColorPlanes = 4 then
        s11 := 'EGA 16-bit color image'
      else
        s11 := IntToStr(ColorPlanes);
      s12 := IntToStr(BytesPerLine);
      s13 := IntToStr(PaletteType);
      s14 := IntToStr(HScreenSize);
      s15 := IntToStr(VScreenSize);
      if Empty(Filler) then
        s16 := 'Filler empty'
      else
        s16 := 'Filler not empty';
      s17 := IntToStr(BytesPerLine*imageHeight );
      s18 := IntToStr(filesize);
    end;
  Dispose(header);

  setInfo('Manufacturer',PChar(s1));
  setInfo('Version',PChar(s2));
  setInfo('Encoding',PChar(s3));
  setInfo('Bits Per Pixel',PChar(s4));
  setInfo('','');
  setInfo('Left',PChar(s5));
  setInfo('Top',PChar(s6));
  setInfo('Width',PChar(s7));
  setInfo('Height',PChar(s8));
  setInfo('','');
  setInfo('Horizintal resolution',PChar(s9));
  setInfo('Vertical resolution',PChar(s10));
  setInfo('','');
  setInfo('Color Planes',PChar(s11));
  setInfo('Bytes Per Line',PChar(s12));
  setInfo('Palette Type',PChar(s13));
  setInfo('','');
  setInfo('Horizintal screen size',PChar(s14));
  setInfo('Vertical screen size',PChar(s15));
  setInfo('','');
  setInfo('Filler',PChar(s16));
  setInfo('Image Size (bytes)',PChar(s17));
  setInfo('File Size (bytes)',PChar(s18));
end;

procedure GetBMPInfo(path : PChar);
var
  header : ^TBMPHeader;
  s1,s2,s3,s4,s5,s6,
  s7,s8,s9,s10,s11,
  s12,s13: string;
  filesize : cardinal;
begin
  New(header);
  filesize:=SizeOF(TBMPHeader);
  LoadHeader(PArrayOfBytes(header),path,filesize);
  with Header^ do
    begin
      s1 := char(Lobyte(Type_) )+char(Hibyte(Type_) );
      s2 := IntToStr(Header^.FileSize);
      case Compression of
        BI_RGB      : s3:='RGB';
        BI_RLE8     : s3:='RLE8';
        BI_RLE4     : s3:='RLE4';
        BI_BITFIELDS: s3:='BITFIELDS';
      end;
      s4 := IntToStr(BitsPerPixel);
      s5 := IntToStr(Width);
      s6 := IntToStr(Height);
      s7 := IntToStr(Hres);
      s8 := IntToStr(Vres);
      if Planes = 1 then
        s9 := '1'
      else
        s9 := IntToStr(Planes) + ' (not expected!)';
      if ColorsUsed = 0 then
        s10 := IntToStr(BitsPerPixel)
      else
        s10 := IntToStr(ColorsUsed);

      if ColorsImportant = 0 then
        s11 := 'All Colors'
      else
        s11 := IntToStr(ColorsImportant);
      if (Compression = BI_RGB) and (SizeImage = 0) then
        s12 := IntToStr(SizeImage)+' (valid)'
      else
        s12 := IntToStr(SizeImage);
      s13 := IntToStr(filesize);
    end;
  Dispose(header);

  setInfo('Type',PChar(s1));
  setInfo('File Size (from header)',PChar(s2));
  setInfo('Compression',PChar(s3));
  setInfo('Bits Per Pixel',PChar(s4));
  setInfo('','');
  setInfo('Width',PChar(s5));
  setInfo('Height',PChar(s6));
  setInfo('','');
  setInfo('Horizontal resolution (pixels per meter)',PChar(s7));
  setInfo('Vertical resolution (pixels per meter)',PChar(s8));
  setInfo('Color Planes',PChar(s9));
  setInfo('Colors Used',PChar(s10));
  setInfo('Important Colors',PChar(s11));
  setInfo('','');
  setInfo('Image Size (bytes)',PChar(s12));
  setInfo('File Size (bytes)',PChar(s13));
end;

procedure GetIconInfo(path : PChar);
var
  header : TIconHeader;
  s1,s2,s3,entersstr: string;
  filesize,i : integer;
  EnArray: array of TIconDirectoryEntry;
  tempf : TFilestream;
begin
  //Result:='';
  tempf := TFileStream.Create(path,fmOpenRead);
  try
    tempf.Read(header,SizeOF(TIconHeader));
    filesize := tempf.Size;
    SetLength(EnArray,header.Count);
    tempf.Read(EnArray[0],header.Count*SizeOF(TIconDirectoryEntry));
  finally
    tempf.Free;
  end;
  with Header do
    begin
      if type_ = 1 then
        s1 := 'Icon'
      else
        s1 := 'Type mismatch';
      s2 := IntToStr(header.Count);
      entersstr := '';

      setInfo('Type',PChar(s1));
      setInfo('Number of entries in icon directory',PChar(s2));

      for i:=0 to Count-1 do
       begin
         with EnArray[i] do
          if i=0 then
            setInfo('Entries',PChar(Format('#%d : %dx%d, %d bits, %d bytes.', [i+1,Width,Height,BitCount,BytesInRes])))
          else
            setInfo('',PChar(Format('#%d : %dx%d, %d bits, %d bytes.', [i+1,Width,Height,BitCount,BytesInRes])));
         end;
      s3 := IntToStr(filesize);
    end;


  setInfo('File Size (bytes)',PChar(s3));
end;

procedure GetTGAInfo(path : PChar);
var
  header : TTGAHeader;
  footer : TTGAFooter;
  extension : TTGAExtension;
  s0,s1,s2,s3,s4,
  s5,s6,s7,s8,s9,
  s10,s11,s12,s13,
  s14: string;
  filesize : integer;
  tempf : TFilestream;
  newversion,extended : Boolean;
begin
  tempf := TFileStream.Create(path,fmOpenRead);
  try
    tempf.Read(header,SizeOF(TTGAHeader));
    filesize := tempf.Size;

    tempf.Seek(26,soFromEnd);
    tempf.Read(footer,SizeOF(TTGAFooter));

    if footer.Signature = 'TRUEVISION-XFILE' then
      newversion := True
    else
      newversion := False;
    extended := False;
    if newversion then
      if footer.ExtensionOffset <> 0 then
        begin
          extended := True;
          tempf.Seek(footer.ExtensionOffset,soFromBeginning);
          tempf.Read(extension,SizeOf(TTGAExtension));
        end;
  finally
    tempf.Free;
  end;
  With header do
    begin
      if newversion then
        s0 := 'Truevision TGA Version 2.0'
      else
        s0 := 'Original TGA Format';

      case ImageType of
        0 : s1 := 'No Image Data Included';
        1 : s1 := 'Uncompressed, Color-mapped Image';
        2 : s1 := 'Uncompressed, True-color Image';
        3 : s1 := 'Uncompressed, Black-and-white Image';
        9 : s1 := 'Run-length encoded, Color-mapped Image';
        10 : s1 := 'Run-length encoded, True-color Image';
        11 : s1 := 'Run-length encoded, Black-and-white Image';
      end;

      s2 := IntToStr(BitsperPixel);
      s3 := IntToStr(XOrigin);
      s4 := IntToStr(YOrigin);
      s5 := IntToStr(Width);
      s6 := IntToStr(Height);
      if extended then
        with extension do
          begin
            s7 := AuthorName;
            s8 := Comments1;
            s9 := Comments2;
            s10 := Comments3;
            s11 := Comments4;
            s12 := Format('%d-%d-%d %d:%d:%d ',[Day,Month,Year,Hour,Minute,Second]);
          end;
      
      s13 := IntToStr((Width*Height*BitsperPixel) div 8);
      s14 := IntToStr(filesize);
    end;

   setInfo(PChar(s0),'');
   setInfo('Type',PChar(s1));
   setInfo('Bits per Pixel',PChar(s2));
   setInfo('','');
   setInfo('Left',PChar(s3));
   setInfo('Top',PChar(s4));
   setInfo('Width',PChar(s5));
   setInfo('Height',PChar(s6));
   setInfo('','');

   if extended then
     begin
     setInfo('Extension','');
     setInfo('Author',PChar(s7));

     if ((s8<>'') and (s9<>'') and (s10<>'') and (s11<>'')) then
       begin
       setInfo('Comments','');
       if s8<>'' then
         setInfo('',PChar(s8));
       if s9<>'' then
         setInfo('',PChar(s9));
       if s10<>'' then
         setInfo('',PChar(s10));
       if s11<>'' then
         setInfo('',PChar(s11));
       end;

     setInfo('Time stamp',PChar(s12));
     setInfo('','');
     end;

   setInfo('Image Size (bytes)',PChar(s13));
   setInfo('File Size (bytes)',PChar(s14));
end;

procedure GetGIFInfo(path : PChar);
var
  header : ^TGIFHeader;
  s1,s2,s3,s4,s5,
  s7,s6,s8: string;
  filesize, b1,b2,b3,GCTSize :cardinal;
  GCT, GCTSort: Boolean;
begin
  New(header);
  filesize:=SizeOF(TGIFHeader);
  LoadHeader(PArrayOfBytes(header),path,filesize);
  with Header^ do
    begin
      GCT := (Packed_ and Bit1) = Bit1;
      GCTSort := (Packed_ and Bit5) = Bit5;
      b1 := ((Packed_ and bit6) div bit6) shl 2;
      b2 := ((Packed_ and bit7) div bit7) shl 1;
      b3 := ((Packed_ and bit8) div bit8) shl 0;
      GCTSize := 2 shl (b1+b2+b3+1);

      s1 := Signuture;
      if GCT then
        s2 := 'Present.'
      else
        s2 := 'No Global Color Table.';
      if GCTSort then
        s3 := '(sorted)'
      else if GCT then
        s3 := '(not sorted)'
      else
        s3 := '';
      s4 := IntToStr(GCTSize);
      case PixelAspectRatio of
        0 : s5 := 'No information was given.';
        1..255 : s5 := FloatToStr( (PixelAspectRatio+15) / 64 );
      end;
      s6 := IntToStr(Width);
      s7 := IntToStr(Heigth);

      s8 := IntToStr(filesize);
    end;
  Dispose(header);

  setInfo('Version',PChar(s1));
  setInfo('Global Color Table',PChar(s2+s3));
  setInfo('Global Color Table Size (bytes)',PChar(s4));
  setInfo('Pixel Aspect Ratio',PChar(s5));
  setInfo('','');
  setInfo('Width',PChar(s6));
  setInfo('Height',PChar(s7));
  setInfo('','');
  setInfo('File Size (bytes)',PChar(s8));
end;

function FQuery(plug_path: PChar; func: TPlugInCallBack; app: HWND):BOOL; stdcall;
begin
func(PT_FINFO,'pcx',' ');
func(PT_FINFO,'bmp',' ');
func(PT_FINFO,'ico',' ');
func(PT_FINFO,'tga',' ');
func(PT_FINFO,'vst',' ');
func(PT_FINFO,'icb',' ');
func(PT_FINFO,'vda',' ');
func(PT_FINFO,'gif',' ');
Result:=true;
end;

function FInfo(path, ext: PChar; func: TDoubleCallBack; app, wnd: THandle):integer; stdcall;
var
  exten : string;
begin
  // setting function
  setInfo:=func;

  setInfo('ADD_PREBUILT_INFORMATION','');
  setInfo('','');

  exten := LowerCase(ext);
  if exten = 'pcx' then
    GetPCXInfo(path)
  else if exten = 'bmp' then
    GetBMPInfo(path)
  else if exten = 'ico' then
    GetIconInfo(path)
  else if (exten = 'tga') or
          (exten = 'vda') or
          (exten = 'vst') or
          (exten = 'icb') then
    GetTGAInfo(path)
  else if exten = 'gif' then
    GetGIFInfo(path);

  Result := 1;
end;

exports
  FQuery, FInfo;

begin
end.
