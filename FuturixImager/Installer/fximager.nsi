!include "MUI2.nsh"
!define FXVERSION "$\"S$\" Beta 4"

Name "FuturixImager"
OutFile "Output\futuriximager.exe"
CRCCheck on
SetCompressor /SOLID lzma
RequestExecutionLevel admin
ShowInstDetails nevershow
ShowUninstDetails nevershow

BrandingText "FuturixImager ${FXVERSION}"

InstallDir "$PROGRAMFILES\FuturixImager Beta"
InstallDirRegKey HKCU "Software\Futurix\FuturixImager" "InstallationPath"

!define MUI_WELCOMEPAGE_TITLE "FuturixImager ${FXVERSION}"
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of FuturixImager.$\r$\n$\r$\n$_CLICK"

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
#!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
  
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"


Section "FuturixImager"
  SectionIn RO
  SetDetailsPrint none
  
  # registry clean-up
  DeleteRegKey HKEY_CLASSES_ROOT "FuturixImager_6"
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager6"

  # deleting old files
  Delete $SMPROGRAMS\FuturixImager.lnk
  Delete $INSTDIR\fx*.chm
  Delete $INSTDIR\fx*.dll
  Delete $INSTDIR\fx*.exe
  Delete $INSTDIR\uninstallfx.exe
  
  # installing main files
  SetOutPath "$INSTDIR"
  File "..\Bin\fxextraformats.dll"
  File "..\Bin\fxfreg.exe"
  File "..\Bin\fximager.exe"
  File "..\Bin\fxjbig.dll"
  File "..\Bin\fxlegacy.dll"
  File "..\Bin\fxmagick.dll"
  File "..\Bin\fxraw.dll"
  
  # writing unistaller registry key
  WriteRegStr   HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager6" "DisplayName" "FuturixImager ${FXVERSION}"
  WriteRegStr   HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager6" "DisplayVersion" "${FXVERSION}"
  WriteRegStr   HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager6" "DisplayIcon" "$INSTDIR\fximager.exe"
  WriteRegStr   HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager6" "UninstallString" "$INSTDIR\uninstallfx.exe"
  WriteRegStr   HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager6" "URLUpdateInfo" "http://fximage.com/"
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager6" "NoModify" 1
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager6" "NoRepair" 1
   
  # creating uninstaller
  WriteUninstaller "uninstallfx.exe"
  
  # plug-in system setup
  DeleteRegKey HKEY_CURRENT_USER "Software\Futurix\FuturixImager\Cache"
  ExecWait '"$INSTDIR\fximager.exe" /scan'
  
  # registering with default programs
  ExecWait '"$INSTDIR\fxfreg.exe" /sync'
  
  # creating shortcuts
  CreateShortCut "$SMPROGRAMS\FuturixImager.lnk" "$INSTDIR\fximager.exe"
  
  # writing installtion location to the registry
  WriteRegStr HKCU "Software\Futurix\FuturixImager" "InstallationPath" $INSTDIR
SectionEnd


#Section "Raw camera formats support"
#  SetOutPath "$INSTDIR"
#  File "..\Bin\fxraw.dll"
#SectionEnd

#Section "Screen capture"
#  SetOutPath "$INSTDIR"
#  File "..\Bin\fxcapture.dll"
#SectionEnd

#Section "Additional filters"
#  SetOutPath "$INSTDIR"
#  File "..\Bin\fxeffects.dll"
#SectionEnd


Section Uninstall
  SetDetailsPrint none
  
  # registry clean-up
  ExecWait '"$INSTDIR\fxfreg.exe" /clean'
  ExecWait '"$INSTDIR\fximager.exe" /clean'

  # deleting files
  Delete $SMPROGRAMS\FuturixImager.lnk
  Delete $INSTDIR\fx*.chm
  Delete $INSTDIR\fx*.dll
  Delete $INSTDIR\fx*.exe
  Delete $INSTDIR\uninstallfx.exe

  # registry clean-up
  DeleteRegKey HKEY_CURRENT_USER "Software\Futurix\FuturixImager"
  DeleteRegKey /ifempty HKEY_CURRENT_USER "Software\Futurix"
  DeleteRegKey HKEY_CLASSES_ROOT "FuturixImager_6"  
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager6"

  # removing folder (only if it's already empty)
  RMDir $INSTDIR
SectionEnd

