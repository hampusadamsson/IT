#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>

// this part defines what information a person will contain
struct Person {
  char *name;
  int age;
  int height;
  int weight;
};

// what does this do?
struct Person *Person_create(char *name, int age, int height, int weight)
{
  // allocate memory for the struct person
  struct Person *who = malloc(sizeof(struct Person));
  //check that the memory allocated isnt faulty
  assert (who != NULL);
  
  // duplicate the string for the name (so that the struct actually owns it)
  who -> name = strdup(name);
  // initialize every field of the struct x3
  who -> age = age;
  who -> height = height;
  who -> weight = weight;

  return who;
}

void Person_destroy(struct Person *who)
{
  // Check that the memory allocated for who isnt faulty
  assert(who != NULL);

  // free the memory allocated from strdup
  free(who->name);
  // free the memory allocated from the malloc
  free(who);
}

void Person_print(struct Person *who)
{
  printf("Name: %s\n", who->name);
  printf("Age: %d\n", who->age);
  printf("Weight: %d\n", who->height);
  printf("Height: %d\n", who->weight);
}


int main (int argc, char *argv[])
{
  // make two people structures
  struct Person *Philip = Person_create("Philip Akerfeldt", 23, 196, 80);

  struct Person *Sam = Person_create("Sam Ronnlund", 23, 193, 105);

  // print them out and where they are in memory
  printf("Philip is at memory location %p\n", Philip);
  printf("Sam is at memory location %p\n", Sam);

  // make everyone age 20 years and print them again
  Philip -> age += 20;
  Philip -> height += 2.5;
  Philip -> weight += 45;
  Person_print(Philip);

  Sam -> age += 20;
  Sam -> height -= 2.5;
  Sam -> weight -= 45;
  Person_print(Sam);

  return 0;
}
