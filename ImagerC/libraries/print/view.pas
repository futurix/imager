unit view;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, ToolWin, Printers, Preview, ImgList, Registry, Menus;

type
  TfrmPrint = class(TForm)
    prwPrint: TPrintPreview;
    imlPrint: TImageList;
    tbrPrintMain: TToolBar;
    tbnPaper: TToolButton;
    Sep_1: TToolButton;
    tbnZoom: TToolButton;
    tbnDraw: TToolButton;
    Sep_2: TToolButton;
    tbnSettings: TToolButton;
    tbnPrint: TToolButton;
    Sep_3: TToolButton;
    tbnClose: TToolButton;
    tbnPosition: TToolButton;
    popPaper: TPopupMenu;
    popZoom: TPopupMenu;
    piZMFit: TMenuItem;
    piZMWidth: TMenuItem;
    piZMHeight: TMenuItem;
    N1: TMenuItem;
    piZM6: TMenuItem;
    piZM12: TMenuItem;
    piZM25: TMenuItem;
    piZM50: TMenuItem;
    piZM75: TMenuItem;
    piZM100: TMenuItem;
    piZM150: TMenuItem;
    piZM200: TMenuItem;
    piZM400: TMenuItem;
    piZM800: TMenuItem;
    piZM1600: TMenuItem;
    piPSLetter: TMenuItem;
    piPSSmallLetter: TMenuItem;
    piPSTabloid: TMenuItem;
    piPSLedger: TMenuItem;
    piPSLegal: TMenuItem;
    piPSStatement: TMenuItem;
    piPSExecutive: TMenuItem;
    piPSA3: TMenuItem;
    piPSA4: TMenuItem;
    piPSSmallA4: TMenuItem;
    piPSA5: TMenuItem;
    piPSB4: TMenuItem;
    piPSB5: TMenuItem;
    piPSFolio: TMenuItem;
    piPSQuatro: TMenuItem;
    piPS10x14: TMenuItem;
    piPS11x17: TMenuItem;
    piPSNote: TMenuItem;
    piPSEnv9: TMenuItem;
    piPSEnv10: TMenuItem;
    piPSEnv11: TMenuItem;
    piPSEnv12: TMenuItem;
    piPSEnv14: TMenuItem;
    piPSCSheet: TMenuItem;
    piPSDSheet: TMenuItem;
    piPSESheet: TMenuItem;
    piPSEnvDL: TMenuItem;
    piPSEnvC5: TMenuItem;
    piPSEnvC3: TMenuItem;
    piPSEnvC4: TMenuItem;
    piPSEnvC6: TMenuItem;
    piPSEnvC65: TMenuItem;
    piPSEnvB4: TMenuItem;
    piPSEnvB5: TMenuItem;
    piPSEnvB6: TMenuItem;
    piPSEnvItaly: TMenuItem;
    piPSEnvMonarch: TMenuItem;
    piPSEnvPersonal: TMenuItem;
    piPSFanfoldUSStd: TMenuItem;
    piPSFanfoldGermanStd: TMenuItem;
    piPSFanfoldGermanLegal: TMenuItem;
    piPSB4ISO: TMenuItem;
    piPSJapanesePostcard: TMenuItem;
    piPS9x11: TMenuItem;
    piPS10x11: TMenuItem;
    piPS15x11: TMenuItem;
    piPSEnvInvite: TMenuItem;
    piPSLetterExtra: TMenuItem;
    piPSLegalExtra: TMenuItem;
    piPSTabloidExtra: TMenuItem;
    piPSA4Extra: TMenuItem;
    piPSLetterTransverse: TMenuItem;
    piPSA4Transverse: TMenuItem;
    piPSLetterExtraTransverse: TMenuItem;
    piPSAPlus: TMenuItem;
    piPSBPlus: TMenuItem;
    piPSLetterPlus: TMenuItem;
    piPSA4Plus: TMenuItem;
    piPSA5Transverse: TMenuItem;
    piPSB5Transverse: TMenuItem;
    piPSA3Extra: TMenuItem;
    piPSA5Extra: TMenuItem;
    piPSB5Extra: TMenuItem;
    piPSA2: TMenuItem;
    piPSA3Transverse: TMenuItem;
    piPSA3ExtraTransverse: TMenuItem;
    pStandard: TMenuItem;
    pExtra: TMenuItem;
    pSmall: TMenuItem;
    N2: TMenuItem;
    pEnvelopes: TMenuItem;
    pSized: TMenuItem;
    pPlus: TMenuItem;
    pTransverse: TMenuItem;
    pMore: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    popSettings: TPopupMenu;
    piPortrait: TMenuItem;
    piLandscape: TMenuItem;
    procedure tbnCloseClick(Sender: TObject);
    procedure tbnPrintClick(Sender: TObject);
    procedure tbnPositionClick(Sender: TObject);
    procedure tbnDrawClick(Sender: TObject);
    procedure piZMFitClick(Sender: TObject);
    procedure piZMWidthClick(Sender: TObject);
    procedure piZMHeightClick(Sender: TObject);
    procedure piZM6Click(Sender: TObject);
    procedure piZM12Click(Sender: TObject);
    procedure piZM25Click(Sender: TObject);
    procedure piZM50Click(Sender: TObject);
    procedure piZM75Click(Sender: TObject);
    procedure piZM100Click(Sender: TObject);
    procedure piZM150Click(Sender: TObject);
    procedure piZM200Click(Sender: TObject);
    procedure piZM400Click(Sender: TObject);
    procedure piZM800Click(Sender: TObject);
    procedure piZM1600Click(Sender: TObject);
    procedure piPSLetterClick(Sender: TObject);
    procedure piPSSmallLetterClick(Sender: TObject);
    procedure piPSTabloidClick(Sender: TObject);
    procedure piPSLedgerClick(Sender: TObject);
    procedure piPSLegalClick(Sender: TObject);
    procedure piPSStatementClick(Sender: TObject);
    procedure piPSExecutiveClick(Sender: TObject);
    procedure piPSA3Click(Sender: TObject);
    procedure piPSA4Click(Sender: TObject);
    procedure piPSSmallA4Click(Sender: TObject);
    procedure piPSA5Click(Sender: TObject);
    procedure piPSB4Click(Sender: TObject);
    procedure piPSB5Click(Sender: TObject);
    procedure piPSFolioClick(Sender: TObject);
    procedure piPSQuatroClick(Sender: TObject);
    procedure piPS10x14Click(Sender: TObject);
    procedure piPS11x17Click(Sender: TObject);
    procedure piPSNoteClick(Sender: TObject);
    procedure piPSEnv9Click(Sender: TObject);
    procedure piPSEnv10Click(Sender: TObject);
    procedure piPSEnv11Click(Sender: TObject);
    procedure piPSEnv12Click(Sender: TObject);
    procedure piPSEnv14Click(Sender: TObject);
    procedure piPSCSheetClick(Sender: TObject);
    procedure piPSDSheetClick(Sender: TObject);
    procedure piPSESheetClick(Sender: TObject);
    procedure piPSEnvDLClick(Sender: TObject);
    procedure piPSEnvC5Click(Sender: TObject);
    procedure piPSEnvC3Click(Sender: TObject);
    procedure piPSEnvC4Click(Sender: TObject);
    procedure piPSEnvC6Click(Sender: TObject);
    procedure piPSEnvC65Click(Sender: TObject);
    procedure piPSEnvB4Click(Sender: TObject);
    procedure piPSEnvB5Click(Sender: TObject);
    procedure piPSEnvB6Click(Sender: TObject);
    procedure piPSEnvItalyClick(Sender: TObject);
    procedure piPSEnvMonarchClick(Sender: TObject);
    procedure piPSEnvPersonalClick(Sender: TObject);
    procedure piPSFanfoldUSStdClick(Sender: TObject);
    procedure piPSFanfoldGermanStdClick(Sender: TObject);
    procedure piPSFanfoldGermanLegalClick(Sender: TObject);
    procedure piPSB4ISOClick(Sender: TObject);
    procedure piPSJapanesePostcardClick(Sender: TObject);
    procedure piPS9x11Click(Sender: TObject);
    procedure piPS10x11Click(Sender: TObject);
    procedure piPS15x11Click(Sender: TObject);
    procedure piPSEnvInviteClick(Sender: TObject);
    procedure piPSLetterExtraClick(Sender: TObject);
    procedure piPSLegalExtraClick(Sender: TObject);
    procedure piPSTabloidExtraClick(Sender: TObject);
    procedure piPSA4ExtraClick(Sender: TObject);
    procedure piPSLetterTransverseClick(Sender: TObject);
    procedure piPSA4TransverseClick(Sender: TObject);
    procedure piPSLetterExtraTransverseClick(Sender: TObject);
    procedure piPSAPlusClick(Sender: TObject);
    procedure piPSBPlusClick(Sender: TObject);
    procedure piPSLetterPlusClick(Sender: TObject);
    procedure piPSA4PlusClick(Sender: TObject);
    procedure piPSA5TransverseClick(Sender: TObject);
    procedure piPSB5TransverseClick(Sender: TObject);
    procedure piPSA3ExtraClick(Sender: TObject);
    procedure piPSA5ExtraClick(Sender: TObject);
    procedure piPSB5ExtraClick(Sender: TObject);
    procedure piPSA2Click(Sender: TObject);
    procedure piPSA3TransverseClick(Sender: TObject);
    procedure piPSA3ExtraTransverseClick(Sender: TObject);
    procedure piPortraitClick(Sender: TObject);
    procedure piLandscapeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function DoPrint(app: THandle; img: hBitmap; filename: PChar; fast: boolean):integer; stdcall;

