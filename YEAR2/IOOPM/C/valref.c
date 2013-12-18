#include <stdio.h>

int main (void) {
  
  int x = 14;
  int z = 1;
  int *y;
  
  y = &x;
  puts("Första gången");
  printf("Detta är värdet på x: %d\n", x);
  printf("Detta är värdet på z: %d\n", z);
  printf("Detta är värdet på y: %d\n\n", *y);

  x = z;  
  puts("Andra gången");
  printf("Detta är värdet på x är nu: %d\n", x);
  printf("Detta är värdet på z: %d\n", z);
  printf("Detta är värdet på y är nu: %d\n\n", *y);
  
  x = 1337;
  puts("Tredje gången");
  printf("Detta är värdet på x är nu: %d\n", x);
  printf("Detta är värdet på z: %d\n", z);
  printf("Detta är värdet på y är nu: %d\n\n", *y);
  
  
  return 0;
}
