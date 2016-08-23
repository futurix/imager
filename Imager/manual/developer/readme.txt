
                              Futuris Imager SDK
                                 version 5.2

-------------------------------------------------------------------------------

Futuris Imager SDK contains sources of many plug-ins, that are included with
Futuris Imager.

All sources should compile in Delphi 7. 
C++ samples coming up soon.

-------------------------------------------------------------------------------

Folder structure of SDK:

\components\
 - Delphi VCL components that are used by provided plug-ins (you will need to
   install these components if you want to compile the plug-ins)
   WARNING: some of the components in this folder are custom modified and not
   the original versions from developers' websites

\plugins\
 - plug-in sources (binary version of these plug-ins are included with Futuris
   Imager 5.2) 

\shared\
 - several source files from Futuris Imager itself (these files contain useful
   functions and constants - you cannot compile provided plug-ins without them)

-------------------------------------------------------------------------------

Provided plug-in sources:

plg_capture
 - screen capture plug-in
 - shows how to implement import plug-in
 - to compile install provided Apprehend components

plg_cur
 - Windows cursors support plug-in
 - shows how to implement open plug-in

plg_fimg
 - FreeImage library plug-in
 - shows how to implement open and multipage open plug-ins
 - uses FreeImage header (modified version included in plug-ins folder)
 - compiled version will require renamed FreeImage DLL (take from
   Futuris Imager installation or rename the one from provided
   freeimage.zip into "f_fimglib.dll")
   
plg_gex
 - GraphicEx library plug-in
 - shows how to implement open plug-in
 - GraphicEx library located in plug-in folder, you don't need to install it
 
plg_gif
 - GIF exporter plug-in
 - shows how to implement saver and exporter plug-ins
 - uses custom version of TGifImage library (located in plug-in folder, do not
   install it into Delphi IDE)
   
plg_hex
 - HEX viewer plug-in
 - shows how to implement tool plug-in
 - uses TMPHexEditor (to compile install provided version)

plg_wallpaper
 - wallpaper tools plug-in
 - shows how to implement multiple plug-ins (tool plug-ins in this case) in one
   DLL
 - uses TTileImage (to compile install provided version)

plg_wap
 - WBMP support plug-in
 - shows how to implement open and save plug-ins

samples
 - empty sample plug-ins for all plug-in types, with some useful comments

-------------------------------------------------------------------------------

Useful source files:

 - c_const.pas
   header file for constants and function types used by Futuris Imager plug-ins
 
 - c_helper.pas
   header file for img_helper.dll - DLL that's included with Futuris Imager and
   provides some neat functions for plug-ins
   
   function FHelpPrint (of type TFHelpPrint - see c_const.pas) is also exported
   from img_helper.dll - you can use it to print images (I just don't link to
   it statically)
 
 - c_pos.pas
   functions to quickly save/restore window coordinates and/or position to
   registry
 
 - c_reg.pas
   extended (somewhat fail-safe) version of TRegistry
 
 - c_toolbar.pas
   ugly hack that allows to have BTNS_WHOLEDROPDOWN style in TToolBar (just
   include this file in uses list AFTER ComCtrls)
 
 - c_utils.pas
   some utility functions

-------------------------------------------------------------------------------

Futuris Imager plug-in types:

 > opener
 > saver
 - these are the main types of Imager plug-ins: straightforward open and save
   from/to files
 - GUI is forbidden for openers, only simple GUI permitted for savers (for more
   complex GUI make it an exporter)
 - available in "Open" / "Save" dialogs (openers also used by img_helper.dll
   and many others modules)
 - openers should export FQuery and FOpen functions
 - savers should export FQuery and FSave functions

 > opener for animated
 - animation plug-ins display some animation frame-by-frame (all control over
   the flow should be done by plug-in itself) 
 - available in "Open" dialog
 - openers for animated images should export FQuery, FAnimStart, FAnimRestart,
   FAnimGetFrame and FAnimStop functions
 - openers for animated images should also be simple openers (export FOpen
   function that will open first fram or whatever you like - this could be used
   as thumbnail in many places or as normal image in other situations)

 > opener for multi-page
 - almost the same as animation plug-ins, but in this case there is not timed
   delays (user changes the pages) and Imager should know total number of pages
 - available in "Open" dialog
 - openers for multi-page images should export FQuery, FMultiStart,
   FMultiGetPage and FMultiStop functions
 - openers for multi-page images should also be simple openers (export FOpen
   function that will open first page or whatever you like - this could be used
   as thumbnail in many places or as normal image in other situations)

 > importer
 - importers get some bitmap out of nowhere ;-) and return it to Imager
 - available in "File -> Import" menu
 - importers should export FQuery and FImport functions

 > exporter
 - exporters get current image from Imager, and can do anything with it
   (however if you just to save it into file, use "saver" plug-inw instead)
 - available in "File -> Export" menu
 - exporters should export FQuery and FExport functions

 > filter
 - filters transform current image anyhow, and return it back to Imager
 - available in "Filters" dialog
 - filters should export FQuery and FFilter functions

 > informer
 - informers reach some information (like bit depth and EXIF metadata) and
   pass it to Imager (information is just strings, nothing special)
 - available in "File Information" dialog
 - informers should export FQuery and FInfo functions 

 > tool
 - if your plug-in does not fit anywhere else - make it a tool
 - available in "Tools" menu
 - tools should export FQuery and FTool functions

-------------------------------------------------------------------------------

Notes:

1. Futuris Imager internally works only with 24-bit images, so all images that
   you pass to it (and get from it) should/will always be 24-bit!
2. All plug-ins should export FQuery function and pass required information
   to Imager there. DLLs without FQuery export are not considered plug-ins
   by Futuris Imager.
3. Plug-ins created with this version of SDK will work only with Futuris Imager
   5.2 and newer.
4. The third parameter of callback in FQuery takes string that will be
   remembered by Futuris Imager as a file format description for the extension
   that is passed in the second parameter (works only if PT_FOPEN,
   PT_FOPENMULTI, PT_FOPENANIM or PT_FSAVE passed in the first parameter).
   Do not pass several descriptions for the same extension - only the last
   will be saved.

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
