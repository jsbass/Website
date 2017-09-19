/*********************************************
 *                  Project 5                *
 * Author:    Jacob Bass                     *
 * Program:   proj5                          *
 * Purpose:   Recieve grades from either a   *
 *            keyboard or file and read in   *
 *            grade data or read out grade   *
 *            data from/to grades.txt        *
 *            depending on the users chosen  *
 *            input method stores the input  *
 *            grades as an array. Makes      *
 *            another array containing the   *
 *            Letter grades cooresponding to *
 *            each numerical grade.          *
 *********************************************
 */

#include <stdio.h>
#include <stdlib.h>

//Structure Declarations
struct grade
{
    int number;
    char letter;
};

//Function Declarations
char letterify(int grade);
int  make_letter(struct grade grades[],int n);

int main(void){
    
    //Variable Declarations
    int temp,i,sum=0,n=100,exit_loop=0;
    struct grade grades[100];
    float avg;
    char ch,lavg;
    FILE *gradefile;

    //Fill grades array with -1 and lgrades array with 'E'
    for (i=0;i<100;i++)
    {
        grades[i].number=-1;
        grades[i].letter='E';
    }

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
        {
            printf("Invalid input detected\n");
            getchar();
        }
        // end if (ch=='k'||...)
    } // end while (!(exit_loop))

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
        } //end if(!(gradefile...))

        //Get number of grades from first line
        fscanf(gradefile,"%d",&n);
        
        //Error check n
        if (n>100)
        {
            printf("Limiting grades to the first 100\n");
            n=100;
        }
        else if (n<0)
        {
            printf("The number of grades cannot be less than 0\n");
            return -1;
        } //end if(n>100)

        //Get the list of numbers
        for (i=0;i<n;i++)
        {
            //Error check for end of file before expect number of inputs
            if (fscanf(gradefile,"%d",&temp)==EOF)
            {
                //End of File found before gathering the specified 
                //number of grades
                fclose(gradefile);
                printf("%d grades expected but only %d found. Now Exiting...\n",n,i);
                return -2;
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
                grades[i].number=temp;
            //end if (temp>100||temp<0)
        } //end for (i=0;i<n;i++)

        //close the file
        if (gradefile!=NULL)
            fclose(gradefile);
    }
    //User chose keyboard input
    else if (ch=='K'||ch=='k')
    {
        //Try to open "grades.txt" to write
        if(!(gradefile=fopen("grades.txt","w")))
        {
            printf("Could not open \"grades.txt\" to write.");
            printf("Check to make sure it isn't already open\n");
            return EXIT_SUCCESS;
        } //end if(!(gradefile...))
        
        //Get each grade in the list
        for (i=0;i<n;i++)
        {
            //Get the grade
            printf("Please enter grade number %d (-1 to quit): ",i+1);
            scanf("%d",&temp);
            if (temp==-1)
            {
                n=i;
                printf("Stopped at %d grades.\n",n);
                break;
            } //end if (temp==1)
            
            //Check for an appropriate grade between 0 and 100
            if (temp>100||temp<0)
            {
                printf("%d is not a valid grade.\n",temp);
                printf("The grade must be from 0 to 100\n");
                i+=-1;
            }
            else
                //Add the value to the grades array
                grades[i].number=temp;
            //end if (temp>100...)
        } //end for (i=0;i<n;i++)

        //Add the data to the file
        fprintf(gradefile,"%d\n",n);
        for(i=0;i<n;i++)
            fprintf(gradefile,"%d\n",grades[i].number);

        //Close the opened file
        if(gradefile!=NULL)
            fclose(gradefile);
    }
    //Check for messed up program logic and error proofing holes
    else
        printf("You should not be seeing this\n");
    //end if (ch=='F'||...)

    //Analyze grades and assign letter grades
    if(make_letter(grades,n))
    {
        //make_lgrades returned EXIT_FAILURE
        printf("Somehow you your number of grades became negative. Exiting...\n");
        return -3;
    }
    
    //Sum the values in the array
    for (i=0;i<n;i++)
        sum+=grades[i].number;
        
    //Calculate and Output Average
    avg =(int) (float)sum/(float)n;
    lavg = letterify((int)avg);

    //Output grades and grade letters as well as the average and lettered average
    printf("\n");
    printf("number of grades proccessed: %d\n",n);
    printf("/-----------------------------\\\n");
    printf("|    Grades   | Letter Grades |\n");
    for (i=0;i<n;i++)
        printf("|     %3d     |       %c       |\n",grades[i].number,grades[i].letter);
    printf("|-----------------------------|\n");
    if (avg==100)
        printf("| avg: %3.2f |       %c       |\n",avg,lavg);
    else if (avg>=10)
        printf("| avg: %3.2f  |       %c       |\n",avg,lavg);
    else
        printf("| avg: %3.2f   |       %c       |\n",avg,lavg);
    printf("\\-----------------------------/\n");
    
    return EXIT_SUCCESS;
}

//Turns the numerical grade input -1<n<101 and returns the letter grade
//equivalent
char letterify(int grade){

    if(grade>100||grade<0)
        return 'E';
    else if (grade>=90)
        return 'A';
    else if (grade>=80)
        return 'B';
    else if (grade>=70)
        return 'C';
    else if (grade>=60)
        return 'D';
    else
        return 'F';

}

//Takes the grades array, lgrades array, and the number of 
//elements checks each element (both should be the same size) and checks
//each element of grades before assigning a letter grade to the cooresponding 
//element of lgrades
int make_letter(struct grade grades[], int n)
{
    int i;
    
    //Error check n
    if (n<1)
    {
        printf("The array length must be a positive number\n");
        return EXIT_FAILURE;
    }
    
    for (i=0;i<n;i++)
        grades[i].letter=letterify(grades[i].number);

    return EXIT_SUCCESS;

}
