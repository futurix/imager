//---------------------------------------------------------------------------

#pragma hdrstop

#include <Classes.hpp>
#include <stdio.h>
#include <math.h>

#include "utils2.h"
#include "ieplugin.h"
//---------------------------------------------------------------------------
// we cannot include stdio.h in utils.cpp, then we need to create utils2.cpp

extern "C"
{

extern IEX_Info xhandle;

/*
P6rWWW HHHrMMMr
*/
void ConvertPPM2Image(char* ptr)
{
   int vmax;
   sscanf(ptr,"P6\n%d %d\n%d\n", &xhandle.imWidth, &xhandle.imHeight, &vmax);
   xhandle.imFormat=(vmax<256? IEX_24RGB:IEX_48RGB);
   // search for start of pixels
   int i=0;
   for(int c=0; i<100 && c<3; i++)
      if( ptr[i]=='\n' )
         c++;
   xhandle.imData=ptr+i;
   xhandle.imPalette=0;
}

// suppress math errors (like pow overflow)
int _matherr(struct _exception *a)
{
  a->retval = a->retval;
  return 1;
}

}

#pragma package(smart_init)
