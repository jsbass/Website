//Performs Euclid's Algorithm to find the GCD of two integers

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(void){

    int num1=0,num2=0,temp=0,gcd=0;

    printf("\n");
    printf("I will find the greatest common factor of two numbers.\n");

    //Ask user for the two numbers
    printf("What is the first number?: ");
    scanf("%d",&num1);
    printf("What is the second number?: ");
    scanf("%d",&num2);

    //Check if one or both is zero
    if(num1<0||num2<0)
    {
        printf("One of the numbers can't be negative.\n");
        return (-1);
    }
    else if (num1==0&&num2==0)
    {
        printf("Both numbers can't be zero.\n");
        return (-1);
    }

    //sort the largest into num1
    if(num1<num2)
    {
        temp=num1;
        num1=num2;
        num2=temp;
    }

    //Make sure num2 is not 0
    if (num2==0)
    {
        gcd=num1;
        printf("The GCD is %d\n",gcd);
        return (-1);
    }

    //Perform Euclid's Algorithm
    while(num1%num2!=0)
    {
        temp=num2;
        num2=num1%num2;
        num1=temp;
    }
    gcd=num2;

    printf("The GCD is %d\n",gcd);

    return EXIT_SUCCESS;

}
