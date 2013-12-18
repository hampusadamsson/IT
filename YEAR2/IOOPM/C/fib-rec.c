#include<stdio.h>
#include<stdlib.h>

int fib(int n) {
 
if (n == 0) {
  //printf("Fib(%d) = %d\n",n, 0);
    return 0; 
  } else {
    if (n == 1) {
      //printf("Fib(%d) = %d\n",n, 1);
      return 1; 
    } else {
	//printf("Fib(%d) = %d\n", n, b);
      return (fib(n-1) + fib(n-2)); 
    }
  }
}

int main(int argc, char **argv) {

  if (argc < 2) {
    puts("Usage: ./fib-rec 5");
  } else {
    int n = atoi(*(argv+1));
    for (int k = 0; k<=n; k++){
      printf("Fib(%d) = %d\n", k, fib(k));      
    } 
    
    
  }
  return 0;
}

