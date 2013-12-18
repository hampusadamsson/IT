#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef struct node *Node;

//readinput
//läser från filen vi får in
Node readinput(char *filename);

//sökfunktion
//Skickar in en Node och returnerar inte något
//används för att söka i databasen
void query(Node list);

//uppdateringsfunktion
//Skickar in en Node och inte skickar tillbaka något
//uppdaterar element den tidigare databasen
void update(Node list);

//insertfunktion
//lägger in nya element och skickar tillbaka en ny lista
//lägger in nya element i databasen förutsatt att platsen med en viss nyckel är ledig
Node insert(Node list);

//borttagningsfunktion
//tar bort ett element och skickar tillbaka en ny lista
//tar bort element ur databasen
Node delete(Node list);

//printar ut
//printar listan
//printar ut det vi har i databasen
void print(Node list);

//sorterar binärt
//sorterar databasen binärt för att få en logaritmisk tidskomplexitet
Node binarysort(char *key, char *value, Node newNode)