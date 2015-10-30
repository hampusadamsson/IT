#include <stdio.h>

int main (int argc, char *argv[])
{
  int areas[] = {10, 12, 13, 14, 20};
  char name[] = "Philip";
  char full_name[] = {
    'P', 'H', 'I', 'L', 'I', 'P', ' ',
    'A', 'K', 'E', 'R', 'F', 'E', 'L', 'D' , 'T', '\0'};
  
  printf("The size of an int is %ld\n",sizeof(int));
  printf("the sze of areas (int[]): %ld\n", sizeof(areas));
  
  printf("the number of inte in areas: %ld\n", sizeof(areas) / sizeof(int));

  printf("The 2nd area is %d and the 4th is %d\n", areas[2], areas[3]);

  printf("The size of char is: %ld\n", sizeof(char));
  printf("The size of name is: %ld\n", sizeof(name));
  printf("The numer of chars in name is: %ld\n", sizeof(name) / sizeof(char));

  printf("name=\"%s\" and full_name=\"%s\" \n", name, full_name);


  return 0;
}
