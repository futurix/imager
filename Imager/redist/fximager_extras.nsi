!include "MUI.nsh"

!define FXVERSION 5.7.2

Name "FuturixImager Extras"
OutFile "futuriximager_extras.exe"
CRCCheck on
SetCompressor lzma

BrandingText "FuturixImager ${FXVERSION} Extras"

InstallDir "$PROGRAMFILES\FuturixImager"

!define MUI_WELCOMEPAGE_TITLE "FuturixImager ${FXVERSION} Extras"
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of FuturixImager Extras.\r\n\r\n$_CLICK"

!define MUI_COMPONENTSPAGE_NODESC
!define MUI_ABORTWARNING

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
  
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"


Function .onInit
   ReadRegStr $0 HKEY_CURRENT_USER "Software\alex_t\FuturixImager" "InstallationPath"
   
   StrCmp $0 "" Abort NoAbort
   
   Abort:
   
   MessageBox MB_OK|MB_ICONSTOP "Cannot find FuturixImager installation! Please install (or reinstall) latest version of FuturixImager."
   Abort
   
   NoAbort:
   StrCpy $INSTDIR $0  
FunctionEnd


Section "-Core"
  SectionIn RO
  
  # deleting old files
  Delete $INSTDIR\fxjbig.dll
  Delete $INSTDIR\fxhex.dll
  Delete $INSTDIR\fxgif.dll
  Delete $INSTDIR\fxmagick.dll
  Delete $INSTDIR\fxmng.dll
  Delete $INSTDIR\fxmnghandler.dll
  Delete $INSTDIR\fxplaygif.dll
  Delete $INSTDIR\fxmoreinfo.dll
  Delete $INSTDIR\fxgraphicex.dll
  Delete $INSTDIR\fxmail.dll
  Delete $INSTDIR\fxthemexp.dll
  Delete $INSTDIR\fxwireless.dll
  Delete $INSTDIR\uninstallx.exe
  
  # creating uninstaller
  SetOutPath "$INSTDIR"
  WriteUninstaller "uninstallx.exe"
  
  # plug-in system clean-up
  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\FuturixImager\Plug-ins"
SectionEnd

Section "Support for JBIG images"
  SetOutPath "$INSTDIR"
  File "..\bin\fxjbig.dll"
SectionEnd

Section "View as HEX plug-in"
  SetOutPath "$INSTDIR"
  File "..\bin\fxhex.dll"
SectionEnd

Section "Advanced GIF exporter"
  SetOutPath "$INSTDIR"
  File "..\bin\fxgif.dll"
SectionEnd

Section "Playback of animated GIFs"
  SetOutPath "$INSTDIR"
  File "..\bin\fxgdiplus.dll"
SectionEnd

Section "Support for SVG, TTF, DICOM, etc..."
  SetOutPath "$INSTDIR"
  File "..\bin\fxmagick.dll"
SectionEnd

Section "MNG/JNG support"
  SetOutPath "$INSTDIR"
  File "..\bin\fxmng.dll"
  File "..\bin\fxmnghandler.dll"
SectionEnd

Section "Additional information display for bitmaps"
  SetOutPath "$INSTDIR"
  File "..\bin\fxmoreinfo.dll"
SectionEnd

Section "Support for PhotoCD, Photoshop, EPS..."
  SetOutPath "$INSTDIR"
  File "..\bin\fxgraphicex.dll"
SectionEnd

Section "Support for e-mailing images"
  SetOutPath "$INSTDIR"
  File "..\bin\fxmail.dll"
SectionEnd

Section "Support for writing wireless bitmaps (WBMP)"
  SetOutPath "$INSTDIR"
  File "..\bin\fxwireless.dll"
SectionEnd

Section "XP-style toobar theme"
  SetOutPath "$INSTDIR"
  File "..\bin\fxthemexp.dll"
SectionEnd


Section Uninstall
  # deleting files
  Delete $INSTDIR\fxjbig.dll
  Delete $INSTDIR\fxhex.dll
  Delete $INSTDIR\fxgif.dll
  Delete $INSTDIR\fxmagick.dll
  Delete $INSTDIR\fxmng.dll
  Delete $INSTDIR\fxmnghandler.dll
  Delete $INSTDIR\fxplaygif.dll
  Delete $INSTDIR\fxmoreinfo.dll
  Delete $INSTDIR\fxgraphicex.dll
  Delete $INSTDIR\fxmail.dll
  Delete $INSTDIR\fxthemexp.dll
  Delete $INSTDIR\fxwireless.dll
  Delete $INSTDIR\uninstallx.exe
SectionEnd

