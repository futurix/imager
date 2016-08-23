unit w_info;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, c_const, c_utils, ImageEnIO, histogrambox, ieview,
  imageenview, ExtCtrls, c_locales;

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
    btnHistogram: TButton;
    procedure AddCommonInfo();
    procedure AddToList(name, value: string);
    procedure AddToEXIF(name, value: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnHistogramClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Localize();
  end;

var
  frmInfo: TfrmInfo;

function Log2(X: Extended): Extended;
function Ceil(X: Extended): Integer;
function IsInformed(ext: string):boolean;
function GetInfo(name, value: PChar):BOOL; cdecl;


implementation

uses main, f_filectrl, f_tools, w_hist;

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
	reg.OpenKey(sModules + '\' + PS_FINFO, true);
    if reg.RStr(ext, '') <> '' then
  		Result := true
	else
  		Result := false;
	reg.CloseKey();
end;

procedure TfrmInfo.AddCommonInfo();
begin
    if ((infImage.image_type <> itUnsaved) and (infImage.image_type <> itNone)) then
    	begin
        AddToList(LoadLStr(1200), infImage.path);
        AddToList(LoadLStr(1201), Format(LoadLStr(1204), [(FileSize(infImage.path) / 1024)]));
        AddToList(LoadLStr(1205), DateTimeToStr(FileDateToDateTime(FileAge(infImage.path))));
        AddToList('', '');
        end;

    AddToList(LoadLStr(1206), Format(LoadLStr(1207), [IntToStr(frmMain.img.IEBitmap.VclBitmap.Width), IntToStr(frmMain.img.IEBitmap.VclBitmap.Height)]));
end;

function GetInfo(name, value: PChar):BOOL;
begin
    if Assigned(frmInfo) then
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

procedure TfrmInfo.btnCloseClick(Sender: TObject);
begin
	Close();
end;

procedure TfrmInfo.FormCreate(Sender: TObject);
var
	FxImgInfo: TFxImgInfo;
	lib: THandle;
    tempd: double;
    temps: string;
    io: TImageEnIO;
begin
    Localize();
    AddCommonInfo();

	if IsInformed(ExtractExt(infImage.path)) then
  		begin
  		reg.OpenKey(sModules + '\' + PS_FINFO, true);
  		lib := LoadLibrary(PChar(reg.RStr(ExtractExt(infImage.path), '')));
  		reg.CloseKey();

  		if (lib <> 0) then
    		begin
    		@FxImgInfo := GetProcAddress(lib, EX_INFO);

    		if (@FxImgInfo <> nil) then
      			FxImgInfo(PChar(infImage.path), PChar(ExtractExt(infImage.path)), GetInfo, Application.Handle, frmMain.Handle, FxImgGlobalCallback);

    		FreeLibrary(lib);
    		end;
  		end;

    // adding EXIF and IPTC information (if applicable)
    if ((infImage.image_type <> itUnsaved) and (infImage.image_type <> itNone) and (FileExists(infImage.path))) then
    	begin
        io := TImageEnIO.Create(nil);
        io.ParamsFromFile(infImage.path);

        if not io.Aborting then
			begin
            if (io.Params.FileType = ioJPEG) then
            	begin
                AddToList('', '');
                AddToList(LoadLStr(1220), Format(LoadLStr(1221), [IntToStr(IECalcJpegFileQuality(infImage.path))]));
                end;

            if io.Params.EXIF_HasEXIFData then
            	begin
                shtEXIFinfo.TabVisible := true;

                if (Trim(io.Params.EXIF_Make) <> '') then
               		AddToEXIF(LoadLStr(1222), io.Params.EXIF_Make);
                if (Trim(io.Params.EXIF_Model) <> '') then
                	AddToEXIF(LoadLStr(1223), io.Params.EXIF_Model);

                if ((Trim(io.Params.EXIF_Make) <> '') or (Trim(io.Params.EXIF_Model)<>'')) then
                	AddToEXIF('', '');

                AddToEXIF(LoadLStr(1224), Format(LoadLStr(1225), [io.Params.EXIF_ExifImageWidth, io.Params.EXIF_ExifImageHeight]));
                AddToEXIF(LoadLStr(1226), Format(LoadLStr(1227), [(io.Params.EXIF_ExifImageWidth * io.Params.EXIF_ExifImageHeight) / (1000 * 1000)]));
                if Assigned(io.Params.EXIF_Bitmap) then
                	begin
                    AddToEXIF(LoadLStr(1228), Format(LoadLStr(1229), [LoadLStr(753)]));
                    imgThumb.IEBitmap.Assign(io.Params.EXIF_Bitmap);
                    shtEXIF.TabVisible := true;
                    end
                else
                    AddToEXIF(LoadLStr(1228), LoadLStr(72));

                AddToEXIF('', '');
                if (Trim(io.Params.EXIF_DateTimeOriginal)<>'') then
                	AddToEXIF(LoadLStr(1230), io.Params.EXIF_DateTimeOriginal);
                if (Trim(io.Params.EXIF_DateTimeDigitized)<>'') then
                	AddToEXIF(LoadLStr(1231), io.Params.EXIF_DateTimeDigitized);

                if ((Trim(io.Params.EXIF_DateTimeOriginal)<>'') or (Trim(io.Params.EXIF_DateTimeDigitized)<>'')) then
                	AddToEXIF('', '');

                AddToEXIF(LoadLStr(1232), Format('%-8.2f', [io.Params.EXIF_XResolution]));
                AddToEXIF(LoadLStr(1233), Format('%-8.2f', [io.Params.EXIF_YResolution]));

                AddToEXIF('', '');
                if (Trim(io.Params.EXIF_Software)<>'') then
                	AddToEXIF(LoadLStr(1234), io.Params.EXIF_Software);
                AddToEXIF(LoadLStr(1235), IntToStr(io.Params.EXIF_ISOSpeedRatings[0]));
                AddToEXIF(LoadLStr(1236), 'F' + Format('%-4.1f', [io.Params.EXIF_FNumber]));

       			if (io.Params.EXIF_ExposureTime <> 0) then
        			AddToEXIF(LoadLStr(1237), Format(LoadLStr(1238), [Round(1 / io.Params.EXIF_ExposureTime)]))
      			else
        			AddToEXIF(LoadLStr(1237), LoadLStr(70));

                AddToEXIF(LoadLStr(1239), Format(LoadLStr(1240), [io.Params.EXIF_FocalLength]));

                case io.Params.EXIF_ExposureProgram of
                    0: temps := LoadLStr(70);
        			1: temps := LoadLStr(1242);
        			2: temps := LoadLStr(1243);
        			3: temps := LoadLStr(1244);
        			4: temps := LoadLStr(1245);
        			5: temps := LoadLStr(1246);
        			6: temps := LoadLStr(1247);
        			7: temps := LoadLStr(1248);
        			8: temps := LoadLStr(1249);
                    else
                    	temps := LoadLStr(70);
      			end;
                AddToEXIF(LoadLStr(1241), temps);

                case io.Params.EXIF_LightSource of
        			0: temps := LoadLStr(70);
        			1: temps := LoadLStr(1251);
        			2: temps := LoadLStr(1252);
        			3: temps := LoadLStr(1253);
        			10: temps := LoadLStr(1254);
        			17: temps := LoadLStr(1255);
        			18: temps := LoadLStr(1256);
        			19: temps := LoadLStr(1257);
        			20: temps := LoadLStr(1258);
        			21: temps := LoadLStr(1259);
        			22: temps := LoadLStr(1260);
                    255: temps := LoadLStr(71);
                    else
                    	temps := LoadLStr(70);
      			end;
                AddToEXIF(LoadLStr(1250), temps);

                case io.Params.EXIF_Flash of
                    0: temps := LoadLStr(1262);
        			1: temps := LoadLStr(1263);
        			5: temps := LoadLStr(1264);
        			7: temps := LoadLStr(1265);
        			9: temps := LoadLStr(1266);
        			25: temps := LoadLStr(1267);
        			73: temps := LoadLStr(1267);
        			89: temps := LoadLStr(1267);
                    else
                    	temps := LoadLStr(70);
      			end;
                AddToEXIF(LoadLStr(1261), temps);

                if (io.Params.EXIF_MaxApertureValue > 0) then
        			tempd := Ceil(2 * Log2(io.Params.EXIF_MaxApertureValue))
      			else
        			tempd := 0;

                AddToEXIF(LoadLStr(1268), Format('F%-4.1f', [tempd]));

                case io.Params.EXIF_MeteringMode of
        			0: temps := LoadLStr(70);
        			1: temps := LoadLStr(1270);
        			2: temps := LoadLStr(1271);
        			3: temps := LoadLStr(1272);
        			4: temps := LoadLStr(1273);
        			5: temps := LoadLStr(1274);
        			6: temps := LoadLStr(1275);
                    255: temps := LoadLStr(71);
        			else
                    	temps := LoadLStr(70);
      			end;
     			AddToEXIF(LoadLStr(1269), temps);

                AddToEXIF(LoadLStr(1276), Format('%-8.2f', [io.Params.EXIF_ExposureBiasValue]));
      			AddToEXIF(LoadLStr(1277), Format('%-8.2f', [io.Params.EXIF_BrightnessValue]));

      			case io.Params.EXIF_SensingMethod of
                    0: temps := LoadLStr(70);
        			2: temps := LoadLStr(1279);
                    else
                    	temps := LoadLStr(70);
      			end;
      			AddToEXIF(LoadLStr(1278), temps);

      			AddToEXIF(LoadLStr(1280), Format('%-8.2f', [io.Params.EXIF_WhitePoint[0]]));
      			AddToEXIF(LoadLStr(1281), Format('%-8.2f', [io.Params.EXIF_ReferenceBlackWhite[0]]));
      			AddToEXIF(LoadLStr(1282), Format('%-8.2f', [io.Params.EXIF_YCbCrCoefficients[1]]));
      			AddToEXIF(LoadLStr(1283), io.Params.EXIF_FlashPixVersion);

      			case io.Params.EXIF_ColorSpace of
        			1: temps := LoadLStr(1284);
        			65535: temps := LoadLStr(1285)
        			else
        				temps := LoadLStr(70);
      			end;
                AddToEXIF(LoadLStr(1286), temps);

      			AddToEXIF(LoadLStr(1287), Format('%-8.2f', [io.Params.EXIF_FocalPlaneXResolution]));
     			AddToEXIF(LoadLStr(1288), Format('%-8.2f', [io.Params.EXIF_FocalPlaneYResolution]));

                case io.Params.EXIF_FocalPlaneResolutionUnit of
                    1: temps := LoadLStr(1290);
        			2: temps := LoadLStr(1291);
        			3: temps := LoadLStr(1292);
                    else
                    	temps := LoadLStr(70);
      			end;
      			AddToEXIF(LoadLStr(1289), temps);

      			AddToEXIF(LoadLStr(1293), Format('%-8.2f', [io.Params.EXIF_PrimaryChromaticities[0]]));
      			AddToEXIF(LoadLStr(1294), io.Params.EXIF_ExifVersion);
      			AddToEXIF(LoadLStr(1295), Format('%-8.1f', [io.Params.EXIF_CompressedBitsPerPixel]));

      			case io.Params.EXIF_ResolutionUnit of
                    1: temps := LoadLStr(1290);
        			2: temps := LoadLStr(1291);
        			3: temps := LoadLStr(1292);
                    else
                    	temps := LoadLStr(70);
      			end;
      			AddToEXIF(LoadLStr(1296), temps);

      			case io.Params.EXIF_YCbCrPositioning of
                    1: temps := LoadLStr(1298);
        			2: temps := LoadLStr(1299);
                    else
                    	temps := LoadLStr(70);
     			end;
      			AddToEXIF(LoadLStr(1297), temps);

      			case io.Params.EXIF_Orientation of
        			1: temps := LoadLStr(1301);
        			2: temps := LoadLStr(1302);
        			3: temps := LoadLStr(1303);
        			4: temps := LoadLStr(1304);
        			5: temps := LoadLStr(1305);
        			6: temps := LoadLStr(1306);
        			7: temps := LoadLStr(1307);
        			8: temps := LoadLStr(1308);
                    else
                    	temps := LoadLStr(70);
      			end;
      			AddToEXIF(LoadLStr(1300), temps);

      			AddToEXIF(LoadLStr(1309), io.Params.EXIF_ImageDescription);
      			AddToEXIF(LoadLStr(1310), IntToStr(io.Params.EXIF_SceneType));
      			AddToEXIF(LoadLStr(1311), Format('%-8.2f', [io.Params.EXIF_SubjectDistance]));
      			AddToEXIF(LoadLStr(1312), io.Params.EXIF_SubsecTime);
      			AddToEXIF(LoadLStr(1313), io.Params.EXIF_SubsecTimeOriginal);
      			AddToEXIF(LoadLStr(1314), io.Params.EXIF_RelatedSoundFile);
      			AddToEXIF(LoadLStr(1315), Format('%-8.2f', [io.Params.EXIF_ExposureIndex]));

      			if io.Params.EXIF_FileSource = 3 then
                    begin
                    AddToEXIF('', '');
        			AddToEXIF(LoadLStr(1316), LoadLStr(1317));
                    end;

                if ((Trim(io.Params.EXIF_Copyright) <> '') or (Trim(io.Params.EXIF_UserCommentCode) <> '') or
                	(Trim(io.Params.EXIF_UserComment) <> '')) then
      				AddToEXIF('', '');

                if (Trim(io.Params.EXIF_Copyright) <> '') then
      				AddToEXIF(LoadLStr(1318), io.Params.EXIF_Copyright);

                if (Trim(io.Params.EXIF_UserCommentCode) <> '') then
      				AddToEXIF(LoadLStr(1319), io.Params.EXIF_UserCommentCode);

                if (Trim(io.Params.EXIF_UserComment) <> '') then
      				AddToEXIF(LoadLStr(1320), io.Params.EXIF_UserComment);
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

procedure TfrmInfo.btnHistogramClick(Sender: TObject);
begin
	if not Assigned(frmHist) then
  		begin
  		Application.CreateForm(TfrmHist, frmHist);
		frmHist.ShowModal();
  		end;
end;

procedure TfrmInfo.Localize();
begin
    Self.Caption					:= LoadLStr(750);
    shtGeneral.Caption				:= LoadLStr(751);
    shtEXIFinfo.Caption     		:= LoadLStr(752);
    shtEXIF.Caption					:= LoadLStr(753);
    btnClose.Caption				:= LoadLStr(54);
    btnHistogram.Caption			:= LoadLStr(754);
    lvwInfo.Columns[0].Caption		:= LoadLStr(755);
    lvwInfo.Columns[1].Caption		:= LoadLStr(756);
    lvwEXIF.Columns[0].Caption		:= lvwInfo.Columns[0].Caption;
    lvwEXIF.Columns[1].Caption		:= lvwInfo.Columns[1].Caption;
end;

end.
