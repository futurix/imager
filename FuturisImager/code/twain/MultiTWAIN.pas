unit MultiTWAIN;

interface

uses
  Windows, SysUtils, Classes, Graphics, CommDlg;

type
{$IFDEF VER100}
   UnsignedInt32 = Cardinal;
{$ELSE}
   UnsignedInt32 = Integer;
{$ENDIF}
   hDibCallbackProc = procedure(curdib: THandle; n: Integer); stdcall;

const
   TWAIN_BW=1;	  { 1-bit per pixel, B&W 	 (== TWPT_BW) }
   TWAIN_GRAY=2;	  { 1,4, or 8-bit grayscale  (== TWPT_GRAY) }
   TWAIN_RGB=4;	  { 24-bit RGB color         (== TWPT_RGB) }
   TWAIN_PALETTE=8; { 1,4, or 8-bit palette    (== TWPT_PALETTE) }
   TWAIN_ANYTYPE=0; { any of the above }

   TWAIN_PRESESSION=1;        {	source manager not loaded }
   TWAIN_SM_LOADED=2;	      { source manager loaded }
   TWAIN_SM_OPEN=3;           { source manager open }
   TWAIN_SOURCE_OPEN=4;       { source open but not enabled }
   TWAIN_SOURCE_ENABLED=5;    { source enabled to acquire }
   TWAIN_TRANSFER_READY=6;    { image ready to transfer }
   TWAIN_TRANSFERRING=7;	  { image in transit }

   TWUN_INCHES=0;
   TWUN_CENTIMETERS=1;
   TWUN_PICAS=2;
   TWUN_POINTS=3;
   TWUN_TWIPS=4;
   TWUN_PIXELS=5;

{$L eztwain.obj}
function TWAIN_SelectImageSource(hwnd: HWND): Integer; stdcall; external;
function TWAIN_AcquireNative(hwnd: HWND; pixmask: Integer): HBitmap; stdcall; external;
procedure TWAIN_FreeNative(hDIB: HBitmap); stdcall external;
function TWAIN_AcquireToClipboard(hwndApp: HWND; wPixTypes: UnsignedInt32): Integer; stdcall; external;
function TWAIN_AcquireToFilename(hWndApp: HWND; pszFile: PChar): Integer; stdcall; external;
function TWAIN_IsAvailable: Integer; stdcall; external;
function TWAIN_EasyVersion: Integer; stdcall; external;
function TWAIN_State: Integer; stdcall; external;

// Added by DSN 7/98, this allows the user to specify an
// optional callback function to be called each time a new image comes
// in.  This can be a potentially powerful way to increase the primary
// application's efficiency, because upon receipt of an hdib the app
// could start a background thread to begin processing the images as
// needed.  Why bother with this?  Because on my Pentium 150, the Windows
// NT task monitor indicates that when I download images at 112kbps that
// I'm only using 15% of the processor's power, and the remaining 85% of
// the time it is idle!  It's silly to wait to begin processing because
// there's so much untapped processing capacity here.

procedure TWAIN_RegisterCallback(fxn: hDibCallbackProc); stdcall; external;
procedure TWAIN_UnRegisterCallback; stdcall; external;
// the next three functions were added by DSN to manage acquisition of multiple
// images.  The first, TWAIN_CleadDibList, is called automatically by
// TWAIN_AcquireNative (and, hence, the other Acquire functions).
// TWAIN_GetNumDibs returns the number of images available.
// Finally, TWAIN_GetDib retrieves a specific dib from the list.  Note that
// the first dib corresponds to n = 0.
// ALSO NOTE: the maximum number of dibs that can be scanned in is 999
// This value may easily be expanded by changing the MAX_IMAGES constant
// in the C code.

procedure TWAIN_ClearDibList; stdcall; external;
function TWAIN_GetNumDibs: Integer; stdcall; external;
function TWAIN_GetDib(n: Integer): THandle; stdcall; external;

function TWAIN_DibDepth(hDib: HBitmap): Integer; stdcall; external;
function TWAIN_DibWidth(hDib: HBitmap): Integer; stdcall; external;
function TWAIN_DibHeight(hDib: HBitmap): Integer; stdcall; external;
function TWAIN_DibNumColors(hDib: HBitmap): Integer; stdcall; external;
function TWAIN_CreateDibPalette(hdib: HBitmap): Integer; stdcall; external;  // HANDLE & HPALETTE, respectively
procedure TWAIN_DrawDibToDC(
		hDC: HDC;
		dx, dy, w, h: Integer;
		hDib: HBitmap;
		sx, sy: Integer
		); stdcall; external;
