#include <stdio.h>

int main(int argc, char *argv[])
{
  int distance = 100;
  float power = 2.345f;
  double super_power = 56789.4532;
  char initial = 'M';
  char first_name[] = "Philip";
  char last_name[] = "Akerfeldt";

  printf("You are %d miles away\n", distance);
  printf("you have %f levels of power\n", power);
  printf("Your level of superpower is %f\n", super_power);
  printf("Your initial is %c\n", initial);
  printf("Your firstname is %s\n", first_name);
  printf("Your lastname is %s\n",last_name);
  printf("Your entire name is %s %c. %s. \n",first_name, initial, last_name);

  return 0;
}
