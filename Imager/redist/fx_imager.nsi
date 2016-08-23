!include "MUI.nsh"

Name "FuturixImager"
OutFile "futuriximager.exe"
CRCCheck on
SetCompressor lzma

BrandingText "FuturixImager"

InstallDir "$PROGRAMFILES\FuturixImager"

!define MUI_WELCOMEPAGE_TITLE "FuturixImager 5.5.1"
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of FuturixImager.\r\n\r\n$_CLICK"

!define MUI_ABORTWARNING

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
  
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"


Section ""
  # registry clean-up
  DeleteRegKey HKEY_CLASSES_ROOT "FuturixImager"
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager"

  # shortcuts clean-up
  Delete "$SMPROGRAMS\FuturixImager.lnk"
  Delete "$DESKTOP\FuturixImager.lnk"

  # deleting old files
  Delete $INSTDIR\fx_capture.dll
  Delete $INSTDIR\fx_corefunc.dll
  Delete $INSTDIR\fx_dcraw.dll
  Delete $INSTDIR\fx_effects.dll
  Delete $INSTDIR\fx_email.dll
  Delete $INSTDIR\fx_graphicex.dll
  Delete $INSTDIR\fx_imager.exe
  Delete $INSTDIR\fx_imgcore.dll
  Delete $INSTDIR\fx_imghelper.dll
  Delete $INSTDIR\fx_jpegllss.dll
  Delete $INSTDIR\fx_wallpaper.dll
  Delete $INSTDIR\fx_wbitmap.dll
  Delete $INSTDIR\uninstallfx.exe
  
  # installing main files
  SetOutPath "$INSTDIR"
  File "..\release\fx_capture.dll"
  File "..\release\fx_corefunc.dll"
  File "..\release\fx_dcraw.dll"
  File "..\release\fx_effects.dll"
  File "..\release\fx_email.dll"
  File "..\release\fx_graphicex.dll"
  File "..\release\fx_imager.exe"
  File "..\release\fx_imgcore.dll"
  File "..\release\fx_imghelper.dll"
  File "..\release\fx_jpegllss.dll"
  File "..\release\fx_wallpaper.dll"
  File "..\release\fx_wbitmap.dll"
  
  # writing unistaller registry key
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "DisplayName" "FuturixImager 5.5.1"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "DisplayIcon" "$INSTDIR\fx_imager.exe"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "UninstallString" "$INSTDIR\uninstallfx.exe"
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "NoModify" 1
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "NoRepair" 1
   
  # creating uninstaller
  WriteUninstaller "uninstallfx.exe"
  
  # plug-in system clean-up
  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\FuturixImager\Plug-ins"

  # creating shortcuts
  CreateShortCut "$SMPROGRAMS\FuturixImager.lnk" "$INSTDIR\fx_imager.exe"
  CreateShortCut "$DESKTOP\FuturixImager.lnk" "$INSTDIR\fx_imager.exe"
  
  # writing installtion location to the registry
  WriteRegStr HKEY_CURRENT_USER "Software\alex_t\FuturixImager" "InstallationPath" "$INSTDIR"
SectionEnd


Section Uninstall
  # registry clean-up
  ExecWait '"$INSTDIR\fx_imager.exe" /uninstall'

  # deleting old files
  Delete $INSTDIR\fx_capture.dll
  Delete $INSTDIR\fx_corefunc.dll
  Delete $INSTDIR\fx_dcraw.dll
  Delete $INSTDIR\fx_effects.dll
  Delete $INSTDIR\fx_email.dll
  Delete $INSTDIR\fx_graphicex.dll
  Delete $INSTDIR\fx_imager.exe
  Delete $INSTDIR\fx_imgcore.dll
  Delete $INSTDIR\fx_imghelper.dll
  Delete $INSTDIR\fx_jpegllss.dll
  Delete $INSTDIR\fx_wallpaper.dll
  Delete $INSTDIR\fx_wbitmap.dll
  Delete $INSTDIR\uninstallfx.exe

  # registry clean-up
  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\FuturixImager"
  DeleteRegKey /ifempty HKEY_CURRENT_USER "Software\alex_t"
  DeleteRegKey HKEY_CLASSES_ROOT "FuturixImager"  
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager"

  # shortcuts clean-up
  Delete "$SMPROGRAMS\FuturixImager.lnk"
  Delete "$DESKTOP\FuturixImager.lnk"
  
  # removing folder (only if it's already empty)
  RMDir $INSTDIR
SectionEnd
