library fxmoreinfo;

uses
  Windows, Classes, SysUtils, c_const, c_locales;

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
       s1 := LoadLStr(3130)
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
        s11 := LoadLStr(3131)
      else
        s11 := IntToStr(ColorPlanes);
      s12 := IntToStr(BytesPerLine);
      s13 := IntToStr(PaletteType);
      s14 := IntToStr(HScreenSize);
      s15 := IntToStr(VScreenSize);
      if Empty(Filler) then
        s16 := LoadLStr(3132)
      else
        s16 := LoadLStr(3133);
      s17 := IntToStr(BytesPerLine*imageHeight );
      s18 := IntToStr(filesize);
    end;
  Dispose(header);

  setInfo(PChar(LoadLStr(3134)),PChar(s1));
  setInfo(PChar(LoadLStr(3135)),PChar(s2));
  setInfo(PChar(LoadLStr(3136)),PChar(s3));
  setInfo(PChar(LoadLStr(3137)),PChar(s4));
  setInfo('','');
  setInfo(PChar(LoadLStr(3138)),PChar(s5));
  setInfo(PChar(LoadLStr(3139)),PChar(s6));
  setInfo(PChar(LoadLStr(3140)),PChar(s7));
  setInfo(PChar(LoadLStr(3141)),PChar(s8));
  setInfo('','');
  setInfo(PChar(LoadLStr(3142)),PChar(s9));
  setInfo(PChar(LoadLStr(3143)),PChar(s10));
  setInfo('','');
  setInfo(PChar(LoadLStr(3144)),PChar(s11));
  setInfo(PChar(LoadLStr(3145)),PChar(s12));
  setInfo(PChar(LoadLStr(3146)),PChar(s13));
  setInfo('','');
  setInfo(PChar(LoadLStr(3147)),PChar(s14));
  setInfo(PChar(LoadLStr(3148)),PChar(s15));
  setInfo('','');
  setInfo(PChar(LoadLStr(3149)),PChar(s16));
  setInfo(PChar(LoadLStr(3150)),PChar(s17));
  setInfo(PChar(LoadLStr(3151)),PChar(s18));
end;

procedure GetBMPInfo(path : PChar);
var
  header : ^TBMPHeader;
  s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13: string;
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
        s9 := Format(LoadLStr(3152), [IntToStr(Planes)]);
      if ColorsUsed = 0 then
        s10 := IntToStr(BitsPerPixel)
      else
        s10 := IntToStr(ColorsUsed);

      if ColorsImportant = 0 then
        s11 := LoadLStr(3154)
      else
        s11 := IntToStr(ColorsImportant);
      if (Compression = BI_RGB) and (SizeImage = 0) then
        s12 := Format(LoadLStr(3153), [IntToStr(SizeImage)])
      else
        s12 := IntToStr(SizeImage);
      s13 := IntToStr(filesize);
    end;
  Dispose(header);

  setInfo(PChar(LoadLStr(3155)),PChar(s1));
  setInfo(PChar(LoadLStr(3156)),PChar(s2));
  setInfo(PChar(LoadLStr(3157)),PChar(s3));
  setInfo(PChar(LoadLStr(3137)),PChar(s4));
  setInfo('','');
  setInfo(PChar(LoadLStr(3140)),PChar(s5));
  setInfo(PChar(LoadLStr(3141)),PChar(s6));
  setInfo('','');
  setInfo(PChar(LoadLStr(3158)),PChar(s7));
  setInfo(PChar(LoadLStr(3159)),PChar(s8));
  setInfo(PChar(LoadLStr(3144)),PChar(s9));
  setInfo(PChar(LoadLStr(3160)),PChar(s10));
  setInfo(PChar(LoadLStr(3161)),PChar(s11));
  setInfo('','');
  setInfo(PChar(LoadLStr(3150)),PChar(s12));
  setInfo(PChar(LoadLStr(3151)),PChar(s13));
end;

procedure GetIconInfo(path : PChar);
var
  header : TIconHeader;
  s1,s2,s3,entersstr: string;
  filesize,i : integer;
  EnArray: array of TIconDirectoryEntry;
  tempf : TFilestream;
