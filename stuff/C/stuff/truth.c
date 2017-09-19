/**********************************************************
 **  Program: truth.c                                    **
 **  Author:  Jacob Bass                                 **
 **  Purpose: Generate a truth tables and compare        **
 **           equivalencies of user input compound       **
 **           statements                                 **
 **                                                      **
 **********************************************************
 */

#include <stdio.h>
#include <stdlib.h>

//Function Declarations
int [] forloops(int nloops, int loopn)

int main(){
  int nstate,i,n_eq;
  char c_eq;

  printf("How many statements are there?");
  scanf("%d%c",&nstate);
  printf("\n");

  do{
  
  printf("Is this an equivalence problem? (y or n)");
  scanf("%c",&c_eq);
  printf("\n");

  if (eq == 'Y' || eq == 'y'){
    n_eq=1;
    break;
  }
  else if (eq == 'N' || eq == 'n'){
    n_eq=0;
    break;
  }
    
  printf("Please enter a valid answer. (y or n)\n");

  }while(1);

  clear;

  printf("Compound Statement 1\n");
  printf("Valid Symbols: and   &\n");
  printf("               or    |\n");
  printf("               not   ~\n");
  printf("               paren ()\n");

  return EXIT_SUCCESS;
}

int[] forloops(nloops,loopn)
{
}
