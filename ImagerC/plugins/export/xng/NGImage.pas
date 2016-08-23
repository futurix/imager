unit NGImage;

{$WARNINGS OFF}
{$HINTS OFF}

{****************************************************************************}
{*               This is version: 0.9.2 (3rd BETA)                          *}  
{****************************************************************************}

// folowing directives can be turned off to exclude specific parts if needed
// (note: TNGImage itself is always defined !)

{$DEFINE INCLUDE_PNG_SAVE}             // include PNG save support in TNGImage
{$DEFINE INCLUDE_JNG_SAVE}             // include JNG save support in TNGImage
{$DEFINE INCLUDE_ZLIB}                 // include ZLIB support functions
                                       // (needed for either PNG or JNG save!!)
{$DEFINE INCLUDE_JPEG}                 // include JPEG support & TJPEGImage
                                       // (needed for JNG save!!)

{$DEFINE REGISTER_PNG}                 // include & register TPNGImage
{$DEFINE REGISTER_JNG}                 // include & register TJNGImage
{$DEFINE REGISTER_MNG}                 // include & register TMNGImage
{$IFDEF INCLUDE_JPEG}
{$DEFINE REGISTER_JPEG}                // register TJPEGImage
{$ENDIF}

{****************************************************************************}
{*                                                                          *}
{*  COPYRIGHT NOTICE:                                                       *}
{*                                                                          *}
{*  Copyright (c) 2001 Gerard Juyn (gerard@libmng.com)                      *}
{*  [You may insert additional notices after this sentence if you modify    *}
{*   this source]                                                           *}
{*                                                                          *}
{*  For the purposes of this copyright and license, "Contributing Authors"  *}
{*  is currently defined as the following set of individuals:               *}
{*                                                                          *}
{*     Gerard Juyn                                                          *}
{*                                                                          *}
{*  This component is supplied "AS IS".  The Contributing Authors           *}
{*  disclaim all warranties, expressed or implied, including, without       *}
{*  limitation, the warranties of merchantability and of fitness for any    *}
{*  purpose.  The Contributing Authors assume no liability for direct,      *}
{*  indirect, incidental, special, exemplary, or consequential damages,     *}
{*  which may result from the use of this component, even if advised of     *}
{*  the possibility of such damage.                                         *}
{*                                                                          *}
{*  Permission is hereby granted to use, copy, modify, and distribute this  *}
{*  source code, or portions hereof, for any purpose, without fee, subject  *}
{*  to the following restrictions:                                          *}
{*                                                                          *}
{*  1. The origin of this source code must not be misrepresented;           *}
{*     you must not claim that you wrote the original software.             *}
{*                                                                          *}
{*  2. Altered versions must be plainly marked as such and must not be      *}
{*     misrepresented as being the original source.                         *}
{*                                                                          *}
{*  3. This Copyright notice may not be removed or altered from any source  *}
{*     or altered source distribution.                                      *}
{*                                                                          *}
{*  The Contributing Authors specifically permit, without fee, and          *}
{*  encourage the use of this source code as a component to supporting      *}
{*  the MNG/JNG and PNG file format in commercial products. If you use this *}
{*  source code in a product, acknowledgment would be highly appreciated.   *}
{*                                                                          *}
{****************************************************************************}
{*                                                                          *}
{*  Copyrights & Trademarks                                                 *}
{*                                                                          *}
{*  Uses "libmng" - an open-source initiative by Gerard Juyn                *}
{*  copyright (C) 2000,2001 G. Juyn                                         *}
{*  http://www.libmng.com                                                   *}
{*                                                                          *}
{*  Based in part on the works of the Independant JPEG Group (IJG)          *}
{*  copyright (C) 1991-1998 Thomas G. Lane                                  *}
{*  http://www.ijg.org                                                      *}
{*                                                                          *}
{*  Uses "lcms" (little CMS) by Marti Maria Saguer                          *}
{*  distributed under LGPL                                                  *}
{*  http://www.littlecms.com                                                *}
{*                                                                          *}
{*  Uses "zlib" - a mighty, patent-free(!) (de)compression-library          *}
{*  copyright (C) 1995-1998 Jean-loup Gailly and Mark Adler                 *}
{*  http://www.info-zip.org/pub/infozip/zlib                                *}
{*                                                                          *}
{*  The implementation of the TJPEGImage is based on sample code in the     *}
{*  JPEG unit provided with Borland Delphi.                                 *}
{*  Copyright (c) 1997 Borland International                                *}
{*  (only adapted to work with ijgsrc6b in libmng.dll)                      *}
{*                                                                          *}
{*  Parts of the source-code are courtesy of Triple-T                       *}
{*  http://www.3-t.com                                                      *}
{*                                                                          *}
{****************************************************************************}
{*                                                                          *}
{*  Changelog:                            * reverse chronological order *   *}
{*                                                                          *}
{*  * 0.9.2 *                                                               *}
{*  Third beta (added JPEG/ZLIB, PNG save, JNG save)                        *}
{*  2001/05/04 - Added version constants                                    *}
{*             - Added OnStatusChange event property to TNGImage            *}
{*             - Added JNG save support to TNGImage                         *}
{*  2001/05/03 - Added PNG save support to TNGImage                         *}
{*             - Added transparency variables to TNGImage                   *}
{*             - Added support to assign a TBitmap to TNGImage              *}
{*             - Added TJPEGImage                                           *}
{*             - Added external defs for ZLIB/JPEG (included in libmng!)    *}
{*             - Added properties to access libmng variables to TNGImage    *}
{*             - Added conditionals to include/register specific components *}
{*                                                                          *}
{*  * 0.9.1 *                                                               *}
{*  Second beta (small fixes)                                               *}
{*                                                                          *}
{*  * 0.9.0 *                                                               *}
{*  First beta (basic setup)                                                *}
{*                                                                          *}
{****************************************************************************}
{*                                                                          *}
{*  TODO:                                                                   *}
{*                                                                          *}
{*  - several optimizations                                                 *}
{*  - support for OnProgress                                                *}
{*  - group all resource strings                                            *}
{*  - new TMNGVideo component (optimized for video-stream playback)         *}
{*                                                                          *}
{****************************************************************************}

// define internal dependencies (do not modify!!!!)

{$IFDEF INCLUDE_PNG_SAVE}
{$DEFINE INCLUDE_ZLIB}
{$ENDIF}
{$IFDEF INCLUDE_JNG_SAVE}
{$DEFINE INCLUDE_ZLIB}
{$DEFINE INCLUDE_JPEG}
{$ENDIF}

{****************************************************************************}

interface

uses Windows, Graphics, ExtCtrls, Classes, SysUtils, Forms;

{****************************************************************************}

const
  TNGVersionStr     = '0.9.2';
  TNGVersionMajor   = 0;
  TNGVersionMinor   = 9;
  TNGVersionRelease = 2;

{****************************************************************************}

type
  ENGImageException = class (EInvalidGraphicOperation);

{****************************************************************************}
{* LIBMNG interface definitions                                             *}
{* (translated from libmng.h)                                               *}
{****************************************************************************}

const MNG_TRUE       = TRUE;
      MNG_FALSE      = FALSE;
      MNG_NULL       = nil;

type  mng_uint32     = cardinal;
      mng_int32      = integer;
      mng_uint16     = word;
      mng_int16      = smallint;
      mng_uint8      = byte;
      mng_int8       = shortint;
      mng_bool       = boolean;
      mng_ptr        = pointer;
      mng_pchar      = pchar;

      mng_handle     = pointer;
      mng_retcode    = mng_int32;
      mng_chunkid    = mng_uint32;

      mng_size_t     = cardinal;

      mng_imgtype    = (mng_it_unknown, mng_it_png, mng_it_mng, mng_it_jng);
      mng_speedtype  = (mng_st_normal, mng_st_fast, mng_st_slow, mng_st_slowest);

      mng_uint32p    = ^mng_uint32;
      mng_uint16p    = ^mng_uint16;
      mng_uint8p     = ^mng_uint8;
      mng_chunkidp   = ^mng_chunkid;

      mng_palette8e  = packed record             // 8-bit palette element
                         iRed   : mng_uint8;
                         iGreen : mng_uint8;
                         iBlue  : mng_uint8;
                       end;

      mng_palette8   = packed array [0 .. 255] of mng_palette8e;

      mng_uint8arr   = packed array [0 .. 255] of mng_uint8;
      mng_uint8arr4  = packed array [0 ..   3] of mng_uint8;
      mng_uint16arr  = packed array [0 .. 255] of mng_uint16;
      mng_uint32arr  = packed array [0 .. 255] of mng_uint32;
      mng_uint32arr2 = packed array [0 ..   1] of mng_uint32;

{****************************************************************************}

type mng_memalloc      = function  (    iLen         : mng_size_t) : mng_ptr; stdcall;
     mng_memfree       = procedure (    iPtr         : mng_ptr;
                                        iLen         : mng_size_t); stdcall;

type mng_openstream    = function  (    hHandle      : mng_handle) : mng_bool; stdcall;
type mng_closestream   = function  (    hHandle      : mng_handle) : mng_bool; stdcall;

type mng_readdata      = function  (    hHandle      : mng_handle;
                                        pBuf         : mng_ptr;
                                        iBuflen      : mng_uint32;
                                    var pRead        : mng_uint32) : mng_bool; stdcall;

type mng_writedata     = function  (    hHandle      : mng_handle;
                                        pBuf         : mng_ptr;
                                        iBuflen      : mng_uint32;
                                    var pWritten     : mng_uint32) : mng_bool; stdcall;

type mng_errorproc     = function  (    hHandle      : mng_handle;
                                        iErrorcode   : mng_retcode;
                                        iSeverity    : mng_uint8;
                                        iChunkname   : mng_chunkid;
                                        iChunkseq    : mng_uint32;
                                        iExtra1      : mng_int32;
                                        iExtra2      : mng_int32;
                                        zErrortext   : mng_pchar ) : mng_bool; stdcall;
type mng_traceproc     = function  (    hHandle      : mng_handle;
                                        iFuncnr      : mng_int32;
                                        iFuncseq     : mng_uint32;
                                        zFuncname    : mng_pchar ) : mng_bool; stdcall;

type mng_processheader = function  (    hHandle      : mng_handle;
                                        iWidth       : mng_uint32;
                                        iHeight      : mng_uint32) : mng_bool; stdcall;
type mng_processtext   = function  (    hHandle      : mng_handle;
                                        iType        : mng_uint8;
                                        zKeyword     : mng_pchar;
                                        zText        : mng_pchar;
                                        zLanguage    : mng_pchar;
                                        zTranslation : mng_pchar ) : mng_bool; stdcall;

type mng_processunknown = function (    hHandle      : mng_handle;
                                        iChunkid     : mng_chunkid;
                                        iRawlen      : mng_uint32;
                                        pRawdata     : mng_ptr   ) : mng_bool; stdcall;

type mng_getcanvasline = function  (    hHandle      : mng_handle;
                                        iLinenr      : mng_uint32) : mng_ptr; stdcall;
type mng_getalphaline  = function  (    hHandle      : mng_handle;
                                        iLinenr      : mng_uint32) : mng_ptr; stdcall;
type mng_getbkgdline   = function  (    hHandle      : mng_handle;
                                        iLinenr      : mng_uint32) : mng_ptr; stdcall;
type mng_refresh       = function  (    hHandle      : mng_handle;
                                        iX           : mng_uint32;
                                        iY           : mng_uint32;
                                        iWidth       : mng_uint32;
                                        iHeight      : mng_uint32) : mng_bool; stdcall;

type mng_gettickcount  = function  (    hHandle      : mng_handle) : mng_uint32; stdcall;
type mng_settimer      = function  (    hHandle      : mng_handle;
                                        iMsecs       : mng_uint32) : mng_bool; stdcall;

{****************************************************************************}

function  mng_version_text    : mng_pchar;
function  mng_version_so      : mng_uint8;
function  mng_version_dll     : mng_uint8;
function  mng_version_major   : mng_uint8;
function  mng_version_minor   : mng_uint8;
function  mng_version_release : mng_uint8;

{****************************************************************************}

function  mng_initialize          (pUserdata       : mng_ptr;
                                   fMemalloc       : mng_memalloc;
                                   fMemfree        : mng_memfree;
                                   fTraceproc      : mng_traceproc    ) : mng_handle;        stdcall;

function  mng_reset               (hHandle         : mng_handle       ) : mng_retcode;       stdcall;

function  mng_cleanup             (var hHandle     : mng_handle       ) : mng_retcode;       stdcall;

function  mng_read                (hHandle         : mng_handle       ) : mng_retcode;       stdcall;
function  mng_write               (hHandle         : mng_handle       ) : mng_retcode;       stdcall;
function  mng_create              (hHandle         : mng_handle       ) : mng_retcode;       stdcall;

function  mng_readdisplay         (hHandle         : mng_handle       ) : mng_retcode;       stdcall;
function  mng_display             (hHandle         : mng_handle       ) : mng_retcode;       stdcall;
function  mng_display_resume      (hHandle         : mng_handle       ) : mng_retcode;       stdcall;
function  mng_display_freeze      (hHandle         : mng_handle       ) : mng_retcode;       stdcall;
function  mng_display_reset       (hHandle         : mng_handle       ) : mng_retcode;       stdcall;

function  mng_getlasterror        (hHandle         : mng_handle;
                                   var iSeverity   : mng_uint8;
                                   var iChunkname  : mng_chunkid;
                                   var iChunkseq   : mng_uint32;
                                   var iExtra1     : mng_int32;
                                   var iExtra2     : mng_int32;
                                   var zErrortext  : mng_pchar        ) : mng_retcode;       stdcall;

{****************************************************************************}

function  mng_setcb_memalloc      (hHandle         : mng_handle;
                                   fProc           : mng_memalloc     ) : mng_retcode;       stdcall;
function  mng_setcb_memfree       (hHandle         : mng_handle;
                                   fProc           : mng_memfree      ) : mng_retcode;       stdcall;

function  mng_setcb_openstream    (hHandle         : mng_handle;
                                   fProc           : mng_openstream   ) : mng_retcode;       stdcall;
function  mng_setcb_closestream   (hHandle         : mng_handle;
                                   fProc           : mng_closestream  ) : mng_retcode;       stdcall;

function  mng_setcb_readdata      (hHandle         : mng_handle;
                                   fProc           : mng_readdata     ) : mng_retcode;       stdcall;

function  mng_setcb_writedata     (hHandle         : mng_handle;
                                   fProc           : mng_writedata    ) : mng_retcode;       stdcall;

function  mng_setcb_errorproc     (hHandle         : mng_handle;
                                   fProc           : mng_errorproc    ) : mng_retcode;       stdcall;

function  mng_setcb_processheader (hHandle         : mng_handle;
                                   fProc           : mng_processheader) : mng_retcode;       stdcall;
function  mng_setcb_processtext   (hHandle         : mng_handle;
                                   fProc           : mng_processtext  ) : mng_retcode;       stdcall;

function  mng_setcb_getcanvasline (hHandle         : mng_handle;
                                   fProc           : mng_getcanvasline) : mng_retcode;       stdcall;
function  mng_setcb_getalphaline  (hHandle         : mng_handle;
                                   fProc           : mng_getalphaline ) : mng_retcode;       stdcall;
function  mng_setcb_getbkgdline   (hHandle         : mng_handle;
                                   fProc           : mng_getbkgdline  ) : mng_retcode;       stdcall;
function  mng_setcb_refresh       (hHandle         : mng_handle;
                                   fProc           : mng_refresh      ) : mng_retcode;       stdcall;

function  mng_setcb_gettickcount  (hHandle         : mng_handle;
                                   fProc           : mng_gettickcount ) : mng_retcode;       stdcall;
function  mng_setcb_settimer      (hHandle         : mng_handle;
                                   fProc           : mng_settimer     ) : mng_retcode;       stdcall;

{****************************************************************************}

function  mng_getcb_memalloc      (hHandle         : mng_handle       ) : mng_memalloc;      stdcall;
function  mng_getcb_memfree       (hHandle         : mng_handle       ) : mng_memfree;       stdcall;

function  mng_getcb_openstream    (hHandle         : mng_handle       ) : mng_openstream;    stdcall;
function  mng_getcb_closestream   (hHandle         : mng_handle       ) : mng_closestream;   stdcall;

function  mng_getcb_readdata      (hHandle         : mng_handle       ) : mng_readdata;      stdcall;

function  mng_getcb_writedata     (hHandle         : mng_handle       ) : mng_writedata;     stdcall;

function  mng_getcb_errorproc     (hHandle         : mng_handle       ) : mng_errorproc;     stdcall;

function  mng_getcb_processheader (hHandle         : mng_handle       ) : mng_processheader; stdcall;
function  mng_getcb_processtext   (hHandle         : mng_handle       ) : mng_processtext;   stdcall;

function  mng_getcb_getcanvasline (hHandle         : mng_handle       ) : mng_getcanvasline; stdcall;
function  mng_getcb_getalphaline  (hHandle         : mng_handle       ) : mng_getalphaline;  stdcall;
function  mng_getcb_getbkgdline   (hHandle         : mng_handle       ) : mng_getbkgdline;   stdcall;
function  mng_getcb_refresh       (hHandle         : mng_handle       ) : mng_refresh;       stdcall;

function  mng_getcb_gettickcount  (hHandle         : mng_handle       ) : mng_gettickcount;  stdcall;
function  mng_getcb_settimer      (hHandle         : mng_handle       ) : mng_settimer;      stdcall;

{****************************************************************************}

function  mng_set_userdata        (hHandle         : mng_handle;
                                   pUserdata       : mng_ptr          ) : mng_retcode;       stdcall;

function  mng_set_canvasstyle     (hHandle         : mng_handle;
                                   iStyle          : mng_uint32       ) : mng_retcode;       stdcall;
function  mng_set_bkgdstyle       (hHandle         : mng_handle;
                                   iStyle          : mng_uint32       ) : mng_retcode;       stdcall;

function  mng_set_bgcolor         (hHandle         : mng_handle;
                                   iRed            : mng_uint16;
                                   iGreen          : mng_uint16;
                                   iBlue           : mng_uint16       ) : mng_retcode;       stdcall;

function  mng_set_usebkgd         (hHandle         : mng_handle;
                                   bUseBKGD        : mng_bool         ) : mng_retcode;       stdcall;

function  mng_set_storechunks     (hHandle         : mng_handle;
                                   bStorechunks    : mng_bool         ) : mng_retcode;       stdcall;

function  mng_set_viewgammaint    (hHandle         : mng_handle;
                                   iGamma          : mng_uint32       ) : mng_retcode;       stdcall;
function  mng_set_displaygammaint (hHandle         : mng_handle;
                                   iGamma          : mng_uint32       ) : mng_retcode;       stdcall;
function  mng_set_dfltimggammaint (hHandle         : mng_handle;
                                   iGamma          : mng_uint32       ) : mng_retcode;       stdcall;

function  mng_set_srgb            (hHandle         : mng_handle;
                                   bIssRGB         : mng_bool         ) : mng_retcode;       stdcall;
function  mng_set_outputprofile   (hHandle         : mng_handle;
                                   zFilename       : mng_pchar        ) : mng_retcode;       stdcall;
function  mng_set_outputprofile2  (hHandle         : mng_handle;
                                   iProfilesize    : mng_uint32;
                                   pProfile        : mng_ptr          ) : mng_retcode;       stdcall;
function  mng_set_outputsrgb      (hHandle         : mng_handle       ) : mng_retcode;       stdcall;
function  mng_set_srgbprofile     (hHandle         : mng_handle;
                                   zFilename       : mng_pchar        ) : mng_retcode;       stdcall;
function  mng_set_srgbprofile2    (hHandle         : mng_handle;
                                   iProfilesize    : mng_uint32;
                                   pProfile        : mng_ptr          ) : mng_retcode;       stdcall;
function  mng_set_srgbimplicit    (hHandle         : mng_handle       ) : mng_retcode;       stdcall;

function  mng_set_maxcanvassize   (hHandle         : mng_handle;
                                   iMaxwidth       : mng_uint32;
                                   iMaxheight      : mng_uint32       ) : mng_retcode;       stdcall;

{****************************************************************************}

function  mng_get_userdata        (hHandle         : mng_handle       ) : mng_ptr;           stdcall;

function  mng_get_sigtype         (hHandle         : mng_handle       ) : mng_imgtype;       stdcall;
function  mng_get_imagetype       (hHandle         : mng_handle       ) : mng_imgtype;       stdcall;
function  mng_get_imagewidth      (hHandle         : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_imageheight     (hHandle         : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_ticks           (hHandle         : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_framecount      (hHandle         : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_layercount      (hHandle         : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_playtime        (hHandle         : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_simplicity      (hHandle         : mng_handle       ) : mng_uint32;        stdcall;

function  mng_get_bitdepth        (hHandle         : mng_handle       ) : mng_uint8;         stdcall;
function  mng_get_colortype       (hHandle         : mng_handle       ) : mng_uint8;         stdcall;
function  mng_get_compression     (hHandle         : mng_handle       ) : mng_uint8;         stdcall;
function  mng_get_filter          (hHandle         : mng_handle       ) : mng_uint8;         stdcall;
function  mng_get_interlace       (hHandle         : mng_handle       ) : mng_uint8;         stdcall;
function  mng_get_alphabitdepth   (hHandle         : mng_handle       ) : mng_uint8;         stdcall;
function  mng_get_alphacompression(hHandle         : mng_handle       ) : mng_uint8;         stdcall;
function  mng_get_alphafilter     (hHandle         : mng_handle       ) : mng_uint8;         stdcall;
function  mng_get_alphainterlace  (hHandle         : mng_handle       ) : mng_uint8;         stdcall;

procedure mng_get_bgcolor         (hHandle         : mng_handle;
                                   var iRed        : mng_uint16;
                                   var iGreen      : mng_uint16;
                                   var iBlue       : mng_uint16       );                     stdcall;

function  mng_get_usebkgd         (hHandle         : mng_handle       ) : mng_bool;          stdcall;

function  mng_get_viewgammaint    (hHandle         : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_displaygammaint (hHandle         : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_dfltimggammaint (hHandle         : mng_handle       ) : mng_uint32;        stdcall;

function  mng_get_srgb            (hHandle         : mng_handle       ) : mng_bool;          stdcall;

function  mng_get_maxcanvaswidth  (hHandle         : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_maxcanvasheight (hHandle         : mng_handle       ) : mng_uint32;        stdcall;

function  mng_get_starttime       (hHandle         : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_runtime         (hHandle         : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_currentframe    (hHandle         : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_currentlayer    (hHandle         : mng_handle       ) : mng_uint32;        stdcall;
function  mng_get_currentplaytime (hHandle         : mng_handle       ) : mng_uint32;        stdcall;

function  mng_status_error        (hHandle         : mng_handle       ) : mng_bool;          stdcall;
function  mng_status_reading      (hHandle         : mng_handle       ) : mng_bool;          stdcall;
function  mng_status_suspendbreak (hHandle         : mng_handle       ) : mng_bool;          stdcall;
function  mng_status_creating     (hHandle         : mng_handle       ) : mng_bool;          stdcall;
function  mng_status_writing      (hHandle         : mng_handle       ) : mng_bool;          stdcall;
function  mng_status_displaying   (hHandle         : mng_handle       ) : mng_bool;          stdcall;
function  mng_status_running      (hHandle         : mng_handle       ) : mng_bool;          stdcall;
function  mng_status_timerbreak   (hHandle         : mng_handle       ) : mng_bool;          stdcall;

{****************************************************************************}

function  mng_putchunk_ihdr (hHandle            : mng_handle;
                             iWidth             : mng_uint32;
                             iHeight            : mng_uint32;
                             iBitdepth          : mng_uint8;
                             iColortype         : mng_uint8;
                             iCompression       : mng_uint8;
                             iFilter            : mng_uint8;
                             iInterlace         : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_plte (hHandle            : mng_handle;
                             iCount             : mng_uint32;
                             aPalette           : mng_palette8 ) : mng_retcode; stdcall;

function  mng_putchunk_idat (hHandle            : mng_handle;
                             iRawlen            : mng_uint32;
                             pRawdata           : mng_ptr      ) : mng_retcode; stdcall;

function  mng_putchunk_iend (hHandle            : mng_handle   ) : mng_retcode; stdcall;

function  mng_putchunk_trns (hHandle            : mng_handle;
                             bEmpty             : mng_bool;
                             bGlobal            : mng_bool;
                             iType              : mng_uint8;
                             iCount             : mng_uint32;
                             aAlphas            : mng_uint8arr;
                             iGray              : mng_uint16;
                             iRed               : mng_uint16;
                             iGreen             : mng_uint16;
                             iBlue              : mng_uint16;
                             iRawlen            : mng_uint32;
                             aRawdata           : mng_uint8arr ) : mng_retcode; stdcall;

function  mng_putchunk_gama (hHandle            : mng_handle;
                             bEmpty             : mng_bool;
                             iGamma             : mng_uint32   ) : mng_retcode; stdcall;

function  mng_putchunk_chrm (hHandle            : mng_handle;
                             bEmpty             : mng_bool;
                             iWhitepointx       : mng_uint32;
                             iWhitepointy       : mng_uint32;
                             iRedx              : mng_uint32;
                             iRedy              : mng_uint32;
                             iGreenx            : mng_uint32;
                             iGreeny            : mng_uint32;
                             iBluex             : mng_uint32;
                             iBluey             : mng_uint32   ) : mng_retcode; stdcall;

function  mng_putchunk_srgb (hHandle            : mng_handle;
                             bEmpty             : mng_bool;
                             iRenderingintent   : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_iccp (hHandle            : mng_handle;
                             bEmpty             : mng_bool;
                             iNamesize          : mng_uint32;
                             zName              : mng_pchar;
                             iCompression       : mng_uint8;
                             iProfilesize       : mng_uint32;
                             pProfile           : mng_ptr      ) : mng_retcode; stdcall;

function  mng_putchunk_text (hHandle            : mng_handle;
                             iKeywordsize       : mng_uint32;
                             zKeyword           : mng_pchar;
                             iTextsize          : mng_uint32;
                             zText              : mng_pchar    ) : mng_retcode; stdcall;

function  mng_putchunk_ztxt (hHandle            : mng_handle;
                             iKeywordsize       : mng_uint32;
                             zKeyword           : mng_pchar;
                             iCompression       : mng_uint8;
                             iTextsize          : mng_uint32;
                             zText              : mng_pchar    ) : mng_retcode; stdcall;

function  mng_putchunk_itxt (hHandle            : mng_handle;
                             iKeywordsize       : mng_uint32;
                             zKeyword           : mng_pchar;
                             iCompressionflag   : mng_uint8;
                             iCompressionmethod : mng_uint8;
                             iLanguagesize      : mng_uint32;
                             zLanguage          : mng_pchar;
                             iTranslationsize   : mng_uint32;
                             zTranslation       : mng_pchar;
                             iTextsize          : mng_uint32;
                             zText              : mng_pchar    ) : mng_retcode; stdcall;

function  mng_putchunk_bkgd (hHandle            : mng_handle;
                             bEmpty             : mng_bool;
                             iType              : mng_uint8;
                             iIndex             : mng_uint8;
                             iGray              : mng_uint16;
                             iRed               : mng_uint16;
                             iGreen             : mng_uint16;
                             iBlue              : mng_uint16   ) : mng_retcode; stdcall;

function  mng_putchunk_phys (hHandle            : mng_handle;
                             bEmpty             : mng_bool;
                             iSizex             : mng_uint32;
                             iSizey             : mng_uint32;
                             iUnit              : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_sbit (hHandle            : mng_handle;
                             bEmpty             : mng_bool;
                             iType              : mng_uint8;
                             aBits              : mng_uint8arr4) : mng_retcode; stdcall;

function  mng_putchunk_splt (hHandle            : mng_handle;
                             bEmpty             : mng_bool;
                             iNamesize          : mng_uint32;
                             zName              : mng_pchar;
                             iSampledepth       : mng_uint8;
                             iEntrycount        : mng_uint32;
                             pEntries           : mng_ptr      ) : mng_retcode; stdcall;

function  mng_putchunk_hist (hHandle            : mng_handle;
                             iEntrycount        : mng_uint32;
                             aEntries           : mng_uint16arr) : mng_retcode; stdcall;

function  mng_putchunk_time (hHandle            : mng_handle;
                             iYear              : mng_uint16;
                             iMonth             : mng_uint8;
                             iDay               : mng_uint8;
                             iHour              : mng_uint8;
                             iMinute            : mng_uint8;
                             iSecond            : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_jhdr (hHandle            : mng_handle;
                             iWidth             : mng_uint32;
                             iHeight            : mng_uint32;
                             iColortype         : mng_uint8;
                             iImagesampledepth  : mng_uint8;
                             iImagecompression  : mng_uint8;
                             iImageinterlace    : mng_uint8;
                             iAlphasampledepth  : mng_uint8;
                             iAlphacompression  : mng_uint8;
                             iAlphafilter       : mng_uint8;
                             iAlphainterlace    : mng_uint8    ) : mng_retcode; stdcall;

function  mng_putchunk_jdat (hHandle            : mng_handle;
                             iRawlen            : mng_uint32;
                             pRawdata           : mng_ptr      ) : mng_retcode; stdcall;

function  mng_putchunk_jsep (hHandle            : mng_handle   ) : mng_retcode; stdcall;

{****************************************************************************}

const MNG_NOERROR          = 0;

      MNG_OUTOFMEMORY      = 1;
      MNG_INVALIDHANDLE    = 2;
      MNG_NOCALLBACK       = 3;
      MNG_UNEXPECTEDEOF    = 4;
      MNG_ZLIBERROR        = 5;
      MNG_JPEGERROR        = 6;
      MNG_LCMSERROR        = 7;
      MNG_NOOUTPUTPROFILE  = 8;
      MNG_NOSRGBPROFILE    = 9;
      MNG_BUFOVERFLOW      = 10;
      MNG_FUNCTIONINVALID  = 11;
      MNG_OUTPUTERROR      = 12;
      MNG_JPEGBUFTOOSMALL  = 13;
      MNG_NEEDMOREDATA     = 14;
      MNG_NEEDTIMERWAIT    = 15;
      MNG_NEEDSECTIONWAIT  = 16;

      MNG_APPIOERROR       = 901;
      MNG_APPTIMERERROR    = 902;
      MNG_APPCMSERROR      = 903;
      MNG_APPMISCERROR     = 904;
      MNG_APPTRACEABORT    = 905;

      MNG_INTERNALERROR    = 999;

      MNG_INVALIDSIG       = 1025;
      MNG_INVALIDCRC       = 1027;
      MNG_INVALIDLENGTH    = 1028;
      MNG_SEQUENCEERROR    = 1029;
      MNG_CHUNKNOTALLOWED  = 1030;
      MNG_MULTIPLEERROR    = 1031;
      MNG_PLTEMISSING      = 1032;
      MNG_IDATMISSING      = 1033;
      MNG_CANNOTBEEMPTY    = 1034;
      MNG_GLOBALLENGTHERR  = 1035;
      MNG_INVALIDBITDEPTH  = 1036;
      MNG_INVALIDCOLORTYPE = 1037;
      MNG_INVALIDCOMPRESS  = 1038;
      MNG_INVALIDFILTER    = 1039;
      MNG_INVALIDINTERLACE = 1040;
      MNG_NOTENOUGHIDAT    = 1041;
      MNG_PLTEINDEXERROR   = 1042;
      MNG_NULLNOTFOUND     = 1043;
      MNG_KEYWORDNULL      = 1044;
      MNG_OBJECTUNKNOWN    = 1045;
      MNG_OBJECTEXISTS     = 1046;
      MNG_TOOMUCHIDAT      = 1047;
      MNG_INVSAMPLEDEPTH   = 1048;
      MNG_INVOFFSETSIZE    = 1049;
      MNG_INVENTRYTYPE     = 1050;
      MNG_ENDWITHNULL      = 1051;
      MNG_INVIMAGETYPE     = 1052;
      MNG_INVDELTATYPE     = 1053;
      MNG_INVALIDINDEX     = 1054;
      MNG_TOOMUCHJDAT      = 1055;
      MNG_JPEGPARMSERR     = 1056;
      MNG_INVFILLMETHOD    = 1057;
      MNG_OBJNOTCONCRETE   = 1058;
      MNG_TARGETNOALPHA    = 1059;

      MNG_INVALIDCNVSTYLE  = 2049;
      MNG_WRONGCHUNK       = 2050;
      MNG_INVALIDENTRYIX   = 2051;
      MNG_NOHEADER         = 2052;
      MNG_NOCORRCHUNK      = 2053;
      MNG_NOMHDR           = 2054;

      MNG_IMAGETOOLARGE    = 4097;
      MNG_NOTANANIMATION   = 4098;
      MNG_FRAMENRTOOHIGH   = 4099;
      MNG_LAYERNRTOOHIGH   = 4100;
      MNG_PLAYTIMETOOHIGH  = 4101;
      MNG_FNNOTIMPLEMENTED = 4102;

      MNG_IMAGEFROZEN      = 8193;

{****************************************************************************}

const MNG_CANVAS_RGB8      = $00000000;
      MNG_CANVAS_RGBA8     = $00001000;
      MNG_CANVAS_ARGB8     = $00003000;
      MNG_CANVAS_RGB8_A8   = $00005000;
      MNG_CANVAS_BGR8      = $00000001;
      MNG_CANVAS_BGRA8     = $00001001;
      MNG_CANVAS_ABGR8     = $00003001;

{****************************************************************************}
{* LIBMNG interface definitions for ZLIB                                    *}
{****************************************************************************}
{*                                                                          *}
{*  Uses "zlib" - a mighty, patent-free(!) (de)compression-library          *}
{*  copyright (C) 1995-1998 Jean-loup Gailly and Mark Adler                 *}
{*  http://www.info-zip.org/pub/infozip/zlib                                *}
{*                                                                          *}
{****************************************************************************}

{$IFDEF INCLUDE_ZLIB}

{****************************************************************************}

function InflateString  (    Input      : string;
                         var Output     : string ) : integer;

function DeflateString  (    Input      : string;
                         var Output     : string ) : integer;

function InflateString2 (    Input      : string;
                         var Output     : string;
                             windowBits : integer) : integer;

function DeflateString2 (    Input      : string;
                         var Output     : string;
                             level      : integer;
                             method     : integer;
                             windowBits : integer;
                             memLevel   : integer;
                             strategy   : integer) : integer;

{****************************************************************************}

const
  ZLIB_VERSION = '1.1.3';

{****************************************************************************}

type
  alloc_func = function  (opaque  : pointer;
                          items   : integer;
                          size    : integer) : pointer; stdcall;
  free_func  = procedure (opaque  : pointer;
                          address : pointer); stdcall;

{****************************************************************************}

type
  z_stream   = packed record
                 next_in   : pointer;
                 avail_in  : integer;
                 total_in  : cardinal;

                 next_out  : pointer;
                 avail_out : integer;
                 total_out : cardinal;

                 msg       : pchar;
                 state     : pointer;    { reserved }

                 zalloc    : alloc_func;
                 zfree     : free_func;
                 opaque    : pointer;

                 data_type : integer;
                 adler     : cardinal;
                 reserved  : cardinal;
               end;

  z_streamp  = ^z_stream;

{****************************************************************************}

const
  Z_NO_FLUSH            = 0;
  Z_PARTIAL_FLUSH       = 1;
  Z_SYNC_FLUSH          = 2;
  Z_FULL_FLUSH          = 3;
  Z_FINISH              = 4;

  Z_OK                  = 0;
  Z_STREAM_END          = 1;
  Z_NEED_DICT           = 2;
  Z_ERRNO               = -1;
  Z_STREAM_ERROR        = -2;
  Z_DATA_ERROR          = -3;
  Z_MEM_ERROR           = -4;
  Z_BUF_ERROR           = -5;
  Z_VERSION_ERROR       = -6;

  Z_NO_COMPRESSION      = 0;
  Z_BEST_SPEED          = 1;
  Z_BEST_COMPRESSION    = 9;
  Z_DEFAULT_COMPRESSION = -1;

  Z_FILTERED            = 1;
  Z_HUFFMAN_ONLY        = 2;
  Z_DEFAULT_STRATEGY    = 0;

  Z_BINARY              = 0;
  Z_ASCII               = 1;
  Z_UNKNOWN             = 2;

  Z_DEFLATED            = 8;

  Z_NULL                = 0;

  Z_MAX_MEM_LEVEL       = 9;
  Z_DEF_MEM_LEVEL       = 8;

{****************************************************************************}

function zlibVersion : pchar; stdcall;

function deflateInit          (strm        : z_streamp;
                               level       : integer  ) : integer; stdcall;

function deflate              (strm        : z_streamp;
                               flush       : integer  ) : integer; stdcall;

function deflateEnd           (strm        : z_streamp) : integer; stdcall;

function inflateInit          (strm        : z_streamp) : integer; stdcall;

function inflate              (strm        : z_streamp;
                               flush       : integer  ) : integer; stdcall;

function inflateEnd           (strm        : z_streamp) : integer; stdcall;

function deflateInit2         (strm        : z_streamp;
                               level       : integer;
                               method      : integer;
                               windowBits  : integer;
                               memLevel    : integer;
                               strategy    : integer  ) : integer; stdcall;

function deflateSetDictionary (strm        : z_streamp;
                               dictionary  : pointer;
                               dictLength  : cardinal ) : integer; stdcall;

function deflateCopy          (dest        : z_streamp;
                               source      : z_streamp) : integer; stdcall;

function deflateReset         (strm        : z_streamp) : integer; stdcall;

function deflateParams        (strm        : z_streamp;
                               level       : integer;
                               strategy    : integer  ) : integer; stdcall;

function inflateInit2         (strm        : z_streamp;
                               windowBits  : integer  ) : integer; stdcall;

function inflateSetDictionary (strm        : z_streamp;
                               dictionary  : pointer;
                               dictLength  : cardinal ) : integer; stdcall;

function inflateSync          (strm        : z_streamp) : integer; stdcall;

function inflateReset         (strm        : z_streamp) : integer; stdcall;

function compress             (dest        : pointer;
                               var destLen : cardinal;
                               source      : pointer;
                               sourceLen   : cardinal ) : integer; stdcall;

function compress2            (dest        : pointer;
                               var destLen : cardinal;
                               source      : pointer;
                               sourceLen   : cardinal;
                               level       : integer  ) : integer; stdcall;

function uncompress           (dest        : pointer;
                               var destLen : cardinal;
                               source      : pointer;
                               sourceLen   : cardinal ) : integer; stdcall;

function adler32              (adler       : cardinal;
                               buf         : pointer;
                               len         : cardinal ) : cardinal; stdcall;

function crc32                (crc         : cardinal;
                               buf         : pointer;
                               len         : cardinal ) : cardinal; stdcall;

function zError               (err         : integer  ) : pchar;

function inflateSyncPoint     (strm        : z_streamp) : integer; stdcall;

function get_crc_table : pointer; stdcall;

{****************************************************************************}

{$ENDIF} // INCLUDE_ZLIB

{****************************************************************************}
{* LIBMNG interface definitions for JPEG                                    *}
{****************************************************************************}
{*                                                                          *}
{*  Based in part on the works of the Independant JPEG Group (IJG)          *}
{*  copyright (C) 1991-1998 Thomas G. Lane                                  *}
{*  http://www.ijg.org                                                      *}
{*                                                                          *}
{*  The implementation of the TJPEGImage is based on sample code in the     *}
{*  JPEG unit provided with Borland Delphi.                                 *}
{*  Copyright (c) 1997 Borland International                                *}
{*  (only adapted to work with ijgsrc6b in libmng.dll)                      *}
{*                                                                          *}
{****************************************************************************}

{$IFDEF INCLUDE_JPEG}

{***************************************************************************}

resourcestring
  sChangeJPGSize = 'Cannot change the size of a JPEG image';
  sJPEGError = 'JPEG error #%d';

{***************************************************************************}

type
  TJPEGQualityRange = 1..100;   // 100 = best quality, 25 = pretty awful
  TJPEGPerformance = (jpBestQuality, jpBestSpeed);
  TJPEGScale = (jsFullSize, jsHalf, jsQuarter, jsEighth);
  TJPEGPixelFormat = (jf24Bit, jf8Bit);

{***************************************************************************}

type
  TJPEGData = class(TSharedImage)
  private
    FData: TCustomMemoryStream;
    FHeight: Integer;
    FWidth: Integer;
    FGrayscale: Boolean;
    FBuffer: Pointer;                  // added for JPEGLIB streaming support
    FSize: Integer;                    // size of buffer

  protected
    procedure FreeHandle; override;

  public
    constructor Create;
    destructor Destroy; override;

    property PData: TCustomMemoryStream read FData;

  end;

  TJPEGImage = class(TGraphic)
  private
    FImage: TJPEGData;
    FBitmap: TBitmap;
    FScaledWidth: Integer;
    FScaledHeight: Integer;
    FTempPal: HPalette;
    FSmoothing: Boolean;
    FGrayScale: Boolean;
    FPixelFormat: TJPEGPixelFormat;
    FQuality: TJPEGQualityRange;
    FProgressiveDisplay: Boolean;
    FProgressiveEncoding: Boolean;
    FPerformance: TJPEGPerformance;
    FScale: TJPEGScale;
    FNeedRecalc: Boolean;

    procedure CalcOutputDimensions;
    function GetBitmap: TBitmap;
    function GetGrayscale: Boolean;
    procedure SetGrayscale(Value: Boolean);
    procedure SetPerformance(Value: TJPEGPerformance);
    procedure SetPixelFormat(Value: TJPEGPixelFormat);
    procedure SetScale(Value: TJPEGScale);
    procedure SetSmoothing(Value: Boolean);

  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure Changed(Sender: TObject); override;
    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
    function Equals(Graphic: TGraphic): Boolean; override;
    procedure FreeBitmap;
    function GetEmpty: Boolean; override;
    function GetHeight: Integer; override;
    function GetPalette: HPALETTE; override;
    function GetWidth: Integer; override;
    procedure NewBitmap;
    procedure NewImage;
    procedure ReadData(Stream: TStream); override;
    procedure ReadStream(Size: Longint; Stream: TStream);
    procedure SetHeight(Value: Integer); override;
    procedure SetPalette(Value: HPalette); override;
    procedure SetWidth(Value: Integer); override;
    procedure WriteData(Stream: TStream); override;

  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Compress;
    procedure DIBNeeded;
    procedure JPEGNeeded;
    procedure Assign(Source: TPersistent); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle;
      APalette: HPALETTE); override;
    procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle;
      var APalette: HPALETTE); override;

    property Bitmap: TBitmap read GetBitmap;  // volatile
    property PData: TJPEGData read FImage;
    // Options affecting / reflecting compression and decompression behavior
    property Grayscale: Boolean read GetGrayscale write SetGrayscale;
    property ProgressiveEncoding: Boolean read FProgressiveEncoding write FProgressiveEncoding;

    // Compression options
    property CompressionQuality: TJPEGQualityRange read FQuality write FQuality;

    // Decompression options
    property PixelFormat: TJPEGPixelFormat read FPixelFormat write SetPixelFormat;
    property ProgressiveDisplay: Boolean read FProgressiveDisplay write FProgressiveDisplay;
    property Performance: TJPEGPerformance read FPerformance write SetPerformance;
    property Scale: TJPEGScale read FScale write SetScale;
    property Smoothing: Boolean read FSmoothing write SetSmoothing;

  end;

{***************************************************************************}

  TJPEGDefaults = record
    CompressionQuality: TJPEGQualityRange;
    Grayscale: Boolean;
    Performance: TJPEGPerformance;
    PixelFormat: TJPEGPixelFormat;
    ProgressiveDisplay: Boolean;
    ProgressiveEncoding: Boolean;
    Scale: TJPEGScale;
    Smoothing: Boolean;
  end;

{***************************************************************************}

var   // Default settings for all new TJPEGImage instances
  JPEGDefaults: TJPEGDefaults = (
    CompressionQuality: 90;
    Grayscale: False;
    Performance: jpBestQuality;
    PixelFormat: jf24Bit;         // initialized to match video mode
    ProgressiveDisplay: False;
    ProgressiveEncoding: False;
    Scale: jsFullSize;
    Smoothing: True;
  );

{***************************************************************************}

{ The following types and external function declarations are used to
  call into functions of the Independent JPEG Group's (IJG) implementation
  of the JPEG image compression/decompression public standard.  The IJG
  library's C source code is compiled into OBJ files and linked into
  the Delphi application. Only types and functions needed by this unit
  are declared; all IJG internal structures are stubbed out with
  generic pointers to reduce internal source code congestion.

  IJG source code copyright (C) 1991-1996, Thomas G. Lane. }

{$Z4}  // Minimum enum size = dword

const
  JPEG_LIB_VERSION = 62;        { Version 6b }

  JPEG_RST0     = $D0;  { RST0 marker code }
  JPEG_EOI      = $D9;  { EOI marker code }
  JPEG_APP0     = $E0;  { APP0 marker code }
  JPEG_COM      = $FE;  { COM marker code }

  DCTSIZE             = 8;      { The basic DCT block is 8x8 samples }
  DCTSIZE2            = 64;     { DCTSIZE squared; # of elements in a block }
  NUM_QUANT_TBLS      = 4;      { Quantization tables are numbered 0..3 }
  NUM_HUFF_TBLS       = 4;      { Huffman tables are numbered 0..3 }
  NUM_ARITH_TBLS      = 16;     { Arith-coding tables are numbered 0..15 }
  MAX_COMPS_IN_SCAN   = 4;      { JPEG limit on # of components in one scan }
  MAX_SAMP_FACTOR     = 4;      { JPEG limit on sampling factors }
  C_MAX_BLOCKS_IN_MCU = 10;     { compressor's limit on blocks per MCU }
  D_MAX_BLOCKS_IN_MCU = 10;     { decompressor's limit on blocks per MCU }
  MAX_COMPONENTS = 10;          { maximum number of image components (color channels) }

  MAXJSAMPLE = 255;
  CENTERJSAMPLE = 128;

type
  JSAMPLE = byte;
  GETJSAMPLE = integer;
  JCOEF = word;
  JCOEF_PTR = ^JCOEF;
  UINT8 = byte;
  UINT16 = Word;
  UINT = Cardinal;
  INT16 = SmallInt;
  INT32 = Integer;
  INT32PTR = ^INT32;
  JDIMENSION = Cardinal;

  JOCTET = Byte;
  jTOctet = 0..(MaxInt div SizeOf(JOCTET))-1;
  JOCTET_FIELD = array[jTOctet] of JOCTET;
  JOCTET_FIELD_PTR = ^JOCTET_FIELD;
  JOCTETPTR = ^JOCTET;

  JSAMPLE_PTR = ^JSAMPLE;
  JSAMPROW_PTR = ^JSAMPROW;

  jTSample = 0..(MaxInt div SIZEOF(JSAMPLE))-1;
  JSAMPLE_ARRAY = Array[jTSample] of JSAMPLE;  {far}
  JSAMPROW = ^JSAMPLE_ARRAY;  { ptr to one image row of pixel samples. }

  jTRow = 0..(MaxInt div SIZEOF(JSAMPROW))-1;
  JSAMPROW_ARRAY = Array[jTRow] of JSAMPROW;
  JSAMPARRAY = ^JSAMPROW_ARRAY;  { ptr to some rows (a 2-D sample array) }

  jTArray = 0..(MaxInt div SIZEOF(JSAMPARRAY))-1;
  JSAMP_ARRAY = Array[jTArray] of JSAMPARRAY;
  JSAMPIMAGE = ^JSAMP_ARRAY;  { a 3-D sample array: top index is color }

const
  CSTATE_START        = 100;    { after create_compress }
  CSTATE_SCANNING     = 101;    { start_compress done, write_scanlines OK }
  CSTATE_RAW_OK       = 102;    { start_compress done, write_raw_data OK }
  CSTATE_WRCOEFS      = 103;    { jpeg_write_coefficients done }
  DSTATE_START        = 200;    { after create_decompress }
  DSTATE_INHEADER     = 201;    { reading header markers, no SOS yet }
  DSTATE_READY        = 202;    { found SOS, ready for start_decompress }
  DSTATE_PRELOAD      = 203;    { reading multiscan file in start_decompress}
  DSTATE_PRESCAN      = 204;    { performing dummy pass for 2-pass quant }
  DSTATE_SCANNING     = 205;    { start_decompress done, read_scanlines OK }
  DSTATE_RAW_OK       = 206;    { start_decompress done, read_raw_data OK }
  DSTATE_BUFIMAGE     = 207;    { expecting jpeg_start_output }
  DSTATE_BUFPOST      = 208;    { looking for SOS/EOI in jpeg_finish_output }
  DSTATE_RDCOEFS      = 209;    { reading file in jpeg_read_coefficients }
  DSTATE_STOPPING     = 210;    { looking for EOI in jpeg_finish_decompress }

{ Known color spaces. }

type
  J_COLOR_SPACE = (
  JCS_UNKNOWN,            { error/unspecified }
  JCS_GRAYSCALE,          { monochrome }
  JCS_RGB,                { red/green/blue }
  JCS_YCbCr,              { Y/Cb/Cr (also known as YUV) }
  JCS_CMYK,               { C/M/Y/K }
  JCS_YCCK                { Y/Cb/Cr/K }
                  );

{ DCT/IDCT algorithm options. }

type
  J_DCT_METHOD = (
	JDCT_ISLOW,		{ slow but accurate integer algorithm }
	JDCT_IFAST,		{ faster, less accurate integer method }
	JDCT_FLOAT		{ floating-point: accurate, fast on fast HW (Pentium)}
                 );

{ Dithering options for decompression. }

type
  J_DITHER_MODE = (
    JDITHER_NONE,               { no dithering }
    JDITHER_ORDERED,            { simple ordered dither }
    JDITHER_FS                  { Floyd-Steinberg error diffusion dither }
                  );

{ Error handler }

const
  JMSG_LENGTH_MAX  = 200;  { recommended size of format_message buffer }
  JMSG_STR_PARM_MAX = 80;

  JPOOL_PERMANENT = 0;  // lasts until master record is destroyed
  JPOOL_IMAGE	    = 1;	 // lasts until done with image/datastream

type
  jpeg_error_mgr_ptr = ^jpeg_error_mgr;
  jpeg_progress_mgr_ptr = ^jpeg_progress_mgr;

  j_common_ptr = ^jpeg_common_struct;
  j_compress_ptr = ^jpeg_compress_struct;
  j_decompress_ptr = ^jpeg_decompress_struct;

{ Routine signature for application-supplied marker processing methods.
  Need not pass marker code since it is stored in cinfo^.unread_marker. }

  jpeg_marker_parser_method = function(cinfo : j_decompress_ptr) : LongBool; stdcall;

{ Marker reading & parsing }
  jpeg_marker_reader_ptr = ^jpeg_marker_reader;
  jpeg_marker_reader = packed record
    reset_marker_reader : procedure(cinfo : j_decompress_ptr); stdcall;
    { Read markers until SOS or EOI.
      Returns same codes as are defined for jpeg_consume_input:
      JPEG_SUSPENDED, JPEG_REACHED_SOS, or JPEG_REACHED_EOI. }

    read_markers : function (cinfo : j_decompress_ptr) : Integer; stdcall;
    { Read a restart marker --- exported for use by entropy decoder only }
    read_restart_marker : jpeg_marker_parser_method;
    { Application-overridable marker processing methods }
//    process_COM : jpeg_marker_parser_method;
//    process_APPn : Array[0..16-1] of jpeg_marker_parser_method;

    { State of marker reader --- nominally internal, but applications
      supplying COM or APPn handlers might like to know the state. }

    saw_SOI : LongBool;            { found SOI? }
    saw_SOF : LongBool;            { found SOF? }
    next_restart_num : Integer;    { next restart number expected (0-7) }
    discarded_bytes : UINT;        { # of bytes skipped looking for a marker }
  end;

  {int8array = Array[0..8-1] of int;}
  int8array = Array[0..8-1] of Integer;

  jpeg_error_mgr = record
    { Error exit handler: does not return to caller }
    error_exit : procedure  (cinfo : j_common_ptr); stdcall;
    { Conditionally emit a trace or warning message }
    emit_message : procedure (cinfo : j_common_ptr; msg_level : Integer); stdcall;
    { Routine that actually outputs a trace or error message }
    output_message : procedure (cinfo : j_common_ptr); stdcall;
    { Format a message string for the most recent JPEG error or message }
    format_message : procedure  (cinfo : j_common_ptr; buffer: PChar); stdcall;
    { Reset error state variables at start of a new image }
    reset_error_mgr : procedure (cinfo : j_common_ptr); stdcall;

    { The message ID code and any parameters are saved here.
      A message can have one string parameter or up to 8 int parameters. }

    msg_code : Integer;

    msg_parm : record
      case byte of
      0:(i : int8array);
      1:(s : string[JMSG_STR_PARM_MAX]);
    end;
    trace_level : Integer;     { max msg_level that will be displayed }
    num_warnings : Integer;    { number of corrupt-data warnings }
    jpeg_message_table : Pointer; { Library errors }
    last_jpeg_message : Integer;    { Table contains strings 0..last_jpeg_message }
    { Second table can be added by application (see cjpeg/djpeg for example).
      It contains strings numbered first_addon_message..last_addon_message. }
    addon_message_table : Pointer; { Non-library errors }
    first_addon_message : Integer;	{ code for first string in addon table }
    last_addon_message : Integer;	{ code for last string in addon table }
  end;


{ Data destination object for compression }
  jpeg_destination_mgr_ptr = ^jpeg_destination_mgr;
  jpeg_destination_mgr = record
    next_output_byte : JOCTETptr;  { => next byte to write in buffer }
    free_in_buffer : Longint;    { # of byte spaces remaining in buffer }

    init_destination : procedure (cinfo : j_compress_ptr); stdcall;
    empty_output_buffer : function (cinfo : j_compress_ptr) : LongBool; stdcall;
    term_destination : procedure (cinfo : j_compress_ptr); stdcall;
  end;


{ Data source object for decompression }

  jpeg_source_mgr_ptr = ^jpeg_source_mgr;
  jpeg_source_mgr = record
    next_input_byte : JOCTETptr;      { => next byte to read from buffer }
    bytes_in_buffer : Longint;       { # of bytes remaining in buffer }

    init_source : procedure  (cinfo : j_decompress_ptr); stdcall;
    fill_input_buffer : function (cinfo : j_decompress_ptr) : LongBool; stdcall;
    skip_input_data : procedure (cinfo : j_decompress_ptr; num_bytes : Longint); stdcall;
    resync_to_restart : function (cinfo : j_decompress_ptr;
                                  desired : Integer) : LongBool; stdcall;
    term_source : procedure (cinfo : j_decompress_ptr); stdcall;
  end;

{ JPEG library memory manger routines }
  jpeg_memory_mgr_ptr = ^jpeg_memory_mgr;
  jpeg_memory_mgr = record
    { Method pointers }
    alloc_small : function (cinfo : j_common_ptr;
                            pool_id, sizeofobject: Integer): pointer; stdcall;
    alloc_large : function (cinfo : j_common_ptr;
                            pool_id, sizeofobject: Integer): pointer; stdcall;
    alloc_sarray : function (cinfo : j_common_ptr; pool_id : Integer;
                             samplesperrow : JDIMENSION;
                             numrows : JDIMENSION) : JSAMPARRAY; stdcall;
    alloc_barray : pointer;
    request_virt_sarray : pointer;
    request_virt_barray : pointer;
    realize_virt_arrays : pointer;
    access_virt_sarray : pointer;
    access_virt_barray : pointer;
    free_pool : pointer;
    self_destruct : pointer;
    max_memory_to_use : Longint;
    max_alloc_chunk : Longint;
  end;

    { Fields shared with jpeg_decompress_struct }
  jpeg_common_struct = packed record
    err : jpeg_error_mgr_ptr;        { Error handler module }
    mem : jpeg_memory_mgr_ptr;          { Memory manager module }
    progress : jpeg_progress_mgr_ptr;   { Progress monitor, or NIL if none }
    client_data : Pointer;            { Available for use by application }
    is_decompressor : LongBool;      { so common code can tell which is which }
    global_state : Integer;          { for checking call sequence validity }
  end;

{ Progress monitor object }

  jpeg_progress_mgr = record
    progress_monitor : procedure(const cinfo : jpeg_common_struct); stdcall;
    pass_counter : Integer;     { work units completed in this pass }
    pass_limit : Integer;       { total number of work units in this pass }
    completed_passes : Integer;	{ passes completed so far }
    total_passes : Integer;     { total number of passes expected }
    // extra Delphi info
    instance: TJPEGImage;       // ptr to current TJPEGImage object
    last_pass: Integer;
    last_pct: Integer;
    last_time: Integer;
    last_scanline: Integer;
  end;


{ Master record for a compression instance }

  jpeg_compress_struct = packed record
    common: jpeg_common_struct;

    dest : jpeg_destination_mgr_ptr; { Destination for compressed data }

  { Description of source image --- these fields must be filled in by
    outer application before starting compression.  in_color_space must
    be correct before you can even call jpeg_set_defaults(). }

    image_width : JDIMENSION;         { input image width }
    image_height : JDIMENSION;        { input image height }
    input_components : Integer;       { # of color components in input image }
    in_color_space : J_COLOR_SPACE;   { colorspace of input image }
    input_gamma : double;             { image gamma of input image }

    // Compression parameters
    data_precision : Integer;             { bits of precision in image data }
    num_components : Integer;             { # of color components in JPEG image }
    jpeg_color_space : J_COLOR_SPACE;     { colorspace of JPEG image }
    comp_info : Pointer;
    quant_tbl_ptrs: Array[0..NUM_QUANT_TBLS-1] of Pointer;
    dc_huff_tbl_ptrs : Array[0..NUM_HUFF_TBLS-1] of Pointer;
    ac_huff_tbl_ptrs : Array[0..NUM_HUFF_TBLS-1] of Pointer;
    arith_dc_L : Array[0..NUM_ARITH_TBLS-1] of UINT8; { L values for DC arith-coding tables }
    arith_dc_U : Array[0..NUM_ARITH_TBLS-1] of UINT8; { U values for DC arith-coding tables }
    arith_ac_K : Array[0..NUM_ARITH_TBLS-1] of UINT8; { Kx values for AC arith-coding tables }
    num_scans : Integer;		 { # of entries in scan_info array }
    scan_info : Pointer;     { script for multi-scan file, or NIL }
    raw_data_in : LongBool;        { TRUE=caller supplies downsampled data }
    arith_code : LongBool;         { TRUE=arithmetic coding, FALSE=Huffman }
    optimize_coding : LongBool;    { TRUE=optimize entropy encoding parms }
    CCIR601_sampling : LongBool;   { TRUE=first samples are cosited }
    smoothing_factor : Integer;       { 1..100, or 0 for no input smoothing }
    dct_method : J_DCT_METHOD;    { DCT algorithm selector }
    restart_interval : UINT;      { MCUs per restart, or 0 for no restart }
    restart_in_rows : Integer;        { if > 0, MCU rows per restart interval }

    { Parameters controlling emission of special markers. }
    write_JFIF_header : LongBool;  { should a JFIF marker be written? }
    JFIF_major_version : UINT8;  { What to write for the JFIF version number }
    JFIF_minor_version : UINT8;
    { These three values are not used by the JPEG code, merely copied }
    { into the JFIF APP0 marker.  density_unit can be 0 for unknown, }
    { 1 for dots/inch, or 2 for dots/cm.  Note that the pixel aspect }
    { ratio is defined by X_density/Y_density even when density_unit=0. }
    density_unit : UINT8;         { JFIF code for pixel size units }
    dummy1 : byte;
    X_density : UINT16;           { Horizontal pixel density }
    Y_density : UINT16;           { Vertical pixel density }
    write_Adobe_marker : LongBool; { should an Adobe marker be written? }

    { State variable: index of next scanline to be written to
      jpeg_write_scanlines().  Application may use this to control its
      processing loop, e.g., "while (next_scanline < image_height)". }

    next_scanline : JDIMENSION;   { 0 .. image_height-1  }

    { Remaining fields are known throughout compressor, but generally
      should not be touched by a surrounding application. }
    progressive_mode : LongBool;   { TRUE if scan script uses progressive mode }
    max_h_samp_factor : Integer;      { largest h_samp_factor }
    max_v_samp_factor : Integer;      { largest v_samp_factor }
    total_iMCU_rows : JDIMENSION; { # of iMCU rows to be input to coef ctlr }
    comps_in_scan : Integer;          { # of JPEG components in this scan }
    cur_comp_info : Array[0..MAX_COMPS_IN_SCAN-1] of Pointer;
    MCUs_per_row : JDIMENSION;    { # of MCUs across the image }
    MCU_rows_in_scan : JDIMENSION;{ # of MCU rows in the image }
    blocks_in_MCU : Integer;          { # of DCT blocks per MCU }
    MCU_membership : Array[0..C_MAX_BLOCKS_IN_MCU-1] of Integer;
    Ss, Se, Ah, Al : Integer;         { progressive JPEG parameters for scan }

    { Links to compression subobjects (methods and private variables of modules) }
    master : Pointer;
    main : Pointer;
    prep : Pointer;
    coef : Pointer;
    marker : Pointer;
    cconvert : Pointer;
    downsample : Pointer;
    fdct : Pointer;
    entropy : Pointer;
    script_space : Pointer; { workspace for jpeg_simple_progression }
    script_space_size : Integer;
  end;


{ Master record for a decompression instance }

  jpeg_decompress_struct = packed record
    common: jpeg_common_struct;

    { Source of compressed data }
    src : jpeg_source_mgr_ptr;

    { Basic description of image --- filled in by jpeg_read_header(). }
    { Application may inspect these values to decide how to process image. }

    image_width : JDIMENSION;      { nominal image width (from SOF marker) }
    image_height : JDIMENSION;     { nominal image height }
    num_components : Integer;          { # of color components in JPEG image }
    jpeg_color_space : J_COLOR_SPACE; { colorspace of JPEG image }

    { Decompression processing parameters }
    out_color_space : J_COLOR_SPACE; { colorspace for output }
    scale_num, scale_denom : uint ;  { fraction by which to scale image }
    output_gamma : double;           { image gamma wanted in output }
    buffered_image : LongBool;        { TRUE=multiple output passes }
    raw_data_out : LongBool;          { TRUE=downsampled data wanted }
    dct_method : J_DCT_METHOD;       { IDCT algorithm selector }
    do_fancy_upsampling : LongBool;   { TRUE=apply fancy upsampling }
    do_block_smoothing : LongBool;    { TRUE=apply interblock smoothing }
    quantize_colors : LongBool;       { TRUE=colormapped output wanted }
    { the following are ignored if not quantize_colors: }
    dither_mode : J_DITHER_MODE;     { type of color dithering to use }
    two_pass_quantize : LongBool;     { TRUE=use two-pass color quantization }
    desired_number_of_colors : Integer;  { max # colors to use in created colormap }
    { these are significant only in buffered-image mode: }
    enable_1pass_quant : LongBool;    { enable future use of 1-pass quantizer }
    enable_external_quant : LongBool; { enable future use of external colormap }
    enable_2pass_quant : LongBool;    { enable future use of 2-pass quantizer }

    { Description of actual output image that will be returned to application.
      These fields are computed by jpeg_start_decompress().
      You can also use jpeg_calc_output_dimensions() to determine these values
      in advance of calling jpeg_start_decompress(). }

    output_width : JDIMENSION;       { scaled image width }
    output_height: JDIMENSION;       { scaled image height }
    out_color_components : Integer;  { # of color components in out_color_space }
    output_components : Integer;     { # of color components returned }
    { output_components is 1 (a colormap index) when quantizing colors;
      otherwise it equals out_color_components. }

    rec_outbuf_height : Integer;     { min recommended height of scanline buffer }
    { If the buffer passed to jpeg_read_scanlines() is less than this many
      rows high, space and time will be wasted due to unnecessary data
      copying. Usually rec_outbuf_height will be 1 or 2, at most 4. }

    { When quantizing colors, the output colormap is described by these
      fields. The application can supply a colormap by setting colormap
      non-NIL before calling jpeg_start_decompress; otherwise a colormap
      is created during jpeg_start_decompress or jpeg_start_output. The map
      has out_color_components rows and actual_number_of_colors columns. }

    actual_number_of_colors : Integer;      { number of entries in use }
    colormap : JSAMPARRAY;              { The color map as a 2-D pixel array }

    { State variables: these variables indicate the progress of decompression.
      The application may examine these but must not modify them. }

    { Row index of next scanline to be read from jpeg_read_scanlines().
      Application may use this to control its processing loop, e.g.,
      "while (output_scanline < output_height)". }

    output_scanline : JDIMENSION; { 0 .. output_height-1  }

    { Current input scan number and number of iMCU rows completed in scan.
      These indicate the progress of the decompressor input side. }

    input_scan_number : Integer;      { Number of SOS markers seen so far }
    input_iMCU_row : JDIMENSION;  { Number of iMCU rows completed }

    { The "output scan number" is the notional scan being displayed by the
      output side.  The decompressor will not allow output scan/row number
      to get ahead of input scan/row, but it can fall arbitrarily far behind.}

    output_scan_number : Integer;     { Nominal scan number being displayed }
    output_iMCU_row : JDIMENSION;        { Number of iMCU rows read }

    coef_bits : Pointer;

    { Internal JPEG parameters --- the application usually need not look at
      these fields.  Note that the decompressor output side may not use
      any parameters that can change between scans. }

    { Quantization and Huffman tables are carried forward across input
      datastreams when processing abbreviated JPEG datastreams. }

    quant_tbl_ptrs : Array[0..NUM_QUANT_TBLS-1] of Pointer;
    dc_huff_tbl_ptrs : Array[0..NUM_HUFF_TBLS-1] of Pointer;
    ac_huff_tbl_ptrs : Array[0..NUM_HUFF_TBLS-1] of Pointer;

    { These parameters are never carried across datastreams, since they
      are given in SOF/SOS markers or defined to be reset by SOI. }
    data_precision : Integer;          { bits of precision in image data }
    comp_info : Pointer;
    progressive_mode : LongBool;    { TRUE if SOFn specifies progressive mode }
    arith_code : LongBool;          { TRUE=arithmetic coding, FALSE=Huffman }
    arith_dc_L : Array[0..NUM_ARITH_TBLS-1] of UINT8; { L values for DC arith-coding tables }
    arith_dc_U : Array[0..NUM_ARITH_TBLS-1] of UINT8; { U values for DC arith-coding tables }
    arith_ac_K : Array[0..NUM_ARITH_TBLS-1] of UINT8; { Kx values for AC arith-coding tables }

    restart_interval : UINT; { MCUs per restart interval, or 0 for no restart }

    { These fields record data obtained from optional markers recognized by
      the JPEG library. }
    saw_JFIF_marker : LongBool;  { TRUE iff a JFIF APP0 marker was found }
    { Data copied from JFIF marker: }
    JFIF_major_version : UINT8;	{ JFIF version number }
    JFIF_minor_version : UINT8;
    density_unit : UINT8;       { JFIF code for pixel size units }
    dummy1 : byte;
    X_density : UINT16;         { Horizontal pixel density }
    Y_density : UINT16;         { Vertical pixel density }
    saw_Adobe_marker : LongBool; { TRUE iff an Adobe APP14 marker was found }
    Adobe_transform : UINT8;    { Color transform code from Adobe marker }
    dummy2 : array [0 .. 2] of byte;

    CCIR601_sampling : LongBool; { TRUE=first samples are cosited }

    {  Aside from the specific data retained from APPn markers known to the
      library, the uninterpreted contents of any or all APPn and COM markers
      can be saved in a list for examination by the application. }
    marker_list : Pointer; { Head of list of saved markers }

    { Remaining fields are known throughout decompressor, but generally
      should not be touched by a surrounding application. }
    max_h_samp_factor : Integer;    { largest h_samp_factor }
    max_v_samp_factor : Integer;    { largest v_samp_factor }
    min_DCT_scaled_size : Integer;  { smallest DCT_scaled_size of any component }
    total_iMCU_rows : JDIMENSION; { # of iMCU rows in image }
    sample_range_limit : Pointer;   { table for fast range-limiting }

    { These fields are valid during any one scan.
      They describe the components and MCUs actually appearing in the scan.
      Note that the decompressor output side must not use these fields. }
    comps_in_scan : Integer;           { # of JPEG components in this scan }
    cur_comp_info : Array[0..MAX_COMPS_IN_SCAN-1] of Pointer;
    MCUs_per_row : JDIMENSION;     { # of MCUs across the image }
    MCU_rows_in_scan : JDIMENSION; { # of MCU rows in the image }
    blocks_in_MCU : Integer;    { # of DCT blocks per MCU }
    MCU_membership : Array[0..D_MAX_BLOCKS_IN_MCU-1] of Integer;
    Ss, Se, Ah, Al : Integer;          { progressive JPEG parameters for scan }

    { This field is shared between entropy decoder and marker parser.
      It is either zero or the code of a JPEG marker that has been
      read from the data source, but has not yet been processed. }
    unread_marker : Integer;

    { Links to decompression subobjects
      (methods, private variables of modules) }
    master : Pointer;
    main : Pointer;
    coef : Pointer;
    post : Pointer;
    inputctl : Pointer;
    marker : Pointer;
    entropy : Pointer;
    idct : Pointer;
    upsample : Pointer;
    cconvert : Pointer;
    cquantize : Pointer;
  end;

  TJPEGContext = record
    err: jpeg_error_mgr;
    progress: jpeg_progress_mgr;
    FinalDCT: J_DCT_METHOD;
    FinalTwoPassQuant: Boolean;
    FinalDitherMode: J_DITHER_MODE;
    case byte of
      0: (common: jpeg_common_struct);
      1: (d: jpeg_decompress_struct);
      2: (c: jpeg_compress_struct);
  end;

{ Decompression startup: read start of JPEG datastream to see what's there
   function jpeg_read_header (cinfo : j_decompress_ptr;
                              require_image : LongBool) : Integer;
  Return value is one of: }
const
  JPEG_SUSPENDED              = 0; { Suspended due to lack of input data }
  JPEG_HEADER_OK              = 1; { Found valid image datastream }
  JPEG_HEADER_TABLES_ONLY     = 2; { Found valid table-specs-only datastream }
{ If you pass require_image = TRUE (normal case), you need not check for
  a TABLES_ONLY return code; an abbreviated file will cause an error exit.
  JPEG_SUSPENDED is only possible if you use a data source module that can
  give a suspension return (the stdio source module doesn't). }


{ function jpeg_consume_input (cinfo : j_decompress_ptr) : Integer;
  Return value is one of: }

  JPEG_REACHED_SOS            = 1; { Reached start of new scan }
  JPEG_REACHED_EOI            = 2; { Reached end of image }
  JPEG_ROW_COMPLETED          = 3; { Completed one iMCU row }
  JPEG_SCAN_COMPLETED         = 4; { Completed last iMCU row of a scan }

{***************************************************************************}

procedure jpeg_CreateDecompress (var cinfo : jpeg_decompress_struct;
  version : integer; structsize : integer); stdcall;
procedure jpeg_stdio_src(var cinfo: jpeg_decompress_struct;
  input_file: TStream); stdcall;
procedure jpeg_read_header(var cinfo: jpeg_decompress_struct;
  RequireImage: LongBool); stdcall;
procedure jpeg_calc_output_dimensions(var cinfo: jpeg_decompress_struct); stdcall;
function jpeg_start_decompress(var cinfo: jpeg_decompress_struct): Longbool; stdcall;
function jpeg_read_scanlines(var cinfo: jpeg_decompress_struct;
	scanlines: JSAMPARRAY; max_lines: JDIMENSION): JDIMENSION; stdcall;
function jpeg_finish_decompress(var cinfo: jpeg_decompress_struct): Longbool; stdcall;
procedure jpeg_destroy_decompress (var cinfo : jpeg_decompress_struct); stdcall;
function jpeg_has_multiple_scans(var cinfo: jpeg_decompress_struct): Longbool; stdcall;
function jpeg_consume_input(var cinfo: jpeg_decompress_struct): Integer; stdcall;
function jpeg_start_output(var cinfo: jpeg_decompress_struct; scan_number: Integer): Longbool; stdcall;
function jpeg_finish_output(var cinfo: jpeg_decompress_struct): LongBool; stdcall;
procedure jpeg_destroy(var cinfo: jpeg_common_struct); stdcall;

procedure jpeg_CreateCompress (var cinfo : jpeg_compress_struct;
  version : integer; structsize : integer); stdcall;
procedure jpeg_stdio_dest(var cinfo: jpeg_compress_struct;
  output_file: TStream); stdcall;
procedure jpeg_set_defaults(var cinfo: jpeg_compress_struct); stdcall;
procedure jpeg_set_quality(var cinfo: jpeg_compress_struct; Quality: Integer;
  Baseline: Longbool); stdcall;
procedure jpeg_set_colorspace(var cinfo: jpeg_compress_struct;
  colorspace: J_COLOR_SPACE); stdcall;
procedure jpeg_simple_progression(var cinfo: jpeg_compress_struct); stdcall;
procedure jpeg_start_compress(var cinfo: jpeg_compress_struct;
  WriteAllTables: LongBool); stdcall;
function jpeg_write_scanlines(var cinfo: jpeg_compress_struct;
  scanlines: JSAMPARRAY; max_lines: JDIMENSION): JDIMENSION; stdcall;
procedure jpeg_finish_compress(var cinfo: jpeg_compress_struct); stdcall;

function jpeg_resync_to_restart (cinfo : j_decompress_ptr; desired : Integer) : LongBool; stdcall;

{***************************************************************************}

procedure InitContext(var jc: TJPEGContext); stdcall;
procedure ReleaseContext(var jc: TJPEGContext); stdcall;

{****************************************************************************}

{$ENDIF} // INCLUDE_JPEG

{****************************************************************************}
{* actual object definitions                                                *}
{****************************************************************************}

type
  TNGImage  = class;

{****************************************************************************}
{* internal object to facilitate reference counting of a LIBMNG handle      *}
{****************************************************************************}

  TNGBitmap = class (TBitmap)
  private
    HFHandle          : mng_handle;         // libmng handle
    OFImages          : TList;              // parent TNGImage objects
    OFTimer           : TTimer;             // timer for MNG animation
    OFStream          : TStream;            // stream for load/save
    BFFreeOnClose     : boolean;            // free the stream on load/save completed
    BFHaveHeader      : boolean;            // processed PNG/JNG/MNG header chunk

    IFAlphaColor      : integer;            // to add transparency after assigning
    OFAlphaBitmap     : TBitmap;            // a TBitmap to TNGImage

    IFZLIBLevel       : integer;            // ZLIB compression parameters
    IFZLIBMethod      : integer;
    IFZLIBWindowbits  : integer;
    IFZLIBMemLevel    : integer;
    IFZLIBStrategy    : integer;
    IFZLIBMaxIDAT     : cardinal;

    IFJPEGQuality     : integer;            // JPEG compression parameters
    BFJPEGProgressive : boolean;
    IFJPEGMaxJDAT     : cardinal;

    BFStatusCheck     : boolean;            // lock recursive status checks
    BFCreating        : boolean;            // libmng status history
    BFWriting         : boolean;
    BFReading         : boolean;
    BFDisplaying      : boolean;
    BFRunning         : boolean;

    procedure CheckStatus;

    procedure ProcessTimer    (Sender    : TObject);

    procedure Refresh         (IHX, IHY  : integer;
                               IHWidth   : integer;
                               IHHeight  : integer);

    function  CompressRawdata (SHRawdata : string) : string;

{$IFDEF INCLUDE_PNG_SAVE}              // PNG save support ?
    procedure CreatePNG;
{$ENDIF}
{$IFDEF INCLUDE_JNG_SAVE}              // JNG save support ?
    procedure CreateJNG;
{$ENDIF}

    procedure LibMNG_Error    (SHMsg     : string);

  protected
    procedure Rewind;                  // Restart from first frame
    procedure Pause;                   // Pause at current frame
    procedure Play;                    // Resume from current frame (after pause)
    procedure Stop;                    // Stop animation (cannot resume in this case!)

    procedure AddImage    (OHImage : TNGImage);
    procedure RemoveImage (OHImage : TNGImage);

  public
    constructor Create; override;
    destructor Destroy; override;

    procedure LoadFromStream (      Stream   : TStream); override;
    procedure SaveToStream   (      Stream   : TStream); override;
    procedure LoadFromFile   (const FileName : string ); override;
    procedure SaveToFile     (const FileName : string ); override;

    procedure LoadFromClipboardFormat
                             (      AFormat  : Word;
                                    AData    : THandle;
                                    APalette : HPALETTE); override;
    procedure SaveToClipboardFormat
                             (var   AFormat  : Word;
                              var   AData    : THandle;
                              var   APalette : HPALETTE); override;

  end;

{****************************************************************************}
{* The PNG/JNG/MNG base class                                               *}
{*                                                                          *}
{* This will function like any other descendant of TGraphic, except that    *}
{* not all functionality is (as of yet) supported.                          *}
{* But basic operations such as LoadFromFile/LoadFromStream and Draw        *}
{* are supported.                                                           *}
{****************************************************************************}

  TNGImage = class (TGraphic)
  private
    OFCanvas       : TCanvas;          // remembered from "draw" override
    OFRect         : TRect;            // remembered from "draw" override
    BFRefreshing   : boolean;          // lock recursive refreshes
    OFBitmap       : TNGBitmap;        // actual bitmap data

    OFStatusChange : TNotifyEvent;     // triggered when libmng status changes

    procedure Refresh (IHX, IHY : integer;
                       IHWidth  : integer;
                       IHHeight : integer);

    procedure CreateBitmap;
    procedure DestroyBitmap;
    procedure AssignBitmap (OHBitmap : TNGBitmap);
    procedure IsolateBitmap;

    // libmng version control

    function GetLIBMNGVersionText    : string;
    function GetLIBMNGVersionDLL     : integer;
    function GetLIBMNGVersionMajor   : integer;
    function GetLIBMNGVersionMinor   : integer;
    function GetLIBMNGVersionRelease : integer;

    // graphic properties

    function GetSignatureType        : mng_imgtype;
    function GetImageType            : mng_imgtype;
    function GetTicks                : cardinal;           // MNG
    function GetFrameCount           : cardinal;           // MNG
    function GetLayerCount           : cardinal;           // MNG
    function GetPlayTime             : cardinal;           // MNG
    function GetSimplicity           : cardinal;           // MNG
    function GetBitdepth             : byte;               // PNG+JNG
    function GetColorType            : byte;               // PNG+JNG
    function GetCompression          : byte;               // PNG+JNG
    function GetFilter               : byte;               // PNG
    function GetInterlaceMethod      : byte;               // PNG+JNG
    function GetAlphaBitdepth        : byte;               // JNG
    function GetAlphaCompression     : byte;               // JNG
    function GetAlphaFilter          : byte;               // JNG
    function GetAlphaInterlace       : byte;               // JNG

    // libmng background control

    function GetBGColor              : TColor;
    function GetUseBKGD              : boolean;
    procedure SetBGColor             (IHValue : TColor );
    procedure SetUseBKGD             (BHValue : boolean);

    // libmng compression variables

    function GetZLIBLevel            : integer;
    function GetZLIBMethod           : integer;
    function GetZLIBWindowbits       : integer;
    function GetZLIBMemLevel         : integer;
    function GetZLIBStrategy         : integer;
    function GetZLIBMaxIDAT          : cardinal;
    procedure SetZLIBLevel           (IHValue : integer );
    procedure SetZLIBMethod          (IHValue : integer );
    procedure SetZLIBWindowbits      (IHValue : integer );
    procedure SetZLIBMemLevel        (IHValue : integer );
    procedure SetZLIBStrategy        (IHValue : integer );
    procedure SetZLIBMaxIDAT         (IHValue : cardinal);

    function GetJPEGQuality          : integer;            // 1..100
    function GetJPEGProgressive      : boolean;
    function GetJPEGMaxJDAT          : cardinal;
    procedure SetJPEGQuality         (IHValue : integer ); // 1..100
    procedure SetJPEGprogressive     (BHValue : boolean );
    procedure SetJPEGMaxJDAT         (IHValue : cardinal);

    // libmng status control

    function GetMNGStartTime         : cardinal;
    function GetMNGRunTime           : cardinal;
    function GetMNGCurrentFrame      : cardinal;
    function GetMNGCurrentLayer      : cardinal;
    function GetMNGCurrentPlaytime   : cardinal;

    function GetStatusError          : boolean;
    function GetStatusReading        : boolean;
    function GetStatusCreating       : boolean;
    function GetStatusWriting        : boolean;
    function GetStatusDisplaying     : boolean;
    function GetStatusRunning        : boolean;

  protected

  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Free;

    procedure LoadFromStream  (      Stream   : TStream); override;
    procedure SaveToStream    (      Stream   : TStream); override;
    procedure LoadFromFile    (const FileName : string ); override;
    procedure SaveToFile      (const FileName : string ); override;

    procedure LoadFromClipboardFormat  // not supported yet !!!
                              (      AFormat  : Word;
                                     AData    : THandle;
                                     APalette : HPALETTE); override;
    procedure SaveToClipboardFormat    // not supported yet !!!
                              (var   AFormat  : Word;
                               var   AData    : THandle;
                               var   APalette : HPALETTE); override;

    function  GetHeight : integer; override;
    function  GetWidth  : integer; override;
    function  GetEmpty  : boolean; override;

    procedure SetHeight       (      Value    : integer); override;
    procedure SetWidth        (      Value    : integer); override;

    procedure Assign          (      Source   : TPersistent); override;
    procedure Draw            (      ACanvas  : TCanvas;
                               const Rect     : TRect  ); override;

    procedure SetAlphaColor   (      Color    : TColor );
    // this actually assigns the bitmap internally so it can be dropped afterwards
    procedure SetAlphaBitmap  (      Bitmap   : TBitmap);

{$IFDEF INCLUDE_PNG_SAVE}              // PNG save support ?
    procedure SaveToPNGstream (      Stream   : TStream);
    procedure SaveToPNGfile   (const FileName : string );
{$ENDIF}
{$IFDEF INCLUDE_JNG_SAVE}              // JNG save support ?
    procedure SaveToJNGstream (      Stream   : TStream);
    procedure SaveToJNGfile   (const FileName : string );
{$ENDIF}

    // libmng animation functions

    procedure MNG_Rewind;              // Restart from first frame
    procedure MNG_Pause;               // Pause at current frame
    procedure MNG_Play;                // Resume from current frame (after pause)
    procedure MNG_Stop;                // Stop animation (cannot resume in this case!)

    // libmng version control

    property LIBMNGVersionText    : string       read GetLIBMNGVersionText;
    property LIBMNGVersionDLL     : integer      read GetLIBMNGVersionDLL;
    property LIBMNGVersionMajor   : integer      read GetLIBMNGVersionMajor;
    property LIBMNGVersionMinor   : integer      read GetLIBMNGVersionMinor;
    property LIBMNGVersionRelease : integer      read GetLIBMNGVersionRelease;

    // graphic properties

    property SignatureType        : mng_imgtype  read GetSignatureType;
    property ImageType            : mng_imgtype  read GetImageType;
    property TicksPerSecond       : cardinal     read GetTicks;             // MNG
    property FrameCount           : cardinal     read GetFrameCount;        // MNG
    property LayerCount           : cardinal     read GetLayerCount;        // MNG
    property PlayTime             : cardinal     read GetPlayTime;          // MNG
    property Simplicity           : cardinal     read GetSimplicity;        // MNG
    property BitDepth             : byte         read GetBitdepth;          // PNG+JNG
    property ColorType            : byte         read GetColorType;         // PNG+JNG
    property CompressionMethod    : byte         read GetCompression;       // PNG+JNG
    property FilterMethod         : byte         read GetFilter;            // PNG
    property InterlaceMethod      : byte         read GetInterlaceMethod;   // PNG+JNG
    property AlphaBitdepth        : byte         read GetAlphaBitdepth;     // JNG
    property AlphaCompression     : byte         read GetAlphaCompression;  // JNG
    property AlphaFilter          : byte         read GetAlphaFilter;       // JNG
    property AlphaInterlace       : byte         read GetAlphaInterlace;    // JNG

    // libmng background control

    property BGColor              : TColor       read GetBGColor         write SetBGColor;
    property UseBKGD              : boolean      read GetUseBKGD         write SetUseBKGD;

    // libmng compression variables

    property ZLIBLevel            : integer      read GetZLIBLevel       write SetZLIBLevel;
    property ZLIBMethod           : integer      read GetZLIBMethod      write SetZLIBMethod;
    property ZLIBWindowbits       : integer      read GetZLIBWindowbits  write SetZLIBWindowbits;
    property ZLIBMemLevel         : integer      read GetZLIBMemLevel    write SetZLIBMemLevel;
    property ZLIBStrategy         : integer      read GetZLIBStrategy    write SetZLIBStrategy;
    property ZLIBMaxIDAT          : cardinal     read GetZLIBMaxIDAT     write SetZLIBMaxIDAT;

    property JPEGQuality          : integer      read GetJPEGQuality     write SetJPEGQuality;  // 1..100
    property JPEGProgressive      : boolean      read GetJPEGProgressive write SetJPEGprogressive;
    property JPEGmaxJDAT          : cardinal     read GetJPEGMaxJDAT     write SetJPEGMaxJDAT;

    // libmng status control

    property MNGStartTime         : cardinal     read GetMNGStartTime;      // MNG
    property MNGRunTime           : cardinal     read GetMNGRunTime;        // MNG
    property MNGCurrentFrame      : cardinal     read GetMNGCurrentFrame;   // MNG
    property MNGCurrentLayer      : cardinal     read GetMNGCurrentLayer;   // MNG
    property MNGCurrentPlaytime   : cardinal     read GetMNGCurrentPlaytime;// MNG

    property StatusError          : boolean      read GetStatusError;
    property StatusReading        : boolean      read GetStatusReading;
    property StatusCreating       : boolean      read GetStatusCreating;
    property StatusWriting        : boolean      read GetStatusWriting;
    property StatusDisplaying     : boolean      read GetStatusDisplaying;
    property StatusRunning        : boolean      read GetStatusRunning;

    property OnStatusChange       : TNotifyEvent read OFStatusChange     write OFStatusChange;

  end;

{****************************************************************************}
{* Derived classes to support all network graphics formats                  *}
{****************************************************************************}

type
{$IFDEF REGISTER_PNG}
  TPNGImage = class (TNGImage);
{$ENDIF}
{$IFDEF REGISTER_JNG}
  TJNGImage = class (TNGImage);
{$ENDIF}
{$IFDEF REGISTER_MNG}
  TMNGImage = class (TNGImage);
{$ENDIF}

{****************************************************************************}

implementation

{****************************************************************************}
{* local constants & types                                                  *}
{****************************************************************************}

const
  SCPNGExt                 = 'PNG';
  SCJNGExt                 = 'JNG';
  SCMNGExt                 = 'MNG';
  SCJPEGExt1               = 'JPE';
  SCJPEGExt2               = 'JFIF';
  SCJPEGExt3               = 'JPEG';
  SCJPEGExt4               = 'JPG';

  SCPNGImageFile           = 'Portable Network Graphics';
  SCJNGImageFile           = 'JPEG Network Graphics';
  SCMNGImageFile           = 'Multiple-image Network Graphics';
  SCJPEGImageFile          = 'JPEG image';

  SCClipboardNotSupported  = 'PNG/JNG/MNG clipboard not yet supported';
  SCNGImageException       = 'PNG/JNG/MNG error: %s ' +
                             '[Code=%d; Severity=%d; Chunknr=%d; Extra=%d/%d]';
  SCNGSavePNGillegal       = 'PNG save not supported in this state';
  SCNGSaveJNGillegal       = 'JNG save not supported in this state';

  {TODO: move all other messages here and change to resourcestrings}

{****************************************************************************}

type TRGBpixel = record
                   B : byte;
                   G : byte;
                   R : byte;
                 end;
     PRGBpixel = ^TRGBpixel;

{****************************************************************************}
{* LIBMNG implementation definitions                                        *}
{****************************************************************************}

const mngdll = 'libmng.dll';

{****************************************************************************}

function mng_version_text;         external mngdll;
function mng_version_so;           external mngdll;
function mng_version_dll;          external mngdll;
function mng_version_major;        external mngdll;
function mng_version_minor;        external mngdll;
function mng_version_release;      external mngdll;

{****************************************************************************}

function mng_initialize;           external mngdll;
function mng_reset;                external mngdll;
function mng_cleanup;              external mngdll;

function mng_read;                 external mngdll;
function mng_write;                external mngdll;
function mng_create;               external mngdll;

function mng_readdisplay;          external mngdll;
function mng_display;              external mngdll;
function mng_display_resume;       external mngdll;
function mng_display_freeze;       external mngdll;
function mng_display_reset;        external mngdll;

function mng_getlasterror;         external mngdll;

{****************************************************************************}

function mng_setcb_memalloc;       external mngdll;
function mng_setcb_memfree;        external mngdll;

function mng_setcb_openstream;     external mngdll;
function mng_setcb_closestream;    external mngdll;

function mng_setcb_readdata;       external mngdll;

function mng_setcb_writedata;      external mngdll;

function mng_setcb_errorproc;      external mngdll;

function mng_setcb_processheader;  external mngdll;
function mng_setcb_processtext;    external mngdll;

function mng_setcb_getcanvasline;  external mngdll;
function mng_setcb_getalphaline;   external mngdll;
function mng_setcb_getbkgdline;    external mngdll;
function mng_setcb_refresh;        external mngdll;

function mng_setcb_gettickcount;   external mngdll;
function mng_setcb_settimer;       external mngdll;

{****************************************************************************}

function mng_getcb_memalloc;       external mngdll;
function mng_getcb_memfree;        external mngdll;

function mng_getcb_openstream;     external mngdll;
function mng_getcb_closestream;    external mngdll;

function mng_getcb_readdata;       external mngdll;

function mng_getcb_writedata;      external mngdll;

function mng_getcb_errorproc;      external mngdll;

function mng_getcb_processheader;  external mngdll;
function mng_getcb_processtext;    external mngdll;

function mng_getcb_getcanvasline;  external mngdll;
function mng_getcb_getalphaline;   external mngdll;
function mng_getcb_getbkgdline;    external mngdll;
function mng_getcb_refresh;        external mngdll;

function mng_getcb_gettickcount;   external mngdll;
function mng_getcb_settimer;       external mngdll;

{****************************************************************************}

function mng_set_userdata;         external mngdll;

function mng_set_canvasstyle;      external mngdll;
function mng_set_bkgdstyle;        external mngdll;

function mng_set_bgcolor;          external mngdll;
function mng_set_usebkgd;          external mngdll;

function mng_set_storechunks;      external mngdll;

function mng_set_viewgammaint;     external mngdll;
function mng_set_displaygammaint;  external mngdll;
function mng_set_dfltimggammaint;  external mngdll;

function mng_set_srgb;             external mngdll;
function mng_set_outputprofile;    external mngdll;
function mng_set_outputprofile2;   external mngdll;
function mng_set_outputsrgb;       external mngdll;
function mng_set_srgbprofile;      external mngdll;
function mng_set_srgbprofile2;     external mngdll;
function mng_set_srgbimplicit;     external mngdll;

function mng_set_maxcanvassize;    external mngdll;

{****************************************************************************}

function  mng_get_userdata;        external mngdll;

function  mng_get_sigtype;         external mngdll;
function  mng_get_imagetype;       external mngdll;
function  mng_get_imagewidth;      external mngdll;
function  mng_get_imageheight;     external mngdll;
function  mng_get_ticks;           external mngdll;
function  mng_get_framecount;      external mngdll;
function  mng_get_layercount;      external mngdll;
function  mng_get_playtime;        external mngdll;
function  mng_get_simplicity;      external mngdll;

function  mng_get_bitdepth;        external mngdll;
function  mng_get_colortype;       external mngdll;
function  mng_get_compression;     external mngdll;
function  mng_get_filter;          external mngdll;
function  mng_get_interlace;       external mngdll;
function  mng_get_alphabitdepth;   external mngdll;
function  mng_get_alphacompression;external mngdll;
function  mng_get_alphafilter;     external mngdll;
function  mng_get_alphainterlace;  external mngdll;

procedure mng_get_bgcolor;         external mngdll;
function  mng_get_usebkgd;         external mngdll;

function  mng_get_viewgammaint;    external mngdll;
function  mng_get_displaygammaint; external mngdll;
function  mng_get_dfltimggammaint; external mngdll;

function  mng_get_srgb;            external mngdll;

function  mng_get_maxcanvaswidth;  external mngdll;
function  mng_get_maxcanvasheight; external mngdll;

function  mng_get_starttime;       external mngdll;
function  mng_get_runtime;         external mngdll;
function  mng_get_currentframe;    external mngdll;
function  mng_get_currentlayer;    external mngdll;
function  mng_get_currentplaytime; external mngdll;

function  mng_status_error;        external mngdll;
function  mng_status_reading;      external mngdll;
function  mng_status_suspendbreak; external mngdll;
function  mng_status_creating;     external mngdll;
function  mng_status_writing;      external mngdll;
function  mng_status_displaying;   external mngdll;
function  mng_status_running;      external mngdll;
function  mng_status_timerbreak;   external mngdll;

{****************************************************************************}

function  mng_putchunk_ihdr;       external mngdll;
function  mng_putchunk_plte;       external mngdll;
function  mng_putchunk_idat;       external mngdll;
function  mng_putchunk_iend;       external mngdll;
function  mng_putchunk_trns;       external mngdll;
function  mng_putchunk_gama;       external mngdll;
function  mng_putchunk_chrm;       external mngdll;
function  mng_putchunk_srgb;       external mngdll;
function  mng_putchunk_iccp;       external mngdll;
function  mng_putchunk_text;       external mngdll;
function  mng_putchunk_ztxt;       external mngdll;
function  mng_putchunk_itxt;       external mngdll;
function  mng_putchunk_bkgd;       external mngdll;
function  mng_putchunk_phys;       external mngdll;
function  mng_putchunk_sbit;       external mngdll;
function  mng_putchunk_splt;       external mngdll;
function  mng_putchunk_hist;       external mngdll;
function  mng_putchunk_time;       external mngdll;

function  mng_putchunk_jhdr;       external mngdll;
function  mng_putchunk_jdat;       external mngdll;
function  mng_putchunk_jsep;       external mngdll;

{****************************************************************************}
{* LIBMNG implementation definitions for ZLIB                               *}
{****************************************************************************}

{$IFDEF INCLUDE_ZLIB}

{****************************************************************************}

function deflateInit_  (strm        : z_streamp;
                        level       : integer;
                        version     : pchar;
                        stream_size : integer) : integer; stdcall; external mngdll;

function inflateInit_  (strm        : z_streamp;
                        version     : pchar;
                        stream_size : integer) : integer; stdcall; external mngdll;

function deflateInit2_ (strm        : z_streamp;
                        level       : integer;
                        method      : integer;
                        windowBits  : integer;
                        memLevel    : integer;
                        strategy    : integer;
                        version     : pchar;
                        stream_size : integer) : integer; stdcall; external mngdll;

function inflateInit2_ (strm        : z_streamp;
                        windowBits  : integer;
                        version     : pchar;
                        stream_size : integer) : integer; stdcall; external mngdll;

{****************************************************************************}

function zlibVersion;          external mngdll;
function deflate;              external mngdll;
function deflateEnd;           external mngdll;
function inflate;              external mngdll;
function inflateEnd;           external mngdll;
function deflateSetDictionary; external mngdll;
function deflateCopy;          external mngdll;
function deflateReset;         external mngdll;
function deflateParams;        external mngdll;
function inflateSetDictionary; external mngdll;
function inflateSync;          external mngdll;
function inflateReset;         external mngdll;
function compress;             external mngdll;
function compress2;            external mngdll;
function uncompress;           external mngdll;
function adler32;              external mngdll;
function crc32;                external mngdll;
function zError;               external mngdll;
function inflateSyncPoint;     external mngdll;
function get_crc_table;        external mngdll;

{****************************************************************************}

function deflateInit;
begin
  Result := deflateInit_ (strm, level, ZLIB_VERSION, sizeof (z_stream));
end;

{****************************************************************************}

function inflateInit;
begin
  Result := inflateInit_ (strm, ZLIB_VERSION, sizeof (z_stream));
end;

{****************************************************************************}

function deflateInit2;
begin
  Result := deflateInit2_ (strm, level, method, windowBits, memLevel, strategy,
                           ZLIB_VERSION, sizeof (z_stream));
end;

{****************************************************************************}

function inflateInit2;
begin
  Result := inflateInit2_ (strm, windowBits, ZLIB_VERSION, sizeof (z_stream));
end;

{****************************************************************************}

function InflateString;

var stream : z_stream;

begin
  fillchar (stream, sizeof (stream), 0);

  stream.next_in   := @Input [1];
  stream.avail_in  := length (Input);
  stream.next_out  := @Output [1];
  stream.avail_out := length (Output);

  stream.zalloc    := nil;
  stream.zfree     := nil;
  stream.opaque    := nil;

  Result := inflateInit (@stream);

  if (Result <> Z_OK) then
    Exit;

  Result := inflate (@stream, Z_FINISH);

  if (Result <> Z_STREAM_END) then
  begin
    inflateEnd (@stream);

    if Result = Z_OK then
      Result := Z_BUF_ERROR;

    Exit;
  end;

  Output := copy (Output, 1, stream.total_out);
  Result := inflateEnd (@stream);
end;

{***************************************************************************}

function DeflateString;

var stream : z_stream;

begin
  fillchar (stream, sizeof (stream), 0);

  stream.next_in   := @Input [1];
  stream.avail_in  := length (Input);
  stream.next_out  := @Output [1];
  stream.avail_out := length (Output);

  stream.zalloc    := nil;
  stream.zfree     := nil;
  stream.opaque    := nil;

  Result := deflateInit (@stream, Z_DEFAULT_COMPRESSION);

  if (Result <> Z_OK) then
    Exit;

  Result := deflate (@stream, Z_FINISH);

  if (Result <> Z_STREAM_END) then
  begin
    deflateEnd (@stream);

    if Result = Z_OK then
      Result := Z_BUF_ERROR;

    Exit;
  end;

  Output := copy (Output, 1, stream.total_out);
  Result := deflateEnd (@stream);
end;

{***************************************************************************}

function InflateString2;

var stream : z_stream;

begin
  fillchar (stream, sizeof (stream), 0);

  stream.next_in   := @Input [1];
  stream.avail_in  := length (Input);
  stream.next_out  := @Output [1];
  stream.avail_out := length (Output);

  stream.zalloc    := nil;
  stream.zfree     := nil;
  stream.opaque    := nil;

  Result := inflateInit2 (@stream, windowBits);

  if (Result <> Z_OK) then
    Exit;

  Result := inflate (@stream, Z_FINISH);

  if (Result <> Z_STREAM_END) then
  begin
    inflateEnd (@stream);

    if Result = Z_OK then
      Result := Z_BUF_ERROR;

    Exit;
  end;

  Output := copy (Output, 1, stream.total_out);
  Result := inflateEnd (@stream);
end;

{***************************************************************************}

function DeflateString2;

var stream : z_stream;

begin
  fillchar (stream, sizeof (stream), 0);

  stream.next_in   := @Input [1];
  stream.avail_in  := length (Input);
  stream.next_out  := @Output [1];
  stream.avail_out := length (Output);

  stream.zalloc    := nil;
  stream.zfree     := nil;
  stream.opaque    := nil;

  Result := deflateInit2 (@stream, level, method, windowBits, memLevel, strategy);

  if (Result <> Z_OK) then
    Exit;

  Result := deflate (@stream, Z_FINISH);

  if (Result <> Z_STREAM_END) then
  begin
    deflateEnd (@stream);

    if Result = Z_OK then
      Result := Z_BUF_ERROR;

    Exit;
  end;

  Output := copy (Output, 1, stream.total_out);
  Result := deflateEnd (@stream);
end;

{****************************************************************************}

{$ENDIF} // INCLUDE_ZLIB

{****************************************************************************}
{* LIBMNG implementation definitions for JPEG                               *}
{****************************************************************************}

{$IFDEF INCLUDE_JPEG}

{****************************************************************************}

procedure jpeg_CreateDecompress (var cinfo : jpeg_decompress_struct;
  version : integer; structsize : integer); stdcall; external mngdll;
procedure jpeg_stdio_src(var cinfo: jpeg_decompress_struct;
  input_file: TStream); stdcall; external mngdll;
procedure jpeg_read_header(var cinfo: jpeg_decompress_struct;
  RequireImage: LongBool); stdcall; external mngdll;
procedure jpeg_calc_output_dimensions(var cinfo: jpeg_decompress_struct); stdcall; external mngdll;
function jpeg_start_decompress(var cinfo: jpeg_decompress_struct): Longbool; stdcall; external mngdll;
function jpeg_read_scanlines(var cinfo: jpeg_decompress_struct;
	scanlines: JSAMPARRAY; max_lines: JDIMENSION): JDIMENSION; stdcall; external mngdll;
function jpeg_finish_decompress(var cinfo: jpeg_decompress_struct): Longbool; stdcall; external mngdll;
procedure jpeg_destroy_decompress (var cinfo : jpeg_decompress_struct); stdcall; external mngdll;
function jpeg_has_multiple_scans(var cinfo: jpeg_decompress_struct): Longbool; stdcall; external mngdll;
function jpeg_consume_input(var cinfo: jpeg_decompress_struct): Integer; stdcall; external mngdll;
function jpeg_start_output(var cinfo: jpeg_decompress_struct; scan_number: Integer): Longbool; stdcall; external mngdll;
function jpeg_finish_output(var cinfo: jpeg_decompress_struct): LongBool; stdcall; external mngdll;
procedure jpeg_destroy(var cinfo: jpeg_common_struct); stdcall; external mngdll;

procedure jpeg_CreateCompress (var cinfo : jpeg_compress_struct;
  version : integer; structsize : integer); stdcall; external mngdll;
procedure jpeg_stdio_dest(var cinfo: jpeg_compress_struct;
  output_file: TStream); stdcall; external mngdll;
procedure jpeg_set_defaults(var cinfo: jpeg_compress_struct); stdcall; external mngdll;
procedure jpeg_set_quality(var cinfo: jpeg_compress_struct; Quality: Integer;
  Baseline: Longbool); stdcall; external mngdll;
procedure jpeg_set_colorspace(var cinfo: jpeg_compress_struct;
  colorspace: J_COLOR_SPACE); stdcall; external mngdll;
procedure jpeg_simple_progression(var cinfo: jpeg_compress_struct); stdcall; external mngdll;
procedure jpeg_start_compress(var cinfo: jpeg_compress_struct;
  WriteAllTables: LongBool); stdcall; external mngdll;
function jpeg_write_scanlines(var cinfo: jpeg_compress_struct;
  scanlines: JSAMPARRAY; max_lines: JDIMENSION): JDIMENSION; stdcall; external mngdll;
procedure jpeg_finish_compress(var cinfo: jpeg_compress_struct); stdcall; external mngdll;

function jpeg_resync_to_restart (cinfo : j_decompress_ptr; desired : Integer) : LongBool; stdcall; external mngdll;

{****************************************************************************}

{$ENDIF} // INCLUDE_JPEG

{****************************************************************************}
{* local callback funtions to interface with LIBMNG                         *}
{****************************************************************************}

function XNG_alloc (IHSize : mng_size_t) : mng_ptr; stdcall;
begin
  GetMem   (Result,  IHSize);
  FillChar (Result^, IHSize, 0);
end;

{****************************************************************************}

procedure XNG_free (PHPtr  : mng_ptr;
                    IHSize : mng_size_t); stdcall;
begin
  FreeMem (PHPtr, IHSize);
end;

{****************************************************************************}

function XNG_gettickcount (HHHandle : mng_handle) : mng_uint32; stdcall;
begin
  Result := Windows.GetTickCount;
end;

{****************************************************************************}

function XNG_openstream (HHHandle : mng_handle) : mng_bool; stdcall;
begin
  Result := MNG_TRUE;
end;

{****************************************************************************}

function XNG_closestream (HHHandle : mng_handle) : mng_bool; stdcall;

var OHImage : TNGbitmap;

begin
  OHImage := TNGbitmap (mng_get_userdata (HHHandle));

  if OHImage.BFFreeOnClose then
  begin
    OHImage.OFStream.Free;
    OHImage.OFStream := nil;
  end;

  Result := MNG_TRUE;
end;

{****************************************************************************}

function XNG_readdata (    HHHandle : mng_handle;
                           PHBuf    : mng_ptr;
                           IHBuflen : mng_uint32;
                       var IHRead   : mng_uint32) : mng_bool; stdcall;

var OHImage : TNGbitmap;

begin
  OHImage    := TNGbitmap (mng_get_userdata (HHHandle));

  with OHImage do
  begin
    if OFStream.Position >= OFStream.Size then
      IHRead := 0
    else
      IHRead := OHImage.OFStream.Read (PHBuf^, IHBuflen);

  end;

  Result     := MNG_TRUE;
end;

{****************************************************************************}

function XNG_writedata (    HHHandle  : mng_handle;
                            PHBuf     : mng_ptr;
                            IHBuflen  : mng_uint32;
                        var IHWritten : mng_uint32) : mng_bool; stdcall;

var OHImage : TNGbitmap;

begin
  OHImage     := TNGbitmap (mng_get_userdata (HHHandle));

  with OHImage do
    IHWritten := OHImage.OFStream.Write (PHBuf^, IHBuflen);

  Result      := MNG_TRUE;
end;

{****************************************************************************}

function XNG_errorproc (HHHandle    : mng_handle;
                        IHErrorcode : mng_retcode;
                        IHSeverity  : mng_uint8;
                        IHChunkname : mng_chunkid;
                        IHChunkseq  : mng_uint32;
                        IHExtra1    : mng_int32;
                        IHExtra2    : mng_int32;
                        SHErrortext : mng_pchar ) : mng_bool; stdcall;
begin
  Result  := MNG_TRUE;
end;

{****************************************************************************}

function XNG_processheader (HHHandle : mng_handle;
                            IHWidth  : mng_uint32;
                            IHHeight : mng_uint32) : mng_bool; stdcall;

var OHImage : TNGbitmap;

begin
  OHImage := TNGbitmap (mng_get_userdata (HHHandle));

  with OHImage do
  begin
    Width        := IHWidth;
    Height       := IHHeight;
    HandleType   := bmDIB;
    PixelFormat  := pf24bit;
    BFHaveHeader := true;
  end;

  Result := MNG_TRUE;
end;

{****************************************************************************}

function XNG_getcanvasline (HHHandle : mng_handle;
                            IHLineNr : mng_uint32) : mng_ptr; stdcall;

var OHImage : TNGbitmap;

begin
  OHImage := TNGbitmap (mng_get_userdata (HHHandle));
  Result  := OHImage.ScanLine [IHLineNr];
end;

{****************************************************************************}

function XNG_refresh (HHHandle : mng_handle;
                      IHX, IHY : mng_uint32;
                      IHWidth  : mng_uint32;
                      IHHeight : mng_uint32) : mng_bool; stdcall;

var OHImage : TNGbitmap;

begin
  OHImage := TNGbitmap (mng_get_userdata (HHHandle));
  OHImage.Refresh (IHX, IHY, IHWidth, IHHeight);
  Result  := MNG_TRUE;
end;

{****************************************************************************}

function XNG_settimer (HHHandle : mng_handle;
                       IHMSecs  : mng_uint32) : mng_bool; stdcall;

var OHImage : TNGbitmap;

begin
  OHImage                  := TNGbitmap (mng_get_userdata (HHHandle));
  OHImage.OFTimer.Interval := IHMSecs;
  OHImage.OFTimer.Enabled  := true;
  Result                   := MNG_TRUE;
end;

{****************************************************************************}
{* local funtions to interface with LIBMNGs JPEG code                       *}
{****************************************************************************}

{$IFDEF INCLUDE_JPEG)

{****************************************************************************}

procedure SwapRedBlueScanline (Line : pointer; Width : Integer);

type pbytes3 = ^tbytes3;
     tbytes3 = array [0..2] of byte;

var ix : integer;
    bLine : pbytes3;
    bTemp : byte;

begin
  bLine := pbytes3(Line);
  for ix := 0 to pred(Width) do
  begin
    bTemp := bLine[0];
    bLine[0] := bLine[2];
    bLine[2] := bTemp;
    inc (bLine);
  end;
end;

{****************************************************************************}

procedure SwapRedBlue (Bitmap : TBitmap);

var ix : Integer;

begin
  for ix := 0 to pred(Bitmap.Height) do
    SwapRedBlueScanline(Bitmap.Scanline[ix], Bitmap.Width);
end;

{****************************************************************************}

type
  EJPEG = class(EInvalidGraphic);

{****************************************************************************}

procedure InvalidOperation(const Msg: string); near;
begin
  raise EInvalidGraphicOperation.Create(Msg);
end;

{****************************************************************************}

procedure JpegError(cinfo: j_common_ptr); stdcall;
begin
  raise EJPEG.CreateFmt(sJPEGError,[cinfo^.err^.msg_code]);
end;

{****************************************************************************}

procedure EmitMessage(cinfo: j_common_ptr; msg_level: Integer); stdcall;
begin
  //!!
end;

{****************************************************************************}

procedure OutputMessage(cinfo: j_common_ptr); stdcall;
begin
  //!!
end;

{****************************************************************************}

procedure FormatMessage(cinfo: j_common_ptr; buffer: PChar); stdcall;
begin
  //!!
end;

{****************************************************************************}

procedure ResetErrorMgr(cinfo: j_common_ptr); stdcall;
begin
  cinfo^.err^.num_warnings := 0;
  cinfo^.err^.msg_code := 0;
end;

{****************************************************************************}

procedure SrcInit(cinfo: j_decompress_ptr); stdcall;

var Data : TJPEGData;

begin
  Data := TJPEGData(cinfo^.common.client_data);

  cinfo^.src^.next_input_byte := Data.FData.Memory;
  cinfo^.src^.bytes_in_buffer := Data.FData.Size;
end;

{****************************************************************************}

function SrcFill(cinfo: j_decompress_ptr) : Longbool; stdcall;
begin
  Result := TRUE;
end;

{****************************************************************************}

procedure SrcSkip(cinfo: j_decompress_ptr;
                  num_bytes: Longint); stdcall;
begin
  if num_bytes > 0 then
  begin
    if cinfo^.src^.bytes_in_buffer > num_bytes then
    begin
      dec(cinfo^.src^.bytes_in_buffer, num_bytes);
      inc(cinfo^.src^.next_input_byte, num_bytes);
    end;
  end;
end;

{****************************************************************************}

procedure SrcTerm(cinfo: j_decompress_ptr); stdcall;
begin
end;

{****************************************************************************}

procedure DstInit(cinfo: j_compress_ptr); stdcall;

var Data : TJPEGData;

begin
  Data := TJPEGData(cinfo^.common.client_data);
  Data.FSize := 4000;

  GetMem(Data.FBuffer, Data.FSize);

  cinfo^.dest^.next_output_byte := Data.FBuffer;
  cinfo^.dest^.free_in_buffer := Data.FSize;
end;

{****************************************************************************}

function DstEmpty(cinfo: j_compress_ptr) : Longbool; stdcall;

var Data : TJPEGData;

begin
  Data := TJPEGData(cinfo^.common.client_data);

  Data.FData.Write(Data.FBuffer^, Data.FSize);

  cinfo^.dest^.next_output_byte := Data.FBuffer;
  cinfo^.dest^.free_in_buffer := Data.FSize;

  Result := TRUE;
end;

{****************************************************************************}

procedure DstTerm(cinfo: j_compress_ptr); stdcall;

var Data : TJPEGData;

begin
  Data := TJPEGData(cinfo^.common.client_data);

  if cinfo^.dest^.free_in_buffer < Data.FSize then
    Data.FData.Write(Data.FBuffer^, Data.FSize-cinfo^.dest^.free_in_buffer);

  cinfo^.dest^.next_output_byte := nil;
  cinfo^.dest^.free_in_buffer := 0;

  if Data.FSize > 0 then
    FreeMem(Data.FBuffer, Data.FSize);

  Data.FBuffer := nil;
  Data.FSize := 0;
end;

{****************************************************************************}
{ TJPEGData                                                                  }
{****************************************************************************}

constructor TJPEGData.Create;
begin
  inherited;
  FBuffer := nil;
  FSize := 0;
end;

{****************************************************************************}

destructor TJPEGData.Destroy;
begin
  FData.Free;
  inherited Destroy;
end;

{****************************************************************************}

procedure TJPEGData.FreeHandle;
begin
end;

{****************************************************************************}
{ TJPEGImage                                                                 }
{****************************************************************************}

constructor TJPEGImage.Create;
begin
  inherited Create;
  NewImage;
  FQuality := JPEGDefaults.CompressionQuality;
  FGrayscale := JPEGDefaults.Grayscale;
  FPerformance := JPEGDefaults.Performance;
  FPixelFormat := JPEGDefaults.PixelFormat;
  FProgressiveDisplay := JPEGDefaults.ProgressiveDisplay;
  FProgressiveEncoding := JPEGDefaults.ProgressiveEncoding;
  FScale := JPEGDefaults.Scale;
  FSmoothing := JPEGDefaults.Smoothing;
end;

{****************************************************************************}

destructor TJPEGImage.Destroy;
begin
  if FTempPal <> 0 then DeleteObject(FTempPal);
  FBitmap.Free;
  FImage.Release;
  inherited Destroy;
end;

{****************************************************************************}

procedure TJPEGImage.Assign(Source: TPersistent);
begin
  if Source is TJPEGImage then
  begin
    FImage.Release;
    FImage := TJPEGImage(Source).FImage;
    FImage.Reference;
    if TJPEGImage(Source).FBitmap <> nil then
    begin
      NewBitmap;
      FBitmap.Assign(TJPEGImage(Source).FBitmap);
    end;
  end
  else if Source is TBitmap then
  begin
    NewImage;
    NewBitmap;
    FBitmap.Assign(Source);
  end
  else
    inherited Assign(Source);
end;

{****************************************************************************}

procedure TJPEGImage.AssignTo(Dest: TPersistent);
begin
  if Dest is TBitmap then
    Dest.Assign(Bitmap)
  else
    inherited AssignTo(Dest);
end;

{****************************************************************************}

const
  jpeg_std_error: jpeg_error_mgr = (
    error_exit: JpegError;
    emit_message: EmitMessage;
    output_message: OutputMessage;
    format_message: FormatMessage;
    reset_error_mgr: ResetErrorMgr);

  jpeg_std_src: jpeg_source_mgr = (
    next_input_byte: nil;
    bytes_in_buffer: 0;
    init_source: SrcInit;
    fill_input_buffer: SrcFill;
    skip_input_data: SrcSkip;
    resync_to_restart: nil;
    term_source: SrcTerm);

  jpeg_std_dest: jpeg_destination_mgr = (
    next_output_byte: nil;
    free_in_buffer: 0;
    init_destination: DstInit;
    empty_output_buffer: DstEmpty;
    term_destination: DstTerm);

{****************************************************************************}

procedure ProgressCallback(const cinfo: jpeg_common_struct); stdcall;
var
  Ticks: Integer;
  R: TRect;
  temp: Integer;
begin
  if (cinfo.progress = nil) or (cinfo.progress^.instance = nil) then Exit;
  with cinfo.progress^ do
  begin
    Ticks := GetTickCount;
    if (Ticks - last_time) < 500 then Exit;
    temp := last_time;
    last_time := Ticks;
    if temp = 0 then Exit;
    if cinfo.is_decompressor then
      with j_decompress_ptr(@cinfo)^ do
      begin
        R := Rect(0, last_scanline, output_width, output_scanline);
        if R.Bottom < last_scanline then
          R.Bottom := output_height;
      end
    else
      R := Rect(0,0,0,0);
    temp := Trunc(100.0*(completed_passes + (pass_counter/pass_limit))/total_passes);
    if temp = last_pct then Exit;
    last_pct := temp;
    if cinfo.is_decompressor then
      last_scanline := j_decompress_ptr(@cinfo)^.output_scanline;
    instance.Progress(instance, psRunning, temp, (R.Bottom - R.Top) >= 4, R, '');
  end;
end;

{****************************************************************************}

procedure InitContext(var jc: TJPEGContext); stdcall;
begin
  FillChar (jc, sizeof (jc), 0);
  jc.err        := jpeg_std_error;
  jc.common.err := @jc.err;
end;

{****************************************************************************}

procedure ReleaseContext(var jc: TJPEGContext); stdcall;
begin
  if jc.common.err = nil then
    exit;

  jpeg_destroy (jc.common);
  jc.common.err := nil;
end;

{****************************************************************************}

procedure InitDecompressor(Obj: TJPEGImage; var jc: TJPEGContext); stdcall;
begin
  FillChar(jc, sizeof(jc), 0);
  jc.err := jpeg_std_error;
  jc.common.err := @jc.err;

  jpeg_CreateDecompress(jc.d, JPEG_LIB_VERSION, sizeof(jpeg_decompress_struct));
  with Obj do
  try
    jc.progress.progress_monitor := @ProgressCallback;
    jc.progress.instance := Obj;
    jc.common.progress := @jc.progress;

    Obj.FImage.FData.Position := 0;
//    jpeg_stdio_src(jc.d, FImage.FData);
    jc.d.common.client_data := FImage;
    jc.d.src := @jpeg_std_src;
    jc.d.src.resync_to_restart := jpeg_resync_to_restart;
    jpeg_read_header(jc.d, TRUE);

    jc.d.scale_num := 1;
    jc.d.scale_denom := 1 shl Byte(FScale);
    jc.d.do_block_smoothing := FSmoothing;

    if FGrayscale then jc.d.out_color_space := JCS_GRAYSCALE;
    if (PixelFormat = jf8Bit) or (jc.d.out_color_space = JCS_GRAYSCALE) then
    begin
      jc.d.quantize_colors := True;
      jc.d.desired_number_of_colors := 236;
    end;

    if FPerformance = jpBestSpeed then
    begin
      jc.d.dct_method := JDCT_IFAST;
      jc.d.two_pass_quantize := False;
//      jc.d.do_fancy_upsampling := False;    !! AV inside jpeglib
      jc.d.dither_mode := JDITHER_ORDERED;
    end;

    jc.FinalDCT := jc.d.dct_method;
    jc.FinalTwoPassQuant := jc.d.two_pass_quantize;
    jc.FinalDitherMode := jc.d.dither_mode;
    if FProgressiveDisplay and jpeg_has_multiple_scans(jc.d) then
    begin  // save requested settings, reset for fastest on all but last scan
      jc.d.enable_2pass_quant := jc.d.two_pass_quantize;
      jc.d.dct_method := JDCT_IFAST;
      jc.d.two_pass_quantize := False;
      jc.d.dither_mode := JDITHER_ORDERED;
      jc.d.buffered_image := True;
    end;
  except
    ReleaseContext(jc);
    raise;
  end;
end;

{****************************************************************************}

procedure TJPEGImage.CalcOutputDimensions;
var
  jc: TJPEGContext;
begin
  if not FNeedRecalc then Exit;
  InitDecompressor(Self, jc);
  try
    jc.common.progress := nil;
    jpeg_calc_output_dimensions(jc.d);
    // read output dimensions
    FScaledWidth := jc.d.output_width;
    FScaledHeight := jc.d.output_height;
    FProgressiveEncoding := jpeg_has_multiple_scans(jc.d);
  finally
    ReleaseContext(jc);
  end;
end;

{****************************************************************************}

procedure TJPEGImage.Changed(Sender: TObject);
begin
  inherited Changed(Sender);
end;

{****************************************************************************}

procedure TJPEGImage.Compress;
var
  LinesWritten, LinesPerCall: Integer;
  SrcScanLine: Pointer;
  PtrInc: Integer;
  jc: TJPEGContext;
  Src: TBitmap;
begin
  FillChar(jc, sizeof(jc), 0);
  jc.err := jpeg_std_error;
  jc.common.err := @jc.err;

  jpeg_CreateCompress(jc.c, JPEG_LIB_VERSION, sizeof(jpeg_compress_struct));
  try
    try
      jc.progress.progress_monitor := @ProgressCallback;
      jc.progress.instance := Self;
      jc.common.progress := @jc.progress;

      if FImage.FData <> nil then NewImage;
      FImage.FData := TMemoryStream.Create;
      FImage.FData.Position := 0;
//      jpeg_stdio_dest(jc.c, FImage.FData);
      jc.c.common.client_data := FImage;
      jc.c.dest := @jpeg_std_dest;

      if (FBitmap = nil) or (FBitmap.Width = 0) or (FBitmap.Height = 0) then Exit;
      jc.c.image_width := FBitmap.Width;
      FImage.FWidth := FBitmap.Width;
      jc.c.image_height := FBitmap.Height;
      FImage.FHeight := FBitmap.Height;
      jc.c.input_components := 3;           // JPEG requires 24bit RGB input
      jc.c.in_color_space := JCS_RGB;

      Src := TBitmap.Create;
      try
        Src.Assign(FBitmap);
        Src.PixelFormat := pf24bit;
        SwapRedBlue (Src);

        jpeg_set_defaults(jc.c);
        jpeg_set_quality(jc.c, FQuality, True);

        if FGrayscale then
        begin
          FImage.FGrayscale := True;
          jpeg_set_colorspace(jc.c, JCS_GRAYSCALE);
        end;

        if ProgressiveEncoding then
          jpeg_simple_progression(jc.c);

        SrcScanline := Src.ScanLine[0];
        PtrInc := Integer(Src.ScanLine[1]) - Integer(SrcScanline);

          // if no dword padding required and source bitmap is top-down
        if (PtrInc > 0) and ((PtrInc and 3) = 0) then
          LinesPerCall := jc.c.image_height  // do whole bitmap in one call
        else
          LinesPerCall := 1;      // otherwise spoonfeed one row at a time

        Progress(Self, psStarting, 0, False, Rect(0,0,0,0), '');
        try
          jpeg_start_compress(jc.c, True);

          while (jc.c.next_scanline < jc.c.image_height) do
          begin
            LinesWritten := jpeg_write_scanlines(jc.c, @SrcScanline, LinesPerCall);
            Inc(Integer(SrcScanline), PtrInc * LinesWritten);
          end;

          jpeg_finish_compress(jc.c);
        finally
          if ExceptObject = nil then
            PtrInc := 100
          else
            PtrInc := 0;
          Progress(Self, psEnding, PtrInc, False, Rect(0,0,0,0), '');
        end;
      finally
        Src.Free;
      end;
    except
      on EAbort do    // OnProgress can raise EAbort to cancel image save
        NewImage;     // Throw away any partial jpg data
    end;
  finally
    ReleaseContext(jc);
  end;
end;

{****************************************************************************}

procedure TJPEGImage.DIBNeeded;
begin
  GetBitmap;
end;

{****************************************************************************}

procedure TJPEGImage.Draw(ACanvas: TCanvas; const Rect: TRect);
begin
  ACanvas.StretchDraw(Rect, Bitmap);
end;

{****************************************************************************}

function TJPEGImage.Equals(Graphic: TGraphic): Boolean;
begin
  Result := (Graphic is TJPEGImage) and
    (FImage = TJPEGImage(Graphic).FImage); //!!
end;

{****************************************************************************}

procedure TJPEGImage.FreeBitmap;
begin
  FBitmap.Free;
  FBitmap := nil;
end;

{****************************************************************************}

function BuildPalette(const cinfo: jpeg_decompress_struct): HPalette; stdcall;
var
  Pal: TMaxLogPalette;
  I: Integer;
  C: Byte;
begin
  Pal.palVersion := $300;
  Pal.palNumEntries := cinfo.actual_number_of_colors;
  if cinfo.out_color_space = JCS_GRAYSCALE then
    for I := 0 to Pal.palNumEntries-1 do
    begin
      C := cinfo.colormap^[0]^[I];
      Pal.palPalEntry[I].peRed := C;
      Pal.palPalEntry[I].peGreen := C;
      Pal.palPalEntry[I].peBlue := C;
      Pal.palPalEntry[I].peFlags := 0;
    end
  else
    for I := 0 to Pal.palNumEntries-1 do
    begin
      Pal.palPalEntry[I].peRed := cinfo.colormap^[2]^[I];
      Pal.palPalEntry[I].peGreen := cinfo.colormap^[1]^[I];
      Pal.palPalEntry[I].peBlue := cinfo.colormap^[0]^[I];
      Pal.palPalEntry[I].peFlags := 0;
    end;
  Result := CreatePalette(PLogPalette(@Pal)^);
end;

{****************************************************************************}

procedure BuildColorMap(var cinfo: jpeg_decompress_struct; P: HPalette); stdcall;
var
  Pal: TMaxLogPalette;
  Count, I: Integer;
begin
  Count := GetPaletteEntries(P, 0, 256, Pal.palPalEntry);
  if Count = 0 then Exit;       // jpeg_destroy will free colormap
  cinfo.colormap := cinfo.common.mem.alloc_sarray(@cinfo.common, JPOOL_IMAGE, Count, 3);
  cinfo.actual_number_of_colors := Count;
  for I := 0 to Count-1 do
  begin
    Byte(cinfo.colormap^[2]^[I]) := Pal.palPalEntry[I].peRed;
    Byte(cinfo.colormap^[1]^[I]) := Pal.palPalEntry[I].peGreen;
    Byte(cinfo.colormap^[0]^[I]) := Pal.palPalEntry[I].peBlue;
  end;
end;

{****************************************************************************}

function TJPEGImage.GetBitmap: TBitmap;
var
  LinesPerCall, LinesRead: Integer;
  DestScanLine: Pointer;
  PtrInc: Integer;
  jc: TJPEGContext;
  GeneratePalette: Boolean;
begin
  Result := FBitmap;
  if Result <> nil then Exit;
  if (FBitmap = nil) then FBitmap := TBitmap.Create;
  Result := FBitmap;
  GeneratePalette := True;

  InitDecompressor(Self, jc);
  try
    try
      // Set the bitmap pixel format
      FBitmap.Handle := 0;
      if (PixelFormat = jf8Bit) or (jc.d.out_color_space = JCS_GRAYSCALE) then
        FBitmap.PixelFormat := pf8bit
      else
        FBitmap.PixelFormat := pf24bit;

      Progress(Self, psStarting, 0, False, Rect(0,0,0,0), '');
      try
        if (FTempPal <> 0) then
        begin
          if (FPixelFormat = jf8Bit) then
          begin                        // Generate DIB using assigned palette
            BuildColorMap(jc.d, FTempPal);
            FBitmap.Palette := CopyPalette(FTempPal);  // Keep FTempPal around
            GeneratePalette := False;
          end
          else
          begin
            DeleteObject(FTempPal);
            FTempPal := 0;
          end;
        end;

        jpeg_start_decompress(jc.d);

        // Set bitmap width and height
        with FBitmap do
        begin
          Handle := 0;
          Width := jc.d.output_width;
          Height := jc.d.output_height;
          DestScanline := ScanLine[0];
          PtrInc := Integer(ScanLine[1]) - Integer(DestScanline);
          if (PtrInc > 0) and ((PtrInc and 3) = 0) then
             // if no dword padding is required and output bitmap is top-down
            LinesPerCall := jc.d.rec_outbuf_height // read multiple rows per call
          else
            LinesPerCall := 1;            // otherwise read one row at a time
        end;

        if jc.d.buffered_image then
        begin  // decode progressive scans at low quality, high speed
          while jpeg_consume_input(jc.d) <> JPEG_REACHED_EOI do
          begin
            jpeg_start_output(jc.d, jc.d.input_scan_number);
            // extract color palette
            if (jc.common.progress^.completed_passes = 0) and (jc.d.colormap <> nil)
              and (FBitmap.PixelFormat = pf8bit) and GeneratePalette then
            begin
              FBitmap.Palette := BuildPalette(jc.d);
              PaletteModified := True;
            end;
            DestScanLine := FBitmap.ScanLine[0];
            while (jc.d.output_scanline < jc.d.output_height) do
            begin
              LinesRead := jpeg_read_scanlines(jc.d, @DestScanline, LinesPerCall);
              Inc(Integer(DestScanline), PtrInc * LinesRead);
            end;
            jpeg_finish_output(jc.d);
          end;
          // reset options for final pass at requested quality
          jc.d.dct_method := jc.FinalDCT;
          jc.d.dither_mode := jc.FinalDitherMode;
          if jc.FinalTwoPassQuant then
          begin
            jc.d.two_pass_quantize := True;
            jc.d.colormap := nil;
          end;
          jpeg_start_output(jc.d, jc.d.input_scan_number);
          DestScanLine := FBitmap.ScanLine[0];
        end;

        // build final color palette
        if (not jc.d.buffered_image or jc.FinalTwoPassQuant) and
          (jc.d.colormap <> nil) and GeneratePalette then
        begin
          FBitmap.Palette := BuildPalette(jc.d);
          PaletteModified := True;
          DestScanLine := FBitmap.ScanLine[0];
        end;
        // final image pass for progressive, first and only pass for baseline
        while (jc.d.output_scanline < jc.d.output_height) do
        begin
          LinesRead := jpeg_read_scanlines(jc.d, @DestScanline, LinesPerCall);
          Inc(Integer(DestScanline), PtrInc * LinesRead);
        end;

        if jc.d.buffered_image then jpeg_finish_output(jc.d);
        jpeg_finish_decompress(jc.d);

         if FBitmap.PixelFormat = pf24bit then
           SwapRedBlue (FBitmap);

      finally
        if ExceptObject = nil then
          PtrInc := 100
        else
          PtrInc := 0;
        Progress(Self, psEnding, PtrInc, PaletteModified, Rect(0,0,0,0), '');
        // Make sure new palette gets realized, in case OnProgress event didn't.
        if PaletteModified then
          Changed(Self);
      end;
    except
      on EAbort do ;   // OnProgress can raise EAbort to cancel image load
    end;
  finally
    ReleaseContext(jc);
  end;
end;

{****************************************************************************}

function TJPEGImage.GetEmpty: Boolean;
begin
  Result := (FImage.FData = nil) and FBitmap.Empty;
end;

{****************************************************************************}

function TJPEGImage.GetGrayscale: Boolean;
begin
  Result := FGrayscale or FImage.FGrayscale;
end;

{****************************************************************************}

function TJPEGImage.GetPalette: HPalette;
var
  DC: HDC;
begin
  Result := 0;
  if FBitmap <> nil then
    Result := FBitmap.Palette
  else if FTempPal <> 0 then
    Result := FTempPal
  else if FPixelFormat = jf24Bit then   // check for 8 bit screen
  begin
    DC := GetDC(0);
    if (GetDeviceCaps(DC, BITSPIXEL) * GetDeviceCaps(DC, PLANES)) <= 8 then
    begin
      FTempPal := CreateHalftonePalette(DC);
      Result := FTempPal;
    end;
    ReleaseDC(0, DC);
  end;
end;

{****************************************************************************}

function TJPEGImage.GetHeight: Integer;
begin
  if FBitmap <> nil then
    Result := FBitmap.Height
  else if FScale = jsFullSize then
    Result := FImage.FHeight
  else
  begin
    CalcOutputDimensions;
    Result := FScaledHeight;
  end;
end;

{****************************************************************************}

function TJPEGImage.GetWidth: Integer;
begin
  if FBitmap <> nil then
    Result := FBitmap.Width
  else if FScale = jsFullSize then
    Result := FImage.FWidth
  else
  begin
    CalcOutputDimensions;
    Result := FScaledWidth;
  end;
end;

{****************************************************************************}

procedure TJPEGImage.JPEGNeeded;
begin
  if FImage.FData = nil then
    Compress;
end;

{****************************************************************************}

procedure TJPEGImage.LoadFromClipboardFormat(AFormat: Word; AData: THandle;
  APalette: HPALETTE);
begin
  //!! check for jpeg clipboard data, mime type image/jpeg
  FBitmap.LoadFromClipboardFormat(AFormat, AData, APalette);
end;

{****************************************************************************}

procedure TJPEGImage.LoadFromStream(Stream: TStream);
begin
  ReadStream(Stream.Size - Stream.Position, Stream);
end;

{****************************************************************************}

procedure TJPEGImage.NewBitmap;
begin
  FBitmap.Free;
  FBitmap := TBitmap.Create;
end;

{****************************************************************************}

procedure TJPEGImage.NewImage;
begin
  if FImage <> nil then FImage.Release;
  FImage := TJPEGData.Create;
  FImage.Reference;
end;

{****************************************************************************}

procedure TJPEGImage.ReadData(Stream: TStream);
var
  Size: Longint;
begin
  Stream.Read(Size, SizeOf(Size));
  ReadStream(Size, Stream);
end;

{****************************************************************************}

procedure TJPEGImage.ReadStream(Size: Longint; Stream: TStream);
var
  jerr: jpeg_error_mgr;
  cinfo: jpeg_decompress_struct;
begin
  NewImage;
  with FImage do
  begin
    FData := TMemoryStream.Create;
    FData.Size := Size;
    Stream.ReadBuffer(FData.Memory^, Size);
    if Size > 0 then
    begin
      jerr := jpeg_std_error;  // use local var for thread isolation
      cinfo.common.err := @jerr;
      jpeg_CreateDecompress(cinfo, JPEG_LIB_VERSION, sizeof(cinfo));
      try
        FData.Position := 0;
//        jpeg_stdio_src(cinfo, FData);
        cinfo.common.client_data := FImage;  
        cinfo.src := @jpeg_std_src;
        cinfo.src.resync_to_restart := jpeg_resync_to_restart;
        jpeg_read_header(cinfo, TRUE);
        FWidth := cinfo.image_width;
        FHeight := cinfo.image_height;
        FGrayscale := cinfo.jpeg_color_space = JCS_GRAYSCALE;
        FProgressiveEncoding := jpeg_has_multiple_scans(cinfo);
      finally
        jpeg_destroy_decompress(cinfo);
      end;
    end;
  end;
  PaletteModified := True;
  Changed(Self);
end;

{****************************************************************************}

procedure TJPEGImage.SaveToClipboardFormat(var AFormat: Word; var AData: THandle;
  var APalette: HPALETTE);
begin
//!!  check for jpeg clipboard format, mime type image/jpeg
  Bitmap.SaveToClipboardFormat(AFormat, AData, APalette);
end;

{****************************************************************************}

procedure TJPEGImage.SaveToStream(Stream: TStream);
begin
  JPEGNeeded;
  with FImage.FData do
    Stream.Write(Memory^, Size);
end;

{****************************************************************************}

procedure TJPEGImage.SetGrayscale(Value: Boolean);
begin
  if FGrayscale <> Value then
  begin
    FreeBitmap;
    FGrayscale := Value;
    PaletteModified := True;
    Changed(Self);
  end;
end;

{****************************************************************************}

procedure TJPEGImage.SetHeight(Value: Integer);
begin
  InvalidOperation(SChangeJPGSize);
end;

{****************************************************************************}

procedure TJPEGImage.SetPalette(Value: HPalette);
var
  SignalChange: Boolean;
begin
  if Value <> FTempPal then
  begin
    SignalChange := (FBitmap <> nil) and (Value <> FBitmap.Palette);
    if SignalChange then FreeBitmap;
    FTempPal := Value;
    if SignalChange then
    begin
      PaletteModified := True;
      Changed(Self);
    end;
  end;
end;

{****************************************************************************}

procedure TJPEGImage.SetPerformance(Value: TJPEGPerformance);
begin
  if FPerformance <> Value then
  begin
    FreeBitmap;
    FPerformance := Value;
    PaletteModified := True;
    Changed(Self);
  end;
end;

{****************************************************************************}

procedure TJPEGImage.SetPixelFormat(Value: TJPEGPixelFormat);
begin
  if FPixelFormat <> Value then
  begin
    FreeBitmap;
    FPixelFormat := Value;
    PaletteModified := True;
    Changed(Self);
  end;
end;

{****************************************************************************}

procedure TJPEGImage.SetScale(Value: TJPEGScale);
begin
  if FScale <> Value then
  begin
    FreeBitmap;
    FScale := Value;
    FNeedRecalc := True;
    Changed(Self);
  end;
end;

{****************************************************************************}

procedure TJPEGImage.SetSmoothing(Value: Boolean);
begin
  if FSmoothing <> Value then
  begin
    FreeBitmap;
    FSmoothing := Value;
    Changed(Self);
  end;
end;

{****************************************************************************}

procedure TJPEGImage.SetWidth(Value: Integer);
begin
  InvalidOperation(SChangeJPGSize);
end;

{****************************************************************************}

procedure TJPEGImage.WriteData(Stream: TStream);
var
  Size: Longint;
begin
  Size := 0;
  if Assigned(FImage.FData) then Size := FImage.FData.Size;
  Stream.Write(Size, Sizeof(Size));
  if Size > 0 then Stream.Write(FImage.FData.Memory^, Size);
end;

{****************************************************************************}

procedure InitDefaults;
var
  DC: HDC;
begin
  DC := GetDC(0);
  if (GetDeviceCaps(DC, BITSPIXEL) * GetDeviceCaps(DC, PLANES)) <= 8 then
    JPEGDefaults.PixelFormat := jf8Bit
  else
    JPEGDefaults.PixelFormat := jf24Bit;
  ReleaseDC(0, DC);
end;

{****************************************************************************}

{$ENDIF} // INCLUDE_JPEG

{****************************************************************************}
{* internal object to facilitate reference counting of a LIBMNG handle      *}
{****************************************************************************}

constructor TNGBitmap.Create;
begin
  inherited;

  HandleType        := bmDIB;                    // we work with 24-bit DIBs only
  PixelFormat       := pf24bit;
  OFImages          := TList.Create;
  OFTimer           := TTimer.Create (nil);
  OFTimer.Enabled   := false;
  OFTimer.OnTimer   := ProcessTimer;
  BFHaveHeader      := false;

  IFAlphaColor      := -1;                       // no transparency supplied yet
  OFAlphaBitmap     := nil;

  IFZLIBLevel       := Z_BEST_COMPRESSION;       // ZLIB compression parameters
  IFZLIBMethod      := Z_DEFLATED;
  IFZLIBWindowbits  := 15;
  IFZLIBMemLevel    := Z_MAX_MEM_LEVEL;
  IFZLIBStrategy    := Z_DEFAULT_STRATEGY;
  IFZLIBMaxIDAT     := 65536;

  IFJPEGQuality     := 90;                       // JPEG compression parameters
  BFJPEGProgressive := false;
  IFJPEGMaxJDAT     := 65536;

  BFStatusCheck     := false;                    // initial libmng status
  BFCreating        := false;
  BFWriting         := false;
  BFReading         := false;
  BFDisplaying      := false;
  BFRunning         := false;

  // initialize the LIBMNG library
  HFHandle := mng_initialize (mng_ptr (self), XNG_alloc, XNG_free, nil);
  if HFHandle = MNG_NULL then
    LibMNG_Error ('Create/initialize');

  // make sure we can save the file later
  if (mng_set_storechunks (HFHandle, MNG_TRUE) <> MNG_NOERROR) then
    LibMNG_Error ('Create/set_storechunks');

  // initialize the callback functions
  if (mng_setcb_openstream    (HFHandle, XNG_openstream   ) <> MNG_NOERROR) or
     (mng_setcb_closestream   (HFHandle, XNG_closestream  ) <> MNG_NOERROR) or
     (mng_setcb_readdata      (HFHandle, XNG_readdata     ) <> MNG_NOERROR) or
     (mng_setcb_writedata     (HFHandle, XNG_writedata    ) <> MNG_NOERROR) or
     (mng_setcb_errorproc     (HFHandle, XNG_errorproc    ) <> MNG_NOERROR) or
     (mng_setcb_processheader (HFHandle, XNG_processheader) <> MNG_NOERROR) or
     (mng_setcb_getcanvasline (HFHandle, XNG_getcanvasline) <> MNG_NOERROR) or
     (mng_setcb_refresh       (HFHandle, XNG_refresh      ) <> MNG_NOERROR) or
     (mng_setcb_gettickcount  (HFHandle, XNG_gettickcount ) <> MNG_NOERROR) or
     (mng_setcb_settimer      (HFHandle, XNG_settimer     ) <> MNG_NOERROR) then
    LibMNG_Error ('Create/setcb_xxxx');

  // initialize the canvas layout
  if (mng_set_canvasstyle     (HFHandle, MNG_CANVAS_BGR8  ) <> MNG_NOERROR) or
     (mng_set_bkgdstyle       (HFHandle, MNG_CANVAS_BGR8  ) <> MNG_NOERROR) then
    LibMNG_Error ('Create/set_canvasstyle');

  CheckStatus;
end;

{****************************************************************************}

destructor TNGBitmap.Destroy;
begin
  // clean it up; let's start with the timer
  OFTimer.Enabled := false;
  if mng_cleanup (HFHandle) <> MNG_NOERROR then
    LibMNG_Error ('Destroy/cleanup');

  OFAlphaBitmap.Free;
  OFTimer.Free;
  OFImages.Free;
  inherited;
end;

{****************************************************************************}

procedure TNGBitmap.AddImage;
begin
  // OFImages.Count is our silent reference-counter :-)
  OFImages.Add (OHImage);
end;

{****************************************************************************}

procedure TNGBitmap.RemoveImage;

var IHX : integer;

begin
  IHX := OFImages.IndexOf (OHImage);
  if IHX >= 0 then
    OFImages.Delete (IHX);
end;

{***************************************************************************}

procedure TNGBitmap.CheckStatus;

var BHChanged    : boolean;
    BHReading    : boolean;
    BHCreating   : boolean;
    BHWriting    : boolean;
    BHDisplaying : boolean;
    BHRunning    : boolean;
    IHX          : integer;
    OHImage      : TNGImage;

begin
  if not BFStatusCheck then            // prevent recusrion !!!
  begin
    BFStatusCheck  := true;

    try                                // get all status variables
      BHReading    := mng_status_reading    (HFHandle);
      BHCreating   := mng_status_creating   (HFHandle);
      BHWriting    := mng_status_writing    (HFHandle);
      BHDisplaying := mng_status_displaying (HFHandle);
      BHRunning    := mng_status_running    (HFHandle);
      BHChanged    := (BHReading <> BFReading) or (BHCreating   <> BFCreating  ) or
                      (BHWriting <> BFWriting) or (BHDisplaying <> BFDisplaying) or
                      (BHRunning <> BFRunning);
      BFReading    := BHReading;
      BFCreating   := BHCreating;
      BFWriting    := BHWriting;
      BFDisplaying := BHDisplaying;
      BFRunning    := BHRunning;

      if BHChanged then                // status changed ?
      begin
        for IHX := pred (OFImages.Count) downto 0 do
        begin                          // notify our parents
          OHImage := TNGImage (OFImages.Items [IHX]);
          if assigned (OHImage.OFStatusChange) then
            OHImage.OFStatusChange (OHImage);
        end;
      end;

    finally
      BFStatusCheck := false;
    end;
  end;
end;

{****************************************************************************}

procedure TNGBitmap.LoadFromStream;

var IHRslt : mng_retcode;

begin
  OFStream      := Stream;
  BFFreeOnClose := false;

  // load it in a single go
  IHRslt        := mng_read (HFHandle);
  if IHRslt <> MNG_NOERROR then
    LibMNG_Error ('LoadFromStream/read');

  // now make sure the first frame is visible
  IHRslt        := mng_display (HFHandle);
  if (IHRslt <> MNG_NOERROR) and (IHRslt <> MNG_NEEDTIMERWAIT) then
    LibMNG_Error ('LoadFromStream/display');

  CheckStatus;
end;

{****************************************************************************}

procedure TNGBitmap.SaveToStream;

var IHRslt : mng_retcode;

begin
  OFStream      := Stream;
  BFFreeOnClose := false;

  // doesn't get easier than this...
  IHRslt        := mng_write (HFHandle);
  if IHRslt <> MNG_NOERROR then
    LibMNG_Error ('SaveToStream/write');

  CheckStatus;
end;

{****************************************************************************}

procedure TNGBitmap.LoadFromFile;

var IHRslt : mng_retcode;

begin
  OFStream      := TFileStream.Create (FileName, fmOpenRead or fmShareDenyWrite);
  BFFreeOnClose := true;

  // load it in a single go
  IHRslt        := mng_read (HFHandle);
  if IHRslt <> MNG_NOERROR then
    LibMNG_Error ('LoadFromFile/read');

  // now make sure the first frame is visible
  IHRslt        := mng_display (HFHandle);
  if (IHRslt <> MNG_NOERROR) and (IHRslt <> MNG_NEEDTIMERWAIT) then
    LibMNG_Error ('LoadFromFile/display');

  CheckStatus;
end;

{****************************************************************************}

procedure TNGBitmap.SaveToFile;

var IHRslt : mng_retcode;

begin
  OFStream      := TFileStream.Create (FileName, fmCreate or fmShareExclusive);
  BFFreeOnClose := true;

  // doesn't get easier than this...
  IHRslt        := mng_write (HFHandle);
  if IHRslt <> MNG_NOERROR then
    LibMNG_Error ('SaveToFile/write');

  CheckStatus;
end;

{****************************************************************************}

procedure TNGBitmap.LoadFromClipboardFormat;
begin
  // sorry; future extension (maybe)
  raise ENGImageException.Create (SCClipboardNotSupported);
end;

{****************************************************************************}

procedure TNGBitmap.SaveToClipboardFormat;
begin
  // sorry; future extension (maybe)
  raise ENGImageException.Create (SCClipboardNotSupported);
end;

{****************************************************************************}

procedure TNGBitmap.ProcessTimer;

var IHRslt : mng_retcode;

begin
  // reset the timer; LIBMNG will set it again if necessary
  OFTimer.Enabled := false;
  // tell LIBMNG to fill the next frame
  IHRslt          := mng_display_resume (HFHandle);
  if (IHRslt <> MNG_NOERROR) and (IHRslt <> MNG_NEEDTIMERWAIT) then
    LibMNG_Error ('ProcessTimer/display_resume');

  CheckStatus;
end;

{****************************************************************************}

procedure TNGBitmap.Refresh;

var IHQ : integer;

begin
  CheckStatus;
  // make sure all our referred images get updated
  for IHQ := pred (OFImages.Count) downto 0 do
    TNGImage (OFImages.Items [IHQ]).Refresh (IHX, IHY, IHWidth, IHHeight);
end;

{****************************************************************************}

procedure TNGBitmap.Rewind;

var IHRslt : mng_retcode;

begin
  OFTimer.Enabled := false;
  if (mng_display_reset (HFHandle) <> MNG_NOERROR) then
    LibMNG_Error ('Rewind/display_reset');

  IHRslt := mng_display (HFHandle);
  if (IHRslt <> MNG_NOERROR) and (IHRslt <> MNG_NEEDTIMERWAIT) then
    LibMNG_Error ('Rewind/display');

  CheckStatus;
end;

{****************************************************************************}

procedure TNGBitmap.Pause;
begin
  OFTimer.Enabled := false;
  if (mng_display_freeze (HFHandle) <> MNG_NOERROR) then
    LibMNG_Error ('Pause/display_freeze');

  CheckStatus;
end;

{****************************************************************************}

procedure TNGBitmap.Play;

var IHRslt : mng_retcode;

begin
  OFTimer.Enabled := false;
  IHRslt          := mng_display_resume (HFHandle);
  if (IHRslt <> MNG_NOERROR) and (IHRslt <> MNG_NEEDTIMERWAIT) then
    LibMNG_Error ('Play/display_resume');

  CheckStatus;
end;

{****************************************************************************}

procedure TNGBitmap.Stop;
begin
  OFTimer.Enabled := false;
  if (mng_display_reset (HFHandle) <> MNG_NOERROR) then
    LibMNG_Error ('Rewind/display_reset');

  CheckStatus;
end;

{***************************************************************************}

function TNGBitmap.CompressRawData;

var IHBufLen : integer;
    IHRslt   : integer;

begin
  IHBufLen := length (SHRawData) + 1000;         // let's assume the worst

  repeat
    Result := StringOfChar  (#0, IHBufLen);      // try a compress
    IHRslt := DeflateString2 (SHRawData, Result, IFZLIBLevel, IFZLIBMethod,
                              IFZLIBWindowBits, IFZLIBMemLevel, IFZLIBStrategy);

    if IHRslt = Z_BUF_ERROR then                 // not enough bufferspace ?
      IHBufLen := IHBufLen + 1000;

  until IHRslt <> Z_BUF_ERROR;                   // until done or error

  if IHRslt <> 0 then                            // just no result on error
    Result := '';                                
end;

{****************************************************************************}

{$IFDEF INCLUDE_PNG_SAVE}
procedure TNGBitmap.CreatePNG;

var SHRawData   : string;
    SHRawData1  : string;
    SHRawData2  : string;
    SHRawData4  : string;
    SHRawData8  : string;
    IHBitDepth  : byte;
    IHColorType : byte;
    BHHasAlpha  : boolean;
    IHMaxCol    : integer;
    AHPalette   : mng_palette8;
    IHMaxAlpha  : integer;
    AHAlpha     : mng_uint8arr;
    AHCounts    : mng_uint32arr;
    AHDummy     : mng_uint8arr;

{===========================================================================}

function GetIndex (IHR, IHG, IHB, IHA : byte) : integer;
begin
  Result := 0;

  while (Result < IHMaxCol) and ((AHPalette [Result].iRed   <> IHR) or
                                 (AHPalette [Result].iGreen <> IHG) or
                                 (AHPalette [Result].iBlue  <> IHB) or
                                 (AHAlpha   [Result]        <> IHA)    )do
    inc (Result);

  if Result >= IHMaxCol then
    Result := -1;
end;

{===========================================================================}

function GetAlphaPixel (IHX, IHY : integer) : byte;
begin
  if not OFAlphaBitmap.Monochrome then
    OFAlphaBitmap.Monochrome := true;
  Result := OFAlphaBitmap.Canvas.Pixels [IHX, IHY] and $FF;
end;

{===========================================================================}

function GetAlpha (PHPixel  : PRGBpixel;
                   IHX, IHY : integer) : byte;
begin
  if OFAlphaBitmap <> nil then
    {TODO: this is really inefficient; optimize !!! }
    Result := GetAlphaPixel (IHX, IHY)
  else
  if (IFAlphaColor >= 0) and (PHPixel^.R = (IFAlphaColor       ) and $FF) and
                             (PHPixel^.G = (IFAlphaColor shr  8) and $FF) and
                             (PHPixel^.B = (IFAlphaColor shr 16) and $FF) then
    Result := 0
  else
    Result := 255;
end;

{===========================================================================}

procedure CalcNrOfUniques;

var PHPixel  : PRGBpixel;
    IHX, IHY : integer;
    IHQ      : integer;
    IHR, IHG : byte;
    IHB, IHA : byte;

begin
  BHHasAlpha := false;
  IHMaxCol   := 0;

  for IHY := 0 to pred (Height) do
  begin
    PHPixel := PRGBpixel (Scanline [IHY]);

    for IHX := 0 to pred (Width) do
    begin
      IHR := PHPixel^.R;
      IHG := PHPixel^.G;
      IHB := PHPixel^.B;
      IHA := GetAlpha (PHPixel, IHX, IHY);

      if IHA < 255 then                // indicate if we encountered transparency
        BHHasAlpha := true;

      if IHMaxCol <= 256 then          // no need to count beyond 256 entries
      begin
        IHQ := GetIndex (IHR, IHG, IHB, IHA);

        if (IHQ >= 0) and (IHQ < IHMaxCol) then
        begin
          AHCounts [IHQ] := AHCounts [IHQ] + 1;
        end
        else
        begin
          if IHMaxCol < 256 then
          begin
            AHPalette [IHMaxCol].iRed   := IHR;
            AHPalette [IHMaxCol].iGreen := IHG;
            AHPalette [IHMaxCol].iBlue  := IHB;
            AHAlpha   [IHMaxCol]        := IHA;
            AHCounts  [IHMaxCol]        := 1;
          end;
          
          inc (IHMaxCol);
        end;
      end;

      PHPixel := PRGBpixel (integer (PHPixel) + 3);
    end;
  end;
end;


{===========================================================================}

procedure OptimizePalette;

var IHX, IHY : integer;

{===========================================================================}

procedure SwapEntry (IHX, IHY : integer);

var IHB : byte;
    IHI : mng_uint32;

begin
  IHB                    := AHPalette [IHX].iRed;
  AHPalette [IHX].iRed   := AHPalette [IHY].iRed;
  AHPalette [IHY].iRed   := IHB;
  IHB                    := AHPalette [IHX].iGreen;
  AHPalette [IHX].iGreen := AHPalette [IHY].iGreen;
  AHPalette [IHY].iGreen := IHB;
  IHB                    := AHPalette [IHX].iBlue;
  AHPalette [IHX].iBlue  := AHPalette [IHY].iBlue;
  AHPalette [IHY].iBlue  := IHB;
  IHB                    := AHAlpha   [IHX];
  AHAlpha   [IHX]        := AHAlpha   [IHY];
  AHAlpha   [IHY]        := IHB;
  IHI                    := AHCounts  [IHX];
  AHCounts  [IHX]        := AHCounts  [IHY];
  AHCounts  [IHY]        := IHI;
end;

{===========================================================================}

begin
  // optimizing the palette
  // put transparent items first
  // both opaque or both transparent sorts on decreasing hist-count
  for IHX := 0 to pred (IHMaxCol) do
  begin
    for IHY := succ (IHX) to pred (IHMaxCol) do
    begin
      if (AHAlpha [IHX] = 255) and (AHAlpha [IHY] = 255) then
      begin
        if AHCounts [IHX] < AHCounts [IHY] then
          SwapEntry (IHX, IHY);
      end
      else
      if (AHAlpha [IHX] = 255) and (AHAlpha [IHY] < 255) then
      begin
        SwapEntry (IHX, IHY);
      end
      else
      if (AHAlpha [IHX] < 255) and (AHAlpha [IHY] < 255) then
      begin
        if AHCounts [IHX] < AHCounts [IHY+1] then
          SwapEntry (IHX, IHY);
      end;
    end;
  end;

  // since all transparent items are first in the palette
  // we can safely discard the ones at the back which are fully opaque
  IHMaxAlpha := IHMaxCol;
  while (IHMaxAlpha > 0) and (AHAlpha [IHMaxAlpha-1] = 255) do
    dec (IHMaxAlpha);
end;

{===========================================================================}

procedure CreateIndexedData1;

var IHX, IHY : integer;
    IHR      : integer;
    IHQ      : integer;
    PHPixel  : PRGBpixel;
    IHLineW  : integer;

begin
  IHLineW    := ((Width + 7) shr 3) + 1;
  SHRawData1 := StringOfChar (#0, IHLineW * Height);

  for IHY := 0 to pred (Height) do
  begin
    PHPixel := PRGBpixel (Scanline [IHY]);
    IHR     := (IHY * IHLineW) + 2;

    for IHX := 0 to pred (Width) do
    begin
      IHQ := GetIndex (PHPixel^.R, PHPixel^.G, PHPixel^.B, GetAlpha (PHPixel, IHX, IHY));

      case (IHX mod 8) of
        0 : SHRawData1 [IHR] := chr ((IHQ and $01) shl 7);
        1 : SHRawData1 [IHR] := chr (ord (SHRawData1 [IHR]) + (IHQ and $01) shl 6);
        2 : SHRawData1 [IHR] := chr (ord (SHRawData1 [IHR]) + (IHQ and $01) shl 5);
        3 : SHRawData1 [IHR] := chr (ord (SHRawData1 [IHR]) + (IHQ and $01) shl 4);
        4 : SHRawData1 [IHR] := chr (ord (SHRawData1 [IHR]) + (IHQ and $01) shl 3);
        5 : SHRawData1 [IHR] := chr (ord (SHRawData1 [IHR]) + (IHQ and $01) shl 2);
        6 : SHRawData1 [IHR] := chr (ord (SHRawData1 [IHR]) + (IHQ and $01) shl 1);
      else  SHRawData1 [IHR] := chr (ord (SHRawData1 [IHR]) + (IHQ and $01));
      end;

      PHPixel := PRGBpixel (integer (PHPixel) + 3);

      if (IHX mod 8) = 7 then
        inc (IHR);
    end;
  end;

  SHRawData1 := CompressRawData (SHRawData1);
end;

{===========================================================================}

procedure CreateIndexedData2;

var IHX, IHY : integer;
    IHR      : integer;
    IHQ      : integer;
    PHPixel  : PRGBpixel;
    IHLineW  : integer;

begin
  IHLineW     := ((Width + 3) shr 2) + 1;
  SHRawData2  := StringOfChar (#0, IHLineW * Height);

  for IHY := 0 to pred (Height) do
  begin
    PHPixel := PRGBpixel (Scanline [IHY]);
    IHR     := (IHY * IHLineW) + 2;

    for IHX := 0 to pred (Width) do
    begin
      IHQ := GetIndex (PHPixel^.R, PHPixel^.G, PHPixel^.B, GetAlpha (PHPixel, IHX, IHY));

      case (IHX mod 4) of
        0 : SHRawData2 [IHR] := chr ((IHQ and $03) shl 6);
        1 : SHRawData2 [IHR] := chr (ord (SHRawData2 [IHR]) + (IHQ and $03) shl 4);
        2 : SHRawData2 [IHR] := chr (ord (SHRawData2 [IHR]) + (IHQ and $03) shl 2);
      else  SHRawData2 [IHR] := chr (ord (SHRawData2 [IHR]) + (IHQ and $03));
      end;

      PHPixel := PRGBpixel (integer (PHPixel) + 3);

      if (IHX mod 4) = 3 then
        inc (IHR);
    end;
  end;

  SHRawData2 := CompressRawData (SHRawData2);
end;

{===========================================================================}

procedure CreateIndexedData4;

var IHX, IHY : integer;
    IHR      : integer;
    IHQ      : integer;
    PHPixel  : PRGBpixel;
    IHLineW  : integer;

begin
  IHLineW    := ((Width + 1) shr 1) + 1;
  SHRawData4 := StringOfChar (#0, IHLineW * Height);

  for IHY := 0 to pred (Height) do
  begin
    PHPixel := PRGBpixel (Scanline [IHY]);
    IHR     := (IHY * IHLineW) + 2;

    for IHX := 0 to pred (Width) do
    begin
      IHQ := GetIndex (PHPixel^.R, PHPixel^.G, PHPixel^.B, GetAlpha (PHPixel, IHX, IHY));

      if (IHX mod 2) = 0 then
        SHRawData4 [IHR] := chr ((IHQ and $0F) shl 4)
      else
        SHRawData4 [IHR] := chr (ord (SHRawData4 [IHR]) + (IHQ and $0F));

      PHPixel := PRGBpixel (integer (PHPixel) + 3);

      if (IHX mod 2) = 1 then
        inc (IHR);
    end;
  end;

  SHRawData4 := CompressRawData (SHRawData4);
end;

{===========================================================================}

procedure CreateIndexedData8;

var IHX, IHY : integer;
    IHR      : integer;
    PHPixel  : PRGBpixel;

begin
  SHRawData8 := StringOfChar (#0, (Width + 1) * Height);

  for IHY := 0 to pred (Height) do
  begin
    PHPixel := PRGBpixel (Scanline [IHY]);
    IHR     := (IHY * (Width + 1)) + 2;

    for IHX := 0 to pred (Width) do
    begin
      SHRawData8 [IHR] := chr (GetIndex (PHPixel^.R, PHPixel^.G, PHPixel^.B,
                                         GetAlpha (PHPixel, IHX, IHY)));
      PHPixel          := PRGBpixel (integer (PHPixel) + 3);
      inc (IHR);
    end;
  end;

  SHRawData8 := CompressRawData (SHRawData8);
end;

{===========================================================================}

procedure CreateRGBAdata8;

var IHX, IHY : integer;
    IHR      : integer;
    PHPixel  : PRGBpixel;

begin
  SHRawData   := StringOfChar (#0, ((Width shl 2) + 1) * Height);
  IHBitDepth  := 8;                    // 8-bit RGBA
  IHColorType := 6;

  for IHY := 0 to pred (Height) do
  begin
    PHPixel := PRGBpixel (Scanline [IHY]);
    IHR     := (IHY * ((Width shl 2) + 1)) + 2;

    for IHX := 0 to pred (Width) do
    begin
      SHRawData [IHR] := chr (PHPixel^.R); inc (IHR);
      SHRawData [IHR] := chr (PHPixel^.G); inc (IHR);
      SHRawData [IHR] := chr (PHPixel^.B); inc (IHR);
      SHRawData [IHR] := chr (GetAlpha (PHPixel, IHX, IHY)); inc (IHR);
      PHPixel         := PRGBpixel (integer (PHPixel) + 3);
    end;
  end;
end;

{===========================================================================}

procedure CreateRGBdata8;

var IHX, IHY : integer;
    IHR      : integer;
    PHPixel  : PRGBpixel;

begin
  SHRawData   := StringOfChar (#0, ((Width * 3) + 1) * Height);
  IHBitDepth  := 8;                    // 8-bit RGB
  IHColorType := 2;

  for IHY := 0 to pred (Height) do
  begin
    PHPixel := PRGBpixel (Scanline [IHY]);
    IHR     := (IHY * ((Width * 3) + 1)) + 2;

    for IHX := 0 to pred (Width) do
    begin
      SHRawData [IHR] := chr (PHPixel^.R); inc (IHR);
      SHRawData [IHR] := chr (PHPixel^.G); inc (IHR);
      SHRawData [IHR] := chr (PHPixel^.B); inc (IHR);
      PHPixel         := PRGBpixel (integer (PHPixel) + 3);
    end;
  end;
end;

{===========================================================================}

begin
  PixelFormat := pf24bit;              // we always want it in this format !!
  CalcNrOfUniques;                     // let's see if we can optimize to indexed-color

  if IHMaxCol <= 256 then              // can we... can we ???
  begin
    OptimizePalette;                   // make it an optimum palette then
    IHColorType := 3;                  // indexed color!

    if IHMaxCol <= 2 then
    begin
      CreateIndexedData1;              // determine best possible compression
      CreateIndexedData2;
      CreateIndexedData4;
      CreateIndexedData8;

      if (length (SHRawData1) < length (SHRawData2)) and
         (length (SHRawData1) < length (SHRawData4)) and
         (length (SHRawData1) < length (SHRawData8)) then
      begin
        SHRawData  := SHRawData1;
        IHBitDepth := 1;
      end
      else
      if (length (SHRawData2) < length (SHRawData4)) and
         (length (SHRawData2) < length (SHRawData8)) then
      begin
        SHRawData  := SHRawData2;
        IHBitDepth := 2;
      end
      else
      if length (SHRawData4) < length (SHRawData8) then
      begin
        SHRawData  := SHRawData4;
        IHBitDepth := 4;
      end
      else
      begin
        SHRawData  := SHRawData8;
        IHBitDepth := 8;
      end;
    end
    else
    if IHMaxCol <= 4 then
    begin
      CreateIndexedData2;              // determine best possible compression
      CreateIndexedData4;
      CreateIndexedData8;

      if (length (SHRawData2) < length (SHRawData4)) and
         (length (SHRawData2) < length (SHRawData8)) then
      begin
        SHRawData  := SHRawData2;
        IHBitDepth := 2;
      end
      else
      if length (SHRawData4) < length (SHRawData8) then
      begin
        SHRawData  := SHRawData4;
        IHBitDepth := 4;
      end
      else
      begin
        SHRawData  := SHRawData8;
        IHBitDepth := 8;
      end;
    end
    else
    if IHMaxCol <= 16 then
    begin
      CreateIndexedData4;              // determine best possible compression
      CreateIndexedData8;

      if length (SHRawData4) < length (SHRawData8) then
      begin
        SHRawData  := SHRawData4;
        IHBitDepth := 4;
      end
      else
      begin
        SHRawData  := SHRawData8;
        IHBitDepth := 8;
      end;
    end
    else
    begin
      CreateIndexedData8;              // always 8-bit here
      SHRawData    := SHRawData8;
      IHBitDepth   := 8;
    end;
  end
  else
  begin
    if BHHasAlpha then                 // do we need the alpha channel ?
      CreateRGBAdata8
    else
      CreateRGBdata8;

    SHRawData := CompressRawData (SHRawData);
  end;

  if SHRawData = '' then               // ZLIB got botched ?
    raise ENGImageException.Create ('Serious ZLIB error...');
                                       // now create the PNG chunks
  if mng_reset (HFHandle) <> MNG_NOERROR then
    LibMNG_Error ('CreatePNG/reset');

  if mng_create (HFHandle) <> MNG_NOERROR then
    LibMNG_Error ('CreatePNG/create');

  if mng_putchunk_ihdr (HFHandle, Width, Height, IHBitdepth,
                        IHColortype, 0, 0, 0) <> MNG_NOERROR then
    LibMNG_Error ('CreatePNG/putchunk_ihdr');

  if mng_putchunk_srgb (HFHandle, MNG_FALSE, 0) <> MNG_NOERROR then
    LibMNG_Error ('CreatePNG/putchunk_srgb');

  if IHColorType = 3 then
  begin
    if mng_putchunk_plte (HFHandle, IHMaxCol, AHPalette) <> MNG_NOERROR then
      LibMNG_Error ('CreatePNG/putchunk_plte');

    if IHMaxAlpha > 0 then
      if mng_putchunk_trns (HFHandle, MNG_FALSE, MNG_FALSE, 3, IHMaxAlpha,
                            AHAlpha, 0, 0, 0, 0, 0, AHDummy) <> MNG_NOERROR then
        LibMNG_Error ('CreatePNG/putchunk_trns');
  end;
                                       // write approprietely sized data chunks
  while length (SHRawdata) > IFZLIBMaxIDAT do
  begin
    if mng_putchunk_idat (HFHandle, IFZLIBMaxIDAT, @SHRawdata [1]) <> MNG_NOERROR then
      LibMNG_Error ('CreatePNG/putchunk_idat');
    delete (SHRawData, 1, IFZLIBMaxIDAT);
  end;

  if SHRawdata <> '' then
    if mng_putchunk_idat (HFHandle, length (SHRawdata), @SHRawdata [1]) <> MNG_NOERROR then
      LibMNG_Error ('CreatePNG/putchunk_idat');

  if mng_putchunk_iend (HFHandle) <> MNG_NOERROR then
    LibMNG_Error ('CreatePNG/putchunk_iend');

  CheckStatus;
end;
{$ENDIF} // INCLUDE_PNG_SAVE

{****************************************************************************}

{$IFDEF INCLUDE_JNG_SAVE}
procedure TNGBitmap.CreateJNG;

var SHJDAT        : string;
    SHIDAT        : string;
    IHColorType   : byte;
    IHAlphaDepth  : byte;
    OHJPEG        : TJPEGimage;
    IHX, IHY      : integer;
    IHZ           : integer;
    OHBitmap      : TBitmap;
    IHR, IHG, IHB : byte;
    PHPixel       : PRGBpixel;

begin
  PixelFormat := pf24bit;              // we always want it in this format!!
  SHIDAT      := '';                   // assume no alpha
  IHColorType := 10;                   // and RGB format
  OHJPEG      := TJPEGimage.Create;

  try
    OHJPEG.Assign (self);              // let's get the JPEG data-stream
    OHJPEG.ProgressiveEncoding := BFJPEGProgressive;
    OHJPEG.CompressionQuality  := IFJPEGQuality;
    OHJPEG.Compress;

    SHJDAT := StringOfChar (#0, OHJPEG.PData.PData.Size);
    move (OHJPEG.PData.PData.Memory^, SHJDAT [1], length (SHJDAT));

  finally
    OHJPEG.Free;
  end;

  if OFAlphaBitmap <> nil then         // do we have a transparency bitmap ?
  begin
    {TODO: this bit can really use some optimization !!! }
    OHBitmap := TBitmap.Create;

    try
      OHBitmap.Width      := Width;
      OHBitmap.Height     := Height;
      OHBitmap.Monochrome := true;
      OHBitmap.Canvas.StretchDraw (Rect (0, 0, Width, Height), OFAlphaBitmap);

      IHColorType := IHColorType + 4;
      SHIDAT      := StringOfChar (#0, (Width + 1) * Height);
      IHZ         := 1;

      for IHY := 0 to pred (Height) do
      begin
        inc (IHZ);
        for IHX := 0 to pred (Width) do
        begin
          SHIDAT [IHZ] := chr (OHBitmap.Canvas.Pixels [IHX, IHY] and $FF);
          inc (IHZ);
        end;
      end;

    finally
      OHBitmap.Free;
    end;
  end
  else
  if IFAlphaColor >= 0 then            // do we have a transparency color ?
  begin
    IHR         := (IFAlphaColor       ) and $FF;
    IHG         := (IFAlphaColor shr  8) and $FF;
    IHB         := (IFAlphaColor shr 16) and $FF;
    IHColorType := IHColorType + 4;
    SHIDAT      := StringOfChar (#0, (Width + 1) * Height);
    IHZ         := 1;

    for IHY := 0 to pred (Height) do
    begin
      inc (IHZ);
      PHPixel := PRGBpixel (Scanline [IHY]);

      for IHX := 0 to pred (Width) do
      begin
        if (PHPixel^.R = IHR) and (PHPixel^.G = IHG) and (PHPixel^.B = IHB) then
          SHIDAT [IHZ] := #0
        else
          SHIDAT [IHZ] := #255;
          
        inc (IHZ);
        PHPixel := PRGBpixel (integer (PHPixel) + 3);
      end;
    end;
  end;

  {TODO: optimize alpha-channel to 1-/2-/4-bit if possible}
  
                                       // now create the JNG chunks
  if mng_reset (HFHandle) <> MNG_NOERROR then
    LibMNG_Error ('CreateJNG/reset');

  if mng_create (HFHandle) <> MNG_NOERROR then
    LibMNG_Error ('CreateJNG/create');

  if SHIDAT <> '' then                 // transparency present ?
    IHAlphaDepth := 8
  else
    IHAlphaDepth := 0;

  if mng_putchunk_jhdr (HFHandle, Width, Height, IHColortype,
                        8, 8, 0, IHAlphaDepth, 0, 0, 0) <> MNG_NOERROR then
    LibMNG_Error ('CreateJNG/putchunk_jhdr');

  if mng_putchunk_srgb (HFHandle, MNG_FALSE, 0) <> MNG_NOERROR then
    LibMNG_Error ('CreateJNG/putchunk_srgb');

  if SHIDAT <> '' then                 // transparency present ?
  begin
    SHIDAT := CompressRawData (SHIDAT);// compress it
    if SHIDAT = '' then                // ZLIB got botched ?
      raise ENGImageException.Create ('Serious ZLIB error...');
                                       // now write approprietely sized chunks
    while length (SHIDAT) > IFZLIBMaxIDAT do
    begin
      if mng_putchunk_idat (HFHandle, IFZLIBMaxIDAT, @SHIDAT [1]) <> MNG_NOERROR then
        LibMNG_Error ('CreateJNG/putchunk_idat');
      delete (SHIDAT, 1, IFZLIBMaxIDAT);
    end;

    if SHIDAT <> '' then
      if mng_putchunk_idat (HFHandle, length (SHIDAT), @SHIDAT [1]) <> MNG_NOERROR then
        LibMNG_Error ('CreateJNG/putchunk_idat');
  end;
                                       // write approprietely sized data chunks
  while length (SHJDAT) > IFJPEGMaxJDAT do
  begin
    if mng_putchunk_jdat (HFHandle, IFJPEGMaxJDAT, @SHJDAT [1]) <> MNG_NOERROR then
      LibMNG_Error ('CreateJNG/putchunk_jdat');
    delete (SHJDAT, 1, IFJPEGMaxJDAT);
  end;

  if SHJDAT <> '' then
    if mng_putchunk_jdat (HFHandle, length (SHJDAT), @SHJDAT [1]) <> MNG_NOERROR then
      LibMNG_Error ('CreateJNG/putchunk_jdat');

  if mng_putchunk_iend (HFHandle) <> MNG_NOERROR then
    LibMNG_Error ('CreateJNG/putchunk_iend');

  CheckStatus;
end;
{$ENDIF} // INCLUDE_JNG_SAVE

{****************************************************************************}

procedure TNGBitmap.LibMNG_Error;

var iErrorcode : mng_uint32;
    iSeverity  : mng_uint8;
    iChunkname : mng_chunkid;
    iChunkseq  : mng_uint32;
    iExtra1    : mng_int32;
    iExtra2    : mng_int32;
    zErrortext : mng_pchar;

begin
  // extract extended error information
  iErrorcode := mng_getlasterror (HFHandle, iSeverity, iChunkname, iChunkseq,
                                            iExtra1, iExtra2, zErrortext);
  // and dump
  raise ENGImageException.CreateFmt (SCNGImageException,
                                     [strpas (zErrortext), iErrorcode, iSeverity,
                                      iChunkseq, iExtra1, iExtra2]);
end;

{****************************************************************************}
{* The PNG/JNG/MNG base class                                               *}
{****************************************************************************}

constructor TNGImage.Create;
begin
  inherited;
  OFCanvas       := nil;
  OFRect         := rect (0,0,1,1);
  BFRefreshing   := false;
  OFBitmap       := nil;
  OFStatusChange := nil;
  
  CreateBitmap;
end;

{****************************************************************************}

destructor TNGImage.Destroy;
begin
  DestroyBitmap;
  inherited;
end;

{****************************************************************************}

procedure TNGImage.Free;
begin
  // prevent animation redraws after we've been sentenced to die
  OFCanvas := nil;
  OFBitmap.RemoveImage (self);
  inherited;
end;

{****************************************************************************}

procedure TNGImage.CreateBitmap;
begin
  // create a "reference-counter" object and sign myself up
  OFBitmap := TNGBitmap.Create;
  OFBitmap.AddImage (self);
end;

{****************************************************************************}

procedure TNGImage.DestroyBitmap;
begin
  // sign myself off from the "reference-counter" object
  OFBitmap.RemoveImage (self);
  // if the receference count has reached rockbottom clean up the object
  if OFBitmap.OFImages.Count <= 0 then
    OFBitmap.Free;
end;

{****************************************************************************}

procedure TNGImage.AssignBitmap;
begin
  // detach from the original "reference-counter" object
  DestroyBitmap;
  // attach to the given object
  OFBitmap := OHBitmap;
  OFBitmap.AddImage (self);
end;

{****************************************************************************}

procedure TNGImage.IsolateBitmap;
begin
  // detach and create new "reference-counter" object if we're sharing it
  if OFBitmap.OFImages.Count > 1 then
  begin
    DestroyBitmap;
    CreateBitmap;
  end;
end;

{****************************************************************************}

procedure TNGImage.LoadFromStream;
begin
  //detach and create new "reference-counter" object if we're sharing it
  IsolateBitmap;
  // let the object do it's work
  OFBitmap.LoadFromStream (Stream);
end;

{****************************************************************************}

procedure TNGImage.SaveToStream;
begin
  // let the object do it's work
  OFBitmap.SaveToStream (Stream);
end;

{****************************************************************************}

procedure TNGImage.LoadFromFile;
begin
  // detach and create new "reference-counter" object if we're sharing it
  IsolateBitmap;
  // let the object do it's work
  OFBitmap.LoadFromFile (FileName);
end;

{****************************************************************************}

procedure TNGImage.SaveToFile;
begin
  // let the object do it's work
  OFBitmap.SaveToFile (FileName);
end;

{****************************************************************************}

procedure TNGImage.LoadFromClipboardFormat;
begin
  // let the object do it's work
  OFBitmap.LoadFromClipboardFormat (AFormat, AData, APalette);
end;

{****************************************************************************}

procedure TNGImage.SaveToClipboardFormat;
begin
  // let the object do it's work
  OFBitmap.SaveToClipboardFormat (AFormat, AData, APalette);
end;

{****************************************************************************}

function  TNGImage.GetHeight;
begin
  // let the object do it's work
  Result := OFBitmap.Height;
end;

{****************************************************************************}

function  TNGImage.GetWidth;
begin
  // let the object do it's work
  Result := OFBitmap.Width;
end;

{****************************************************************************}

function TNGImage.GetEmpty;
begin
  // was LIBMNG initialized?
  Result := (OFBitmap.HFHandle = nil);
end;

{****************************************************************************}

procedure TNGImage.SetHeight;
begin
  // let the object do it's work
  OFBitmap.Height := Value;
end;

{****************************************************************************}

procedure TNGImage.SetWidth;
begin
  // let the object do it's work
  OFBitmap.Width := Value;
end;

{****************************************************************************}

procedure TNGImage.Assign;
begin
  // if it's family, let's do some reference counting and share the LIBMNG handle
  if Source is TNGImage then
    AssignBitmap (TNGImage (Source).OFBitmap)
  else
  if Source is TBitmap then            // is it a TBitmap (or descendant) ?
  begin
    DestroyBitmap;                     // create virgin libmng handle!
    CreateBitmap;                      
    OFBitmap.Assign (Source);
  end;
end;

{****************************************************************************}

procedure TNGImage.Draw;
begin
  // remember that sucker for animations
  OFCanvas := ACanvas;
  OFRect   := Rect;
  // all that's left is to refresh
  Refresh (0, 0, Width, Height);
end;

{****************************************************************************}

procedure TNGImage.Refresh;
begin
  // be sure we have something to paint to and aren't repeating ourself
  if (OFCanvas <> nil) and (not BFRefreshing) and
     (OFBitmap.BFHaveHeader) then
  begin
    BFRefreshing := true;
    try
      OFCanvas.StretchDraw (OFRect, OFBitmap);
    finally
      BFRefreshing := false;
    end;
  end;
end;

{****************************************************************************}

procedure TNGImage.MNG_Rewind;
begin
  OFBitmap.Rewind;
end;

{****************************************************************************}

procedure TNGImage.MNG_Pause;
begin
  OFBitmap.Pause;
end;

{****************************************************************************}

procedure TNGImage.MNG_Play;
begin
  OFBitmap.Play;
end;

{****************************************************************************}

procedure TNGImage.MNG_Stop;
begin
  OFBitmap.Stop;
end;

{****************************************************************************}

function TNGImage.GetLIBMNGVersionText;
begin
  Result := StrPas (mng_version_text);
end;

{****************************************************************************}

function TNGImage.GetLIBMNGVersionDLL;
begin
  Result := mng_version_dll;
end;

{****************************************************************************}

function TNGImage.GetLIBMNGVersionMajor;
begin
  Result := mng_version_major;
end;

{****************************************************************************}

function TNGImage.GetLIBMNGVersionMinor;
begin
  Result := mng_version_minor;
end;

{****************************************************************************}

function TNGImage.GetLIBMNGVersionRelease;
begin
  Result := mng_version_release;
end;

{****************************************************************************}

function TNGImage.GetSignatureType;
begin
  Result :=  mng_get_sigtype (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetImageType;
begin
  Result := mng_get_imagetype (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetTicks;
begin
  Result := mng_get_ticks (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetFrameCount;
begin
  Result := mng_get_framecount (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetLayerCount;
begin
  Result := mng_get_layercount (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetPlayTime;
begin
  Result := mng_get_playtime (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetSimplicity;
begin
  Result := mng_get_simplicity (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetBitdepth;
begin
  Result := mng_get_bitdepth (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetColorType;
begin
  Result := mng_get_colortype (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetCompression;
begin
  Result := mng_get_compression (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetFilter;
begin
  Result := mng_get_filter (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetInterlaceMethod;
begin
  Result := mng_get_interlace (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetAlphaBitdepth;
begin
  Result := mng_get_alphabitdepth (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetAlphaCompression;
begin
  Result := mng_get_alphacompression (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetAlphaFilter;
begin
  Result := mng_get_alphafilter (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetAlphaInterlace;
begin
  Result := mng_get_alphainterlace (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetBGColor;

var IHRed, IHGreen, IHBlue : word;

begin
  mng_get_bgcolor (OFBitmap.HFHandle, IHRed, IHGreen, IHBlue);
  IHRed   := IHRed   shr 8;                 // shift down from 16-bit to 8-bit
  IHGreen := IHGreen shr 8;
  IHBlue  := IHBlue  shr 8;
  Result  := (IHBlue shl 16) + (IHGreen shl 8) + IHRed;
end;

{****************************************************************************}

function TNGImage.GetUseBKGD;
begin
  Result := mng_get_usebkgd (OFBitmap.HFHandle);
end;

{****************************************************************************}

procedure TNGImage.SetBGColor;

var IHRed, IHGreen, IHBlue : word;

begin
  IHRed   := (IHValue       ) and $FF;      // get individual components
  IHGreen := (IHValue shr  8) and $FF;
  IHBlue  := (IHValue shr 16) and $FF;
  IHRed   := IHRed   shl 8 + IHRed;         // scale up from 8-bit to 16-bit
  IHGreen := IHGreen shl 8 + IHGreen;
  IHBlue  := IHBlue  shl 8 + IHBlue;

  mng_set_bgcolor (OFBitmap.HFHandle, IHRed, IHGreen, IHBlue);
  OFBitmap.CheckStatus;
end;

{****************************************************************************}

procedure TNGImage.SetUseBKGD;
begin
  mng_set_usebkgd (OFBitmap.HFHandle, BHValue);
  OFBitmap.CheckStatus;
end;

{****************************************************************************}

function TNGImage.GetZLIBLevel;
begin
  Result := OFBitmap.IFZLIBLevel;
end;

{****************************************************************************}

function TNGImage.GetZLIBMethod;
begin
  Result := OFBitmap.IFZLIBMethod;
end;

{****************************************************************************}

function TNGImage.GetZLIBWindowbits;
begin
  Result := OFBitmap.IFZLIBWindowbits;
end;

{****************************************************************************}

function TNGImage.GetZLIBMemLevel;
begin
  Result := OFBitmap.IFZLIBMemLevel;
end;

{****************************************************************************}

function TNGImage.GetZLIBStrategy;
begin
  Result := OFBitmap.IFZLIBStrategy;
end;

{****************************************************************************}

function TNGImage.GetZLIBMaxIDAT;
begin
  Result := OFBitmap.IFZLIBMaxIDAT;
end;

{****************************************************************************}

procedure TNGImage.SetZLIBLevel;
begin
  OFBitmap.IFZLIBLevel := IHValue;
end;

{****************************************************************************}

procedure TNGImage.SetZLIBMethod;
begin
  OFBitmap.IFZLIBMethod := IHValue;
end;

{****************************************************************************}

procedure TNGImage.SetZLIBWindowbits;
begin
  OFBitmap.IFZLIBWindowbits := IHValue;
end;

{****************************************************************************}

procedure TNGImage.SetZLIBMemLevel;
begin
  OFBitmap.IFZLIBMemLevel := IHValue;
end;

{****************************************************************************}

procedure TNGImage.SetZLIBStrategy;
begin
  OFBitmap.IFZLIBStrategy := IHValue;
end;

{****************************************************************************}

procedure TNGImage.SetZLIBMaxIDAT;
begin
  OFBitmap.IFZLIBMaxIDAT := IHValue;
end;

{****************************************************************************}

function TNGImage.GetJPEGQuality;
begin
  Result := OFBitmap.IFJPEGQuality;
end;

{****************************************************************************}

function TNGImage.GetJPEGProgressive;
begin
  Result := OFBitmap.BFJPEGProgressive;
end;

{****************************************************************************}

function TNGImage.GetJPEGMaxJDAT;
begin
  Result := OFBitmap.IFJPEGMaxJDAT;
end;

{****************************************************************************}

procedure TNGImage.SetJPEGQuality;
begin
  OFBitmap.IFJPEGQuality := IHValue;
end;

{****************************************************************************}

procedure TNGImage.SetJPEGprogressive;
begin
  OFBitmap.BFJPEGProgressive := BHValue;
end;

{****************************************************************************}

procedure TNGImage.SetJPEGMaxJDAT;
begin
  OFBitmap.IFJPEGMaxJDAT := IHValue;
end;

{****************************************************************************}

function TNGImage.GetMNGStartTime;
begin
  Result := mng_get_starttime (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetMNGRunTime;
begin
  Result := mng_get_runtime (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetMNGCurrentFrame;
begin
  Result := mng_get_currentframe (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetMNGCurrentLayer;
begin
  Result := mng_get_currentlayer (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetMNGCurrentPlaytime;
begin
  Result := mng_get_currentplaytime (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetStatusError;
begin
  Result := mng_status_error (OFBitmap.HFHandle);
end;

{****************************************************************************}

function TNGImage.GetStatusReading;
begin
  OFBitmap.CheckStatus;
  Result := OFBitmap.BFReading;
end;

{****************************************************************************}

function TNGImage.GetStatusCreating;
begin
  OFBitmap.CheckStatus;
  Result := OFBitmap.BFCreating;
end;

{****************************************************************************}

function TNGImage.GetStatusWriting;
begin
  OFBitmap.CheckStatus;
  Result := OFBitmap.BFWriting;
end;

{****************************************************************************}

function TNGImage.GetStatusDisplaying;
begin
  OFBitmap.CheckStatus;
  Result := OFBitmap.BFDisplaying;
end;

{****************************************************************************}

function TNGImage.GetStatusRunning;
begin
  OFBitmap.CheckStatus;
  Result := OFBitmap.BFRunning;
end;

{****************************************************************************}

procedure TNGImage.SetAlphaColor;
begin
  OFBitmap.IFAlphaColor := ColorToRGB (Color);
end;

{****************************************************************************}

procedure TNGImage.SetAlphaBitmap;
begin
  OFBitmap.OFAlphaBitmap := TBitmap.Create;
  OFBitmap.OFAlphaBitmap.Assign (Bitmap);
end;

{****************************************************************************}
{* Compression and save to PNG routines                                     *}
{****************************************************************************}

{$IFDEF INCLUDE_PNG_SAVE}
procedure TNGImage.SaveToPNGstream;
begin                                  // must be virgin libmng handle !
  if (GetStatusCreating) or (GetStatusWriting) or (GetStatusDisplaying) then
    raise ENGImageException.Create (SCNGSavePNGillegal);

  OFBitmap.CreatePNG;                  // create chunks and then save it
  SaveToStream (Stream);
end;

{****************************************************************************}

procedure TNGImage.SaveToPNGfile;
begin                                  // must be virgin libmng handle !
  if (GetStatusCreating) or (GetStatusWriting) or (GetStatusDisplaying) then
    raise ENGImageException.Create (SCNGSavePNGillegal);

  OFBitmap.CreatePNG;                  // create chunks and then save it
  SaveToFile (FileName);
end;
{$ENDIF} // INCLUDE_PNG_SAVE

{****************************************************************************}
{* Compression & save to JNG routines                                       *}
{****************************************************************************}

{$IFDEF INCLUDE_JNG_SAVE}
procedure TNGImage.SaveToJNGstream;
begin                                  // must be virgin libmng handle !
  if (GetStatusCreating) or (GetStatusWriting) or (GetStatusDisplaying) then
    raise ENGImageException.Create (SCNGSaveJNGillegal);

  OFBitmap.CreateJNG;                  // create chunks and then save it
  SaveToStream (Stream);
end;

{****************************************************************************}

procedure TNGImage.SaveToJNGfile;
begin                                  // must be virgin libmng handle !
  if (GetStatusCreating) or (GetStatusWriting) or (GetStatusDisplaying) then
    raise ENGImageException.Create (SCNGSaveJNGillegal);

  OFBitmap.CreateJNG;                  // create chunks and then save it
  SaveToFile (FileName);
end;
{$ENDIF} // INCLUDE_JNG_SAVE

{****************************************************************************}
{* Register/Unregister our derived classes                                  *}
{****************************************************************************}

initialization
{$IFDEF INCLUDE_JPEG}
  InitDefaults;
{$IFDEF REGISTER_JPEG}
  TPicture.RegisterFileFormat (SCJPEGExt1, SCJPEGImageFile, TJPEGImage);
  TPicture.RegisterFileFormat (SCJPEGExt2, SCJPEGImageFile, TJPEGImage);
  TPicture.RegisterFileFormat (SCJPEGExt3, SCJPEGImageFile, TJPEGImage);
  TPicture.RegisterFileFormat (SCJPEGExt4, SCJPEGImageFile, TJPEGImage);
{$ENDIF}
{$ENDIF}
{$IFDEF REGISTER_MNG}
  TPicture.RegisterFileFormat (SCMNGExt, SCMNGImageFile, TMNGImage);
{$ENDIF}
{$IFDEF REGISTER_JNG}
  TPicture.RegisterFileFormat (SCJNGExt, SCJNGImageFile, TJNGImage);
{$ENDIF}
{$IFDEF REGISTER_PNG}
  TPicture.RegisterFileFormat (SCPNGExt, SCPNGImageFile, TPNGImage);
{$ENDIF}

{****************************************************************************}

finalization
{$IFDEF REGISTER_PNG}
  TPicture.UnregisterGraphicClass (TPNGImage);
{$ENDIF}
{$IFDEF REGISTER_JNG}
  TPicture.UnregisterGraphicClass (TJNGImage);
{$ENDIF}
{$IFDEF REGISTER_MNG}
  TPicture.UnregisterGraphicClass (TMNGImage);
{$ENDIF}
{$IFDEF REGISTER_JPEG}
  TPicture.UnregisterGraphicClass (TJPEGImage);
{$ENDIF}

{****************************************************************************}

{$WARNINGS ON}
{$HINTS ON}

end.

