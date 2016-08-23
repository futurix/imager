Name "Futuris Imager"
OutFile "output\imager.exe"
CRCCheck on

BrandingText "Futuris Imager 2.6"
Icon "imager.ico"
EnabledBitmap "check.bmp"
DisabledBitmap "nocheck.bmp"
WindowIcon off

LicenseText "To install Futuris Imager, you must accept following agreement:"
LicenseData "license.txt"

InstallDir "$PROGRAMFILES\Futuris Imager"
DirShow show
DirText "Where should Futuris Imager be installed?"

AutoCloseWindow true
ShowInstDetails hide

InstType "Typical"
InstType "Full"

ComponentText "Which components should be installed?"

Section "Futuris Imager (required)"
  ; copying general portion of required files
  SetOutPath "$INSTDIR"
  File "..\release\futuris.bpl"
  File "..\release\cleantmp.exe"
  File "..\release\imager.exe"
  File "..\release\plugscan.dll"
  File "..\release\plugscan.exe"
  SetOutPath "$INSTDIR\help"
  File "..\release\help\*.*"
  SetOutPath "$INSTDIR\plugins"
  File "..\release\plugins\f_gif.dll"
  File "..\release\plugins\f_infoplug.dll"
  File "..\release\plugins\f_jpeg.dll"
  File "..\release\plugins\f_mail.dll"
  File "..\release\plugins\f_resize.dll"
  File "..\release\plugins\f_rotate.dll"
  File "..\release\plugins\f_shtml.dll"
  File "..\release\plugins\f_stdwin.dll"
  File "..\release\plugins\f_windib.dll"
  ; adding more stuff
  CreateDirectory "$INSTDIR\temp"
  CreateShortCut "$SMPROGRAMS\Futuris Imager.lnk" "$INSTDIR\imager.exe"
SectionEnd

Section "support for WindowsXP themes"
  SectionIn 12
  SetOutPath "$INSTDIR"
  File "..\release\imager.exe.manifest"
  File "..\release\plugscan.exe.manifest"
  File "..\release\browser.exe.manifest"
SectionEnd

SectionDivider "features"

Section "Printing support"
  SectionIn 12
  SetOutPath "$INSTDIR"
  File "..\release\print.dll"
SectionEnd

Section "TWAIN scanning support"
  SectionIn 12
  ; registering to Still Image Service (Win2k, WinMe, WinXP)
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\StillImage\Registered Applications" "Futuris Imager" "$INSTDIR\imager.exe"
  ; working  
  SetOutPath "$INSTDIR\plugins"
  File "..\release\plugins\f_twain.dll"
SectionEnd

Section "File browser (with image preview)"
  SectionIn 12
  SetOutPath "$INSTDIR"
  File "..\release\browser.exe"
SectionEnd

Section "WebView (support for webcams)"
  SectionIn 12
  SetOutPath "$INSTDIR"
  File "..\release\webload.dll"
SectionEnd

SectionDivider "file formats"

Section "TIFF, Targa, PhotoCD, Photoshop"
  SectionIn 12
  SetOutPath "$INSTDIR\plugins"
  File "..\release\plugins\f_gex.dll"
SectionEnd

Section "PNG, MNG, JNG (recommended)"
  SectionIn 12
  SetOutPath "$INSTDIR"
  File "..\release\libmng.dll"
  SetOutPath "$INSTDIR\plugins"
  File "..\release\plugins\f_mng.dll"
  File "..\release\plugins\f_ngexport.dll"
SectionEnd

Section "Mavica 411"
  SectionIn 2
  SetOutPath "$INSTDIR\plugins"
  File "..\release\plugins\f_mavica.dll"
SectionEnd

Section "AutoCAD slides"
  SectionIn 2
  SetOutPath "$INSTDIR\plugins"
  File "..\release\plugins\f_slides.dll"
SectionEnd

Section "WAP bitmaps"
  SectionIn 2
  SetOutPath "$INSTDIR\plugins"
  File "..\release\plugins\f_wap.dll"
SectionEnd

SectionDivider "plug-ins"

Section "Filters (image transformations)"
  SectionIn 12
  SetOutPath "$INSTDIR\plugins"
  File "..\release\plugins\f_blur.dll"
  File "..\release\plugins\f_brightness.dll"
  File "..\release\plugins\f_color.dll"
  File "..\release\plugins\f_colorreplace.dll"
  File "..\release\plugins\f_crop.dll"
  File "..\release\plugins\f_greyscale.dll"
  File "..\release\plugins\f_invert.dll"
  File "..\release\plugins\f_mirror.dll"
SectionEnd

Section "HEX Viewer"
  SectionIn 2
  SetOutPath "$INSTDIR\plugins"
  File "..\release\plugins\f_hex.dll"
SectionEnd

Section "View-as-wallpaper tool"
  SectionIn 2
  SetOutPath "$INSTDIR\plugins"
  File "..\release\plugins\f_wallpaper.dll"
SectionEnd

SectionDivider "exporters"

Section "Export as Windows ICOn"
  SectionIn 2
  SetOutPath "$INSTDIR\plugins"
  File "..\release\plugins\f_iconexp.dll"
SectionEnd

Section "Export as TIFF"
  SectionIn 2
  SetOutPath "$INSTDIR\plugins"
  File "..\release\plugins\f_tiffsave.dll"
SectionEnd

Section "-post"
  ; writing uninstaller
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC" "DisplayName" "Futuris Imager 2.6"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC" "DisplayIcon" "$INSTDIR\imager.exe"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC" "DisplayVersion" "2.6"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC" "HelpLink" "http://alext.plastiqueweb.com/"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC" "Publisher" "Alexander Tereschenko"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC" "URLInfoAbout" "http://alext.plastiqueweb.com/"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC" "UninstallString" "$INSTDIR\uninst.exe"
  WriteUninstaller "$INSTDIR\uninst.exe"
  ; setting Registry
  DeleteRegKey HKEY_CURRENT_USER "Software\Futuris\FIPIS"
  WriteRegStr HKEY_CURRENT_USER "Software\Futuris\ImagerC\Web" "Ref" "http://alext.plastiqueweb.com/"
  WriteRegStr HKEY_CURRENT_USER "Software\Futuris\ImagerC\Web" "UA" "FuturisImager/2.6"
  ; initializing FIPIS
  ExecWait "$INSTDIR\plugscan.exe"
  ExecWait '"$INSTDIR\imager.exe" /regdock' 
  ; the end
  BringToFront
  HideWindow
  MessageBox MB_OK|MB_ICONINFORMATION 'Futuris Imager 2.6 successfully installed. You can launch it from "Start" menu.'
SectionEnd

UninstallText "This will uninstall Futuris Imager 2.6 from your system"
ShowUninstDetails hide

Section Uninstall
  SetAutoClose true
  ExecWait '"$INSTDIR\imager.exe" /unreg'
  DeleteRegKey HKEY_CURRENT_USER "Software\Futuris\ImagerC"
  DeleteRegKey HKEY_CURRENT_USER "Software\Futuris\FIPIS"
  DeleteRegKey /ifempty HKEY_CURRENT_USER "Software\Futuris"
  DeleteRegKey HKEY_CLASSES_ROOT "FuturisImager"  
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC"
  DeleteRegValue HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\StillImage\Registered Applications" "Futuris Imager"
  Delete "$SMPROGRAMS\Futuris Imager.lnk"
  ; deleting remaining files
  Delete "$INSTDIR\uninst.exe"
  RMDir /r "$INSTDIR"
SectionEnd
