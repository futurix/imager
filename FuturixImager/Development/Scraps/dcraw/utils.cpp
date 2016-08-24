//---------------------------------------------------------------------------

#pragma hdrstop

#include <Classes.hpp>
#include <mem.h>

extern "C"
{

#include "utils.h"
#include "utils2.h"
#include "ieplugin.h"

void xmain(int argc, char **argv);  // from dcraw.c
void ConvertPPM2Image(char* ptr);   // from utils2.cpp

// global variables
IEX_Info xhandle;
TMemoryStream* outStream;
FILE* stderr=0;
FILE* stdout=0;
char* xargv[20];
int xargc=1;
unsigned iewidth, ieheight;

int plugincapability=IEX_FILEREADER;
char* plugindescriptor="Camera RAW";
char* pluginextensions="CRW;CR2;DNG;NEF;RAW;RAF;X3F;ORF;SRF;MRW;DCR;BAY;PEF;TIFF;TIF;SR2;ARW";
bool autosearchexif=true;  // we want ImageEn to search EXIF info inside the file
int formatscount=1;

// globals from dcraw.c
extern char make[64], model[70], model2[64];

//---------------------------------------------------------------------------



__declspec(dllexport) void* WINAPI IEX_GetInfo(void* handle, int info)
{
  IEX_Info* ihandle = (IEX_Info*)handle;
  switch( info )
  {
    case IEX_IMAGEWIDTH:
      return &ihandle->imWidth;
    case IEX_IMAGEHEIGHT:
      return &ihandle->imHeight;
    case IEX_PIXELFORMAT:
      return &ihandle->imFormat;
    case IEX_FORMATDESCRIPTOR:
      return ihandle->imFormatDescriptor;
    case IEX_IMAGEDATA:
      return ihandle->imData;
    case IEX_IMAGEPALETTE:
      return ihandle->imPalette;

    case IEX_PLUGINCAPABILITY:
      return &plugincapability;
    case IEX_PLUGINDESCRIPTOR:
      return plugindescriptor;
    case IEX_FILEEXTENSIONS:
      return pluginextensions;
    case IEX_AUTOSEARCHEXIF:
      return &autosearchexif;
    case IEX_FORMATSCOUNT:
      return &formatscount;
  }
}

__declspec(dllexport) void WINAPI IEX_SetInfo(void* handle, int info, void* value)
{
  IEX_Info* ihandle = (IEX_Info*)handle;
  switch( info )
  {
    case IEX_IMAGEWIDTH:
      ihandle->imWidth = *(int*)value;
      break;
    case IEX_IMAGEHEIGHT:
      ihandle->imHeight = *(int*)value;
      break;
    case IEX_PIXELFORMAT:
      ihandle->imFormat = *(int*)value;
      break;
    case IEX_IMAGEDATA:
      ihandle->imData = value;
      break;
    case IEX_IMAGEPALETTE:
      ihandle->imPalette = value;
      break;
  }
}

__declspec(dllexport) void* WINAPI IEX_Initialize(int format)
{
  xargc=1;
  xhandle.IEX_Progress=0;
  xhandle.IEX_Read=0;
  xhandle.IEX_Write=0;
  xhandle.IEX_PositionSet=0;
  xhandle.IEX_PositionGet=0;
  xhandle.IEX_Length=0;
  xhandle.IEX_GetParameter=0;
  xhandle.IEX_SetParameter=0;
  xhandle.imWidth=0;
  xhandle.imHeight=0;
  xhandle.imFormat=IEX_INVALID;
  xhandle.imFormatDescriptor[0]=0;
  xhandle.imData=0;
  xhandle.imPalette=0;
  xhandle.userData=0;
  xhandle.plugInData=0;
  xhandle.plugInData1=0;
  xhandle.selectedFormat=format;
  return &xhandle;
}

__declspec(dllexport) void WINAPI IEX_SetCallBacks(void* handle, TIEX_Progress progressfun, TIEX_Read readfun, TIEX_Write writefun, TIEX_PositionSet posset, TIEX_PositionGet posget, TIEX_Length lenfun, TIEX_GetParameter getparam, TIEX_SetParameter setparam, void* userData )
{
  IEX_Info* ihandle = (IEX_Info*)handle;
  ihandle->userData=userData;
  ihandle->IEX_Progress=(TIEX_Progress)progressfun;
  ihandle->IEX_Read=(TIEX_Read)readfun;
  ihandle->IEX_Write=(TIEX_Write)writefun;
  ihandle->IEX_PositionSet=(TIEX_PositionSet)posset;
  ihandle->IEX_PositionGet=(TIEX_PositionGet)posget;
  ihandle->IEX_Length=(TIEX_Length)lenfun;
  ihandle->IEX_GetParameter=(TIEX_GetParameter)getparam;
  ihandle->IEX_SetParameter=(TIEX_SetParameter)setparam;
}

__declspec(dllexport) void WINAPI IEX_AddParameter(void* handle, char* param)
{
   xargv[xargc]=(char*)malloc(strlen(param)+1);
   strcpy(xargv[xargc],param);
   ++xargc;
}

__declspec(dllexport) void WINAPI IEX_Finalize(void* handle)
{
   for(int i=1;i<xargc;i++)
      free(xargv[i]);
   delete outStream;
}

__declspec(dllexport) void WINAPI IEX_ExecuteRead(void* handle, bool parametersOnly)
{
   char ss[1024];

   if(parametersOnly)
      IEX_AddParameter(handle,"-i");

   (*xhandle.IEX_GetParameter)("IsNativePixelFormat", ss, xhandle.userData);
   if( strcmp(ss,"1")==0 ) IEX_AddParameter(handle,"-4");

   (*xhandle.IEX_GetParameter)("RAW_HalfSize", ss, xhandle.userData);
   if( strcmp(ss,"1")==0 ) IEX_AddParameter(handle,"-h");

   (*xhandle.IEX_GetParameter)("RAW_QuickInterpolate", ss, xhandle.userData);
   if( strcmp(ss,"1")==0 ) {
        IEX_AddParameter(handle,"-q");
        IEX_AddParameter(handle,"0");
   }

   (*xhandle.IEX_GetParameter)("RAW_UseAutoWB", ss, xhandle.userData);
   if( strcmp(ss,"1")==0 ) IEX_AddParameter(handle,"-a");

   (*xhandle.IEX_GetParameter)("RAW_UseCameraWB", ss, xhandle.userData);
   if( strcmp(ss,"1")==0 ) IEX_AddParameter(handle,"-w");

   (*xhandle.IEX_GetParameter)("RAW_Bright", ss, xhandle.userData);
   if( strcmp(ss,"1")!=0 ) {
        IEX_AddParameter(handle, "-b" );
        IEX_AddParameter(handle, ss );
   }

   /*
   (*xhandle.IEX_GetParameter)("RAW_RedScale", ss, xhandle.userData);
   if( strcmp(ss,"1")!=0) {
           IEX_AddParameter(handle, "-r" );
           IEX_AddParameter(handle, ss );
   }

   (*xhandle.IEX_GetParameter)("RAW_BlueScale", ss, xhandle.userData);
   if( strcmp(ss,"1")!=0) {
           IEX_AddParameter(handle, "-l" );
           IEX_AddParameter(handle, ss );
   }
   */

   (*xhandle.IEX_GetParameter)("RAW_ExtraParams", ss, xhandle.userData);
   if( strlen(ss)>0 ) {
        int i,l;
        char *p=ss,*p1=ss;
        for(i=0,l=strlen(ss)+1;i<l;i++,p++)
                if(*p==32 || *p==0) {
                        *p=0;
                        IEX_AddParameter(handle, p1 );
                        p1=p+1;
                }
   }

   outStream = new TMemoryStream();
   xargv[0]="par.000";     // just to fill this field
   xargv[xargc]="par.111"; // just to fill this field

   xmain(xargc+1,xargv);

  (*xhandle.IEX_SetParameter)("DpiX", "72", xhandle.userData);
  (*xhandle.IEX_SetParameter)("DpiY", "72", xhandle.userData);
  (*xhandle.IEX_SetParameter)("ImageCount", "1", xhandle.userData);

  strcpy(xhandle.imFormatDescriptor,make);
  strcat(xhandle.imFormatDescriptor," ");
  strcat(xhandle.imFormatDescriptor,model);
  strcat(xhandle.imFormatDescriptor," ");
  strcat(xhandle.imFormatDescriptor,model2);

  if(!parametersOnly)
  {
    outStream->Size=outStream->Position;
    if(outStream->Size > 0)
      ConvertPPM2Image((char*)outStream->Memory);
  }
  else
  {
    if(iewidth!=0 && ieheight!=0)
    {
      xhandle.imWidth=iewidth;
      xhandle.imHeight=ieheight;
    }
    xhandle.imFormat=IEX_24RGB;
  }

}

__declspec(dllexport) bool WINAPI IEX_ExecuteTry(void* handle)
{
   IEX_AddParameter(handle,"-i");
   outStream = new TMemoryStream();
   xargv[0]="par.000";     // just to fill this field
   xargv[xargc]="par.111"; // just to fill this field
   xmain(xargc+1,xargv);

   return (iewidth!=0 && ieheight!=0);
}

__declspec(dllexport) void WINAPI IEX_ExecuteWrite(void* handle)
{
}

//---------------------------------------------------------------------------

void DoProgress(int percentage)
{
   (*xhandle.IEX_Progress)( percentage, xhandle.userData );
}

FILE *fopen(const char *filename, const char *mode)
{
   if( mode[0]=='r' )
   {
      return (FILE*)5;
   }
   else if( mode[0]=='w' )
   {
      return (FILE*)outStream;
   }
}

int fclose(FILE *stream)
{
   return 0;
}

int fseek(FILE *stream, long offset, int whence)
{
   if( (int)stream != 5 )
   {
      // out stream
      TStream* fs=(TStream*)stream;
      switch(whence)
      {
         case SEEK_SET:
            fs->Seek(offset, soBeginning);
            break;
         case SEEK_CUR:
            fs->Seek(offset, soCurrent);
            break;
         case SEEK_END:
            fs->Seek(offset, soEnd);
            break;
      }
   } else
   {
      // in stream, use call back functions
      int a;
      switch(whence)
      {
         case SEEK_SET:
            (*xhandle.IEX_PositionSet)(offset, xhandle.userData);
            break;
         case SEEK_CUR:
            a =(*xhandle.IEX_PositionGet)(xhandle.userData);
            (*xhandle.IEX_PositionSet)(a+offset, xhandle.userData);
            break;
         case SEEK_END:
            a =(*xhandle.IEX_Length)(xhandle.userData);
            (*xhandle.IEX_PositionSet)(a+offset, xhandle.userData);
            break;
      }
   }
   return 0;
}

size_t fread(void *ptr, size_t size, size_t n, FILE *stream)
{
   //OutputDebugString(IntToStr(size*n).c_str());
   if(size)
      return (*xhandle.IEX_Read)(ptr, size*n, xhandle.userData) / size;
   else
      return 0;
}

int fgetc(FILE *stream)
{
   unsigned char c;
   if( (*xhandle.IEX_Read)(&c,1,xhandle.userData)==0 )
        return -1;      // EOF
   else
        return c;
}

char *fgets(char *s, int n, FILE *stream)
{
   int c=0;
   int i=0;
   for(; i<n && c!='\n';i++)
   {
      c=fgetc(stream);
      if( c==-1 )
        return 0;
      s[i]=c;
   }
   s[i]=0;
   return s;
}

long int ftell(FILE *stream)
{
   if( (int)stream != 5 )
   {
      // out stream
      TStream* fs=(TStream*)stream;
      return fs->Position;
   } else
   {
      // in stream
      return (*xhandle.IEX_PositionGet)(xhandle.userData);
   }
}

size_t fwrite(const void *ptr, size_t size, size_t n, FILE *stream)
{
   TStream* fs=(TStream*)stream;
   if( fs->Size == fs->Position )
      fs->Size = fs->Size + 1000000;   // this speed-up processing
   return fs->Write(ptr, size*n)/size;
}

int iefscanf(FILE *stream, const char *format, int* address)
{
   *address=1;
   return 1;
}

void fwritestring(FILE *stream, const char *str)
{
   TStream* fs=(TStream*)stream;
   fs->Write(str, strlen(str));
}

void fwriteint(FILE *stream, int val)
{
   TStream* fs=(TStream*)stream;
   char s[255];
   ltoa(val, s, 10);
   fs->Write(s, strlen(s));
}

int fprintf(FILE *stream, const char *format)
{
}

}



//---------------------------------------------------------------------------
#pragma package(smart_init)
