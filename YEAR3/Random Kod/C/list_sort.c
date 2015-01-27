#include <stdio.h>
#include <stdlib.h>

int bubble_sorter(int array []){
  
  // number of element in the array
  //int n = sizeof(array) / sizeof(int);
 
  // needed for the accumulator (loop)
  int d = sizeof(array) / sizeof(int);

  // used for swapping in the array
  int swap; 

  // used for fuck off
  int i;
  
  for (i = 0; i < d; i++)
    {  
      /*Increasing order as of now, change to "<" for decreasing order.*/
      if (array[i] > array[i+1]){
	swap = array[i];
	array[i] = array[i+1];
	array[i+1] = swap; 	
      }
    }
  printf("This is the sorted list: %d\n", *array);
  
  
  return 0;
}

int main(int argc, char ** argv){
  puts("This program will sort the integers of a list");
  
  /*if (argc<2) 
    {
      puts ("The program needs more than one input argument");
    }
  else 
    { 
      bubble_sorter(argv[1]);
    } 
  */
  int x[5] = {5,2,3,7};
  int size = sizeof(x) / sizeof(int);
  printf("Size of testlist: %d\n", size);
  bubble_sorter(x);

  return 0;
}
