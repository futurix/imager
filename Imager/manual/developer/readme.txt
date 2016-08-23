
         FuturixImager SDK
         Version 5.5.1

-------------------------------------------------------------------------------

Contents:
  1. Sources of many FuturixImager plug-ins.
  2. Localizable strings for FuturixImager.
  3. Instructions.

All samples should compile in Delphi 7. Visual C++ samples coming up soon.

-------------------------------------------------------------------------------

Folder structure of SDK:

\components\
 - Delphi VCL components that are used by provided plug-ins (you will need to
   install these components if you want to compile some plug-ins)
   WARNING: some of the components in this folder are custom modified and not
   the original versions from developers' websites

\localization\
 - resource script with localizable strings for FuturixImager
 - instructions on translating FuturixImager
 - useful tools
 - sample localization DLL project for Visual C++ 2005

\plugins\
 - plug-in sources (binaries of these plug-ins are included with
   FuturixImager 5.5)

\shared\
 - several source files from FuturixImager itself (these files contain useful
   functions and constants - you cannot compile provided plug-ins without them)

-------------------------------------------------------------------------------

Provided plug-in sources:

plugin_capture
 - screen capture plug-in
 - shows how to implement FxImgImport plug-in
 - includes Apprehend components (no need to install them)

plugin_email
 - tool plug-in
 - shows how to implement FxImgTool plug-in
 - very simple

plugin_freeimage
 - FreeImage library plug-in
 - shows how to implement FxImgOpen and FxImgMulti plug-ins
 - uses FreeImage header (modified version included)
 - compiled version will require renamed FreeImage DLL (take from
   FuturixImager download page)

plugin_fx
 - filter plug-in
 - shows how to implement FxImgFilter plug-in
   
plugin_gex
 - GraphicEx library plug-in
 - shows how to implement FxImgOpen plug-in
 - modified GraphicEx library included
 
plugin_gif
 - GIF exporter plug-in
 - shows how to implement FxImgExport plug-in
 - uses custom version of TGifImage library (located in plug-in folder, do not
   install it into Delphi IDE!)
   
plugin_hex
 - HEX viewer plug-in
 - shows how to implement FxImgTool plug-in
 - uses TMPHexEditor (to compile install provided version)

plugin_wallpaper
 - wallpaper tools plug-in
 - shows how to implement multiple plug-ins (FxImgTool plug-ins in this case)
   in one DLL
 - uses TTileImage (to compile install provided version)

plugin_wap
 - WBMP support plug-in
 - shows how to implement FxImgOpen and FxImgSave plug-ins

-------------------------------------------------------------------------------

Useful source files:

 - c_const.pas
   header file for constants and function definitions used by FuturixImager
   plug-ins

 - c_locales.pas
   localization support functions
 
 - c_reg.pas
   extended version of TRegistry
 
 - c_toolbar.pas
   ugly hack that allows to have BTNS_WHOLEDROPDOWN style for TToolBar (just
   include this file in uses list AFTER ComCtrls)
 
 - c_utils.pas
   some utility functions

 - c_wndpos.pas
   functions to quickly save/restore window coordinates and/or position to
   registry

-------------------------------------------------------------------------------

FuturixImager plug-in types:

 > opener
 > saver
 - these are the main types of Imager plug-ins: straightforward open and save
   from/to files
 - GUI is forbidden for openers, only simple GUI permitted for savers (for more
   complex GUI make it an exporter)
 - available in "Open" / "Save" dialogs (openers also used by many others
   modules)
 - openers should export FxImgQuery and FxImgOpen functions
 - savers should export FxImgQuery and FxImgSave functions

 > opener for animation
 ! this plug-in type deprecated and will be removed in future versions
 - animation plug-ins display some animation frame-by-frame (all control over
   the flow should be done by plug-in itself) 
 - available in "Open" dialog
 - openers for animated images should export FxImgQuery, FxImgAnimStart,
   FxImgAnimRestart, FxImgAnimGetFrame and FxImgAnimStop functions
 - openers for animated images should also be simple openers (export FxImgOpen
   function that will open first frame or whatever you like - this could be
   used as thumbnail in many places or as normal image in special situations)

 > opener for multi-page images
 - almost the same as animation plug-ins, but in this case there are no timed
   delays (user changes the pages) and Imager should know total number of pages
 - available in "Open" dialog
 - openers for multi-page images should export FxImgQuery, FxImgMultiStart,
   FxImgMultiGetPage and FxImgMultiStop functions
 - openers for multi-page images should also be simple openers (export
   FxImgOpen function that will open first page or whatever you like - this
   could be used as thumbnail in many places or as normal image in special
   situations)

 > importer
 - importers get some bitmap out of nowhere ;-) and return it to Imager
 - available in "File -> Import" menu
 - importers should export FxImgQuery and FxImgImport functions

 > exporter
 - exporters get current image from Imager, and can do anything with it
   (however if you just want to save it into file, use "saver" plug-ins
   instead)
 - available in "File -> Export" menu
 - exporters should export FxImgQuery and FxImgExport functions

 > filter
 - filters transform current image anyhow, and return it back to Imager
 - available in "Filters" dialog
 - filters should export FxImgQuery and FxImgFilter functions
 - use preview_call callback for dynamic previews

 > informer
 - informers reach some information (like bit depth and EXIF metadata) and
   pass it to Imager (information is just strings, nothing special)
 - available in "File Information" dialog
 - informers should export FxImgQuery and FxImgInfo functions 

 > tool
 - if your plug-in does not fit anywhere else - make it a tool
 - available in "Tools" menu
 - tools should export FxImgQuery and FxImgTool functions

 > localization
 - resource-only DLLs with translated strings from FuturixImager (up-to-date
   English strings always located in fx_imager.exe) 

 > future types (planned for the next versions)
 - thumbnail extractors
 - new image templates
 - filters working with alpha channel
 - custom graphics for FuturixImager toolbar

-------------------------------------------------------------------------------

Notes:

1. FuturixImager internally works only with 24-bit images, so all images that
   you pass to it (and get from it) should/will always be 24-bit!
2. All plug-ins (except localizations) should export FxImgQuery function and
   pass required information to Imager there. DLLs without FxImgQuery export
   are not considered plug-ins by FuturixImager.
3. All exported FxImgQuery functions should include valid call with PT_FNAME to
   give plug-in name to host application. The plug-in name should be in
   English.
4. Plug-ins created with this version of SDK will work only with FuturixImager
   5.5 and newer.

-------------------------------------------------------------------------------

More information about used libraries:

 - Apprehend
   http://www.hicomponents.com/apprehend/news.htm
 
 - FreeImage
   http://freeimage.sourceforge.net/
 
 - GraphicEx
   http://www.soft-gems.net/
 
 - TGifImage
   http://finn.mobilixnet.dk/delphi/
 
 - TMPHexEditor
   http://www.mirkes.de/en/delphi/vcls/hexedit.php

-------------------------------------------------------------------------------

Copyright © 1999-2005 Alexander Tereshchenko
All rights reserved
