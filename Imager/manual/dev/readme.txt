------------------------------------------------------------------

                            FDK 2.02
     aka Futuris Imager Plug-In System (FIPIS) Development Kit

------------------------------------------------------------------
Contents:
	\DOCS\    - folder with complete FIPIS specification
	            launch file index.html in your browser
	         
	\SAMPLES\ - folder with samples. Contains:
	            
	            \RESOURCE\ - folder with sample FIPIS
	                         resource (template ini files
	                         and resource script).
	                         You can compile sample.rc with
	                         resource compiler to get
	                         sample.res file to include in
	                         plug-in.
	                         (Borland users can run brcc32.exe,
	                         like that: "brcc32.exe sample.rc"
	                         and link resource with plug-in DLL
	                         using {$R SAMPLE.RES} compiler
	                         directive)
	                         
	                         NOTE: read sample.ini contents,
	                         this file is self-explaining
	                         
	            \DELPHI\  - blank project for Delphi (32-bit),
	            		with all functions definitions
	            		(compiles as DLL)
	            		      
	            		NOTE: remove all non-used
	            		functions

		    \MICROSOFT\	- filter plug-in template for
		    		  Microsoft Visual C++
	            		 
	            \SKIN\     - default Imager's skin.
	            		 
	            		 NOTE: not all buttons are used
	            		 currently, but will be used soon.

------------------------------------------------------------------

More samples will be available soon. Check Futuris site for
updates ( http://futuris.itsoft.ru/index.html ).

------------------------------------------------------------------