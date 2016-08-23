unit w_info;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Math, ToolWin,
  ImageEnIO, histogrambox, ieview, imageenview, imageenproc,
  c_reg, c_const, c_utils;

type
  TfrmInfo = class(TForm)
    btnClose: TButton;
    lvwInfo: TListView;
    pclInfo: TPageControl;
    shtGeneral: TTabSheet;
    shtEXIF: TTabSheet;
    imgThumb: TImageEnView;
    shtEXIFinfo: TTabSheet;
    lvwEXIF: TListView;
    shtHist: TTabSheet;
    pnlHist: TPanel;
    rbnAll: TRadioButton;
    rbnGrey: TRadioButton;
    rbnRed: TRadioButton;
    rbnGreen: TRadioButton;
    rbnBlue: TRadioButton;
    sbxHist: TScrollBox;
    hist: THistogramBox;
    procedure AddCommonInfo();
    procedure AddToList(name, value: string);
    procedure AddToEXIF(name, value: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rbnAllClick(Sender: TObject);
    procedure shtHistShow(Sender: TObject);
  private
    proc: TImageEnProc;
  public
    gen_hyst: boolean;
  end;

var
  frmInfo: TfrmInfo;


implementation

uses w_main, f_tools;

{$R *.DFM}

procedure TfrmInfo.AddCommonInfo();
var
  date: TDateTime;
begin
  if (IsPresent() and not IsUnsaved()) then
    begin
    AddToList('Path', infImage.path);
    AddToList('File Size', Format('%f Kb', [(FileSize(infImage.path) / 1024)]));

    if FileAge(infImage.path, date) = true then
      AddToList('File Timestamp', DateTimeToStr(date));

    AddToList('', '');
    end;

  AddToList('Dimensions',
    Format('%s x %s', [IntToStr(frmMain.img.IEBitmap.Width), IntToStr(frmMain.img.IEBitmap.Height)]));
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

procedure TfrmInfo.btnCloseClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmInfo.FormCreate(Sender: TObject);
var
  tempd: double;
  temps: string;
  io: TImageEnIO;
begin
  gen_hyst := false;

  if IsThemed() then
    sbxHist.BorderStyle := bsNone;

  AddCommonInfo();

  // adding EXIF and IPTC information (if applicable)
  if (IsPresent() and not IsUnsaved() and (FileExists(infImage.path))) then
    begin
    io := TImageEnIO.Create(nil);
    io.ParamsFromFile(infImage.path);

    if not io.Aborting then
      begin
      if (io.Params.FileType = ioJPEG) then
        begin
        AddToList('', '');
        AddToList('JPEG compression', Format('%s%% (estimation)', [IntToStr(IECalcJpegFileQuality(infImage.path))]));
        end;

      if io.Params.EXIF_HasEXIFData then
        begin
        shtEXIFinfo.TabVisible := true;

        if (Trim(string(io.Params.EXIF_Make)) <> '') then
          AddToEXIF('Manufacturer', string(io.Params.EXIF_Make));
        if (Trim(string(io.Params.EXIF_Model)) <> '') then
          AddToEXIF('Model', string(io.Params.EXIF_Model));

        if ((Trim(string(io.Params.EXIF_Make)) <> '') or (Trim(string(io.Params.EXIF_Model))<>'')) then
          AddToEXIF('', '');

        AddToEXIF('Image Dimensions',
          Format('%d x %d Pixels', [io.Params.EXIF_ExifImageWidth, io.Params.EXIF_ExifImageHeight]));
        AddToEXIF('Resolution',
          Format('%.1f MP (estimate)', [(io.Params.EXIF_ExifImageWidth * io.Params.EXIF_ExifImageHeight) / (1000 * 1000)]));

        if Assigned(io.Params.EXIF_Bitmap) then
          begin
          AddToEXIF('Thumbnail', 'Available (see "EXIF Thumbnail" page)');
          imgThumb.IEBitmap.Assign(io.Params.EXIF_Bitmap);
          shtEXIF.TabVisible := true;
          end
        else
          AddToEXIF('Thumbnail', 'Not available');

        AddToEXIF('', '');

        if (Trim(string(io.Params.EXIF_DateTimeOriginal)) <> '') then
          AddToEXIF('Original Date', string(io.Params.EXIF_DateTimeOriginal));
        if (Trim(string(io.Params.EXIF_DateTimeDigitized)) <> '') then
          AddToEXIF('Digitized Date', string(io.Params.EXIF_DateTimeDigitized));

        if ((Trim(string(io.Params.EXIF_DateTimeOriginal)) <> '') or (Trim(string(io.Params.EXIF_DateTimeDigitized)) <> '')) then
          AddToEXIF('', '');

        AddToEXIF('X Resolution', Format('%-8.2f', [io.Params.EXIF_XResolution]));
        AddToEXIF('Y Resolution', Format('%-8.2f', [io.Params.EXIF_YResolution]));

        AddToEXIF('', '');

        if (Trim(string(io.Params.EXIF_Software)) <> '') then
          AddToEXIF('Software', string(io.Params.EXIF_Software));

        if (io.Params.EXIF_ISOSpeedRatings[0] <> 0) then
          AddToEXIF('ISO', IntToStr(io.Params.EXIF_ISOSpeedRatings[0]));

        if (io.Params.EXIF_FNumber > -1) then
          AddToEXIF('FNumber', 'F' + Format('%-4.1f', [io.Params.EXIF_FNumber]))
        else
          AddToEXIF('FNumber', 'Unknown');

        if (io.Params.EXIF_ExposureTime <> -1) then
          AddToEXIF('Exposure Time', Format('1/%d sec', [Round(1 / io.Params.EXIF_ExposureTime)]))
        else
          AddToEXIF('Exposure Time', 'Unknown');

        if (io.Params.EXIF_FocalLength <> -1) then
          AddToEXIF('Focal Length', Format('%-4.1f mm.', [io.Params.EXIF_FocalLength]));

        case io.Params.EXIF_ExposureProgram of
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
          25: temps := 'Onboard Flash fired';
          73: temps := 'Onboard Flash fired';
          89: temps := 'Onboard Flash fired';
          else
            temps := 'Unknown';
        end;
        AddToEXIF('Flash', temps);

        if (io.Params.EXIF_MaxApertureValue <> -1000) then
          begin
          if (io.Params.EXIF_MaxApertureValue > 0) then
            tempd := Ceil(2 * Log2(io.Params.EXIF_MaxApertureValue))
          else
            tempd := 0;

          AddToEXIF('Max Aperture Value', Format('F%-4.1f', [tempd]));
          end;

        case io.Params.EXIF_MeteringMode of
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

        if (io.Params.EXIF_ExposureBiasValue <> -1000) then
          AddToEXIF('Exposure Bias Value', Format('%-8.2f', [io.Params.EXIF_ExposureBiasValue]));
        if (io.Params.EXIF_BrightnessValue <> -1000) then
          AddToEXIF('Brightness Value', Format('%-8.2f', [io.Params.EXIF_BrightnessValue]));

        case io.Params.EXIF_SensingMethod of
          2: temps := '1 chip color area sensor';
          else
            temps := 'Unknown';
        end;
        AddToEXIF('Sensing Method', temps);

        if (io.Params.EXIF_WhitePoint[0] <> -1) then
          AddToEXIF('White Point', Format('%-8.2f', [io.Params.EXIF_WhitePoint[0]]));
        if (io.Params.EXIF_ReferenceBlackWhite[0] <> -1) then
          AddToEXIF('Reference Black White', Format('%-8.2f', [io.Params.EXIF_ReferenceBlackWhite[0]]));
        if (io.Params.EXIF_YCbCrCoefficients[0] <> -1) then
          AddToEXIF('YCbCr Coefficients', Format('%-8.2f', [io.Params.EXIF_YCbCrCoefficients[1]]));

        if (string(io.Params.EXIF_FlashPixVersion) <> '') then
          AddToEXIF('FlashPix Version', string(io.Params.EXIF_FlashPixVersion));

        case io.Params.EXIF_ColorSpace of
          1: temps := 'sRGB';
          65535: temps := 'Uncalibrated'
          else
            temps := 'Unknown';
        end;
        AddToEXIF('Color Space', temps);

        if (io.Params.EXIF_FocalPlaneXResolution <> -1) then
          AddToEXIF('Focal Plane X Resolution', Format('%-8.2f', [io.Params.EXIF_FocalPlaneXResolution]));
        if (io.Params.EXIF_FocalPlaneYResolution <> -1) then
          AddToEXIF('Focal Plane Y Resolution', Format('%-8.2f', [io.Params.EXIF_FocalPlaneYResolution]));

        case io.Params.EXIF_FocalPlaneResolutionUnit of
          1: temps := 'No unit';
          2: temps := 'Inches';
          3: temps := 'Centimeter';
          else
            temps := 'Unknown';
        end;
        AddToEXIF('Focal Plane Resolution Unit', temps);

        if (io.Params.EXIF_PrimaryChromaticities[0] <> -1) then
          AddToEXIF('Primary Chromaticities', Format('%-8.2f', [io.Params.EXIF_PrimaryChromaticities[0]]));
        if (string(io.Params.EXIF_ExifVersion) <> '') then
          AddToEXIF('EXIF Version', string(io.Params.EXIF_ExifVersion));
        if (io.Params.EXIF_CompressedBitsPerPixel <> 0) then
          AddToEXIF('Compressed BitsPerPixel', Format('%-8.1f', [io.Params.EXIF_CompressedBitsPerPixel]));

        case io.Params.EXIF_ResolutionUnit of
          1: temps := 'No unit';
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

        if (string(io.Params.EXIF_ImageDescription) <> '') then
          AddToEXIF('Image Description', string(io.Params.EXIF_ImageDescription));
        if (io.Params.EXIF_SceneType <> -1) then
          AddToEXIF('Scene Type', IntToStr(io.Params.EXIF_SceneType));
        if (io.Params.EXIF_SubjectDistance <> -1) then
          AddToEXIF('Subject Distance', Format('%-8.2f', [io.Params.EXIF_SubjectDistance]));
        if (string(io.Params.EXIF_SubsecTime) <> '') then
          AddToEXIF('Subsec Time', string(io.Params.EXIF_SubsecTime));
        if (string(io.Params.EXIF_SubsecTimeOriginal) <> '') then
          AddToEXIF('Subsec Time Original', string(io.Params.EXIF_SubsecTimeOriginal));
        if (string(io.Params.EXIF_RelatedSoundFile) <> '') then
          AddToEXIF('Related Sound File', string(io.Params.EXIF_RelatedSoundFile));
        if (io.Params.EXIF_ExposureIndex <> -1) then
          AddToEXIF('Exposure Index', Format('%-8.2f', [io.Params.EXIF_ExposureIndex]));

        if (io.Params.EXIF_FileSource = 3) then
          begin
          AddToEXIF('', '');
          AddToEXIF('File Source', 'Digital Still Camera');
          end;

        if ((Trim(string(io.Params.EXIF_Copyright)) <> '') or (Trim(io.Params.EXIF_UserComment) <> '')) then
          AddToEXIF('', '');

        if (Trim(string(io.Params.EXIF_Copyright)) <> '') then
          AddToEXIF('Copyright', string(io.Params.EXIF_Copyright));

        if (Trim(io.Params.EXIF_UserComment) <> '') then
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

procedure TfrmInfo.rbnAllClick(Sender: TObject);
begin
  if rbnAll.Checked then
    hist.HistogramKind := [hkRed, hkGreen, hkBlue, hkGray]
  else if rbnRed.Checked then
    hist.HistogramKind := [hkRed]
  else if rbnGreen.Checked then
    hist.HistogramKind := [hkGreen]
  else if rbnBlue.Checked then
    hist.HistogramKind := [hkBlue]
  else
    hist.HistogramKind := [hkGray];
end;

procedure TfrmInfo.shtHistShow(Sender: TObject);
begin
  // on demand generation
  if (gen_hyst = false) then
    begin
    gen_hyst := true;

    proc := TImageEnProc.Create(sbxHist);
    proc.AttachedIEBitmap.Assign(frmMain.img.IEBitmap);

    hist.AttachedImageEnProc := proc;
    hist.Update();
    end;
end;

end.
