/*********************************************
 *                  Project 2                *
 * Author:    Jacob Bass                     *
 * Prgram:    proj2                          *
 * Purpose:   Recieve grades from either a   *
 *            keyboard or file and read in   *
 *            grade data or read out grade   *
 *            data to grades.txt depending   *
 *            on the users chosen input      *
 *            method                         *
 *********************************************
 */

#include <stdio.h>
#include <stdlib.h>

int main(void){

    //Variable Declarations
    int sum=0,temp=0,i=0,n=0,exit_loop=0;
    float avg=0;
    char ch;
    FILE *gradefile;

    //Explain Program
    printf("\n");
    printf("-------------------------------------------------------\n");
    printf("This program can take either keyboard or file input");
    printf(" for grades from ranging\n");
    printf("from 0 to 100 and then it will calculate the average.\n");
    printf("If file input is used, then the file should be named\n");
    printf("\"grades.txt\" and contain the number of grades on\n");
    printf("the first line followed by one grade each of the\n");
    printf("following lines.\n");
    printf("If keyboard input is used a file following the same\n");
    printf("rules will be output\n");
    printf("-------------------------------------------------------\n");
    printf("\n");

    //Have user choose a method of input
    while (!(exit_loop))
    {
        printf("Please choose an input method\n");
        printf("Keyboard (K or k), File (F or f), Quit (Q or q)\n");
        ch = getchar();
        if (ch=='k'||ch=='K'||ch=='f'||ch=='F')
            exit_loop=1;
        else if (ch=='Q'||ch=='q')
           return EXIT_SUCCESS;
        else
            printf("Invalid input detected\n");
        // end if (ch=='k'||...)
    } //end while (!(exit_loop))

    //User chose file input
    if (ch=='F'||ch=='f')
    {
        //Open file/check for file
        if (!(gradefile=fopen("grades.txt","r")))
        {
            //Could not find "grades.txt"
            printf("Could not find \"grades.txt\"\n");
            printf("Make a \"grades.txt\" file and try again\n");
            return EXIT_SUCCESS;
        } // end if (!(gradefile...))

        //Get number of grades from first line
        fscanf(gradefile,"%d",&n);

		//Error check n
		if (n<0)
		{
			printf("The number of grades must be greater than zero\n");
			return (-1);
		}
		
        //Get the list of numbers
        for (i=0;i<n;i++)
        {
            //Error check for end of file before expect number of inputs
            if (fscanf(gradefile,"%d",&temp)==EOF)
            {
                //End of File found before gathering the specified 
                //number of grades
                printf("%d grades not found.\n",n);
                printf("Continuing with the %d ",i);
                printf("grades that were found.\n");
                n=i;
                break;
            } //end if(temp==EOF)

            //Error check for grades outside of range
            if (temp>100||temp<0)
            {
                printf("Grade %d is not between 0 and 100, it is ",i); 
                printf("%d so it will not be used\n",temp);
				i+=-1;
				n+=-1;
            }
            else
                sum+=temp;
            //end if (temp>100||temp<0)
        } // end for (i=0;i<n;i++)

        //close the file
        if (gradefile!=NULL)
            fclose(gradefile);
    } //end if (ch=='F'...)

    //User chose keyboard input
    else if (ch=='K'||ch=='k')
    {
        //Try to open "grades.txt" to write
        if (!(gradefile=fopen("grades.txt","w")))
        {
            printf("Could not open \"grades.txt\" to write.");
            printf("Check to make sure it isn't already open\n");
            return EXIT_SUCCESS;
        } //end if (!(gradefile...))

        //Get the number of grades
		do {
			printf("Please enter the number of grades: ");
			scanf("%d",&n);
			if (n<1)
				printf("The number of grades must be greater than zero\n");
		} while (n<1);

        //Write the number of grades to "grades.txt"
        fprintf(gradefile,"%d\n",n);

        //Get each grade in the list
        for (i=0;i<n;i++)
        {
            //Get the grade
            printf("Please enter grade number %d: ",i+1);
            scanf("%d",&temp);
            //Check for an appropriate grade between 0 and 100
            if (temp>100||temp<0)
            {
                printf("%d is not a valid grade.\n",temp);
                printf("The grade must be from 0 to 100\n");
            } //end if (temp>100||temp<0)
            else
                //Write the grade to "grades.txt" and add it to the sum
                fprintf(gradefile,"%d\n",temp);
                sum+=temp;
        } //end for (i=1;i<=n;i++)

        //Close the opened file
        if(gradefile!=NULL)
            fclose(gradefile);
            
    } //end if (ch=='K'...)
	
    //Check for messed up program logic and error proofing holes
    else
        printf("You should not be seeing this\n");
    //end if (ch=='F'||...)
    
    //Calculate and Output Average
	if(n!=0)
		avg = (float)sum/(float)n;

    printf("The average of these %d grades is %.2f\n",n,avg);

    return EXIT_SUCCESS;        
}
