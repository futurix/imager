!include "MUI2.nsh"
!define FXVERSION "6.0"

Name "FuturixImager Extras"
OutFile "Output\futuriximager_extras.exe"
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

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
  
!insertmacro MUI_LANGUAGE "English"


Section "-Core"
  SectionIn RO
  SetDetailsPrint none
  
  ReadRegDWORD $0 HKLM "Software\Futurix\FuturixImager" "UpdateCounter"
  IntOp $0 $0 + 1
  WriteRegDWORD HKLM "Software\Futurix\FuturixImager" "UpdateCounter" $0
SectionEnd
