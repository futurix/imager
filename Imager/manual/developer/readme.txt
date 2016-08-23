
                              Futuris Imager SDK
                                 version 4.5a

-------------------------------------------------------------------------------

Current version of SDK contains only example plug-ins, written in Delphi
(should compile in Delphi 5/6/7). C++ samples coming up soon.

-------------------------------------------------------------------------------

animated.dpr
 - sample animation plug-in
 - animation plug-ins display some animation frame-by-frame (all control over
   the flow should be done by plug-in itself) 
 - available in "Open" dialog

c_const.pas
 - header file for constants used by Futuris Imager plug-ins
 - do NOT redistribute this file!

c_helper.pas
 - header file for helper.dll
 - do NOT redistribute this file!

export.dpr
 - sample exporter
 - exporters get current image from Imager, and can do anything with it
   (however if you just to save it into file, use "saver" plug-in instead)
 - available in "File -> Export" menu

filter.dpr
 - sample filter
 - filters transform current image somehow, and return it back to Imager
 - available in "Filters" dialog

futuris.dpk
 - Futuris Imager package
 - this is a custom version of VCL70.bpl, used by Futuris Imager and all
   plug-ins. You can compile and use it for your own Delphi plugins, but
   note - I do not quarantee that this package will remain binary compatible
   in the future (it can change to newer version of VCL, or I can add more
   units, etc)
 - when you'll compile this package, Delphi will ask you if you want to add
   rtp??.bpl and vcl??.bpl to the project - answer "No"!!!
 - do NOT redistribute this file!

import.dpr
 - sample importer
 - importers get some bitmap out of nowhere ;-) and return it to Imager
 - available in "File -> Import" menu

info.dpr
 - sample informer
 - informers reach some information (like bit depth and EXIF metadata) and
   pass it to Imager (information is just strings, nothing special)
 - available in "File Information" dialog

multipage.dpr
 - sample multi-page plug-in
 - almost the same as animation plug-ins, but in this case there is not timed
   delays (user changes the pages) and Imager should know total number of pages
 - available in "Open" dialog

opensave.dpr
 - sample opener and saver plug-ins
 - these are the main types of Imager plug-ins: straightforward open and save
   from/to files
 - GUI is forbidden for openers, only simple GUI permitted for savers (for more
   complex GUI make it an exporter)
 - available in "Open" / "Save" dialogs (openers also used by helper.dll and
   many others modules)

tool.dpr
 - sample tool plug-in
 - if your plug-in does not fit anywhere else - make it a tool
 - available in "Tools" menu

-------------------------------------------------------------------------------

Notes:

1. Futuris Imager internally works only with 24-bit image, so all images that
   you pass to it (and get from it) should always be 24-bit!
2. All plug-ins should export FIPISquery function and pass required information
   to Imager there. DLLs without FIPISquery export are not considered plug-ins
   by Futuris Imager.

-------------------------------------------------------------------------------

Copyright © 1999-2004 Alexander Tereshchenko
All rights reserved
