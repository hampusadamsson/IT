#include <stdio.h>

int intInc (int *pointer){
  *pointer += 1;
  return 0; 
}

int takeTime(int i){
  while (i < 1000000000){
    i++;
  } 
  return 0;
}

int main (void) {
  int one = 1;
  //int two = 2;
  //int three = 3;
  int *ptrone;
  // int *ptrtwo;
  //int *ptrthree; 

  ptrone = &one;

  puts("\nWelcome, this is a simple program to show how to send values through the stack over to other functions!\n\n");

  printf("This is the value of pointer one before the increment function: %d\n\n", *ptrone); // prints out the value in which the pointer is pointing to.

  takeTime(one);

  intInc(ptrone); //calls the funcion intInc which increments the value of the int that the pointer points to.

  printf("This is the value of pointer one after the increment function: %d\n\n", *ptrone); // prints out the new vlue of the in in which the pointer is pointing to.
  return 0;
}



