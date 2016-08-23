{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnThbnCr
|
| Description: Thumbnail creator class.
|
| History: Nov 14, 2001. MB first version
|
|---------------------------------------------------------------------------}
unit EnThbnCr;

interface

uses
    Classes,  { for TStringList }
    EnMisc,   { for TEnvisionProgressEvent }
    EnDigrph, { for TRgb }
    EnTransf; { for TResizeTransform }

type

TGetThumbnailFileNameEvent = function( const FileName : String ) : String of object;

TThumbnailCreator = class(TObject)
protected
    FThumbnailWidth         : Integer;
    FThumbnailHeight        : Integer;

    FEnlargeSmallImages     : Boolean;

    FFileNames              : TStringList;

    FOnGetThumbnailFileName : TGetThumbnailFileNameEvent;

    FThumbnailSuffix        : String;

    FOutputDirectory        : String;

    FOnProgress             : TEnvisionProgressEvent;

    FBackgroundColor        : EnDiGrph.TRgb;

    FResizeTransform        : TResizeTransform;

    FErrors                 : TStringList;

    { By default, GetThumbnailFileName is not overriden, it will check if
      the OnGetThumbnailFileName handler is assigned. If the handler is
      not assigned, and the function is not overriden, the thumbnails will
      get the ThumbnailSuffix added just before the extension. }
    function GetThumbnailFileName( const FileName : String ) : String; virtual;

    function GetInterpolated : Boolean;
    procedure SetInterpolated( const Interpolated : Boolean );

    function GetFilter : TInterpolationFilter;
    procedure SetFilter( const Filter : TInterpolationFilter );

    function GetOverrideDestFormat : Boolean;
    procedure SetOverrideDestFormat( const OverrideDestFormat : Boolean );

    function GetDestFormat : TImageFormat;
    procedure SetDestFormat( const DestFormat : TImageFormat );

    function GetFileCount : Integer;

    procedure SetOutputDirectory( const Directory : String );

