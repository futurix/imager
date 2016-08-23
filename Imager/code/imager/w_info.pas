unit w_info;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, c_const, c_utils, ImageEnIO, histogrambox, ieview,
  imageenview;

type
  TfrmInfo = class(TForm)
    btnOK: TButton;
    lvwInfo: TListView;
    pclInfo: TPageControl;
    shtGeneral: TTabSheet;
    shtEXIF: TTabSheet;
    shtHistogram: TTabSheet;
    boxHistogram: THistogramBox;
    cbxRed: TCheckBox;
    cbxGreen: TCheckBox;
    cbxBlue: TCheckBox;
    cbxGray: TCheckBox;
    imgThumb: TImageEnView;
    shtEXIFinfo: TTabSheet;
    lvwEXIF: TListView;

    procedure AddCommonInfo();
    procedure AddToList(name, value: string);
    procedure AddToEXIF(name, value: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbxRedClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInfo: TfrmInfo;

function Log2(X: Extended): Extended;
function Ceil(X: Extended): Integer;
function IsInformed(ext: string):boolean;
function GetInfo(name, value: PChar):BOOL; stdcall;


implementation

uses main, globals, f_filectrl, f_tools;

{$R *.DFM}

function Log2(X: Extended): Extended;
asm
   FLD1
   FLD     X
   FYL2X
   FWAIT
end;

// ceil
function Ceil(X: Extended): Integer;
begin
  Result := Trunc ( X );
  if Frac ( X ) > 0 then
    Inc ( Result );
end;

function IsInformed(ext: string):boolean;
begin
	reg.OpenKey(sModules + '\Info', true);
    if reg.RStr(ext, '') <> '' then
  		Result := true
	else
  		Result := false;
	reg.CloseKey();
end;

procedure TfrmInfo.AddCommonInfo();
begin
	case infImage.file_type of
  		ftLocal:
    		begin
    		case infImage.image_type of
      			itNormal:
       				begin
        			AddToList('Path', infImage.path);
        			AddToList('File Size', Format('%f kb', [(FileSize(infImage.path) / 1024)]));
        			AddToList('File Timestamp', DateTimeToStr(FileDateToDateTime(FileAge(infImage.path))));
        			AddToList('', '');
        			AddToList('Dimensions', IntToStr(frmMain.img.IEBitmap.VclBitmap.Width) + ' x ' + IntToStr(frmMain.img.IEBitmap.VclBitmap.Height));
        			end;
     			itAnimated, itMulti:
        			begin
        			AddToList('Path', infImage.path);
        			AddToList('File Size', Format('%f kb', [(FileSize(infImage.path) / 1024)]));
        			AddToList('File Timestamp', DateTimeToStr(FileDateToDateTime(FileAge(infImage.path))));
        			end;
            end;
    		end;
  		ftUnsaved:
    		begin
    		AddToList('Dimensions', IntToStr(frmMain.img.IEBitmap.VclBitmap.Width) + ' x ' + IntToStr(frmMain.img.IEBitmap.VclBitmap.Height));
    		end;
  	end;
end;

function GetInfo(name, value: PChar):BOOL;
begin
	if name = 'ADD_PREBUILT_INFORMATION' then
  		frmInfo.AddCommonInfo()
	else
  		frmInfo.AddToList(String(name), String(value));
  
	Result := true;
end;

procedure TfrmInfo.AddToList(name, value: string);
var
	tmp: TListItem;
begin
	tmp := lvwInfo.Items.Add();
	tmp.Caption := name;

	if (value <> '') then
  		tmp.SubItems.Add(value);
end;

procedure TfrmInfo.AddToEXIF(name, value: string);
var
	tmp: TListItem;
begin
	tmp := lvwEXIF.Items.Add();
	tmp.Caption := name;

	if (value <> '') then
  		tmp.SubItems.Add(value);
end;

procedure TfrmInfo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
end;

procedure TfrmInfo.FormDestroy(Sender: TObject);
begin
	frmInfo := nil;
end;

procedure TfrmInfo.btnOKClick(Sender: TObject);
begin
	Close();
end;

procedure TfrmInfo.FormCreate(Sender: TObject);
var
	FIPISinfo: TFIPISinfo;
	lib: THandle;
    tempd: double;
    temps: string;
    io: TImageEnIO;
begin
	if IsInformed(ExtractExt(infImage.path)) then
  		begin
  		reg.OpenKey(sModules + '\Info', true);
  		lib := LoadLibrary(PChar(GetAppFolder() + reg.RStr(ExtractExt(infImage.path), '')));
  		reg.CloseKey();

  		if (lib <> 0) then
    		begin
    		@FIPISinfo := GetProcAddress(lib, 'FIPISinfo');

    		if not (@FIPISinfo = nil) then
      			FIPISinfo(PChar(infImage.path), PChar(ExtractExt(infImage.path)), GetInfo, Application.Handle, frmMain.Handle);

    		FreeLibrary(lib);
    		end
  		else
        	AddCommonInfo();
  		end
	else
  		AddCommonInfo();

    // setting histogram
    boxHistogram.AttachedImageEnProc := frmMain.img.Proc;

    // adding EXIF and IPTC information (if applicable)
    if ((infImage.file_type = ftLocal) and (FileExists(infImage.path))) then
    	begin
        io := TImageEnIO.Create(nil);
        io.ParamsFromFile(infImage.path);

        if not io.Aborting then
			begin
            if (io.Params.FileType = ioJPEG) then
            	begin
                AddToList('', '');
                AddToList('JPEG compression', (IntToStr(IECalcJpegFileQuality(infImage.path)) + '% (estimation)'));
                end;

            if io.Params.EXIF_HasEXIFData then
            	begin
                shtEXIFinfo.TabVisible := true;

                if (Trim(io.Params.EXIF_Make)<>'') then
               		AddToEXIF('Manufacturer', io.Params.EXIF_Make);
                if (Trim(io.Params.EXIF_Model)<>'') then
                	AddToEXIF('Model', io.Params.EXIF_Model);

                if ((Trim(io.Params.EXIF_Make)<>'') or (Trim(io.Params.EXIF_Model)<>'')) then
                	AddToEXIF('', '');

                AddToEXIF('Image Dimensions', Format('%d x %d Pixels', [io.Params.EXIF_ExifImageWidth, io.Params.EXIF_ExifImageHeight]));
                AddToEXIF('Resolution', Format('%.1f MP (estimate)', [(io.Params.EXIF_ExifImageWidth * io.Params.EXIF_ExifImageHeight) / (1000 * 1000)]));
                if Assigned(io.Params.EXIF_Bitmap) then
                	begin
                    AddToEXIF('Thumbnail', 'Available (see "EXIF Thumbnail" page)');
                    imgThumb.IEBitmap.Assign(io.Params.EXIF_Bitmap);
                    shtEXIF.TabVisible := true;
                    end
                else
                    AddToEXIF('Thumbnail', 'Not available');

                AddToEXIF('', '');
                if (Trim(io.Params.EXIF_DateTimeOriginal)<>'') then
                	AddToEXIF('Original Date', io.Params.EXIF_DateTimeOriginal);
                if (Trim(io.Params.EXIF_DateTimeDigitized)<>'') then
                	AddToEXIF('Digitized Date', io.Params.EXIF_DateTimeDigitized);

                if ((Trim(io.Params.EXIF_DateTimeOriginal)<>'') or (Trim(io.Params.EXIF_DateTimeDigitized)<>'')) then
                	AddToEXIF('', '');

                AddToEXIF('X Resolution', Format('%-8.2f', [io.Params.EXIF_XResolution]));
                AddToEXIF('Y Resolution', Format('%-8.2f', [io.Params.EXIF_YResolution]));

                AddToEXIF('', '');
                if (Trim(io.Params.EXIF_Software)<>'') then
                	AddToEXIF('Software', io.Params.EXIF_Software);
                AddToEXIF('ISO', IntToStr(io.Params.EXIF_ISOSpeedRatings[0]));
                AddToEXIF('FNumber', 'F' + Format('%-4.1f', [io.Params.EXIF_FNumber]));

       			if (io.Params.EXIF_ExposureTime <> 0) then
        			AddToEXIF('Exposure Time', Format('1/%d sec', [Round ( 1 / io.Params.EXIF_ExposureTime )]))
      			else
        			AddToEXIF('Exposure Time', 'Unknown' );

                AddToEXIF('Focal Length', Format('%-4.1f', [io.Params.EXIF_FocalLength] ) + ' mm.');

                case io.Params.EXIF_ExposureProgram of
                    0: temps := 'Unknown';
        			1: temps := 'Manual control';
        			2: temps := 'Normal';
        			3: temps := 'Aperture priority';
        			4: temps := 'Shutter priority';
        			5: temps := 'Creative (slow program)';
        			6: temps := 'Action(high-speed program)';
        			7: temps := 'Portrait mode';
        			8: temps := 'Landscape mode';
                    else
                    	temps := 'Unknown';
      			end;
                AddToEXIF('Exposure Program', temps);

                case io.Params.EXIF_LightSource of
        			0: temps := 'Unknown';
        			1: temps := 'Daylight';
        			2: temps := 'Fluorescent';
        			3: temps := 'Tungsten';
        			10: temps := 'Flash';
        			17: temps := 'Standard light A';
        			18: temps := 'Standard light B';
        			19: temps := 'Standard light C';
        			20: temps := 'D55';
        			21: temps := 'D65';
        			22: temps := 'D75';
                    255: temps := 'Other';
                    else
                    	temps := 'Unknown';
      			end;
                AddToEXIF('Light Source', temps);

                case io.Params.EXIF_Flash of
                    0: temps := 'Flash did not fire';
        			1: temps := 'Flash fired';
        			5: temps := 'Flash fired but strobe return light not detected';
        			7: temps := 'Flash fired and strobe return light detected';
        			9: temps := 'Flash fired, compulsory flash mode';
        			25: temps := '(25) Onboard Flash fired';
        			73: temps := '(73) Onboard Flash fired';
        			89: temps := '(89) Onboard Flash fired';
                    else
                    	temps := 'Unknown';
      			end;
                AddToEXIF('Flash', temps);

                if (io.Params.EXIF_MaxApertureValue > 0) then
        			tempd := Ceil(2 * Log2(io.Params.EXIF_MaxApertureValue))
      			else
        			tempd := 0;

                AddToEXIF('Max Aperture Value', 'F' + Format('%-4.1f', [tempd]));

                case io.Params.EXIF_MeteringMode of
        			0: temps := 'Unknown';
        			1: temps := 'Average';
        			2: temps := 'Center weighted average';
        			3: temps := 'Spot';
        			4: temps := 'Multi-spot';
        			5: temps := 'Multi-segment';
        			6: temps := 'Partial';
                    255: temps := 'Other';
        			else
                    	temps := 'Unknown';
      			end;
     			AddToEXIF('Metering Mode', temps);

                AddToEXIF('Exposure Bias Value', Format('%-8.2f', [io.Params.EXIF_ExposureBiasValue]));
      			AddToEXIF('Brightness Value', Format('%-8.2f', [io.Params.EXIF_BrightnessValue]));

      			case io.Params.EXIF_SensingMethod of
                    0: temps := 'Unknown';
        			2: temps := '1 chip color area sensor';
                    else
                    	temps := 'Unknown';
      			end;
      			AddToEXIF('Sensing Method', temps);

      			AddToEXIF('White Point', Format('%-8.2f', [io.Params.EXIF_WhitePoint[0]]));
      			AddToEXIF('Reference Black White', Format('%-8.2f', [io.Params.EXIF_ReferenceBlackWhite[0]]));
      			AddToEXIF('YCbCr Coefficients', Format('%-8.2f', [io.Params.EXIF_YCbCrCoefficients[1]]));
      			AddToEXIF('FlashPix Version', io.Params.EXIF_FlashPixVersion);

      			case io.Params.EXIF_ColorSpace of
        			1: temps := 'sRGB';
        			65535: temps := 'Uncalibrated'
        			else
        				temps := 'Unknown';
      			end;
                AddToEXIF('Color Space', temps);

      			AddToEXIF('Focal Plane X Resolution', Format('%-8.2f', [io.Params.EXIF_FocalPlaneXResolution]));
     			AddToEXIF('Focal Plane Y Resolution', Format('%-8.2f', [io.Params.EXIF_FocalPlaneYResolution]));

                case io.Params.EXIF_FocalPlaneResolutionUnit of
                    1: temps := 'No-unit';
        			2: temps := 'Inches';
        			3: temps := 'Centimeter';
                    else
                    	temps := 'Unknown';
      			end;
      			AddToEXIF('Focal Plane Resolution Unit', temps);

      			AddToEXIF('Primary Chromaticities', Format('%-8.2f', [io.Params.EXIF_PrimaryChromaticities[0]]));
      			AddToEXIF('EXIF Version', io.Params.EXIF_ExifVersion);
      			AddToEXIF('Compressed BitsPerPixel', Format('%-8.1f', [io.Params.EXIF_CompressedBitsPerPixel]));

      			case io.Params.EXIF_ResolutionUnit of
                    1: temps := 'No-unit';
        			2: temps := 'Inches';
        			3: temps := 'Centimeter';
                    else
                    	temps := 'Unknown';
      			end;
      			AddToEXIF('Resolution Unit', temps);

      			case io.Params.EXIF_YCbCrPositioning of
                    1: temps := 'Center of pixel array';
        			2: temps := 'Datum point';
                    else
                    	temps := 'Unknown';
     			end;
      			AddToEXIF('YCbCr Positioning', temps);

      			case io.Params.EXIF_Orientation of
        			1: temps := 'Top left side';
        			2: temps := 'Top right side';
        			3: temps := 'Bottom right side';
        			4: temps := 'Bottom left side';
        			5: temps := 'Left side top';
        			6: temps := 'Right side top';
        			7: temps := 'Right side bottom';
        			8: temps := 'Left side bottom';
                    else
                    	temps := 'Unknown';
      			end;
      			AddToEXIF('Orientation', temps);

      			AddToEXIF('Image Description', io.Params.EXIF_ImageDescription);
      			AddToEXIF('Scene Type', IntToStr(io.Params.EXIF_SceneType));
      			AddToEXIF('Subject Distance', Format('%-8.2f', [io.Params.EXIF_SubjectDistance]));
      			AddToEXIF('Subsec Time', io.Params.EXIF_SubsecTime);
      			AddToEXIF('Subsec Time Original', io.Params.EXIF_SubsecTimeOriginal);
      			AddToEXIF('Related Sound File', io.Params.EXIF_RelatedSoundFile);
      			AddToEXIF('Exposure Index', Format('%-8.2f', [io.Params.EXIF_ExposureIndex]));

      			AddToEXIF('', '');
      			if io.Params.EXIF_FileSource = 3 then
        			AddToEXIF('File Source', 'Digital Still Camera');

      			AddToEXIF('', '');
      			AddToEXIF('Copyright', io.Params.EXIF_Copyright);
      			AddToEXIF('User Comment Code', io.Params.EXIF_UserCommentCode);
      			AddToEXIF('User Comment', io.Params.EXIF_UserComment);
                end;
            end;

        FreeAndNil(io);
        end;
end;

procedure TfrmInfo.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
	if Key = VK_ESCAPE then
  		Self.Close();
end;

procedure TfrmInfo.cbxRedClick(Sender: TObject);
begin
	if cbxRed.Checked then
        boxHistogram.HistogramKind := boxHistogram.HistogramKind + [hkRed]
    else
    	boxHistogram.HistogramKind := boxHistogram.HistogramKind - [hkRed];
	if cbxGreen.Checked then
    	boxHistogram.HistogramKind := boxHistogram.HistogramKind + [hkGreen]
    else
    	boxHistogram.HistogramKind := boxHistogram.HistogramKind - [hkGreen];
	if cbxBlue.Checked then
    	boxHistogram.HistogramKind := boxHistogram.HistogramKind + [hkBlue]
    else
    	boxHistogram.HistogramKind := boxHistogram.HistogramKind - [hkBlue];
	if cbxGray.Checked then
    	boxHistogram.HistogramKind := boxHistogram.HistogramKind + [hkGray]
    else
    	boxHistogram.HistogramKind := boxHistogram.HistogramKind - [hkGray];
end;

end.
