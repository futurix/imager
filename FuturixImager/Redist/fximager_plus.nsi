!include "MUI2.nsh"
!define FXVERSION "June 2011"

Name "FuturixImager Essentials"
OutFile "Output\futuriximager_plus.exe"
CRCCheck on
SetCompressor /SOLID lzma
RequestExecutionLevel admin
ShowInstDetails nevershow
ShowUninstDetails nevershow

BrandingText "FuturixImager Essentials - ${FXVERSION}"

InstallDir "$PROGRAMFILES\FuturixImager Essentials"
InstallDirRegKey HKCU "SOFTWARE\Futurix\FuturixImagerEssentials" "EssentialsPath"

!define MUI_WELCOMEPAGE_TITLE "FuturixImager Essentials$\r$\n${FXVERSION}"
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of FuturixImager Essentials.$\r$\n$\r$\n$_CLICK"

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


Section "-FuturixImagerEssentials"
  SetDetailsPrint none
  
  # increase counter
  ReadRegDWORD $0 HKLM "SOFTWARE\Futurix\FuturixImager" "UpdateCounter"
  IntOp $0 $0 + 1
  WriteRegDWORD HKLM "SOFTWARE\Futurix\FuturixImager" "UpdateCounter" $0
  
  # register location
  WriteRegStr HKLM "SOFTWARE\Futurix\FuturixImager\PluginLocations" "$INSTDIR" "FuturixImager Essentials - ${FXVERSION}"
  
  # registry clean-up
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerEssentials"

  # deleting old files
  Delete $INSTDIR\fx*.dll
  Delete $INSTDIR\uninstall.exe
  
  # writing unistaller registry key
  WriteRegStr   HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerEssentials" "DisplayName" "FuturixImager Essentials"
  WriteRegStr   HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerEssentials" "DisplayVersion" "${FXVERSION}"
  WriteRegStr   HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerEssentials" "DisplayIcon" "$INSTDIR\uninstall.exe"
  WriteRegStr   HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerEssentials" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr   HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerEssentials" "URLUpdateInfo" "http://dev.fxfp.com/"
  WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerEssentials" "NoModify" 1
  WriteRegDWORD HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerEssentials" "NoRepair" 1
  
  # creating uninstaller
  WriteUninstaller "uninstall.exe"
  
  # writing installtion location to the registry
  WriteRegStr HKCU "SOFTWARE\Futurix\FuturixImagerEssentials" "EssentialsPath" $INSTDIR
SectionEnd


Section "Screen capture"
  SetOutPath "$INSTDIR"
  File "..\Bin\fxcapture.dll"
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
  DeleteRegKey HKCU "SOFTWARE\Futurix\FuturixImagerEssentials"
  DeleteRegKey /ifempty HKCU "SOFTWARE\Futurix"
  DeleteRegValue HKLM "SOFTWARE\Futurix\FuturixImager\PluginLocations" "$INSTDIR"
  DeleteRegKey HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImagerEssentials"

  # removing folder (only if it's already empty)
  RMDir $INSTDIR
SectionEnd

