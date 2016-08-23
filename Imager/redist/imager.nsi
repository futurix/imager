!include "MUI.nsh"

Name "Futuris Imager"
OutFile "futuris_imager.exe"
CRCCheck on
SetCompressor lzma

BrandingText "Futuris Imager 5.01"

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
  
  Delete "$INSTDIR\*.dll"
  Delete "$INSTDIR\*.bpl"
  Delete "$INSTDIR\*.exe"
  Delete "$INSTDIR\*.txt"
  Delete "$INSTDIR\*.htm"
  Delete "$INSTDIR\*.html"
  Delete "$INSTDIR\*.chm"
  
  File "..\release\f_brightness.dll"
  File "..\release\f_capture.dll"
  File "..\release\f_color.dll"
  File "..\release\f_core.dll"
  File "..\release\f_crop.dll"
  File "..\release\f_cur.dll"
  File "..\release\f_effects.dll"
  File "..\release\f_graphicex.dll"
  File "..\release\f_resize.dll"
  File "..\release\f_rotate.dll"
  File "..\release\f_setwallpaper.dll"
  File "..\release\f_wbitmap.dll"
  File "..\release\helper.dll"
  File "..\release\imager.chm"
  File "..\release\imager.exe"
  File "..\release\imager.html"
  File "..\release\img_core.bpl"
  File "..\release\print.dll"

  CreateShortCut "$DESKTOP\Futuris Imager.lnk" "$INSTDIR\imager.exe"
  CreateShortCut "$SMPROGRAMS\Futuris Imager.lnk" "$INSTDIR\imager.exe"
  
  SetOutPath "$INSTDIR"
  
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "DisplayName" "Futuris Imager 5.01"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "DisplayIcon" "$INSTDIR\imager.exe"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "DisplayVersion" "5.01"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "HelpLink" "http://www.ukfog.com/"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "Publisher" "Alexander Tereshchenko"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "URLInfoAbout" "http://www.ukfog.com/"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "UninstallString" "$INSTDIR\uninstf.exe"
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "NoModify" 1
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "NoRepair" 1
    
  WriteUninstaller "uninstf.exe"
  
  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\Futuris Imager"
SectionEnd

Section Uninstall
  ExecWait '"$INSTDIR\imager.exe" /unreg'

  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\Futuris Imager"
  DeleteRegKey HKEY_CLASSES_ROOT "FuturisImager"  
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager"

  Delete "$DESKTOP\Futuris Imager.lnk"
  Delete "$SMPROGRAMS\Futuris Imager.lnk"
  
  RMDir /r "$INSTDIR"
SectionEnd
