# include <stdio.h>
# include <stdlib.h>
# include <string.h>

int main(void) {
  
  int *heap = malloc(20);
  int stack = 7; 
  

  printf("The stack is value is now: %d\n", stack);
  printf("The heap is value is now: %d\n\n", *heap);
  
  
  stack = 1337;
  *heap = 42;


  printf("The stack is value is now: %d\n", stack);
  printf("The heap is value is now: %d\n", *heap);

  free(heap);
  return 0;
}
