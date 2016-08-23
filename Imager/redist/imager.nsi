!include "MUI.nsh"

Name "Futuris Imager"
OutFile "imager.exe"
CRCCheck on
SetCompressor lzma

BrandingText "Futuris Imager 5.1"

InstallDir "$PROGRAMFILES\Futuris Imager"

!define MUI_WELCOMEPAGE_TITLE "Welcome to the Futuris Imager 5.1 Setup Wizard"

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
  RMDir /r $INSTDIR
  
  SetOutPath "$INSTDIR\manual"
  File /r "..\release\manual\*.*"
  
  SetOutPath "$INSTDIR"
  File "..\release\f_capture.dll"
  File "..\release\f_core.dll"
  File "..\release\f_cur.dll"
  File "..\release\f_effects.dll"
  File "..\release\f_fimg.dll"
  File "..\release\f_graphicex.dll"
  File "..\release\f_wallpaper.dll"
  File "..\release\f_wbitmap.dll"
  File "..\release\freeimage.dll"
  File "..\release\imager.exe"
  File "..\release\img_core.dll"
  File "..\release\img_helper.dll"
  
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "DisplayName" "Futuris Imager 5.1"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "DisplayIcon" "$INSTDIR\imager.exe"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "DisplayVersion" "5.1"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "HelpLink" "http://www.ukfog.com/"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "Publisher" "Alexander Tereshchenko"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "URLInfoAbout" "http://www.ukfog.com/"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "UninstallString" "$INSTDIR\uninstf.exe"
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "NoModify" 1
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "NoRepair" 1
    
  WriteUninstaller "uninstf.exe"
  
  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\Futuris Imager\Plug-ins"

  CreateShortCut "$SMPROGRAMS\Futuris Imager.lnk" "$INSTDIR\imager.exe"
SectionEnd

Section Uninstall
  ExecWait '"$INSTDIR\imager.exe" /unreg'

  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\Futuris Imager"
  DeleteRegKey HKEY_CLASSES_ROOT "FuturisImager"  
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager"

  Delete "$SMPROGRAMS\Futuris Imager.lnk"
  
  RMDir /r /REBOOTOK $INSTDIR
SectionEnd
