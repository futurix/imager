!include "MUI.nsh"

Name "FuturixImager"
OutFile "futuriximager.exe"
CRCCheck on
SetCompressor lzma

BrandingText "FuturixImager"

InstallDir "$PROGRAMFILES\FuturixImager"

!define MUI_WELCOMEPAGE_TITLE "FuturixImager 5.5.2"
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

  # deleting old files
  Delete $SMPROGRAMS\FuturixImager.lnk
  Delete $INSTDIR\fxcapture.dll
  Delete $INSTDIR\fxcore.dll
  Delete $INSTDIR\fxeffects.dll
  Delete $INSTDIR\fxgraphicex.dll
  Delete $INSTDIR\fximager.exe
  Delete $INSTDIR\fxjpeglossless.dll
  Delete $INSTDIR\fxmail.dll
  Delete $INSTDIR\fxmain.dll
  Delete $INSTDIR\fxraw.dll
  Delete $INSTDIR\fxwallpaper.dll
  Delete $INSTDIR\fxwireless.dll
  Delete $INSTDIR\uninstallfx.exe
  
  # deleting legacy files
  Delete $DESKTOP\FuturixImager.lnk
  Delete $INSTDIR\fx_advgif.dll
  Delete $INSTDIR\fx_capture.dll
  Delete $INSTDIR\fx_corefunc.dll
  Delete $INSTDIR\fx_dcraw.dll
  Delete $INSTDIR\fx_effects.dll
  Delete $INSTDIR\fx_email.dll
  Delete $INSTDIR\fx_freeimage.dll
  Delete $INSTDIR\fx_freeimage_adapter.dll
  Delete $INSTDIR\fx_graphicex.dll
  Delete $INSTDIR\fx_hex.dll
  Delete $INSTDIR\fx_imagemagick.dll
  Delete $INSTDIR\fx_imager.exe
  Delete $INSTDIR\fx_imgcore.dll
  Delete $INSTDIR\fx_imghelper.dll
  Delete $INSTDIR\fx_infoplug.dll
  Delete $INSTDIR\fx_jbig.dll
  Delete $INSTDIR\fx_jpegllss.dll
  Delete $INSTDIR\fx_lang_eng.dll
  Delete $INSTDIR\fx_lang_fin.dll
  Delete $INSTDIR\fx_lang_fra.dll
  Delete $INSTDIR\fx_lang_ger.dll
  Delete $INSTDIR\fx_lang_jpn.dll
  Delete $INSTDIR\fx_lang_nla.dll
  Delete $INSTDIR\fx_lang_slo.dll
  Delete $INSTDIR\fx_lang_spa.dll
  Delete $INSTDIR\fx_mng.dll
  Delete $INSTDIR\fx_mng_adapter.dll
  Delete $INSTDIR\fx_wallpaper.dll
  Delete $INSTDIR\fx_wbitmap.dll
  
  # installing main files
  SetOutPath "$INSTDIR"
  File "..\bin\fxcapture.dll"
  File "..\bin\fxcore.dll"
  File "..\bin\fxeffects.dll"
  File "..\bin\fxgraphicex.dll"
  File "..\bin\fximager.exe"
  File "..\bin\fxjpeglossless.dll"
  File "..\bin\fxmail.dll"
  File "..\bin\fxmain.dll"
  File "..\bin\fxraw.dll"
  File "..\bin\fxwallpaper.dll"
  File "..\bin\fxwireless.dll"
  
  # writing unistaller registry key
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "DisplayName" "FuturixImager 5.5.2"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "DisplayIcon" "$INSTDIR\fximager.exe"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager" "UninstallString" "$INSTDIR\uninstallfx.exe"
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


Section Uninstall
  # registry clean-up
  ExecWait '"$INSTDIR\fximager.exe" /uninstall'

  # deleting old files
  Delete $INSTDIR\fxcapture.dll
  Delete $INSTDIR\fxcore.dll
  Delete $INSTDIR\fxeffects.dll
  Delete $INSTDIR\fxgraphicex.dll
  Delete $INSTDIR\fximager.exe
  Delete $INSTDIR\fxjpeglossless.dll
  Delete $INSTDIR\fxmail.dll
  Delete $INSTDIR\fxmain.dll
  Delete $INSTDIR\fxraw.dll
  Delete $INSTDIR\fxwallpaper.dll
  Delete $INSTDIR\fxwireless.dll
  Delete $INSTDIR\uninstallfx.exe

  # registry clean-up
  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\FuturixImager"
  DeleteRegKey /ifempty HKEY_CURRENT_USER "Software\alex_t"
  DeleteRegKey HKEY_CLASSES_ROOT "FuturixImager"  
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturixImager"

  # shortcuts clean-up
  Delete "$SMPROGRAMS\FuturixImager.lnk"
  
  # removing folder (only if it's already empty)
  RMDir $INSTDIR
SectionEnd
