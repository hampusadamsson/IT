#include <stdio.h>
#include <stdlib.h>

//int main(int argc, char ** argv){

int main(int argc, char ** argv)
{
  printf("This is a simpel program!\n");
  //printf("Please insert two integers. \n");
  //scanf("%d%d", );  
  int i;

  for (i=1; i<argc; i++){
  printf("This is the argument passed with the program %s\n", argv[i]);
}
  return 0;
}
