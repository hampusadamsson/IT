#include <stdio.h>
#include <stdlib.h>

int fact_iter(int n) {
  int fact_iter_i = 1;
  for (int i = 2; i <= n; ++i) {
    fact_iter_i = fact_iter_i * i;
      }
  return fact_iter_i;
}


int fact_rec(int n) {
  if (n == 1) {
    return n;
  } else {
    return n * fact_rec(n - 1);
  }  
}
    


int main (int argc, char *argv[]) {
  char *charnumber = argv[1];
  int intnumber = atoi(charnumber);
  printf("Recursive: %d\n", fact_rec(intnumber));
  printf("Iterative: %d\n", fact_iter(intnumber));
  return 0;
}

