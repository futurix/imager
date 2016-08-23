!include "MUI.nsh"

Name "Futuris Imager"
OutFile "imager.exe"
CRCCheck on
SetCompressor lzma

BrandingText "Futuris Imager 2.6c"

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

  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC" "DisplayName" "Futuris Imager 2.6c"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC" "DisplayIcon" "$INSTDIR\imager.exe"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC" "DisplayVersion" "2.6c"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC" "HelpLink" "http://www.knives-out.org/"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC" "Publisher" "Alexander Tereshchenko"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC" "URLInfoAbout" "http://www.knives-out.org/"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC" "UninstallString" "$INSTDIR\uninst.exe"

  WriteUninstaller "uninst.exe"

  DeleteRegKey HKEY_CURRENT_USER "Software\Futuris\ImagerC"
  DeleteRegKey HKEY_CURRENT_USER "Software\Futuris\FIPIS"

  WriteRegStr HKEY_CURRENT_USER "Software\Futuris\ImagerC\Web" "Ref" "http://www.knives-out.org/"
  WriteRegStr HKEY_CURRENT_USER "Software\Futuris\ImagerC\Web" "UA" "FuturisImager/2.6c"

  ExecWait "$INSTDIR\plugscan.exe"
  ExecWait '"$INSTDIR\imager.exe" /regdock' 

SectionEnd

Section Uninstall
  ExecWait '"$INSTDIR\imager.exe" /unreg'

  DeleteRegKey HKEY_CURRENT_USER "Software\Futuris\ImagerC"
  DeleteRegKey HKEY_CURRENT_USER "Software\Futuris\FIPIS"
  DeleteRegKey /ifempty HKEY_CURRENT_USER "Software\Futuris"
  DeleteRegKey HKEY_CLASSES_ROOT "FuturisImager"  
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC"
  DeleteRegValue HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\StillImage\Registered Applications" "Futuris Imager"

  Delete "$SMPROGRAMS\Futuris Imager.lnk"
  Delete "$DESKTOP\Futuris Imager.lnk"
  Delete "$INSTDIR\uninst.exe"
  RMDir /r "$INSTDIR"
SectionEnd
