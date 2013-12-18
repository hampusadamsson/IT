#ifndef __imalloc
#define __imalloc

// Allokera 'bytes' antal tecken i minnet. 'threshhold' s�tter ett
// tr�skelv�rde f�r att f�rhindra att allt f�r sm� block skapas
// (fragmentering)
void init(unsigned int bytes, unsigned int threshhold);

// Allokera 'bytes' antal tecken i minnet
void *rmalloc(int bytes);

// Manipulera referensr�knaren
void retain(void *address);
void release(void *address);

// F�r illustration av anv�ndande av minnesutrymmet i
// testprogrammet, inte en del av rmalloc
void dumpmem();

#endif


