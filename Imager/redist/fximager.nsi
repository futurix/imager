!include "MUI2.nsh"

!define FXVERSION "5.9.4"

Name "FuturixImager"
OutFile "output\futuriximager.exe"
CRCCheck on
SetCompressor /SOLID lzma
RequestExecutionLevel highest
ShowInstDetails nevershow
ShowUninstDetails nevershow

BrandingText "FuturixImager ${FXVERSION}"

InstallDir "$PROGRAMFILES\FuturixImager"
InstallDirRegKey HKCU "Software\alex_t\FuturixImager" "InstallationPath"

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
!insertmacro MUI_PAGE_COMPONENTS
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
  
  # removing xtra plug-ins via uninstaller (if possible)
  ExecWait '"$INSTDIR\uninstallx.exe" /S'
  
  # registry clean-up
  DeleteRegKey HKEY_CLASSES_ROOT "FuturixImager"
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager"

  # deleting old files
  Delete $SMPROGRAMS\FuturixImager.lnk
  Delete $INSTDIR\fx*.chm
  Delete $INSTDIR\fx*.dll
  Delete $INSTDIR\fx*.exe
  Delete $INSTDIR\uninstallfx.exe
  Delete $INSTDIR\uninstallx.exe
  
  # installing main files
  SetOutPath "$INSTDIR"
  File "..\bin\fxcore.dll"
  File "..\bin\fxfimg.dll"
  File "..\bin\fxformats.exe"
  File "..\bin\fximager.exe"
  File "..\bin\fxmain.dll"
  
  # writing unistaller registry key
  WriteRegStr   HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "DisplayName" "FuturixImager ${FXVERSION}"
  WriteRegStr   HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "DisplayVersion" "${FXVERSION}"
  WriteRegStr   HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "DisplayIcon" "$INSTDIR\fximager.exe"
  WriteRegStr   HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "UninstallString" "$INSTDIR\uninstallfx.exe"
  WriteRegStr   HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "URLUpdateInfo" "http://fximage.com/"
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "NoModify" 1
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "NoRepair" 1
   
  # creating uninstaller
  WriteUninstaller "uninstallfx.exe"
  
  # plug-in system clean-up
  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\FuturixImager\Plug-ins"

  # creating shortcuts
  CreateShortCut "$SMPROGRAMS\FuturixImager.lnk" "$INSTDIR\fximager.exe"
  
  # writing installtion location to the registry
  WriteRegStr HKCU "Software\alex_t\FuturixImager" "InstallationPath" $INSTDIR
SectionEnd


Section "Raw camera formats support"
  SetOutPath "$INSTDIR"
  File "..\bin\fxraw.dll"
SectionEnd

Section "Lossless JPEG transformations"
  SetOutPath "$INSTDIR"
  File "..\bin\fxjpeglossless.dll"
SectionEnd

Section "Screen capture"
  SetOutPath "$INSTDIR"
  File "..\bin\fxcapture.dll"
SectionEnd

Section "Additional filters"
  SetOutPath "$INSTDIR"
  File "..\bin\fxeffects.dll"
SectionEnd

Section "Wallpaper tools"
  SetOutPath "$INSTDIR"
  File "..\bin\fxwallpaper.dll"
SectionEnd


Section Uninstall
  SetDetailsPrint none
  
  # registry clean-up
  ExecWait '"$INSTDIR\fxformats.exe" /uninstall'

  # removing extra plug-ins via uninstaller (if possible)
  ExecWait '"$INSTDIR\uninstallx.exe" /S'

  # deleting files
  Delete $SMPROGRAMS\FuturixImager.lnk
  Delete $INSTDIR\fx*.chm
  Delete $INSTDIR\fx*.dll
  Delete $INSTDIR\fx*.exe
  Delete $INSTDIR\uninstallfx.exe
  Delete $INSTDIR\uninstallx.exe

  # registry clean-up
  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\FuturixImager"
  DeleteRegKey /ifempty HKEY_CURRENT_USER "Software\alex_t"
  DeleteRegKey HKEY_CLASSES_ROOT "FuturixImager"  
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager"

  # removing folder (only if it's already empty)
  RMDir $INSTDIR
SectionEnd