var
  frmPrint: TfrmPrint;
  image: TBitmap;
  file_name: PChar;
  fast_print: boolean = false;
  p_top: integer = 0;
  p_left: integer = 0;
  reg: TRegistry;

implementation

uses pos;

{$R *.DFM}

function DoPrint(app: THandle; img: hBitmap; filename: PChar; fast: boolean):integer;
begin
Application.Handle:=app;
reg:=TRegistry.Create();
reg.RootKey:=HKEY_CURRENT_USER;
reg.OpenKey('\Software\Futuris\ImagerC\Print',true);
image:=TBitmap.Create();
image.Handle:=img;
image.PixelFormat:=pf24bit;
image.HandleType:=bmDIB;
file_name:=filename;
frmPrint:=TfrmPrint.Create(Application);
// reading settings
try
   case reg.ReadInteger('Orientation') of
                                       0: frmPrint.prwPrint.Orientation:=poPortrait;
                                       1: frmPrint.prwPrint.Orientation:=poLandscape;
                                       end;
   except frmPrint.prwPrint.Orientation:=poPortrait end;
try frmPrint.Width:=reg.ReadInteger('Width') except frmPrint.Width:=566 end;
try frmPrint.Height:=reg.ReadInteger('Height') except frmPrint.Height:=414 end;
try frmPrint.prwPrint.PaperWidth:=reg.ReadInteger('PaperWidth') except frmPrint.prwPrint.PaperWidth:=2100 end;
try frmPrint.prwPrint.PaperHeight:=reg.ReadInteger('PaperHeight') except frmPrint.prwPrint.PaperHeight:=2970 end;
try
   case reg.ReadInteger('ZoomState') of
                                     0: begin
                                        frmPrint.prwPrint.ZoomState:=zsZoomOther;
                                        frmPrint.prwPrint.Zoom:=50;
                                        end;
                                     1: frmPrint.prwPrint.ZoomState:=zsZoomToFit;
                                     2: frmPrint.prwPrint.ZoomState:=zsZoomToHeight;
                                     3: frmPrint.prwPrint.ZoomState:=zsZoomToWidth;
                                     end;
   except
    frmPrint.prwPrint.ZoomState:=zsZoomOther;
    frmPrint.prwPrint.Zoom:=50;
   end;
