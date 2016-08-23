!include "MUI2.nsh"

!define FXVERSION "5.9"

Name "FuturixImager Extras"
OutFile "output\futuriximager_extras.exe"
CRCCheck on
SetCompressor /SOLID lzma
RequestExecutionLevel highest
ShowInstDetails nevershow
ShowUninstDetails nevershow

BrandingText "FuturixImager ${FXVERSION} Extras"

InstallDir "$PROGRAMFILES\FuturixImager"

!define MUI_WELCOMEPAGE_TITLE "FuturixImager ${FXVERSION} Extras"
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of FuturixImager Extras.$\r$\n$\r$\n$_CLICK"

!define MUI_COMPONENTSPAGE_NODESC
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\orange-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\orange-uninstall.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Header\orange-r.bmp"
!define MUI_HEADERIMAGE_UNBITMAP "${NSISDIR}\Contrib\Graphics\Header\orange-uninstall-r.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\orange.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\orange-uninstall.bmp"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
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
  SetDetailsPrint none
  
  # deleting legacy files
  Delete $INSTDIR\fxhex.dll
  Delete $INSTDIR\fxgif.dll
  Delete $INSTDIR\fxmail.dll
  Delete $INSTDIR\fxmng.dll
  Delete $INSTDIR\fxmnghandler.dll
  Delete $INSTDIR\fxmoreinfo.dll
  
  # deleting old files
  Delete $INSTDIR\fxjbig.dll
  Delete $INSTDIR\fxmagick.dll
  Delete $INSTDIR\fxplaygif.dll
  Delete $INSTDIR\fxgraphicex.dll
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

Section "Playback of animated GIFs"
  SetOutPath "$INSTDIR"
  File "..\bin\fxgdiplus.dll"
SectionEnd

Section "Support for SVG, TTF, DICOM, etc..."
  SetOutPath "$INSTDIR"
  File "..\bin\fxmagick.dll"
SectionEnd

Section "Support for PhotoCD, EPS thumbnails..."
  SetOutPath "$INSTDIR"
  File "..\bin\fxgraphicex.dll"
SectionEnd

Section "Support for writing wireless bitmaps (WBMP)"
  SetOutPath "$INSTDIR"
  File "..\bin\fxwireless.dll"
SectionEnd


Section Uninstall
  SetDetailsPrint none
  
  # deleting files
  Delete $INSTDIR\fxjbig.dll
  Delete $INSTDIR\fxmagick.dll
  Delete $INSTDIR\fxplaygif.dll
  Delete $INSTDIR\fxgraphicex.dll
  Delete $INSTDIR\fxwireless.dll
  Delete $INSTDIR\uninstallx.exe
SectionEnd