function TWAIN_WriteNativeToFilename(hdib: hBitmap; pszFile: PChar): Integer;  stdcall; external;
function TWAIN_WriteNativeToFile(hdib: HBitmap; fh: Integer): Integer; stdcall; external;
function TWAIN_LoadNativeFromFilename(pszFile: PChar): HBitmap; stdcall; external;
function TWAIN_LoadNativeFromFile(fh: Integer): HBitmap;  stdcall; external;
procedure TWAIN_RegisterApp( nMajorNum,nMinorNum: integer;
                             nLanguage: integer;
                             nCountry: integer;
                             lpszVersion: PChar;
                             lpszMfg: PChar;
                             lpszFamily: PChar;
                             lpszProduct: PChar); stdcall; external;
procedure TWAIN_SetHideUI(fHide: Integer); stdcall; external;
function TWAIN_GetHideUI: Integer; stdcall; external;
function TWAIN_GetResultCode: UnsignedInt32; stdcall; external;
function TWAIN_GetConditionCode: UnsignedInt32; stdcall; external;
function TWAIN_LoadSourceManager: Integer; stdcall; external;
function TWAIN_OpenSourceManager(hwnd: HWND): Integer; stdcall; external;
function TWAIN_OpenDefaultSource: Integer; stdcall; external;
function TWAIN_EnableSource(hwnd: hWnd): Integer; stdcall; external;
function TWAIN_DisableSource: Integer; stdcall; external;
function TWAIN_CloseSource: Integer; stdcall; external;
function TWAIN_CloseSourceManager(hWnd: HWND): Integer; stdcall; external;
function TWAIN_UnloadSourceManager: Integer; stdcall; external;
function TWAIN_MessageHook(lpmsg: PMSG): Integer; stdcall; external;
procedure TWAIN_ModalEventLoop; stdcall; external;
procedure TWAIN_NativeXferGetAll(psmg: PMSG); stdcall; external; // for multiple xfers
function TWAIN_AbortAllPendingXfers: Integer; stdcall; external;
function TWAIN_WriteDibToFile(lpDIB: PBITMAPINFOHEADER; fh: Integer): Integer; stdcall; external;
function TWAIN_NegotiateXferCount(nXfers: Integer): Integer; stdcall; external;
function TWAIN_NegotiatePixelTypes(wPixTypes: UnsignedInt32): Integer; stdcall; external;
function TWAIN_GetCurrentUnits: Integer; stdcall; external;
function TWAIN_SetCurrentUnits(nUnits: Integer): Integer; stdcall; external;
function TWAIN_GetBitDepth: Integer; stdcall; external;
function TWAIN_SetBitDepth(nBits: Integer): Integer; stdcall; external;
function TWAIN_GetPixelType: Integer; stdcall; external;
function TWAIN_SetCurrentPixelType(nPixType: Integer): Integer; stdcall; external;
function TWAIN_GetCurrentResolution: double;   // implemented below
function TWAIN_SetCurrentResolution(dRes: double): Integer;  // implemented below
function TWAIN_SetCapOneValue(Cap: UnsignedInt32; ItemType: UnsignedInt32; ItemVal: LongInt): Integer; stdcall; external;
function TWAIN_GetCapCurrent(Cap: UnsignedInt32; ItemType: UnsignedInt32; pVal: Pointer): Integer; stdcall; external;
function TWAIN_DS(DG: LongInt; DAT: UnsignedInt32; MSG: UnsignedInt32; pData: Pointer): Integer; stdcall; external;
function TWAIN_Mgr(DG: LongInt; DAT: UnsignedInt32; MSG: UnsignedInt32; pData: Pointer): Integer; stdcall; external;

procedure CopyDIBIntoImage(hDIB: THandle; Image: TPicture);

implementation

{ The procedures implemented below are the ones which use floating point numbers }

const
   ICAP_XRESOLUTION = $1118;
   ICAP_PIXELTYPE = $0101;
   TWTY_FIX32 = $0007;
   TWTY_UINT16 = $0004;

type
   TW_FIX32 = record
      Whole: SmallInt;
      Frac: Word;
   end;

function ToFix32(r: Double): UnsignedInt32;
var
   fix: TW_FIX32;
   v: Integer;
begin
   v := Round(r * 65536.0 + 0.5);
   fix.Whole := ShortInt(V shr 16);
   fix.Frac := Word (v and $ffff);
   ToFix32 := UnsignedInt32(fix);
end;

function Fix32ToFloat(fix: TW_FIX32): double;
var
   v: Integer;
