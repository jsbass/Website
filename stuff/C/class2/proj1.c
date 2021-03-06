/*********************************************
 *                  Project 1                *
 * Author:    Jacob Bass                     *
 * Prgram:    proj1                          *
 * Purpose:   Recieve a user defined number  *
 *            number of grades and calulate  *
 *            an average                     *
 *********************************************
 */

#include <stdio.h>
#include <stdlib.h>
#include <ncurses.h>

int main(void){

  //Variable Declaration
  int n=0,sum=0,avg=0,round_avg=0,i=0,temp=0;
  float f_avg;
  char ch;

  printf("This program takes several grades and averages them\n");

  //Ask for number of grades
  printf("How many grades are there? ");
  scanf("%d",&n);

  //Ask for grades n number of times
  for (i=1;i<=n;i++) {
    printf("What is grade number %d? ",i);
    scanf("%d",&temp);
    sum=sum+(int)temp;
  }

  //Calculate the different averages
  avg = sum/n;
  round_avg = (float)sum/(float)n+.5;
  f_avg = (float)sum/(float)n;

  //Display the different averages
  printf("--------------------------------------------------------\n");
  printf("This average was calculated using the truncated integer,\n");
  printf("int, type for the sum, number of grades, and average:\n");
  printf("The average is: %d\n",avg);

  printf("--------------------------------------------------------\n");
  printf("This average was calculated using the floating type for\n");
  printf("the sum and number of grades,rounded, then, cast back ");
  printf("to an int for the average:\n");
  printf("The average is: %d\n",round_avg);

  printf("--------------------------------------------------------\n");
  printf("This average was calculated using the floating point,\n");
  printf("float, type for the sum, number of grades, and average:\n");
  printf("The average is: %f\n",f_avg);
  printf("\n");
  
  //Ask user for a character
  getchar();
  printf("Input a character ");
  ch = getchar();

  //Display the user's character
  printf("Your character was \"%c\"\n",ch);

  return EXIT_SUCCESS;
}
