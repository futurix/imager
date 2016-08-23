!include "MUI.nsh"

Name "Futuris Imager"
OutFile "imager.exe"
CRCCheck on
SetCompressor lzma

BrandingText " "

InstallDir "$PROGRAMFILES\Futuris Imager"

!define MUI_WELCOMEPAGE_TITLE "Futuris Imager 5.3"
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of Futuris Imager.\r\n\r\n$_CLICK"

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
  # removing xtra plug-in via uninstaller (if possible)
  ExecWait '"$INSTDIR\uninstx.exe" /S'
  
  # registry clean-up
  DeleteRegKey HKEY_CURRENT_USER "Software\Futuris"
  DeleteRegKey HKEY_CLASSES_ROOT "FuturisImager"  
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImagerC"
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager"
  DeleteRegValue HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\StillImage\Registered Applications" "Futuris Imager"

  # shortcuts clean-up
  Delete "$SMPROGRAMS\Futuris Imager.lnk"
  Delete "$DESKTOP\Futuris Imager.lnk"

  # deleting old files in the main folder
  Delete $INSTDIR\f_capture.dll
  Delete $INSTDIR\f_core.dll
  Delete $INSTDIR\f_cur.dll
  Delete $INSTDIR\f_effects.dll
  Delete $INSTDIR\f_graphicex.dll
  Delete $INSTDIR\f_wallpaper.dll
  Delete $INSTDIR\f_wbitmap.dll
  Delete $INSTDIR\imager.exe
  Delete $INSTDIR\img_browser.dll
  Delete $INSTDIR\img_core.dll
  Delete $INSTDIR\img_helper.dll

  # deleting old extra plug-ins in the main folder
  Delete $INSTDIR\f_fimg.dll
  Delete $INSTDIR\f_fimglib.dll
  Delete $INSTDIR\f_gif.dll
  Delete $INSTDIR\f_hex.dll
  Delete $INSTDIR\f_infoplug.dll
  Delete $INSTDIR\f_mng.dll
  Delete $INSTDIR\f_mnglib.dll

  # deleting old manual files
  Delete $INSTDIR\manual\author.html
  Delete $INSTDIR\manual\changes.html
  Delete $INSTDIR\manual\credits.html
  Delete $INSTDIR\manual\faq.html
  Delete $INSTDIR\manual\freeimage.txt
  Delete $INSTDIR\manual\index.html
  Delete $INSTDIR\manual\intro.html
  Delete $INSTDIR\manual\kb.html
  Delete $INSTDIR\manual\license.html
  Delete $INSTDIR\manual\new.html
  Delete $INSTDIR\manual\styles.css
  Delete $INSTDIR\manual\website.html
  Delete $INSTDIR\manual\welcome.html
  RMDir $INSTDIR\manual
  
  # deleting old files from previous versions in the main folder
  Delete $INSTDIR\browser.exe
  Delete $INSTDIR\browser.exe.manifest
  Delete $INSTDIR\cleantmp.exe
  Delete $INSTDIR\f_brightness.dll
  Delete $INSTDIR\f_color.dll
  Delete $INSTDIR\f_crop.dll
  Delete $INSTDIR\f_embed.dll
  Delete $INSTDIR\f_mapi.dll
  Delete $INSTDIR\f_resize.dll
  Delete $INSTDIR\f_rotate.dll
  Delete $INSTDIR\f_rtl.bpl
  Delete $INSTDIR\f_scan.dll
  Delete $INSTDIR\f_setwallpaper.dll
  Delete $INSTDIR\f_shtml.dll
  Delete $INSTDIR\f_utils.dll
  Delete $INSTDIR\freeimage.dll
  Delete $INSTDIR\freeimage.txt
  Delete $INSTDIR\futflash.exe
  Delete $INSTDIR\futuris.bpl
  Delete $INSTDIR\gdiplus.dll
  Delete $INSTDIR\helper.dll
  Delete $INSTDIR\imager.chm
  Delete $INSTDIR\imager.exe.manifest
  Delete $INSTDIR\imager.html
  Delete $INSTDIR\imager.ini
  Delete $INSTDIR\img_core.bpl
  Delete $INSTDIR\jasper.dll
  Delete $INSTDIR\libmng.dll
  Delete $INSTDIR\plugscan.dll
  Delete $INSTDIR\plugscan.exe
  Delete $INSTDIR\plugscan.exe.manifest
  Delete $INSTDIR\print.dll
  Delete $INSTDIR\webload.dll
  
  # deleting old help folder
  Delete $INSTDIR\help\a_credits.html
  Delete $INSTDIR\help\a_history.html
  Delete $INSTDIR\help\about.html
  Delete $INSTDIR\help\author.html
  Delete $INSTDIR\help\contact.html
  Delete $INSTDIR\help\feedback.html
  Delete $INSTDIR\help\g_about.html
  Delete $INSTDIR\help\g_license.html
  Delete $INSTDIR\help\g_new.html
  Delete $INSTDIR\help\home.html
  Delete $INSTDIR\help\index.html
  Delete $INSTDIR\help\license.html
  Delete $INSTDIR\help\new.html
  Delete $INSTDIR\help\r_plain.html
  Delete $INSTDIR\help\readme.html
  Delete $INSTDIR\help\releases.html
  Delete $INSTDIR\help\s_faq.html
  Delete $INSTDIR\help\styles.css
  Delete $INSTDIR\help\w_masks.html
  Delete $INSTDIR\help\w_shortcuts.html
  RMDir $INSTDIR\help
  
  # deleting old plugins folder
  Delete $INSTDIR\plugins\f_bitmaps.dll
  Delete $INSTDIR\plugins\f_blur.dll
  Delete $INSTDIR\plugins\f_brightness.dll
  Delete $INSTDIR\plugins\f_browser.dll
  Delete $INSTDIR\plugins\f_capture.dll
  Delete $INSTDIR\plugins\f_color.dll
  Delete $INSTDIR\plugins\f_colorreplace.dll
  Delete $INSTDIR\plugins\f_conv_256.dll
  Delete $INSTDIR\plugins\f_crop.dll
  Delete $INSTDIR\plugins\f_effects.dll
  Delete $INSTDIR\plugins\f_favorites.dll
  Delete $INSTDIR\plugins\f_fimg.dll
  Delete $INSTDIR\plugins\f_gdiplus.dll
  Delete $INSTDIR\plugins\f_gex.dll
  Delete $INSTDIR\plugins\f_gex_plain.dll
  Delete $INSTDIR\plugins\f_gif.dll
  Delete $INSTDIR\plugins\f_gif_disp.dll
  Delete $INSTDIR\plugins\f_graphicex.dll
  Delete $INSTDIR\plugins\f_grayscale.dll
  Delete $INSTDIR\plugins\f_greyscale.dll
  Delete $INSTDIR\plugins\f_hex.dll
  Delete $INSTDIR\plugins\f_iconlib.dll
  Delete $INSTDIR\plugins\f_iconexp.dll
  Delete $INSTDIR\plugins\f_infoplug.dll
  Delete $INSTDIR\plugins\f_invert.dll
  Delete $INSTDIR\plugins\f_jpeg.dll
  Delete $INSTDIR\plugins\f_jpeg2000.dll
  Delete $INSTDIR\plugins\f_mail.dll
  Delete $INSTDIR\plugins\f_mapi.dll
  Delete $INSTDIR\plugins\f_mavica.dll
  Delete $INSTDIR\plugins\f_mirror.dll
  Delete $INSTDIR\plugins\f_mng.dll
  Delete $INSTDIR\plugins\f_ngexport.dll
  Delete $INSTDIR\plugins\f_pcx.dll
  Delete $INSTDIR\plugins\f_png.dll
  Delete $INSTDIR\plugins\f_print.dll
  Delete $INSTDIR\plugins\f_resize.dll
  Delete $INSTDIR\plugins\f_rotate.dll
  Delete $INSTDIR\plugins\f_setwallpaper.dll
  Delete $INSTDIR\plugins\f_shtml.dll
  Delete $INSTDIR\plugins\f_slides.dll
  Delete $INSTDIR\plugins\f_stdwin.dll
  Delete $INSTDIR\plugins\f_targa.dll
  Delete $INSTDIR\plugins\f_text.dll
  Delete $INSTDIR\plugins\f_tiff.dll
  Delete $INSTDIR\plugins\f_tiffsave.dll
  Delete $INSTDIR\plugins\f_tifflib.dll
  Delete $INSTDIR\plugins\f_twain.dll
  Delete $INSTDIR\plugins\f_wallpaper.dll
  Delete $INSTDIR\plugins\f_wap.dll
  Delete $INSTDIR\plugins\f_wbitmap.dll
  Delete $INSTDIR\plugins\f_windib.dll
  Delete $INSTDIR\plugins\f_xng.dll
  RMDir $INSTDIR\plugins
  
  # deleting misc. old folders
  RMDir $INSTDIR\cache
  RMDir $INSTDIR\favorites
  RMDir $INSTDIR\setup
  RMDir $INSTDIR\temp
  RMDir $INSTDIR\toolbar

  # deleting old uninstallers
  Delete $INSTDIR\unins000.dat
  Delete $INSTDIR\unins000.exe
  Delete $INSTDIR\uninst.exe
  Delete $INSTDIR\uninstf.exe
  Delete $INSTDIR\uninstx.exe
  
  # installing manual
  SetOutPath "$INSTDIR\manual"
  File /r "..\release\manual\*.*"
  
  # installing main files
  SetOutPath "$INSTDIR"
  File "..\release\f_capture.dll"
  File "..\release\f_core.dll"
  File "..\release\f_cur.dll"
  File "..\release\f_effects.dll"
  File "..\release\f_graphicex.dll"
  File "..\release\f_wallpaper.dll"
  File "..\release\f_wbitmap.dll"
  File "..\release\imager.exe"
  File "..\release\img_core.dll"
  File "..\release\img_helper.dll"
  
  # writing unistaller registry key
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "DisplayName" "Futuris Imager 5.3"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "DisplayIcon" "$INSTDIR\imager.exe"
  WriteRegStr HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "UninstallString" "$INSTDIR\uninstf.exe"
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "NoModify" 1
  WriteRegDWORD HKEY_LOCAL_MACHINE "Software\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager" "NoRepair" 1
   
  # creating uninstaller
  WriteUninstaller "uninstf.exe"
  
  # plug-in system clean-up
  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\Futuris Imager\Plug-ins"

  # creating shortcuts
  CreateShortCut "$SMPROGRAMS\Futuris Imager.lnk" "$INSTDIR\imager.exe"
  CreateShortCut "$DESKTOP\Futuris Imager.lnk" "$INSTDIR\imager.exe"
  
  # writing installtion location to the registry
  WriteRegStr HKEY_CURRENT_USER "Software\alex_t\Futuris Imager" "InstallationPath" "$INSTDIR"
