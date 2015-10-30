#include <stdio.h>

int main (int argc, char *argv[])
{

  int numbers[4] = {0};
  char name [3] = {'A'};

  //first print out raw

  printf("numbers: %d %d %d %d\n", numbers[0], numbers[1], numbers[2], numbers[3]);

  printf("name each: %c %c %c %c\n", name[0], name[1], name[2], name[3]); 

  printf("name: %s\n", name);

  //setup numbers
  numbers[0] = 1;
  numbers[1] = 2;
  numbers[2] = 3;
  numbers[3] = 4; 

  //setup name
  name[0] = 'P';
  name[1] = 'h';
  name[2] = 'a';
  name[3] = 'k';

  //print out initialized values

  printf("numbers: %d %d %d %d\n", numbers[0], numbers[1], numbers[2], numbers[3]);
  printf("name each: %c %c %c %c\n", name[0], name[1], name[2], name[3]);

  //print them out as a string
  printf("This is the string that was combined: %s\n", name);

  //another way to use name
  char *another = "Philip";

  printf("another: %s\n", another);
  printf("another each: %c %c %c %c %c %c\n", another[0],another[1],
	 another[2],another[3],another[4],another[5]);

  return 0;
}
