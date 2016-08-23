///////////////////////////////////////////////////////////////////////////////////////////////
//
// AnalyzerPlugins.pas - Base unit for creating image processing plugins for Image Analyzer
// ----------------------------------------------------------------------------------------
// Version:   2003-08-18
// Maintain:  Michael Vinther    |     mv@logicnet.dk
//
// Last changes:
//
unit AnalyzerPlugins;

interface

uses Windows, SysUtils;

type
  TBGRPalette = packed array[0..255] of packed record
                  B, G, R : Byte;
                end;

  PBGRPalette = ^TBGRPalette;
  TImageContainer = packed record
                      Width, Height : Integer;
                      BytesPerLine : Integer;
                      PixelFormat : Integer; // $00 // Map is a pointer to a zero-terminated string
                                             // $01 // 8 bit. If Palette is NULL when using this format, grayscale is assumed
                                             // $21 // 16 bit grayscale
                                             // $03 // 24 bit color. Image Analyzer will always give 24 bit images in this format
                                             // $04 // 32 bit color.
                                             // $13 // 24 bit, non-interleaved
                                             // $18 // Real matrix each pixel is a double
                                             // $28 // Complex matrix, two doubles per pixel: Re,Im
                      Map : PByteArray;
                      Palette : PBGRPalette;
                      Options : PChar;
                    end;
  PImageContainer = ^TImageContainer;


// Add item to program main menu
const cmdMakeMenuItem = 1;
type TMakeMenuItem = packed record // This command can only be issued from RegisterPlugin
  Menu    : PChar;
  Caption : PChar;
  Hint    : PChar;
  Tag     : Integer; // For identification in ProcessImage
end;
PMakeMenuItem = ^TMakeMenuItem;

// Create new image window
const cmdCreateImageWindow = 2;
type TCreateImageWindow = packed record
  Name  : PChar;
  Image : TImageContainer;
end;
PCreateImageWindow = ^TCreateImageWindow;

// Get image from image window
const cmdGetImageWindow = 3;
type TGetImageWindow = packed record
  WindowNumber : Integer;

  // Set by Analyzer:
  TotalWindowCount : Integer;
  Name             : PChar;
  Image            : TImageContainer;
  Selection        : TRect;
end;
PGetImageWindow = ^TGetImageWindow;

// Get handle of main window
const cmdGetMainWindowHandle = 4;
type TGetMainWindowHandle = packed record
  Handle : THandle;
end;

// Update progress and refresh screen
const cmdUpdateProgress = 5;
type TUpdateProgress = packed record
  Progress : Integer;
end;

// Get program version
const cmdGetProgramVersion = 6;
type TGetProgramVersion = packed record
  Version : Integer;
end;

// Set file open capability
const cmdSetFileOpenCapability = 7;
type TSetFileOpenCapability = packed record // This command can only be issued from RegisterPlugin
  Filter  : PChar;   // File format filter, e.g. '3D models (*.ply;*.3ds)|*.ply;*.3ds'
  Tag     : Integer; // For identification in ProcessImage. Image.Map will point to file name
end;
PSetFileOpenCapability = ^TSetFileOpenCapability;

// Open file
const cmdOpenFile = 8;
type TOpenFile = packed record
  FileName : PChar;
end;

// Function for sending cmdXXX commands to Image Analyzer
// TAnalyzerCallback function should return 0 on failure
TAnalyzerCallback = function(Command: Integer; Data: Pointer): LongBool; stdcall;

// RegisterPlugin function should return 0 on failure
TRegisterPlugin = function(CallBack: TAnalyzerCallback): LongBool; stdcall;

// Return codes:
//   0 : Ok
//   1 : Image unassigned/not changed
//   2 : Unable to open file
//   3 : Encoding/decoding error
//   4 : Unsupported pixel format
//   5 : Unable to close file (?)
//   6 : Operation not supported
TProcessImage = function(Tag: Integer; Image: PImageContainer): Integer; stdcall;


var
  AnalyzerCallback : TAnalyzerCallback = nil;

procedure RaisePluginError(Result: Integer; Default: string='');

implementation

procedure RaisePluginError(Result: Integer; Default: string);
begin
  if Result<>0 then
  begin
    case Result of
      2 : raise Exception.Create('Unable to open file');
      3 : raise Exception.Create('Error in bitmap data');
      4 : raise Exception.Create('Unsupported pixel format');
      5 : raise Exception.Create('Unable to close file');
    else
      begin
        Default:='Process failed: %d';
        raise Exception.CreateFmt(Default,[Result]);
      end;
    end;
  end;
end;

end.

