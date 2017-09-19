//Fibonacci sequence generator

#include <stdio.h>
#include <stdlib.h>

int main(void){

	long int *fib;
	int n,i,exit_loop=0;
	char ch;
	
	//Tell the user the program functionality
	printf("This program can: list all of the fibonacci numbers up to the nth element (list)\n");
	printf("                  list just the nth element (single)\n");
	printf("                  list the nth and the (n-1)th elements (double)\n");
	
	//Have user choose a method of input
    while (!(exit_loop))
    {
        printf("Please choose:\n");
        printf("List (L or l), Single (S or s), Double (D or d), or Quit (Q or q)\n");
        ch = getchar();
        if (ch=='L'||ch=='l'||ch=='S'||ch=='s'||ch=='D'||ch=='d')
            exit_loop=1;
        else if (ch=='Q'||ch=='q')
           return EXIT_SUCCESS;
        else
        {
            printf("Invalid input detected\n");
            getchar();
        }
        // end if (ch=='k'||...)
    }
		
	//User chose List
	if (ch=='L'||ch=='l'){
		do {
			printf("What is the nth number to list until?:");
			scanf("%d",&n);
			if (n<1)
				printf("Please enter a positive number for n\n");
		} while (n<1);
		
		//dynamically allocate an integer array of length n
		if ((fib = (long int*)malloc(n*sizeof(long)))==NULL)
		{
			printf("Memory allocation failed\n");
			return (-1);
		}
		
		//check to see if n=1
		if (n==1)
			fib[0] = 1;
		else {
			fib[0] = 1;
			fib[1] = 1;
			for (i=2;i<=n-1;i++)
				fib[i]=fib[i-1]+fib[i-2];
		}
		
		for (i=0;i<n;i++)
			printf("%d ",fib[i]);
		printf("\n");
		
		free(fib);
	}
	//User chose Single
	else if (ch=='S'||ch=='s'){
		do {
			printf("What is the nth number to find?:");
			scanf("%d",&n);
			if (n<1)
				printf("Please enter a positive number for n\n");
		} while (n<1);
		
		//dynamically allocate an integer array of length n
		if ((fib = (long int*)malloc(n*sizeof(long)))==NULL)
		{
			printf("Memory allocation failed\n");
			return (-1);
		}
		
		//check to see if n=1
		if (n==1)
			fib[0] = 1;
		else {
			fib[0] = 1;
			fib[1] = 1;
			for (i=2;i<=n-1;i++)
				fib[i]=fib[i-1]+fib[i-2];
		}
		
		printf("%d\n",fib[n-1]);
		
		free(fib);
	}
	//User chose Double
	if (ch=='D'||ch=='d'){
		do {
			printf("What is the nth number to list until?:");
			scanf("%d",&n);
			if (n<2)
				printf("Please enter number for n that is at least 2\n");
		} while (n<2);
		
		//dynamically allocate an integer array of length n
		if ((fib = (long int*)malloc(n*sizeof(long)))==NULL)
		{
			printf("Memory allocation failed\n");
			return (-1);
		}

		fib[0] = 1;
		fib[1] = 1;
		for (i=2;i<=n-1;i++)
			fib[i]=fib[i-1]+fib[i-2];
		
		printf("%d %d\n",fib[n-2],fib[n-1]);
		
		free(fib);
	}
	
	return EXIT_SUCCESS;
}
