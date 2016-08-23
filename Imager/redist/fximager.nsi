!include "MUI.nsh"

Name "FuturixImager"
OutFile "futuriximager.exe"
CRCCheck on
SetCompressor lzma

BrandingText "FuturixImager 5.6"

InstallDir "$PROGRAMFILES\FuturixImager"

!define MUI_WELCOMEPAGE_TITLE "FuturixImager 5.6"
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of FuturixImager.\r\n\r\n$_CLICK"

!define MUI_COMPONENTSPAGE_NODESC
!define MUI_ABORTWARNING

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

  # removing xtra plug-in via uninstaller (if possible)
  ExecWait '"$INSTDIR\uninstallx.exe" /S'
  
  # registry clean-up
  DeleteRegKey HKEY_CLASSES_ROOT "FuturixImager"
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager"

  # deleting old files
  Delete $SMPROGRAMS\FuturixImager.lnk
  Delete $INSTDIR\fx*.dll
  Delete $INSTDIR\fx*.exe
  Delete $INSTDIR\uninstallfx.exe
  Delete $INSTDIR\uninstallx.exe
  
  # installing main files
  SetOutPath "$INSTDIR"
  File "..\bin\fxcore.dll"
  File "..\bin\fximager.exe"
  File "..\bin\fxmain.dll"
  
  # writing unistaller registry key
  WriteRegStr   HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "DisplayName" "FuturixImager 5.6"
  WriteRegStr   HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "DisplayIcon" "$INSTDIR\fximager.exe"
  WriteRegStr   HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "UninstallString" "$INSTDIR\uninstallfx.exe"
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "NoModify" 1
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "NoRepair" 1
   
  # creating uninstaller
  WriteUninstaller "uninstallfx.exe"
  
  # plug-in system clean-up
  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\FuturixImager\Plug-ins"

  # creating shortcuts
  CreateShortCut "$SMPROGRAMS\FuturixImager.lnk" "$INSTDIR\fximager.exe"
  
  # writing installtion location to the registry
  WriteRegStr HKEY_CURRENT_USER "Software\alex_t\FuturixImager" "InstallationPath" "$INSTDIR"
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
  # registry clean-up
  ExecWait '"$INSTDIR\fximager.exe" /uninstall'

  # removing extra plug-ins via uninstaller (if possible)
  ExecWait '"$INSTDIR\uninstallx.exe" /S'

  # deleting old files
  Delete $SMPROGRAMS\FuturixImager.lnk
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

