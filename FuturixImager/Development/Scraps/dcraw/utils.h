//---------------------------------------------------------------------------

#ifndef utilsH
#define utilsH
//---------------------------------------------------------------------------

#include <stddef.h>

typedef int FILE;

extern FILE* stderr;
extern FILE* stdout;

FILE *fopen(const char *filename, const char *mode);
int fclose(FILE *stream);
int fseek(FILE *stream, long offset, int whence);
size_t fread(void *ptr, size_t size, size_t n, FILE *stream);
size_t fwrite(const void *ptr, size_t size, size_t n, FILE *stream);
int fgetc(FILE *stream);
long int ftell(FILE *stream);
int iefscanf(FILE *stream, const char *format, int* address);
char *fgets(char *s, int n, FILE *stream);

void fwritestring(FILE *stream, const char *str);
void fwriteint(FILE *stream, int val);
void DoProgress(int percentage);

#endif