SectionEnd


Section Uninstall
  # registry clean-up
  ExecWait '"$INSTDIR\imager.exe" /uninstall'

  # removing xtra plug-in via uninstaller (if possible)
  ExecWait '"$INSTDIR\uninstx.exe" /S'

  # deleting files in the main folder
  Delete $INSTDIR\f_capture.dll
  Delete $INSTDIR\f_core.dll
  Delete $INSTDIR\f_cur.dll
  Delete $INSTDIR\f_effects.dll
  Delete $INSTDIR\f_graphicex.dll
  Delete $INSTDIR\f_wallpaper.dll
  Delete $INSTDIR\f_wbitmap.dll
  Delete $INSTDIR\imager.exe
  Delete $INSTDIR\img_browser.dll
  Delete $INSTDIR\img_core.dll
  Delete $INSTDIR\img_helper.dll

  # deleting known extra plug-ins in the main folder
  Delete $INSTDIR\f_fimg.dll
  Delete $INSTDIR\f_fimglib.dll
  Delete $INSTDIR\f_gif.dll
  Delete $INSTDIR\f_hex.dll
  Delete $INSTDIR\f_infoplug.dll
  Delete $INSTDIR\f_mng.dll
  Delete $INSTDIR\f_mnglib.dll

  # deleting manual files
  Delete $INSTDIR\manual\author.html
  Delete $INSTDIR\manual\changes.html
  Delete $INSTDIR\manual\credits.html
  Delete $INSTDIR\manual\freeimage.txt
  Delete $INSTDIR\manual\index.html
  Delete $INSTDIR\manual\intro.html
  Delete $INSTDIR\manual\kb.html
  Delete $INSTDIR\manual\license.html
  Delete $INSTDIR\manual\new.html
  Delete $INSTDIR\manual\website.html
  RMDir $INSTDIR\manual

  # deleting old uninstallers
  Delete $INSTDIR\uninstf.exe
  Delete $INSTDIR\uninstx.exe

  # registry clean-up
  DeleteRegKey HKEY_CURRENT_USER "Software\alex_t\Futuris Imager"
  DeleteRegKey /ifempty HKEY_CURRENT_USER "Software\alex_t"
  DeleteRegKey HKEY_CLASSES_ROOT "FuturisImager"  
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\FuturisImager"

  # shortcuts clean-up
  Delete "$SMPROGRAMS\Futuris Imager.lnk"
  Delete "$DESKTOP\Futuris Imager.lnk"
  
  # removing folder (only if it's already empty)
  RMDir $INSTDIR
SectionEnd