begin
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
        s1 := PChar(LoadLStr(3162))
      else
        s1 := PChar(LoadLStr(3163));
      s2 := IntToStr(header.Count);
      entersstr := '';

      setInfo(PChar(LoadLStr(3155)),PChar(s1));
      setInfo(PChar(LoadLStr(3164)),PChar(s2));

      for i:=0 to Count-1 do
       begin
         with EnArray[i] do
          if i=0 then
            setInfo(PChar(LoadLStr(3165)),PChar(Format(LoadLStr(3166), [i+1,Width,Height,BitCount,BytesInRes])))
          else
            setInfo('',PChar(Format(LoadLStr(3167), [i+1,Width,Height,BitCount,BytesInRes])));
         end;
      s3 := IntToStr(filesize);
    end;

  setInfo(PChar(LoadLStr(3151)),PChar(s3));
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
        s0 := LoadLStr(3168)
      else
        s0 := LoadLStr(3169);

      case ImageType of
        0: s1 := LoadLStr(3170);
        1: s1 := LoadLStr(3171);
        2: s1 := LoadLStr(3172);
        3: s1 := LoadLStr(3173);
        9: s1 := LoadLStr(3174);
        10: s1 := LoadLStr(3175);
        11: s1 := LoadLStr(3176);
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
            s12 := Format(LoadLStr(3177),[Day,Month,Year,Hour,Minute,Second]);
          end;
      
      s13 := IntToStr((Width*Height*BitsperPixel) div 8);
      s14 := IntToStr(filesize);
    end;

   setInfo(PChar(s0),'');
   setInfo(PChar(LoadLStr(3155)),PChar(s1));
   setInfo(PChar(LoadLStr(3137)),PChar(s2));
   setInfo('','');
   setInfo(PChar(LoadLStr(3138)),PChar(s3));
   setInfo(PChar(LoadLStr(3139)),PChar(s4));
   setInfo(PChar(LoadLStr(3140)),PChar(s5));
   setInfo(PChar(LoadLStr(3141)),PChar(s6));
   setInfo('','');

   if extended then
     begin
     setInfo(PChar(LoadLStr(3178)),'');
     setInfo(PChar(LoadLStr(3179)),PChar(s7));

     if ((s8<>'') and (s9<>'') and (s10<>'') and (s11<>'')) then
       begin
       setInfo(PChar(LoadLStr(3180)),'');
       if s8<>'' then
         setInfo('',PChar(s8));
       if s9<>'' then
         setInfo('',PChar(s9));
       if s10<>'' then
         setInfo('',PChar(s10));
       if s11<>'' then
         setInfo('',PChar(s11));
       end;

     setInfo(PChar(LoadLStr(3181)),PChar(s12));
     setInfo('','');
     end;

   setInfo(PChar(LoadLStr(3150)),PChar(s13));
   setInfo(PChar(LoadLStr(3151)),PChar(s14));
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
        s2 := LoadLStr(3182)
      else
        s2 := LoadLStr(3183);
      if GCTSort then
        s3 := LoadLStr(3184)
      else if GCT then
        s3 := LoadLStr(3185)
      else
        s3 := '';
      s4 := IntToStr(GCTSize);
      case PixelAspectRatio of
        0 : s5 := LoadLStr(3186);
        1..255 : s5 := FloatToStr( (PixelAspectRatio+15) / 64 );
      end;
      s6 := IntToStr(Width);
      s7 := IntToStr(Heigth);

      s8 := IntToStr(filesize);
    end;
  Dispose(header);

  setInfo(PChar(LoadLStr(3135)),PChar(s1));
  setInfo(PChar(LoadLStr(3187)),PChar(s2 + ' ' + s3));
  setInfo(PChar(LoadLStr(3188)),PChar(s4));
  setInfo(PChar(LoadLStr(3189)),PChar(s5));
  setInfo('','');
  setInfo(PChar(LoadLStr(3140)),PChar(s6));
  setInfo(PChar(LoadLStr(3141)),PChar(s7));
  setInfo('','');
  setInfo(PChar(LoadLStr(3151)),PChar(s8));
end;

function FxImgQuery(plugin_path: PChar; info_call: TPlugInCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
begin
    Result.result_type := RT_BOOL;
    Result.result_value := FX_TRUE;

    info_call(PT_FNAME, 'Additional information for bitmaps', '');

	info_call(PT_FINFO, 'pcx', ' ');
	info_call(PT_FINFO, 'bmp', ' ');
	info_call(PT_FINFO, 'ico', ' ');
	info_call(PT_FINFO, 'tga', ' ');
	info_call(PT_FINFO, 'vst', ' ');
	info_call(PT_FINFO, 'icb', ' ');
	info_call(PT_FINFO, 'vda', ' ');
	info_call(PT_FINFO, 'gif', ' ');
end;

function FxImgInfo(document_path, info: PChar; info_call: TDoubleCallBack; app, wnd: HWND; app_query: TAppCallBack): TFxImgResult; cdecl;
var
	temp_res: TFxImgResult;
	exten : string;
begin
    Result.result_type := RT_BOOL;
    Result.result_value := FX_TRUE;

    if (@app_query <> nil) then
        begin
    	temp_res := app_query(CQ_GETLANGLIBS, 0, 0);

        if (temp_res.result_type = RT_HANDLE) then
        	begin
            locale_lib := temp_res.result_value;
            backup_lib := temp_res.result_xtra;
            end;
        end;

  	// setting function
  	setInfo := info_call;

  	setInfo('', '');

  	exten := LowerCase(info);

  	if (exten = 'pcx') then
    	GetPCXInfo(document_path)
  	else if (exten = 'bmp') then
    	GetBMPInfo(document_path)
  	else if (exten = 'ico') then
    	GetIconInfo(document_path)
  	else if (exten = 'tga') or
          	(exten = 'vda') or
          	(exten = 'vst') or
          	(exten = 'icb') then
    	GetTGAInfo(document_path)
  	else if (exten = 'gif') then
    	GetGIFInfo(document_path);
end;

exports
	FxImgQuery, FxImgInfo;

begin
end.