try
   frmPrint.Top:=reg.ReadInteger('Top');
   frmPrint.Left:=reg.ReadInteger('Left');
   except
         frmPrint.Position:=poScreenCenter;
   end;
// working
frmPrint.prwPrint.PrintJobTitle:=ExtractFileName(file_name);
frmPrint.tbnDrawClick(frmPrint);
if fast then frmPrint.prwPrint.Print()
else frmPrint.ShowModal();
Result:=1;
// saving settings
case frmPrint.prwPrint.ZoomState of
                                 zsZoomOther: begin
                                              reg.WriteInteger('ZoomState',0);
                                              reg.WriteInteger('Zoom',frmPrint.prwPrint.Zoom);
                                              end;
                                 zsZoomToFit: reg.WriteInteger('ZoomState',1);
                                 zsZoomToHeight: reg.WriteInteger('ZoomState',2);
                                 zsZoomToWidth: reg.WriteInteger('ZoomState',3);
                                 end;
case frmPrint.prwPrint.Orientation of
                                   poPortrait: reg.WriteInteger('Orientation',0);
                                   poLandscape: reg.WriteInteger('Orientation',1);
                                   end;
reg.WriteInteger('Width',frmPrint.Width);
reg.WriteInteger('Height',frmPrint.Height);
reg.WriteInteger('PaperWidth',frmPrint.prwPrint.PaperWidth);
reg.WriteInteger('PaperHeight',frmPrint.prwPrint.PaperHeight);
reg.WriteInteger('Top',frmPrint.Top);
reg.WriteInteger('Left',frmPrint.Left);
// freeing
frmPrint.Free();
reg.CloseKey();
reg.Free();
end;

