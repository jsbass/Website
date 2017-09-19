/*********************************************
 *                  Project 6                *
 * Author:    Jacob Bass                     *
 * Program:   proj6                          *
 * Purpose:   Recieve grades from either a   *
 *            keyboard or file and read in   *
 *            grade data or read out grade   *
 *            data from/to grades.txt        *
 *            depending on the users chosen  *
 *            method and stores a students   *
 *            last name, first name, and     *
 *            number grade in a structured   *
 *            array. Then it computes the    *
 *            letter grade equivalent and    *
 *            adds it to the structured      *
 *            array before printing a sorted *
 *            table of the data              *
 *                                           *
 *********************************************
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//Structure Declarations
struct student
{
    char first[20];
    char last[20];
    int ngrade;
    char lgrade;
};

//Function Declarations
int  check_grade(int grade);
int  check_name(char name[]);
char letterify(int grade);
int  determine_grades(struct student students[],int n);
int  capitalize(char name[]);
int  alpha_sort(struct student students[],int n);
int  get_max_length(struct student students[],int n);
int  printoutput(struct student students[],int max_length, int n);
int  printspaces(int n);

//Main program function
int main(void){
    
    //Variable 
    struct student students[100];                //Student Data Array
    int    i,j;                                  //Looping Variables
    int    sum=0;                                //Sum of Users Grades
    int    n=100;                                //Number of Students
    int    exit_loop=0;                          //Determines Loop Termination
	int    tmp_grade;                            //User Grade Input Variable
    char   tmp_first[20],tmp_last[20],ans[5],ch; //User Input Variables
    char   gfile_name[40];                       //File Storage Name
    FILE   *gfile;                               //File Storage Pointer

    //Fill the structured students array with initial data
    for (i=0;i<100;i++)
    {
        students[i].first[0]='\0';
        students[i].last[0]='\0';
        students[i].ngrade=-1;
        students[i].lgrade='E';
    }

    //Explain Program
    printf("\n");
    printf("-------------------------------------------------------\n");
    printf("This program can take either keyboard or file input");
    printf(" for grades from ranging\n");
    printf("from 0 to 100 and then it will calculate the average.\n");
    printf("If file input is used, then the file should\n");
    printf("contain the number of grades on the first line followed\n");
    printf("by the \"first name\" \"last name\" grade on each following line\n");
    printf("If keyboard input is used a file following the same\n");
    printf("rules will be output\n");
    printf("-------------------------------------------------------\n");
    printf("\n");

    //Have user choose a method of input
    while (!(exit_loop))
    {
        //Ask for input method
        printf("Please choose an input method\n");
        printf("Keyboard (K or k), File (F or f), Quit (Q or q)\n");
        //Get user input
        ch = getchar();
        //Clear the carraige return
        getchar();
        //Check for valid input
        if (ch=='k'||ch=='K'||ch=='f'||ch=='F')
            //Valid input detected
            exit_loop=1;
        else if (ch=='Q'||ch=='q')
            //User directed to quit
            return EXIT_SUCCESS;
        else
        {
            //Invalid input detected
            printf("Invalid input detected\n");
        } // end if (ch=='k'||...)
    } // end while (!(exit_loop))

    //User chose file input
    if (ch=='F'||ch=='f')
    {
        //Ask for the file name
        printf("What is the name of the file to read?: ");
        scanf("%39s",gfile_name);
        printf("\n");
        
        //Open file/check for file
        if (!(gfile=fopen(gfile_name,"r")))
        {
            //Could not find gfile
            printf("Could not find \"%s\"\n",gfile_name);
            printf("Make sure \"%s\" exists and is not opened and try again\n",gfile_name);
            return EXIT_FAILURE;
        } //end if(!(gfile...))

        //Get number of grades from first line
        fscanf(gfile,"%d",&n);
        
        //Error check for n outside of students array size
        if (n>100)
        {
            //n outside of range. Limit n to 100
            printf("Limiting grades to the first 100\n");
            n=100;
        }
        else if (n<0)
        {
            //n is negative
            printf("The number of grades cannot be less than 0\n");
            return -1;
        } //end if(n>100)

        //Loop through for each student
        for (i=0;i<n;i++)
        {
            //Loop for each value gathered for each student
            for (j=0;j<3;j++) {
                switch (j) {
                    case 0:
                        //Get first name);
                        if(fscanf(gfile,"%19s",tmp_first)==EOF)
                        {
                            //First name returned EOF
                            printf("End of File reached before the designated");
                            printf(" number of student's data found\n");
                            printf("%d expected, %d found. Now Exiting...\n",n,i);
                            return EXIT_FAILURE;
                        }
                        else if(check_name(tmp_first)==EXIT_FAILURE)
                        {
                            //First name contains non-alphabetic characters
                            printf("Student #%d's first name is not only alphabetic\n",i); 
                            printf("It is %s so this student will not be used\n",tmp_first);
                            //Rewind i and n to discount this student
                            i+=-1;
                            n+=-1;
                            //Stop getting this student's data
                            j=3;
                            break;
                        }
                        else
                        {
                            //Capitalize and store this student's first name data
                            capitalize(tmp_first);
                            strcpy(students[i].first,tmp_first);
                        }
                        break;
                    case 1:
                        //Get last name
                        if(fscanf(gfile,"%19s",tmp_last)==EOF)
                        {
                            //Last name returned EOF
                            printf("End of File reached before the designated");
                            printf(" number of completed student's data found\n");
                            printf("%d expected, %d found. Now Exiting...\n",n,i);
                            return EXIT_FAILURE;
                        }
                        else if(check_name(tmp_last)==EXIT_FAILURE)
                        {
                            //Last name contained non-alphabetic characters
                            printf("Student #%d's last name is not only alphabetic.\n",i); 
                            printf("It is %s so this student will not be used\n",tmp_last);
                            //Rewind i and n to discount this student
                            i+=-1;
                            n+=-1;
                            //Stop getting this student's data
                            j=3;
                            break;
                        }
                        else
                        {
                            //Capitalize and store this student's last name data
                            capitalize(tmp_last);
                            strcpy(students[i].last,tmp_last);
                        }
                        break;
                    case 2:
                        //Get grade
                        if(fscanf(gfile,"%d",&tmp_grade)==EOF)
                        {
                            //Student's grade returned EOF
                            printf("End of File reached before the designated");
                            printf(" number of completed student's data found\n");
                            printf("%d expected, %d found. Now Exiting...\n",n,i);
                            return EXIT_FAILURE;
                        }
                        else if(check_grade(tmp_grade)==EXIT_FAILURE)
                        {
                            //Student's grade is outside of the valid range
                            printf("Student #%d's grade is not between 0 and 100.\n",i); 
                            printf("It is %d so this student will not be used\n",tmp_grade);
                            //Reqind i and n to discount this student
                            i+=-1;
                            n+=-1;
                            break;
                        }
                        else
                            //Store this student's numerical grade data
                            students[i].ngrade=tmp_grade;
                        break;
                } //end switch (j)
            } //end for(j=0;j<3;j++)
        } //end for (i=0;i<n;i++)

        //Close the file
        if (gfile!=NULL)
            fclose(gfile);
        else
            printf("Unable to close the file. File pointer may have been NULL\n");
    }
    //User chose keyboard input
    else if (ch=='K'||ch=='k')
    {
        //Ask for the file name
        printf("What is the name of the file to write?: ");
        scanf("%39s",gfile_name);

        //Try to open gfile to write
        if(!(gfile=fopen(gfile_name,"w")))
        {
            printf("Could not open \"%s\" to write.\n",gfile_name);
            printf("Check to make sure \"%s\" isn't already open\n",gfile_name);
            return EXIT_FAILURE;
        } //end if(!(gfile...))

        //Get each student's data
        exit_loop=0;
        for (i=0;i<n;i++)
        {
            //Determine if there are more students' data
            while (1) {
                //Ask if there is more students' data
                printf("Input a new student's data? (Yes or No): ");
                //Get user input
                scanf("%4s",ans);
                //Clear data outside of 3 the 3 character string
                scanf("%*[^\n]");
                //Check validity of ans
                if (strcasecmp(ans,"yes")==0||strcasecmp(ans,"no")==0)
                    //Valid input
                    break;
                else
                    //Invalid input
                    printf("Error: Invalid input detected\n");
            }//end while (1)
            
            if (strcasecmp(ans,"no")==0) {
                //User determined there were no more students
                n=i;
                break;
            } //end if (strcasecmp(ans,"no")==0)
            
            //Loop for each value gathered for each student
            for (j=0;j<2;j++) {
                switch (j) {
                    case 0:
                        //Get first name
                        while(1) {
                            //Ask user to input this student's first name
                            printf("Enter student %d's full name (\"quit\" to exit): ",i+1);
                            //Get first name input
                            scanf("%19s",tmp_first);
                            
                            if(strcasecmp(tmp_first,"quit")==0) {
                                //User decided to quit
                                i+=-1;
                                j=2;
                                break;
                            }
                            else
                            //Get last name input
                            scanf("%19s",tmp_last);
                            
                            if(check_name(tmp_first)==EXIT_FAILURE)
                            {
                                //First name contains non-alphabetic characters
                                printf("Error: %s contains non-alphabetic characters.\n",tmp_first);
                                continue;
                            }
                            if(check_name(tmp_last)==EXIT_FAILURE)
                            {
                                //Last name contains non-alphabetic characters
                                printf("Error: %s contains non-alphabetic characters.\n",tmp_last);
                                continue;
                            }
                            break;
                        }
                        
                        if(strcasecmp(tmp_first,"quit")!=0) {
                            //User did not say to quit
                            //Capitalize and store this student's first and last name data
                            capitalize(tmp_first);
                            strcpy(students[i].first,tmp_first);
                            capitalize(tmp_last);
                            strcpy(students[i].last,tmp_last);
                        }
                        break;
                    case 1:
                        //Get grade
                        while (1) {
                            //Ask user for this student's grade
                            printf("Enter student %d's grade (-1 to exit): ",i+1);
                            scanf("%d",&tmp_grade);
                            
                            if(tmp_grade==-1){
                                //User decided to quit
                                i+=-1;
                                j=2;
                                break;
                            }
                            else if(check_grade(tmp_grade==EXIT_FAILURE)){
                                //Grade was not in the valid range
                                printf("Error: %d is between 0 and 100.\n",tmp_grade);
                                continue;
                            }
                            break;
                        }
                        if(tmp_grade!=-1)
                            //Store this student's numerical grade
                            students[i].ngrade=tmp_grade;
                        break;
                } //end switch (j)
            } //end for(j=0;j<3;j++)
        } //end for (i=0;i<n;i++)
        
        //Add the data to the file
        fprintf(gfile,"%d\n",n);
        for(i=0;i<n;i++)
            fprintf(gfile,"%s %s %d\n",students[i].first,students[i].last,students[i].ngrade);

        //Close the opened file
        if(gfile!=NULL)
            fclose(gfile);
        else
            printf("Unable to close the file. file pointer may have been NULL\n");
    }
    //Check for messed up program logic and error proofing holes
    else
        printf("You should not be seeing this\n");
    //end if (ch=='F'||...)

    //Check to see if at least one student's data was input
    if(n<1) {
        printf("No student data input. Exiting...\n");
        return EXIT_SUCCESS;
    }

    //Analyze grades and assign letter grades
    if(determine_grades(students,n))
    {
        //make_lgrades returned EXIT_FAILURE
        printf("Somehow you your number of grades became negative. Exiting...\n");
        return -3;
    }
    
    //Sort the array of students
    if (alpha_sort(students,n)==EXIT_FAILURE)
    {
        printf("Names could not be sorted so the table may not be in alphabetical order");
    }
    
    //Output names, grades and grade letters as well as the average and lettered average
    printoutput(students,get_max_length(students,n),n);

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

//Takes the students and the number of 
//elements and checks
//each element of students.ngrade before assigning a letter grade to the cooresponding 
//element of students.lgrade
int determine_grades(struct student students[], int n)
{
    int i;
    
    //Error check for n<1
    if (n<1)
    {
        return EXIT_FAILURE;
    }
    
    //Determine and write a letter grade for each student
    for (i=0;i<n;i++)
        students[i].lgrade=letterify(students[i].ngrade);

    return EXIT_SUCCESS;

}

//check to make sure grade is avlide grade
int check_grade(int grade){

    //Error check for grades outside of range
    if (grade>100||grade<0)
        //grade is outside of valid range
        return EXIT_FAILURE;
    
    return EXIT_SUCCESS;
     
}

//Checks to make sure name is a valid string
int check_name(char name[]) {

    //Make sure that there are only alphabetic characters in the name
    while(*name)
    {
        if((*name<97||*name>122)&&(*name<65||*name>90))
        {
            //non-alphabetic character found
            return EXIT_FAILURE;
        }
        name++;
    }
    
    return EXIT_SUCCESS;
    
}

//Capitalizes the first character of the name string if it is lower case
int capitalize(char name[]){

    //Check for a lower case letter in the first character
    if(name[0]>96&&name[0]<123)
        //lower case letter found
        name[0]=name[0]-32;
    
    return EXIT_SUCCESS;

}
//sorts the students array alphabetically by last name
int alpha_sort(struct student students[], int n) {

  int i, j;
  struct student temp;

  if(n<1)
  {
    return EXIT_FAILURE;
  }

  for(i=0; i<n-1; i++)
    for(j=i+1; j<n; j++)
      if((strcmp(students[i].last, students[j].last))>0)
      {
        temp=students[i];
        students[i]=students[j];
        students[j]=temp;
      }
  return EXIT_SUCCESS;
}

//Prints n number of spaces
int printspaces(int n) {

    int i;
    
    if(n>0)
        for(i=0;i<n;i++)
            printf(" ");
    else
        return EXIT_FAILURE;
        
    return EXIT_SUCCESS;

}

//Determines the maximum character length from all of the students
//in the form "Last, First"
int get_max_length(struct student students[],int n){

    int i,length=0,temp;
    
    for(i=0;i<n;i++){
        temp=strlen(students[i].first)+strlen(students[i].last)+2;
        if(temp>length)
            length=temp;
    }
    return length;
}

//Prints a formatted and aligned table containing the data
//in the students structured array
int printoutput(struct student students[],int max_length, int n) {

    int length_diff,length,i,sum=0;
    float avg;
    char lavg;
    
    //Sum the values in the array
    for (i=0;i<n;i++)
        sum+=students[i].ngrade;
        
    //Calculate and output the average
    avg =(int) (float)sum/(float)n;
    lavg = letterify((int)avg);
    
    //Print table
    //Print top line
    printf("/");
    for (i=0;i<max_length;i++)
        printf("-");
    printf("---------------------------\\\n");
    
    //Print header
    printf("| Name");
    printspaces(max_length-4);
    printf(" | Grades | Letter Grades |\n");
    
    //Print each student's data
    for(i=0;i<n;i++){
        printf("| %s, %s",students[i].last,students[i].first);
        length=strlen(students[i].first)+strlen(students[i].last)+2;
        length_diff=max_length-length;
        printspaces(length_diff);
        printf(" |  %3d   |       %c       |\n",students[i].ngrade,students[i].lgrade);
    }

    //Print the middle line
    printf("|");
    for (i=0;i<max_length;i++)
        printf("-");
    printf("---------------------------|\n");
    printf("|");
    //Print the aligned average data
    if(max_length%2==0)
        printspaces((max_length/2-1));
    else
        printspaces((max_length/2));
    printf("Avg");
    printspaces((max_length/2));
    if(avg<100)
        printf("| %3.3f |       %c       |\n",avg,lavg);
    else
        printf("| %3.2f |       %c       |\n",avg,lavg);

    //Print the bottom line
    printf("\\");
    for (i=0;i<max_length;i++)
        printf("-");
    printf("---------------------------/\n");
    
    return EXIT_SUCCESS;
    
}