public

    constructor Create;
    destructor Destroy; override;

    procedure Execute;

    { Add a file to the list of files for which to create thumbnails. FileName
      may include wild cards such as  c:\images\*.jpg. An exception will be
      raised if a file name's extension is not a registered graphic format.  }
    procedure AddFile( const FileName : String );

    procedure ClearFileNames;

    { Returns the number of files currently in the file name list }
    property FileCount : Integer read GetFileCount;

    property OnProgress : TEnvisionProgressEvent read FOnProgress
                                                 write FOnProgress;

    { Output directory where the thumbnail files will be created. If empty,
      the thumbnail files are created in the same directory as the original
      image }
    property OutputDirectory : String read FOutputDirectory
                                      write SetOutputDirectory;

    property ThumbnailWidth  : LongInt read FThumbnailWidth
                                       write FThumbnailWidth;

    property ThumbnailHeight : LongInt read FThumbnailHeight
                                       write FThumbnailHeight;

    property Interpolated : Boolean read GetInterpolated
                                    write SetInterpolated;

    property Filter : TInterpolationFilter read GetFilter
                                           write SetFilter;

    property OverrideDestFormat : Boolean read GetOverrideDestFormat
                                          write SetOverrideDestFormat;

    property DestFormat : TImageFormat read GetDestFormat
                                       write SetDestFormat;

    property ResizeTransform : TResizeTransform read FResizeTransform;

    { If EnlargeSmallImages is True, images small than ThumbnailWidth,
      ThumbnailHeight will be stretched to the larger dimensions that
      fits ThumbnailWidth, ThumbnailHeight while maintaining the aspect
      ratio. If False, smaller images are not resized. }
    property EnlargeSmallImages : Boolean read FEnlargeSmallImages
                                          write FEnlargeSmallImages;

    { If EnlargeSmallImages is False, BackgroundColor is used to file the
      background of the thumbnail image. Default is white. }
    property BackgroundColor : TRgb read FBackgroundColor
                                    write FBackgroundColor;

    { if the OnGetThumbnailFileName handler is not assigned, all thumbnail
      files will get their file name by adding ThumbnailSuffix before the
      extention. Default value is '_thumb'. For example, Clown.Jpg would
      have its thumbnail called Clown_thumb.jpg }
    property ThumbnailSuffix : String read FThumbnailSuffix
                                      write FThumbnailSuffix;


    { MB Apr 23, 2003.
      After a call to Execute, Errors will contain an error description, one
      line for each file for which a thumbnail wa not generated }
    property Errors : TStringList read FErrors;

    { Provide an OnGetThumbnailFileName to override the default behavior to
      determine the thumbnail file names. Also, it is possible to override
      the GetThumbnailFileName method }
    property OnGetThumbnailFileName : TGetThumbnailFileNameEvent
                                        read FOnGetThumbnailFileName
                                        write FOnGetThumbnailFileName;

end;

{--------------------------------------------------------------------------}

implementation

uses
    Windows,
    FileCtrl, { for DirectoryExists }
    SysUtils, { for ExtractFilePath, ExtractFileName }
    EnMsg;    { for DirectoryExists }

const

CDefaultThumbnailSuffix = '_thumb';

{--------------------------------------------------------------------------}

constructor TThumbnailCreator.Create;
begin
    inherited Create;

    FResizeTransform       := TResizeTransform.Create;
    FFileNames             := TStringList.Create;
    FErrors                := TStringList.Create;

    ThumbnailWidth         := 60;
    ThumbnailHeight        := 60;
    EnlargeSmallImages     := False;
    ThumbnailSuffix        := CDefaultThumbnailSuffix;
    BackgroundColor        := CWhiteRgb;
end;

{--------------------------------------------------------------------------}

destructor TThumbnailCreator.Destroy;
begin
    FErrors.Free;
    FFileNames.Free;
    FResizeTransform.Free;

    inherited Destroy;
end;

{--------------------------------------------------------------------------}

function TThumbnailCreator.GetThumbnailFileName( const FileName : String ) : String;
begin
    if Assigned(FOnGetThumbnailFileName) then
        Result := FOnGetThumbnailFileName(FileName)
    else
    begin
        Result := ExtractFilePath(FileName) +
                  ChangeFileExt(FileName, '') + ThumbnailSuffix + ExtractFileExt(FileName);
    end;

    if OutputDirectory <> '' then
        Result := AddBackSlashToPath(OutputDirectory) + ExtractFileName(Result);
end;

{--------------------------------------------------------------------------}

function TThumbnailCreator.GetInterpolated : Boolean;
begin
    Result := FResizeTransform.Interpolated;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailCreator.SetInterpolated( const Interpolated : Boolean );
begin
    FResizeTransform.Interpolated := Interpolated;
end;

{--------------------------------------------------------------------------}

function TThumbnailCreator.GetFilter : TInterpolationFilter;
begin
    Result := FResizeTransform.Filter;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailCreator.SetFilter( const Filter : TInterpolationFilter );
begin
    FResizeTransform.Filter := Filter;
end;

{--------------------------------------------------------------------------}

function TThumbnailCreator.GetOverrideDestFormat : Boolean;
begin
    Result := FResizeTransform.OverrideDestFormat;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailCreator.SetOverrideDestFormat( const OverrideDestFormat : Boolean );
begin
    FResizeTransform.OverrideDestFormat := OverrideDestFormat;
end;

{--------------------------------------------------------------------------}

function TThumbnailCreator.GetDestFormat : TImageFormat;
begin
    Result := FResizeTransform.DestFormat;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailCreator.SetDestFormat( const DestFormat : TImageFormat );
begin
    FResizeTransform.DestFormat := DestFormat;
end;

{--------------------------------------------------------------------------}

function TThumbnailCreator.GetFileCount : Integer;
begin
    Result := FFileNames.Count;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailCreator.SetOutputDirectory( const Directory : String );
begin
    if not DirectoryExists(Directory) then
        raise EEnvisionError.Create(msgDirectoryDoesNotExist + ', ' + Directory);

    FOutputDirectory := Directory;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailCreator.Execute;
var
    Index           : Integer;
    SourceGraphic   : TDibGraphic;
    DestGraphic     : TDibGraphic;
    DestFileName    : String;
    Loaded          : Boolean;

    procedure Resize;
    var
        Factor : Single;
    begin
        if SourceGraphic.Width > SourceGraphic.Height then
            Factor := ThumbnailWidth / SourceGraphic.Width
        else
            Factor := ThumbnailHeight / SourceGraphic.Height;

        FResizeTransform.Width  := Round(SourceGraphic.Width * Factor);
        FResizeTransform.Height := Round(SourceGraphic.Height * Factor);

        { make the "short side" and even number so that the image is exactly
          centered in the thumbnail }
        if (FResizeTransform.Width < ThumbnailWidth) and
           EnMisc.IsOdd(FResizeTransform.Width) and
           (FResizeTransform.Width > 0) then
            FResizeTransform.Width := FResizeTransform.Width - 1;

        if (FResizeTransform.Height < ThumbnailHeight) and
           EnMisc.IsOdd(FResizeTransform.Height) and
           (FResizeTransform.Height  > 0) then
            FResizeTransform.Height := FResizeTransform.Height - 1;

        FResizeTransform.Apply( SourceGraphic );

        DestGraphic.NewImage( ThumbnailWidth, ThumbnailHeight,
                              SourceGraphic.ImageFormat,
                              SourceGraphic.PalettePtr,
                              SourceGraphic.XDotsPerInch,
                              SourceGraphic.YDotsPerInch );
        DestGraphic.Fill( BackgroundColor );

        DestGraphic.Canvas.Draw( (ThumbnailWidth - SourceGraphic.Width) div 2,
                                 (ThumbnailHeight - SourceGraphic.Height) div 2,
                                 SourceGraphic );
    end;

begin
    FErrors.Clear;
    DoProgress( Self, FOnProgress, 0, 0, FFileNames.Count - 1, -1 );
    try

        for Index := 0 to (FFileNames.Count - 1) do
        begin
            { MB Apr 23, 2003. Avoid aborting on exception. Accumulate errors }
            try
                DestFileName := GetThumbnailFileName(FFileNames[Index]);

                SourceGraphic   := NewDibGraphic(FFileNames[Index]);
                DestGraphic     := NewDibGraphic(DestFileName);
                try
                    Loaded := True;
                    try
                         SourceGraphic.LoadFromFile(FFileNames[Index]);
                    except
                        Loaded := False;
                    end;

                    if Loaded then
                    begin
                        if (SourceGraphic.Width  < ThumbnailWidth) and
                           (SourceGraphic.Height < ThumbnailHeight) then
                        begin
                            if EnlargeSmallImages then
                                 Resize
                            else
                            begin
                                 DestGraphic.NewImage( ThumbnailWidth, ThumbnailHeight,
                                                       SourceGraphic.ImageFormat,
                                                       SourceGraphic.PalettePtr,
                                                       SourceGraphic.XDotsPerInch,
                                                       SourceGraphic.YDotsPerInch );
                                 DestGraphic.Fill( BackgroundColor );
                                 DestGraphic.Canvas.Draw( (ThumbnailWidth - SourceGraphic.Width) div 2,
                                                          (ThumbnailHeight - SourceGraphic.Height) div 2,
                                                           SourceGraphic );
                            end;
                        end
                        else
                            Resize;

                        DestGraphic.SaveToFile(DestFileName);

                    end; { Loaded }

                    DoProgress( Self, FOnProgress, Index,
                                0, FFileNames.Count - 1, -1 );
                finally
                    SourceGraphic.Free;
                    DestGraphic.Free;
                end;

            except
                on E:Exception do
                begin
                    Errors.Add( FFileNames[Index] + ', ' + E.Message );
                end;
            end;
        end;
    finally
        DoProgress( Self, FOnProgress, FFileNames.Count - 1, 0, FFileNames.Count - 1, -1 );
    end;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailCreator.AddFile( const FileName : String );

    procedure TestFormatAndAdd( const FileName : String;
                                const Path     : String);
    begin
        if FindDibGraphicClass(FileName) <> nil then
            FFileNames.Add(Path + FileName);
    end;

var
    SearchRec  : TSearchRec;
    Attributes : Integer;
    Path       : String;
begin
    Path       := ExtractFilePath(FileName);

    { Mar 08, 2003. Also include hidden. }
    Attributes := faReadOnly + faArchive + faHidden;

    if FindFirst(FileName, Attributes, SearchRec) = 0 then
    begin
        TestFormatAndAdd(SearchRec.Name, Path);

        while FindNext(SearchRec) = 0 do
            TestFormatAndAdd(SearchRec.Name, Path);

        FindClose(SearchRec);
    end;
end;

{--------------------------------------------------------------------------}

procedure TThumbnailCreator.ClearFileNames;
begin
    FFileNames.Clear;
end;

{--------------------------------------------------------------------------}

end.
