#include<stdlib.h>
#include<stdio.h>

struct node {
  int val;
  struct node * next;
};

typedef struct node Node;

int main(void) {
  Node * current, * head;
   int i;
   
   head = NULL;
   
   // Skapa 10 stycken noder som pekar på varandra
   for(i=1;i<=10;i++) {
     current = (Node *)malloc(sizeof(Node));
      current->val = i;
      current->next  = head;
      head = current;
   }
   current = head;
   
   //Dags att printa ut lite om hur strukturen ser ut
   while(current != NULL) {
     if ( (current->val) > 3){
       printf("The %dth node ", current->val);
       printf("has the adress: %p and ", current);
       printf("points to the adress: %p\n\n", current->next);
       current = current->next;
     } else {
       if ( (current->val) == 3) {
	 printf("The %drd node ", current->val);
	 printf("has the adress: %p and ", current);
	 printf("points to the adress: %p\n\n", current->next);
	 current = current->next;
       } else {
	 if ( (current->val) == 2) {
	   printf("The %dnd node ", current->val);
	   printf("has the adress: %p and ", current);
	   printf("points to the adress: %p\n\n", current->next);
	   current = current->next;
	 } else {
	   if ( (current->val) == 1){
	     printf("The %dst node ", current->val);
	     printf("has the adress: %p and ", current);
	     printf("points to the adress: %p\n\n", current->next);
	     current = current->next;
	   }
	 }
       }
     }
   }
}
