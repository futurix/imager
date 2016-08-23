!include "MUI.nsh"

Name "Futuris Imager Extras"
OutFile "imager_xtra.exe"
CRCCheck on
SetCompressor lzma

BrandingText " "

InstallDir "$PROGRAMFILES\Futuris Imager"

!define MUI_WELCOMEPAGE_TITLE "Futuris Imager 5.3 Extras"
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of Futuris Imager Extras.\r\n\r\n$_CLICK"

!define MUI_ABORTWARNING

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
  
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"


Function .onInit
   ReadRegStr $0 HKEY_CURRENT_USER "Software\alex_t\Futuris Imager" "InstallationPath"
   
   StrCmp $0 "" Abort NoAbort
   
   Abort:
   
   MessageBox MB_OK|MB_ICONSTOP "Cannot find Futuris Imager installation! Please install (or reinstall) latest version of Futuris Imager."
   Abort
   
   NoAbort:
   StrCpy $INSTDIR $0  
FunctionEnd


Section ""
  # deleting old extra plug-ins in the main folder
  Delete $INSTDIR\f_fimg.dll
  Delete $INSTDIR\f_fimglib.dll
  Delete $INSTDIR\f_gif.dll
  Delete $INSTDIR\f_hex.dll
  Delete $INSTDIR\f_infoplug.dll
  Delete $INSTDIR\f_mng.dll
  Delete $INSTDIR\f_mnglib.dll

  # deleting old uninstaller
  Delete $INSTDIR\uninstx.exe
  
  # installing main files
  SetOutPath "$INSTDIR"
  File "..\release\f_fimg.dll"
  File "..\release\f_fimglib.dll"
  File "..\release\f_gif.dll"
  File "..\release\f_hex.dll"
  File "..\release\f_infoplug.dll"
  File "..\release\f_mng.dll"
  File "..\release\f_mnglib.dll"
  
  # creating uninstaller
  WriteUninstaller "uninstx.exe"
  
  # plug-in system clean-up
  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\Futuris Imager\Plug-ins"
SectionEnd


Section Uninstall
  # deleting extra plug-ins in the main folder
  Delete $INSTDIR\f_fimg.dll
  Delete $INSTDIR\f_fimglib.dll
  Delete $INSTDIR\f_gif.dll
  Delete $INSTDIR\f_hex.dll
  Delete $INSTDIR\f_infoplug.dll
  Delete $INSTDIR\f_mng.dll
  Delete $INSTDIR\f_mnglib.dll

  # deleting old uninstallers
  Delete $INSTDIR\uninstx.exe
  
  # removing folder (only if it's already empty)
  RMDir $INSTDIR
SectionEnd
