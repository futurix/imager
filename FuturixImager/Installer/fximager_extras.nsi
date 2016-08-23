!include "MUI2.nsh"
!define FXVERSION "1.0"

Name "FuturixImager Extras"
OutFile "Output\futuriximager_extras.exe"
CRCCheck on
SetCompressor /SOLID lzma
RequestExecutionLevel admin
ShowInstDetails nevershow
ShowUninstDetails nevershow

BrandingText "FuturixImager Extras ${FXVERSION}"

InstallDir "$PROGRAMFILES\FuturixImager Extras"
InstallDirRegKey HKCU "SOFTWARE\Futurix\FuturixImagerExtras" "ExtrasPath"

!define MUI_WELCOMEPAGE_TITLE "FuturixImager Extras ${FXVERSION}"
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
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
  
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"


Section "-FuturixImagerExtras"
  SetDetailsPrint none
  
  # increase counter
  ReadRegDWORD $0 HKLM "SOFTWARE\Futurix\FuturixImager" "UpdateCounter"
  IntOp $0 $0 + 1
  WriteRegDWORD HKLM "SOFTWARE\Futurix\FuturixImager" "UpdateCounter" $0
  
  # register location
  WriteRegStr HKLM "SOFTWARE\Futurix\FuturixImager\PluginLocations" "$INSTDIR" "FuturixImager Extras ${FXVERSION}"
  
  # registry clean-up
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerExtras"

  # deleting old files
  Delete $INSTDIR\fx*.dll
  Delete $INSTDIR\uninstall.exe
  
  # installing main files
  SetOutPath "$INSTDIR"
  File "..\Bin\fxextraformats.dll"
  
  # writing unistaller registry key
  WriteRegStr   HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerExtras" "DisplayName" "FuturixImager Extras ${FXVERSION}"
  WriteRegStr   HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerExtras" "DisplayVersion" "${FXVERSION}"
  WriteRegStr   HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerExtras" "DisplayIcon" "$INSTDIR\uninstall.exe"
  WriteRegStr   HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerExtras" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr   HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerExtras" "URLUpdateInfo" "http://fximage.com/"
  WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerExtras" "NoModify" 1
  WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerExtras" "NoRepair" 1
  
  # creating uninstaller
  WriteUninstaller "uninstall.exe"
  
  # writing installtion location to the registry
  WriteRegStr HKCU "SOFTWARE\Futurix\FuturixImagerExtras" "ExtrasPath" $INSTDIR
SectionEnd


Section "Raw camera formats support"
  SetOutPath "$INSTDIR"
  File "..\Bin\fxraw.dll"
SectionEnd

Section "Additional toolbar themes and icon libraries"
  SetOutPath "$INSTDIR"
  File "..\Bin\fxiconwin7.dll"
  File "..\Bin\fxiconxp.dll"
  File "..\Bin\fxthemecrystal.dll"
SectionEnd

Section "Support for SVG, TTF, DICOM, etc..."
  SetOutPath "$INSTDIR"
  File "..\Bin\fxmagick.dll"
SectionEnd

Section "JBIG format support"
  SetOutPath "$INSTDIR"
  File "..\Bin\fxjbig.dll"
SectionEnd


Section Uninstall
  SetDetailsPrint none

  # increase counter
  ReadRegDWORD $0 HKLM "SOFTWARE\Futurix\FuturixImager" "UpdateCounter"
  IntOp $0 $0 + 1
  WriteRegDWORD HKLM "SOFTWARE\Futurix\FuturixImager" "UpdateCounter" $0
  
  # deleting files
  Delete $INSTDIR\fx*.dll
  Delete $INSTDIR\uninstall.exe

  # registry clean-up
  DeleteRegKey HKCU "SOFTWARE\Futurix\FuturixImagerExtras"
  DeleteRegKey /ifempty HKCU "SOFTWARE\Futurix"
  DeleteRegValue HKLM "SOFTWARE\Futurix\FuturixImager\PluginLocations" "$INSTDIR"
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerExtras"

  # removing folder (only if it's already empty)
  RMDir $INSTDIR
SectionEnd

