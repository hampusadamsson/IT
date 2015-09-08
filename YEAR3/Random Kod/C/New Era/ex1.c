#include <stdio.h>

int main (int argc, char *argv[])
{

int age = 10;
int height = 72;
int neg = -22;
int pos = 24;

printf("I am %d old. \n",age);
printf("And I am approx %d tall.\n", height);
printf("%-d\n", neg);
printf("%-d\n", pos);

	return 0;
}