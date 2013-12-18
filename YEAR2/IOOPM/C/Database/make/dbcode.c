#include "databas.h"


struct node {
  char *key;
  char *value;
  struct node *left;
  struct node *right;
};

//binarysort
Node binarysort(char *key, char *value, Node newNode) {  
if (newNode == NULL) {
  Node newNode = malloc(sizeof(struct node));
  //creates a new node and gives it a key
    newNode->key = malloc(strlen(key) + 1);
    strcpy(newNode->key, key);
    //.. and a value
    newNode->value = malloc(strlen(value) + 1);
    strcpy(newNode->value, value);
    newNode->right = NULL;
    newNode->left = NULL;
    return newNode;
 } else if (strcmp(key, newNode->key) > 0) {
  newNode->right = binarysort(key, value, newNode->right);
  } else {
  newNode->left = binarysort(key, value, newNode->left);
  }
 return newNode;
}


//readline
void readline(char *dest, int n, FILE *source){
  fgets(dest, n, source);
  int len = strlen(dest);
  if(dest[len-1] == '\n')
    dest[len-1] = '\0';
}

// Read the input file
Node readinput(char *filename) {
  printf("Loading database \"%s\"...\n\n", filename);
  FILE *database = fopen(filename, "r");
  char buffer1[128];
  char buffer2[128];
  Node newNode = NULL;
  while(!(feof(database))){
    readline(buffer1, 128, database);
    readline(buffer2, 128, database);
    newNode = binarysort(buffer1, buffer2, newNode);
  }
  return newNode;
}

//query
void query(Node list) {
  printf("Enter key: ");
  char buffer[128];
  int found;
  Node cursor;
      readline(buffer, 128, stdin);
      puts("Searching database...\n");
      found = 0;
      cursor = list;
      while(!found && cursor != NULL){
        if(strcmp(buffer, cursor->key) == 0){
          puts("Found entry:");
          printf("key: %s\nvalue: %s\n", cursor->key, cursor->value);
          found = 1;
        } else {
	  if (strcmp(buffer, cursor->key) > 0){
	    cursor = cursor->right;
	  } else {
	    cursor = cursor->left;
	  }
	}

      }
	if(!found){
	  printf("Could not find an entry matching key \"%s\"!\n", buffer);
	}
}

//update
void update(Node list) {
  printf("Enter key: "); 
  int found;
  Node cursor;
  char buffer[128];
  readline(buffer, 128, stdin);
  puts("Searching database...\n");
  found = 0;
  cursor = list;
  while(!found && cursor != NULL){
        if(strcmp(buffer, cursor->key) == 0){
          puts("Matching entry found:");
          printf("key: %s\nvalue: %s\n\n", cursor->key, cursor->value);
          found = 1;
        }else{
	  if (strcmp(buffer, cursor->key) > 0){
	    cursor = cursor->right;
	  } else {
	    cursor = cursor->left;
	  }
	}
  }
	if(!found){
	  printf("Could not find an entry matching key \"%s\"!\n", buffer);
	}else{
	  printf("Enter new value: ");
	  readline(buffer, 128, stdin);
	  free(cursor->value);
        cursor->value = malloc(strlen(buffer) + 1);
        strcpy(cursor->value, buffer);
        puts("Value inserted successfully!");
	}
}


 
//insert
Node insert(Node list) {
  printf("Enter key: ");
  int found;
  Node cursor;
  char buffer[128];
  char buffer2[128];
  readline(buffer, 128, stdin);
  puts("Searching database for duplicate keys...");
  found = 0;
  cursor = list;
  while(!found && cursor != NULL){
        if(strcmp(buffer, cursor->key) == 0){
          printf("key \"%s\" already exists!\n", cursor->key);
          found = 1;
        }else{
	  if (strcmp(buffer, cursor->key) > 0){
	    cursor = cursor->right;
	  } else {
	    cursor = cursor->left;
	  }
	}
  }
  
  if(!found){ // Insert new node to the front of the list
    puts("Key is unique!\n");
        printf("Enter value: ");
        readline(buffer2, 128, stdin);
	binarysort(buffer, buffer2, list);
        //newNode->next = list;
        puts("");
        puts("Entry inserted successfully:");
        printf("key: %s\nvalue: %s\n", buffer, buffer2);
  }
  return list;
}

/*void deletehelp(Node list) {
  int found;
  Node cursor;
  found = 0;
  cursor = list;
  while(!found && cursor != NULL){
        if(strcmp(buffer, cursor->key) == 0){
          printf("Can't find \"%s\"!\n", cursor->key);
          found = 1;
	} else {
	  if (strcmp(buffer, cursor->key) > 0) {
	  cursor = cursor->right */


//delete
Node delete(Node list) {
  printf("Enter key: ");
  int found;
  Node cursor;
  char buffer[128];
  readline(buffer, 128, stdin);
  puts("Searching database...\n");
  found = 0;
  cursor = list;
  Node prev = NULL;
  while(!found && cursor != NULL){
        if(strcmp(buffer, cursor->key) == 0){
          if(prev == NULL){ // Delete first node
	    // list = cursor->next;
	    // list = cursor->right;
          }else{
            //prev->next = cursor->next;
	    prev->right = cursor->right;
          }
          found = 1;
          printf("Deleted the following entry:\nkey: %s\nvalue: %s\n", cursor->key, cursor->value);
        }else{
          prev = cursor;
	  // cursor = cursor->next;
	  cursor = cursor->right;
        }
  }
  if(!found){
    printf("Could not find an entry matching key \"%s\"!\n", buffer);
  }
  return list;
}


void print(Node cursor) {
  if (cursor) {
    print (cursor->right);    
    puts(cursor->key);
    puts(cursor->value);
    print(cursor->left);
  }
}
