unit mpMNGZLIB;

interface

{***************************************************************************}

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

{***************************************************************************}

const
  ZLIB_VERSION = '1.1.3';

{***************************************************************************}

type
  alloc_func = function  (opaque  : pointer;
                          items   : integer;
                          size    : integer) : pointer; stdcall;
  free_func  = procedure (opaque  : pointer;
                          address : pointer); stdcall;

{***************************************************************************}

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

{***************************************************************************}

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

{***************************************************************************}

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

{***************************************************************************}

implementation

{****************************************************************************}

const mngdll = 'libmng.dll';

{***************************************************************************}

function deflateInit_         (strm        : z_streamp;
                               level       : integer;
                               version     : pchar;
                               stream_size : integer  ) : integer; stdcall;
                                                                   external mngdll;

function inflateInit_         (strm        : z_streamp;
                               version     : pchar;
                               stream_size : integer  ) : integer; stdcall;
                                                                   external mngdll;

function deflateInit2_        (strm        : z_streamp;
                               level       : integer;
                               method      : integer;
                               windowBits  : integer;
                               memLevel    : integer;
                               strategy    : integer;
                               version     : pchar;
                               stream_size : integer  ) : integer; stdcall;
                                                                   external mngdll;

function inflateInit2_        (strm        : z_streamp;
                               windowBits  : integer;
                               version     : pchar;
                               stream_size : integer  ) : integer; stdcall;
                                                                   external mngdll;

{***************************************************************************}

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

{***************************************************************************}

function deflateInit;
begin
  Result := deflateInit_ (strm, level, ZLIB_VERSION, sizeof (z_stream));
end;

{***************************************************************************}

function inflateInit;
begin
  Result := inflateInit_ (strm, ZLIB_VERSION, sizeof (z_stream));
end;

{***************************************************************************}

function deflateInit2;
begin
  Result := deflateInit2_ (strm, level, method, windowBits, memLevel, strategy,
                           ZLIB_VERSION, sizeof (z_stream));
end;

{***************************************************************************}

function inflateInit2;
begin
  Result := inflateInit2_ (strm, windowBits, ZLIB_VERSION, sizeof (z_stream));
end;

{***************************************************************************}

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

{***************************************************************************}

end.
