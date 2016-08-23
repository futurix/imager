!include "MUI.nsh"

Name "Futuris Imager eXtras"
OutFile "futuris_imager_extras.exe"
CRCCheck on
SetCompressor lzma

BrandingText "eXtras for Futuris Imager 5.01"

InstallDir "$PROGRAMFILES\Futuris Imager"

!define MUI_ABORTWARNING

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
  
!insertmacro MUI_LANGUAGE "English"


Section ""
  SetOutPath "$INSTDIR"
  
  File "..\release\f_fimg.dll"
  File "..\release\f_gif.dll"
  File "..\release\f_hex.dll"
  File "..\release\f_infoplug.dll"
  File "..\release\f_mapi.dll"
  File "..\release\f_mng.dll"
  File "..\release\f_shtml.dll"
  File "..\release\f_wallpaper.dll"
  File "..\release\freeimage.dll"
  File "..\release\freeimage.txt"
  File "..\release\libmng.dll"

  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\Futuris Imager"
SectionEnd
