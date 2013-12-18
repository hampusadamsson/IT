#include <stdio.h>

/*void print (void *pekare, int typ) {
 for (int i = 0; i < 7; ++i) {
   //printf("The pointer points to: %d\n", *pekare);
    switch (typ) {
    case TYP_INT printf("%p", *((int*)pekare)); break;
    case TYP_FLOAT printf("%p", *((float*)pekare)); break;
    }
 }
}
//if ((*pekare++)%2 == 0) {
    //printf("Even!\n\n");
    //  } else {
    //   printf("Uneven!\n\n");
    // }
    */

void print(void *ptr, int i) {
  if(i==1) {
    printf("%d\n",*(int*)ptr);  
  } else if(i==2) {
    printf("%c\n",*(char*)ptr);    
  } else if(i==3) {
    printf("%.2f\n",*(float*)ptr);
  }
}

int main(void) {
  int number = 7;
  float floatnumber = 3.5;
  char ch;
  void *ptr;
  int i = 1;

  ptr = &number;
  print(ptr, i++);
  
  ptr = &ch;
  print(ptr, i++);
  
  ptr = &floatnumber;
  print(ptr, i++);
  
  return 0;
}




/* Comments like me are ignored */
{
/* State 0 (S0) has epsilon-edges to S3 & S5 */
    //1
   "1" : {"" : 2},
   "1" : {"b" : 3},
    //2
    "2" : {"a" : 3},
    //3 
    "3" : {"a" : 3},
    "3" : {"a" : 4},
    "3" : {"" : 1},
    //4
    "4" : {"a" : 4},
    "4" : {"a" : 5},
    "4" : {"b" : 7},
    //5
