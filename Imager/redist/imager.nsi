!include "MUI.nsh"

Name "Futuris Imager"
OutFile "imager.exe"
CRCCheck on
SetCompressor lzma

BrandingText "Futuris Imager 4.1"

InstallDir "$PROGRAMFILES\Futuris Imager"

!define MUI_ABORTWARNING

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
  
!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"


Section ""
  SetOutPath "$INSTDIR"
  File /r "..\release\*.*"

  CreateShortCut "$SMPROGRAMS\Futuris Imager.lnk" "$INSTDIR\imager.exe"
  CreateShortCut "$DESKTOP\Futuris Imager.lnk" "$INSTDIR\imager.exe"

  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\StillImage\Registered Applications" "Futuris Imager" "$INSTDIR\imager.exe"

  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "DisplayName" "Futuris Imager 4.1"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "DisplayIcon" "$INSTDIR\imager.exe"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "DisplayVersion" "4.1"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "HelpLink" "http://www.knives-out.org/"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "Publisher" "Alexander Tereshchenko"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "URLInfoAbout" "http://www.knives-out.org/"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "UninstallString" "$INSTDIR\uninst.exe"

  WriteUninstaller "uninst.exe"

  DeleteRegKey HKEY_CURRENT_USER "Software\Futuris\Imager"
  DeleteRegKey HKEY_CURRENT_USER "Software\Futuris\Modules"

  ExecWait "$INSTDIR\plugscan.exe"
  ExecWait '"$INSTDIR\imager.exe" /reg' 

SectionEnd

Section Uninstall
  ExecWait '"$INSTDIR\imager.exe" /unreg'

  DeleteRegKey HKEY_CURRENT_USER "Software\Futuris\Imager"
  DeleteRegKey HKEY_CURRENT_USER "Software\Futuris\Modules"
  DeleteRegKey /ifempty HKEY_CURRENT_USER "Software\Futuris"
  DeleteRegKey HKEY_CLASSES_ROOT "FuturisImager"  
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager"
  DeleteRegValue HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\StillImage\Registered Applications" "Futuris Imager"

  Delete "$SMPROGRAMS\Futuris Imager.lnk"
  Delete "$DESKTOP\Futuris Imager.lnk"
  Delete "$INSTDIR\uninst.exe"
  RMDir /r "$INSTDIR"
SectionEnd
