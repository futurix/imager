
                         How to localize FuturixImager

-------------------------------------------------------------------------------

To translate FuturixImager, translate all strings in language_terms.rc

Tips:

1. Translate carefully - if you are not sure in some term or word, leave it
   untranslated or ask someone else.

2. Translate only you know both English and your target language very well -
   there is nothing more annoying then badly translated application.

3. Be very careful with .rc file - do not add any additional comments there!

4. If you need to insert quote into translated string - insert it as double
   quote ("") - samples:
   1101 		"Translated string with ""quotes"" inside"
   1102			"""Quotes"" inside string"

5. All strings should be enclosed in quotes - the following string is wrong!
   1101			"String

6. When updated version of language_terms.rc file is available, be sure to
   check all changes between strings using some diff tool - I often correct
   minor mistakes in strings.
   Great free diff tool can be found here:  http://winmerge.org/

7. When you have translated language_terms.rc file - send it to me by e-mail
   (to alex@fxfp.com address). Do not send me compiled DLL - I need .rc file!

8. And thank you for your contributions!

-------------------------------------------------------------------------------

If you want to test your translations you have two ways:

1. If you have Microsoft Visual C++ 2005 - just build following project:
   "current_translations\lang_test\Locale.sln"
   (replacing language_terms.rc file with your translated version).

2. Otherwise do following:
   - go to testkit folder
   - replace language_terms.rc with your translated version
   - run compile_res.bat (this will give you compiled language_terms.RES file)
   - run Resource Hacker (ResHacker.exe) from resource_hacker folder and do
     following in it:
        > open fx_lang_eng.dll from testkit folder in Resource Hacker
          ("File" -> "Open ...")
        > select "Action" -> "Update all Resources"
        > selection language_terms.RES file that you compiled before
        > now save fx_lang_eng.dll ("File" -> "Save")
   - copy resulting fx_lang_eng.dll to FuturixImager folder
   - in FuturixImager scan for new plug-ins
   - switch to your language and test it :-)

-------------------------------------------------------------------------------

Copyright © 2005 Alexander Tereshchenko
All rights reserved
