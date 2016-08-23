!include "MUI.nsh"

Name "Futuris Imager"
OutFile "imager.exe"
CRCCheck on
SetCompressor lzma

BrandingText "Futuris Imager 4.7.1"

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
  StrCmp $INSTDIR $PROGRAMFILES doitnow check01
  
  check01:
  
  StrCmp $INSTDIR $WINDIR doitnow check02
  
  check02:
  
  StrCmp $INSTDIR $SYSDIR doitnow endcheck
  
  endcheck:
  
  RMDir /r "$INSTDIR"
  
  doitnow:
  
  SetOutPath "$INSTDIR"
  File /r "..\release\*.*"

  CreateShortCut "$SMPROGRAMS\Futuris Imager.lnk" "$INSTDIR\imager.exe"

  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "DisplayName" "Futuris Imager 4.7.1"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "DisplayIcon" "$INSTDIR\imager.exe"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "DisplayVersion" "4.7.1"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "HelpLink" "http://www.knives-out.org/"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "Publisher" "Alexander Tereshchenko"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "URLInfoAbout" "http://www.knives-out.org/"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "NoModify" 1
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "NoRepair" 1
    
  WriteUninstaller "uninstall.exe"
  
  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\Futuris Imager"
  
  ExecWait '"$INSTDIR\imager.exe" /reg' 
SectionEnd

Section Uninstall
  ExecWait '"$INSTDIR\imager.exe" /unreg'

  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\Futuris Imager"
  DeleteRegKey HKEY_CLASSES_ROOT "FuturisImager"  
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager"

  Delete "$SMPROGRAMS\Futuris Imager.lnk"
  
  RMDir /r "$INSTDIR\manual"
  RMDir /r "$INSTDIR\plugins"
  Delete "$INSTDIR\*.*"
  RMDir "$INSTDIR"
SectionEnd