procedure TfrmPrint.tbnCloseClick(Sender: TObject);
begin
Close();
end;

procedure TfrmPrint.tbnPrintClick(Sender: TObject);
begin
prwPrint.Print();
end;

procedure TfrmPrint.tbnPositionClick(Sender: TObject);
begin
frmSetPos:=TfrmSetPos.Create(Application);
frmSetPos.ShowModal();
frmSetPos.Free();
end;

procedure TfrmPrint.tbnDrawClick(Sender: TObject);
begin
prwPrint.BeginDoc();
prwPrint.PaintGraphic(p_left,p_top,image);
prwPrint.EndDoc();
end;

procedure TfrmPrint.piZMFitClick(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomToFit;
end;

procedure TfrmPrint.piZMWidthClick(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomToWidth;
end;

procedure TfrmPrint.piZMHeightClick(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomToHeight;
end;

procedure TfrmPrint.piZM6Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=6;
end;

procedure TfrmPrint.piZM12Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=12;
end;

procedure TfrmPrint.piZM25Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=25;
end;

procedure TfrmPrint.piZM50Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=50;
end;

procedure TfrmPrint.piZM75Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=75;
end;

procedure TfrmPrint.piZM100Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=100;
end;

procedure TfrmPrint.piZM150Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=150;
end;

procedure TfrmPrint.piZM200Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=200;
end;

procedure TfrmPrint.piZM400Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=400;
end;

procedure TfrmPrint.piZM800Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=800;
end;

procedure TfrmPrint.piZM1600Click(Sender: TObject);
begin
prwPrint.ZoomState:=zsZoomOther;
prwPrint.Zoom:=1600;
end;

procedure TfrmPrint.piPSLetterClick(Sender: TObject);
begin
prwPrint.PaperType:=pLetter;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSSmallLetterClick(Sender: TObject);
begin
prwPrint.PaperType:=pLetterSmall;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSTabloidClick(Sender: TObject);
begin
prwPrint.PaperType:=pTabloid;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSLedgerClick(Sender: TObject);
begin
prwPrint.PaperType:=pLedger;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSLegalClick(Sender: TObject);
begin
prwPrint.PaperType:=pLegal;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSStatementClick(Sender: TObject);
begin
prwPrint.PaperType:=pStatement;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSExecutiveClick(Sender: TObject);
begin
prwPrint.PaperType:=pExecutive;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSA3Click(Sender: TObject);
begin
prwPrint.PaperType:=pA3;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSA4Click(Sender: TObject);
begin
prwPrint.PaperType:=pA4;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSSmallA4Click(Sender: TObject);
begin
prwPrint.PaperType:=pA4Small;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSA5Click(Sender: TObject);
begin
prwPrint.PaperType:=pA5;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSB4Click(Sender: TObject);
begin
prwPrint.PaperType:=pB4;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSB5Click(Sender: TObject);
begin
prwPrint.PaperType:=pB5;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSFolioClick(Sender: TObject);
begin
prwPrint.PaperType:=pFolio;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSQuatroClick(Sender: TObject);
begin
prwPrint.PaperType:=pQuatro;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPS10x14Click(Sender: TObject);
begin
prwPrint.PaperType:=p10x14;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPS11x17Click(Sender: TObject);
begin
prwPrint.PaperType:=p11x17;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSNoteClick(Sender: TObject);
begin
prwPrint.PaperType:=pNote;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnv9Click(Sender: TObject);
begin
prwPrint.PaperType:=pEnv9;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnv10Click(Sender: TObject);
begin
prwPrint.PaperType:=pEnv10;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnv11Click(Sender: TObject);
begin
prwPrint.PaperType:=pEnv11;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnv12Click(Sender: TObject);
begin
prwPrint.PaperType:=pEnv12;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnv14Click(Sender: TObject);
begin
prwPrint.PaperType:=pEnv14;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSCSheetClick(Sender: TObject);
begin
prwPrint.PaperType:=pCSheet;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSDSheetClick(Sender: TObject);
begin
prwPrint.PaperType:=pDSheet;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSESheetClick(Sender: TObject);
begin
prwPrint.PaperType:=pESheet;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnvDLClick(Sender: TObject);
begin
prwPrint.PaperType:=pEnvDL;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnvC5Click(Sender: TObject);
begin
prwPrint.PaperType:=pEnvC5;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnvC3Click(Sender: TObject);
begin
prwPrint.PaperType:=pEnvC3;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnvC4Click(Sender: TObject);
begin
prwPrint.PaperType:=pEnvC4;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnvC6Click(Sender: TObject);
begin
prwPrint.PaperType:=pEnvC6;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnvC65Click(Sender: TObject);
begin
prwPrint.PaperType:=pEnvC65;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnvB4Click(Sender: TObject);
begin
prwPrint.PaperType:=pEnvB4;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnvB5Click(Sender: TObject);
begin
prwPrint.PaperType:=pEnvB5;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnvB6Click(Sender: TObject);
begin
prwPrint.PaperType:=pEnvB6;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnvItalyClick(Sender: TObject);
begin
prwPrint.PaperType:=pEnvItaly;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnvMonarchClick(Sender: TObject);
begin
prwPrint.PaperType:=pEnvMonarch;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnvPersonalClick(Sender: TObject);
begin
prwPrint.PaperType:=pEnvPersonal;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSFanfoldUSStdClick(Sender: TObject);
begin
prwPrint.PaperType:=pFanfoldUSStd;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSFanfoldGermanStdClick(Sender: TObject);
begin
prwPrint.PaperType:=pFanfoldGermanStd;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSFanfoldGermanLegalClick(Sender: TObject);
begin
prwPrint.PaperType:=pFanfoldGermanLegal;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSB4ISOClick(Sender: TObject);
begin
prwPrint.PaperType:=pB4ISO;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSJapanesePostcardClick(Sender: TObject);
begin
prwPrint.PaperType:=pJapanesePostcard;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPS9x11Click(Sender: TObject);
begin
prwPrint.PaperType:=p9x11;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPS10x11Click(Sender: TObject);
begin
prwPrint.PaperType:=p10x11;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPS15x11Click(Sender: TObject);
begin
prwPrint.PaperType:=p15x11;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSEnvInviteClick(Sender: TObject);
begin
prwPrint.PaperType:=pEnvInvite;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSLetterExtraClick(Sender: TObject);
begin
prwPrint.PaperType:=pLetterExtra;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSLegalExtraClick(Sender: TObject);
begin
prwPrint.PaperType:=pLegalExtra;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSTabloidExtraClick(Sender: TObject);
begin
prwPrint.PaperType:=TabloidExtra;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSA4ExtraClick(Sender: TObject);
begin
prwPrint.PaperType:=pA4Extra;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSLetterTransverseClick(Sender: TObject);
begin
prwPrint.PaperType:=pLetterTransverse;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSA4TransverseClick(Sender: TObject);
begin
prwPrint.PaperType:=pA4Transverse;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSLetterExtraTransverseClick(Sender: TObject);
begin
prwPrint.PaperType:=pLetterExtraTransverse;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSAPlusClick(Sender: TObject);
begin
prwPrint.PaperType:=pAPlus;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSBPlusClick(Sender: TObject);
begin
prwPrint.PaperType:=pBPlus;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSLetterPlusClick(Sender: TObject);
begin
prwPrint.PaperType:=pLetterPlus;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSA4PlusClick(Sender: TObject);
begin
prwPrint.PaperType:=pA4Plus;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSA5TransverseClick(Sender: TObject);
begin
prwPrint.PaperType:=pA5Transverse;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSB5TransverseClick(Sender: TObject);
begin
prwPrint.PaperType:=pB5Transverse;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSA3ExtraClick(Sender: TObject);
begin
prwPrint.PaperType:=pA3Extra;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSA5ExtraClick(Sender: TObject);
begin
prwPrint.PaperType:=pA5Extra;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSB5ExtraClick(Sender: TObject);
begin
prwPrint.PaperType:=pB5Extra;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSA2Click(Sender: TObject);
begin
prwPrint.PaperType:=pA2;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSA3TransverseClick(Sender: TObject);
begin
prwPrint.PaperType:=pA3Transverse;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPSA3ExtraTransverseClick(Sender: TObject);
begin
prwPrint.PaperType:=pA3ExtraTransverse;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piPortraitClick(Sender: TObject);
begin
prwPrint.Orientation:=poPortrait;
tbnDrawClick(frmPrint);
end;

procedure TfrmPrint.piLandscapeClick(Sender: TObject);
begin
prwPrint.Orientation:=poLandscape;
tbnDrawClick(frmPrint);
end;

end.
