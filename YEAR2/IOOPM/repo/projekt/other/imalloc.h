#ifndef __imalloc
#define __imalloc

// Allokera ett sammanh�ngande minnesutrymme om 'bytes' bytes f�r
// smalloc, nollst�ll det
void init(unsigned int bytes);

// Allokera sizeof(int) antal tecken i minnet
int *imalloc();

// Manipulera referensr�knaren
int retain(int *address);
int release(int *address);

// F�r illustration av anv�ndande av minnesutrymmet i
// testprogrammet, inte en del av imalloc
void dumpmem();

#endif