begin
   v := (Integer(fix.Whole) shl 16) or (UnsignedInt32(fix.frac) and $ffff);
   Fix32ToFloat := v / 65536.0;
end;

function TWAIN_GetCurrentResolution: double;
var
   res: TW_FIX32;
begin
   TWAIN_GetCapCurrent(ICAP_XRESOLUTION, TWTY_FIX32, @res);
   TWAIN_GetCurrentResolution := Fix32ToFloat(res);
end;

function TWAIN_SetCurrentResolution(dRes: double): Integer;
begin
   TWAIN_SetCurrentResolution := TWAIN_SetCapOneValue(ICAP_XRESOLUTION, TWTY_FIX32, ToFix32(dRes));
end;

(*************************************************)

procedure CopyDIBIntoImage(hDIB: THandle; Image: TPicture);
var
   DibW, DibH{, oldw, oldh}: integer;
begin
   //Oldw := Image.Width;
   //Oldh := Image.Height;
   DibW := TWAIN_DibWidth(hDib);
   DibH := TWAIN_DibHeight(hDib);
   Image.Bitmap.Width := DibW;  // temporarily enlarge image to ensure the whole
   Image.Bitmap.Height := DibH; // DIB gets copied
   TWAIN_DrawDibToDC(Image.Bitmap.Canvas.Handle, 0, 0, DibW, DibH, hDIB, 0, 0);
   //Image.Width := oldw;
   //Image.Height := oldh;
end;

{   The function below was adapted from code on www.codeguru.com.  After
   I translated it from C++ I realized I wouldn't need it; however, I've
   left it in here in case anyone else finds it useful.  NOTE: I never
   tested to make sure my translation was accurate, so be careful! -- DSN 7/98

function DIBToDDB(hDIB: THandle): HBitmap;
var
   lpbi: PBitmapInfoHeader;
   hbm: HBitmap;
   Pal, OldPal: HPalette;
   dc: HDC;
   nSize: UnsignedInt32;
   pLP: PLogPalette;
   nColors, i: Integer;
   lpDIBBits: Pointer;
   bmInfo: PBitmapInfo;

   bmicoloraddr: PChar;
   bmisum: PChar;
   bmisumncolor: PChar;

begin
   if (hDIB = 0) then
      begin
         DIBToDDB := 0;
         exit;
      end;
   dc := GetDC(0);
   pal := 0;

   lpbi := PBitmapInfoHeader(hDIB);
   if (lpbi^.biClrUsed > 0) then
      nColors := lpbi^.biClrUsed
   else nColors := 1 shl lpbi^.biBitCount;

   bmicoloraddr := PChar(@(bmInfo^.bmiColors));
   bmiSum := bmiColorAddr + (bmInfo^.bmiHeader.biClrUsed * sizeof(DWORD));
   if bmInfo^.bmiHeader.biCompression = BI_BITFIELDS then
      bmiSum := bmiSum + (3 * sizeof(DWORD));
   bmisumncolor := bmiColorAddr + (nColors * sizeof(DWORD));

   if bmInfo^.bmiHeader.biBitCount > 8 then
      lpDIBBits := Pointer(bmiSum)
   else lpDIBBits := Pointer(bmisumncolor);

   if (nColors <= 256 and (GetDeviceCaps(dc, RASTERCAPS) and RC_PALETTE)) then
      begin    // Create and select a logical palette if needed
         nSize := sizeof(TLogPalette) + (sizeof(TPaletteEntry) * nColors);
         GetMem(pLP, nSize);
         pLP^.palVersion := $0300;
         pLP^.palNumEntries := ncolors;
         for i := 0 to nColors do
            begin
               pLP^.palPalEntry[i].peRed := bmInfo.bmiColors[i].rgbRed;
               pLP^.palPalEntry[i].peGreen := bmInfo.bmiColors[i].rgbGreen;
               pLP^.palPalEntry[i].peBlue := bmInfo.bmiColors[i].rgbBlue;
               pLP^.palPalEntry[i].peFlags := 0;
            end;
         pal := CreatePalette(pLP^);
         FreeMem(pLP);
         OldPal := SelectPalette(dc, pal, False);// select and realize the palette
         RealizePalette(dc);
      end;
   hbm := CreateDIBitmap(dc,
                         (PBitmapInfoHeader(lpbi))^,
                         LongInt(CBM_INIT),
                         lpDIBBits,
                         (PBitmapInfo(lpbi))^,
                         DIB_RGB_COLORS);
   if pal <> 0 then
      SelectPalette(dc, Oldpal, False);
   ReleaseDC(0, dc);
   DIBToDDB := hbm;
end;}

end.







